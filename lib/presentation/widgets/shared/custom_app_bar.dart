import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/presentation/view_models/authentication_view_model.dart';
import 'package:food_app/presentation/view_models/states/authentication_state.dart';
import 'package:food_app/shared/config/dependency_injection.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: getIt<AuthenticationViewModel>(),
      child: Consumer<AuthenticationViewModel>(
        builder: (context, authViewModel, _) {
          return AppBar(
            leading: _buildLeading(context, authViewModel.state),
            title: Text(title),
            actions: _buildActions(context, authViewModel.state),
          );
        },
      ),
    );
  }

  Widget? _buildLeading(BuildContext context, AuthenticationState state) {
    return switch (state) {
      Authenticated() => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ProfileIncomplete() => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      _ => null,
    };
  }

  List<Widget> _buildActions(BuildContext context, AuthenticationState state) {
    return switch (state) {
      Authenticated(:final user) => [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              final authViewModel = context.read<AuthenticationViewModel>();
              _showUserMenu(context, authViewModel, user);
            },
          ),
        ],
      ProfileIncomplete(:final user) => [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              final authViewModel = context.read<AuthenticationViewModel>();
              _showUserMenu(context, authViewModel, user);
            },
          ),
        ],
      Guest() => [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/login');
            },
            child: const Text('Acceso'),
          ),
        ],
      Checking() => [
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 16),
        ],
    };
  }

  void _showUserMenu(
    BuildContext context, 
    AuthenticationViewModel authViewModel,
    User user,
  ) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
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
              
              if (user.email != null) ...[
                ListTile(
                  leading: const Icon(Icons.email),
                  title: Text(user.email!),
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 8),
              ],

              if (authViewModel.state is ProfileIncomplete) ...[
                ListTile(
                  leading: const Icon(Icons.warning, color: Colors.orange),
                  title: const Text('Perfil incompleto'),
                  subtitle: const Text('Completa tu perfil para acceder a todas las funciones'),
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/register');
                  },
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
