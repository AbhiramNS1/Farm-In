import 'package:flutter/material.dart';

class FarmInAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FarmInAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Image.asset("assets/app/icon.png"),
      ),
      backgroundColor: const Color.fromARGB(255, 117, 255, 142),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
