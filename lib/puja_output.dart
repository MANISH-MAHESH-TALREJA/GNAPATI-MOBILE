import 'dart:async';
import 'package:audio_player/audioplayer.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:ganpati/general_utility_functions.dart';
import 'package:toast/toast.dart';
import '../../constants.dart';
import 'flutter_html/flutter_html.dart';

typedef void OnError(Exception exception);

enum PlayerState { stopped, playing, paused }

class PujaOutput extends StatefulWidget
{
  final String english, hindi, url;
  PujaOutput(this.url, this.english, this.hindi);
  @override
  _PujaOutputState createState() => _PujaOutputState();
}

class _PujaOutputState extends State<PujaOutput>
{
  @override
  void initState()
  {
    super.initState();
    initAudioPlayer();
  }

  Duration? duration;
  Duration? position;
  AudioPlayer? audioPlayer;
  String? localFilePath;
  PlayerState playerState = PlayerState.stopped;
  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;
  get durationText => duration != null ? duration.toString().split('.').first.replaceFirst("0:", "") : '';
  get positionText => position != null ? position.toString().split('.').first.replaceFirst("0:", "") : '';
  StreamSubscription? _positionSubscription;
  StreamSubscription? _audioPlayerStateSubscription;

  @override
  void dispose()
  {
    _positionSubscription!.cancel();
    _audioPlayerStateSubscription!.cancel();
    audioPlayer!.stop();
    super.dispose();
  }

  void initAudioPlayer()
  {
    audioPlayer = AudioPlayer();
    _positionSubscription = audioPlayer!.onAudioPositionChanged.listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription =
        audioPlayer!.onPlayerStateChanged.listen((s)
        {
          if (s == AudioPlayerState.playing)
          {
            setState(() => duration = audioPlayer!.duration);
          }
          else if (s == AudioPlayerState.stopped)
          {
            onComplete();
            setState(()
            {
              position = duration;
            });
          }
        }, onError: (msg)
        {
          setState(()
          {
            playerState = PlayerState.stopped;
            duration = Duration(seconds: 0);
            position = Duration(seconds: 0);
          });
        });
  }

  Future play(String ringUrl) async
  {
    await audioPlayer!.play(ringUrl);
    setState(()
    {
      playerState = PlayerState.playing;
    });
  }

  Future pause() async
  {
    await audioPlayer!.pause();
    setState(()
    {
      playerState = PlayerState.paused;
    });
  }

  Future stop() async
  {
    await audioPlayer!.stop();
    setState(()
    {
      playerState = PlayerState.stopped;
      position = null;
    });
  }

  void onComplete()
  {
    setState(() => playerState = PlayerState.stopped);
  }

  @override
  Widget build(BuildContext context)
  {
    ToastContext().init(context);
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top:5.0, left: 5.0, right: 5.0),
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFFFFA500),
                border: Border.all(
                  color: Constants.BlueColor,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: FlipCard(
              direction: FlipDirection.HORIZONTAL,
              front: Padding(
                padding: const EdgeInsets.symmetric(vertical : 5.0),
                child: Center(child: SingleChildScrollView(child: Html(
                    defaultTextStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                    data: '''  ${"<center>"+widget.hindi+"</center>"}   '''),
                )),
              ),
              back: Container(
                decoration: BoxDecoration(
                    color: Color(0xFF0000FF),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical : 5.0),
                  child: Center(child: SingleChildScrollView(child: Html(
                      defaultTextStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      data: '''  ${"<center>"+widget.english+"</center>"}   '''),
                  )),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Constants.BlueColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              height: 75,
              width: MediaQuery.of(context).size.width-10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>
                    [
                      Icon(Icons.swipe, color: Constants.BlueColor,),
                      SizedBox(width: 5,),
                      Text("CLICK ON THE CARD TO CHANGE LANGUAGE", maxLines: 2, textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12,color: Constants.BlueColor, fontFamily: Constants.AppFont)),
                    ],
                  ),
                  /*if (duration != null)
                  Slider(
                      value: position?.inMilliseconds?.toDouble() ?? 0.0,
                      onChanged: (double value)
                      {
                        return audioPlayer.seek((value / 1000).roundToDouble());
                      },
                      min: 0.0,
                      max: duration.inMilliseconds.toDouble()),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                    [
                      if (position != null)  Row(mainAxisSize: MainAxisSize.min, children:
                      [
                        Padding(
                          padding: EdgeInsets.only(right:5.0, left : 5),
                          child: CircularProgressIndicator(
                            value: position != null && position!.inMilliseconds > 0 ? (position?.inMilliseconds.toDouble() ?? 0.0) / (duration?.inMilliseconds.toDouble() ?? 0.0) : 0.0,
                            valueColor: AlwaysStoppedAnimation(Constants.BlueColor),
                            backgroundColor: Colors.grey[500],
                          ),
                        ),
                        Text(position != null ? "${positionText ?? ''} / ${durationText ?? ''}" : duration != null ? durationText : '', style: TextStyle(fontSize: 16.0),
                        )
                      ]),
                      IconButton(
                        onPressed: isPlaying ? null : () => play(widget.url),
                        icon: Icon(Icons.play_circle_outline),
                        iconSize: 30,
                        color: Colors.blue,
                      ),
                      IconButton(
                        onPressed: isPlaying ? () => pause() : null,
                        iconSize: 30.0,
                        icon: Icon(Icons.pause_circle_outline_outlined),
                        color: Colors.blue,
                      ),
                      IconButton(
                        onPressed: (isPlaying || isPaused) && position!=null ? () => stop() : null,
                        icon: Icon(Icons.stop_circle_outlined),
                        iconSize: 30,
                        color: Colors.red,
                      ),
                      IconButton(
                        onPressed: () async => saveMedia(context, widget.url, "GANESH PUJA",'Music'),
                        iconSize: 30,
                        icon: Icon(Icons.arrow_circle_down_outlined),
                        color: Constants.GreenColor,
                      ),
                    ],
                  ),
                ],
              )
          ),
        )
    );
  }
}
