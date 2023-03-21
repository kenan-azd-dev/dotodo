//import 'package:dotodo/app/app.dart';
import 'package:dotodo/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      //await tester.pumpWidget();
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
