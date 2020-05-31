import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'card.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  var firestoreDB = Firestore.instance.collection("board").snapshots();

  TextEditingController nameInputController;
  TextEditingController titleInputController;
  TextEditingController descriptionInputController;
  TextEditingController priorityInputController;


  @override
  void initState() {
    super.initState();
    nameInputController = TextEditingController();
    titleInputController = TextEditingController();
    descriptionInputController = TextEditingController();
    priorityInputController =  TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text("TODO LIST"),
        centerTitle: true,
        elevation: 5.0,
        backgroundColor: Colors.black,
      ),

// body: getNoteListView(),
      body: StreamBuilder(
        stream: firestoreDB,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, int index) {
                  return CustomCard(snapshot: snapshot.data, index: index);
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        backgroundColor: Colors.redAccent,
        tooltip: "Add Tasks",
        elevation: 0.0,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _showDialog(BuildContext context) async {
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
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                  child: Center(
                    // child: TextField(
                    //   style: TextStyle(),
                    //   decoration: InputDecoration(
                    //     labelText: "Please Add Your Todo List",
                    //     labelStyle: TextStyle(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    child: Text (
                      "Add Your List",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                                padding: EdgeInsets.only(
                                    top: 15.0, bottom: 15.0, left: 15.0),
                                child: TextField(
                                  autofocus: true,
                                  autocorrect: true,
                                  controller: priorityInputController,
                                  style: TextStyle(),
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_alert),
                                    labelText: "Priority",
                                    labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                       Flexible(
                        child: SizedBox(
                          height: 80,
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
                                descriptionInputController.text.isNotEmpty&&
                                priorityInputController.text.isNotEmpty
                                ) {
                              Firestore.instance.collection("board").add({
                                "name": nameInputController.text,
                                "title": titleInputController.text,
                                "description": descriptionInputController.text,
                                "priority":priorityInputController.text,
                                "timestamp": new DateTime.now()
                              }).then((response) {
                                print(response.documentID);
                                Navigator.pop(context);
                                nameInputController.clear();
                                titleInputController.clear();
                                descriptionInputController.clear();
                                priorityInputController.clear();
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
  }
}
