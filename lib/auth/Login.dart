import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda_period/auth/GetAuth.dart';
import 'package:panda_period/auth/custom.dart';


class LoginInPage extends StatefulWidget {
  const LoginInPage({super.key});

  @override
  State<LoginInPage> createState() => _LoginInPageState();
}

class _LoginInPageState extends State<LoginInPage> {
    var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    
    body:Center(child:Container(
      //color: Colors.redAccent,
      //  decoration: const BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage("assets/images/panda.jpg"),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      
      child:
       Column(
        
        children: <Widget>[
          
        //  Container(
          
        //  color: Color.fromARGB(255, 7, 238, 126),
        //   child:  Image.asset(
        //     'assets/images/logo.jpg',
        //     width: 150,
        //     height: 150,
        //   ),
        //  ),
          const SizedBox(height: 20),
          const Text(
            'Welcome',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 7, 235, 125),
            ),
          ),
          const SizedBox(height: 40),
           // ignore: prefer_const_constructors
           CustomText(
           hintText: 'Enter your email',
           textInputType: TextInputType.emailAddress,
            isPass: false, textController: emailController ,
           ),     
          const SizedBox(height: 20),
          // ignore: prefer_const_constructors
          CustomText(
            hintText: 'Enter your password',
           textInputType: TextInputType.emailAddress,
            isPass: true, textController: passwordController,
          ),
          const SizedBox(height: 20),
         
          
              const SizedBox(width: 90,),
              ElevatedButton(onPressed: (){
               // GetAuth.instance.
              },
          style: ElevatedButton.styleFrom(
            primary: Colors.white10,
            shadowColor: Color.fromARGB(26, 81, 160, 180),
          ),
           child: Text(
              'Log In',
              style: TextStyle(
                fontSize: 18,
                color: Colors.lightGreen[800],
              ),
            ),),
          
          const SizedBox(width: 60),
          const SizedBox(height: 20),
            Wrap(children: [RichText(text: TextSpan(
            text:"Don't have an account?",
            style: const TextStyle(
              color: Colors.grey,
            ),
            children: [TextSpan(text: ' SignUp',
            style:const TextStyle(
              color: Colors.red, 
              fontWeight: FontWeight.bold,
              //fontSize: 20
            ),
            recognizer: TapGestureRecognizer()..onTap=(){
              Get.toNamed('/signup');

            }
            )],
          )),],),
            GestureDetector(
              onTap: (() {
                GetAuth().Google_auth();
              }),
              child: const Text(
                'sign in with google',
                style: TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              )
                
                
          ),
              
            


          
          
        ]
      ),
    )
    ,)
    );
  }
}

