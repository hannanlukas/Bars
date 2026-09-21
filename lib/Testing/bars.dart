import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

// This file contains the main bar class and bar notifier class which is responsible
// for storing the bar states, and watching them in the widgets. and viewing the active
// and inactive bars.

class Bar{

  Bar({
    required this.xValue,
    required this.yValue,
    required this.color,
    required this.xLabel,
    required this.insertionIndex,
    required this.visible,
    required this.circularRadius,
    required this.outlined,
    required this.outlineWidth
  });

  final double xValue;
  final double yValue;
  final Color color;
  final String xLabel;
  final int insertionIndex;
  final bool visible;
  final double circularRadius;
  final bool outlined;
  final double outlineWidth;

  Bar copyWith({
    double? xValue,
    double? yValue,
    Color? color,
    String? xLabel,
    int? insertionIndex,
    bool? visible,
    double? circularRadius,
    bool? outlined,
    double? outlineWidth
  }) {
    return Bar(
      xValue: xValue ?? this.xValue,
      yValue: yValue ?? this.yValue,
      color: color ?? this.color,
      xLabel: xLabel ?? this.xLabel,
      insertionIndex: insertionIndex ?? this.insertionIndex,
      visible: visible ?? this.visible,
      circularRadius: circularRadius ?? this.circularRadius,
      outlined: outlined ?? this.outlined,
      outlineWidth: outlineWidth ?? this.outlineWidth
    );
  }

}

enum BarsSortOrder{
  insertionIndex,
  smallestToGreatestX,
  greatestToSmallestX,
  smallestToGreatestY,
  greatestToSmallestY,
  custom
}

class BarChartBarsNotifier extends Notifier<List<Bar>>{

  BarChartBarsNotifier({required List<Bar> bars})
      : _bars = bars.toList();

  final List<Bar> _bars;

  @override
  List<Bar> build() => _bars;

  void setVisibility({required int barIndex, required bool value}){

    if (barIndex < 0 || barIndex >= state.length){
      return;
    }

    state = state.toList()..[barIndex] = state[barIndex].copyWith(visible: value);

  }
  void setColor({required int barIndex, required Color value}){
    if (barIndex < 0 || barIndex >= state.length){
      return;
    }

    state = state.toList()..[barIndex] = state[barIndex].copyWith(color: value);
  }
  void setCircularRadius({required int barIndex, required double value}){
    if (barIndex < 0 || barIndex >= state.length){
      return;
    }

    state = state.toList()..[barIndex] = state[barIndex].copyWith(circularRadius: value);
  }
  void setOutlined({required int barIndex, required bool value}){
    if (barIndex < 0 || barIndex >= state.length){
      return;
    }

    state = state.toList()..[barIndex] = state[barIndex].copyWith(outlined: value);
  }
  void setOutlineWidth({required int barIndex, required double value}){
    if (barIndex < 0 || barIndex >= state.length){
      return;
    }

    state = state.toList()..[barIndex] = state[barIndex].copyWith(outlineWidth: value);
  }

  void sortByInsertionIndex(){
    final bars = state.toList()..sort((a, b){
      if (a.insertionIndex < b.insertionIndex) return -1;
      if (a.insertionIndex > b.insertionIndex) return 1;
      return 0;
    });
    state = bars;
  }
  void sortSmallestToGreatestX(){
    final bars = state.toList()..sort((a, b){
      if (a.xValue < b.xValue) return -1;
      if (a.xValue > b.xValue) return 1;
      return 0;
    });
    state = bars;
  }
  void sortGreatestToSmallestX(){
    final bars = state.toList()..sort((a, b){
      if (a.xValue > b.xValue) return -1;
      if (a.xValue < b.xValue) return 1;
      return 0;
    });
    state = bars;
  }
  void sortSmallestToGreatestY(){
    final bars = state.toList()..sort((a, b){
      if (a.yValue < b.yValue) return -1;
      if (a.yValue > b.yValue) return 1;
      return 0;
    });
    state = bars;
  }
  void sortGreatestToSmallestY(){
    final bars = state.toList()..sort((a, b){
      if (a.yValue > b.yValue) return -1;
      if (a.yValue < b.yValue) return 1;
      return 0;
    });
    state = bars;
  }
  void reorderBar({required int barIndex, required int newBarIndex}){
    if (barIndex < 0 || barIndex > state.length) return;
    if (newBarIndex < 0 || newBarIndex > state.length) return;

    final bars = state.toList();
    final bar = bars[barIndex];
    bars.removeAt(barIndex);
    bars.insert(newBarIndex, bar);

    state = bars;
  }
}

class BarChartSortOrderNotifier extends Notifier<BarsSortOrder>{

  @override
  BarsSortOrder build() => BarsSortOrder.insertionIndex;

  void set({required BarsSortOrder order}){
    state = order;
  }

}

class BarChartGlobalBars{

  static bool _initialised = false;
  static bool get isInitialised => _initialised;

  static void initialise({required List<Bar> bars}){
    if (!_initialised){
      BarChartGlobalBars.bars = NotifierProvider<BarChartBarsNotifier, List<Bar>>(() => BarChartBarsNotifier(bars: bars));
      BarChartGlobalBars.sortOrder = NotifierProvider<BarChartSortOrderNotifier, BarsSortOrder>(() => BarChartSortOrderNotifier());
      BarChartGlobalBars.activeBars = Provider<List<Bar>>((ref) {
        final bars = ref.watch(BarChartGlobalBars.bars);
        return [for (final b in bars) if (b.visible) b];
      });
      BarChartGlobalBars.inactiveBars = Provider<List<Bar>>((ref) {
        final bars = ref.watch(BarChartGlobalBars.bars);
        return [for (final b in bars) if (!b.visible) b];
      });
      BarChartGlobalBars.barMinY = Provider<double>((ref) {
        final activeBars = ref.watch(BarChartGlobalBars.activeBars);
        double y = double.maxFinite;
        for (final b in activeBars){
          if (b.yValue < y){
            y = b.yValue;
          }
        }
        return y;

      });
      BarChartGlobalBars.barMaxY = Provider<double>((ref) {

        final activeBars = ref.watch(BarChartGlobalBars.activeBars);
        double y = -double.maxFinite;
        for (final b in activeBars){
          if (b.yValue > y){
            y = b.yValue;
          }
        }
        return y;

      });

      BarChartGlobalBars.maxYValue = Provider<double>((ref) {

        final barMaxY = ref.watch(BarChartGlobalBars.barMaxY);

        if (barMaxY < 0){
          return 0.0;
        }
        return barMaxY;

      });
      BarChartGlobalBars.minYValue = Provider<double>((ref) {

        final barMinY = ref.watch(BarChartGlobalBars.barMinY);

        if (barMinY >= 0){
          return 0.0;
        }
        return barMinY;

      });
      BarChartGlobalBars.yDistance = Provider<double>((ref) {

        final maxYValue = ref.watch(BarChartGlobalBars.maxYValue);
        final minYValue = ref.watch(BarChartGlobalBars.minYValue);

        return maxYValue - minYValue;

      });

      _initialised = true;
    }
  }

  static late NotifierProvider<BarChartBarsNotifier, List<Bar>> bars;
  static late NotifierProvider<BarChartSortOrderNotifier, BarsSortOrder> sortOrder;
  static late Provider<List<Bar>> activeBars;
  static late Provider<List<Bar>> inactiveBars;
  static late Provider<double> barMinY;
  static late Provider<double> barMaxY;

  // so while the barMinY & barMaxY account for the actual bars min and max,
  // these are for determining the relative positions.
  static late Provider<double> minYValue;
  static late Provider<double> maxYValue;
  static late Provider<double> yDistance;
}



