import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/controllers/popular_product_controller.dart';
import 'package:untitled/pages/home/main_food_page.dart';
import 'package:untitled/utils/app_constants.dart';
import 'package:untitled/utils/dimensions.dart';
import 'package:untitled/widgets/app_column.dart';
import 'package:untitled/widgets/app_icon.dart';
import 'package:untitled/widgets/exandable_text_widget.dart';

import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  const PopularFoodDetail({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(AppConstants.BASE_URL +
                            AppConstants.UPLOAD_URL +
                            product.img!))),
              )),
          //icon widgets
          Positioned(
            top: Dimensions.hegiht45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: AppIcon(icon: Icons.arrow_back_ios),
                  onTap: () {
                    Get.to(() => MainFoodPage());
                  },
                ),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
          ),
          //introduction of food
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize - 20,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.hegiht20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                      text: product.name!,
                      size: Dimensions.font26,
                    ),
                    SizedBox(
                      height: Dimensions.hegiht20,
                    ),
                    BigText(text: "Introduce"),
                    SizedBox(
                      height: Dimensions.hegiht20,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: ExandableTextWidget(
                                text: product.description!)))
                  ],
                ),
              )),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimensions.hegiht30,
                bottom: Dimensions.hegiht30,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.hegiht20,
                      bottom: Dimensions.hegiht20,
                      right: Dimensions.width20,
                      left: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQantity(false);
                          },
                          child: Icon(
                            Icons.remove,
                            color: Colors.grey,
                          )),
                      SizedBox(
                        width: Dimensions.width10 / 5,
                      ),
                      BigText(text: popularProduct.quanitty.toString()),
                      SizedBox(
                        width: Dimensions.width10 / 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQantity(true);
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.hegiht20,
                      bottom: Dimensions.hegiht20,
                      right: Dimensions.width20,
                      left: Dimensions.width20),
                  child: BigText(
                    text: "\$ ${product.price!}| Add to cart",
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.green[300],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
