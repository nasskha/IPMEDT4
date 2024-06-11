import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'widget/line_chart_widget.dart'; // Adjust the import according to your file structure

class VoortgangPage extends StatefulWidget {
  final Function(String) updateSelectedEmoji;

  const VoortgangPage({Key? key, required this.updateSelectedEmoji}) : super(key: key);

  @override
  _VoortgangPageState createState() => _VoortgangPageState();
}

class _VoortgangPageState extends State<VoortgangPage> {
  final List<String> emojis = [
    '😄', '😊', '😔', '😢', '😡', '😴', '🥳', '😎' // Add more emojis as needed
  ];

  final Map<String, double> emojiToYValue = {
    '😄': 8.0, '😊': 7.0, '😔': 4.0, '😢': 3.0, '😡': 2.0, '😴': 5.0, '🥳': 6.0, '😎': 7.0
  };

  final List<FlSpot> points = [];
  String _selectedTimeline = 'Week'; // Initial selection

  @override
  void initState() {
    super.initState();
    fetchProgressData();
    loadSavedData(); // Load saved data when the app starts
  }

  Future<void> fetchProgressData() async {
    try {
      final response = await http.get(
        Uri.parse('http://your-backend-url.com/api/voortgang'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          points.clear();
          for (var item in data) {
            points.add(FlSpot(item['day'].toDouble(), emojiToYValue[item['emoji']] ?? 0.0));
          }
        });
        saveData(); // Save fetched data to persistent storage
      } else {
        print('Failed to load data: ${response.body}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedPoints = prefs.getString('points');
    if (savedPoints != null) {
      final List<dynamic> data = json.decode(savedPoints);
      setState(() {
        points.clear();
        for (var item in data) {
          points.add(FlSpot(item['x'].toDouble(), item['y'].toDouble()));
        }
      });
    }
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final String pointsData = json.encode(points.map((point) => {'x': point.x, 'y': point.y}).toList());
    await prefs.setString('points', pointsData);
  }

  void updateSelectedEmoji(String emoji) {
    setState(() {
      if (_selectedTimeline == 'Week' && points.length < 7 ||
          _selectedTimeline == 'Month' && points.length < 30 ||
          _selectedTimeline == 'Year' && points.length < 12) {
        points.add(FlSpot(points.length.toDouble(), emojiToYValue[emoji] ?? 0.0));
      }
      widget.updateSelectedEmoji(emoji); // Update the selected emoji
      saveData(); // Save data whenever a new point is added
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status:'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...emojis.map((emoji) => GestureDetector(
                    onTap: () {
                      updateSelectedEmoji(emoji);
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 4), // Add space between emojis
                      decoration: BoxDecoration(
                        color: Colors.brown[50],
                        borderRadius: BorderRadius.circular(5.0), // Smaller squares around emojis
                      ),
                      child: Text(
                        emoji,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Text(
                    'Mood Graph',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(), // Add space between text and dropdown
                  Container(
                    width: 100, // Set a smaller width for the dropdown
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), // Rounded edges
                      color: Colors.white, // Set the background color to white
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedTimeline,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedTimeline = newValue!;
                          });
                        },
                        items: <String>['Week', 'Month', 'Year']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0), // Make the items smaller
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        dropdownColor: Colors.white, // Set dropdown background color
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8), // Add padding to top
                child: LineChartWidget(
                  points: points,
                  selectedTimeline: _selectedTimeline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
