import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService {
  late StreamSubscription subscription;
  late bool isConnected;
  getConnectivity(BuildContext context) => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isConnected = await InternetConnectionChecker().hasConnection;
        if (!isConnected && result == ConnectivityResult.wifi) {
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('No connection'),
              content:
                  const Text('Please check the connection to the internet'),
              actions: [
                CupertinoButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            ),
          );
        }
      });
}
