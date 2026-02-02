part of "imports.dart";

class ConnectionCubit extends Cubit<ConnectionStatus> {
  final ConnectionChecker connectionChecker;
  ConnectionCubit({required this.connectionChecker})
      : super(ConnectionStatus(false, true)) {
    if (!kIsWeb && Platform.isAndroid) {
      // GoogleApiAvailability.instance
      //     .checkGooglePlayServicesAvailability()
      //     .then((value) {
      //   if ([
      //         GooglePlayServicesAvailability.serviceVersionUpdateRequired,
      //         GooglePlayServicesAvailability.success,
      //         GooglePlayServicesAvailability.serviceUpdating
      //       ].contains(value) ||
      //       Platform.isIOS) {
      //     emit(state.copyWith(gsm: true));
      //   }
      // });
    }
  }

  Future<bool> checkIsConnected() async {
    await Future.delayed(const Duration(seconds: 1));
    final isConnected = await connectionChecker.isConnected;

    _showFlashBar(isConnected);
    logger("isConnected $isConnected");
    emit(state.copyWith(connected: isConnected));

    return isConnected;
  }

  bool? _lastConnectionState;
  void _showFlashBar(bool connected) {
    logger(_lastConnectionState);

    // if (connected == _lastConnectionState) {
    //   return;
    // }
    // _lastConnectionState = connected;
    // Flushbar(
    //   flushbarPosition: FlushbarPosition.TOP,
    //   padding: const EdgeInsets.all(20),
    //   message: connected
    //       ? Trans.internetConnectionWasBack.trans()
    //       : Trans.internetConnectionWasLost.trans(),
    //   icon: Icon(Icons.info_outline,
    //       size: 28.0, color: connected ? Colors.green : Colors.red),
    //   duration: const Duration(seconds: 5),
    // ).show(Halper.i.context);
  }

  Connectivity connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _streamSubscription;
  void startListen() {
    checkIsConnected();
    _streamSubscription?.cancel();
    _streamSubscription = connectivity.onConnectivityChanged.listen((event) {
      emit(state.copyWith(connected: false));
      logger("in listen $event ");
      checkIsConnected();
    });
  }
}

class ConnectionStatus {
  final bool connected;
  final bool gsm;

  ConnectionStatus(this.connected, this.gsm);

  ConnectionStatus copyWith({
    bool? connected,
    bool? gsm,
  }) {
    return ConnectionStatus(
      connected ?? this.connected,
      gsm ?? this.gsm,
    );
  }
}
