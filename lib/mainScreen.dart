import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/addTodo.dart';

class Mainscreen extends StatefulWidget {
  // void Function(String data) addData;

  Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List<String> todoList = ['Learn Coding', 'Practice Coding'];

  // void addData(String entry) {
  //   if (!todoList.contains(entry)) {
  //     todoList.add(entry);
  //   }
  // }

  String data = 'dummy';

  void changeText(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('items', todoList);
    if (!todoList.contains(data)) {
      todoList.add(data);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SafeArea(
          child: Drawer(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Drawer Data"),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text("Todo"),
          centerTitle: true,
          actions: [
            InkWell(
              splashColor: Colors.orange[100],
              enableFeedback: false,
              onTap: () {
                print("+ is clicked");
                showModalBottomSheet(
                    context: context,
                    backgroundColor: const Color.fromARGB(255, 255, 237, 183),
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Container(
                          height: 160,
                          child: Addtodo(
                            changeText: changeText,
                          ),
                        ),
                      );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add,
                  color: Colors.red,
                  size: 45,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          child: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(todoList[index]),
                leading: Icon(Icons.arrow_circle_right_outlined),
              );
            },
          ),
          // child: Text('$data'),
        ));
  }
}
