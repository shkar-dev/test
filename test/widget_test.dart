import 'package:flutter_test/flutter_test.dart';
import 'package:ios1test/main.dart';

void main() {
  testWidgets('iOS Cupertino app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CupertinoMainApp());

    // Verify that the Today tab bar item and title exist.
    expect(find.text('Today'), findsWidgets);
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('Controls'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });
}
