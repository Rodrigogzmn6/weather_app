import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/features/location/presentation/provider/permission_provider.dart';
import 'package:weather_app/features/location/presentation/provider/service_provider.dart';
import 'package:weather_app/features/location/presentation/widgets/welcome_widget.dart';
import 'package:weather_app/features/weather/presentation/screens/home_screen.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  _showSnackBar(message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$message'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final service = ref.watch(serviceProvider);
    final permission = ref.watch(permissionProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.kBackgroundColor,
        body: service.when(
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) {
            _showSnackBar(error);
            return WelcomeWidget(
                handleOnPressed: () => ref.refresh(serviceProvider.future));
          },
          data: (data) {
            return permission.when(
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) {
                _showSnackBar(error);
                return WelcomeWidget(
                  handleOnPressed: () {
                    ref.refresh(serviceProvider.future);
                    ref.refresh(permissionProvider.future);
                  },
                );
              },
              data: (data) => const HomeScreen(),
            );
          },
        ),
      ),
    );
  }
}
