// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/error/show_snackbar.dart';
import 'package:weather_app/core/widgets/error_widget.dart';
import 'package:weather_app/core/widgets/widgets.dart';
import 'package:weather_app/features/location/presentation/provider/providers.dart';
import 'package:weather_app/features/weather/presentation/screens/home_screen.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final service = ref.watch(serviceProvider);
    final permission = ref.watch(permissionProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.kBackgroundColor,
        body: service.when(
          loading: () => const LoadingWidget(),
          error: (error, stack) {
            showSnackBar(context, error);
            return ErrorMessageWidget(
              title: 'Welcome',
              handleOnPressed: () => ref.refresh(serviceProvider.future),
            );
          },
          data: (serviceData) {
            return permission.when(
              loading: () => const LoadingWidget(),
              error: (error, stack) {
                showSnackBar(context, error);
                return ErrorMessageWidget(
                  title: 'Welcome',
                  handleOnPressed: () {
                    ref.refresh(serviceProvider.future);
                    ref.refresh(permissionProvider.future);
                  },
                );
              },
              data: (permissionData) {
                return const HomeScreen();
              },
            );
          },
        ),
      ),
    );
  }
}
