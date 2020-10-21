import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';

class ProgressPairRecord extends StatefulWidget {

  final String exerciseTitle;
  final String path;

  ProgressPairRecord(this.exerciseTitle, this.path);

  @override
  State<StatefulWidget> createState() {
    return ProgressPairRecordState();
  }
}

class ProgressPairRecordState extends State<ProgressPairRecord> {

  bool switcher = false;
  AudioPlayer audioPlayer;

  Future<void> playLocal(String path) async {
    int result = await audioPlayer.play(path, isLocal: true);
  }

  @override
  void initState() {
    AudioPlayer.logEnabled = true;
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        switcher = !switcher;
      });

    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            child: Text(
              widget.exerciseTitle,
              style: TextStyle(
                fontFamily: 'sans-serif-black',
                fontSize: 16,
                color: AppColors.VIOLET,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          Container(
            child: Text(
                ' – '
            ),
          ),
          Container(
            child: FloatingActionButton(
              heroTag: null,
              elevation: 0,
              onPressed: () {
                if (!switcher) {
                  playLocal(widget.path).then((value) => {
                    print("play")
                  });
                } else {
                  audioPlayer.stop();
                }
                setState(() {
                  switcher = !switcher;
                });
              },
              child: getIcon(),
              backgroundColor: AppColors.WHITE,
            ),
          ),
        ],
      ),
    );
  }

  Widget getIcon() {
    if (!switcher) {
      return Icon(
        Icons.play_arrow,
        size: 40,
        color: AppColors.VIOLET,
      );
    } else {
      return Icon(
        Icons.stop,
        size: 40,
        color: AppColors.VIOLET,
      );
    }
  }
}