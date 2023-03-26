import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_dcs/pages/loginPage.dart';
import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Center(
                child: Text("Login Success"),
              ),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: () async =>{
                await Amplify.Auth.signOut().then((value){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logout Success')));
                }).then((value){
                  Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => loginPage()),ModalRoute.withName("/home"));
                }).onError((error, stackTrace){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logout Failed')));
                })
              }, child: Container(child: Center(child: Text("Log Out"),),)),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
