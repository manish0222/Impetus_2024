import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:praskn_app/DSA/feed.dart';
import 'package:praskn_app/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'DSA/course.dart';
import 'test/quizapp.dart';
import 'userDetails.dart/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final token;

  const HomePage({@required this.token, Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String email;
  late String name;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    initSharedPref(); // Don't await here
    name = "";
  }

  Future<void> initSharedPref() async {
    // Make initSharedPref async
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      setState(() {
        name = prefs!.getString('name') ?? "";
        userDetail['name'] = name;
        userDetail['email'] = email;
        userDetail['token'] = widget.token;
      });
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 31, 151, 220),
                    Color.fromARGB(255, 23, 113, 154)
                  ],
                ),
              ),
            ),
          ),
          // Your content
          Column(
            children: [
              // Blue container at the top
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Color.fromARGB(146, 130, 174, 195),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Welcome To Prashikshan App ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10), // Spacer with height of 10
              // Welcome container stacked on top of World container
              Container(
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Welcome ${name}",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20), // Spacer with height of 20
              // Button below the stacked containers
              // ElevatedButton(
              //   onPressed: () {
              //     // Button action
              //     Navigator.push(
              //         context, MaterialPageRoute(builder: (context) => QuizApp()));
              //   },
              //   child: Text('Appear test'),
              // ),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => QuizApp()));
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 6,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Color.fromARGB(255, 167, 224, 219),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              '/images/img1.jpg', // Change 'assets/test_icon.png' to the path of your image
                              width: 100, // Adjust the width as needed
                              height: 100, // Adjust the height as needed
                            ),
                            SizedBox(height: 10), // Spacer with height of 10
                            Text(
                              'Take Test',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Action for the second container ArraysComponent
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => DS()));
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 7,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Color.fromARGB(255, 167, 224, 219),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              '/images/img2.jpg', // Change 'assets/test_icon.png' to the path of your image
                              width: 100, // Adjust the width as needed
                              height: 100, // Adjust the height as needed
                            ),
                            SizedBox(height: 10), // Spacer with height of 10
                            Text(
                              'DSA Course',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _openChromeToFriendApp();
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => QuizApp()));
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 6,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Color.fromARGB(255, 167, 224, 219),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              '/images/img3.jpg', // Change 'assets/test_icon.png' to the path of your image
                              width: 100, // Adjust the width as needed
                              height: 100, // Adjust the height as needed
                            ),
                            SizedBox(height: 10), // Spacer with height of 10
                            Text(
                              'Interview Bot',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _openChromeToFriendApp1();
                        // launchWhatsApp("918975885793");
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => WhatsAppPage()));
                        // Action for the second container
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 7,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Color.fromARGB(255, 167, 224, 219),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              '/images/img4.jpg', // Change 'assets/test_icon.png' to the path of your image
                              width: 100, // Adjust the width as needed
                              height: 100, // Adjust the height as needed
                            ),
                            SizedBox(height: 10), // Spacer with height of 10
                            Text(
                              'Video Bot',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          // WhatsApp button in top right corner
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Action when WhatsApp button is tapped
                launchWhatsApp("918975885793");
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green, // You can change the color
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.wechat_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  // Future<void> launchWhatsApp(String number) async {
  //   final link = WhatsAppUnilink(
  //     phoneNumber: number,
  //     text: "Hello, I need support.",
  //   );
  //   await launch('$link');
  // }
  Future<void> launchWhatsApp(String number) async {
    final whatsappWebUrl =
        "https://web.whatsapp.com/send?phone=$number&text=Hello,%20I%20need%20support.";
    if (await canLaunch(whatsappWebUrl)) {
      await launch(whatsappWebUrl);
    } else {
      throw 'Could not launch WhatsApp web';
    }
  }

  void _openChromeToFriendApp() async {
    String url =
        'http://localhost:8000'; // Assuming Flask app is running on port 5000
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _openChromeToFriendApp1() async {
    String url =
        'http://localhost:5000'; // Assuming Flask app is running on port 5000
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _navigateToYouTubePage() {
    // Implement your action for the YouTube button here
    // For example, you can launch a YouTube URL
    launch("https://www.youtube.com/");
  }
}
