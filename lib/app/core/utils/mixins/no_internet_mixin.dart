import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../packages/network/network_status/network_status.dart';
import '../../shared/presentation/controllers/states/global_states/no_internet_connection_state.dart';
import '../../shared/presentation/widgets/guide_snack_bar.dart';

mixin NoInternetMixin<T extends StatefulWidget> on State<T> {
  late StreamSubscription networkServiceStreamSubscription;

  @override
  void initState() {
    super.initState();
    networkServiceStreamSubscription =
        Modular.get<NetworkServiceImplementation>()
            .connectivity
            .onConnectivityChanged
            .listen(
      (connectivityEvent) {
        if (connectivityEvent == ConnectivityResult.none) {
          GuideSnackBar.showSnackBar(context, NoInternetConnectionState());
        } else {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }
      },
    );
  }

  @override
  void dispose() {
    networkServiceStreamSubscription.cancel();
    super.dispose();
  }
}
