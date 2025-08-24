import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/hive/hive_init.dart';
import 'package:hive/hive.dart';

class ThemeModeController extends StateNotifier<ThemeMode> {
  ThemeModeController() : super(ThemeMode.system) {
    _load();
  }
  static const _key = 'theme_mode';

  Future<void> _load() async {
    final box = Hive.box(settingsBoxKey);

    final value = box.get(_key) as String?;

    if (value == 'light') state = ThemeMode.light;
    if (value == 'dark') state = ThemeMode.dark;
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;

    final box = Hive.box(settingsBoxKey);

    await box.put(_key, switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      _ => 'system',
    });
  }
}
