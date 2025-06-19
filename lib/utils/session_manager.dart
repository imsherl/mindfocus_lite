import '../models/session_model.dart';

class SessionManager {
  // Singleton pattern
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  // Private list to store sessions in memory
  final List<FocusSession> _sessions = [];
  
  // Current session tracking
  DateTime? _currentSessionStart;
  bool? _currentSessionIsWork;

  /// Start a new focus session
  void startSession({required bool isWork}) {
    _currentSessionStart = DateTime.now();
    _currentSessionIsWork = isWork;
  }

  /// End the current session and add it to the list
  FocusSession? endSession() {
    if (_currentSessionStart == null || _currentSessionIsWork == null) {
      return null; // No active session to end
    }

    final session = FocusSession(
      startTime: _currentSessionStart!,
      endTime: DateTime.now(),
      isWorkSession: _currentSessionIsWork!,
    );

    _sessions.add(session);
    
    // Reset current session tracking
    _currentSessionStart = null;
    _currentSessionIsWork = null;
    
    return session;
  }

  /// Get all sessions for today
  List<FocusSession> getTodaySessions() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    return _sessions.where((session) {
      return session.startTime.isAfter(today) && 
             session.startTime.isBefore(tomorrow);
    }).toList();
  }

  /// Get all sessions (for debugging/testing)
  List<FocusSession> getAllSessions() {
    return List.from(_sessions);
  }

  /// Add mock sessions for testing
  void addMockSessions() {
    final mockSessions = FocusSession.getMockSessions();
    _sessions.addAll(mockSessions);
  }

  /// Clear all sessions (for testing)
  void clearSessions() {
    _sessions.clear();
    _currentSessionStart = null;
    _currentSessionIsWork = null;
  }

  /// Check if there's an active session
  bool get hasActiveSession => _currentSessionStart != null;

  /// Get active session info
  Map<String, dynamic>? get activeSessionInfo {
    if (!hasActiveSession) return null;
    
    return {
      'startTime': _currentSessionStart,
      'isWork': _currentSessionIsWork,
      'duration': DateTime.now().difference(_currentSessionStart!),
    };
  }

  /// Get total focus time for today from actual sessions
  Duration getTotalFocusTimeToday() {
    final todaySessions = getTodaySessions();
    Duration totalTime = Duration.zero;
    
    for (final session in todaySessions) {
      if (session.isWorkSession) {
        totalTime += session.duration;
      }
    }
    
    return totalTime;
  }

  /// Get count of completed work sessions today
  int getCompletedSessionsToday() {
    final todaySessions = getTodaySessions();
    return todaySessions.where((session) => session.isWorkSession).length;
  }
} 