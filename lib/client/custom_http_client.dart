import 'dart:io' show Platform;
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:http/http.dart' as http;

class CustomHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final token = await FirebaseAppCheck.instance.getToken();
    if (token != null) {
      request.headers['X-Firebase-AppCheck'] = token;
    }

    if (Platform.isAndroid) {
      request.headers['X-App-Platform'] = 'android';
    } else if (Platform.isIOS) {
      request.headers['X-App-Platform'] = 'ios';
    } else {
      request.headers['X-App-Platform'] = 'web';
    }

    return _inner.send(request);
  }
}
