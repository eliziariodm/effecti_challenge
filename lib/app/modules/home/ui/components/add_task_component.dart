import 'package:effecti_challenge/app/modules/home/interactor/blocs/home_bloc.dart';
import 'package:effecti_challenge/app/modules/home/interactor/events/home_event.dart';
import 'package:effecti_challenge/app/modules/home/ui/widgets/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class AddTaskComponent extends StatefulWidget {
  final HomeBloc bloc;

  const AddTaskComponent({super.key, required this.bloc});

  @override
  State<AddTaskComponent> createState() => _AddTaskComponentState();
}

class _AddTaskComponentState extends State<AddTaskComponent> {
  final _formkey = GlobalKey<FormState>();

  String title = '';
  DateTime? date;
  TextEditingController dateTextController = TextEditingController(text: '');

  @override
  void dispose() {
    dateTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return AlertDialog(
      title: Text(
        "Adicione uma task:",
        style: theme.textTheme.titleSmall,
      ),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      content: SizedBox(
        height: 160,
        width: MediaQuery.sizeOf(context).width,
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextInputWidget(
                label: 'Título',
                onChanged: (value) {
                  title = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O campo título é obrigatório!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextInputWidget(
                controller: dateTextController,
                label: 'Data de Conclusão',
                disabled: true,
                onTap: () async {
                  date = await showDialog(
                    context: context,
                    barrierColor: Colors.transparent,
                    builder: (context) => DatePickerDialog(
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1992),
                      lastDate: DateTime(2030),
                    ),
                  );

                  if (date != null) {
                    dateTextController.text =
                        DateFormat('dd/MM/yyyy').format(date!);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      actions: [
        TextButton(
          child: Text(
            'Cancelar',
            style: theme.textTheme.titleSmall,
          ),
          onPressed: () {
            Modular.to.pop();
          },
        ),
        TextButton(
          child: Text(
            'OK',
            style: theme.textTheme.titleSmall,
          ),
          onPressed: () {
            if (_formkey.currentState!.validate()) {
              Modular.to.pop();

              widget.bloc.add(AddingTasksEvent(
                title,
                date != null
                    ? dateTextController.text
                    : DateFormat('dd/MM/yyyy').format(DateTime.now()),
              ));

              return;
            }
          },
        ),
      ],
    );
  }
}
