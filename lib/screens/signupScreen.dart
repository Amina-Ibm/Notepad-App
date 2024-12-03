import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_pad_app/screens/welcomeScreen.dart';


class SignupScreen extends StatelessWidget {
  late final String userName;
  late final String userEmail;
  final box = GetStorage();
  void saveUserData(String name, String email){

    box.write("username", name);
    box.write("email", email);
  }

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    final emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      backgroundColor: Theme.of(context).colorScheme.onTertiary,
      body: Padding(

        padding: const EdgeInsets.all(16.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                nameController.text = value;
              },
            ),
            SizedBox(height: 16),
            TextField(

              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                emailController.text = value;
              },
            ),
            SizedBox(height: 24),
            TextButton(

              onPressed: () {
                saveUserData(nameController.text, emailController.text);
                Get.to(welcomeScreen());
              },
              child: Text("Signup"),
            ),
          ],
        ),
      ),
    );
  }
}
