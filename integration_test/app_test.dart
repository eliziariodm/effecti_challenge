import 'package:effecti_challenge/app/app_module.dart';
import 'package:effecti_challenge/app/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('testing ModalComponent E2E', () {
    testWidgets('adding, editing and removing the task', (tester) async {
      await tester.pumpWidget(
        ModularApp(
          module: AppModule(),
          child: const AppWidget(),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("button_add")));

      await tester.pump();

      await tester.enterText(find.byKey(const Key('text_input_add')), 'Task 1');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("button_text_input_add")));

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("open_modal")));

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('edit_task')));

      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(const Key('text_input_add')), 'Task Edited');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("button_text_input_add")));

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("open_modal")));

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('delete_task')));

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("button_delete")));

      expect(find.byKey(const Key('app_bar')), findsOneWidget);
    });
  });
}
