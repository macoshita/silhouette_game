import 'package:flutter/material.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart'
    as r;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:silhouette_game/features/game_mode/game_mode.dart';
import 'package:silhouette_game/features/handwritten_cell/time_series_offset.dart'
    show Character;

part 'digital_ink_recognizer.g.dart';

@Riverpod(keepAlive: true)
Future<r.DigitalInkRecognizer> digitalInkRecognizer(
    DigitalInkRecognizerRef ref) async {
  final modelManager = r.DigitalInkRecognizerModelManager();
  const languageModel = "JA";
  final bool downloaded = await modelManager.isModelDownloaded(languageModel);
  if (!downloaded) {
    await modelManager.downloadModel(languageModel);
  }
  return r.DigitalInkRecognizer(languageCode: languageModel);
}

typedef RecognizeFunction = Future<bool> Function(Character, String);

@riverpod
RecognizeFunction recognize(RecognizeRef ref) {
  return (Character character, String expected) async {
    if (character.isEmpty) {
      return false;
    }

    final ink = r.Ink()
      ..strokes = [
        for (final stroke in character)
          r.Stroke()
            ..points = [
              for (final offset in stroke)
                r.StrokePoint(
                  x: offset.dx,
                  y: offset.dy,
                  t: offset.time,
                )
            ]
      ];

    final recognizer = await ref.read(digitalInkRecognizerProvider.future);
    final result = await recognizer.recognize(ink);
    print(result.map((e) => e.text).toList());

    final gameMode = ref.read(gameModeProvider);
    final filtered = result.where(
      (e) {
        // 2 文字以上は無視
        if (e.text.characters.length != 1) return false;

        // ハイフンは特定のものだけ残す
        if (e.text == 'ー') return true;

        // ゲームモードに応じてひらがな・カタカナのみ残す
        return switch (gameMode) {
          GameMode.hiragana => _isHiragana(e.text),
          GameMode.katakana => _isKatakana(e.text),
        };
      },
    );
    print(filtered.map((e) => e.text).toList());

    return filtered.take(2).any((e) => e.text == expected);
  };
}

bool _isHiragana(String text) {
  return text.codeUnitAt(0) >= 0x3040 && text.codeUnitAt(0) <= 0x309F;
}

bool _isKatakana(String text) {
  return text.codeUnitAt(0) >= 0x30A1 && text.codeUnitAt(0) <= 0x30FC;
}
