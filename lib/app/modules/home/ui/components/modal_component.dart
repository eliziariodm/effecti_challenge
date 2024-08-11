import 'package:effecti_challenge/app/modules/home/interactor/blocs/home_bloc.dart';
import 'package:effecti_challenge/app/modules/home/interactor/events/home_event.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_model.dart';
import 'package:effecti_challenge/app/modules/home/ui/widgets/dialog_remove_task_widget.dart';
import 'package:effecti_challenge/app/modules/home/ui/widgets/dialog_task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ModalComponent extends StatefulWidget {
  final HomeBloc bloc;
  final TasksModel task;
  final int index;

  const ModalComponent({
    super.key,
    required this.bloc,
    required this.task,
    required this.index,
  });

  @override
  State<ModalComponent> createState() => _ModalComponentState();
}

class _ModalComponentState extends State<ModalComponent> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SizedBox(
      height: 185,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.resolveWith(
                  (states) => Colors.transparent,
                ),
              ),
              child: Text(
                'Editar Task',
                style: theme.textTheme.titleSmall,
              ),
              onPressed: () async {
                Modular.to.pop();
                await showDialog(
                  context: context,
                  builder: (context) => DialogTaskWidget(
                    onPressed: (title, date) {
                      widget.bloc.add(
                        EditingTasksEvent(
                          widget.task,
                          widget.index,
                          title,
                          date,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Divider(
            thickness: 0.4,
            color: theme.colorScheme.primary,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.resolveWith(
                  (states) => Colors.transparent,
                ),
              ),
              child: Text(
                'Delete Task',
                style: theme.textTheme.titleSmall,
              ),
              onPressed: () {
                Modular.to.pop();

                showDialog(
                  context: context,
                  builder: (context) => DialogRemoveTaskWidget(
                    title: 'Atenção!!!',
                    subtitle: 'Tem certeza que deseja excluir a task?',
                    onPressed: () {
                      Modular.to.pop();
                      widget.bloc.add(DeletingTasksEvent(widget.task));
                    },
                  ),
                );
              },
            ),
          ),
          Divider(
            thickness: 0.4,
            color: theme.colorScheme.primary,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.resolveWith(
                  (states) => Colors.transparent,
                ),
              ),
              child: Text(
                widget.task.isCompleted
                    ? 'Desmarcar como Concluída'
                    : 'Marcar como Concluída',
                style: theme.textTheme.titleSmall,
              ),
              onPressed: () {
                Modular.to.pop();

                widget.task.isCompleted
                    ? widget.bloc.add(
                        PendingTasksEvent(
                          widget.task,
                          widget.index,
                        ),
                      )
                    : widget.bloc.add(
                        CompletingTasksEvent(
                          widget.task,
                          widget.index,
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
