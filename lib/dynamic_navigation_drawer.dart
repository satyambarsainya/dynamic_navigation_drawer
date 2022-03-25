import 'package:flutter/material.dart';

class DynamicNavigationDrawer extends StatefulWidget {
  final Function(String) onTap;
  final MaterialColor backgroundColorForMenu;
  final MaterialColor backgroundColorForDrawerHeader;
  final MaterialColor? backgroundColorForDrawerPane;
  final double drawerWidth;
  final double drawerMenuHeight;
  final Map<String, IconData> tileList;
  final Color? menuFontColor;
  final double? menuFontSize;
  final TextAlign? menuTextAlign;
  final bool isDrawerHeaderRequired;
  final String? accountName;
  final String? accountEmail;
  final String? imageUrl;
  final MaterialColor menuNotSelectedColor;

  DynamicNavigationDrawer(
      {required this.onTap,
      required this.backgroundColorForMenu,
      required this.backgroundColorForDrawerHeader,
      this.backgroundColorForDrawerPane,
      required this.drawerWidth,
      required this.drawerMenuHeight,
      this.menuFontColor,
      this.menuFontSize,
      this.menuTextAlign,
      required this.isDrawerHeaderRequired,
      required this.menuNotSelectedColor,
      required this.tileList,
      this.accountName,
      this.accountEmail,
      this.imageUrl}); // new code

  // static const MethodChannel _channel =
  //     MethodChannel('dynamic_navigation_drawer');
  //
  // static Future<String?> get platformVersion async {
  //   final String? version = await _channel.invokeMethod('getPlatformVersion');
  //   return version;
  // }
  @override
  DynamicNavigationDrawerState createState() => DynamicNavigationDrawerState();
}

class DynamicNavigationDrawerState extends State<DynamicNavigationDrawer> {
  late int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.isDrawerHeaderRequired
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.start,
      children: [
        widget.isDrawerHeaderRequired
            ? buildDrawerHeader(context)
            : Container(
                // color: Colors.white,
                ),
        buildDrawerMenu(context),
      ],
    );
  }

  Widget buildDrawerMenu(BuildContext context) {
    return Expanded(
      child: Container(
        color: widget.backgroundColorForDrawerPane == null
            ? Colors.white
            : widget.backgroundColorForDrawerPane,
        width: MediaQuery.of(context).size.width /
            (widget.drawerWidth == null ? 1.5 : widget.drawerWidth),
        height: MediaQuery.of(context).size.height,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: widget.isDrawerHeaderRequired ? true : false,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: widget.tileList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      print(widget.tileList.keys.elementAt(index));
                      setState(() {
                        widget.onTap(widget.tileList.keys.elementAt(index));
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                        color: selectedIndex == index
                            ? Colors.red
                            : widget.menuNotSelectedColor,
                        height: widget.drawerMenuHeight == null
                            ? 50
                            : widget.drawerMenuHeight,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Icon(widget.tileList.values.elementAt(index)),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  widget.tileList.keys.elementAt(index),
                                  style: TextStyle(
                                      color: widget.menuFontColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: widget.menuFontSize == null
                                          ? 10.0
                                          : widget.menuFontSize),
                                ),
                              ),
                            )
                          ],
                        )),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 0.5,
                  );
                },
              ),
              // Divider()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawerHeader(BuildContext context) {
    return Container(
      // height: 200,
      width: MediaQuery.of(context).size.width /
          (widget.drawerWidth == null ? 1.5 : widget.drawerWidth),
      child: UserAccountsDrawerHeader(
        margin: EdgeInsets.only(bottom: 0.0),
        decoration: BoxDecoration(
          color: Colors.tealAccent,
        ),
        accountName: Text(widget.accountName.toString() == null
            ? "ABC"
            : widget.accountName.toString()),
        accountEmail: Text(widget.accountEmail.toString() == null
            ? "abc@gmail.com"
            : widget.accountEmail.toString()),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
              ? Colors.blue
              : Colors.white,
          child: Container(
            // width: 200,
            // height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(widget.imageUrl.toString() == null
                      ? "https://www.w3schools.com/howto/img_avatar.png"
                      : widget.imageUrl.toString()),
                  fit: BoxFit.fill),
            ),
          ),
        ),
      ),
    );
  }
}
