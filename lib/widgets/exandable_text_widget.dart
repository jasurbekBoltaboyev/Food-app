import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/utils/dimensions.dart';
import 'package:untitled/widgets/small_text.dart';

class ExandableTextWidget extends StatefulWidget {
  final String text;
  const ExandableTextWidget({super.key, required this.text});

  @override
  State<ExandableTextWidget> createState() => _ExandableTextWidgetState();
}

class _ExandableTextWidgetState extends State<ExandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: secondHalf.isEmpty
          ? SmallText(color:Colors.grey[800],size:Dimensions.font16,text: firstHalf)
          : Column(
        children: [
          SmallText(height:1.8,color:Colors.grey[800],size:Dimensions.font16,text: hiddenText ? (firstHalf + "...") : (firstHalf + secondHalf)),
          InkWell(
            onTap: () {
              setState(() {
                hiddenText = !hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText( text: hiddenText?"Show more":"Show  less", color: Colors.green[300]),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up, color: Colors.green[300]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

