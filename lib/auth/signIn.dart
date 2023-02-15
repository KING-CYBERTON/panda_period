import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda_period/auth/custom.dart';
import 'package:panda_period/auth/GetAuth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    
    body:Center(child:Container(
      //color: Colors.white,
      //  decoration: const BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage("assets/images/panda.jpg"),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      
      child: Column(
        
        children:[
          
          Image.asset(
            'assets/images/logo.jpg',
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 20),
          const Text(
            'Welcome sign up',
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
            isPass: false,
             textController: emailController,
          ),
          const SizedBox(height: 20),
          // ignore: prefer_const_constructors
          CustomText(
          
             hintText: 'Enter your password',
           textInputType: TextInputType.emailAddress,
            isPass: true,
             textController: passwordController,
          ),
          const SizedBox(height: 20),
         
          
          const SizedBox(width: 60),
          ElevatedButton(onPressed: (){
            GetAuth.instance.CreateUser(emailController.text.trim(), passwordController.text.trim());
          },
          
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.white10,
                ),
          child: Text('Sign Up',style: TextStyle( fontSize: 18,
                color: Colors.lightGreen[800], ),
                 )
                ),
            
          const SizedBox(height: 20),
          RichText(text: TextSpan(
            text:'Have an account?',
            style: const TextStyle(
              color: Colors.grey,
            ),
            children: [TextSpan(text: '  LogIn',
            
            style:const TextStyle(
              color: Colors.amber, 
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
            recognizer: TapGestureRecognizer()..onTap=(){
              Get.toNamed('/login');

            }
            )],
          )),
        //  const CircleAvatar(
        //   radius: 30,
        //   backgroundImage: AssetImage(''),
            
        //   ),
       
        ],
      ),
    )
    ,)
    );
  }
}
