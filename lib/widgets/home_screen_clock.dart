import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreenClock extends StatefulWidget {
  const HomeScreenClock({super.key});

  @override
  State<HomeScreenClock> createState() => _HomeScreenClockState();
}

class _HomeScreenClockState extends State<HomeScreenClock> {
  late Stream<DateTime> timeStream;
  DateTime currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    timeStream = Stream<DateTime>.periodic(const Duration(seconds: 1), (_) {
      setState(() => currentTime = DateTime.now());
      return currentTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: timeStream,
      builder: (context, snapshot) {
        final timeText = DateFormat('h:mm  a').format(
          snapshot.data ?? currentTime,
        );
        final dateText = DateFormat('EEEE, d MMMM').format(
          snapshot.data ?? currentTime,
        );

        return Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                timeText,
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 4),
              Text(
                dateText,
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        );
      },
    );
  }
}
