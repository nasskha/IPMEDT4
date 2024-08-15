import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'widget/line_chart_widget.dart'; // Adjust the import according to your file structure

class VoortgangPage extends StatefulWidget {
  final Function(String) updateSelectedEmoji;

  const VoortgangPage({super.key, required this.updateSelectedEmoji});

  @override
  _VoortgangPageState createState() => _VoortgangPageState();
}

class _VoortgangPageState extends State<VoortgangPage> {
  final List<String> emojis = [
    '😔','😢','😡','😴','😊','😄','😎','🥳' // Add more emojis as needed
  ];

  final Map<String, double> emojiToYValue = {
    '😔':1.0, '😢':2.0, '😡':3.0, '😴':4.0, '😊':5.0, '😄':6.0, '😎':7.0, '🥳': 8.0
  };

  List<FlSpot> points = [];
  String _selectedTimeline = 'Week'; // Initial selection
  String _selectedWeek = '1-7'; // Initial week selection

  @override
  void initState() {
    super.initState();
    clearSavedData();
    fetchProgressData(_selectedWeek);
  }

  Future<void> clearSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      points = [];
    });
  }

  Future<void> fetchProgressData(String period) async {
    // Clear the points list for a new period
    setState(() {
      points = [];
    });

    if (_selectedTimeline == 'Week') {
      loadSavedData(period);
    } else {
      aggregateDataForTimeline(period);
    }
  }

  Future<void> loadSavedData(String period) async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedPoints = prefs.getString('points_$period');
    if (savedPoints != null) {
      final List<dynamic> data = json.decode(savedPoints);
      setState(() {
        points = data.map((item) => FlSpot(item['x'].toDouble(), item['y'].toDouble())).toList();
        points.sort((a, b) => a.x.compareTo(b.x)); // Ensure points are sorted
      });
    }
  }

  Future<void> aggregateDataForTimeline(String period) async {
    final prefs = await SharedPreferences.getInstance();
    List<FlSpot> aggregatedPoints = [];

    if (_selectedTimeline == 'Month') {
      List<String> weeksInMonth = getWeeksInMonth(period);
      for (String week in weeksInMonth) {
        final String? savedPoints = prefs.getString('points_$week');
        if (savedPoints != null) {
          final List<dynamic> data = json.decode(savedPoints);
          aggregatedPoints.addAll(
            data.map((item) => FlSpot(item['x'].toDouble(), item['y'].toDouble())).toList(),
          );
        }
      }
    } else if (_selectedTimeline == 'Year') {
      List<String> monthsInYear = getMonthsInYear(period);
      for (String month in monthsInYear) {
        List<String> weeksInMonth = getWeeksInMonth(month);
        for (String week in weeksInMonth) {
          final String? savedPoints = prefs.getString('points_$week');
          if (savedPoints != null) {
            final List<dynamic> data = json.decode(savedPoints);
            aggregatedPoints.addAll(
              data.map((item) => FlSpot(item['x'].toDouble(), item['y'].toDouble())).toList(),
            );
          }
        }
      }
    }

    // Ensure no duplicate x-values and sort points
    aggregatedPoints = aggregatedPoints.toSet().toList(); // Remove duplicates
    aggregatedPoints.sort((a, b) => a.x.compareTo(b.x)); // Sort points by x-value

    setState(() {
      points = aggregatedPoints;
    });
  }

  List<String> getWeeksInMonth(String month) {
    // Simulate weeks in a month
    return ['1-7', '7-14', '14-21', '21-28'];
  }

  List<String> getMonthsInYear(String year) {
    // Simulate months in a year
    return ['2024-01', '2024-02', '2024-03', '2024-04', '2024-05', '2024-06', '2024-07', '2024-08', '2024-09', '2024-10', '2024-11', '2024-12'];
  }

  Future<void> saveData(String period) async {
    final prefs = await SharedPreferences.getInstance();
    final String pointsData = json.encode(points.map((point) => {'x': point.x, 'y': point.y}).toList());
    await prefs.setString('points_$period', pointsData);
  }

  void updateSelectedEmoji(String emoji) {
    setState(() {
      if (points.length < 7) {
        points.add(FlSpot(points.length.toDouble(), emojiToYValue[emoji] ?? 0.0));
      }
      widget.updateSelectedEmoji(emoji); // Update the selected emoji
      saveData(_selectedWeek); // Save data whenever a new point is added
    });
  }

  List<String> getWeekLabels() {
    return ['1-7', '7-14', '14-21', '21-28'];
  }

  String getCurrentMonth() {
    return DateFormat('MMMM').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How are you feeling today?'),
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
              padding: const EdgeInsets.only(top:0),
              child: Row(
                children: [
                  const Text(
                    'Mood Graph',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                            fetchProgressData(_selectedWeek);
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
                                padding: const EdgeInsets.symmetric(horizontal: 17.0), // Make the items smaller
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
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 170),
              child: Row(
                children: [
                  const Text(
                    '',
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
                        value: _selectedWeek,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          if (newValue != null && getWeekLabels().contains(newValue)) {
                            setState(() {
                              _selectedWeek = newValue;
                              fetchProgressData(_selectedWeek);
                            });
                          }
                        },
                        items: getWeekLabels()
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0), // Make the items smaller
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
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 250), // Add padding to top
              child: Text(
                'Month: ${getCurrentMonth()}',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0), // Add padding to top
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
