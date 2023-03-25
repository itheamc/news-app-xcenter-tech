import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/screen_size.dart';

/// Responsive Ui Mixin
mixin ResponsiveUiMixin<T extends GetxController> {
  T get controller => Get.find<T>();

  double get width => Get.width;

  double get height => Get.height;

  /// Method to return widget for mobile
  Widget? ui4Watch({Key? key}) => null;

  /// Method to return widget for mobile
  Widget ui4Phone({Key? key});

  /// Method to return widget for tablet
  Widget? ui4Tablet({Key? key}) => null;

  /// Method to return widget for desktop
  Widget? ui4Desktop({Key? key}) => null;

  /// Method to return ui as per the screen size
  Widget buildUi(BuildContext context) {
    if (ui4Desktop() == null && ui4Tablet() == null && ui4Watch() == null) {
      return ui4Phone();
    }

    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.minWidth > ScreenSize.s1200) {
          return ui4Desktop() ?? ui4Phone();
        } else if (constraints.minWidth > ScreenSize.s640) {
          return ui4Tablet() ?? ui4Phone();
        } else if (constraints.minWidth > ScreenSize.s300) {
          return ui4Phone();
        } else {
          return ui4Watch() ?? ui4Phone();
        }
      },
    );
  }
}

/// Responsive Ui
class ResponsiveUi extends StatelessWidget {
  final Widget? desktopUi;
  final Widget? tabletUi;
  final Widget phoneUi;
  final Widget? watchUi;

  const ResponsiveUi({
    Key? key,
    this.desktopUi,
    this.tabletUi,
    required this.phoneUi,
    this.watchUi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      if (constraints.minWidth > ScreenSize.s1200) {
        return desktopUi ?? phoneUi;
      } else if (constraints.minWidth > ScreenSize.s640) {
        return tabletUi ?? phoneUi;
      } else if (constraints.minWidth > ScreenSize.s300) {
        return phoneUi;
      } else {
        return watchUi ?? phoneUi;
      }
    });
  }
}
