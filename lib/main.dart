import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vec;
import 'dart:convert';
import 'dart:core';
import 'package:barchart/bars.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/initialisation.dart';
import 'package:barchart/Testing/parser.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:window_manager/window_manager.dart';
import 'package:barchart/Testing/Widgets/Menus/warnings.dart';

// Release
void main(List<String> args) async {

  final filePath = args.isNotEmpty ? args[0] : null;

  String jsonString = "[{}]";
  String appTitle = "Bar Chart";
  if (filePath != null){
    final file = File(filePath);
    jsonString = file.readAsStringSync();
  }


  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  bool initialisationSuccess = true;
  if (!Initialisation.isInitialised){
    final initialisationState = Initialisation.initialiseFromString(jsonString: jsonString);
    if (initialisationState is InitialisationError){
      initialisationSuccess = false;
    }
    if (initialisationState is InitialisationSuccessWithWarnings){
      GlobalConfigWarnings.warnings = initialisationState.warnings;
      appTitle = initialisationState.parserState.barChartTitle;
    }
    if (initialisationState is InitialisationSuccess){
      appTitle = initialisationState.parserState.barChartTitle;
    }
  }

  WindowOptions windowOptions = WindowOptions(
    title: appTitle,
    size: Size(800, 800),
    minimumSize: Size(600, 600),
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(
      ProviderScope(
          child: MaterialApp(
              home: Scaffold(
                  body: initialisationSuccess
                      ? BarChartExample()
                      : ErrorWidget("Unable to format config")
              )
          )
      )
  );
}

// Debug
/*
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  var jsonString = '''
    [
      {
        "settings": {
          "title": "Worthiness Of Fruit",
          "xLabelForValues": "Cost",
          "xLabelForNames": "Fruit Type",
          "yLabel": "Enjoyment Rating",
          "description": "This bar chart compares the cost of fruit against how much the fruit is enjoyed, with the maximum rating being 10, and the minimum rating being -10.",
          "showTitle": true,
          "showYGrid": true,
          "showXGrid": true,
          "showYValues": true,
          "showXValues": true,
          "showXLabel": true,
          "showYLabel": true,
          "showZeroLine": true,
          "barWidth": 50.0,
          "leftPanelValueCount": 9,
          "xName": "Cost",
          "yName": "Rating",
          "showLabelsInBottomPanel": false,
          "resizerWidth": 3.0,
          "yValueFloatingPointDigits": 2,
          "barXSpacing": 25.0,
          "rotateXLabels": true,
          "showResizerLines": false,
          "enableCursorTracker": true,
          "enableBarOverlays": true,
          "staticYGrid": false,
          "xGridOpacity": 0.1,
          "yGridOpacity": 0.1,
          
          "topPanelBackgroundColor": {"r": 250, "g": 250, "b": 250, "a": 255},
          "leftPanelBackgroundColor": {"r": 250, "g": 250, "b": 250, "a": 255},
          "barChartBackgroundColor": {"r": 255, "g": 255, "b": 255, "a": 255},
          "bottomPanelBackgroundColor": {"r": 250, "g": 250, "b": 250, "a": 255},
          
          "titleFontSize": 24.0,
          "titleFontColor": {"r": 0, "g": 0, "b": 0, "a": 255},
          "xLabelFontSize": 16.0,
          "xLabelFontColor": {"r": 0, "g": 0, "b": 0, "a": 255},
          "yLabelFontSize": 16.0,
          "yLabelFontColor": {"r": 0, "g": 0, "b": 0, "a": 255},
          "yValuesFontSize": 12.0,
          "yValuesFontColor": {"r": 0, "g": 0, "b": 0, "a": 255},
          "xValuesFontSize": 12.0,
          "xValuesFontColor": {"r": 0, "g": 0, "b": 0, "a": 255}
        },

        "constraints": {
          "leftPanelFlexX" : 1,
          "rightPanelFlexX": 9,
          "topPanelFlexY": 1,
          "barChartFlexY": 8,
          "bottomPanelFlexY": 1
        },
        "bars": [
          {"xValue": 1.50, "yValue": 5.0, "color": {"r": 255, "g": 0, "b": 0, "a": 255, "random": false}, "xLabel": "Apple", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
          {"xValue": 1.00, "yValue": -2.0, "color": {"r": 0, "g": 255, "b": 0, "a": 255, "random": false}, "xLabel": "Pear", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
          {"xValue": 0.80, "yValue": 9.0, "color": {"r": 255, "g": 163, "b": 0, "a": 255, "random": false}, "xLabel": "Orange", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
          {"xValue": 1.80, "yValue": 4.0, "color": {"r": 248, "g": 255, "b": 0, "a": 255, "random": false}, "xLabel": "Banana", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
          {"xValue": 2.50, "yValue": 10.0, "color": {"r": 220, "g": 20, "b": 60, "a": 255, "random": false}, "xLabel": "Strawberry", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
          {"xValue": 3.00, "yValue": 8.0, "color": {"r": 138, "g": 43, "b": 226, "a": 255, "random": false}, "xLabel": "Blueberry", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
          {"xValue": 4.50, "yValue": 7.5, "color": {"r": 106, "g": 13, "b": 173, "a": 255, "random": false}, "xLabel": "Mango", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
          {"xValue": 5.00, "yValue": -8.0, "color": {"r": 143, "g": 188, "b": 143, "a": 255, "random": false}, "xLabel": "Durian", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
          {"xValue": 3.50, "yValue": -5.0, "color": {"r": 255, "g": 20, "b": 147, "a": 255, "random": false}, "xLabel": "Dragonfruit", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
          {"xValue": 20.0, "yValue": 6.5, "color": {"r": 50, "g": 205, "b": 50, "a": 255, "random": false}, "xLabel": "Kiwi", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0}
        ]
      }
    ]
  ''';
  String appTitle = "Bar Chart";

  if (!Initialisation.isInitialised){
    final initialisationState = Initialisation.initialiseFromString(jsonString: jsonString);
    if (initialisationState is InitialisationError){
      print("Initialisation Error : ${initialisationState.errorMessage}");
    }
    if (initialisationState is InitialisationSuccessWithWarnings){

      appTitle = initialisationState.parserState.barChartTitle;

      print ("Initialised with warnings : ");
      for (final w in initialisationState.warnings) print(w);
    }
    if (initialisationState is InitialisationSuccess){

      appTitle = initialisationState.parserState.barChartTitle;

      print("Initialisation success");
    }
  }

  WindowOptions windowOptions = WindowOptions(
    title: appTitle,
    size: Size(800, 800),
    minimumSize: Size(600, 600),
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(
      ProviderScope(
          child: MaterialApp(
              home: Scaffold(
                  body: BarChartExample()
              )
          )
      )
  );
}
 */

