import 'package:flixage/ui/pages/app/settings_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(SettingsPage.route);
                },
              ),
            ],
          ),
          Text("Często odtwarzane")
        ],
      ),
    );
  }
}
