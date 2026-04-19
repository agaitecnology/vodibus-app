import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vodibus_app/main.dart';

void main() {
  testWidgets('VoDiBus smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const VoDiBusApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
