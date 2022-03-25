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

  const DynamicNavigationDrawer(
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
      this.imageUrl});

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
                ),
        buildDrawerMenu(context),
      ],
    );
  }

  Widget buildDrawerMenu(BuildContext context) {
    return Expanded(
      child: Container(
        color: widget.backgroundColorForDrawerPane ?? Colors.white,
        width: MediaQuery.of(context).size.width / widget.drawerWidth,
        height: MediaQuery.of(context).size.height,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: widget.isDrawerHeaderRequired ? true : false,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
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
                        height: widget.drawerMenuHeight,
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
                                      fontSize: widget.menuFontSize ?? 10.0),
                                ),
                              ),
                            )
                          ],
                        )),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
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
      width: MediaQuery.of(context).size.width /
          (widget.drawerWidth ?? 1.5),
      child: UserAccountsDrawerHeader(
        margin: const EdgeInsets.only(bottom: 0.0),
        decoration: const BoxDecoration(
          color: Colors.tealAccent,
        ),
        accountName: Text(widget.accountName.toString() ?? "ABC"),
        accountEmail: Text(widget.accountEmail.toString() ?? "abc@gmail.com"),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
              ? Colors.blue
              : Colors.white,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(widget.imageUrl.toString() ?? "https://www.w3schools.com/howto/img_avatar.png"),
                  fit: BoxFit.fill),
            ),
          ),
        ),
      ),
    );
  }
}
