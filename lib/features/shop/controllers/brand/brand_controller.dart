import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:t_ecommerce_admin_panel/data/repositories/brand/brand_repository.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/brand_model.dart';

class BrandsController extends TBaseController<BrandModel> {
  static BrandsController get instance => Get.find();
  final _brandRepository = Get.put(BrandRepository());

  @override
  bool containSearchQuery(BrandModel item, String query) {
    // TODO: implement containSearchQuery
    throw UnimplementedError();
  }

  @override
  Future<void> deleteItem(BrandModel item) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<List<BrandModel>> fetchItems() async {
    return await _brandRepository.fetchAllBrands();
  }
}
