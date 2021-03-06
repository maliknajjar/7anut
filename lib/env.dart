import 'package:flutter/foundation.dart' show kIsWeb;

// ignore: camel_case_types
class env {
  static String apiUrl = kIsWeb 
  ? "http://localhost"         // for the web wich is in the same server location
  : "http://192.168.1.40";     // in the device
}