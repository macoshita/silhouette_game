import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:silhouette_game/features/game/game_screen.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "しるえっとくいず",
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineLarge,
            ),
            const Gap(16),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const GameScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: theme.textTheme.titleLarge,
                ),
                child: const Text('はじめる')),
          ],
        ),
      ),
    );
  }
}
