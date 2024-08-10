import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RemoveAllTasksComponent extends StatelessWidget {
  const RemoveAllTasksComponent({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return AlertDialog(
      title: Text(
        "Atenção!!!",
        style: theme.textTheme.titleMedium,
      ),
      content: Text(
        'Tem certeza que deseja excluir todas as tasks?',
        style: theme.textTheme.titleSmall,
      ),
      actions: [
        TextButton(
          child: Text(
            'Sim',
            style: theme.textTheme.titleSmall,
          ),
          onPressed: () {
            Modular.to.pop();
          },
        ),
        TextButton(
          child: Text(
            'Não',
            style: theme.textTheme.titleSmall,
          ),
          onPressed: () {
            Modular.to.pop();
          },
        ),
      ],
    );
  }
}
