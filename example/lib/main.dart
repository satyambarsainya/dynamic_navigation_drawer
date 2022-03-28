import 'package:dynamic_navigation_drawer/dynamic_navigation_drawer_with_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
    var tileListWithIcon = {
      "Profile": Icons.people,
      "Home": Icons.home,
      "Settings": Icons.settings,
      "Logout": Icons.logout
    };

    List titleList = [];
    titleList.add("Profile");
    titleList.add("Home");
    titleList.add("Settings");
    titleList.add("Logout");

    return Scaffold(
      // Below widget can be used to render Dynamic Navigation Drawer with icon
      drawer: DynamicNavigationDrawerWithIcon(
        initialSelectionIndex: selectedIndex,
        tileListWithIcon: tileListWithIcon,
        isDrawerHeaderRequired: true,
        accountName: "Satyam Barsainya",
        accountEmail: "barsainya.satyam.sb@gmail.com",
        imageUrl: "https://www.w3schools.com/howto/img_avatar.png",
        drawerMenuHeight: 50,
        drawerWidth: 1.5,
        menuFontColor: Colors.white,
        menuFontSize: 15,
        menuTextAlign: TextAlign.center,
        menuNotSelectedColor: Colors.amber,
        backgroundColorForDrawerHeader: Colors.amber,
        backgroundColorForMenu: Colors.green,
        onTap: (String value, int index) {
          if (kDebugMode) {
            print(value);
          }
        },
      ),
      // Below widget can be used to render Dynamic Navigation Drawer without icon
      // drawer: DynamicNavigationDrawerWithoutIcon(
      //   tileList: titleList,
      //   initialSelectionIndex: selectedIndex,
      //   isDrawerHeaderRequired: true,
      //   accountName: "Satyam Barsainya",
      //   accountEmail: "barsainya.satyam.sb@gmail.com",
      //   imageUrl: "https://www.w3schools.com/howto/img_avatar.png",
      //   drawerMenuHeight: 50,
      //   drawerWidth: 1.5,
      //   menuFontColor: Colors.white,
      //   menuFontSize: 15,
      //   menuTextAlign: TextAlign.center,
      //   menuNotSelectedColor: Colors.amber,
      //   backgroundColorForDrawerHeader: Colors.amber,
      //   backgroundColorForMenu: Colors.green,
      //   onTap: (String value, int index) {
      //     selectedIndex = index;
      //     if (kDebugMode) {
      //       print(value);
      //     }
      //   },
      // ),
      appBar: AppBar(
        title: const Text('Dynamic Navigation Drawer'),
      ),
      body: const Center(
        child: Text('Dynamic Navigation Drawer'),
      ),
    );
  }
}
