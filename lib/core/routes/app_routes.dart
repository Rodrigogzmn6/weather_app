import 'package:go_router/go_router.dart';
import 'package:weather_app/core/routes/routes_path.dart';
import 'package:weather_app/features/location/presentation/screens/welcome_screen.dart';
import 'package:weather_app/features/weather/presentation/screens/home_screen.dart';

final appRoutes = [
  GoRoute(
    path: RoutesPath.home,
    builder: (context, state) => const WelcomeScreen(),
  ),
  GoRoute(
    path: RoutesPath.weather,
    builder: (context, state) => const HomeScreen(),
  ),
];
