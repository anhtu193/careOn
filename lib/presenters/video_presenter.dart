import 'package:care_on/models/video_model.dart';
import 'package:care_on/repositories/video_repository.dart';
import 'package:flutter/material.dart';

class VideoPresenter {
  final VideoRepository repository = VideoRepository();

  void getVideos(Function(List<Video>) onData, Function onError) {
    repository.getVideosStream().listen((videos) {
      onData(videos);
    }, onError: onError);
  }
}
