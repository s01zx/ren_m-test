import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/sizeConfig.dart';

const textcolor = Color(0xff3B3B3B);
const primaryColor = Color(0xff7765C4);
const sourceappid = "ckpu7zo0p0000gg5436coo7xs";
const bearerToken =
    "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyMzQ4OTkzOTQ5NjMzIiwiaWF0IjoxNjQ5NDEyOTgwLCJleHAiOjE2NDk0OTkzODB9.DKY9oBHQi2LZ8qp0KDBpyzFaWKA1NpFVLgRnmy3MyfqZ89wWCdxPoF15I9nW9JgA_HKRCEx3H5powEtCN-__PQ";

double calculateSize(double size) {
  var val = size / 8.53;
  return val * SizeConfig.heightMultiplier!;
}

final pageMargin = EdgeInsets.only(
  left: calculateSize(28),
  right: calculateSize(28),
  top: calculateSize(20),
  //bottom: calculatefontSize(20),
);

Widget appText(String tx, double size,
    {FontWeight weight = FontWeight.w400,
    topmargin = 0.0,
    bottommargin = 0.0,
    leftmargin = 0.0,
    rightmargin = 0.0,
    TextAlign align = TextAlign.center,
    Color color = textcolor,
    double? space,
    bool softwrap = true,
    TextOverflow? overflow,
    FontStyle fontStyle = FontStyle.normal}) {
  return Container(
    margin: EdgeInsets.only(
        top: calculateSize(topmargin),
        bottom: calculateSize(bottommargin),
        left: calculateSize(leftmargin),
        right: calculateSize(rightmargin)),
    child: Text(
      tx == null ? "" : tx,
      softWrap: softwrap,
      overflow: overflow,
      textAlign: align,
      style: TextStyle(
        fontSize: calculateSize(size),
        fontWeight: weight,
        fontStyle: fontStyle,
        color: color,
        letterSpacing: space,
      ),
    ),
  );
}

class TransactionTile extends StatelessWidget {
  var imageasset;
  var title;
  var subtitle;
  var amount;
  var id;

  TransactionTile(
      {this.imageasset, this.title, this.subtitle, this.amount, this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: calculateSize(79),
      margin: EdgeInsets.only(bottom: calculateSize(10)),
      decoration: BoxDecoration(
        color: Color(0xffFAF9FF),
        borderRadius: BorderRadius.circular(calculateSize(8)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: calculateSize(13)),
        child: Row(
          children: [
            Image.asset(imageasset),
            SizedBox(
              width: calculateSize(8),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appText(title, 13,
                      weight: FontWeight.w700,
                      align: TextAlign.start,
                      color: Color(0xff3B3B3B)),
                  appText(subtitle, 13, weight: FontWeight.w400)
                ],
              ),
            ),
            SizedBox(
              width: calculateSize(8),
            ),
            amount,
          ],
        ),
      ),
    );
  }
}
