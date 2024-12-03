import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_pad_app/models/note.dart';
import 'package:note_pad_app/providers/databaseProvider.dart';
import 'package:note_pad_app/widgets/sideDrawer.class.dart';
import 'package:note_pad_app/providers/databaseController.dart';
import 'package:get/get.dart';


class addNoteScreen extends StatefulWidget {
  addNoteScreen({super.key, this.note});
  final Note? note;

  @override
  State<addNoteScreen> createState() => _addNoteScreenState();
}

class _addNoteScreenState extends State<addNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  late var noteTitleController = TextEditingController();
  late var noteDescController = TextEditingController();
  int? noteId;

  @override
  void initState() {
    super.initState();
    noteTitleController = TextEditingController(text: widget.note?.title ?? '');
    noteDescController = TextEditingController(text: widget.note?.Desc ?? '');
    noteId = widget.note?.id;
  }

  @override
  void dispose() {
    noteTitleController.dispose();
    noteDescController.dispose();
    super.dispose();
  }

  String? _validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title';
    }
    return null;
  }

  String? _validateDesc(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a note';
    }
    return null;
  }

  void _submitForm(BuildContext context, dynamic dbProvider) {
    if (_formKey.currentState?.validate() ?? false) {
      final note = Note(
        id: noteId,
          title: noteTitleController.text,
          Desc: noteDescController.text);
      dbProvider.addNoteToDatabase(note);

      Get.snackbar(
        "Success",
        "Note Saved", // Message text
        snackPosition: SnackPosition.BOTTOM,
      );

      _clearForm();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields')),
      );
    }
  }

  void _clearForm() {
    noteTitleController.clear();
    noteDescController.clear();
  }

  Widget build(BuildContext context) {
    final databaseController dbprovider = Get.put(databaseController());
    return Scaffold(
        appBar: AppBar(
          title: Text('Add note'),
        ),
        drawer: sideDrawer(),
        body:
        Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary,
                image: DecorationImage(

                    image: AssetImage('assets/images/note-bg.png'),
                    colorFilter: ColorFilter.mode(
                        Theme
                            .of(context)
                            .colorScheme
                            .primary,
                        BlendMode.overlay),
                    scale: 0.4
                    ,
                    //fit: BoxFit.cover
                    alignment: Alignment.center
                )
            ),
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(height: 15,),
                SizedBox(
                  width: 270,
                  height: 80,
                  child: TextFormField(

                    controller: noteTitleController,
                    decoration: InputDecoration(
                      label: Text('Add Title'),
                    ),
                    validator: _validateTitle,

                  ),
                ),
                //SizedBox(height: 10,),
                SizedBox(
                  width: 270,
                  height: 120,
                  child: TextFormField(
                    controller: noteDescController,
                    decoration: InputDecoration(
                      label: Text('Add Note'),
                    ),
                    validator: _validateDesc,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 1,
                  ),
                ),
                //SizedBox(height: 20,),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          _submitForm(context, dbprovider);
                        },
                        child: Text('Save Note')
                    ),
                    SizedBox(width: 20,),
                    TextButton(
                        onPressed: () {
                          _clearForm();
                        },
                        child: Text('Clear')
                    ),

                  ],
                )
              ],

            ),
          ),
        )

    );
  }
}




