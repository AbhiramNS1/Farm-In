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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Conform'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Go to settings',
                  onPressed: () {},
                ),
              ),
            );
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
