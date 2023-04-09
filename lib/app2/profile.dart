import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:panda_period/app2/profile2.dart';
import 'package:panda_period/app2/usermodel.dart';
import 'package:panda_period/contollers/fireget.dart';
import 'package:panda_period/contollers/profileco.dart';
class ProfileTabdisplay extends StatefulWidget {
  const ProfileTabdisplay({Key? key}) : super(key: key);

  @override
  State<ProfileTabdisplay> createState() => _ProfileTabdisplayState();
}

class _ProfileTabdisplayState extends State<ProfileTabdisplay> {
  late DateTime _selectedDate;
    final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _periodLengthController = TextEditingController();
  final _periodCycleController = TextEditingController();
  final _startDateController = TextEditingController();
  final _reminderController = TextEditingController();



  

  final repo = Get.put(FireRepo());
  

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    
  }


  @override
  Widget build(BuildContext context) {
    final userdata = Get.put(userprofile());

    String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
  if (!emailRegExp.hasMatch(value)) {
    return 'Invalid email address';
  }
  return null;
}
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
            actions: [
              IconButton(
                      icon: const Icon(
              Icons.edit,
              color: Colors.white,
                      ),
                      onPressed: () {
              Get.toNamed('/Profile');
                      },
                    ),]
            ),
      body: Container(
        margin: EdgeInsets.zero,
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
              alignment: Alignment.center,
              padding:const  EdgeInsets.all(double.infinity),
              child: FutureBuilder(
                future: userdata.getUserDetails(),

                builder: (context, snapshot) {
                  
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserData userData =snapshot.data as UserData;
                    return  Column(
                      children: [
                       SizedBox(height: 90,),
                  const CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('panda.png'),

                  ),
                  SizedBox(height: 30,),
                        Container(
                          padding:const EdgeInsets.all(double.infinity),
                          child: SingleChildScrollView(
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const SizedBox(height: 20.0),
                                          const Text(
                          'Profile',
                          style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 20.0),
                                          TextFormField(
                                            initialValue: userData.name  ,
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                                          ),
                                          const SizedBox(height: 20.0),
                                         TextFormField(
                                          initialValue: userData.email,
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: emailValidator,
                          ),
                                  
                                          const SizedBox(height: 20.0),
                                          TextFormField(
                                            
                          controller: _periodLengthController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Period length (in days)',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your period length';
                            }
                            return null;
                          },
                                          ),
                                          const SizedBox(height: 20.0),
                                          TextFormField(
                          controller: _periodCycleController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Cycle length (in days)',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your cycle length';
                            }
                            return null;
                          },
                                          ),
                                          const SizedBox(height: 20.0),
                                          const Text(
                          'Select period start date:',
                          style: TextStyle(fontSize: 16.0),
                                          ),
                                          const SizedBox(height: 10.0),
                                          DatePickerWidget(
                          initialDate: userData.startDate,
                          onDateSelected: (date) {
                            setState(() {
                              _selectedDate = date;
                            });
                          },
                                          ),
                                          const SizedBox(height: 20.0),
                                          TextFormField(
                          controller: _reminderController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Drink water reminder (in hours)',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a reminder interval';
                            }
                            return null;
                          },
                                          ),
                                          const SizedBox(height: 20.0),
                                          ElevatedButton(
                                    onPressed: () {
                                      if (!_formKey.currentState!.validate()) return;
                                      
                                    final uid = FirebaseAuth.instance.currentUser?.uid;
                             final user = UserData(
                              name: _nameController.text.trim(), 
                              email: _emailController.text.trim(),
                              periodLength: int.parse(_periodLengthController.text.trim()), 
                              periodCycle: int.parse(_periodCycleController.text.trim()),
                              startDate: _selectedDate,
                              reminder: int.parse(_reminderController.text.trim())
                              );
                        
                              FireRepo.instance.createUser(user);
                              
                                    
                                      
                                    },
                                    child: const Text('Save'),
                                  ),
                                  ]
                                  ),
                                  ),
                                  ),
                        ),
                      ],
                    );
                  } else if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()),);
                    
                  }else {
                    return const Center(child: Text('something went wrong'),);
                  }
                  
                } else{
                  return const Center(child: CircularProgressIndicator.adaptive(),); 
                }
                }
              )
            ),
          );
        
      

}
}