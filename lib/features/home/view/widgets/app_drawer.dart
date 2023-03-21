import 'package:flutter/material.dart';
import '../../../../utils/navigate_to.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  title: Text('Settings'),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                  onTap: () => Navigator.of(context).pushNamed(NavigateTo.settingsPage),
                ),
                ListTile(
                  leading: Icon(Icons.star_rate_rounded),
                  title: Text('Rate the app'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.question_mark_rounded),
                  title: Text('About'),
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
