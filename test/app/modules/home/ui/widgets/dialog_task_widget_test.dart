import 'package:effecti_challenge/app/app_module.dart';
import 'package:effecti_challenge/app/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('testing widget DialogTaskWidget', (tester) async {
    await tester.pumpWidget(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    );

    await tester.pump();

    await tester.tap(find.byKey(const Key("button_add")));

    await tester.pump();

    expect(find.byKey(const Key("alert_dialog_add")), findsOneWidget);
  });
}
