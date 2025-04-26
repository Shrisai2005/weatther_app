import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String city = "Bangalore";
  String temperature = "";
  String description = "";

  Future<void> fetchWeather() async {
    final apiKey = '8717cd62baa53824d26c081841941378'; // Replace with your key
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        temperature = data['main']['temp'].toString();
        description = data['weather'][0]['description'];
      });
    } else {
      setState(() {
        temperature = "Error";
        description = "City not found";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Enter City"),
              onChanged: (value) {
                city = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchWeather,
              child: Text("Get Weather"),
            ),
            SizedBox(height: 30),
            Text(
              "Temperature: $temperature °C",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Condition: $description",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
