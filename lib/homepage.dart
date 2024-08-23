import 'package:flutter/material.dart';
import 'package:friends/components/mytext.dart';
import 'package:friends/seasons.dart';
import 'package:friends/settings.dart';
import 'package:friends/suggestions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    Seasons(),
    Suggestions(),
    Settings(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.of(context).pop(); // Close the drawer after selection
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: MyText(data: "M E N U", fontSize: 30.0),
            ),
            ListTile(
              leading: const Icon(Icons.window),
              title: const Text(
                'Seasons',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text(
                'Suggestion',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => _onItemTapped(2),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _pages[_selectedIndex],
      ),
    );
  }
}
