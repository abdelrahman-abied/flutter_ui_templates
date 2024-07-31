import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui_template/internet_connectivity/state/connectivity_state.dart';
import 'package:flutter_ui_template/theme/theme_extansions.dart';

import '../../otp_design.dart/otp_home_screen.dart';

class ConnectivityView extends ConsumerStatefulWidget {
  const ConnectivityView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConnectivityViewState();
}

class _ConnectivityViewState extends ConsumerState<ConnectivityView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ref.watch(connectivityStatusProviders) == ConnectivityStatus.isConnected
                ? 'Is Connected to Internet'
                : 'Is Disconnected from Internet',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          backgroundColor: ref.watch(connectivityStatusProviders) == ConnectivityStatus.isConnected
              ? Colors.green
              : Colors.red,
        ),
      );
    });
    return Scaffold(
        backgroundColor: connectivityStatusProvider == ConnectivityStatus.isConnected
            ? Colors.greenAccent
            : Colors.black54,
        appBar: AppBar(
          title: const Text(
            'Network Connectivity',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: Theme.of(context).appGradientTheme.backgroundGradient,
                ),
                child: const Text(
                  'Connectivity Status',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtpVerificationView(),
                    ),
                  );
                },
                child: Text(
                  connectivityStatusProvider == ConnectivityStatus.isConnected
                      ? 'Is Connected to Internet'
                      : 'Is Disconnected from Internet',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
