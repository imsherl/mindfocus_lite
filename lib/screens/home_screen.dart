import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/session_manager.dart';

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
  late int remainingSeconds;
  Timer? _timer;
  
  // SessionManager instance
  final SessionManager _sessionManager = SessionManager();

  @override
  void initState() {
    super.initState();
    _resetTimer();
    // Add mock sessions for demo purposes
    _sessionManager.addMockSessions();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      isRunning = false;
      isWorkSession = true;
      remainingSeconds = workDuration * 60;
    });
  }

  void _toggleTimer() {
    setState(() {
      if (isRunning) {
        // Pausing - end current session
        _timer?.cancel();
        _sessionManager.endSession();
      } else {
        // Starting - begin new session
        _sessionManager.startSession(isWork: isWorkSession);
        _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
      }
      isRunning = !isRunning;
    });
  }

  void _onTick(Timer timer) {
    setState(() {
      if (remainingSeconds > 0) {
        remainingSeconds--;
      } else {
        // Session completed
        timer.cancel();
        isRunning = false;
        
        // End current session and save it
        final completedSession = _sessionManager.endSession();
        
        // Switch session type for next session
        isWorkSession = !isWorkSession;
        remainingSeconds = (isWorkSession ? workDuration : breakDuration) * 60;
        
        // Show completion dialog
        _showSessionCompleteDialog(completedSession != null);
      }
    });
  }

  void _showSessionCompleteDialog(bool sessionSaved) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isWorkSession 
          ? 'Break Time!' 
          : 'Work Session Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(isWorkSession
              ? 'Great work! Take a $breakDuration minute break.'
              : 'Break complete! Ready for a $workDuration minute work session?'),
            if (sessionSaved && !isWorkSession) ...[
              const SizedBox(height: 10),
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 24,
              ),
              const Text(
                'Session saved!',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _toggleTimer(); // Auto-start next session
            },
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final currentDuration = isWorkSession ? workDuration : breakDuration;
    final progress = remainingSeconds / (currentDuration * 60);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MindFocus Lite'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // End any active session before resetting
              if (_sessionManager.hasActiveSession) {
                _sessionManager.endSession();
              }
              _resetTimer();
            },
            tooltip: 'Reset Timer',
          ),
        ],
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
            const SizedBox(height: 20),
            
            // Session tracking status
            if (_sessionManager.hasActiveSession)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '⏱️ Session in progress',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            
            // Timer display
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isWorkSession 
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                Text(
                  _formatTime(remainingSeconds),
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