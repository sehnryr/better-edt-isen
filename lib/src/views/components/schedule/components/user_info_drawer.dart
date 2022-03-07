import 'package:flutter/material.dart';
import 'package:edt_isen/src/api/aurion.dart';
import 'package:edt_isen/src/common/create_route.dart';
import 'package:edt_isen/src/views/pages/login.dart';

class UserInfoDrawer extends StatelessWidget {
  const UserInfoDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        bottomNavigationBar: TextButton(
          child: const Text("DÉCONNEXION"),
          style: TextButton.styleFrom(
            fixedSize: const Size(double.infinity, 60.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0)),
            primary: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            Aurion.logout();
            Navigator.of(context).pushReplacement(createRoute(
              const LoginScreen(),
              Direction.fromLeft,
            ));
          },
        ),
      ),
    );
  }
}
