import "package:flutter/material.dart";
import 'package:flutter_provider_mvvm/core/routing/ErrorRoute.dart';
import 'package:flutter_provider_mvvm/views/login_view.dart';
import 'package:flutter_provider_mvvm/views/signup_view.dart';
import 'package:page_transition/page_transition.dart';


class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    print("these are arguments ${settings.arguments}");
    print("these are arguments ${settings.name}");
    switch (settings.name) {
      case '/signin':
        return PageTransition(
            child: LoginView(), type: PageTransitionType.rightToLeft);

      case '/register':
        return PageTransition(
            child: SignupView(), type: PageTransitionType.rightToLeft);

      // case '/home':
      //   return PageTransition(
      //       child: MainPage(), type: PageTransitionType.rightToLeft);

      // case '/chatScreen':
      //   {
      //     Map<String, dynamic>? params = args as Map<String, dynamic>?;
      //     return PageTransition(
      //         child: ListenableProvider<MainProvider>.value(
      //           value: params!["groupListProvider"],
      //           child: ChatPage(),
      //         ),
      //         type: PageTransitionType.rightToLeft);
      //   }

      default:
        return MaterialPageRoute(
            builder: (_) => ErrorRoute(routename: settings.name));
    }
  }
}
