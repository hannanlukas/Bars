import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:barchart/Testing/transformation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vector_math/vector_math_64.dart';

class CursorOffsetNotifier extends Notifier<Offset?>{

  @override
  Offset? build() => null;

  void set({required Offset? value}){
    state = value;
  }

}

class BarChartGlobalCursor{

  // the local cursor offset relative to the barchart panel only.
  static final barChartCursorOffset =  NotifierProvider<CursorOffsetNotifier, Offset?>(() => CursorOffsetNotifier());

  // returns the bar index the cursor is currently hovering over.
  static final hoveringOverXIndex = Provider<int?>((ref) {

    final cursorOffset = ref.watch(BarChartGlobalCursor.barChartCursorOffset);
    if (cursorOffset == null){
      return null;
    }

    final transform = ref.watch(BarChartGlobalTransformation.transformation);
    final bars = ref.watch(BarChartGlobalBars.activeBars);
    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final scale = transform.getMaxScaleOnAxis();

    final transformedCursorX = cursorOffset.dx - transform.getTranslation().x;

    final barX = (config.barWidth + config.barXSpacing) * scale;
    final totalBarX = barX * bars.length;

    if (transformedCursorX < 0 || transformedCursorX > totalBarX || barX <= 0.0){
      return null;
    }

    if (transformedCursorX % ((config.barWidth + config.barXSpacing) * scale) > config.barWidth * scale){
      return null;
    }

    final index = (transformedCursorX / barX).floor();
    return index;

  });

  // returns the y value that's being hovered over.
  static final hoveringOverYValue = Provider<double?>((ref) {

    final cursorOffset = ref.watch(BarChartGlobalCursor.barChartCursorOffset);
    if (cursorOffset == null){
      return null;
    }

    final maxY = ref.watch(BarChartGlobalBars.maxYValue);
    final transform = ref.watch(BarChartGlobalTransformation.transformation);
    final yDistance = ref.watch(BarChartGlobalBars.yDistance);
    final constraints = ref.watch(BarChartGlobalConstraints.constraints);
    final scale = transform.getMaxScaleOnAxis();
    if (scale < 0.0){
      return null;
    }
    final unit = constraints.barChartSize.height / (yDistance / scale);
    if (unit < 0.0){
      return null;
    }

    final transformedMouseOffset = cursorOffset.dy - transform.getTranslation().y;

    final yVal = maxY - (transformedMouseOffset / unit);
    return yVal;

  });

}