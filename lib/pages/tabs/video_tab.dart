import 'package:care_on/components/video_item.dart';
import 'package:care_on/models/video_model.dart';
import 'package:care_on/pages/video_player_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VideoTab extends StatefulWidget {
  const VideoTab({super.key});

  @override
  State<VideoTab> createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
  List<Video> videoList = [];

  void getVideosFromFirestore() async {
    FirebaseFirestore.instance
        .collection('videos')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      setState(() {
        videoList.clear();
        videoList = snapshot.docs.map((DocumentSnapshot document) {
          return Video(
            url: document['url'],
            title: document['title'],
            duration: document['duration'],
            thumbnailUrl: document['thumbnail'],
          );
        }).toList();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVideosFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F6FB),
      body: ListView.builder(
        itemCount: videoList.length,
        itemBuilder: (context, index) {
          return VideoItem(
            video: videoList[index],
          );
        },
      ),
    );
  }
}
