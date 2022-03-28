import 'package:flutter/material.dart';

class DynamicNavigationDrawerWithIcon extends StatefulWidget {
  final Function(String, int) onTap;
  final MaterialColor backgroundColorForMenu;
  final MaterialColor backgroundColorForDrawerHeader;
  final MaterialColor? backgroundColorForDrawerPane;
  final double drawerWidth;
  final double drawerMenuHeight;
  final Map<String, IconData> tileListWithIcon;
  final Color? menuFontColor;
  final double? menuFontSize;
  final TextAlign? menuTextAlign;
  final bool isDrawerHeaderRequired;
  final String? accountName;
  final String? accountEmail;
  final String? imageUrl;
  int initialSelectionIndex;
  final MaterialColor menuNotSelectedColor;

  DynamicNavigationDrawerWithIcon(
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
      required this.initialSelectionIndex})
      : super(key: key);

  @override
  DynamicNavigationDrawerWithIconState createState() =>
      DynamicNavigationDrawerWithIconState();
}

class DynamicNavigationDrawerWithIconState
    extends State<DynamicNavigationDrawerWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.isDrawerHeaderRequired
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.start,
      children: [
        widget.isDrawerHeaderRequired
            ? buildDrawerHeader(context)
            : Container(),
        buildDrawerMenuWithIcon(context)
      ],
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
                            widget.initialSelectionIndex = index;
                            widget.onTap(
                                widget.tileListWithIcon.keys.elementAt(index),
                                widget.initialSelectionIndex);
                            Navigator.of(context).pop();
                          });
                        },
                        child: Container(
                          color: widget.initialSelectionIndex == index
                              ? Colors.red
                              : widget.menuNotSelectedColor,
                          height: widget.drawerMenuHeight,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  widget.tileListWithIcon.values
                                      .elementAt(index),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    widget.tileListWithIcon.keys
                                        .elementAt(index),
                                    style: TextStyle(
                                        color: widget.menuFontColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: widget.menuFontSize ?? 10.0),
                                  ),
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
