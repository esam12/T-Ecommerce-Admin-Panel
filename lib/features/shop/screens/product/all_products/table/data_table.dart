import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/product/all_products/table/table_source.dart';

class ProductTable extends StatelessWidget {
  const ProductTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 700,
      columns: const [
        DataColumn2(
          label: Text('Product'),
        ),
        DataColumn2(
          label: Text('Stock'),
        ),
        DataColumn2(
          label: Text('Brand'),
        ),
        DataColumn2(
          label: Text('Price'),
        ),
        DataColumn2(
          label: Text('Date'),
        ),
        DataColumn2(
          label: Text('Action'),
          fixedWidth: 100,
        ),
      ],
      source: ProductRows(),
    );
  }
}
