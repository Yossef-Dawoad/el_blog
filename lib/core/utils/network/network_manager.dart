import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

abstract interface class NetworkManager {
  Future<bool> get hasInternetAccess;

  /// Exposes connectivity update events from the platform.
  Stream<List<ConnectivityResult>> get onConnectivityChanged;
}

class NetworkManagerImpl implements NetworkManager {
  final Connectivity _connectivity;
  NetworkManagerImpl(this._connectivity);

  @override
  Future<bool> get hasInternetAccess async => _checkhasInternetAccess();

  Future<bool> _checkhasInternetAccess() async {
    try {
      final result = await _connectivity.checkConnectivity();
      // If the connection is none or only bluetooth, then there is no internet connection.
      if (result.contains(ConnectivityResult.none) ||
          result.every((ele) => ele == ConnectivityResult.bluetooth)) {
        return false;
      }
      return true;
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Exposes connectivity update events from the platform.
  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;
}

// connectivity_plus: ^6.0.3