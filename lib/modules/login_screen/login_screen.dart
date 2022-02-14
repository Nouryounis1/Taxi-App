import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxi_app/modules/main_page.dart';
import 'package:taxi_app/modules/registertion_screen/registertion_sreen.dart';
import 'package:taxi_app/shared/components.dart';
import 'package:taxi_app/style/colors.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailAddressController = TextEditingController();

  var passwordController = TextEditingController();

  void showSnackBar(String title, context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      title,
      style: const TextStyle(fontSize: 15.0),
      textAlign: TextAlign.center,
    )));
  }

  void login(context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            const ProgressDialog(status: 'Logging you in'));

    final UserCredential userCredential = (await _auth
        .signInWithEmailAndPassword(
            email: emailAddressController.text,
            password: passwordController.text)
        .catchError((ex) {
      PlatformException thisEx = ex;
      Navigator.pop(context);
      print(thisEx.message!);
      showSnackBar(thisEx.message!, context);
    }));
    User? user = userCredential.user;
    print(user);

    if (user != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('users/${user.uid}');
      final DatabaseEvent event = await userRef.once();
      if (event.snapshot.value != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, MainPage.id, (route) => false);
      } else {
        showSnackBar('No records exist. Please create new account', context);
      }
    } else {
      showSnackBar(' Cannot be signed in', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 70.0,
                ),
                const Image(
                  alignment: Alignment.center,
                  height: 100.0,
                  width: 100.0,
                  image: AssetImage('images/logo.png'),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                const Text(
                  'Sign In as a Rider',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, fontFamily: 'Brand-Bold'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: emailAddressController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            labelText: 'Email address',
                            labelStyle: TextStyle(fontSize: 14.0),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.0)),
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(fontSize: 14.0),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.0)),
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 50.0,
                        width: double.infinity,
                        child: TaxiOutlineButton(
                          title: 'LOGIN',
                          onPressed: () async {
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());
                            if (connectivityResult !=
                                    ConnectivityResult.mobile &&
                                connectivityResult != ConnectivityResult.wifi) {
                              showSnackBar('No Internet connectivity', context);
                              return;
                            }
                            if (!emailAddressController.text.contains('@')) {
                              showSnackBar(
                                  'Please provie a valid email address',
                                  context);
                              return;
                            }
                            if (passwordController.text.length < 8) {
                              showSnackBar(
                                  'Please provie a valid password', context);
                              return;
                            }

                            login(context);
                          },
                          color: BrandColors.colorGreen,
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(context,
                                RegitertionScreen.id, (route) => false);
                          },
                          child: const Text(
                              'Don\'t have an account, sign up here'))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
