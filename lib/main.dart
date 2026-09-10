import 'package:flutter/cupertino.dart';
import 'theme_notifier.dart';
import 'views/controls_tab.dart';
import 'views/explore_tab.dart';
import 'views/home_tab.dart';
import 'views/settings_tab.dart';

void main() {
  runApp(const CupertinoMainApp());
}

class CupertinoMainApp extends StatefulWidget {
  const CupertinoMainApp({super.key});

  @override
  State<CupertinoMainApp> createState() => _CupertinoMainAppState();
}

class _CupertinoMainAppState extends State<CupertinoMainApp> {
  final CupertinoThemeNotifier _themeNotifier = CupertinoThemeNotifier();

  @override
  void initState() {
    super.initState();
    _themeNotifier.addListener(_handleThemeChange);
  }

  void _handleThemeChange() {
    setState(() {});
  }

  @override
  void dispose() {
    _themeNotifier.removeListener(_handleThemeChange);
    _themeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'iOS Cupertino Demo',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: _themeNotifier.isSystemTheme ? null : _themeNotifier.brightness,
        primaryColor: CupertinoColors.systemBlue,
        scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      ),
      home: MainNavigationScreen(themeNotifier: _themeNotifier),
    );
  }
}

class MainNavigationScreen extends StatelessWidget {
  final CupertinoThemeNotifier themeNotifier;

  const MainNavigationScreen({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.today),
            activeIcon: Icon(CupertinoIcons.today_fill),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.compass),
            activeIcon: Icon(CupertinoIcons.compass_fill),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.slider_horizontal_3),
            label: 'Controls',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gear_alt),
            activeIcon: Icon(CupertinoIcons.gear_alt_fill),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (BuildContext context) => const HomeTab(),
            );
          case 1:
            return CupertinoTabView(
              builder: (BuildContext context) => const ExploreTab(),
            );
          case 2:
            return CupertinoTabView(
              builder: (BuildContext context) => const ControlsTab(),
            );
          case 3:
            return CupertinoTabView(
              builder: (BuildContext context) => SettingsTab(themeNotifier: themeNotifier),
            );
          default:
            return CupertinoTabView(
              builder: (BuildContext context) => const HomeTab(),
            );
        }
      },
    );
  }
}
