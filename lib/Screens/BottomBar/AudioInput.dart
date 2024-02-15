import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/AudioModel.dart';
import '../../Models/Utils.dart';
import '../../constants.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var lst = [];

class AudioInput extends StatefulWidget {
  const AudioInput({super.key});

  @override
  State<AudioInput> createState() => _AudioInputState();
}

class _AudioInputState extends State<AudioInput>
    with SingleTickerProviderStateMixin {
  int maxDuration = 10;
  double deviceHeight = Constants().deviceHeight,
      deviceWidth = Constants().deviceWidth;
  late AnimationController _controller;
  bool isRecorderReady = false, gotSomeTextYo = false, isPlaying = false;
  String ngrokurl = Constants().url;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: maxDuration))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isPlaying = false;
        }
      });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey[900]!,
                Colors.black,
                Colors.grey[900]!,
              ]),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 50 * (height / deviceHeight),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.speakMic,
                    style: TextStyle(
                        fontFamily: "productSansReg",
                        color: Colors.cyan[500],
                        fontWeight: FontWeight.w700,
                        fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 100 * (height / deviceHeight),
                ),
                // StreamBuilder<RecordingDisposition>(
                //     stream: recorder.onProgress,
                //     builder: (context, snapshot) {
                //       final duration = snapshot.hasData
                //           ? snapshot.data!.duration
                //           : Duration.zero;
                //       String twoDigits(int n) => n.toString().padLeft(2, '0');
                //       final twoDigitMinutes =
                //           twoDigits(duration.inMinutes.remainder(60));
                //       final twoDigitSeconds =
                //           twoDigits(duration.inSeconds.remainder(60));
                //       return Text(
                //         "$twoDigitMinutes:$twoDigitSeconds s",
                //         style: TextStyle(
                //           fontSize: 40,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.cyan[500],
                //           fontFamily: "productSansReg",
                //         ),
                //       );
                //     }),
                SizedBox(
                  height: 80 * (height / deviceHeight),
                ),
                if (isPlaying)
                  Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.cyan[500]!,
                    size: 50 * (height / deviceHeight),
                  )),
                if (!isPlaying)
                  SizedBox(
                    height: 150 * (height / deviceHeight),
                    child: gotSomeTextYo
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              lst[0],
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "productSansReg",
                                  color: Color(0xFF009CFF)),
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.all(8.0),
                          ),
                  ),
                if (!isPlaying)
                  SizedBox(
                    height: 50 * (height / deviceHeight),
                  ),
                if (isPlaying)
                  SizedBox(
                    height: 150 * (height / deviceHeight),
                  ),
                Container(
                  alignment: Alignment.center,
                  height: 60 * (height / deviceHeight),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      shape: BoxShape.circle),
                  child: GestureDetector(
                    onTap: () async {},
                    child: AnimatedContainer(
                      height: isPlaying
                          ? 25 * (height / deviceHeight)
                          : 50 * (height / deviceHeight),
                      width: isPlaying
                          ? 25 * (height / deviceHeight)
                          : 50 * (height / deviceHeight),
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(isPlaying ? 6 : 100),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70 * (height / deviceHeight),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
