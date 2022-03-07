import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Requests {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<http.Response> get(String url) async {
    String cookies = await getStoredCookies(getHostname(url));
    return http.get(
      Uri.parse(url),
      headers: cookies.isNotEmpty ? {
        'Cookie': cookies,
      } : null,
    ).timeout(const Duration(seconds: 10));
  }

  static Future<http.Response> post(String url,
      {Map<String, String>? body}) async {
    String cookies = await getStoredCookies(getHostname(url));
    return http.post(
      Uri.parse(url),
      body: body,
      headers: cookies.isNotEmpty ? {
        'Cookie': cookies,
      } : null,
    ).timeout(const Duration(seconds: 10));
  }

  static String getHostname(String url) => Uri.parse(url).host;

  static Future<void> setStoredCookies(String hostname, String cookies) =>
      _storage.write(key: hostname, value: cookies);

  static Future<String> getStoredCookies(String hostname) async =>
      await _storage.read(key: hostname) ?? "";

  static Future<void> clearStoredCookies(String hostname) =>
      _storage.delete(key: hostname);
}
