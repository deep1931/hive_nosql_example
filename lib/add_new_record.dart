import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_example/custom_widgets.dart';

import 'helper.dart';

class AddNewRecord extends StatefulWidget {
  var id;

  AddNewRecord({Key? key, this.id}) : super(key: key);

  @override
  State<AddNewRecord> createState() => _AddNewRecordState();
}

class _AddNewRecordState extends State<AddNewRecord> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final userBox = Hive.box('user_box');

  @override
  void initState() {
    super.initState();

    if (widget.id != null) {
      final user = userBox.get(widget.id);

      if (kDebugMode) {
        print(user);
      }

      if (user != null) {
        nameController.text = user['name'];
        mobileController.text = user['mobile'];
        emailController.text = user['email'];
        addressController.text = user['address'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new record'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              textField(
                  title: 'Name',
                  controller: nameController,
                  onChange: (value) {}),
              textField(
                  title: 'Mobile Number',
                  controller: mobileController,
                  isNumber: true,
                  maxLen: 10,
                  onChange: (value) {}),
              textField(
                  title: 'Email Id',
                  controller: emailController,
                  onChange: (value) {},
                  maxLen: 100),
              textField(
                  title: 'Address',
                  controller: addressController,
                  onChange: (value) {},
                  maxLen: 100,
                  maxLines: 3),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  saveRecord();
                },
                child: const Text('Save Record'),
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  saveRecord() {
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter name');
      return;
    }

    if (mobileController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter mobile number');
      return;
    }
    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter email id');
      return;
    }
    if (addressController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter address');
      return;
    }

    int id = 0;
    if (widget.id == null) {
      id = getRandomNumber();
    } else {
      id = widget.id;
    }

    Map<String, dynamic> record = {};

    record['id'] = id;
    record['name'] = nameController.text;
    record['mobile'] = mobileController.text;
    record['email'] = emailController.text;
    record['address'] = addressController.text;

    userBox.put(id, record);

    Get.snackbar('Success', 'Record Saved Successfully...',
        snackPosition: SnackPosition.BOTTOM);

    clear();
  }

  clear() {
    setState(() {
      nameController.text = '';
      emailController.text = '';
      mobileController.text = '';
      addressController.text = '';
    });
  }
}
