import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silhouette_game/features/quiz/quiz.dart';

final showHintProvider = StateProvider.autoDispose((ref) => false);

class Hint extends HookConsumerWidget {
  final double fontSize;

  const Hint(this.fontSize, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hint =
        ref.watch(quizProvider.select((v) => v.requireValue.currentCharacter));
    return Text(
      hint,
      style: TextStyle(
        fontSize: fontSize,
        height: 1,
        color: Colors.black12,
      ),
    );
  }
}

class HintIcon extends HookConsumerWidget {
  const HintIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
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
          ref.read(showHintProvider.notifier).state = true;
        },
        icon: const Icon(
          Icons.lightbulb,
        ),
      ),
    );
  }
}
