import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/core/constants/constants.dart';

class WelcomeWidget extends StatelessWidget {
  final Function handleOnPressed;
  const WelcomeWidget({super.key, required this.handleOnPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome',
            style: GoogleFonts.dancingScript(
              textStyle: const TextStyle(
                color: Constants.kTextColor,
                fontSize: 70.0,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => handleOnPressed(),
            style: const ButtonStyle(),
            child: const Text('Let\'s Go!'),
          ),
        ],
      ),
    );
  }
}
