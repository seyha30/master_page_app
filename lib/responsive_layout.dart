
import 'package:flutter/material.dart';

import 'screen_size_constants.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget tiny;
  final Widget phone;
  final Widget tablet;
  final Widget largeTablet;
  final Widget computer;

  const ResponsiveLayout({
    Key? key,
    required this.tiny,
    required this.phone,
    required this.tablet,
    required this.largeTablet,
    required this.computer,
  }) : super(key: key);

  static bool isTinyHeightLimit(BuildContext context) {
    return MediaQuery.of(context).size.height < tinyHeightLimit;
  }

  static bool isTinyLimit(BuildContext context) =>
      MediaQuery.of(context).size.width < tinyLimit;

  static bool isPhone(BuildContext context) =>
      MediaQuery.of(context).size.width < phoneLimit &&
      MediaQuery.of(context).size.width >= tinyLimit;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletLimit &&
      MediaQuery.of(context).size.width >= phoneLimit;

  static bool isLargeTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < largeTabletLimit &&
      MediaQuery.of(context).size.width >= tabletLimit;

  static bool isComputer(BuildContext context) {
    return MediaQuery.of(context).size.width >= largeTabletLimit;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < tinyLimit ||
            constraints.maxHeight < tinyHeightLimit) {
          return tiny;
        }
        if (constraints.maxWidth < phoneLimit) {
          return phone;
        }
        if (constraints.maxWidth < tabletLimit) {
          return tablet;
        }
        if (constraints.maxWidth < largeTabletLimit) {
          return largeTablet;
        }
        return computer;
      },
    );
  }
}
