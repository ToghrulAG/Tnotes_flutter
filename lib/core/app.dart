import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/theme.dart';
import '../state/settings_controller.dart';
import '../features/home/presentation/home_screen.dart';

class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: lightTheme(),
      darkTheme: darkTheme(),

      home: SplashGate(),
    );
  }
}
//
class SplashGate extends StatefulWidget {
  const SplashGate({super.key});
  @override
  State<SplashGate> createState() => _SplashGateState();
}
//
class _SplashGateState extends State<SplashGate>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  )..forward();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _c, child: const HomeScreen());
  }
}
