import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:t_ecommerce_admin_panel/data/repositories/banner/banner_repository.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/banner_model.dart';

class BannerController extends TBaseController<BannerModel> {
  static BannerController get instance => Get.find();

  final _bannerRepository = Get.put(BannerRepository());

  @override
  bool containSearchQuery(BannerModel item, String query) {
    return false;
  }

  @override
  Future<void> deleteItem(BannerModel item) async {
    await _bannerRepository.deleteBanner(item.id ?? '');
  }

  @override
  Future<List<BannerModel>> fetchItems() async {
    return await _bannerRepository.getAllBanners();
  }

  /// Method for formatting a route string
  String formatRoute(String route) {
    if(route.isEmpty) return '';

    // Remove the leading '/'
    final formattedRoute = route.substring(1);

    // Capitalize the first Character
    return formattedRoute[0].toUpperCase() + formattedRoute.substring(1);
    
    
  } 
  
}
