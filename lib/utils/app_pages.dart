import '../all_packages.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.splash1, page: () => SplashView(index: 1)),
    GetPage(name: Routes.splash2, page: () => SplashView(index: 2)),
    GetPage(name: Routes.splash3, page: () => SplashView(index: 3)),
    GetPage(name: Routes.splash4, page: () => SplashView(index: 4)),
    GetPage(name: Routes.register, page: () => RegisterView()),
    GetPage(name: Routes.login, page: () => LoginView()),
    GetPage(name: Routes.home, page: () => HomeView()),
    GetPage(name: Routes.game, page: () => const GameView()),
  ];
}
