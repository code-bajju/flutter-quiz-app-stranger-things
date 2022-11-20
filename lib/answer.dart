import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final Color answerColor;
  final answerTap;

  Answer({ this.answerText, this.answerColor, this.answerTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(

      highlightColor: Colors.red.withOpacity(0.3),
      splashColor: Colors.orange.withOpacity(0.5),
      onTap: answerTap,
      child: Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
        width: double.infinity,
        height: MediaQuery.of(context).size.height/15,

        decoration: BoxDecoration(
          color: answerColor,
          border: Border.all(color: Colors.black,width:3),
          borderRadius: BorderRadius.circular(20.0),

        ),
        child: Text(
          answerText,
          style: TextStyle(

            fontSize: 15.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
    );
  }
}