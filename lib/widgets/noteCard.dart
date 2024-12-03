import 'package:flutter/material.dart';
import 'package:note_pad_app/providers/databaseController.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:note_pad_app/providers/databaseProvider.dart';
import 'package:note_pad_app/screens/addNoteScreen.dart';
import '../models/note.dart';
import 'package:get/get.dart';

class noteCard extends StatelessWidget{
  noteCard({super.key, required this.note});
  final Note note;

  Widget build(BuildContext context){
    final databaseController dbProvider = Get.put(databaseController());
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(note.title,
                  style: Theme.of(context).textTheme.displayLarge,),
                Spacer(),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      Get.to(addNoteScreen(note: note,));

                    } else if (value == 'delete') {
                      dbProvider.deleteNoteFromDatabase(note);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Colors.blue),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 8),
            Text(note.Desc,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              style: Theme.of(context).textTheme.displaySmall,),

          ],
        ),
      ),
    );
  }
}