import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MainPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> listTodo = [];

  void addTodo(String item) {
    setState(() {
      listTodo.add(item);
    });
  }

  void deleteTodo(int index) {
    setState(() {
      listTodo.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListBook"),
        backgroundColor: Color.fromARGB(255, 48, 148, 230),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.account_circle),
          iconSize: 30,
        ),
      ),
      //drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String newItem = '';
              return AlertDialog(
                title: Text('Add Item'),
                content: TextFormField(
                  onChanged: (value) {
                    newItem = value;
                  },
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      addTodo(newItem);
                      Navigator.pop(context);
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          size: 40,
          color: Color.fromARGB(255, 245, 247, 245),
        ),
      ),
      body: ListView.builder(
        itemCount: listTodo.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(listTodo[index]),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              deleteTodo(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Item deleted'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                Icons.delete,
                size: 30,
                color: Colors.black54,
              ),
            ),
            child: ListTile(
              leading: Icon(Icons.search_off_outlined),
              title: Text(
                "${listTodo[index]}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
          );
        },
      ),
    );
  }
}
