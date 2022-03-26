import 'package:flutter/material.dart';

class DynamicNavigationDrawer extends StatefulWidget {
  final Function(String) onTap;
  final MaterialColor backgroundColorForMenu;
  final MaterialColor backgroundColorForDrawerHeader;
  final MaterialColor? backgroundColorForDrawerPane;
  final double drawerWidth;
  final double drawerMenuHeight;
  final Map<String, IconData> tileListWithIcon;
  final List? tileList;
  final bool onlyTileListRequired;
  final bool tileListWithIconRequired;
  final Color? menuFontColor;
  final double? menuFontSize;
  final TextAlign? menuTextAlign;
  final bool isDrawerHeaderRequired;
  final String? accountName;
  final String? accountEmail;
  final String? imageUrl;
  final MaterialColor menuNotSelectedColor;

  const DynamicNavigationDrawer(
      {Key? key,
      required this.onTap,
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
      required this.tileListWithIcon,
      this.accountName,
      this.accountEmail,
      this.imageUrl,
      this.tileList,
      required this.onlyTileListRequired,
      required this.tileListWithIconRequired})
      : super(key: key);

  @override
  DynamicNavigationDrawerState createState() => DynamicNavigationDrawerState();
}

class DynamicNavigationDrawerState extends State<DynamicNavigationDrawer> {
  late int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.onlyTileListRequired == true &&
        widget.tileListWithIconRequired == false &&
        widget.tileList != null &&
        widget.tileList?.length != 0) {
      return Column(
        crossAxisAlignment: widget.isDrawerHeaderRequired
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.start,
        children: [
          widget.isDrawerHeaderRequired
              ? buildDrawerHeader(context)
              : Container(),
          buildDrawerMenuWithoutIcon(context)
        ],
      );
    } else if (widget.onlyTileListRequired == false &&
        widget.tileListWithIconRequired == true &&
        widget.tileListWithIcon?.length != 0) {
      return Column(
        crossAxisAlignment: widget.isDrawerHeaderRequired
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.start,
        children: [
          widget.isDrawerHeaderRequired
              ? buildDrawerHeader(context)
              : Container(),
          buildDrawerMenuWithIcon(context),
        ],
      );
    } else if (widget.onlyTileListRequired == true &&
        widget.tileListWithIconRequired == true) {
      throw Exception(
          "You can set either onlyTileListRequired or tileListWithIconRequired as true and not both the flag");
    } else {
      throw Exception(
          "Widget can't be render as the tileList or tileListWithIcon is empty");
    }
  }

  Widget buildDrawerMenuWithoutIcon(BuildContext context) {
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
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.tileList?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.onTap(
                                widget.tileListWithIcon.keys.elementAt(index));
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          color: selectedIndex == index
                              ? Colors.red
                              : widget.menuNotSelectedColor,
                          height: widget.drawerMenuHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(
                                child: widget.tileListWithIcon.keys != null
                                    ? Text(
                                        widget.tileListWithIcon.keys
                                            .elementAt(index),
                                        style: TextStyle(
                                            color: widget.menuFontColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                widget.menuFontSize ?? 10.0),
                                      )
                                    : Container(),
                              ),
                              Container()
                            ],
                          ),
                        ),
                      ),
                      const Divider(height: 0.3)
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawerMenuWithIcon(BuildContext context) {
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
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.tileListWithIcon.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.onTap(
                                widget.tileListWithIcon.keys.elementAt(index));
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
                                child: widget.tileListWithIcon.values != null
                                    ? Icon(widget.tileListWithIcon.values
                                        .elementAt(index))
                                    : Container(),
                              ),
                              Expanded(
                                child: Center(
                                  child: widget.tileListWithIcon.keys != null
                                      ? Text(
                                          widget.tileListWithIcon.keys
                                              .elementAt(index),
                                          style: TextStyle(
                                              color: widget.menuFontColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  widget.menuFontSize ?? 10.0),
                                        )
                                      : Container(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider(height: 0.3)
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawerHeader(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / (widget.drawerWidth),
      child: UserAccountsDrawerHeader(
        margin: const EdgeInsets.only(bottom: 0.0),
        decoration: const BoxDecoration(
          color: Colors.tealAccent,
        ),
        accountName: Text(widget.accountName.toString()),
        accountEmail: Text(widget.accountEmail.toString()),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
              ? Colors.blue
              : Colors.white,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(widget.imageUrl.toString()),
                  fit: BoxFit.fill),
            ),
          ),
        ),
      ),
    );
  }
}
