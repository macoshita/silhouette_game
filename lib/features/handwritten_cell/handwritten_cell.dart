import 'dart:ui';

import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:silhouette_game/features/handwritten_cell/time_series_offset.dart';

class HandwrittenCellController extends ValueNotifier<Character> {
  HandwrittenCellController() : super([]);

  void _addStroke(TimeSeriesOffset offset) {
    value = [
      ...value,
      [offset]
    ];
  }

  void _addPoint(TimeSeriesOffset offset) {
    value = [
      ...value.sublist(0, value.length - 1),
      [...value.last, offset]
    ];
  }

  void reset() {
    value = [];
  }
}

TimeSeriesOffset _getOffset(PointerEvent details, double width) {
  final offset = details.localPosition.normalize(width);
  return TimeSeriesOffset.fromOffset(offset);
}

class HandwrittenCell extends HookWidget {
  const HandwrittenCell({
    super.key,
    required this.controller,
  });

  final HandwrittenCellController controller;

  @override
  Widget build(BuildContext context) {
    final character = useValueListenable(controller);
    final throttleTime = useRef(0);

    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Listener(
          onPointerDown: (details) {
            throttleTime.value = clock.now().millisecondsSinceEpoch;
            controller._addStroke(_getOffset(details, width));
          },
          onPointerMove: (details) {
            final now = clock.now().millisecondsSinceEpoch;
            if (now - throttleTime.value > 16) {
              throttleTime.value = now;
              controller._addPoint(_getOffset(details, width));
            }
          },
          onPointerUp: (details) {
            controller._addPoint(_getOffset(details, width));
          },
          child: Cell(
            strokes: character,
            showGuides: true,
          ),
        );
      }),
    );
  }
}

class Cell extends HookConsumerWidget {
  final List<Stroke> strokes;
  final bool showGuides;
  final Color cellColor;

  const Cell({
    super.key,
    required this.strokes,
    this.showGuides = false,
    this.cellColor = Colors.black,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: _Painter(
          strokes: strokes,
          devicePixelRatio: devicePixelRatio,
          showGuides: showGuides,
          cellColor: cellColor,
        ),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  final List<Stroke> strokes;
  final double pixelSize;
  final bool showGuides;
  final Color cellColor;

  _Painter({
    required this.strokes,
    required double devicePixelRatio,
    required this.showGuides,
    required this.cellColor,
  }) : pixelSize = 1 / devicePixelRatio;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()
          ..color = cellColor
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke);

    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    if (showGuides) {
      canvas.drawLine(
          Offset(size.width / 2, 0),
          Offset(size.width / 2, size.height),
          Paint()
            ..color = Colors.grey
            ..strokeWidth = 1);
      canvas.drawLine(
          Offset(0, size.height / 2),
          Offset(size.width, size.height / 2),
          Paint()
            ..color = Colors.grey
            ..strokeWidth = 1);
    }

    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3;
    for (final stroke in strokes) {
      canvas.drawPoints(
        PointMode.polygon,
        stroke.map((e) => e.toOffset().denormalize(size.width)).toList(),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) {
    return !const DeepCollectionEquality()
            .equals(strokes, oldDelegate.strokes) ||
        showGuides != oldDelegate.showGuides ||
        cellColor != oldDelegate.cellColor ||
        pixelSize != oldDelegate.pixelSize;
  }
}

const _normalizedSize = 1000.0;

extension _OffsetX on Offset {
  Offset normalize(double size) {
    final s = _normalizedSize / size;
    return scale(s, s);
  }

  Offset denormalize(double size) {
    final s = size / _normalizedSize;
    return scale(s, s);
  }
}
