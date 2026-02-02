import 'package:app/core/network_checker/connection_checker.dart';
import 'package:app/core/shared/imports.dart';

Future<DataSource> makeListDecision(
  DataSource source,
) async {
  final connectionChecker = sl<ConnectionChecker>();
  // return DataSource.local;

  if (source.isRemote) {
    return source;
  } else if (source.isLocal) {
    return source;
  } else {
    bool isConnected = await connectionChecker.isConnected;
    if (isConnected) {
      return DataSource.remote;
    }
    return DataSource.local;
  }
}
