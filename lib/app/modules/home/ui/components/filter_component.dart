import 'package:flutter/material.dart';
import 'package:effecti_challenge/app/utils/filter_enum.dart';

class FilterComponent extends StatefulWidget {
  const FilterComponent({super.key});

  @override
  State<FilterComponent> createState() => _FilterComponentState();
}

class _FilterComponentState extends State<FilterComponent> {
  Set<Filter> selection = <Filter>{Filter.all};

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
          selected: selection,
          onSelectionChanged: (Set<Filter> newSelection) {
            setState(() {
              selection = newSelection;
            });
          },
        ),
      ],
    );
  }
}
