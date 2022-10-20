import 'package:flutter/material.dart';

enum TabItem { gi, green, blue }

const Map<TabItem, String> tabName = {
  TabItem.gi: 'red',
  TabItem.green: 'green',
  TabItem.blue: 'blue',
};

const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.gi: Colors.red,
  TabItem.green: Colors.green,
  TabItem.blue: Colors.blue,
};