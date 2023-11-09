import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Youtube extends StatefulWidget {
  const Youtube({super.key});

  @override
  State<Youtube> createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {
  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: YoutubePlayerController.fromVideoId(
        videoId: 'dTlvfTlMhV8',
        autoPlay: false,
        params: const YoutubePlayerParams(showFullscreenButton: true),
      ),
      aspectRatio: 16 / 9,
    );
  }
}
