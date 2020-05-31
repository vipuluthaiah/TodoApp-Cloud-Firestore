import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;

  const CustomCard({Key key, this.snapshot, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var docId = snapshot.documents[index].documentID;
    var snapshotdata = snapshot.documents[index].data;
    var timetodate = new DateTime.fromMillisecondsSinceEpoch(
        snapshot.documents[index].data["timestamp"].seconds * 1000);
    var dateFormatted = new DateFormat("EEEE,MMM d,y").format(timetodate);
    // var name = snapshot.documents[index].data["name"];

    TextEditingController nameInputController =
        TextEditingController(text: snapshotdata["name"]);

    TextEditingController titleInputController =
        TextEditingController(text: snapshotdata["title"]);

    TextEditingController descriptionInputController =
        TextEditingController(text: snapshotdata["description"]);

    TextEditingController priorityInputController =
        TextEditingController(text: snapshotdata["priority"]);

    var priority = snapshot.documents[index].data["priority"];
    return Column(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.black,
          elevation: 5.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://media.giphy.com/media/RMMkV2n8iiQiIu2p9t/giphy.gif"),
              backgroundColor: Colors.transparent,
              radius: 32.0,
            ),

            // title: Text(),
            title: Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    snapshot.documents[index].data["title"],
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 21.0),
                  ),
                ),
              ],
            ),
            subtitle: Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    snapshot.documents[index].data["description"],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.clear,
                color: Colors.white,

                size: 35,
              ),
              onTap: () async {
                
                await Firestore.instance
                    .collection("board")
                    .document(docId)
                    .delete();
              },
            ),
            // onTap: () {
            //   debugPrint("ListTile Tapped");
            //   // navigateToDetail(this)
            // },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.mode_edit,
                  size: 28,
                ),
                onPressed: () async {
                  await showDialog(
                      context: context,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 11.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListView(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 15.0, bottom: 15.0, left: 15.0),
                                child: Center(
                                  // child: TextField(
                                  //   style: TextStyle(),
                                  //   decoration: InputDecoration(
                                  //     labelText: "Please Update the list", //stupid code

                                  //     labelStyle: TextStyle(
                                  //       fontSize: 20,
                                  //       fontWeight: FontWeight.bold,
                                  //     ),
                                  //   ),
                                  // ),
                                  child: Text(
                                    " Update the list",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 15.0, bottom: 15.0, left: 15.0),
                                child: TextField(
                                  autofocus: true,
                                  autocorrect: true,
                                  controller: nameInputController,
                                  style: TextStyle(),
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.person,
                                      color: Colors.redAccent,
                                    ),
                                    labelText: "Your Name",
                                    labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 15.0, bottom: 15.0, left: 15.0),
                                child: TextField(
                                  controller: titleInputController,
                                  // style: textStyle,
                                  autofocus: true,
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    labelText: 'Title',
                                    icon: Icon(
                                      Icons.title,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 15.0, bottom: 15.0, left: 15.0),
                                child: TextField(
                                  autofocus: true,
                                  autocorrect: true,
                                  controller: descriptionInputController,
                                  style: TextStyle(),
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.note_add,
                                      color: Colors.redAccent,
                                    ),
                                    labelText: "Description",
                                    labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 15.0, bottom: 15.0, left: 15.0),
                                child: TextField(
                                  autofocus: true,
                                  autocorrect: true,
                                  controller: priorityInputController,
                                  style: TextStyle(),
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.add_alert,
                                      color: Colors.redAccent,
                                    ),
                                    labelText: "Priority",
                                    labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: RaisedButton(
                                        textColor: Colors.white,
                                        color: Colors.green,
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Update',
                                          textScaleFactor: 1.5,
                                        ),
                                        onPressed: () {
                                          if (titleInputController
                                                  .text.isNotEmpty &&
                                              nameInputController
                                                  .text.isNotEmpty &&
                                              descriptionInputController
                                                  .text.isNotEmpty &&
                                              priorityInputController
                                                  .text.isNotEmpty) {
                                            Firestore.instance
                                                .collection("board")
                                                .document(docId)
                                                .updateData({
                                              "name": nameInputController.text,
                                              "title":
                                                  titleInputController.text,
                                              "description":
                                                  descriptionInputController
                                                      .text,
                                              "priority":
                                                  priorityInputController.text,
                                              "timestamp": new DateTime.now()
                                            }).then((response) {
                                              Navigator.pop(context);
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                      child: RaisedButton(
                                        textColor: Colors.white,
                                        color: Colors.red,
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Cancle',
                                          textScaleFactor: 1.5,
                                        ),
                                        onPressed: () {
                                          nameInputController.clear();
                                          titleInputController.clear();
                                          descriptionInputController.clear();
                                          priorityInputController.clear();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Duration: "),
                  Text((dateFormatted == null) ? "" : dateFormatted),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.add_alert),
              Text(
                "      $priority",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
