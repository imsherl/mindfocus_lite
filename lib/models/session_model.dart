class FocusSession {
  final DateTime startTime;
  final DateTime endTime;
  final bool isWorkSession;

  FocusSession({
    required this.startTime,
    required this.endTime,
    required this.isWorkSession,
  });

  /// Calculate the duration of the focus session
  Duration get duration => endTime.difference(startTime);

  /// Static method to return mock data for testing
  static List<FocusSession> getMockSessions() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    return [
      FocusSession(
        startTime: today.add(const Duration(hours: 9)),
        endTime: today.add(const Duration(hours: 9, minutes: 25)),
        isWorkSession: true,
      ),
      FocusSession(
        startTime: today.add(const Duration(hours: 10)),
        endTime: today.add(const Duration(hours: 10, minutes: 5)),
        isWorkSession: false, // Break session
      ),
      FocusSession(
        startTime: today.add(const Duration(hours: 10, minutes: 30)),
        endTime: today.add(const Duration(hours: 10, minutes: 55)),
        isWorkSession: true,
      ),
      FocusSession(
        startTime: today.add(const Duration(hours: 14)),
        endTime: today.add(const Duration(hours: 14, minutes: 25)),
        isWorkSession: true,
      ),
    ];
  }

  /// Get total focus time for today from mock sessions
  static Duration getTotalFocusTimeToday() {
    final sessions = getMockSessions();
    Duration totalTime = Duration.zero;
    
    for (final session in sessions) {
      if (session.isWorkSession) {
        totalTime += session.duration;
      }
    }
    
    return totalTime;
  }

  /// Get count of completed work sessions today
  static int getCompletedSessionsToday() {
    final sessions = getMockSessions();
    return sessions.where((session) => session.isWorkSession).length;
  }
} 