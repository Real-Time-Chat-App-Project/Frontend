import 'package:flutter/cupertino.dart';
import 'package:real_time_chat_app/core/init/navigation/INavigation_service.dart';

class NavigationService implements INavigationService {
  //
  static NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;

  NavigationService._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Future<void> navigateToPage(
      {required String path, required Object data}) async {
    await navigatorKey.currentState!.pushNamed(path, arguments: data);
  }
}
