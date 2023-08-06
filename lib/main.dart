import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './utils/app_theme.dart';
import './views/tasks_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: CustomTheme.appTheme(),
        darkTheme: CustomTheme.appTheme(isDark: true),
        home: const TasksScreen(),
      ),
    );
  }
}
