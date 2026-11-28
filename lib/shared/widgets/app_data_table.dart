import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

class AppDataTableColumn<T> {
  const AppDataTableColumn({
    required this.label,
    this.numeric = false,
    this.sortBy,
  });

  final String label;
  final bool numeric;

  /// Optional comparator value extractor.
  final Comparable? Function(T row)? sortBy;
}

class AppDataRow<T> {
  const AppDataRow({required this.payload, required this.cells});

  final T payload;
  final List<Widget> cells;
}

class AppDataTable<T> extends HookWidget {
  const AppDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onRowTap,
    this.emptyState,
    this.mobileTileBuilder,
    this.pageSizeOptions = const [10, 25, 50],
    this.initialPageSize = 10,
    this.mobileBreakpoint = 768,
  });

  final List<AppDataTableColumn<T>> columns;
  final List<AppDataRow<T>> rows;
  final void Function(T row)? onRowTap;
  final Widget? emptyState;
  final Widget Function(BuildContext context, T payload)? mobileTileBuilder;
  final List<int> pageSizeOptions;
  final int initialPageSize;
  final double mobileBreakpoint;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty && emptyState != null) {
      return emptyState!;
    }

    final ValueNotifier<int> pageIndex = useState(0);
    final ValueNotifier<int> rowsPerPage = useState(initialPageSize);
    final ValueNotifier<int?> sortColumnIndex = useState<int?>(null);
    final ValueNotifier<bool> sortAscending = useState<bool>(true);

    // 1. Apply sorting if a sortable column is active
    final List<AppDataRow<T>> sortedRows = useMemoized(() {
      final int? colIdx = sortColumnIndex.value;
      if (colIdx == null || colIdx < 0 || colIdx >= columns.length) {
        return rows;
      }
      final Comparable? Function(T row)? extractor = columns[colIdx].sortBy;
      if (extractor == null) return rows;

      final copy = List<AppDataRow<T>>.of(rows);
      copy.sort((a, b) {
        final Comparable? aVal = extractor(a.payload);
        final Comparable? bVal = extractor(b.payload);
        if (aVal == null && bVal == null) return 0;
        if (aVal == null) return sortAscending.value ? -1 : 1;
        if (bVal == null) return sortAscending.value ? 1 : -1;
        final int cmp = aVal.compareTo(bVal);
        return sortAscending.value ? cmp : -cmp;
      });
      return copy;
    }, [rows, sortColumnIndex.value, sortAscending.value]);

    // 2. Apply pagination slicing
    final int totalRows = sortedRows.length;
    final int totalPages = (totalRows / rowsPerPage.value).ceil().clamp(
      1,
      999999,
    );
    final int safePageIndex = pageIndex.value.clamp(0, totalPages - 1);

    final int startIndex = safePageIndex * rowsPerPage.value;
    final int endIndex = (startIndex + rowsPerPage.value).clamp(0, totalRows);
    final List<AppDataRow<T>> visibleRows = sortedRows.sublist(
      startIndex,
      endIndex,
    );

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile =
              constraints.maxWidth < mobileBreakpoint &&
              mobileTileBuilder != null;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: isMobile
                    ? ListView.separated(
                        shrinkWrap: true,
                        itemCount: visibleRows.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final AppDataRow<T> row = visibleRows[index];
                          return InkWell(
                            onTap: onRowTap == null
                                ? null
                                : () => onRowTap!(row.payload),
                            child: mobileTileBuilder!(context, row.payload),
                          );
                        },
                      )
                    : SingleChildScrollView(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: constraints.maxWidth,
                            ),
                            child: DataTable(
                              showCheckboxColumn: false,
                              sortColumnIndex: sortColumnIndex.value,
                              sortAscending: sortAscending.value,
                              columns: [
                                for (int i = 0; i < columns.length; i++)
                                  DataColumn(
                                    numeric: columns[i].numeric,
                                    onSort: columns[i].sortBy == null
                                        ? null
                                        : (colIndex, ascending) {
                                            sortColumnIndex.value = colIndex;
                                            sortAscending.value = ascending;
                                            pageIndex.value = 0;
                                          },
                                    label: Text(columns[i].label),
                                    mouseCursor: columns[i].sortBy == null
                                        ? null
                                        : const WidgetStatePropertyAll(
                                            SystemMouseCursors.click,
                                          ),
                                  ),
                              ],
                              rows: [
                                for (final r in visibleRows)
                                  DataRow(
                                    onSelectChanged: onRowTap == null
                                        ? null
                                        : (_) => onRowTap!(r.payload),
                                    cells: [
                                      for (final cell in r.cells)
                                        DataCell(cell),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
              const Divider(height: 1),
              _PaginationFooter(
                totalRows: totalRows,
                startIndex: startIndex,
                endIndex: endIndex,
                pageIndex: safePageIndex,
                totalPages: totalPages,
                rowsPerPage: rowsPerPage.value,
                pageSizeOptions: pageSizeOptions,
                onRowsPerPageChanged: (value) {
                  rowsPerPage.value = value;
                  pageIndex.value = 0;
                },
                onPageChanged: (newPage) => pageIndex.value = newPage,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PaginationFooter extends StatelessWidget {
  const _PaginationFooter({
    required this.totalRows,
    required this.startIndex,
    required this.endIndex,
    required this.pageIndex,
    required this.totalPages,
    required this.rowsPerPage,
    required this.pageSizeOptions,
    required this.onRowsPerPageChanged,
    required this.onPageChanged,
  });

  final int totalRows;
  final int startIndex;
  final int endIndex;
  final int pageIndex;
  final int totalPages;
  final int rowsPerPage;
  final List<int> pageSizeOptions;
  final ValueChanged<int> onRowsPerPageChanged;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 4,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Rows:', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(width: 6),
              DropdownButton<int>(
                value: rowsPerPage,
                isDense: true,
                underline: const SizedBox.shrink(),
                items: [
                  for (final size in pageSizeOptions)
                    DropdownMenuItem(value: size, child: Text('$size')),
                ],
                onChanged: (v) {
                  if (v != null) onRowsPerPageChanged(v);
                },
              ),
            ],
          ),
          Text(
            '${startIndex + 1}–$endIndex of $totalRows',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left_rounded),
                visualDensity: VisualDensity.compact,
                onPressed: pageIndex > 0
                    ? () => onPageChanged(pageIndex - 1)
                    : null,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right_rounded),
                visualDensity: VisualDensity.compact,
                onPressed: pageIndex < totalPages - 1
                    ? () => onPageChanged(pageIndex + 1)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
