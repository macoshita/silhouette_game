import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart'
    as r;
import 'package:silhouette_game/features/game/time_series_offset.dart'
    show Character;
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
  return r.DigitalInkRecognizer(languageCode: 'JA');
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

    // 最初の 2 候補までを正解とする
    return result.take(2).any((e) =>
        e.text == expected ||
        (expected == 'ー' && ['一', '-', 'ー', '_'].contains(e.text)));
  };
}
