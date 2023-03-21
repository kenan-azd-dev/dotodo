import 'package:dotodo/providers/theme_provider.dart';
import 'package:dotodo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../features/home/home.dart';
import '../../../l10n/l10n.dart';
import '../../../utils/navigate_to.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeProvider>(builder: (context, themeProvider, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Utils.determineTheme(themeProvider.themeMode, context),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routes: NavigateTo.routes,
        home: const HomePage(),
      );
    });
  }
}