import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final serviceProvider = FutureProvider.autoDispose<bool>((ref) async {
  final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  return serviceEnabled ? true : throw ('GPS service is desabled');
});
