import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:untitled/data/repository/popular_product_repo.dart';
import 'package:untitled/models/product_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _pularProductList = [];
  List<dynamic> get popularProductList => _pularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quanitty = 0;
  int get quanitty => _quanitty;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quanitty;
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPoppularProductList();
    if (response.statusCode == 200) {
      _pularProductList = [];
      _pularProductList.addAll(Product.fromJson(response.body).products);
      // print(_pularProductList);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQantity(bool isIncrement) {
    if (isIncrement) {
      _quanitty = checkQuantity(_quanitty + 1);
    } else {
      _quanitty = checkQuantity(_quanitty - 1);
      ;
    }
    update();
  }

  int checkQuantity(int qauntity) {
    if (qauntity < 0) {
      Get.snackbar(
        "item count",
        "iltimos miqdordi oshiring!",
        backgroundColor: Colors.green[300],
        colorText: Colors.white,
      );
      return 0;
    } else if (quanitty >= 20) {
      Get.snackbar(
        "item count",
        "iltimos miqdordi kamaytring!",
        backgroundColor: Colors.green[300],
        colorText: Colors.white,
      );
      return 20;
    } else {
      return qauntity;
    }
  }

  void initProduct() {
    _quanitty = 0;
    _inCartItems = 0;
  }
}
