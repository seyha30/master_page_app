
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'constants.dart';
import 'responsive_layout.dart';

List<String> _buttonNames = ["Overview", "Customer", "Sales"];
int _currentSelectedButton = 0;

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: purpleLightColor,
      child: Row(
        children: [
          if (ResponsiveLayout.isComputer(context))
            Container(
              margin: EdgeInsets.only(left: 10.0),
              height: double.infinity,
              decoration: BoxDecoration(
                // boxShadow: const [
                //   BoxShadow(
                //     color: Colors.black45,
                //     offset: Offset(0, 0),
                //     spreadRadius: 1,
                //     blurRadius: 10,
                //   ),
                // ],
                border: Border.all(color: Colors.red),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
                child: Image.asset("asset/images/profile.png"),
              ),
            )
          else
            IconButton(
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
          const SizedBox(width: Constants.kPadding),
          if (ResponsiveLayout.isComputer(context))
            OutlinedButton(
              onPressed: () => print('Admin button clicked'),
              child: const Padding(
                padding: EdgeInsets.all(Constants.kPadding / 2),
                child: Text("Admin"),
              ),
              style: OutlinedButton.styleFrom(
                primary: whiteColor,
                side: const BorderSide(color: Colors.white, width: 0.4),
              ),
            ),
          const Spacer(),
          if (ResponsiveLayout.isComputer(context))
            ...List.generate(
              _buttonNames.length,
              (index) => TextButton(
                onPressed: () {
                  setState(() {
                    _currentSelectedButton = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(Constants.kPadding * 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _buttonNames[index],
                        style: TextStyle(
                          color: _currentSelectedButton == index ? Colors.white : Colors.white70,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(Constants.kPadding / 2),
                        width: 60,
                        height: 2,
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.red),
                          gradient: _currentSelectedButton == index
                              ? const LinearGradient(
                                  colors: [
                                    redColor,
                                    Constants.orange,
                                  ],
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(Constants.kPadding * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _buttonNames[_currentSelectedButton],
                    style: const TextStyle(
                      color: whiteColor,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(Constants.kPadding / 2),
                    width: 60,
                    height: 2,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          redColor,
                          Constants.orange,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const Spacer(),
          IconButton(
            color: Colors.white,
            iconSize: 30,
            onPressed: () => print('search button pressed'),
            icon: const Icon(Icons.search),
          ),
          Stack(
            children: [
              IconButton(
                color: Colors.white,
                iconSize: 30,
                onPressed: () => print('Login screen'),
                icon: const Icon(Icons.notifications_none_outlined),
              ),
              const Positioned(
                right: 6,
                top: 6,
                child: CircleAvatar(
                  backgroundColor: Colors.pink,
                  radius: 8,
                  child: Text(
                    '1',
                    style: TextStyle(fontSize: 10, color: whiteColor),
                  ),
                ),
              ),
            ],
          ),
          // top right profile image
          // if (!ResponsiveLayout.isPhone(context))
          //   Container(
          //     margin: EdgeInsets.all(Constants.kPadding),
          //     height: double.infinity,
          //     decoration: BoxDecoration(boxShadow: [
          //       BoxShadow(
          //         color: Colors.black45,
          //         offset: Offset(0, 0),
          //         spreadRadius: 1,
          //         blurRadius: 10,
          //       )
          //     ], shape: BoxShape.circle),
          //     child: CircleAvatar(
          //       backgroundColor: orangeColor,
          //       radius: 30,
          //       backgroundImage: AssetImage(
          //         "asset/images/profile.png",
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
