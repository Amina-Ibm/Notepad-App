import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:note_pad_app/screens/addNoteScreen.dart';

class welcomeScreen extends StatelessWidget{
  welcomeScreen({super.key});
  Widget build(BuildContext context){
    final box = GetStorage();
    final userName = box.read("username");
    final email = box.read("email");
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      backgroundColor: Theme.of(context).colorScheme.onTertiary,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text('Welcome $userName'),
            SizedBox(height: 15,),
            Text('Your email is: $email'),
            SizedBox(height: 30,),
            TextButton(
                onPressed: (){Get.to(addNoteScreen());},
                child: Text('Next ->'))

          ],
        ),

      ),
    );
  }
}