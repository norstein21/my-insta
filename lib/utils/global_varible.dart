import 'package:flutter/material.dart';

const webScreenSize = 600;

// const homeScreenItem = <Widget>[
//             Center(child: Text(user!.username)),
//             Center(child: Text(user.email)),
//             Center(child: Text(user.bio)),
//             Center(child: Text(user.uid)),
//             Center(child: Text(user.profileImage))
//           ]

const bottomNavbarItem = <BottomNavigationBarItem>[
  BottomNavigationBarItem(icon: Icon(Icons.home)),
  BottomNavigationBarItem(icon: Icon(Icons.search)),
  BottomNavigationBarItem(icon: Icon(Icons.add_circle)),
  BottomNavigationBarItem(icon: Icon(Icons.favorite)),
  BottomNavigationBarItem(icon: Icon(Icons.person))
];
