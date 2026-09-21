import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
//import 'package:barchart/bars.dart';
import 'package:barchart/Testing/bars.dart';

// This file is used to store the main config state and watch it globally, and will
// notify any listeners when the config changes.

// Used to notify the widget when the bar chart config changes
class BarChartConfigNotifier extends Notifier<BarChartConfig>{

  BarChartConfigNotifier({
    required this.initialConfig,
  });
  final BarChartConfig initialConfig;

  @override
  BarChartConfig build() => initialConfig;

  void set({required BarChartConfig newConfig}){
    state = newConfig;
  }
}

// The raw bar chart config
class BarChartConfig{

  final bool showTitle;
  final bool showXGrid;
  final bool showYGrid;
  final bool showYValues;
  final bool showXValues;
  final bool showXLabel;
  final bool showYLabel;
  final bool showZeroLine;
  final bool showLabelsInBottomPanel;
  final bool rotateXLabels;
  final bool showResizerLines;
  final bool cursorTrackerEnabled;
  final bool enableBarOverlays;
  final bool staticYGrid;

  final String barChartTitle;
  final String xValueLabelForValues;
  final String xValueLabelForNames;
  final String yValueLabel;
  final String barChartInformation;
  final String xName;
  final String yName;

  final double barWidth;
  final double barXSpacing;
  final int leftPanelValueCount;
  final int yValueFloatingPointDigits;

  final double xGridOpacity;
  final double yGridOpacity;

  // need to add these to the settings menu
  final Color topPanelBackgroundColor;
  final Color leftPanelBackgroundColor;
  final Color barChartBackgroundColor;
  final Color bottomPanelBackgroundColor;

  final double titleFontSize;
  final Color titleFontColor;
  final double xLabelFontSize;
  final Color xLabelFontColor;
  final double yLabelFontSize;
  final Color yLabelFontColor;
  final double xValuesFontSize;
  final Color xValuesFontColor;
  final double yValuesFontSize;
  final Color yValuesFontColor;

  final List<Bar> bars;

  const BarChartConfig({
    required this.showTitle,
    required this.showXGrid,
    required this.showYGrid,
    required this.showYValues,
    required this.showXValues,
    required this.showXLabel,
    required this.showYLabel,
    required this.showZeroLine,
    required this.barChartTitle,
    required this.xValueLabelForValues,
    required this.xValueLabelForNames,
    required this.yValueLabel,
    required this.barChartInformation,
    required this.bars,
    required this.xName,
    required this.yName,
    required this.barWidth,
    required this.leftPanelValueCount,
    required this.yValueFloatingPointDigits,
    required this.showLabelsInBottomPanel,
    required this.barXSpacing,
    required this.showResizerLines,
    required this.rotateXLabels,
    required this.cursorTrackerEnabled,
    required this.enableBarOverlays,
    required this.staticYGrid,
    required this.topPanelBackgroundColor,
    required this.leftPanelBackgroundColor,
    required this.barChartBackgroundColor,
    required this.bottomPanelBackgroundColor,
    required this.titleFontColor,
    required this.titleFontSize,
    required this.xLabelFontColor,
    required this.xLabelFontSize,
    required this.xValuesFontColor,
    required this.xValuesFontSize,
    required this.yLabelFontColor,
    required this.yLabelFontSize,
    required this.yValuesFontColor,
    required this.yValuesFontSize,
    required this.xGridOpacity,
    required this.yGridOpacity
  });

  BarChartConfig copyWith({
    bool? showTitle,
    bool? showXGrid,
    bool? showYGrid,
    bool? showYValues,
    bool? showXValues,
    bool? showXLabel,
    bool? showYLabel,
    bool? showZeroLine,
    String? barChartTitle,
    String? xValueLabelForValues,
    String? xValueLabelForNames,
    String? yValueLabel,
    String? barChartInformation,
    List<Bar>? bars,
    String? xName,
    String? yName,
    double? barWidth,
    int? leftPanelValueCount,
    int? yValueFloatingPointDigits,
    bool? showLabelsInBottomPanel,
    double? barXSpacing,
    bool? rotateXLabels,
    bool? showResizerLines,
    bool? cursorTrackerEnabled,
    bool? enableBarOverlays,
    bool? staticYGrid,
    Color? topPanelBackgroundColor,
    Color? leftPanelBackgroundColor,
    Color? barChartBackgroundColor,
    Color? bottomPanelBackgroundColor,
    double? titleFontSize,
    Color? titleFontColor,
    double? xLabelFontSize,
    Color? xLabelFontColor,
    double? yLabelFontSize,
    Color? yLabelFontColor,
    double? xValuesFontSize,
    Color? xValuesFontColor,
    double? yValuesFontSize,
    Color? yValuesFontColor,
    double? xGridOpacity,
    double? yGridOpacity
  }) {
    return BarChartConfig(
      showTitle: showTitle ?? this.showTitle,
      showXGrid: showXGrid ?? this.showXGrid,
      showYGrid: showYGrid ?? this.showYGrid,
      showYValues: showYValues ?? this.showYValues,
      showXValues: showXValues ?? this.showXValues,
      showXLabel: showXLabel ?? this.showXLabel,
      showYLabel: showYLabel ?? this.showYLabel,
      showZeroLine: showZeroLine ?? this.showZeroLine,
      barChartTitle: barChartTitle ?? this.barChartTitle,
      xValueLabelForNames: xValueLabelForNames ?? this.xValueLabelForNames,
      xValueLabelForValues: xValueLabelForValues ?? this.xValueLabelForValues,
      yValueLabel: yValueLabel ?? this.yValueLabel,
      barChartInformation: barChartInformation ?? this.barChartInformation,
      bars: bars ?? this.bars,
      xName: xName ?? this.xName,
      yName: yName ?? this.yName,
      barWidth: barWidth ?? this.barWidth,
      leftPanelValueCount: leftPanelValueCount ?? this.leftPanelValueCount,
      yValueFloatingPointDigits: yValueFloatingPointDigits ?? this.yValueFloatingPointDigits,
      barXSpacing: barXSpacing ?? this.barXSpacing,
      showLabelsInBottomPanel: showLabelsInBottomPanel ?? this.showLabelsInBottomPanel,
      rotateXLabels: rotateXLabels ?? this.rotateXLabels,
      showResizerLines: showResizerLines ?? this.showResizerLines,
      cursorTrackerEnabled: cursorTrackerEnabled ?? this.cursorTrackerEnabled,
      enableBarOverlays: enableBarOverlays ?? this.enableBarOverlays,
      staticYGrid: staticYGrid ?? this.staticYGrid,
      barChartBackgroundColor: barChartBackgroundColor ?? this.barChartBackgroundColor,
      bottomPanelBackgroundColor: bottomPanelBackgroundColor ?? this.bottomPanelBackgroundColor,
      leftPanelBackgroundColor: leftPanelBackgroundColor ?? this.leftPanelBackgroundColor,
      topPanelBackgroundColor: topPanelBackgroundColor ?? this.topPanelBackgroundColor,
      titleFontColor: titleFontColor ?? this.titleFontColor,
      titleFontSize: titleFontSize ?? this.titleFontSize,
      xLabelFontColor: xLabelFontColor ?? this.xLabelFontColor,
      xLabelFontSize: xLabelFontSize ?? this.xLabelFontSize,
      xValuesFontColor: xValuesFontColor ?? this.xValuesFontColor,
      xValuesFontSize: xValuesFontSize ?? this.xValuesFontSize,
      yLabelFontColor: yLabelFontColor ?? this.yLabelFontColor,
      yLabelFontSize: yLabelFontSize ?? this.yLabelFontSize,
      yValuesFontColor: yValuesFontColor ?? this.yValuesFontColor,
      yValuesFontSize: yValuesFontSize ?? this.yValuesFontSize,
      xGridOpacity: xGridOpacity ?? this.xGridOpacity,
      yGridOpacity: yGridOpacity ?? this.yGridOpacity
    );
  }
}

// Used to globally access and watch the config file
class BarChartGlobalConfig{

  // checks if the notifier has been initialised
  static bool _initialised = false;
  static bool get isInitialised => _initialised;

  // initialises the config notifier
  static void initialiseConfigNotifier({required BarChartConfig config}){
    if (!_initialised){
      configNotifier = NotifierProvider<BarChartConfigNotifier, BarChartConfig>(() => BarChartConfigNotifier(initialConfig: config));
      _initialised = true;
    }

  }

  static late final NotifierProvider<BarChartConfigNotifier, BarChartConfig> configNotifier;
}
