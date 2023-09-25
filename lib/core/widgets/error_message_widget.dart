// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/constants.dart';

class ErrorMessageWidget extends StatelessWidget {
  final Function handleOnPressed;
  final Function? handleAction;
  final String message;

  const ErrorMessageWidget(
      {Key? key,
      required this.handleOnPressed,
      required this.message,
      this.handleAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: handleAction != null
          ? AppBar(
              actions: [
                IconButton(
                    onPressed: () => handleAction!(),
                    icon: const Icon(Icons.delete_outline))
              ],
              backgroundColor: Constants.kAppBarBackgroundColor,
            )
          : null,
      backgroundColor: Constants.kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Error.png',
              width: 100.0,
            ),
            const SizedBox(height: 20.0),
            Text(
              message,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () => handleOnPressed(),
              icon: const Icon(Icons.replay_rounded),
              label: const Text('Try Again'),
            )
          ],
        ),
      ),
    );
  }
}
