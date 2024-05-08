import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite_cipher_encryption/dummy_name.dart';
import 'package:sqflite_cipher_encryption/helper/user_dao.dart';
import 'package:sqflite_cipher_encryption/model/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<User> userList = [];
  late Future future;

  Future getData() async {
    final listOfMap = await UserDao.getData();
    for (var map in listOfMap) {
      User user = User.fromMap(map);
      userList.add(user);
    }
  }

  @override
  void initState() {
    future = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Random random = Random();
          int age = random.nextInt(40) + 15;
          int randName = random.nextInt(10);
          String name = DummyNames.dummyUserNames[randName];
          await UserDao.insertData(User(name: name, age: age).toMap());
          userList.add(User(name: name, age: age));
          setState(() {});
        },
        child: const Text('Add Dummy User'),
      ),
      appBar: AppBar(
        title: const Text('User'),
      ),
      body: FutureBuilder(
          future: future,
          builder: (context, ss) {
            if (ss.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (ss.hasError) {
              return const Center(child: Text("Some thing went wrong"));
            } else {
              return userList.isNotEmpty
                  ? ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text(userList[index].name),
                          trailing: Text(userList[index].age.toString()),
                        );
                      })
                  : const Center(
                      child: Text("Sorry, No Data to show"),
                    );
            }
          }),
    );
  }
}
