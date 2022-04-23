import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_example/custom_widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_example/add_new_record.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final userBox = Hive.box('user_box');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddNewRecord());
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
          valueListenable: userBox.listenable(),
          builder: (context, Box box, widget) {
            if (box.isEmpty) {
              return Center(
                child: textView('No record found'),
              );
            }
            return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                itemCount: box.length,
                itemBuilder: (con, index) {
                  return listItem(box.getAt(index));
                });
          }),
    );
  }

  listItem(item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textView('Name:' + item['name']),
                textView('Email: ' + item['email']),
                textView('Mobile: ' + item['mobile']),
                textView('Address: ' + item['address']),
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.to(() => AddNewRecord(id: item['id']));
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      userBox.delete(item['id']);

                      Get.snackbar('Success', 'Record Deleted Successfully...',
                          snackPosition: SnackPosition.BOTTOM);
                    },
                    icon: const Icon(Icons.delete))
              ],
            )
          ],
        ),
      ),
    );
  }
}
