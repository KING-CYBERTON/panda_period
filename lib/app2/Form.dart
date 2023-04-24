// ignore_for_file: unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:panda_period/app2/usermodel.dart';
import 'package:panda_period/contollers/fireget.dart';
class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late DateTime selectedDate;
    final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _periodLengthController = TextEditingController();
  final _periodCycleController = TextEditingController();
  final _startDateController = TextEditingController();
  final _reminderController = TextEditingController();



  bool _isLoading = false;

  final repo = Get.put(FireRepo());
  

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    
  }


  @override
  Widget build(BuildContext context) {

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
        title: Text('Profile'),
      ),
      body:
         SingleChildScrollView(
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
                    initialDate: selectedDate,
                    onDateSelected: (date) {
                      setState(() {
                        selectedDate = date;
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
      startDate: selectedDate,
      reminder: int.parse(_reminderController.text.trim())
      );

      FireRepo.instance.createUser(user);
      Get.offAllNamed('/Homescreen');
      
            
              
            },
            child: const Text('Save'),
          ),
          ]
          ),
          ),
          ),
        
      
);
}
}

class DatePickerWidget extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateSelected;

  const DatePickerWidget({
    Key? key,
    required this.initialDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onDateSelected(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Start Date: ',
              style: TextStyle(fontSize: 18),
            ),
            TextButton(
              onPressed: () => _selectDate(context),
              child: Text(
                DateFormat.yMd().format(_selectedDate),
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}






