import 'package:farm_in/Pages/settings.dart';
import 'package:flutter/material.dart';

class FarmInAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FarmInAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        InkWell(
          child: Icon(Icons.settings),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => SettingsPage()));
          },
        ),
      ],
      leading: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Image.asset("assets/app/icon.png"),
      ),
      title: Text(
        "Farm In",
      ),
      foregroundColor: Colors.black,
      backgroundColor: Colors.green,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
