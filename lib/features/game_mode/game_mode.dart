import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum GameMode {
  hiragana("ひらがな"),
  katakana("カタカナ");

  final String label;

  const GameMode(this.label);
}

final gameModeProvider = StateProvider((ref) => GameMode.hiragana);

class GameModeSwitch extends HookConsumerWidget {
  const GameModeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameMode = ref.watch(gameModeProvider);
    return SegmentedButton(
      segments: [
        for (final gameMode in GameMode.values)
          ButtonSegment(
            value: gameMode,
            label: Text(gameMode.label),
          ),
      ],
      selected: {gameMode},
      onSelectionChanged: (selection) {
        ref.read(gameModeProvider.notifier).state = selection.first;
      },
    );
  }
}
