import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silhouette_game/features/quiz/quiz.dart';

class FinishScreen extends HookConsumerWidget {
  const FinishScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final quizData =
        ref.watch(quizProvider.select((value) => value.requireValue.quizData));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("★がんばったね★", style: theme.textTheme.headlineLarge),
            const Gap(16),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                for (final quiz in quizData)
                  SizedBox(
                    width: 120,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(quiz.asset),
                    ),
                  ),
              ],
            ),
            const Gap(16),
            FilledButton(
              onPressed: () {
                context.go('/');
              },
              style: FilledButton.styleFrom(
                textStyle: theme.textTheme.titleLarge,
              ),
              child: const Text("おわり"),
            ),
          ],
        ),
      ),
    );
  }
}
