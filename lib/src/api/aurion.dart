import 'package:edt_isen/src/common/requests.dart';
import 'package:http/http.dart';
import 'package:edt_isen/src/utils/secure_storage.dart';
import 'package:edt_isen/src/common/exceptions.dart';

class Aurion {
  static String _fetchViewState(Response response) {
    return RegExp(r'name="javax\.faces\.ViewState".*?value="([^"]*)')
        .firstMatch(response.body)!
        .group(1)!;
  }

  static String _fetchDefaultParam(Response response) {
    return RegExp(
            r'id="([^"]*)"\s*?(?=class="schedule")|(?<=class="schedule")\s*?id="([^"]*)"')
        .firstMatch(response.body)!
        .group(1)!;
  }

  static String _fetchName(Response response) {
    return RegExp(r'role="menu".*?<h3>(.*?)<\/h3>')
        .firstMatch(response.body)!
        .group(1)!;
  }

  static bool _credentialVerification(Response response) {
    return RegExp(r'Planning').hasMatch(response.body);
  }

  static Future<bool> login(String username, String password) async {
    const String url = "https://web.isen-ouest.fr/webAurion/login";
    final String hostname = Requests.getHostname(url);

    Response response = await Requests.get(url);

    // Check if the connexion token is still usable
    if (!_credentialVerification(response)) {
      // Clear the dead token
      await Requests.clearStoredCookies(hostname);

      // Make a request to get a fresh token
      response = await Requests.post(
        url,
        body: {
          "username": username,
          "password": password,
        },
      );
      if (response.headers.containsKey("Cookie")) {
        return false;
      }
      Requests.setStoredCookies(hostname, response.headers["Cookie"]!);
    }

    // Saving everything in secure storage
    SecureStorage.setName(_fetchName(response));
    SecureStorage.setUsername(username);
    SecureStorage.setPassword(password);

    return true;
  }

  static Future<bool> logout() async {
    try {
      SecureStorage.deleteName();
      SecureStorage.deletePassword();
      SecureStorage.deleteSchedule();
    } catch (e) {
      return false;
    }
    return true;
  }

  static Future<void> fetchSchedule() async {
    Response response =
    await Requests.get("https://web.isen-ouest.fr/webAurion/");

    // get a range of [-5:5] weeks from present day
    int timeStampStart = DateTime
        .now()
        .subtract(Duration(days: 35 + DateTime
        .now()
        .weekday))
        .millisecondsSinceEpoch;
    int timeStampEnd = DateTime
        .now()
        .add(Duration(days: 35 - DateTime
        .now()
        .weekday - 1))
        .millisecondsSinceEpoch;

    // Set the hellish parameters
    String viewState = _fetchViewState(response);
    String defaultParam = _fetchDefaultParam(response);
    Map<String, String> parameters = {
      "javax.faces.partial.ajax": "true",
      "javax.faces.source": defaultParam,
      "javax.faces.partial.execute": defaultParam,
      "javax.faces.partial.render": defaultParam,
      defaultParam: defaultParam,
      "${defaultParam}_start": timeStampStart.toString(),
      "${defaultParam}_end": timeStampEnd.toString(),
      "form": "form",
      "javax.faces.ViewState": viewState,
    };

    // Now retrieves the default Aurion page
    response = await Requests.post(
      "https://web.isen-ouest.fr/webAurion/faces/MainMenuPage.xhtml",
      body: parameters,
    );

    // Finally get the schedule from the "Planning" widget
    try {
      String schedule = RegExp(r'"events".*?(\[(?:.|\s)*?\])')
          .firstMatch(response.body)!
          .group(1)!;
      SecureStorage.setSchedule(schedule);
    }
    catch (e) {
      throw WidgetNotFound();
    }
  }
}
