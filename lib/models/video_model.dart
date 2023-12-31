import 'package:flutter/material.dart';

class Video {
  final String url;
  final String title;
  final String duration;
  final String thumbnailUrl;

  Video(
      {required this.url,
      required this.title,
      required this.duration,
      required this.thumbnailUrl});

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'title': title,
      'duration': duration,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
