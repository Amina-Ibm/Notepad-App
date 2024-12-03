import 'package:flutter/material.dart';
import 'package:note_pad_app/providers/databaseController.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_pad_app/providers/databaseProvider.dart';
import 'package:note_pad_app/widgets/noteCard.dart';
import 'package:get/get.dart';


class viewNoteScreen extends StatelessWidget{
  viewNoteScreen({super.key});

  Widget build(BuildContext context){
    final databaseController dbController = Get.put(databaseController());
    return Scaffold(
      appBar: AppBar(
        title: Text('All Notes'),
      ),
      body: Padding(
        padding: EdgeInsets.all(6),
        child: Obx( () {
          var notesList = dbController.notes;
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                final note = notesList[index];
                return noteCard(note: note,);
              }
          );
        }

        )

        ));
  }
}