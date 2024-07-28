import 'package:flutter/material.dart';
import 'package:todo/addTodo.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
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
                    return Container(
                      height: 200,
                      child: Addtodo(),
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
      body: InkWell(
        onTap: () {
          print('Clicked');
        },
        child: Text('Press here to see action'),
      ),
    );
  }
}
