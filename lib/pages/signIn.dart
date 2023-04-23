import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:panda_period/contraints/custom.dart';
import 'package:get/get.dart';
// import 'package:panda_period/auth/custom.dart';
import 'package:panda_period/contollers/GetAuth.dart';

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
      appBar: AppBar(
        title: const Text('Panda Period'),
        
      ),
      
    
    body:Center(child:Container(
      width:350,
      height: 600,

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
      
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children:[
          
        Container(
            
            child:  Image.asset(
              'logo.jpg',
              
            ),
           ),
          const SizedBox(height: 20),
          const Text(
            'Welcome sign up',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.pinkAccent,
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
                  primary: Colors.white10,
                  shadowColor: Colors.grey,
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
              color: Colors.red, 
              fontWeight: FontWeight.bold,
              
            ),
            recognizer: TapGestureRecognizer()..onTap=(){
             Get.toNamed('/login');

            }
            )],
          )),
         GestureDetector(
          onTap: () {
           
          },
          child: const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('google.png'),
            
          ),
         )
       
        ],
      ),
    )
    ,)
    );
  }
}
