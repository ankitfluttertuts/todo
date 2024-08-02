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
  List<String> todoList = [];

  // void addData(String entry) {
  //   if (!todoList.contains(entry)) {
  //     todoList.add(entry);
  //   }
  // }

  void add(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!todoList.contains(data)) {
      todoList.add(data);
      await prefs.setStringList('items', todoList);
    }
    setState(() {});
    Navigator.pop(context);
  }

  void loadText() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    todoList = prefs.getStringList("items") ?? [];
    print('data loaded');
    setState(() {});
  }

  void deleteData(String text) async {
    todoList.remove(text);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('items', todoList);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    loadText();
    super.initState();
  }

  void editText(int index, String oldData, String newData) {
    if (oldData != newData) {
      todoList.removeAt(index);
      todoList.insert(index, newData);
      setState(() {});
    }
  }

  void showingDialog(int index, String oldItem) {
    TextEditingController formData = new TextEditingController(text: oldItem);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter the Data'),
            content: TextField(
              controller: formData,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    editText(index, oldItem, formData.text);
                    Navigator.pop(context);
                  },
                  child: Text('Edit')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'))
            ],
          );
        });
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
                            changeText: add,
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
                  title: Row(
                    children: [
                      Flexible(flex: 7, child: Text(todoList[index])),
                      Flexible(
                        flex: 3,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  print('edit');
                                  showingDialog(index, todoList[index]);
                                  // Navigator.pop(context);
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  deleteData(todoList[index]);
                                },
                                icon: Icon(Icons.delete))
                          ],
                        ),
                      )
                    ],
                  ),
                  // title: Text(todoList[index]),
                  leading: Icon(Icons.arrow_circle_right_outlined));
            },
          ),
          // child: Text('$data'),
        ));
  }
}
