import 'package:flutter/material.dart';
import 'package:project/service/Species.dart';
import 'package:project/service/anime.dart';
import 'package:project/tab/profile.dart';
import 'package:project/tab/settings.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;

  final List<String> title = [
    'Anime List',
    'People List',
    'Location List',
    'Species List'
  ];

  final List<Widget> pages = [
    const AnimePage(),
    const ProfilePage(),
    const LocationsPage(),
    const Species(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title[selectedIndex])),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Text(title[selectedIndex])),
            ListTile(title: Text('Species'), onTap: () {
              Navigator.pop(context);

              setState(() {
                selectedIndex = 3;
              });
            },),
            ListTile(
              title: Text('LogOut'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Log Out'),
                      content: Text('Are you Sure You Want to Log out?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/signin',
                              (router) => false,
                            );
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Anime'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'People'),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'Location',
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: pages[selectedIndex],
    );
  }
}
