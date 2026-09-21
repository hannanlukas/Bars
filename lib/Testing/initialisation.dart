import 'dart:io';

import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/parser.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:barchart/Testing/transformation.dart';
import 'package:flutter/material.dart';

// This file is used to initialise all the global notifiers and must be ran prior to
// the run app as all the notifiers are initialised.
// The user should first check if initialisation has already been initialised, then weather the
// state type is InitialisationSuccess, InitialisationError or InitialisationSuccessWithWarnings to ensure
// any warnings or errors are picked up.

class InitialisationState{
  const InitialisationState();
}
class InitialisationSuccess extends InitialisationState{

  final ParserSuccess parserState;

  const InitialisationSuccess({required this.parserState});
}
class InitialisationError extends InitialisationState{
  String errorMessage;

  InitialisationError({
    required this.errorMessage
  });
}
class InitialisationSuccessWithWarnings extends InitialisationState{
  final List<String> warnings;
  final ParserSuccessWithWarnings parserState;

  const InitialisationSuccessWithWarnings({
    required this.warnings, required this.parserState,
  });

}

class Initialisation {

  static bool _initialised = false;
  static bool get isInitialised => _initialised;

  static InitialisationState initialiseFromParserState({required ParserState parserState}){
    if (parserState is ParserError){
      return InitialisationError(errorMessage: parserState.errorMessage);
    }
    if (parserState is ParserSuccessWithWarnings){

      final barChartConfig = parserState.toBarChartConfig();
      final barChartConstraints = parserState.toBarChartConstraints();
      BarChartGlobalConfig.initialiseConfigNotifier(config: barChartConfig);
      BarChartGlobalBars.initialise(bars: barChartConfig.bars);
      BarChartGlobalConstraints.initialise(barChartConstraints: barChartConstraints);
      BarChartGlobalTransformation.initialise(transformation: Matrix4.identity());

      return InitialisationSuccessWithWarnings(warnings: parserState.warnings, parserState: parserState);
    }
    if (parserState is ParserSuccess){

      final barChartConfig = parserState.toBarChartConfig();
      final barChartConstraints = parserState.toBarChartConstraints();
      BarChartGlobalConfig.initialiseConfigNotifier(config: barChartConfig);
      BarChartGlobalBars.initialise(bars: barChartConfig.bars);
      BarChartGlobalConstraints.initialise(barChartConstraints: barChartConstraints);
      BarChartGlobalTransformation.initialise(transformation: Matrix4.identity());
    }

    _initialised = true;
    return InitialisationSuccess(parserState: parserState as ParserSuccess);
  }

  static InitialisationState initialiseFromString({required String jsonString}){

    if (_initialised){
      return InitialisationError(errorMessage: "Initialisation has already initialised");
    }

    final parserState = BarChartConfigParser.fromString(configString: jsonString);
    return initialiseFromParserState(parserState: parserState);
  }

  static InitialisationState initialiseFromLaunchParameters({required List<String> args}){

    if (_initialised){
      return InitialisationError(errorMessage: "Initialisation has already initialised");
    }

    final parserState = BarChartConfigParser.fromStartupArguments(args: args);
    return initialiseFromParserState(parserState: parserState);

  }

}