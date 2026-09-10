import 'package:flutter/cupertino.dart';
import '../theme_notifier.dart';

class SettingsTab extends StatefulWidget {
  final CupertinoThemeNotifier themeNotifier;

  const SettingsTab({super.key, required this.themeNotifier});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _airplaneMode = false;
  bool _wifi = true;
  bool _bluetooth = true;
  bool _vpn = false;

  void _showAboutDialog(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('About iOS Cupertino Project'),
        content: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            'Version 1.0.0 (Build 1)\n\nBuilt with Flutter & Cupertino Widgets to provide an authentic Apple iOS experience.',
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeNotifier.isSystemTheme
        ? MediaQuery.of(context).platformBrightness == Brightness.dark
        : widget.themeNotifier.brightness == Brightness.dark;

    return CupertinoPageScaffold(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Settings'),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Apple ID Profile Header
                CupertinoListSection.insetGrouped(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  children: [
                    CupertinoListTile(
                      leadingSize: 50,
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [CupertinoColors.systemTeal, CupertinoColors.systemIndigo],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'JD',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      title: const Text(
                        'John Doe',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      subtitle: const Text('Apple ID, iCloud, Media & Purchases'),
                      trailing: const CupertinoListTileChevron(),
                    ),
                  ],
                ),

                // Connectivity Section
                CupertinoListSection.insetGrouped(
                  children: [
                    CupertinoListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemOrange,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(CupertinoIcons.airplane, color: CupertinoColors.white, size: 18),
                      ),
                      title: const Text('Airplane Mode'),
                      trailing: CupertinoSwitch(
                        value: _airplaneMode,
                        onChanged: (val) => setState(() => _airplaneMode = val),
                      ),
                    ),
                    CupertinoListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemBlue,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(CupertinoIcons.wifi, color: CupertinoColors.white, size: 18),
                      ),
                      title: const Text('Wi-Fi'),
                      additionalInfo: Text(_wifi ? 'Home_5G' : 'Off'),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () => setState(() => _wifi = !_wifi),
                    ),
                    CupertinoListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemBlue,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(CupertinoIcons.bluetooth, color: CupertinoColors.white, size: 18),
                      ),
                      title: const Text('Bluetooth'),
                      additionalInfo: Text(_bluetooth ? 'On' : 'Off'),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () => setState(() => _bluetooth = !_bluetooth),
                    ),
                    CupertinoListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemBlue,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(CupertinoIcons.shield_fill, color: CupertinoColors.white, size: 18),
                      ),
                      title: const Text('VPN'),
                      additionalInfo: Text(_vpn ? 'Connected' : 'Not Connected'),
                      trailing: CupertinoSwitch(
                        value: _vpn,
                        onChanged: (val) => setState(() => _vpn = val),
                      ),
                    ),
                  ],
                ),

                // Appearance & Display
                CupertinoListSection.insetGrouped(
                  header: const Text('APPEARANCE & DISPLAY'),
                  children: [
                    CupertinoListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemIndigo,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(CupertinoIcons.moon_fill, color: CupertinoColors.white, size: 18),
                      ),
                      title: const Text('Dark Mode'),
                      trailing: CupertinoSwitch(
                        value: isDark,
                        onChanged: (val) {
                          widget.themeNotifier.setBrightness(
                            val ? Brightness.dark : Brightness.light,
                          );
                        },
                      ),
                    ),
                    CupertinoListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemPurple,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(CupertinoIcons.device_phone_portrait, color: CupertinoColors.white, size: 18),
                      ),
                      title: const Text('Match System Theme'),
                      trailing: CupertinoSwitch(
                        value: widget.themeNotifier.isSystemTheme,
                        onChanged: (val) {
                          widget.themeNotifier.setUseSystem(
                            val,
                            MediaQuery.of(context).platformBrightness,
                          );
                        },
                      ),
                    ),
                  ],
                ),

                // General & Info
                CupertinoListSection.insetGrouped(
                  header: const Text('GENERAL'),
                  children: [
                    CupertinoListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(CupertinoIcons.info_circle_fill, color: CupertinoColors.white, size: 18),
                      ),
                      title: const Text('About'),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () => _showAboutDialog(context),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
