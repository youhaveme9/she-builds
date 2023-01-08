import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prega/pages/add_doc.dart';
import 'package:prega/pages/feeds.dart';
import 'package:prega/pages/profile.dart';
import 'package:prega/pages/tips.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: EntryPage(),
    );
  }
}

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const Feeds(),
    const AddDoc(),
    Tips(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.rocket),
            label: 'Feeds',
            backgroundColor: Color.fromARGB(255, 27, 27, 27),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo_rounded),
            label: 'Add Docs',
            backgroundColor: Color.fromARGB(255, 27, 27, 27),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.atom),
            label: 'Tips',
            backgroundColor: Color.fromARGB(255, 27, 27, 27),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Profile',
            backgroundColor: Color.fromARGB(255, 27, 27, 27),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 201, 201, 201),
        onTap: _onItemTapped,
      ),
    );
  }
}
