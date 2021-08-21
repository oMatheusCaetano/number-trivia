import 'package:data_connection_checker/data_connection_checker.dart';

class NetworkInfo {
  final DataConnectionChecker connectionChecker;
  
  NetworkInfo({required this.connectionChecker});

  Future<bool> get isConnected async {
    return this.connectionChecker.hasConnection;
  }
}
