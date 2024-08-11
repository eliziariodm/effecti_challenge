import 'package:effecti_challenge/app/modules/home/interactor/blocs/home_bloc.dart';
import 'package:effecti_challenge/app/modules/home/interactor/events/home_event.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';
import 'package:flutter/material.dart';
import 'package:effecti_challenge/app/utils/filter_enum.dart';

class FilterComponent extends StatefulWidget {
  final HomeBloc bloc;
  final TasksListModel tasksList;

  const FilterComponent({
    super.key,
    required this.bloc,
    required this.tasksList,
  });

  @override
  State<FilterComponent> createState() => _FilterComponentState();
}

class _FilterComponentState extends State<FilterComponent> {
  @override
  void initState() {
    super.initState();
    widget.bloc.state.selection = <Filter>{Filter.all};
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          'Filtrar',
          style: theme.titleMedium,
        ),
        const SizedBox(height: 10),
        SegmentedButton<Filter>(
          showSelectedIcon: false,
          segments: const <ButtonSegment<Filter>>[
            ButtonSegment<Filter>(value: Filter.all, label: Text('Todos')),
            ButtonSegment<Filter>(
                value: Filter.completed, label: Text('Concluído')),
            ButtonSegment<Filter>(
                value: Filter.pending, label: Text('Pendente')),
          ],
          selected: widget.bloc.state.selection!,
          onSelectionChanged: (Set<Filter> newSelection) {
            widget.bloc.state.selection = newSelection;

            widget.bloc.add(
              FilteringTasksEvent(
                widget.tasksList,
                newSelection,
              ),
            );
          },
        ),
      ],
    );
  }
}
