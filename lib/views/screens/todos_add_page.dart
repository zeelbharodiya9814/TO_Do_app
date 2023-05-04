import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:to_do_app_pr/model/icon_model.dart';

import '../../helper/firebase_firestore_DB_helper.dart';
import '../../model/color_model.dart';
import '../../res/color_list.dart';
import '../../res/icon_list.dart';
import '../../widget/color_picker.dart';

class Add_note extends StatefulWidget {
  const Add_note({Key? key}) : super(key: key);

  @override
  State<Add_note> createState() => _Add_noteState();
}

class _Add_noteState extends State<Add_note> {
  var selectionColor;
  late final ValueChanged<ModelColor> parentActions;

  var selectionIcon;
  var selectedIconKey;
  List<ModelIcon> allIcons = listIcons;

  String? title;

  // String? note;
  Uint8List? image;
  bool select = true;
  bool selecticon = true;

  // final ImagePicker pick = ImagePicker();

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();

  GlobalKey<FormState> imsertformKey = GlobalKey<FormState>();

  String date = DateTime.now().toString().split(" ")[0];

  @override
  void initState() {
    // selectionColor = selectionColor;
    // parentActions = parentActions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
        title: Text(
          "Add New",
          style: TextStyle(letterSpacing: 2, fontSize: 20, color: Colors.white),
        ),
        actions: [
          Container(
            height: 40,
            child: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              label: Text("Save"),
              onPressed: () async {
                if (imsertformKey.currentState!.validate()) {
                  imsertformKey.currentState!.save();

                  Map<String, dynamic> data = {
                    'title': title,
                    // 'note': note,
                    'date': date,
                    'color': (select)
                        ? Color(0xffFFFFFF).toString()
                        : selectionColor.toString(),
                    'icon': selectionIcon.toString(),
                  };

                  await FirestoreDBHelper.firestoreDBHelper
                      .insert(data: data);
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Record inserted successfully..."),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  print("validate successfully...");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Record insertion failed"),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }

                titlecontroller.clear();
                // notecontroller.clear();

                setState(() {
                  title = null;
                  selectionColor = null;
                  // image = null;
                });
              },
            ),
          ),
          SizedBox(width: 8,),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: imsertformKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0, right: 13),
                    child: Row(
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Kanit'),
                        ),
                        Spacer(),
                        Text(
                          "${date}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Container(
                      // height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: titlecontroller,
                        // style: TextStyle(color: Colors.white),
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter title...";
                          }
                        },
                        onSaved: (val) {
                          setState(() {
                            title = val;
                          });
                        },
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Enter your category name",
                            hintStyle: TextStyle(
                                color: Colors.grey[400], fontSize: 17),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0, right: 13),
                    child: Row(
                      children: [
                        Text(
                          'Color',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Kanit'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        height: 215,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 60,
                                    childAspectRatio: 1 / 1,
                                    crossAxisSpacing: 0,
                                    crossAxisCount: 5,
                                    mainAxisSpacing: 0),
                            itemCount: listColor.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) => Container(
                                  // key: ValueKey(listColor[index].keyColor),
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(10),
                                  child: Center(
                                      child: GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        color: Color.fromRGBO(
                                            listColor[index].r,
                                            listColor[index].g,
                                            listColor[index].b,
                                            listColor[index].alpha),
                                      ),
                                      width: 30,
                                      height: 30,
                                      child: selectionColor ==
                                              Color.fromRGBO(
                                                  listColor[index].r,
                                                  listColor[index].g,
                                                  listColor[index].b,
                                                  listColor[index].alpha)
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            )
                                          : Container(),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        select = false;
                                        selectionColor = Color.fromRGBO(
                                            listColor[index].r,
                                            listColor[index].g,
                                            listColor[index].b,
                                            listColor[index].alpha);
                                      });
                                      ModelColor color = listColor[index];
                                      parentActions(color);
                                      // Navigator.of(context).pop();
                                    },
                                  )),
                                )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0, right: 13),
                    child: Row(
                      children: [
                        Text(
                          'Icon',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Kanit'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        height: 300,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 60,
                                    childAspectRatio: 1 / 1,
                                    crossAxisCount: 5,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 10),
                            itemCount: allIcons.length,
                            itemBuilder: (_, index) => Container(
                                  key: ValueKey(allIcons[index].iconID),
                                  padding: const EdgeInsets.all(10),
                                  child: Center(
                                    child: IconButton(
                                      // give the selected icon a different color
                                      color: selectedIconKey ==
                                              allIcons[index].iconID
                                          ? Colors.orange
                                          : Colors.grey,
                                      iconSize: 30,
                                      icon: Icon(
                                        allIcons[index].icon,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          selecticon = false;
                                          selectionIcon = allIcons[index].icon;
                                          selectedIconKey =
                                              allIcons[index].iconID;
                                        });
                                        int iconID = allIcons[index].iconID;
                                        // parentAction(iconID);
                                        //Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(left: 25.0),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Container(
      //         height: 40,
      //         child: FloatingActionButton.extended(
      //           onPressed: () {
      //             titlecontroller.clear();
      //             // notecontroller.clear();
      //
      //             setState(() {
      //               title = null;
      //               // note = null;
      //             });
      //
      //             Navigator.pop(context);
      //           },
      //           label: Text("Cancel"),
      //         ),
      //       ),
      //       SizedBox(
      //         width: 15,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
