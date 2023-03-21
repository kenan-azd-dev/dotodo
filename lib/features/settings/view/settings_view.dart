import 'package:dotodo/features/widgets/header.dart';
import 'package:dotodo/providers/theme_provider.dart';
import 'package:dotodo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: kScreenMargin),
        child: ListView(
          children: [
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: kScreenMargin * 2),
              leading: Icon(Icons.dark_mode_rounded),
              title: Text('Theme'),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return Consumer<ThemeModeProvider>(
                      builder: (context, themeProvider, _) {
                        return SimpleDialog(
                          title: Header(
                            text: 'App Theme',
                            isCentered: true,
                          ),
                          children: [
                            ListTile(
                              title: Text('System default'),
                              onTap: () => themeProvider.mode(ThemeMode.system),
                            ),
                            ListTile(
                              title: Text('Dark theme'),
                              onTap: () => themeProvider.mode(ThemeMode.dark),
                            ),
                            ListTile(
                              title: Text('Light theme'),
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
              title: Text('Language'),
              onTap: () {},
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: kScreenMargin * 2),
              leading: Icon(Icons.person_rounded),
              title: Text('Username'),
              onTap: () {},
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: kScreenMargin * 2),
              leading: Icon(Icons.password_outlined),
              title: Text('Password'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
