import 'dart:async';

import 'package:flutter/material.dart';

class PomodoroApp extends StatefulWidget {
  const PomodoroApp({Key? key}) : super(key: key);

  @override
  State<PomodoroApp> createState() => _PomodoroAppState();
}

class _PomodoroAppState extends State<PomodoroApp> {
  Timer? timer;
  late int totalSeconds;
  bool isTimerRunning = false;
  String timerMin = "00", timerSec = "00", selectedDuration = "";
  final List<String> durationList = [];
  int currentRoundCount = 0, currentGoalCount = 0;
  static const int completeRoundCount = 4, completeGoalCount = 12;

  @override
  void initState() {
    super.initState();

    for (var i = 5; i <= 120; i += 5) {
      durationList.add(i.toString());
    }
    onClickDuration(durationList[0]);
  }

  void onClickDuration(String duration) {
    onPauseTimer();
    selectedDuration = duration;
    totalSeconds = int.parse(duration) * 60;
    updateTimerTime(totalSeconds);
  }

  void updateTimerTime(int initSec) {
    var splitList =
        Duration(seconds: initSec).toString().split('.').first.split(':');
    var min = int.parse(splitList[0]) * 60 + int.parse(splitList[1]);
    var sec = int.parse(splitList[2]);

    setState(() {
      timerMin = padZeroDigits(min.toString());
      timerSec = padZeroDigits(sec.toString());
    });
  }

  String padZeroDigits(String time) {
    return time.length < 2 ? time.padLeft(2, '0') : time;
  }

  void onStartTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isTimerRunning = true;
    });
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      onTimerFinished();
    } else {
      totalSeconds -= 1;
      updateTimerTime(totalSeconds);
    }
  }

  void onPauseTimer() {
    timer?.cancel();
    setState(() {
      isTimerRunning = false;
    });
  }

  void onTimerFinished() {
    timer?.cancel();
    onTimerReset();
    updateRoundCount();
  }

  void updateRoundCount() {
    setState(() {
      if (++currentRoundCount == completeRoundCount) {
        currentRoundCount = 0;
        currentGoalCount++;
      }
    });
  }

  void onTimerReset() {
    onPauseTimer();
    onClickDuration(selectedDuration);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MaterialApp(
      home: Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  alignment: const Alignment(-0.9, -0.5),
                  child: const Text(
                    "POMOTIMER",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ),
              ),
              Flexible(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TimeStackBoxWidget(
                          content: timerMin,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 80,
                          height: 195,
                          child: Text(
                            ':',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 100,
                              color: theme.cardColor.withOpacity(0.8),
                            ),
                          ),
                        ),
                        TimeStackBoxWidget(
                          content: timerSec,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 50,
                      child: DurationListWidget(
                        durationList: durationList,
                        selectedDuration: selectedDuration,
                        onClickDuration: onClickDuration,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            iconSize: 120,
                            color: theme.cardColor,
                            icon: Icon(isTimerRunning
                                ? Icons.pause_circle_filled_outlined
                                : Icons.play_circle_filled_outlined),
                            onPressed:
                                isTimerRunning ? onPauseTimer : onStartTimer,
                          ),
                          IconButton(
                            iconSize: 120,
                            color: theme.cardColor,
                            icon:
                                const Icon(Icons.replay_circle_filled_outlined),
                            onPressed: onTimerReset,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ProgressCheckWidget(
                        currentCount: currentRoundCount,
                        completeCount: completeRoundCount,
                        title: 'ROUND',
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ProgressCheckWidget(
                        currentCount: currentGoalCount,
                        completeCount: completeGoalCount,
                        title: 'GOAL',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressCheckWidget extends StatelessWidget {
  final int currentCount, completeCount;
  final String title;

  const ProgressCheckWidget({
    super.key,
    required this.currentCount,
    required this.completeCount,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$currentCount / $completeCount',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: Colors.white70,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

class DurationListWidget extends StatelessWidget {
  final List<String> durationList;
  final String selectedDuration;
  final Function onClickDuration;

  const DurationListWidget(
      {super.key,
      required this.durationList,
      required this.selectedDuration,
      required this.onClickDuration});

  bool isSelectedDuration(String duration) => duration == selectedDuration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ShaderMask(
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.white24,
            Colors.white,
            Colors.white,
            Colors.white24,
          ],
          stops: [
            0,
            0.2,
            0.8,
            1
          ], // 10% purple, 80% transparent, 10% purple
        ).createShader(rect);
      },
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: durationList.length,
        itemBuilder: (_, int index) {
          return getDurationItem(theme, durationList[index]);
        },
      ),
    );
  }

  Widget getDurationItem(ThemeData theme, String duration) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () => {onClickDuration(duration)},
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelectedDuration(duration) ? theme.cardColor : null,
            borderRadius: BorderRadius.circular(8),
            border: isSelectedDuration(duration)
                ? null
                : Border.all(
                    color: theme.cardColor,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
          ),
          width: 70,
          child: Text(
            duration,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: isSelectedDuration(duration)
                  ? theme.colorScheme.background
                  : theme.cardColor,
            ),
          ),
        ),
      ),
    );
  }
}

class TimeStackBoxWidget extends StatelessWidget {
  final String content;

  const TimeStackBoxWidget({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          child: Container(
            height: 100,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: theme.cardColor.withOpacity(0.6),
            ),
          ),
        ),
        Positioned(
          top: 5,
          child: Container(
            height: 100,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: theme.cardColor.withOpacity(0.8),
            ),
          ),
        ),
        Positioned(
          top: 13,
          child: Container(
            height: 180,
            width: 130,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              content,
              style: TextStyle(
                color: theme.textTheme.displayLarge?.color,
                fontSize: 70,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        )
      ],
    );
  }
}
