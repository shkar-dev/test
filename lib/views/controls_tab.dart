import 'package:flutter/cupertino.dart';

class ControlsTab extends StatefulWidget {
  const ControlsTab({super.key});

  @override
  State<ControlsTab> createState() => _ControlsTabState();
}

class _ControlsTabState extends State<ControlsTab> {
  bool _switchVal1 = true;
  bool _switchVal2 = false;
  double _sliderVal = 45.0;
  DateTime _selectedDate = DateTime.now();
  Duration _selectedDuration = const Duration(minutes: 15);
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 280,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    child: const Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: _selectedDate,
                  mode: CupertinoDatePickerMode.dateAndTime,
                  use24hFormat: false,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() => _selectedDate = newDate);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTimerPicker(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 260,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    child: const Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoTimerPicker(
                  initialTimerDuration: _selectedDuration,
                  onTimerDurationChanged: (Duration newDuration) {
                    setState(() => _selectedDuration = newDuration);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Confirm Action'),
        content: const Text('This is a native iOS Cupertino Alert Dialog with standard iOS button styling.'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('Delete'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('iOS Controls'),
      ),
      child: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            CupertinoListSection.insetGrouped(
              header: const Text('INTERACTIVE SWITCHES & SLIDERS'),
              children: [
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.bell_fill, color: CupertinoColors.systemRed),
                  title: const Text('Push Notifications'),
                  trailing: CupertinoSwitch(
                    value: _switchVal1,
                    onChanged: (bool value) {
                      setState(() => _switchVal1 = value);
                    },
                  ),
                ),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.location_fill, color: CupertinoColors.systemBlue),
                  title: const Text('Location Services'),
                  trailing: CupertinoSwitch(
                    value: _switchVal2,
                    onChanged: (bool value) {
                      setState(() => _switchVal2 = value);
                    },
                  ),
                ),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.speaker_2_fill, color: CupertinoColors.systemTeal),
                  title: Text('Volume Level (${_sliderVal.round()}%)'),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CupertinoSlider(
                      value: _sliderVal,
                      min: 0.0,
                      max: 100.0,
                      divisions: 100,
                      onChanged: (double value) {
                        setState(() => _sliderVal = value);
                      },
                    ),
                  ),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: const Text('PICKERS & MODALS'),
              children: [
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.calendar, color: CupertinoColors.systemOrange),
                  title: const Text('Date & Time Picker'),
                  subtitle: Text(
                    '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')} ${_selectedDate.hour.toString().padLeft(2, '0')}:${_selectedDate.minute.toString().padLeft(2, '0')}',
                  ),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => _showDatePicker(context),
                ),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.timer, color: CupertinoColors.systemPurple),
                  title: const Text('Timer Duration Picker'),
                  subtitle: Text(
                    '${_selectedDuration.inHours}h ${_selectedDuration.inMinutes.remainder(60)}m',
                  ),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => _showTimerPicker(context),
                ),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.exclamationmark_triangle_fill, color: CupertinoColors.systemYellow),
                  title: const Text('Show iOS Alert Dialog'),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => _showAlertDialog(context),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: const Text('TEXT INPUT & BUTTONS'),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: CupertinoTextField(
                    controller: _inputController,
                    placeholder: 'Enter your note or message...',
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(CupertinoIcons.pencil, color: CupertinoColors.systemGrey),
                    ),
                    clearButtonMode: OverlayVisibilityMode.editing,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoButton.filled(
                          onPressed: () {
                            if (_inputController.text.isNotEmpty) {
                              _showAlertDialog(context);
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      CupertinoButton(
                        color: CupertinoColors.systemGrey5,
                        onPressed: () {
                          _inputController.clear();
                        },
                        child: Text(
                          'Clear',
                          style: TextStyle(
                            color: CupertinoColors.label.resolveFrom(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: const Text('ACTIVITY INDICATORS'),
              children: const [
                CupertinoListTile(
                  leading: CupertinoActivityIndicator(radius: 12),
                  title: Text('Standard Activity Indicator'),
                  subtitle: Text('Animating smooth iOS spinner'),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
