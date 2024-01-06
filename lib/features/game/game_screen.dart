import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silhouette_game/features/digital_ink_recognizer/digital_ink_recognizer.dart';
import 'package:silhouette_game/features/game/quiz/quiz.dart';
import 'package:silhouette_game/features/game/written_characters.dart';
import 'package:silhouette_game/features/handwritten_cell/handwritten_cell.dart';

final _initializedProvider = FutureProvider((ref) {
  return Future.wait([
    ref.read(digitalInkRecognizerProvider.future),
    ref.read(quizProvider.future),
  ]);
});

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
            child: const _HandwrittenCell(),
          ),
        ],
      ),
    );
  }
}

final _maskedQuizImageProvider = StateProvider((ref) => true);

class _QuizImage extends HookConsumerWidget {
  const _QuizImage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masked = ref.watch(_maskedQuizImageProvider);
    final quizImage =
        ref.watch(quizProvider.select((v) => v.requireValue.currentWordImage));
    final imageWidget = Image.asset(quizImage);
    if (masked) {
      return ColorFiltered(
        colorFilter: const ColorFilter.mode(
          Colors.black,
          BlendMode.srcATop,
        ),
        child: imageWidget,
      );
    }
    return imageWidget;
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

class _HandwrittenCell extends HookConsumerWidget {
  const _HandwrittenCell();

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
        debounce.value = Timer(const Duration(milliseconds: 700), () async {
          final quiz = ref.read(quizProvider).requireValue;

          // 書いた文字が正しいかチェック
          final isCorrect = await ref.read(recognizeProvider)(
            character,
            quiz.currentCharacter,
          );
          if (isCorrect) return;

          // 正しければ次の文字入力に移動
          final quizNotifier = ref.read(quizProvider.notifier);
          if (quizNotifier.nextCharacter()) {
            ref.read(writtenCharactersProvider.notifier).next();
            writingCellController.reset();
            return;
          }

          // すべての文字を入力したら正解演出を出して次の問題に進む
          ref.read(_maskedQuizImageProvider.notifier).state = false;
          if (!context.mounted) return;
          await showModalBottomSheet(
            context: context,
            barrierColor: Colors.transparent,
            backgroundColor: theme.primaryColorLight,
            builder: (context) => _CorrectSheet(quiz.currentWord),
          );
          if (quizNotifier.nextWord()) {
            ref.read(_maskedQuizImageProvider.notifier).state = true;
            ref.invalidate(writtenCharactersProvider);
            writingCellController.reset();
            return;
          }

          // 最後の問題なら全問正解演出
          if (!context.mounted) return;
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
        });
      });
      return debounce.value?.cancel;
    }, const []);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        HandwrittenCell(
          controller: writingCellController,
        ),
        Positioned(
          bottom: -16,
          right: -16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: IconButton(
              iconSize: 32,
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              onPressed: () {
                writingCellController.reset();
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        ),
      ],
    );
  }
}

class _CorrectSheet extends HookConsumerWidget {
  const _CorrectSheet(this.word);

  final String word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(16),
          Text("★せいかい★", style: theme.textTheme.headlineSmall),
          const Gap(16),
          Text(word, style: theme.textTheme.headlineLarge),
          const Gap(16),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: FilledButton.styleFrom(
              textStyle: theme.textTheme.titleLarge,
            ),
            child: const Text("つぎへ"),
          ),
          const Gap(16),
        ],
      ),
    );
  }
}
