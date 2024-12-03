import 'package:flutter/material.dart';
import 'package:note_pad_app/screens/viewNotesScreen.dart';
import 'package:get/get.dart';

class sideDrawer extends StatelessWidget{
  sideDrawer({super.key});

  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Text('Notepad',
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,


            ),
            ),
          ListTile(
            title: Text('Add Note'),
            onTap: () {
             Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('View Notes'),
            onTap: () {
              Get.to(viewNoteScreen());
            },
          ),

        ],
      ),
    );
  }
}