import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  var firestoreDB = Firestore.instance.collection("board").snapshots();

TextEditingController nameInputController;
TextEditingController titleInputController;
TextEditingController  descriptionInputController;
  @override
  void initState(){
    super.initState();
nameInputController = TextEditingController();
titleInputController =TextEditingController();
descriptionInputController = TextEditingController();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
title: Text("TODO"),
centerTitle: true,
elevation: 5.0,
backgroundColor: Colors.black,
),
// body: getNoteListView(),
body: StreamBuilder(
  stream: firestoreDB,
  builder: (context,snapshot){
    if (!snapshot.hasData) {
      return CircularProgressIndicator();
    }else{

    }
  },

  ),
floatingActionButton: FloatingActionButton(
  onPressed: (){

  },
backgroundColor: Colors.black,
tooltip: "Add Tasks",
elevation: 0.0,
child: Icon(Icons.add,color: Colors.white,),
  ),
    );
  }





}