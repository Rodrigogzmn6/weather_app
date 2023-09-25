import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Constants.kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.orangeAccent,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              Constants.loadingText,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
