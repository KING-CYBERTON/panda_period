//import 'dart:html';

import 'package:flutter/material.dart';

class customContainer extends StatelessWidget {
  dynamic valueKey;

  final String txt;
  final String label;
  final Color txtColor;
  final FontWeight weight;
  final double size;
  final FontStyle style;
  
  
   customContainer(

      {super.key,
      required this.label,
      required this.txt,
      required this.txtColor,
      required this.weight,
      required this.size,
      required this.style});   

  @override
  Widget build(BuildContext context) {
    return Container(
                     width:300,
                    height: 50,
                     
      padding: EdgeInsets.only(left:9),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [

          BoxShadow(
            blurRadius: 10,
            offset: Offset(1, 1),
            color: Color.fromARGB(255, 214, 15, 15),
          )
        ],
        border: Border.all(
          color: Color.fromARGB(255, 226, 10, 190),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(11),
      ),
        child: Row(
          children: 
      [ Text(
        key: Key(this.valueKey),
        label,
        style: const TextStyle(
          color: Colors.pinkAccent ,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic, 
        ),
        
      ),
      SizedBox(width:20 ,),
        Text(
        txt,
        style: TextStyle(
            fontSize: size ?? 16,
            color: txtColor ?? Colors.black,
            fontWeight: weight ?? FontWeight.normal),
      ),
    ],
        ),
                  );
  }
}