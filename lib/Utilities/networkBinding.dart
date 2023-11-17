import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetxNetworkManager>(() => GetxNetworkManager());
  }
}

class GetxNetworkManager extends GetxController {
  int connectionType = 0;

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    getConnectionType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> getConnectionType() async {
    var connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return _updateState(connectivityResult);
  }

  bool isDialogShowing = false;

  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        {
          connectionType = 1;
          update();
          if (isDialogShowing) {
            Navigator.of(Get.overlayContext!).pop();
            isDialogShowing = false;
          }
          break;
        }
      case ConnectivityResult.mobile:
        {
          connectionType = 2;
          update();
          if (isDialogShowing) {
            Navigator.of(Get.overlayContext!).pop();
            isDialogShowing = false;
          }
          break;
        }
      case ConnectivityResult.none: {
        connectionType = 0;
        update();
        if (!isDialogShowing) {
          showDialog(
            context: Get.overlayContext!,
            barrierDismissible: false,
            builder: (BuildContext context) {
              isDialogShowing = true;
              return WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  title: Text('No Internet Connection'),
                  content: Text('Please connect to the internet.'),
                  actions: [
                    TextButton(
                      child: Text('Exit'),
                      onPressed: () {
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        } else if (Platform.isIOS) {
                          exit(0);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
        break;
      }
      default:
        Get.snackbar("Network Error", "Please Connect to the Internet");
    }
  }

  @override
  void onClose() {}
}
