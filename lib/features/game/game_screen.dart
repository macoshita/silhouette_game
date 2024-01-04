import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hiragana_game/features/digital_ink_recognizer/digital_ink_recognizer.dart';
import 'package:hiragana_game/features/game/handwritten_cell.dart';
import 'package:hiragana_game/features/game/quiz/quiz.dart';
import 'package:hiragana_game/features/game/written_characters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_screen.g.dart';

@riverpod
Future<void> _initialized(_InitializedRef ref) async {
  await Future.wait([
    ref.read(digitalInkRecognizerProvider.future),
    ref.read(quizProvider.future),
  ]);
}

class GameScreen extends HookConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialized = ref.watch(_initializedProvider);

    return Scaffold(
      body: switch (initialized) {
        AsyncData() => const _Game(),
        AsyncError(:final error) => Center(child: Text("$error")),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _Game extends HookConsumerWidget {
  const _Game();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final debounce = useRef<Timer?>(null);
    final writingCellController = useMemoized(
      () => HandwrittenCellController(),
      const [],
    );

    useEffect(() {
      writingCellController.addListener(() {
        final character = writingCellController.value;
        ref.read(writtenCharactersProvider.notifier).write(character);
        debounce.value?.cancel();
        debounce.value = Timer(const Duration(seconds: 1), () async {
          final quiz = ref.read(quizProvider).requireValue;

          final isCorrect = await ref.read(recognizeProvider)(
            character,
            quiz.currentCharacter,
          );
          if (!context.mounted) return;
          if (isCorrect) {
            final quizNotifier = ref.read(quizProvider.notifier);
            if (quizNotifier.nextCharacter()) {
              ref.read(writtenCharactersProvider.notifier).next();
              writingCellController.reset();
              return;
            }
            await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("正解！"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("次へ"),
                    ),
                  ],
                );
              },
            );
            if (!context.mounted) return;
            if (quizNotifier.nextWord()) {
              ref.invalidate(writtenCharactersProvider);
              writingCellController.reset();
              return;
            }
            await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("全問正解！"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("タイトルへ"),
                    ),
                  ],
                );
              },
            );
          }
        });
      });
      return;
    }, const []);

    return SafeArea(
      child: Column(
        children: [
          const Gap(16),
          Text("だ〜れだ？", style: theme.textTheme.headlineLarge),
          const Gap(8),
          const SizedBox(
            height: 300,
            child: _QuizImage(),
          ),
          const Gap(8),
          const _WrittenCharacters(),
          const Gap(16),
          ConstrainedBox(
            constraints: BoxConstraints.loose(const Size.square(300)),
            child: HandwrittenCell(
              controller: writingCellController,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuizImage extends HookConsumerWidget {
  const _QuizImage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizImage =
        ref.watch(quizProvider.select((v) => v.requireValue.currentWordImage));
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(
        Colors.black,
        BlendMode.srcATop,
      ),
      child: Image.asset(quizImage),
    );
  }
}

class _WrittenCharacters extends HookConsumerWidget {
  const _WrittenCharacters();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (
      currentWord,
      currentCharacterIndex,
    ) = ref.watch(quizProvider.select((v) => (
          v.requireValue.currentWord,
          v.requireValue.currentCharacterIndex,
        )));
    final writtenCharacters = ref.watch(writtenCharactersProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < currentWord.length; i++) ...[
          if (i > 0) const Gap(8),
          SizedBox(
            height: 40,
            child: Cell(
              strokes: i < writtenCharacters.length ? writtenCharacters[i] : [],
              cellColor: currentCharacterIndex == i ? Colors.red : Colors.black,
            ),
          ),
        ]
      ],
    );
  }
}
