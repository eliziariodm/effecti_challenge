import 'package:effecti_challenge/app/modules/home/interactor/blocs/home_bloc.dart';
import 'package:effecti_challenge/app/modules/home/interactor/events/home_event.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/states/home_state.dart';
import 'package:effecti_challenge/app/modules/home/ui/components/add_task_component.dart';
import 'package:effecti_challenge/app/modules/home/ui/components/filter_component.dart';
import 'package:effecti_challenge/app/modules/home/ui/components/remove_all_tasks_component.dart';
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
            title: const Text(
              'ToDo App',
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddTaskComponent(bloc: _bloc),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const RemoveAllTasksComponent(),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const FilterComponent(),
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
                            TasksModel tasks =
                                state.tasksListModel.tasksList[index];

                            return ListTile(
                              title: Text(
                                tasks.title,
                                style: theme.textTheme.bodyMedium,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tasks.date,
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              trailing: Visibility(
                                visible: tasks.isCompleted,
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                              ),
                              onTap: () {},
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
