import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectionCheckPage extends StatelessWidget {
  final Widget page;
  final bool hideAppBar;

  const ConnectionCheckPage({super.key, required this.page, required this.hideAppBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == ConnectivityResult.mobile || snapshot.data == ConnectivityResult.wifi || snapshot.data == ConnectivityResult.ethernet) {
              return page;
            }
          }
          return Scaffold(
            appBar: hideAppBar ? null : AppBar(),
            body: Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20.0),
                  Text("Trying to regain connection...")
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
