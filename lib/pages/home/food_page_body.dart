

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/controllers/popular_product_controller.dart';
import 'package:untitled/controllers/recommended_product_controller.dart';
import 'package:untitled/models/product_model.dart';
import 'package:untitled/pages/food/popular_food_detail.dart';
import 'package:untitled/routes/route_helper.dart';
import 'package:untitled/utils/app_constants.dart';
import 'package:untitled/utils/dimensions.dart';
import 'package:untitled/widgets/app_column.dart';
import 'package:untitled/widgets/big_text.dart';
import 'package:untitled/widgets/icon_and_text_widget.dart';
import 'package:untitled/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController=PageController(viewportFraction:  0.85);
  var _currPageValue=0.0;
  double _scaleFactor=0.8;
  double _hegiht=Dimensions.pageViewContainer;
  @override
  void initState(){
    super.initState();

    pageController.addListener(() {
    setState(() {

      _currPageValue =  pageController.page!;
    });
    });
  }
  @override
  void dispose(){
    pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Column(children: [
      //tepa
      GetBuilder<PopularProductController>(builder: (popularProducts){
     return   popularProducts.isLoaded? Container(
         //color: Colors.redAccent,
         height: Dimensions.pageView,
         child: PageView.builder(
             controller: pageController,
             itemCount: popularProducts.popularProductList.length,
             itemBuilder: (context, position){
               return _buildPageItem(position,popularProducts.popularProductList[position]);
             }),
     ):CircularProgressIndicator(
         color: Colors.green[300],
     );
   }),

      //tugmalar
      GetBuilder<PopularProductController>(builder: (popularProducts){
       return   DotsIndicator(
         dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
         position: _currPageValue,
         decorator: DotsDecorator(
           activeColor:  Color(0xFF89dad0),
           size: const Size.square(9.0),
           activeSize: const Size(18.0, 9.0),
           activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
         ),
       );
     }),
      //popular text
      SizedBox(height: Dimensions.hegiht30,),
      Container(
        margin: EdgeInsets.only(left: Dimensions.width30,),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end ,
          children: [
            BigText(text: "Recommended"),
            SizedBox(width: Dimensions.width10,),
            Container(
              margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".",color: Colors.black26,)),
            SizedBox(width: Dimensions.width10,),
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: SmallText(text: "Food pairing"),),

          ],
        ),
      ),
      //recommended food
      //list of food and images
      GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
        return recommendedProduct.isLoaded?ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recommendedProduct.recommendedProductList.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getRecommendedFood(index));

                },
                child: Container(
                  margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,bottom: Dimensions.hegiht10),
                  child: Row(
                    children: [
                      //image section
                      Container(
                        width:Dimensions.listViewImgSize,
                        height: Dimensions.listViewImgSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white38,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                              image: NetworkImage(
                                  AppConstants.BASE_URL+AppConstants.UPLOAD_URL+  recommendedProduct.recommendedProductList[index].img!
                              ),
                          ),
                        ),



                      ),

                      //text section
                      Expanded(
                        child: Container(
                          height: Dimensions.listViewTextContImgSize,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius20),bottomRight:Radius.circular(Dimensions.radius20)),
                            color: Colors.white,
                          ),
                          child: Container(
                            padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                SizedBox(height: Dimensions.hegiht10,),
                                SmallText(text: "With chinese characteristics"),
                                SizedBox(height: Dimensions.hegiht10,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndTextWidget(
                                        icon: Icons.circle_sharp ,
                                        text: "Normal",
                                        iconColor: Color(0xFFffd28d)),
                                    IconAndTextWidget(
                                        icon: Icons.location_on ,
                                        text: "1.7km",
                                        iconColor: Color(0xFF89dad0)),
                                    IconAndTextWidget(
                                        icon: Icons.access_time_rounded ,
                                        text: "32min",
                                        iconColor: Color(0xFFfcab88)),
                                  ],),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }):CircularProgressIndicator(
          color: Colors.green[300],
        );
      })

    ],
    );
  }
  Widget _buildPageItem(int index, ProductModel popularProduct){
    Matrix4 matrix= new Matrix4.identity();
    if (index==_currPageValue.floor()){
      var currScale =1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans=_hegiht*(1-currScale)/2;
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index==_currPageValue.floor()+1){
      var currScale =_scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans=_hegiht*(1-currScale)/2;

      matrix=Matrix4.diagonal3Values(1, currScale, 1);
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if(index==_currPageValue.floor()-1){
      var currScale =1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans=_hegiht*(1-currScale)/2;

      matrix=Matrix4.diagonal3Values(1, currScale, 1);
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else{
      var currScale=0.8;
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _hegiht*(1-_scaleFactor)/2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
        onTap: (){
      Get.toNamed(RouteHelper.getPopularFood(index));},
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(right: Dimensions.width10,left: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven? Color(0xff69c5df):Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!
                      ),
                  )
              ),
            ),
          ),
          Align(
          alignment: Alignment.bottomCenter,
          child: Container(
          height: Dimensions.pageViewTextContainer,
          margin: EdgeInsets.only(right: Dimensions.width30,left: Dimensions.width30,bottom: Dimensions.hegiht30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0xFFe8e8e8),
                blurRadius: 5.0,
                offset: Offset(0,5),
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-5,0),
              ),    BoxShadow(
                color: Colors.white,
                offset: Offset(5,0),
              ),
            ],

          ),
            child: Container(
              padding: EdgeInsets.only(top: Dimensions.hegiht15,left:Dimensions.width15,right: Dimensions.width15),
              child: AppColumn(text: popularProduct.name! ,size: Dimensions.font20,),
            ),
      ),
        ),

        ],
      ),
    );
  }
}
