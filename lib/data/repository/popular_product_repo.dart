import 'package:get/get.dart';
import 'package:untitled/data/api/api_client.dart';
import 'package:untitled/utils/app_constants.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPoppularProductList()async{
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}