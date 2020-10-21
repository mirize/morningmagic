import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/model/progress/vocabulary_progress/vocabulary_record_progress.dart';
import 'package:morningmagic/db/progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/progress_util.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:morningmagic/view/customPlayerColumn.dart';
import 'package:morningmagic/view/custom_progress_bar/circleProgressBar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:random_string/random_string.dart';

class TimerRecordSuccessScreen extends StatefulWidget {
  @override
  State createState() {
    return _TimerRecordSuccessScreenState();
  }
}

class _TimerRecordSuccessScreenState extends State<TimerRecordSuccessScreen> {
  // Timer
  Timer _timer;
  int _time;
  int _startTime;

  Box box;

  PermissionStatus statusMicrophone;
  PermissionStatus statusStorage;

  FlutterAudioRecorder _recorder;
  Recording _recording;

  Future<Box> getBox() async {
    Box box = await ExerciseUtils().openMyBox();
    if (box == null) {
      box = await ExerciseUtils().initAndGetBox();
    }
    return box;
  }

  Future<bool> getPermissions() async {
    statusMicrophone = await Permission.microphone.status;

    if (statusMicrophone.isGranted) {
      return true;
    }

    if (statusMicrophone.isUndetermined || statusMicrophone.isDenied) {
      statusMicrophone = await Permission.microphone.request();
    }

    return statusMicrophone.isGranted;
  }

  Future<String> get _localPath async {
    final directory = await getTemporaryDirectory();
    return directory.path + "/" + randomAlpha(10) + ".m4a";
  }

  bool isStarted = false;

  Future<void> _startRecording() async {
    await _recorder.start();
    Recording current = await _recorder.current();
    _recording = current;
  }

  Future<void> _resumeRecording() async {
    await _recorder.resume();
    Recording current = await _recorder.current();
    _recording = current;
  }

  Future<void> _stopRecording() async {
    await _recorder.stop();
    Recording current = await _recorder.current();
    _recording = current;
  }

  Future<void> _pauseRecording() async {
    await _recorder.pause();
    Recording current = await _recorder.current();
    _recording = current;
  }

  Future<void> playPause() async {
    if (_recording == null) {
//      ToastUtils.createOverlayEntry(context, AppLocalizations.of(context)
//          .translate("add_permission"));
      return;
    }
    switch (_recording.status) {
      case RecordingStatus.Initialized:
        {
          await _startRecording();
          print("START RECORDING !!!!!!!!!!!!!!!!");
          break;
        }

      case RecordingStatus.Recording:
        {
          await _pauseRecording();
          print("PAUSE RECORDING !!!!!!!!!!!!!!!!");
          break;
        }

      case RecordingStatus.Paused:
        {
          await _resumeRecording();
          print("RESUME RECORDING !!!!!!!!!!!!!!!!");
          break;
        }

      case RecordingStatus.Stopped:
        {
          await _prepare();
          await _startRecording();
          print("START RECORDING AFTER STOP !!!!!!!!!!!!!!!!");
          break;
        }

      default:
        break;
    }
  }

  Future<void> stop() async {
    if (_recording == null) {
//      ToastUtils.createOverlayEntry(context, AppLocalizations.of(context)
//          .translate("add_permission"));
      return;
    }
    switch (_recording.status) {
      case RecordingStatus.Recording:
        {
          await _stopRecording();
          saveVocabularyRecordProgress(_recording.path);
          print("STOP RECORDING !!!!!!!!!!!!!!!!");
          break;
        }

      case RecordingStatus.Paused:
        {
          await _stopRecording();
          saveVocabularyRecordProgress(_recording.path);
          print("STOP RECORDING !!!!!!!!!!!!!!!!");
          break;
        }

      default:
        break;
    }
  }

  void saveVocabularyRecordProgress(String path) {
    if (path != null) {
      path = path.substring(1);
      VocabularyRecordProgress recordProgress =
          new VocabularyRecordProgress(path);
      Day day = ProgressUtil()
          .createDay(null, null, null, null, null, recordProgress, null);
      ProgressUtil().updateDayList(day);
    }
  }

  @override
  void initState() {
    checkPermissions().then((value) {
      print("process complete");
    });

    getBox().then((Box value) {
      setState(() {
        box = value;
        ExerciseTime time = box.get(Resource.VOCABULARY_TIME_KEY,
            defaultValue: ExerciseTime(3));
        _time = time.time * 60;
        _startTime = time.time;

        startTimer();
      });
    });

    super.initState();
  }

  void startTimer() async {
    const oneSec = const Duration(seconds: 1);
    if (_timer == null || !_timer.isActive) {
      _timer = Timer.periodic(
          oneSec,
          (Timer timer) => setState(() {
                if (_time < 1) {
                  timer.cancel();
                  Future.microtask(() => stop());
                  OrderUtil().getRouteById(3).then((value) {
                    Navigator.push(context, value);
                  });
                } else {
                  _time = _time - 1;
                  print(_time);
                }
              }));
    } else if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
  }

  Future<void> checkPermissions() async {
    bool res = await getPermissions();
    if (res) {
      await _prepare();
    }
  }

  Future<void> _prepare() async {
    await _init();
    var result = await _recorder.current();
    _recording = result;
  }

  Future _init() async {
    _recorder = FlutterAudioRecorder(await _localPath,
        audioFormat: AudioFormat.AAC, sampleRate: 22050);
    await _recorder.initialized;
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width, // match parent(all screen)
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.TOP_GRADIENT,
              AppColors.MIDDLE_GRADIENT,
              AppColors.BOTTOM_GRADIENT
            ],
          )),
          child: Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: CircleProgressBar(
                    text: StringUtil().createTimeString(_time),
                    foregroundColor: AppColors.WHITE,
                    value: createValue(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 17),
                  child: PlayerColumn(() async {
                    if (_timer != null && _timer.isActive) {
                      _timer.cancel();
                    }
                    await stop();
                  }, () async {
                    await playPause();
                  }, () async {
                    await stop();
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  double createValue() {
    if (_startTime != null) {
      return 1 - _time / (_startTime * 60);
    } else {
      return 0;
    }
  }

  Future<bool> _onWillPop() async {
    if (_timer != null) {
      _timer.cancel();
    }

    await stop();
    return true;
  }
}
