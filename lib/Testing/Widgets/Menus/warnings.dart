import 'dart:convert';

import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:barchart/Testing/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:barchart/Testing/Widgets/menupicker.dart';
import 'package:file_picker/file_picker.dart';

class GlobalConfigWarnings{
  static List<String> warnings = [];
}

class ConfigWarningsMenu extends HookConsumerWidget {
  const ConfigWarningsMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final activeMenu = ref.watch(BarChartGlobalMenu.activeMenu);

    return Menu(
      isActive: activeMenu == BarChartMenu.warnings,
      menuTitle: "Config Warnings",
      children: [
        for (final w in GlobalConfigWarnings.warnings)
          MenuListing(widget: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(Icons.warning),
              ),
              Expanded(child: Text(w))
            ],
          ))
      ],
    );
  }
}
