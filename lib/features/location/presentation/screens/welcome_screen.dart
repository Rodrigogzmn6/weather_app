// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/widgets/widgets.dart';
import 'package:weather_app/features/location/presentation/provider/providers.dart';
import 'package:weather_app/features/weather/presentation/screens/home_screen.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(serviceProvider);
    final permission = ref.watch(permissionProvider);

    void checkServices() {
      ref.refresh(serviceProvider);
      ref.refresh(permissionProvider);
    }

    return service.when(
      loading: () => const LoadingWidget(),
      error: (error, stack) => ErrorMessageWidget(
        message: error.toString(),
        handleOnPressed: checkServices,
      ),
      data: (serviceData) {
        return permission.when(
          loading: () => const LoadingWidget(),
          error: (error, stack) => ErrorMessageWidget(
            message: error.toString(),
            handleOnPressed: checkServices,
          ),
          data: (permissionData) => const HomeScreen(),
        );
      },
    );
  }
}
