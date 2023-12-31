import 'package:care_on/models/video_model.dart';
import 'package:care_on/views/video_player_page.dart';
import 'package:flutter/material.dart';

class VideoItem extends StatefulWidget {
  Video video;
  VideoItem({super.key, required this.video});

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      precacheImage(NetworkImage(widget.video.thumbnailUrl), context)
          .then((value) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }).catchError((error) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        print("Error loading image: $error");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoPlayerPage(video: widget.video),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          height: 78,
          child: Row(children: [
            SizedBox(
              height: 78,
              width: 124,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 78,
                    width: 124,
                    child: Image.network(
                      widget.video.thumbnailUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (isLoading)
                    CircularProgressIndicator(), // Vòng tròn đang tải
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 215,
                  child: Text(
                    widget.video.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Thời lượng: " + widget.video.duration,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
