

import 'package:flutter/material.dart';
import 'package:master_page_app/responsive_layout.dart';

import 'constants.dart';

class ButtonsInfo {
  String title;
  IconData icon;
  ButtonsInfo({required this.title, required this.icon});
}

class Task {
  String task;
  double taskValue;
  Color color;
  Task({required this.task, required this.taskValue, required this.color});
}

int _currentIndex = 0;

List<ButtonsInfo> _buttonNames = [
  ButtonsInfo(title: "Home", icon: Icons.home),
  ButtonsInfo(title: "Customer", icon: Icons.person),
  ButtonsInfo(title: "Setting", icon: Icons.settings),
  ButtonsInfo(title: "Notifications", icon: Icons.notifications),
  ButtonsInfo(title: "Contacts", icon: Icons.contact_phone_rounded),
  ButtonsInfo(title: "Sales", icon: Icons.sell),
  ButtonsInfo(title: "Marketing", icon: Icons.mark_email_read),
  ButtonsInfo(title: "Security", icon: Icons.verified_user),
  ButtonsInfo(title: "Users", icon: Icons.supervised_user_circle_rounded),
];

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Drawer(
        elevation: 0,
        child: SingleChildScrollView(
          child: Padding(
            // padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
            padding : const EdgeInsets.only(left: 8.0,right: 8.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    "Administrator Menu",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  trailing: !ResponsiveLayout.isComputer(context)
                      ? Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close, color: Colors.white),
                          ),
                        )
                      : null,
                ),
                ...List.generate(
                  _buttonNames.length,
                  (index) => Column(
                    children: [
                      Container(
                        decoration: index == _currentIndex
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [
                                    Constants.red.withOpacity(0.9),
                                    Constants.orange.withOpacity(1.0),
                                    Colors.white38,
                                  ],
                                ),
                              )
                            : null,
                        child: ListTile(
                          title: Text(
                            _buttonNames[index].title,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          leading: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              _buttonNames[index].icon,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
