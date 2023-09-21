import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  // final SharedPreferences sharedPreferences =
  //     await SharedPreferences.getInstance();
  // return sharedPreferences;

  try {
    return await SharedPreferences.getInstance();
  } catch (e) {
    throw ('Something went wrong with your local storage');
  }
});
