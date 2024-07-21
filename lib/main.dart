import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui_template/internet_connectivity/state/connectivity_state.dart';
import 'package:flutter_ui_template/shared_timer/shared_downtimer.dart';
import 'package:flutter_ui_template/theme/app_theme.dart';
import 'package:flutter_ui_template/theme/theme_extansions.dart';

void main() {
  final container = ProviderContainer();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});
  final _scaffoldkey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(connectivityStatusProviders, (previous, next) {
      if (previous != next) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scaffoldkey.currentState?.hideCurrentSnackBar();
          _scaffoldkey.currentState?.showSnackBar(
            SnackBar(
              content: Text(
                ref.read(connectivityStatusProviders) == ConnectivityStatus.isConnected
                    ? 'Is Connected to Internet'
                    : 'Is Disconnected from Internet',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              backgroundColor:
                  ref.read(connectivityStatusProviders) == ConnectivityStatus.isConnected
                      ? Theme.of(context).colorTheme.primaryColor
                      : Theme.of(context).colorTheme.secondaryColor,
            ),
          );
        });
      }
    });

    return MaterialApp(
      scaffoldMessengerKey: _scaffoldkey,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme, // <-- Light theme value
      darkTheme: AppTheme.darkTheme, // <-- Dark theme value
      themeMode: ThemeMode.dark,
      navigatorKey: navigatorKey,
      home: Scaffold(
        body: SharedTimerWidget(),
      ),
    );
  }
}
final navigatorKey = GlobalKey<NavigatorState>();
