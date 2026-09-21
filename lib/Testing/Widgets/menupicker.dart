import 'dart:ui';

import 'package:barchart/Testing/Widgets/Menus/barmodifications.dart';
import 'package:barchart/Testing/Widgets/Menus/information.dart';
import 'package:barchart/Testing/Widgets/Menus/sort.dart';
import 'package:barchart/Testing/Widgets/Menus/warnings.dart';
import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/transformation.dart';
import 'package:barchart/Testing/Widgets/Menus/settings.dart';
import 'package:barchart/Testing/menu.dart';
import 'package:barchart/Testing/Widgets/Menus/save.dart';


class Menu extends HookConsumerWidget {
  const Menu({
    super.key,
    required this.menuTitle,
    this.children = const [],
    required this.isActive
  });

  final String menuTitle;
  final List<MenuListing> children;
  final bool isActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final animation = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );

    useEffect((){
      WidgetsBinding.instance.addPostFrameCallback((_){
        if (isActive) {
          animation.forward();
        } else {
          animation.reverse();
        }
      });

      return null;
    }, [isActive]);


    void exit() async {
      await animation.reverse();
      ref.read(BarChartGlobalMenu.activeMenu.notifier).set(menu: null);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: constraints.maxWidth * 0.5,
            height: constraints.maxHeight,
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Opacity(
                  opacity: animation.value,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 2.0 * animation.value,
                      sigmaY: 2.0 * animation.value,
                    ),
                    child: child,
                  ),
                );
              },
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  final curved =
                  Curves.easeInCubic.transform(animation.value);

                  return Transform.translate(
                    offset: Offset(
                      (constraints.maxWidth * 0.5) * (1.0 - curved),
                      0,
                    ),
                    child: child,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6F8),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      bottomLeft: Radius.circular(28),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 30,
                        offset: const Offset(-8, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Header
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          24,
                          22,
                          16,
                          10,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                menuTitle,
                                style: GoogleFonts.googleSans(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.6,
                                ),
                              ),
                            ),

                            IconButton(
                              onPressed: exit,
                              icon: const Icon(
                                Icons.close_rounded,
                                size: 21,
                              ),
                              style: IconButton.styleFrom(
                                backgroundColor:
                                Colors.black.withValues(alpha: 0.045),
                                foregroundColor: Colors.black87,
                                minimumSize: const Size(42, 42),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Header divider
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.black.withValues(alpha: 0.06),
                        ),
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(
                            18,
                            16,
                            18,
                            18,
                          ),
                          child: Column(
                            children: [
                              for (final c in children)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 5,
                                  ),
                                  child: c,
                                ),

                              const SizedBox(height: 6),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


}

class MenuListing extends HookConsumerWidget {
  const MenuListing({
    super.key,
    required this.widget,
    this.showBorder = true
  });

  final Widget widget;
  final bool showBorder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 56,
            ),
            decoration: showBorder ?BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.black.withValues(alpha: 0.035),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.025),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ) : null,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: Center(
              child: widget,
            ),
          ),
        ),
      ],
    );
  }
}
class MenuListingCheckbox extends MenuListing {
  const MenuListingCheckbox({
    super.key,
    required super.widget,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 56,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.035),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            visualDensity: VisualDensity.compact,
          ),

          const SizedBox(width: 6),

          Expanded(
            child: super.widget,
          ),
        ],
      ),
    );
  }
}
class MenuListingIntInput extends MenuListing {
  const MenuListingIntInput({
    super.key,
    required super.widget,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    required this.onValidChange,
  });

  final int initialValue;
  final int minValue;
  final int maxValue;
  final void Function(int) onValidChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = useState<int?>(initialValue);
    final controller = useTextEditingController(
      text: initialValue.toString(),
    );
    final focus = useFocusNode();

    useEffect(() {
      void adjustValueOnFocusChange() {
        if (value.value == null) {
          value.value = minValue;
          controller.text = minValue.toString();
          onValidChange(minValue);
          return;
        }

        final val = value.value!;

        if (val >= minValue && val <= maxValue) {
          return;
        }

        if (val < minValue) {
          value.value = minValue;
          controller.text = minValue.toString();
          onValidChange(minValue);
          return;
        }

        if (val > maxValue) {
          value.value = maxValue;
          controller.text = maxValue.toString();
          onValidChange(maxValue);
          return;
        }
      }

      focus.addListener(adjustValueOnFocusChange);

      return () {
        focus.removeListener(adjustValueOnFocusChange);
      };
    }, []);

    final valid =
        value.value != null &&
            value.value! >= minValue &&
            value.value! <= maxValue;

    return Container(
      constraints: const BoxConstraints(
        minHeight: 56,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: focus.hasFocus
              ? Theme.of(context)
              .colorScheme
              .primary
              .withValues(alpha: 0.35)
              : Colors.black.withValues(alpha: 0.035),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                style: GoogleFonts.googleSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: valid
                      ? Colors.black87
                      : Colors.red.shade600,
                ),
                focusNode: focus,
                controller: controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  hintText: '0',
                  filled: true,
                  fillColor: Colors.black.withValues(alpha: 0.025),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (str) {
                  final val = int.tryParse(str);
                  value.value = val;

                  if (val != null &&
                      val >= minValue &&
                      val <= maxValue) {
                    onValidChange(val);
                  }
                },
                onTapOutside: (event) {
                  focus.unfocus();
                },
              ),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: super.widget,
          ),

          const SizedBox(width: 6),
        ],
      ),
    );
  }
}
class MenuListingDoubleInput extends MenuListing {
  const MenuListingDoubleInput({
    super.key,
    required super.widget,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    required this.onValidChange,
  });

  final double initialValue;
  final double minValue;
  final double maxValue;
  final void Function(double) onValidChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = useState<double?>(initialValue);
    final controller = useTextEditingController(
      text: initialValue.toString(),
    );
    final focus = useFocusNode();

    useEffect(() {
      void adjustValueOnFocusChange() {
        if (value.value == null) {
          value.value = minValue;
          controller.text = minValue.toString();
          onValidChange(minValue);
          return;
        }

        final val = value.value!;

        if (val >= minValue && val <= maxValue) {
          return;
        }

        if (val < minValue) {
          value.value = minValue;
          controller.text = minValue.toString();
          onValidChange(minValue);
          return;
        }

        if (val > maxValue) {
          value.value = maxValue;
          controller.text = maxValue.toString();
          onValidChange(maxValue);
          return;
        }
      }

      focus.addListener(adjustValueOnFocusChange);

      return () {
        focus.removeListener(adjustValueOnFocusChange);
      };
    }, []);

    final valid =
        value.value != null &&
            value.value! >= minValue &&
            value.value! <= maxValue;

    return Container(
      constraints: const BoxConstraints(
        minHeight: 56,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: focus.hasFocus
              ? Theme.of(context)
              .colorScheme
              .primary
              .withValues(alpha: 0.35)
              : Colors.black.withValues(alpha: 0.035),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                style: GoogleFonts.googleSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: valid
                      ? Colors.black87
                      : Colors.red.shade600,
                ),
                focusNode: focus,
                controller: controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  hintText: '0.0',
                  filled: true,
                  fillColor: Colors.black.withValues(alpha: 0.025),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[0-9]*\.?[0-9]*'),
                  ),
                ],
                onChanged: (str) {
                  final val = double.tryParse(str);
                  value.value = val;

                  if (val != null &&
                      val >= minValue &&
                      val <= maxValue) {
                    onValidChange(val);
                  }
                },
                onTapOutside: (event) {
                  focus.unfocus();
                },
              ),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: super.widget,
          ),

          const SizedBox(width: 6),
        ],
      ),
    );
  }
}
class MenuListingColor extends MenuListing {
  const MenuListingColor({
    super.key,
    required this.initialColor,
    required this.onChanged,
    super.widget = const SizedBox.shrink(),
  });

  final Color initialColor;
  final void Function(Color) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = useState(initialColor);

    Widget channelRow({
      required String label,
      required double value,
      required int displayValue,
      required ValueChanged<double> onChanged,
    }) {
      return Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              label,
              style: GoogleFonts.googleSans(
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(width: 6),

          Expanded(
            child: Slider(
              min: 0.0,
              max: 1.0,
              value: value,
              onChanged: onChanged,
            ),
          ),

          SizedBox(
            width: 38,
            child: Text(
              '$displayValue',
              textAlign: TextAlign.right,
              style: GoogleFonts.googleSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        // Colour preview


        Center(
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color.value,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black.withValues(alpha: 0.12),
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        channelRow(
          label: 'R',
          value: color.value.r,
          displayValue: (color.value.r * 255).toInt(),
          onChanged: (r) {
            color.value = Color.fromARGB(
              (color.value.a * 255).toInt(),
              (r * 255).toInt(),
              (color.value.g * 255).toInt(),
              (color.value.b * 255).toInt(),
            );

            onChanged(color.value);
          },
        ),

        channelRow(
          label: 'G',
          value: color.value.g,
          displayValue: (color.value.g * 255).toInt(),
          onChanged: (g) {
            color.value = Color.fromARGB(
              (color.value.a * 255).toInt(),
              (color.value.r * 255).toInt(),
              (g * 255).toInt(),
              (color.value.b * 255).toInt(),
            );

            onChanged(color.value);
          },
        ),

        channelRow(
          label: 'B',
          value: color.value.b,
          displayValue: (color.value.b * 255).toInt(),
          onChanged: (b) {
            color.value = Color.fromARGB(
              (color.value.a * 255).toInt(),
              (color.value.r * 255).toInt(),
              (color.value.g * 255).toInt(),
              (b * 255).toInt(),
            );

            onChanged(color.value);
          },
        ),

        channelRow(
          label: 'A',
          value: color.value.a,
          displayValue: (color.value.a * 255).toInt(),
          onChanged: (a) {
            color.value = Color.fromARGB(
              (a * 255).toInt(),
              (color.value.r * 255).toInt(),
              (color.value.g * 255).toInt(),
              (color.value.b * 255).toInt(),
            );

            onChanged(color.value);
          },
        ),
      ],
    );
  }
}
class MenuListingDropdown extends MenuListing {
  const MenuListingDropdown({
    super.key,
    required super.widget,
    required this.dropDownWidget,
  });

  final Widget dropDownWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showing = useState(false);

    if (!showing.value) {
      return Container(
        constraints: const BoxConstraints(
          minHeight: 56,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.035),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.025),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.chevron_right_rounded,
                size: 22,
              ),
              onPressed: () {
                showing.value = true;
              },
              style: IconButton.styleFrom(
                backgroundColor:
                Colors.black.withValues(alpha: 0.035),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: super.widget,
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .primary
              .withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(
        10,
        6,
        10,
        10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.expand_less_rounded,
                  size: 22,
                ),
                onPressed: () {
                  showing.value = false;
                },
                style: IconButton.styleFrom(
                  backgroundColor:
                  Colors.black.withValues(alpha: 0.035),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: super.widget,
              ),
            ],
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Colors.black.withValues(alpha: 0.06),
            ),
          ),

          //const SizedBox(height: 8),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              //color: const Color(0xFFF5F6F8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: dropDownWidget,
          ),
        ],
      ),
    );
  }
}
class MenuListingCheckboxWithExpansion extends MenuListingCheckbox{
  const MenuListingCheckboxWithExpansion({
    super.key,
    required super.widget,
    required super.value,
    required super.onChanged,
    required this.expansion
  });

  final Widget expansion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
      constraints: const BoxConstraints(
        minHeight: 56,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.035),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              //horizontal: 10,
              vertical: 6,
            ),
            child: Row(
              children: [
                Checkbox(
                  value: value,
                  onChanged: onChanged,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  visualDensity: VisualDensity.compact,
                ),

                const SizedBox(width: 6),

                Expanded(
                  child: super.widget,
                ),
              ],
            ),
          ),



          if (super.value) ... [
            const Divider(),

            const SizedBox(height: 10),

            expansion
          ]

        ],
      ),
    );

  }

}

class MenuListingButton extends MenuListing {
  const MenuListingButton({
    super.key,
    required super.widget,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 56,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          hoverColor: colorScheme.primary.withValues(alpha: 0.035),
          splashColor: colorScheme.primary.withValues(alpha: 0.08),
          highlightColor: colorScheme.primary.withValues(alpha: 0.05),
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.black.withValues(alpha: 0.035),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.025),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            child: Center(child:
              Row(
                mainAxisSize: MainAxisSize.min,
              children: [
                super.widget,
                Icon(Icons.arrow_right_outlined)
              ],
            )),
          ),
        ),
      ),
    );
  }
}






class MenuPicker extends HookConsumerWidget {
  const MenuPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final menuWindowOpen = useState(false);

    final opacity = useAnimationController(duration: Duration(milliseconds: 200));
    useEffect((){
      if (menuWindowOpen.value)
      {
        opacity.forward();
      }
      else{
        opacity.reverse();
      }

      return null;
    }, [menuWindowOpen.value]);






    return LayoutBuilder(builder: (context, constraints) {

      return Stack(
        children: [


          Positioned(
              top: 0,
              right: 0,
              child: FadeTransition(
                opacity: opacity,
                child: SizedBox(
                  width: 48,
                  height: constraints.maxHeight,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusGeometry.circular(12),
                          color: Colors.white,
                          boxShadow: [BoxShadow(color: Colors.black.withAlpha(50), offset: Offset(-2, -2), blurRadius: 4.0)]
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            IconButton(
                                onPressed: () {
                                  ref.read(BarChartGlobalMenu.activeMenu.notifier).set(menu: BarChartMenu.settings);
                                },
                                icon: Icon(
                                    Icons.settings,
                                )
                            ),
                            IconButton(
                                onPressed: (){
                                  ref.read(BarChartGlobalTransformation.transformation.notifier).set(transformation: Matrix4.identity());
                                },
                                icon: Icon(Icons.replay_sharp)
                            ),
                            IconButton(
                                onPressed: (){
                                  ref.read(BarChartGlobalMenu.activeMenu.notifier).set(menu: BarChartMenu.information);
                                },
                                icon: Icon(Icons.info)
                            ),
                            IconButton(
                                onPressed: (){
                                  ref.read(BarChartGlobalMenu.activeMenu.notifier).set(menu: BarChartMenu.barModifications);
                                },
                                icon: Icon(Icons.visibility)
                            ),
                            IconButton(
                                onPressed: (){
                                  ref.read(BarChartGlobalMenu.activeMenu.notifier).set(menu: BarChartMenu.barSorter);
                                },
                                icon: Icon(Icons.sort)
                            ),
                            IconButton(
                                onPressed: (){
                                  ref.read(BarChartGlobalMenu.activeMenu.notifier).set(menu: BarChartMenu.save);
                                },
                                icon: Icon(Icons.save)
                            ),
                            IconButton(
                                onPressed: (){
                                  ref.read(BarChartGlobalMenu.activeMenu.notifier).set(menu: BarChartMenu.warnings);
                                },
                                icon: Icon(Icons.warning)
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
          ),

          Positioned(
              top: 0,
              right: 0,
              child: MouseRegion(
                hitTestBehavior: HitTestBehavior.translucent,
                onEnter: (_){
                  menuWindowOpen.value = true;
                },
                onExit: (_){
                  menuWindowOpen.value = false;
                },
                child: SizedBox(
                  width: constraints.maxWidth / 8,
                  height: constraints.maxHeight,
                ),
              )
          ),

          Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: SettingsMenu()
              )
          ),

          Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: InformationMenu()
              )
          ),

          Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: BarSort()
              )
          ),

          Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: BarModifications()
              )
          ),

          Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: SaveMenu()
              )
          ),

          Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: ConfigWarningsMenu()
              )
          ),



        ],
      );

    });
  }
}
