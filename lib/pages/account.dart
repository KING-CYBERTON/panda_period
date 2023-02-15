import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccontProfile extends StatefulWidget {
  const AccontProfile({super.key});

  @override
  State<AccontProfile> createState() => _AccontProfileState();
}

class _AccontProfileState extends State<AccontProfile> {
  
  var plController = TextEditingController();
  var ClController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(
      children: [
         Container(
          child:Text(FirebaseAuth.instance.currentUser!.displayName!)
        ),
        
        
       // EditableText(controller: plController, focusNode: focusNode, style: styleeditabledr , cursorColor: cursorColor, backgroundCursorColor: backgroundCursorColor)
        Container(
          child: Text(FirebaseAuth.instance.currentUser!.email!)
        ),
         Container(
          child: Text('cycle length'),
        ),
      ],
    )
    );
  }
}