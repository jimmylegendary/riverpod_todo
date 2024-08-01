import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/model/navigated_pages.dart';

final NavigatedPageProvider =
    NotifierProvider<NavigatedPageViewModel, NavigatedPages>((ref) {
  return NavigatedPageViewModel();
});

class NavigatedPageViewModel extends Notifier<NavigatedPages> {
  @override
  NavigatedPages build() {
    return NavigatedPages(title: "", widget: Container());
  }
}
