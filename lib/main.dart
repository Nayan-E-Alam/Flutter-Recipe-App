import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _currentTheme = ThemeData.light();
  bool _isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  // Function to save the user's theme preference
  Future<void> _saveThemePreference(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);
  }

  // Function to retrieve the user's theme preference
  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String theme = prefs.getString('theme') ?? 'light';
    setState(() {
      _isDarkTheme = theme == 'dark';
      _currentTheme = _isDarkTheme ? ThemeData.dark() : ThemeData.light();
    });
  }

  // Function to toggle the theme
  void _toggleTheme(bool value) {
    setState(() {
      _isDarkTheme = value;
      _currentTheme = _isDarkTheme ? ThemeData.dark() : ThemeData.light();
      _saveThemePreference(_isDarkTheme ? 'dark' : 'light');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _currentTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Theme Preference'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select Theme:',
                style: TextStyle(fontSize: 20),
              ),
              SwitchListTile(
                title: Text(_isDarkTheme ? 'Dark Theme' : 'Light Theme'),
                value: _isDarkTheme,
                onChanged: _toggleTheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
