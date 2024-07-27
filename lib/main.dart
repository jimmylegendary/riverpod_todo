import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/common/app_router.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Flutter MVVM Demo',
      theme: FlexColorScheme.light(scheme: FlexScheme.flutterDash).toTheme,
      darkTheme: FlexColorScheme.dark(scheme: FlexScheme.red).toTheme,
      themeMode: ThemeMode.light,
    );
  }
}
