// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:weather_app/core/constants/constants.dart';

class ErrorMessageWidget extends StatelessWidget {
  final Function handleOnPressed;
  final String? title;

  const ErrorMessageWidget(
      {Key? key, required this.handleOnPressed, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          title != null
              ? Text(
                  'Welcome',
                  style: GoogleFonts.dancingScript(
                    textStyle: const TextStyle(
                      color: Constants.kTextColor,
                      fontSize: 70.0,
                    ),
                  ),
                )
              : Container(),
          ElevatedButton(
            onPressed: () => handleOnPressed(),
            style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Constants.kTextColor)),
            child: const Text('Try Again.'),
          ),
        ],
      ),
    );
  }
}
