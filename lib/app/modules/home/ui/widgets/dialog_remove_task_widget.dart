import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DialogRemoveTaskWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function()? onPressed;

  const DialogRemoveTaskWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return AlertDialog(
      title: Text(
        title,
        style: theme.textTheme.titleMedium,
      ),
      content: Text(
        subtitle,
        style: theme.textTheme.titleSmall,
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            'Sim',
            style: theme.textTheme.titleSmall,
          ),
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
