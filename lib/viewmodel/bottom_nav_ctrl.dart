import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_todo/common/app_router.dart';

final navigationIndexProvider = NotifierProvider<NavigationViewModel, int>(() {
  return NavigationViewModel();
});

class NavigationViewModel extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void movePage(GoRouterState routerState) {
    switch (routerState.matchedLocation) {
      case '/todos':
        state = 0;
        break;
      case '/history':
        state = 1;
        break;
      case '/settings':
        state = 2;
        break;
    }
  }
}
