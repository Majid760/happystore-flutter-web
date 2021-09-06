import 'package:flutter/material.dart';




class CircleComp extends StatelessWidget {
  final Icon icon;
  final double height;
  final double width;
  final Color color;
  final Function onTapo;
  final Widget wiget;
  final double radius;
  final Color borderColor;
  final double borderSize;

  CircleComp({this.wiget,this.borderColor=Colors.white,this.borderSize=0,this.onTapo,this.icon, this.height=50,this.width=50, this.color,this.radius=50, Key key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTapo,
      child: Container(
        height: height,
        width: width,
        child:Center(child: icon ?? wiget),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color:color,
          border: Border.all(color:borderColor,width:borderSize)
        )
      ),
    );
  }
}
