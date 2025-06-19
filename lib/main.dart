import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/suggestion_screen.dart';
import 'screens/breathing_screen.dart';

void main() {
  runApp(const MindFocusLiteApp());
}

class MindFocusLiteApp extends StatelessWidget {
  const MindFocusLiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindFocus Lite',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const MainScreen(initialIndex: 0),
        '/stats': (context) => const MainScreen(initialIndex: 1),
        '/suggestion': (context) => const MainScreen(initialIndex: 2),
        '/breathing': (context) => const MainScreen(initialIndex: 3),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  final int initialIndex;
  
  const MainScreen({super.key, required this.initialIndex});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  // Use IndexedStack to maintain state across navigation
  final List<Widget> _screens = [
    const HomeScreen(),
    const StatsScreen(),
    const SuggestionScreen(),
    const BreathingScreen(),
  ];

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    
    // Navigate to the corresponding route
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/stats');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/suggestion');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/breathing');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Suggestion',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.air),
            label: 'Breathing',
          ),
        ],
      ),
    );
  }
}
