import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxi_app/modules/login_screen/login_screen.dart';
import 'package:taxi_app/modules/main_page.dart';
import 'package:taxi_app/shared/components.dart';
import 'package:taxi_app/style/colors.dart';

class RegitertionScreen extends StatelessWidget {
  RegitertionScreen({Key? key}) : super(key: key);
  static const String id = 'register';
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var fullNameController = TextEditingController();
  var emailAddressController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();

  void showSnackBar(String title, context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      title,
      style: TextStyle(fontSize: 15.0),
      textAlign: TextAlign.center,
    )));
  }

  void registerUser(context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            const ProgressDialog(status: 'Refistering you....'));

    final UserCredential userCredential = (await _auth
        .createUserWithEmailAndPassword(
            email: emailAddressController.text,
            password: passwordController.text)
        .catchError((ex) {
      Navigator.pop(context);

      PlatformException thisEx = ex;
      showSnackBar(thisEx.message!, context);
    }));
    User? user = userCredential.user;
    print(user);
    Navigator.pop(context);

    if (user != null) {
      DatabaseReference newUserRef =
          FirebaseDatabase.instance.ref().child('users/${user.uid}');
      Map userMap = {
        'fullName': fullNameController.text,
        'email': emailAddressController.text,
        'phoneNumber': phoneNumberController.text,
      };
      newUserRef.set(userMap);

      Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
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
                  'Create  a Rider\'s account',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, fontFamily: 'Brand-Bold'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: fullNameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            labelText: 'Full Name',
                            labelStyle: TextStyle(fontSize: 14.0),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.0)),
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            labelText: 'Phone number',
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
                          title: 'REGISTER',
                          onPressed: () async {
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());
                            if (connectivityResult !=
                                    ConnectivityResult.mobile &&
                                connectivityResult != ConnectivityResult.wifi) {
                              showSnackBar('No Internet connectivity', context);
                              return;
                            }
                            if (fullNameController.text.length < 3) {
                              showSnackBar(
                                  'Please provie a valid full name', context);
                              return;
                            }
                            if (phoneNumberController.text.length < 3) {
                              showSnackBar('Please provie a valid phone number',
                                  context);
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

                            registerUser(context);
                          },
                          color: BrandColors.colorGreen,
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, LoginScreen.id, (route) => false);
                          },
                          child:
                              const Text('Already have a RIDER account? Login'))
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
