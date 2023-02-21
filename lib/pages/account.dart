import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:panda_period/contollers/GetAuth.dart';

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
    return Scaffold(
       appBar: AppBar(
        title: const Text('Panda Period'),
        
      ),
      body: Center(
        child: Container(
          width:350,
        height: 400,

         decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [

            BoxShadow(
              blurRadius: 10,
              offset: Offset(1, 1),
              color: Color.fromARGB(255, 145, 56, 115),
            )
          ],
          border: Border.all(
            color: Color.fromARGB(255, 139, 51, 103),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(11),
        ),
          child: Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person),
               Container(
                child:const  Text('Esther Wacera'),
               // child:Text(FirebaseAuth.instance.currentUser!.displayName!)
              ),
              
              
             // EditableText(controller: plController, focusNode: focusNode, style: styleeditabledr , cursorColor: cursorColor, backgroundCursorColor: backgroundCursorColor)
              Container(
               // child: const Text('esther email'),
                child: Text(FirebaseAuth.instance.currentUser!.email!)
              ),
               Container(
                child: const Text('cycle length'),
              ),
               Container(
                child: const Text('period length'),
                
              ),
              SizedBox(
                height: 20,
              ),
               ElevatedButton(onPressed: (){
                  GetAuth.instance.LogOut();
                },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              shadowColor: Color.fromARGB(26, 81, 160, 180),
            ),
             child: Text(
                'LogOut',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.lightGreen[800],
                ),
              ),),
            ],
        ),
          )
        ),
      ),
    );
  }
}