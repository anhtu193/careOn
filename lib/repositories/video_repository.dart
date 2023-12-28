import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:care_on/models/video_model.dart';

class VideoRepository {
  final CollectionReference videoCollection =
      FirebaseFirestore.instance.collection('videos');

  Stream<List<Video>> getVideosStream() {
    return videoCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Video(
          url: doc['url'],
          title: doc['title'],
          duration: doc['duration'],
          thumbnailUrl: doc['thumbnail'],
        );
      }).toList();
    });
  }
}
