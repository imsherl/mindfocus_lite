import 'package:flutter/material.dart';
import '../models/session_model.dart';
import '../utils/session_manager.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  /// Format duration to display minutes in a user-friendly way
  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    if (minutes == 0) {
      return '0 minutes';
    } else if (minutes == 1) {
      return '1 minute';
    } else {
      return '$minutes minutes';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get SessionManager instance
    final sessionManager = SessionManager();
    
    // Get data from SessionManager instead of static methods
    final totalFocusTime = sessionManager.getTotalFocusTimeToday();
    final completedSessions = sessionManager.getCompletedSessionsToday();
    final allSessions = sessionManager.getTodaySessions();
    
    // Check if there are any sessions for fallback
    final hasData = allSessions.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: Center(
        child: hasData 
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Focus Time Section
                Icon(
                  Icons.timer,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  _formatDuration(totalFocusTime),
                  style: TextStyle(
                    fontSize: 32, 
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const Text(
                  'Today\'s Focus Time',
                  style: TextStyle(
                    fontSize: 16, 
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Sessions Section
                Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(height: 16),
                Text(
                  completedSessions == 1 
                    ? '1 session' 
                    : '$completedSessions sessions',
                  style: TextStyle(
                    fontSize: 32, 
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const Text(
                  'Completed Today',
                  style: TextStyle(
                    fontSize: 16, 
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Active session indicator
                if (sessionManager.hasActiveSession) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '🏃‍♂️ Session in progress',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.analytics_outlined,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No data yet',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Start a focus session to see your stats',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
      ),
    );
  }
} 