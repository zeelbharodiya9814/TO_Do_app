import 'package:flutter/material.dart';




class TO_DO extends StatefulWidget {
  const TO_DO({Key? key}) : super(key: key);

  @override
  State<TO_DO> createState() => _TO_DOState();
}

class _TO_DOState extends State<TO_DO> {

  String? todoData;

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> open =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
        title: Text(
          "${open['title']}",
          style: TextStyle(letterSpacing: 2, fontSize: 20, color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("New Reminder"),
                    content: TextField(
                      onChanged: (value) {
                        setState(() {
                          todoData = value;
                        });
                      },
                      autofocus: true,
                      // controller: _textFieldController,
                      decoration:
                      const InputDecoration(hintText: "Input your todolist"),
                    ),
                    actions: <Widget>[
                      MaterialButton(
                        color: Colors.blue[200],
                        textColor: Colors.black,
                        child: const Text('OK'),
                        onPressed: () {
                          if (todoData?.trim() == "") {
                            return;
                          }
                        },
                      ),
                    ],
                  );
                });
          }, icon: Icon(Icons.add,color: Colors.white,size: 30,)),
        ],
      ),
      body: Center(),);
  }
}
