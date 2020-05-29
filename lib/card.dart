import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;

  const CustomCard({Key key, this.snapshot, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var docId = snapshot.documents[index].documentID;
    var snapshotdata = snapshot.documents[index].data;
    // var timetodate = new DateTime.fromMillisecondsSinceEpoch(
    //     snapshot.documents[index].data["timestamp"].seconds * 1000);
    // var dateFormatted = new DateFormat("EEEE,MMM d,y").format(timetodate);
    // var name = snapshot.documents[index].data["name"];

    TextEditingController nameInputController =
        TextEditingController(text: snapshotdata["name"]);

    TextEditingController titleInputController =
        TextEditingController(text: snapshotdata["title"]);

    TextEditingController descriptionInputController =
        TextEditingController(text: snapshotdata["description"]);

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
            title: Text(
              snapshot.documents[index].data["title"],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0),
            ),
            subtitle: Text(
              snapshot.documents[index].data["description"],
              style: TextStyle(color: Colors.white),
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.remove_circle,
                color: Colors.white,
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
              icon: Icon(Icons.mode_edit,
              size: 15,
              ),
             onPressed:()async{
               await  showDialog(
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
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                  child: TextField(
                  
                    style: TextStyle(),
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Please Update the list",
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    controller: nameInputController,
                    style: TextStyle(),
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Your Name",
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                  child: TextField(
                    controller: titleInputController,
                    // style: textStyle,
                    autofocus: true,
                    autocorrect: true,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      icon: Icon(Icons.title),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    controller: descriptionInputController,
                    style: TextStyle(),
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Description",
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
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            if (titleInputController.text.isNotEmpty &&
                                nameInputController.text.isNotEmpty &&
                                descriptionInputController.text.isNotEmpty) {
                              Firestore.instance.collection("board").add({
                                "name": nameInputController.text,
                                "title": titleInputController.text,
                                "description": descriptionInputController.text,
                                "timestamp": new DateTime.now()
                              }).then((response) {
                                print(response.documentID);
                                Navigator.pop(context);
                                nameInputController.clear();
                                titleInputController.clear();
                                descriptionInputController.clear();
                              }).catchError((error) => print(error));
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
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            nameInputController.clear();
                            titleInputController.clear();
                            descriptionInputController.clear();
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
        )
        );
             }
             
              )
          ],
        )
      ],
    );
  }
}
