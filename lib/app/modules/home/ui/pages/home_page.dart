import 'package:effecti_challenge/app/modules/home/interactor/blocs/home_bloc.dart';
import 'package:effecti_challenge/app/modules/home/interactor/events/home_event.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/states/home_state.dart';
import 'package:effecti_challenge/app/modules/home/ui/components/filter_component.dart';
import 'package:effecti_challenge/app/modules/home/ui/components/modal_component.dart';
import 'package:effecti_challenge/app/modules/home/ui/widgets/dialog_remove_task_widget.dart';
import 'package:effecti_challenge/app/modules/home/ui/widgets/dialog_task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<HomeBloc>()..add(LoadTasksEvent());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) => InitialTasksState,
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            key: const Key('app_bar'),
            title: const Text(
              'ToDo App',
            ),
            actions: [
              IconButton(
                key: const Key('button_add'),
                icon: const Icon(Icons.add),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => DialogTaskWidget(
                      onPressed: (title, date) {
                        _bloc.add(
                          AddingTasksEvent(title, date),
                        );
                      },
                    ),
                  );
                },
              ),
              IconButton(
                key: const Key('button_remove'),
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => DialogRemoveTaskWidget(
                      title: 'Atenção!!!',
                      subtitle:
                          'Tem certeza que deseja excluir todas as tasks?',
                      onPressed: () {
                        Modular.to.pop();
                        _bloc.add(DeletingAllTasksEvent());
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                FilterComponent(
                    key: const Key('filter'),
                    bloc: _bloc,
                    tasksList: state.tasksListModel),
                const SizedBox(height: 30),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.673,
                  width: MediaQuery.of(context).size.width,
                  child: state.tasksListModel.tasksList.isEmpty
                      ? Center(
                          child: Text(
                            'Ainda não há tasks adicionadas!',
                            style: theme.textTheme.bodyMedium,
                          ),
                        )
                      : ListView.builder(
                          itemCount: state.tasksListModel.tasksList.length,
                          itemBuilder: ((context, index) {
                            TasksModel task =
                                state.tasksListModel.tasksList[index];

                            return ListTile(
                              key: const Key('open_modal'),
                              title: Text(
                                task.title,
                                style: theme.textTheme.bodyMedium,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.date,
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              trailing: Visibility(
                                visible: task.isCompleted,
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  builder: (context) => ModalComponent(
                                    bloc: _bloc,
                                    task: task,
                                    index: index,
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
