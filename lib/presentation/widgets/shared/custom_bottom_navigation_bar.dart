import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final currentIndex = _getCurrentIndex(currentRoute);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onTabTapped(context, index),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.barcode),
          label: 'Escáner',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscador',
        ),
      ],
    );
  }

  int _getCurrentIndex(String? route) {
    switch (route) {
      case '/query':
        return 0;
      case '/search':
        return 1;
      default:
        return 0;
    }
  }

  void _onTabTapped(BuildContext context, int index) {
    String route;
    switch (index) {
      case 0:
        route = '/query';
      case 1:
        route = '/search';
      default:
        route = '/query';
    }

    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute != route) {
      Navigator.pushReplacementNamed(context, route);
    }
  }
}
