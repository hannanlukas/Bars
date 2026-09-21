import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:barchart/Testing/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:barchart/Testing/Widgets/menupicker.dart';


class InformationMenu extends HookConsumerWidget{
  const InformationMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final activeMenu = ref.watch(BarChartGlobalMenu.activeMenu);

    return Menu(
      menuTitle: "Information",
      isActive: activeMenu == BarChartMenu.information,
      children: [
        MenuListing(widget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            style: GoogleFonts.googleSans(),
            config.barChartInformation,
            textAlign: TextAlign.center,
          ),
        ))
      ],
    );
  }

}