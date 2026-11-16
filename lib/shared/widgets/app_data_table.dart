import 'package:material_ui/material_ui.dart';

class AppDataTableColumn {
  const AppDataTableColumn({required this.label, this.numeric = false});

  final String label;
  final bool numeric;
}

class AppDataTable<T> extends StatelessWidget {
  const AppDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onRowTap,
    this.emptyState,
  });

  final List<AppDataTableColumn> columns;
  final List<AppDataRow<T>> rows;
  final void Function(T row)? onRowTap;
  final Widget? emptyState;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty && emptyState != null) {
      return emptyState!;
    }

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: DataTable(
            showCheckboxColumn: false,
            columns: [
              for (final c in columns)
                DataColumn(numeric: c.numeric, label: Text(c.label)),
            ],
            rows: [
              for (final r in rows)
                DataRow(
                  onSelectChanged: onRowTap == null
                      ? null
                      : (_) => onRowTap!(r.payload),
                  cells: [for (final cell in r.cells) DataCell(cell)],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppDataRow<T> {
  AppDataRow({required this.payload, required this.cells});
  final T payload;
  final List<Widget> cells;
}
