import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/core/routes/app_routes.dart';
import 'package:weather_app/core/routes/routes_path.dart';

final routesProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RoutesPath.home,
    routes: appRoutes,
  );
});
