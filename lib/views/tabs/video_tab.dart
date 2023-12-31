import 'package:care_on/components/video_item.dart';
import 'package:care_on/models/video_model.dart';
import 'package:care_on/presenters/video_presenter.dart';
import 'package:care_on/views/video_player_page.dart';
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
  final VideoPresenter presenter = VideoPresenter();

  void getVideosFromFirestore() async {
    presenter.getVideos((videos) {
      setState(() {
        videoList = videos;
      });
    }, (error) {
      print('Error fetching videos: $error');
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
