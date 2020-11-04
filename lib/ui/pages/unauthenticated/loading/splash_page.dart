import 'package:flixage/bloc/networt_status_bloc.dart';
import 'package:flixage/generated/l10n.dart';
import 'package:flixage/ui/widget/network_aware/network_aware_widget.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NetworkAwareWidget(
      builder: (context, status) {
        Color statusColor = status == NetworkStatus.Offline ? Colors.red : Colors.white;
        String text = status == NetworkStatus.Offline
            ? S.current.splashScreen_offline
            : S.current.splashScreen_welcome;

        return Material(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Flixage",
                  style: TextStyle(color: Theme.of(context).accentColor, fontSize: 80),
                ),
                SizedBox(height: 32),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Text(text,
                          style: TextStyle(color: statusColor, fontSize: 20),
                          textAlign: TextAlign.center),
                    ),
                    CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(statusColor))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
