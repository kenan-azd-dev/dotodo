import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

import '../../../../providers/theme_provider.dart';
import '../../../../utils/constants.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeProvider>(
      builder: (context, themeProvider, _) {
        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: kScreenMargin),
          height: 30,
          width: 90,
          child: AnimatedToggleSwitch.rolling(
              onChanged: (value) async {
                await themeProvider.mode(value);
              },
              current: themeProvider.themeMode,
              values: [
                ThemeMode.light,
                ThemeMode.dark,
                ThemeMode.system
              ],
              iconBuilder:
                  (value, size, foreground) {
                if (value == ThemeMode.light) {
                  return Icon(
                      Icons.wb_sunny_rounded);
                } else if (value ==
                    ThemeMode.dark) {
                  return Icon(
                      Icons.dark_mode_rounded);
                } else {
                  return Icon(Icons
                      .settings_brightness_rounded);
                }
              }),
        );
      },
    );
  }
}
