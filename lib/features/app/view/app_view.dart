import 'package:dotodo/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/utils.dart';
import '../../../features/home/home.dart';
import '../../../l10n/l10n.dart';
import '../../../utils/navigate_to.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeProvider>(builder: (context, themeProvider, _) {
      return MaterialApp(
        title: 'do ToDo',
        debugShowCheckedModeBanner: false,
        locale: Locale('ar'),
        theme: Utils.determineTheme(themeProvider.themeMode, context),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routes: NavigateTo.routes,
        home: const HomePage(),
      );
    });
  }
}
