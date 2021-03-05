import 'package:flutter/foundation.dart' show kIsWeb;

// ignore: camel_case_types
class env {
  static String apiUrl = kIsWeb ? "http://localhost:8000" : "http://192.168.1.40:8000";
}