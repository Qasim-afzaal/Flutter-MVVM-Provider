
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_provider_mvvm/core/routing/routes.dart';
import 'package:flutter_provider_mvvm/core/theme/theme_light.dart';
import 'package:flutter_provider_mvvm/view_models/auth_view_model.dart';
import 'package:flutter_provider_mvvm/views/home_view.dart';
import 'package:flutter_provider_mvvm/views/login_view.dart';
import 'package:flutter_provider_mvvm/views/signup_view.dart';
import 'package:flutter_provider_mvvm/views/splash_screen.dart';

import 'package:provider/provider.dart';

GlobalKey<ScaffoldMessengerState>? rootScaffoldMessengerKey;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..isUserLogedIn()),
  
      ],
      child: MaterialApp(
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeLight().theme,
        onGenerateRoute: Routers.generateRoute,
        home: Scaffold(
          body: Consumer<AuthProvider>(
            builder: (context, auth, child) {
              switch (auth.loggedInStatus) {
                case Status.Authenticating:
                  return SplashView();
                case Status.LoggedInHome:
                  return HomeView();
            
                case Status.LoggedOut:
                  return LoginView();
                case Status.Registered:
                  return SignupView();
               
                default:
                  return LoginView();
              }
            },
          ),
        ),
      ),
    );
  }
}
