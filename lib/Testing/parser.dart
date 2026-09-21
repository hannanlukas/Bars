import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:barchart/Testing/config.dart';
import 'package:flutter/material.dart';
import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/constraints.dart';

// This file is used to parse the initial string or config file path into usable arguments,
// and can be used to indicate when an error has occurred with the parser or warnings have
// occurred when attempting to parse a specific section.
// The ParserState must be checked if it's a ParserError, ParserSuccessWithWarnings, or ParserSuccess
// in order to extract the necessary arguments.


// used to convert the type to another type of null when the specified type doesn't match
class AsTypeOrNull<T>{

  AsTypeOrNull(this.object);
  dynamic object;

  T? value(){
    if (object is T){
      return object as T;
    }
    return null;
  }

}
class AsTypeOrOther<T>{

  AsTypeOrOther(this.object, this.other, this.onNotType);

  dynamic object;
  T other;
  void Function() onNotType;

  T value(){
    if (object is T){
      return object as T;
    }
    onNotType();
    return other;
  }

}

// used for syntax sugar when parsing the json configs.
class TypeParser{

  const TypeParser({
    required this.map,
    required this.warnings,
  });

  final Map<String, dynamic> map;
  final List<String> warnings;

  T typeOrOther<T>(String objectName, T other){

    final object = map[objectName];
    if (object is! T){
      warnings.add("Error formatting $objectName");
      return other;
    }
    return object;

  }

  Color colorOrOther(String objectName, Color alternative){

    final object = map[objectName];
    if (object is! Map<String, dynamic>){
      warnings.add("Error formatting $objectName");
      return alternative;
    }

    final r = object["r"];
    final g = object["g"];
    final b = object["b"];
    final a = object["a"];

    if (r is! int || g is! int || b is! int || a is! int){
      warnings.add("Error formatting $objectName's individual color fields");
      return alternative;
    }

    return Color.fromARGB(a, r, g, b);

  }

}

// The parser state must be checked to determine if it's a ParserError, ParserSuccessWithWarnings, or ParserSuccess
class ParserState{
  const ParserState();
}
class ParserError extends ParserState{

  const ParserError._internal({
    required this.errorMessage,
  });

  final String errorMessage;
}
class ParserSuccess extends ParserState{

  final bool showTitle;
  final bool showXGrid;
  final bool showYGrid;
  final bool showYValues;
  final bool showXValues;
  final bool showXLabel;
  final bool showYLabel;
  final bool showZeroLine;
  final String xName;
  final String yName;
  final bool showLabelsInBottomPanel;
  final bool rotateXLabels;
  final bool showResizerLines;
  final bool enableCursorTracker;
  final bool enableBarOverlays;
  final bool staticYGrid;

  final String barChartTitle;
  final String xValueLabelForValues;
  final String xValueLabelForNames;
  final String yValueLabel;
  final String barChartInformation;

  final double barWidth;
  final int leftPanelValueCount;
  final int yValueFloatingPointDigits;

  final int leftPanelFlexX;
  final int rightPanelFlexX;
  final int topPanelFlexY;
  final int barChartFlexY;
  final int bottomPanelFlexY;
  final double resizerWidth;
  final double barXSpacing;

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

  final double xGridOpacity;
  final double yGridOpacity;

  final List<Bar> bars;

  const ParserSuccess._internal({
    required this.showTitle,
    required this.showXGrid,
    required this.showYGrid,
    required this.showYValues,
    required this.showXValues,
    required this.showXLabel,
    required this.showYLabel,
    required this.showZeroLine,
    required this.xName,
    required this.yName,
    required this.barChartTitle,
    required this.xValueLabelForValues,
    required this.xValueLabelForNames,
    required this.yValueLabel,
    required this.barChartInformation,
    required this.barWidth,
    required this.leftPanelValueCount,
    required this.bars,
    required this.showLabelsInBottomPanel,
    required this.leftPanelFlexX,
    required this.rightPanelFlexX,
    required this.topPanelFlexY,
    required this.barChartFlexY,
    required this.bottomPanelFlexY,
    required this.resizerWidth,
    required this.barXSpacing,
    required this.yValueFloatingPointDigits,
    required this.rotateXLabels,
    required this.showResizerLines,
    required this.enableCursorTracker,
    required this.enableBarOverlays,
    required this.staticYGrid,
    required this.topPanelBackgroundColor,
    required this.barChartBackgroundColor,
    required this.bottomPanelBackgroundColor,
    required this.leftPanelBackgroundColor,
    required this.titleFontSize,
    required this.titleFontColor,
    required this.xLabelFontSize,
    required this.xLabelFontColor,
    required this.yLabelFontSize,
    required this.yLabelFontColor,
    required this.xValuesFontSize,
    required this.xValuesFontColor,
    required this.yValuesFontSize,
    required this.yValuesFontColor,
    required this.xGridOpacity,
    required this.yGridOpacity
  });

  BarChartConfig toBarChartConfig(){
    return BarChartConfig(
        showTitle: showTitle,
        showXGrid: showXGrid,
        showYGrid: showYGrid,
        showYValues: showYValues,
        showXValues: showXValues,
        showXLabel: showXLabel,
        showYLabel: showYLabel,
        showZeroLine: showZeroLine,
        barChartTitle: barChartTitle,
        xValueLabelForValues: xValueLabelForValues,
        xValueLabelForNames: xValueLabelForNames,
        yValueLabel: yValueLabel,
        barChartInformation: barChartInformation,
        bars: bars,
        xName: xName,
        yName: yName,
        barWidth: barWidth,
        leftPanelValueCount: leftPanelValueCount,
        yValueFloatingPointDigits: yValueFloatingPointDigits,
        showLabelsInBottomPanel: showLabelsInBottomPanel,
        barXSpacing: barXSpacing,
        showResizerLines: showResizerLines,
        rotateXLabels: rotateXLabels,
        cursorTrackerEnabled: enableCursorTracker,
        enableBarOverlays: enableBarOverlays,
        staticYGrid: staticYGrid,
        topPanelBackgroundColor: topPanelBackgroundColor,
        leftPanelBackgroundColor: leftPanelBackgroundColor,
        bottomPanelBackgroundColor: bottomPanelBackgroundColor,
        barChartBackgroundColor: barChartBackgroundColor,
        yValuesFontSize: yValuesFontSize,
        yValuesFontColor: yValuesFontColor,
        yLabelFontSize: yLabelFontSize,
        yLabelFontColor: yLabelFontColor,
        xValuesFontSize: xValuesFontSize,
        xValuesFontColor: xValuesFontColor,
        xLabelFontSize: xLabelFontSize,
        xLabelFontColor: xLabelFontColor,
        titleFontSize: titleFontSize,
        titleFontColor: titleFontColor,
        xGridOpacity: xGridOpacity,
        yGridOpacity: yGridOpacity
    );
  }
  BarChartConstraints toBarChartConstraints(){

    final x = (leftPanelFlexX + rightPanelFlexX);
    final y = (topPanelFlexY + barChartFlexY + bottomPanelFlexY);

    final leftPanelXUnit = (x > 0) ? (leftPanelFlexX / x) : 0.1;
    final rightPanelXUnit = (x > 0) ? (rightPanelFlexX / x) : 0.9;
    final topPanelYUnit = (y > 0) ? (topPanelFlexY / y) : 0.1;
    final barChartYUnit = (y > 0) ? (barChartFlexY / y) : 0.8;
    final bottomPanelYUnit = (y > 0) ? (bottomPanelFlexY / y) : 0.1;

    final leftPanelUnitSize = Size(leftPanelXUnit, 1.0);
    final topPanelUnitSize = Size(rightPanelXUnit, topPanelYUnit);
    final barChartUnitSize = Size(rightPanelXUnit, barChartYUnit);
    final bottomPanelUnitSize = Size(rightPanelXUnit, bottomPanelYUnit);


    final constraints = BarChartConstraints.fromUnitSize(
        windowWidth: 0,
        windowHeight: 0,
        leftPanelUnitSize: leftPanelUnitSize,
        topPanelUnitSize: topPanelUnitSize,
        barChartUnitSize: barChartUnitSize,
        bottomPanelUnitSize: bottomPanelUnitSize,
        resizerWidth: resizerWidth,
    );

    return constraints;

  }

}
class ParserSuccessWithWarnings extends ParserSuccess{
  final List<String> warnings;

  const ParserSuccessWithWarnings._internal({
    required this.warnings,
    required super.showTitle,
    required super.showXGrid,
    required super.showYGrid,
    required super.showYValues,
    required super.showXValues,
    required super.showXLabel,
    required super.showYLabel,
    required super.showZeroLine,
    required super.xName,
    required super.yName,
    required super.barChartTitle,
    required super.xValueLabelForValues,
    required super.xValueLabelForNames,
    required super.yValueLabel,
    required super.barChartInformation,
    required super.barWidth,
    required super.leftPanelValueCount,
    required super.bars,
    required super.showLabelsInBottomPanel,
    required super.leftPanelFlexX,
    required super.rightPanelFlexX,
    required super.topPanelFlexY,
    required super.barChartFlexY,
    required super.bottomPanelFlexY,
    required super.resizerWidth,
    required super.barXSpacing,
    required super.yValueFloatingPointDigits,
    required super.rotateXLabels,
    required super.showResizerLines,
    required super.enableCursorTracker,
    required super.enableBarOverlays,
    required super.staticYGrid,
    required super.barChartBackgroundColor,
    required super.bottomPanelBackgroundColor,
    required super.leftPanelBackgroundColor,
    required super.topPanelBackgroundColor,
    required super.titleFontColor,
    required super.titleFontSize,
    required super.xLabelFontColor,
    required super.xLabelFontSize,
    required super.xValuesFontColor,
    required super.xValuesFontSize,
    required super.yLabelFontColor,
    required super.yLabelFontSize,
    required super.yValuesFontColor,
    required super.yValuesFontSize,
    required super.xGridOpacity,
    required super.yGridOpacity
  }) : super._internal();

}


class BarChartConfigParser {

  static Color parseColor({required dynamic color, required Color alternative, required List<String> warnings, required String colorName}){

    if (color is! Map<String, dynamic>){
      warnings.add("Color : $colorName is not formatted correctly.");
      return alternative;
    }

    final r = color["r"];
    final g = color["g"];
    final b = color["b"];
    final a = color["a"];

    if (r is! int || g is! int || b is! int || a is! int){
      warnings.add("Color : $colorName is not formatted correctly.");
      return alternative;
    }

    return Color.fromARGB(a, r, g, b);

  }

  // Returns a parser state which must be checked if the parser state is a ParserError, ParserSuccessWithWarnings, or ParserSuccess
  static ParserState fromString({required String configString}){
    try {

      final configJson = jsonDecode(configString);

      if (configJson is! List<dynamic> || configJson.isEmpty){
        return ParserError._internal(errorMessage: "Json is incorrectly formatted");
      }

      final jsonMap = configJson[0];
      final List<String> warnings = [];

      final configParser = TypeParser(map: jsonMap, warnings: warnings);

      final constraints = configParser.typeOrOther<Map<String, dynamic>>("constraints", {});
      final settings   = configParser.typeOrOther<Map<String, dynamic>>("settings", {});
      final bars       = configParser.typeOrOther<List<dynamic>>("bars", []);

      final settingsParser   = TypeParser(map: settings, warnings: warnings);
      final constraintsParser = TypeParser(map: constraints, warnings: warnings);

      final showTitle           = settingsParser.typeOrOther("showTitle", true);
      final showXGrid           = settingsParser.typeOrOther("showXGrid", true);
      final showYGrid           = settingsParser.typeOrOther("showYGrid", true);
      final showXValues         = settingsParser.typeOrOther("showXValues", true);
      final showYValues         = settingsParser.typeOrOther("showYValues", true);
      final showXLabel          = settingsParser.typeOrOther("showXLabel", true);
      final showYLabel          = settingsParser.typeOrOther("showYLabel", true);
      final showZeroLine        = settingsParser.typeOrOther("showZeroLine", true);
      final barWidth            = settingsParser.typeOrOther("barWidth", 50.0).clamp(1.0, double.infinity);
      final leftPanelValueCount = settingsParser.typeOrOther("leftPanelValueCount", 9).clamp(2, 1000);
      final xName               = settingsParser.typeOrOther("xName", "xValue");
      final yName               = settingsParser.typeOrOther("yName", "yValue");
      final yValueFloatingPointDigits = settingsParser.typeOrOther("yValueFloatingPointDigits", 2).clamp(0, 1000);
      final barChartTitle       = settingsParser.typeOrOther("title", "Title");
      final xValueLabelForValues         = settingsParser.typeOrOther("xLabelForValues", "X Values");
      final xValueLabelForNames = settingsParser.typeOrOther("xLabelForNames", "X Values");
      final yValueLabel         = settingsParser.typeOrOther("yLabel", "Y Values");
      final barChartInformation = settingsParser.typeOrOther("description", "Information");
      final showLabelsInBottomPanel = settingsParser.typeOrOther("showLabelsInBottomPanel", false);
      final resizerWidth = settingsParser.typeOrOther("resizerWidth", 10.0).clamp(0.0, double.infinity);
      final barXSpacing = settingsParser.typeOrOther("barXSpacing", 0.0).clamp(0.0, double.infinity);
      final rotateXLabels = settingsParser.typeOrOther("rotateXLabels", true);
      final showResizerLines = settingsParser.typeOrOther("showResizerLines", true);
      final enableCursorTracker = settingsParser.typeOrOther("enableCursorTracker", true);
      final enableBarOverlays = settingsParser.typeOrOther("enableBarOverlays", true);
      final staticYGrid = settingsParser.typeOrOther("staticYGrid", false);

      final xGridOpacity = settingsParser.typeOrOther("xGridOpacity", 0.1).clamp(0.0, 1.0);
      final yGridOpacity = settingsParser.typeOrOther("yGridOpacity", 0.1).clamp(0.0, 1.0);

      final topPanelBackgroundColor = settingsParser.colorOrOther("topPanelBackgroundColor", Colors.white);
      final leftPanelBackgroundColor = settingsParser.colorOrOther("leftPanelBackgroundColor", Colors.white);
      final barChartBackgroundColor = settingsParser.colorOrOther("barChartBackgroundColor", Colors.white);
      final bottomPanelBackgroundColor = settingsParser.colorOrOther("bottomPanelBackgroundColor", Colors.white);

      final titleFontSize = settingsParser.typeOrOther("titleFontSize", 20.0).clamp(0.0, double.infinity);
      final titleFontColor = settingsParser.colorOrOther("titleFontColor", Colors.black);
      final xLabelFontSize = settingsParser.typeOrOther("xLabelFontSize", 14.0).clamp(0.0, double.infinity);
      final xLabelFontColor = settingsParser.colorOrOther("xLabelFontColor", Colors.black);
      final yLabelFontSize = settingsParser.typeOrOther("yLabelFontSize", 14.0).clamp(0.0, double.infinity);
      final yLabelFontColor = settingsParser.colorOrOther("yLabelFontColor", Colors.black);
      final xValuesFontSize = settingsParser.typeOrOther("xValuesFontSize", 14.0).clamp(0.0, double.infinity);
      final xValuesFontColor = settingsParser.colorOrOther("xValuesFontColor", Colors.black);
      final yValuesFontSize = settingsParser.typeOrOther("yValuesFontSize", 14.0).clamp(0.0, double.infinity);
      final yValuesFontColor = settingsParser.colorOrOther("yValuesFontColor", Colors.black);


      // by using the flex instead we can more accurately represent normalised units.
      // for example: we can extract a normalised unit with leftX / (leftX + rightX) * screenWidth
      final leftPanelFlexX = constraintsParser.typeOrOther("leftPanelFlexX", 1).clamp(0, 999999);
      final rightPanelFlexX = constraintsParser.typeOrOther("rightPanelFlexX", 9).clamp(0, 999999);
      final topPanelFlexY = constraintsParser.typeOrOther("topPanelFlexY", 1).clamp(0, 999999);
      final barChartFlexY = constraintsParser.typeOrOther("barChartFlexY", 8).clamp(0, 999999);
      final bottomPanelFlexY = constraintsParser.typeOrOther("bottomPanelFlexY", 1).clamp(0, 999999);


      final List<Bar> barList = [];
      for (final (index, b) in bars.indexed){

        final barMap        = AsTypeOrOther<Map<String, dynamic>>(b, {}, () => warnings.add("Bar $index is not formatted correctly")).value();
        final xValue        = AsTypeOrOther<double>(barMap["xValue"], 0.0, () => warnings.add("Bar $index xValue is not formatted correctly")).value();
        final yValue        = AsTypeOrOther<double>(barMap["yValue"], 0.0, () => warnings.add("Bar $index yValue is not formatted correctly")).value();
        final xLabel        = AsTypeOrOther<String>(barMap["xLabel"], "xLabel", () => warnings.add("Bar $index xLabel is not formatted correctly")).value();
        final colorListing  = AsTypeOrOther<Map<String, dynamic>>(barMap["color"], {'r': 0, 'g': 0, 'b': 0, 'a': 0, 'random': true}, () => warnings.add("Bar $index color is not formatted correctly")).value();
        final randomColor   = AsTypeOrOther<bool>(colorListing["random"], true, () => warnings.add("Bar $index color - random is not formatted correctly")).value();
        final circularRadius = AsTypeOrOther<double>(barMap["circularRadius"], 0.0, () => warnings.add("Bar $index circular index is not formatted correctly.")).value();
        final outlined = AsTypeOrOther<bool>(barMap["outlined"], false, () => warnings.add("Bar $index outlined not formatted correctly.")).value();
        final outlineWidth = AsTypeOrOther<double>(barMap["outlineWidth"], 0.0, () => warnings.add("Bar $index outline width not formatted correctly.")).value();
        final color = randomColor
            ? Color.fromARGB(
            255,
            Random().nextInt(256),
            Random().nextInt(256),
            Random().nextInt(256)
        )
            : Color.fromARGB(
          AsTypeOrOther<int>(colorListing["a"], 0, () => warnings.add("Bar $index color - a is not formatted correctly.")).value().clamp(0, 255),
          AsTypeOrOther<int>(colorListing["r"], 0, () => warnings.add("Bar $index color - r is not formatted correctly.")).value().clamp(0, 255),
          AsTypeOrOther<int>(colorListing["g"], 0, () => warnings.add("Bar $index color - g is not formatted correctly.")).value().clamp(0, 255),
          AsTypeOrOther<int>(colorListing["b"], 0, () => warnings.add("Bar $index color - b is not formatted correctly.")).value().clamp(0, 255),
        );

        barList.add(Bar(xValue: xValue, yValue: yValue, color: color, xLabel: xLabel, insertionIndex: index, visible: true, circularRadius: circularRadius, outlined: outlined, outlineWidth: outlineWidth));
      }

      if (warnings.isNotEmpty){
        return ParserSuccessWithWarnings._internal(
            warnings: warnings,
            showTitle: showTitle,
            showXGrid: showXGrid,
            showYGrid: showYGrid,
            showYValues: showYValues,
            showXValues: showXValues,
            showXLabel: showXLabel,
            showYLabel: showYLabel,
            showZeroLine: showZeroLine,
            xName: xName,
            yName: yName,
            barChartTitle: barChartTitle,
            xValueLabelForValues: xValueLabelForValues,
            xValueLabelForNames: xValueLabelForNames,
            yValueLabel: yValueLabel,
            barChartInformation: barChartInformation,
            barWidth: barWidth,
            leftPanelValueCount: leftPanelValueCount,
            bars: barList,
            showLabelsInBottomPanel: showLabelsInBottomPanel,
            leftPanelFlexX: leftPanelFlexX,
            rightPanelFlexX: rightPanelFlexX,
            topPanelFlexY: topPanelFlexY,
            barChartFlexY: barChartFlexY,
            bottomPanelFlexY: bottomPanelFlexY,
            resizerWidth: resizerWidth,
            barXSpacing: barXSpacing,
            yValueFloatingPointDigits: yValueFloatingPointDigits,
            rotateXLabels: rotateXLabels,
            showResizerLines: showResizerLines,
            enableCursorTracker: enableCursorTracker,
            enableBarOverlays: enableBarOverlays,
            staticYGrid: staticYGrid,
            topPanelBackgroundColor: topPanelBackgroundColor,
            leftPanelBackgroundColor: leftPanelBackgroundColor,
            bottomPanelBackgroundColor: bottomPanelBackgroundColor,
            barChartBackgroundColor: barChartBackgroundColor,
            titleFontColor: titleFontColor,
            titleFontSize: titleFontSize,
            xLabelFontColor: xLabelFontColor,
            xLabelFontSize: xLabelFontSize,
            xValuesFontColor: xValuesFontColor,
            xValuesFontSize: xValuesFontSize,
            yLabelFontColor: yLabelFontColor,
            yLabelFontSize: yLabelFontSize,
            yValuesFontColor: yValuesFontColor,
            yValuesFontSize: yValuesFontSize,
            xGridOpacity: xGridOpacity,
            yGridOpacity: yGridOpacity
        );
      }

      return ParserSuccess._internal(
          showTitle: showTitle,
          showXGrid: showXGrid,
          showYGrid: showYGrid,
          showYValues: showYValues,
          showXValues: showXValues,
          showXLabel: showXLabel,
          showYLabel: showYLabel,
          showZeroLine: showZeroLine,
          xName: xName,
          yName: yName,
          barChartTitle: barChartTitle,
          xValueLabelForValues: xValueLabelForValues,
          xValueLabelForNames: xValueLabelForNames,
          yValueLabel: yValueLabel,
          barChartInformation: barChartInformation,
          barWidth: barWidth,
          leftPanelValueCount: leftPanelValueCount,
          bars: barList,
          showLabelsInBottomPanel: showLabelsInBottomPanel,
          leftPanelFlexX: leftPanelFlexX,
          rightPanelFlexX: rightPanelFlexX,
          topPanelFlexY: topPanelFlexY,
          barChartFlexY: barChartFlexY,
          bottomPanelFlexY: bottomPanelFlexY,
          resizerWidth: resizerWidth,
          barXSpacing: barXSpacing,
          yValueFloatingPointDigits: yValueFloatingPointDigits,
          rotateXLabels: rotateXLabels,
          showResizerLines: showResizerLines,
          enableCursorTracker: enableCursorTracker,
          enableBarOverlays: enableBarOverlays,
          staticYGrid: staticYGrid,
          barChartBackgroundColor: barChartBackgroundColor,
          bottomPanelBackgroundColor: bottomPanelBackgroundColor,
          leftPanelBackgroundColor: leftPanelBackgroundColor,
          topPanelBackgroundColor: topPanelBackgroundColor,
          yValuesFontSize: yValuesFontSize,
          yValuesFontColor: yValuesFontColor,
          yLabelFontSize: yLabelFontSize,
          yLabelFontColor: yLabelFontColor,
          xValuesFontSize: xValuesFontSize,
          xValuesFontColor: xValuesFontColor,
          xLabelFontSize: xLabelFontSize,
          xLabelFontColor: xLabelFontColor,
          titleFontSize: titleFontSize,
          titleFontColor: titleFontColor,
          xGridOpacity: xGridOpacity,
          yGridOpacity: yGridOpacity
      );
    }
    catch (e){
      return ParserError._internal(errorMessage: e.toString());
    }
  }

  // Returns a parser state which must be checked if the parser state is a ParserError, ParserSuccessWithWarnings, or ParserSuccess
  static ParserState fromStartupArguments({required List<String> args}){

    try {
      if (args.isEmpty){
        return ParserError._internal(errorMessage: "No arguments provided");
      }

      final configPath = args[0];
      final configFile = File(configPath);

      if (!configFile.existsSync()){
        return ParserError._internal(errorMessage: "Config file not found");
      }

      final configString = configFile.readAsStringSync();
      return fromString(configString: configString);
    }
    catch (e){
     return ParserError._internal(errorMessage: e.toString());
    }
  }

}