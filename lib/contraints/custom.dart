import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController textController;
  const CustomText({
    super.key,
    required this.isPass,
    required this.hintText,
    required this.textInputType,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context));
    return Container(
      width:300,
      padding: EdgeInsets.only(left:9),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [

          BoxShadow(
            blurRadius: 10,
            offset: Offset(1, 1),
            color: Colors.grey,
          )
        ],
        border: Border.all(
          color: Color.fromARGB(255, 11, 12, 10),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(11),
      ),
      child:TextField(
      controller: textController,
      decoration: InputDecoration(
        
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    )
    );
  }
}

class dateContainer extends StatelessWidget {
   final String datetxt;
  final String datelabel;
  final Color txtColor;
  final FontWeight weight;
  final double size;
  final FontStyle style;
  
  
  const dateContainer({super.key, required this.datetxt, required this.datelabel, required this.txtColor, required this.weight, required this.size, required this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
                     width:300,
                    height: 90,
                     
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
        child: Column(
          children: 
      [ Text(
        datelabel,
        style: const TextStyle(
          color: Colors.pinkAccent ,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic, 
        ),
        
      ),
      SizedBox(width:20 ,),
        Text(
        datetxt,
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