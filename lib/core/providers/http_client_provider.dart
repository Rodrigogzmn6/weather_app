import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final clientProvider = Provider<http.Client>((ref) {
  return http.Client();
});
