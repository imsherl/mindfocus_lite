import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Focus Time Section
            Icon(
              Icons.timer,
              size: 80,
              color: Colors.blue,
            ),
            SizedBox(height: 16),
            Text(
              '50 minutes',
              style: TextStyle(
                fontSize: 32, 
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text(
              'Today\'s Focus Time',
              style: TextStyle(
                fontSize: 16, 
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            
            SizedBox(height: 40),
            
            // Sessions Section
            Icon(
              Icons.check_circle,
              size: 80,
              color: Colors.green,
            ),
            SizedBox(height: 16),
            Text(
              '3 sessions',
              style: TextStyle(
                fontSize: 32, 
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Text(
              'Completed Today',
              style: TextStyle(
                fontSize: 16, 
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 