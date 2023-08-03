import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/widgets/small_text.dart';

import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final double size;
   AppColumn({super.key,
     required this.text,
   required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: Dimensions.font26,),
        SizedBox(height: Dimensions.hegiht10,),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) { return Icon(Icons.star,color: Color(0xFF89dad0),size:Dimensions.hegiht15,);}) ,
            ),
            SizedBox(width: 10,),
            SmallText(text: "4.5"),
            SizedBox(width: 10,),
            SmallText(text: "1287"),
            SizedBox(width: 10,),
            SmallText(text: "comments")
          ],
        ),
        SizedBox(height: Dimensions.hegiht20,),
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
    );
  }
}
