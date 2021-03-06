import 'package:flutter/cupertino.dart';
import 'package:shopuo/Components/BottomNavComponent.dart';

class NavigationService {
  TabItem currentTab = TabItem.One;

  Map<TabItem, GlobalKey<NavigatorState>> tabKey = {
    TabItem.One: GlobalKey<NavigatorState>(),
    TabItem.Two: GlobalKey<NavigatorState>(),
    TabItem.Three: GlobalKey<NavigatorState>(),
    TabItem.Four: GlobalKey<NavigatorState>(),
  };

  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void pop() {
    return _navigatorKey.currentState.pop();
  }

  void popInner() {
    return tabKey[currentTab].currentState.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) async {
    return await _navigatorKey.currentState.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> navigateInner(
    String routeName, {
    dynamic arguments,
  }) async {
    return await tabKey[currentTab].currentState.pushNamed(
          routeName,
          arguments: arguments,
        );
  }

  Future<dynamic> navigateInnerAndClear(
    String routeName, {
    dynamic arguments,
  }) async {
    return await tabKey[currentTab].currentState.pushNamedAndRemoveUntil(
          routeName,
          (Route<dynamic> route) => false,
          arguments: arguments,
        );
  }

  Future<dynamic> navigateToAndClear(
    String routeName, {
    dynamic arguments,
  }) async {
    return await _navigatorKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }
}
