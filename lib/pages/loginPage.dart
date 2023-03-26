import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_dcs/amplifyconfiguration.dart';
import 'package:aws_dcs/pages/confirmationPage.dart';
import 'package:aws_dcs/pages/homePage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configureAmplify();
    _firebaseMessaging.getToken().then((token) => print("Token is: $token              until here"));
  }

  final _amplifyInstance = Amplify;

  void _configureAmplify() async {
    try {
      AmplifyAuthCognito _amplifyCognito = AmplifyAuthCognito();
      _amplifyInstance.addPlugin(_amplifyCognito);
      _amplifyInstance.configure(amplifyconfig);
      print("Configured");
    } catch (e) {
      print("HERE");
      print(e);
    }
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
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
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    obscureText: true,
                    controller: password,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Password",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: () async => {
                            await Amplify.Auth.signIn(
                                    username: email.text, password: password.text)
                                .then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Login Success')));
                            }).then((value) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => homePage()),
                                  ModalRoute.withName("/login"));
                            }).onError((error, stackTrace) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Login Failed')));
                            })
                          },
                      child: Container(
                        child: Center(
                          child: Text("Login"),
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async => {
                            await Amplify.Auth.signUp(
                                    username: email.text, password: password.text)
                                .then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Register Success')));
                            }).then((value) {
                              email.clear();
                              password.clear();
                            }).onError((error, stackTrace) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Register Failed')));
                            })
                          },
                      child: Container(
                        child: Center(
                          child: Text("Register"),
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text("After you get \"Register Success\", Please Proceeed to confirmation page to do confirmation"),
                  SizedBox(height: 20,),
                  Text("You will get \"Login Failed\" if you did not complete this confirmation"),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => confirmationPage()))
                          },
                      child: Container(
                        child: Center(
                          child: Text("Confirmation Page"),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
