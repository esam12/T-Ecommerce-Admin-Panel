import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../loaders/animation_loader.dart';

/// Custom PaginatedDataTable widget with additional features
class TPaginatedDataTable extends StatelessWidget {
  const TPaginatedDataTable({
<<<<<<< HEAD
    Key? key,
=======
    super.key,
>>>>>>> master
    required this.columns,
    required this.source,
    this.rowsPerPage = 10,
    this.tableHeight = 760,
    this.onPageChanged,
    this.sortColumnIndex,
    this.dataRowHeight = TSizes.xl * 2,
    this.sortAscending = true,
    this.minWidth = 1000,
<<<<<<< HEAD
  }) : super(key: key);
=======
  });
>>>>>>> master

  /// Whether to sort the DataTable in ascending or descending order.
  final bool sortAscending;

  /// Index of the column to sort by.
  final int? sortColumnIndex;

  /// Number of rows to display per page.
  final int rowsPerPage;

  /// Data source for the DataTable.
  final DataTableSource source;

  /// List of columns for the DataTable.
  final List<DataColumn> columns;

  /// Callback function to handle page changes.
  final Function(int)? onPageChanged;

  /// Height of each data row in the DataTable.
  final double dataRowHeight;

  /// Height of the entire DataTable.
  final double tableHeight;

  /// Minimum Width of the entire DataTable.
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Set the dynamic height of the PaginatedDataTable
      height: tableHeight,
      child: Theme(
        // Use to set the Backend color
<<<<<<< HEAD
        data: Theme.of(context).copyWith(cardTheme: const CardTheme(color: Colors.white, elevation: 0)),
        child: PaginatedDataTable2(
          source: source,
=======
        data: Theme.of(context).copyWith(
            cardTheme: const CardTheme(color: Colors.white, elevation: 0)),
        child: PaginatedDataTable2(
          source: source,

          // Columns & Rows
>>>>>>> master
          columns: columns,
          columnSpacing: 12,
          minWidth: minWidth,
          dividerThickness: 0,
          horizontalMargin: 12,
          rowsPerPage: rowsPerPage,
<<<<<<< HEAD
          showFirstLastButtons: true,
          showCheckboxColumn: true,
          sortAscending: sortAscending,
          onPageChanged: onPageChanged,
          dataRowHeight: dataRowHeight,
          renderEmptyRowsInTheEnd: false,
          onRowsPerPageChanged: (noOfRows) {},
          sortColumnIndex: sortColumnIndex,
          headingTextStyle: Theme.of(context).textTheme.titleMedium,
          headingRowColor: MaterialStateProperty.resolveWith((states) => TColors.primaryBackground),
          empty: TAnimationLoaderWidget(animation: TImages.packageAnimation, text: 'Nothing Found', height: 200, width: 200),
=======
          dataRowHeight: dataRowHeight,

          // Checkbox
          showCheckboxColumn: true,

          // Pagination
          showFirstLastButtons: true,
          onPageChanged: onPageChanged,
          renderEmptyRowsInTheEnd: false,
          onRowsPerPageChanged: (noOfRows) {},

          sortAscending: sortAscending,
          sortColumnIndex: sortColumnIndex,
          headingTextStyle: Theme.of(context).textTheme.titleMedium,
          headingRowColor: WidgetStateProperty.resolveWith(
              (states) => TColors.primaryBackground),
          empty: TAnimationLoaderWidget(
              animation: TImages.packageAnimation,
              text: 'Nothing Found',
              height: 200,
              width: 200),
>>>>>>> master
          headingRowDecoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(TSizes.borderRadiusMd),
              topRight: Radius.circular(TSizes.borderRadiusMd),
            ),
          ),
          sortArrowBuilder: (bool ascending, bool sorted) {
            if (sorted) {
<<<<<<< HEAD
              return Icon(ascending ? Iconsax.arrow_up_3 : Iconsax.arrow_down, size: TSizes.iconSm);
=======
              return Icon(ascending ? Iconsax.arrow_up_3 : Iconsax.arrow_down,
                  size: TSizes.iconSm);
>>>>>>> master
            } else {
              return const Icon(Iconsax.arrow_3, size: TSizes.iconSm);
            }
          },
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> master
