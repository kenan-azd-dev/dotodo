import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../../providers/theme_provider.dart';

import '../../../utils/constants.dart';
import '../../../l10n/l10n.dart';
import '../../widgets/header.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.settings),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: kScreenMargin),
        child: ListView(
          children: [
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: kScreenMargin * 2),
              leading: Icon(Icons.dark_mode_rounded),
              title: Text(localization.theme),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return Consumer<ThemeModeProvider>(
                      builder: (context, themeProvider, _) {
                        return SimpleDialog(
                          title: Header(
                            text: localization.appTheme,
                            isCentered: true,
                          ),
                          children: [
                            ListTile(
                              title: Text(localization.themeSystem),
                              onTap: () => themeProvider.mode(ThemeMode.system),
                            ),
                            ListTile(
                              title: Text(localization.themeDark),
                              onTap: () => themeProvider.mode(ThemeMode.dark),
                            ),
                            ListTile(
                              title: Text(localization.themeLight),
                              onTap: () => themeProvider.mode(ThemeMode.light),
                            ),
                          ],
                        );
                      }
                    );
                  },
                );
              },
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: kScreenMargin * 2),
              leading: Icon(Icons.language_rounded),
              title: Text(localization.language),
              onTap: () {},
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: kScreenMargin * 2),
              leading: Icon(Icons.person_rounded),
              title: Text(localization.username),
              onTap: () {},
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: kScreenMargin * 2),
              leading: Icon(Icons.password_outlined),
              title: Text(localization.password),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
