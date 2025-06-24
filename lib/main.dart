import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:food_app/firebase_options.dart';
import 'package:food_app/presentation/pages/product_query_page.dart';
import 'package:food_app/presentation/pages/product_search_page.dart';
import 'package:food_app/presentation/pages/user_login_page.dart';
import 'package:food_app/presentation/pages/user_register_page.dart';
import 'package:food_app/presentation/theme/app_theme.dart';
import 'package:food_app/presentation/view_models/authentication_view_model.dart';
import 'package:food_app/shared/config/dependency_injection.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: './.env');

  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kIsWeb) {
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
    );
    await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
  }

  final authViewModel = getIt<AuthenticationViewModel>();
  final initialRoute = await authViewModel.getInitialRoute();

  runApp(
    MyApp(initialRoute: initialRoute),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required this.initialRoute, super.key});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: getIt<AuthenticationViewModel>(),
        child: MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('es', ''),
          ],
          title: 'Food App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          initialRoute: initialRoute,
          routes: {
            '/login': (context) => const UserLoginPage(),
            '/register': (context) => const UserRegisterPage(),
            '/query': (context) => const ProductQueryPage(),
            '/search': (context) => const ProductSearchPage(),
          },
        ));
  }
}
