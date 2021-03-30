import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';

// CURRENTLY UNUSED

class PostsMenuArgs {}

class PostsMenu extends StatefulWidget {
  @override
  _PostsMenuState createState() => _PostsMenuState();
}

class _PostsMenuState extends State<PostsMenu> {
  _PostsMenuState() : super();
  List<bool> _PostsCheckbox = List.generate(8, (index) {
    return false;
  });
  List<String> _PostDropDown = List.generate(8, (index) {
    return "$index пост";
  });

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;

    final AppBar appBar = AppBar(
      title: Text("Посты"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      // drawer: prepareDrawer(context, Pages.Posts,sessionData),
      drawer: prepareDrawer(context, Pages.Main, sessionData), //tmp
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new SizedBox(
            height: screenH - appBar.preferredSize.height,
            width: screenW,
            child: ListView(
              children: List.generate(8, (index) {
                return new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 75,
                      width: screenW / 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: DropdownButton(
                          value: _PostDropDown[index],
                          onChanged: (newValue) {
                            setState(() {
                              _PostDropDown[index] = newValue;
                            });
                          },
                          items: [
                            DropdownMenuItem(
                              value: "$index пост",
                              child: Text("$index пост"),
                            ),
                            DropdownMenuItem(
                              value: "--------",
                              child: Text("--------"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                      width: screenW / 3,
                      child: Row(
                        children: [
                          SizedBox(
                            width: screenW / 6,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text("Прокачка"),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                            width: screenW / 6,
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 75,
                      width: screenW / 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.trailing,
                          title: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              'Активный',
                            ),
                          ),
                          value: _PostsCheckbox[index],
                          onChanged: (newValue) {
                            setState(() {
                              _PostsCheckbox[index] = !_PostsCheckbox[index];
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
