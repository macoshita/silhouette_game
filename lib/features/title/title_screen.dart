import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silhouette_game/features/game_mode/game_mode.dart';

class TitleScreen extends HookConsumerWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final gameMode = ref.watch(gameModeProvider);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  switch (gameMode) {
                    GameMode.hiragana => "しるえっとくいず",
                    GameMode.katakana => "シルエットクイズ",
                  },
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineLarge,
                ),
                const Gap(16),
                FilledButton(
                  onPressed: () {
                    context.go('/game');
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: theme.textTheme.titleLarge,
                  ),
                  child: const Text('はじめる'),
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: GameModeSwitch(),
            ),
          ),
        ],
      ),
    );
  }
}
