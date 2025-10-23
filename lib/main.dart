import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sport Kcal Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _minutesController = TextEditingController();
  String _selectedActivity = 'Bieganie';

  final Map<String, double> _activityKcalPerMin = {
    'Bieganie': 10.0,
    'Jazda na rowerze': 8.0,
    'Pływanie': 9.0,
    'Chodzenie': 4.5,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sport Kcal Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedActivity,
              onChanged: (value) {
                setState(() {
                  _selectedActivity = value!;
                });
              },
              items: _activityKcalPerMin.keys
                  .map((activity) => DropdownMenuItem(
                        child: Text(activity),
                        value: activity,
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _minutesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Czas w minutach',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final minutes = double.tryParse(_minutesController.text);
                if (minutes != null) {
                  final kcal = _activityKcalPerMin[_selectedActivity]! * minutes;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultPage(
                        activity: _selectedActivity,
                        minutes: minutes,
                        kcal: kcal,
                      ),
                    ),
                  );
                }
              },
              child: Text('Oblicz kalorie'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final String activity;
  final double minutes;
  final double kcal;

  ResultPage({
    required this.activity,
    required this.minutes,
    required this.kcal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wynik'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Aktywność: $activity',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Czas: ${minutes.toStringAsFixed(1)} min',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Spalone kalorie: ${kcal.toStringAsFixed(1)} kcal',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Wróć'),
            )
          ],
        ),
      ),
    );
  }
}
