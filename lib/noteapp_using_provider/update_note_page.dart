import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_database.dart';
import 'package:note_app_with_provider/main.dart';
import 'note_model.dart';
import 'note_provider.dart';

class UpdateNote extends StatefulWidget {
  String mTitle;
  String mDesc;
  String mTime;
  int? id;

  UpdateNote({required this.mTitle, required this.mDesc,required this.mTime, this.id});

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  // late AppDatabase myDB;
  // List<NoteModel> arrNotes = [];
  late String newTitle;
  late String newDesc;
  late String newTime;

  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // myDB = AppDatabase.db;
    this.newTitle = widget.mTitle.toString();
    this.newDesc = widget.mDesc.toString();
    this.newTime = widget.mTime.toString();
    // getNotes();
    //addNotes(titleController.text, descController.text);
  }

  void getInitialNotes(BuildContext context) {
    Provider.of<NoteProvider>(context, listen: false).fetchNote();
  }

  void updateNote(
      String title, String desc, String time, BuildContext context) {
    Provider.of<NoteProvider>(context, listen: false).updateNote(
        NoteModel(note_id: widget.id, title: title, desc: desc, time: time));
  }

  void deleteNote(int id, BuildContext context) {
    Provider.of<NoteProvider>(context, listen: false).deleteNote(id);
  }

  /*void getNotes() async {
    arrNotes = await myDB.fetchAllNotes();
    setState(() {});
  }*/

  /*void addNotes(String title, String desc) async {
    bool check = await myDB.addNote(NoteModel(title: title, desc: desc));
    if (check) {
      arrNotes = await myDB.fetchAllNotes();
      setState(() {});
    }*/ /*
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF252525),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(26.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color(0XFF3B3B3B),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios_new,
                              color: Color(0XFFFFFFFF)),
                        )),
                    SizedBox(
                      width: 100,
                    ),
                    InkWell(
                      onTap: () async {
                       // var time = DateTime.now().toString();
                        var date = DateTime.now();
                        String time = "${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute}:${date.second}";

                        if (newTitle != '' && newDesc != '') {
                          /* await myDB.updateNote(NoteModel(
                              note_id: widget.id,
                              title: newTitle,
                              desc: newDesc));*/
                          updateNote(newTitle, newDesc, time, context);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotesPage()));
                          getInitialNotes(context);
                          //getNotes();
                        }
                      },
                      child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Color(0XFF3B3B3B),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.save,
                                  color: Colors.green.shade500, size: 26),
                              Text(
                                'Update',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.green.shade500,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color(0XFF3B3B3B),
                      ),
                      child: InkWell(
                          onTap: () async {
                            deleteNote(widget.id!, context);
                            getInitialNotes(context);

                            //  await myDB.deleteNote(widget.id!);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotesPage()));
                            //getNotes();
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 26,
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Align(
                   alignment: Alignment.centerRight,
                  child: Text(newTime,style: TextStyle(color: Colors.white,fontSize: 18),)),
              SizedBox(
                height: 24,
              ),
              Form(
                child: TextFormField(
                  initialValue: newTitle,
                  onChanged: (val) {
                    newTitle = val;
                  },
                  style: TextStyle(color: Color(0XFFFFFFFF)),
                  // controller: titleController, //titleController != '' ? TextEditingController(text: widget.mTitle) : titleController,
                  decoration: InputDecoration(
                      hintText: 'Title here!',
                      hintStyle: TextStyle(color: Color(0XFF8C8C8C)),
                      label: Text('Title',
                          style: TextStyle(
                              fontSize: 40, color: Color(0XFF8C8C8C))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: BorderSide(color: Colors.transparent))),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                child: TextFormField(
                  initialValue: newDesc,
                  onChanged: (val) {
                    newDesc = val;
                  },
                  style: TextStyle(color: Color(0XFFFFFFFF)),
                  maxLines: 15,

                  // controller: descController,//descController != '' ? TextEditingController(text: widget.mDesc) : descController,
                  decoration: InputDecoration(
                      hintText: 'Type something...',
                      hintStyle: TextStyle(color: Color(0XFF8C8C8C)),
                      label: Text('Description',
                          style: TextStyle(
                              fontSize: 26, color: Color(0XFF8C8C8C))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: BorderSide(color: Colors.transparent))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
