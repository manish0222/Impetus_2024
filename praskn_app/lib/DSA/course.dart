import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DS extends StatelessWidget {
  // Sample data of key-value pairs
  final Map<String, String> links = {
    'Arrays': 'https://youtu.be/37E9ckMDdTk?si=G626aPxc-Xy6c0X2',
    'Dynamic Programming': 'https://youtu.be/FfXoiwwnxFw?si=0U4BTpWBrl3tp5kM',
    'Tree': 'https://youtu.be/_ANrF3FJm7I?si=4vUuvLlYlTzB_30C',
    'Graph': 'https://youtu.be/M3_pLsDdeuU?si=U-SWOqX93p38Bt0j',
    'Binary Search': 'https://youtu.be/_NT69eLpqks?si=d0FE5U9kr6wVYcgj',
    'Recursion': 'https://youtu.be/yVdKa8dnKiE?si=Anv4aH5mlEiMD-uc',
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Link List',
      theme: ThemeData(
        primaryColor: Colors.blue, // Change primary color to blue
      ),
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: Scaffold(
        appBar: AppBar(
          title: Text('Links'),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade200,
                Colors.blue.shade700
              ], // Define gradient colors
            ),
          ),
          child: ListView.builder(
            itemCount: links.length,
            itemBuilder: (context, index) {
              String key = links.keys.elementAt(index);
              String value = links.values.elementAt(index);
              return LinkItem(
                key1: key,
                link: value,
              );
            },
          ),
        ),
      ),
    );
  }
}

class LinkItem extends StatelessWidget {
  final String key1;
  final String link;

  const LinkItem({Key? key, required this.key1, required this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, // Add elevation to cards for a material look
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Add margin
      child: ListTile(
        title: GestureDetector(
          onTap: () {
            _launchURL(link); // Open link in browser when key is clicked
          },
          child: Text(
            key1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor, // Use primary color
            ),
          ),
        ),
        onTap: () {
          // Display debug info and open link in browser when list item is clicked
          print('You clicked $key1, it redirects to $link');
          _launchURL(link);
        },
      ),
    );
  }

  // Function to launch URL in browser
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

void main() {
  runApp(DS());
}
