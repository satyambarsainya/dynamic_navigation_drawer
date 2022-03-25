import 'package:dynamic_navigation_drawer/dynamic_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String _platformVersion = 'Unknown';

  // @override
  // void initState() {
  //   super.initState();
  //   initPlatformState();
  // }
  //
  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   // We also handle the message potentially returning null.
  //   try {
  //     platformVersion = await DynamicNavigationDrawer.platformVersion ??
  //         'Unknown platform version';
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }
  //
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // systemNavigationBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
    var tileList = {
      "Profile": Icons.people,
      "Home": Icons.home,
      "Settings": Icons.settings,
      "Logout": Icons.logout
    };
    return Scaffold(
      drawer: DynamicNavigationDrawer(
        tileList: tileList,
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
        // backgroundColorForDrawerPane: Colors.red,
        onTap: (String value) {
          print(value);
        },
      ),
      // drawer: Drawer(),
      appBar: AppBar(
        title: const Text('Dynamic Navigation Drawer'),
      ),
      body: GestureDetector(
        onTap: () {},
        child: Center(
          child: Text('Dynamic Navigation Drawer'),
        ),
      ),
    );
  }
}
