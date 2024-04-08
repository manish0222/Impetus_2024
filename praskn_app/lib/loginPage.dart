import 'dart:convert';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'registration.dart';
import 'userDetails.dart/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool _isNotValidate = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }
  //

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      // Trim the email input
      emailController.text = emailController.text.trim();
      var reqBody = {
        "email": emailController.text,
        "password": passwordController.text
      };

      var data = jsonEncode(reqBody);
      // print(reqBody);
      try {
        var response = await http.post(Uri.parse(login),
            headers: {"Content-Type": "application/json"}, body: data);

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          if (jsonResponse['status']) {
            var myToken = jsonResponse['token'];
            prefs.setString('token', myToken);
            prefs.setString('email', emailController.text);
            // You don't seem to be using nameController.text anywhere, so no need to set it
            prefs.setString('name', nameController.text);
            userDetail['token'] = myToken;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(token: myToken)));
          } else {
            print('Something went wrong: ${jsonResponse['message']}');
            // Optionally, show an error message to the user
          }
        } else {
          print('Server returned error: ${response.statusCode}');
          // Optionally, show an error message to the user
        }
      } catch (error) {
        print('Error occurred during HTTP request: $error');
        // Handle the error accordingly, e.g., show an error message to the user
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 120, 213, 213),
                Color.fromARGB(255, 23, 113, 154)
              ],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomCenter,
              stops: [0.0, 0.8],
              tileMode: TileMode.mirror,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Email Sign-In",
                      style: TextStyle(fontSize: 22),
                    ),
                    color: Colors.yellow[100],
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Email",
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Password",
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: TextField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Name",
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      loginUser();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green[600],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "LogIn",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Registration()));
          },
          child: Container(
            height: 25,
            color: Colors.lightBlue,
            child: Center(
              child: Text(
                "Create a new Account..! Sign Up",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'home_page.dart';
// // import 'package:flutter_todo_app/dashboard.dart';
// // import 'package:flutter_todo_app/registration.dart';
// import 'registration.dart';
// import 'userDetails.dart/user.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'applogo.dart';
// import 'package:http/http.dart' as http;
// import 'config.dart';

// class SignInPage extends StatefulWidget {
//   @override
//   _SignInPageState createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   bool _isNotValidate = false;
//   late SharedPreferences prefs;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     initSharedPref();
//   }

//   void initSharedPref() async {
//     prefs = await SharedPreferences.getInstance();
//   }

//   void loginUser() async {
//     if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
//       emailController.text = emailController.text.trim();
//       nameController.text = nameController.text.trim();
//       var reqBody = {
//         "email": emailController.text,
//         "password": passwordController.text
//       };

//       var response = await http.post(Uri.parse(login),
//           headers: {"Content-Type": "application/json"},
//           body: jsonEncode(reqBody));

//       var jsonResponse = jsonDecode(response.body);
//       if (jsonResponse['status']) {
//         var myToken = jsonResponse['token'];
//         prefs.setString('token', myToken);
//         prefs.setString('email', emailController.text);
//         prefs.setString('name', nameController.text);
//         userDetail['token'] = myToken;
//         // User.email = emailController.text;
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => HomePage(token: myToken)));
//       } else {
//         print('Something went wrong');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 colors: [
//                   Color.fromARGB(255, 120, 213, 213),
//                   Color.fromARGB(255, 23, 113, 154)
//                 ],
//                 begin: FractionalOffset.topLeft,
//                 end: FractionalOffset.bottomCenter,
//                 stops: [0.0, 0.8],
//                 tileMode: TileMode.mirror),
//           ),
//           child: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   // CommonLogo(),
//                   HeightBox(10),
//                   "Email Sign-In".text.size(22).yellow100.make(),
//                   TextField(
//                     controller: emailController,
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         hintText: "Email",
//                         errorText: _isNotValidate ? "Enter Proper Info" : null,
//                         border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0)))),
//                   ).p4().px24(),
//                   TextField(
//                     controller: passwordController,
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         hintText: "Password",
//                         errorText: _isNotValidate ? "Enter Proper Info" : null,
//                         border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0)))),
//                   ).p4().px24(),
//                   TextField(
//                     controller: nameController,
//                     keyboardType:
//                         TextInputType.name, // Assuming you want a number input
//                     decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         hintText: "Name",
//                         errorText: _isNotValidate ? "Enter Proper Info" : null,
//                         border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0)))),
//                   ).p4().px24(),
//                   GestureDetector(
//                     onTap: () {
//                       loginUser();
//                     },
//                     child: HStack([
//                       VxBox(child: "LogIn".text.white.makeCentered().p16())
//                           .green600
//                           .roundedLg
//                           .make(),
//                     ]),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         bottomNavigationBar: GestureDetector(
//           onTap: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => Registration()));
//           },
//           child: Container(
//               height: 25,
//               color: Colors.lightBlue,
//               child: Center(
//                   child: "Create a new Account..! Sign Up"
//                       .text
//                       .white
//                       .makeCentered())),
//         ),
//       ),
//     );
//   }
// }
