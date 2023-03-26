import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class confirmationPage extends StatelessWidget {
  const confirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController code = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirmation Page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Text("An email confirmation code is sent to your email, Please type the code to confirm your email."),
              SizedBox(height: 20),
              TextField(
                controller: email,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Email",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
              SizedBox(height: 50,),
              TextField(
                controller: code,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Confirmation Code",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
              SizedBox(height: 50,),
              ElevatedButton(
                  onPressed: () async => {
                    await Amplify.Auth.confirmSignUp(
                        username: email.text, confirmationCode: code.text)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Confirmation Code Correct, you can back to login now')));
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Confirmation Code Incorrect, you can request for a new Confirmation Code')));
                    })
                  },
                  child: Container(
                    child: Center(
                      child: Text("Check for Confirmation Code"),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
