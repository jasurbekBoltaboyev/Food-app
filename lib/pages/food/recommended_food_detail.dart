import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controllers/recommended_product_controller.dart';
import 'package:untitled/routes/route_helper.dart';
import 'package:untitled/utils/dimensions.dart';
import 'package:untitled/widgets/app_icon.dart';
import 'package:untitled/widgets/big_text.dart';
import 'package:untitled/widgets/exandable_text_widget.dart';

import '../../utils/app_constants.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
   const RecommendedFoodDetail({super.key,required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product=Get.find<RecommendedProductController>().recommendedProductList[pageId];
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               GestureDetector(

                   child: AppIcon(icon: Icons.clear),
                 onTap: (){
                     Get.toNamed(RouteHelper.getInitial());
                 },
               ),
               AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(

                child:  Center(child: BigText(size:Dimensions.font26,text: product.name ,)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5,bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  )
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.amber[300],
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(

                  child: ExandableTextWidget(text:product.description!),
                  margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                )
              ],
            ),
            )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width20*2.5,
              right: Dimensions.width20*2.5,
              top: Dimensions.width10,
              bottom: Dimensions.width10
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  iconsize: Dimensions.icon24,
                    iconColor: Colors.white,
                    baskgroundColor: Colors.green.shade300,
                    icon: Icons.remove,
                ),
                BigText(text: "\$ ${product.price!} X 0",color: Colors.grey[800],size: Dimensions.font26,),
                AppIcon(
                    iconsize: Dimensions.icon24,
                    iconColor: Colors.white,
                    baskgroundColor: Colors.green.shade300,
                    icon: Icons.add)
              ],
            ),
          ),
          Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(top: Dimensions.hegiht30,bottom: Dimensions.hegiht30,left: Dimensions.width20,right: Dimensions.width20),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2),
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.hegiht20,bottom: Dimensions.hegiht20,right: Dimensions.width20,left: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child:
                    Icon(
                      Icons.favorite,
                      color: Colors.green[300],
                    )
                ),
                Container(
                  padding: EdgeInsets.only(top: Dimensions.hegiht20,bottom: Dimensions.hegiht20,right: Dimensions.width20,left: Dimensions.width20),

                  child: BigText(text: "\$10| Add to cart",color: Colors.white,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.green[300],
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
