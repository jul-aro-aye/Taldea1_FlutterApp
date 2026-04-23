import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('start screen is shown', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Futbol Jokalarien Jokoa'), findsOneWidget);
    expect(find.text('Jokoa hasi'), findsOneWidget);
  });
}
