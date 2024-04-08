// import 'package:flutter/material.dart';
// import 'package:praskn_app/DSA/player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// final videoUrls = [
//   'https://www.youtube.com/watch?v=1wBpX0iFl5E',
//   'https://www.youtube.com/watch?v=5AxWC49ZMzs',
//   'https://www.youtube.com/watch?v=JSqUZFkRLr8',
//   'https://www.youtube.com/watch?v=qEZf2q4W20g',
//   'https://www.youtube.com/watch?v=jCbclWBV32o'
// ];

// class Feed extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Flutter Youtube"),
//       ),
//       body: ListView.builder(
//         itemCount: videoUrls.length,
//         itemBuilder: (context, index) {
//           final videoID = YoutubePlayer.convertUrlToId(videoUrls[index]);

//           return InkWell(
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) =>
//                         PLayerScreen(videoId: videoID.toString())));
//               },
//               child:
//                   Image.network(YoutubePlayer.getThumbnail(videoId: videoID!)));
//         },
//       ),
//     );
//   }

//   Widget thubmNail() {
//     return Container(
//       height: 200,
//       margin: const EdgeInsets.all(10),
//       color: Colors.blue,
//       child: const Center(
//         child: Text("THUMBNAIL"),
//       ),
//     );
//   }
// }
