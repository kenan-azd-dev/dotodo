import 'package:dotodo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import '../../../../utils/navigate_to.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;
    final size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            height: size.height / 4,
            width: double.infinity,
            color: Theme.of(context).colorScheme.onSecondary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterLogo(size: 50),
                SizedBox(height: 10.0),
                Text('You can do your Todos!')
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.settings_rounded),
                  title: Text(localization.settings),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                  onTap: () => Navigator.of(context).pushNamed(NavigateTo.settingsPage),
                ),
                ListTile(
                  leading: Icon(Icons.star_rate_rounded),
                  title: Text(localization.rateTheApp),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.question_mark_rounded),
                  title: Text(localization.about),
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
