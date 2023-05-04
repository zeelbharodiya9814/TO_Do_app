import 'package:flutter/material.dart';

import '../../helper/firebase_firestore_DB_helper.dart';
import '../../model/color_model.dart';
import '../../model/icon_model.dart';
import '../../res/color_list.dart';
import '../../res/icon_list.dart';

class Update_note extends StatefulWidget {
  const Update_note({Key? key}) : super(key: key);

  @override
  State<Update_note> createState() => _Update_noteState();
}

class _Update_noteState extends State<Update_note> {

  var selectionColor;
  String? title;
  String? note;
  var updatecolor;
  bool select = true;


  var selectionIcon;
  var selectedIconKey;
  List<ModelIcon> allIcons = listIcons;
  bool selecticon = true;



  TextEditingController titlecontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();

  GlobalKey<FormState> updateformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> allDocsupdate =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // UpdateandValidate(allId: allDocs[i].id);
    // var allId = allDocsupdate['id'];
    titlecontroller.text = allDocsupdate['title'];
    updatecolor = allDocsupdate['color'];
    // notecontroller.text = allDocsupdate['note'];

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
        title: Text(
          "Edit",
          style: TextStyle(letterSpacing: 2, fontSize: 20, color: Colors.white),
        ),
        actions: [
          Container(
            height: 40,
            child: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              label: Text("Update"),
              onPressed: () async {
                if (updateformKey.currentState!.validate()) {
                  updateformKey.currentState!.save();

                  var allId = allDocsupdate['id'];

                  await FirestoreDBHelper.firestoreDBHelper
                      .update(id: allId, title: title!,color: (select) ? allDocsupdate['color'] : selectionColor.toString());

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Record updated successfully..."),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  print("validate successfully...");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Record updation failed"),
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
      body:  SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: updateformKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0,right: 13),
                    child: Row(
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Kanit'),),
                        Spacer(),
                        Text(
                          "${allDocsupdate['date']}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
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
                          hintStyle:
                          TextStyle(color: Colors.grey[400], fontSize: 17),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0,right: 13),
                    child: Row(
                      children: [
                        Text(
                          'Color',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Kanit'),),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        height: 250,
                        child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 60,
                                childAspectRatio: 1 / 1,
                                crossAxisSpacing: 0,
                                crossAxisCount: 5,
                                mainAxisSpacing: 0),
                            itemCount: listColor.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) => Container(
                              // key: ValueKey(listColor[index].keyColor),
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
                                          : Container(),),
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
                                      // parentActions(color);
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
      //
      //     ],
      //   ),
      // ),
    );
  }
}
