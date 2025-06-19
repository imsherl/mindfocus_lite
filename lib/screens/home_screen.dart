import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Constants for timer durations (in minutes)
  static const int workDuration = 25;
  static const int breakDuration = 5;

  bool isRunning = false;
  bool isWorkSession = true;
  int remainingSeconds = workDuration * 60;

  void _toggleTimer() {
    setState(() {
      isRunning = !isRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MindFocus Lite'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Session type indicator
            Text(
              isWorkSession ? 'Work Session' : 'Break Time',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 40),
            
            // Timer display
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: remainingSeconds / (workDuration * 60),
                    strokeWidth: 8,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isWorkSession ? Colors.blue : Colors.green,
                    ),
                  ),
                ),
                Text(
                  '${remainingSeconds ~/ 60}:${(remainingSeconds % 60).toString().padLeft(2, '0')}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            const SizedBox(height: 40),
            
            // Start/Pause button
            ElevatedButton.icon(
              onPressed: _toggleTimer,
              icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
              label: Text(isRunning ? 'Pause' : 'Start Focus Session'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 