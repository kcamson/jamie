import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Youtube extends StatefulWidget {
  final String id;
  const Youtube({super.key, required this.id});

  @override
  State<Youtube> createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {
  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: YoutubePlayerController.fromVideoId(
        videoId: widget.id,
        autoPlay: false,
        params: const YoutubePlayerParams(showFullscreenButton: true),
      ),
      aspectRatio: 16 / 9,
    );
  }
}
