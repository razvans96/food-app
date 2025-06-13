import 'package:flutter/material.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final userController = context.watch<UserController>();
    final isLoggedIn = userController.currentUser != null;
    //print('UserController: ${userController.currentUser}');
    return AppBar(
      leading: isLoggedIn
          ? IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            )
          : null,
      title: Text(title),
      actions: [
        if (isLoggedIn)
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Opciones del usuario
            },
          )
        else
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/login');
            },
            child: const Text('Acceso'),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
