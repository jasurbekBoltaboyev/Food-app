import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:untitled/utils/dimensions.dart';
import 'package:untitled/widgets/big_text.dart';
import 'package:untitled/widgets/small_text.dart';

import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Column(
        children: [
          Container(

            child: Container(
              margin: EdgeInsets.only(top: Dimensions.hegiht45,bottom: Dimensions.hegiht15),
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: "Uzekistan",color: Color(0xFF89dad0),),
                      Row(
                        children: [
                          SmallText(text: "Xorazm",color: Colors.black54),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.hegiht45,
                      height: Dimensions.hegiht45,
                      child: Icon(Icons.search,color: Colors.white,size: Dimensions.icon24,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: Color(0xFF89dad0),
                      ),
                    ),
                  )
                ],
              ),

            ),
          ),
         Expanded(child: SingleChildScrollView(
           child:  FoodPageBody(),
         ))
        ],
      )
    );
  }
}
