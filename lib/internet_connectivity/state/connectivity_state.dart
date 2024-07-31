import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus { NotDetermined, isConnected, isDisonnected }

final connectivityStatusProviders = StateNotifierProvider((ref) {
  return ConnectivityStatusNotifier();
});

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
  ConnectivityStatus? lastResult;
  ConnectivityStatus? newState;
  ConnectivityStatusNotifier() : super(ConnectivityStatus.isConnected) {
    if (state == ConnectivityStatus.isConnected) {
      lastResult = ConnectivityStatus.isConnected;
    } else {
      lastResult = ConnectivityStatus.isDisonnected;
    }
    lastResult = ConnectivityStatus.NotDetermined;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      debugPrint('Connectivity Changed: $result');
      switch (result) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          newState = ConnectivityStatus.isConnected;
          break;
        case ConnectivityResult.none:
          newState = ConnectivityStatus.isDisonnected;
          break;
      }
      if (newState != lastResult) {
        state = newState!;
        lastResult = newState;
      }
    });
  }
}
