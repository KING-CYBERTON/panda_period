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