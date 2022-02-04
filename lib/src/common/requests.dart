import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Requests {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static String _stringifyCookies(Map<String, String> cookies) =>
      cookies.entries.map((e) => '${e.key}=${e.value}').join('; ');

  static Future<http.Response> get(String url) async {
    Map<String, String> cookies = await getStoredCookies(getHostname(url));
    return http.get(
      Uri.parse(url),
      headers: {
        'Cookie': _stringifyCookies(cookies),
      },
    );
  }

  static Future<http.Response> post(String url,
      {Map<String, String>? body}) async {
    Map<String, String> cookies = await getStoredCookies(getHostname(url));
    return http.post(
      Uri.parse(url),
      body: body,
      headers: {
        'Cookie': _stringifyCookies(cookies),
      },
    );
  }

  static String getHostname(String url) => Uri.parse(url).host;

  static Future<void> setStoredCookies(String hostname, Object cookies) =>
      _storage.write(key: hostname, value: json.encode(cookies));

  static Future<Map<String, String>> getStoredCookies(String hostname) async =>
      json.decode(await _storage.read(key: hostname) ?? "{}");

  static Future<void> clearStoredCookies(String hostname) =>
      _storage.delete(key: hostname);
}
