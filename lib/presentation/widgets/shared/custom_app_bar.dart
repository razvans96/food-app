import 'package:flutter/material.dart';
import 'package:food_app/presentation/view_models/auth_view_model.dart';
import 'package:food_app/shared/config/dependency_injection.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: getIt<AuthViewModel>(),
      child: Consumer<AuthViewModel>(
        builder: (context, authViewModel, _) {
          final isLoggedIn = authViewModel.currentUser != null;
          
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
                    _showUserMenu(context, authViewModel);
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
        },
      )
    );
  }

  void _showUserMenu(BuildContext context, AuthViewModel authViewModel) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final user = authViewModel.currentUser;
        
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Usuario',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              if (user?.email != null) ...[
                ListTile(
                  leading: const Icon(Icons.email),
                  title: Text(user!.email!),
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 8),
              ],
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Cerrar sesión'),
                contentPadding: EdgeInsets.zero,
                onTap: () async {
                  Navigator.of(context).pop();
                  await authViewModel.signOut();
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil('/query', (route) => false);
                  }
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
