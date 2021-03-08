import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

final TextStyle menuFontStyle = TextStyle(color: Colors.white, fontSize: 20);
final Color menuBackgroundColor = Color(0xFF343442);

class MenuDashboard extends StatefulWidget {
  @override
  _MenuDashboardState createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard>
    with SingleTickerProviderStateMixin {
  double screenHeight, screenWidth;
  bool isMenuOpen = false;
  AnimationController _animationController;
  Animation<double> _scaleAnimation;
  Animation<double> _scaleMenuAnimation;
  Animation<Offset> _menuOffsetAnimation;
  final Duration _duration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _duration);
    _scaleAnimation = Tween(begin: 1.0, end: 0.6).animate(_animationController);
    _scaleMenuAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _menuOffsetAnimation = Tween(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: menuBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            generateMenu(context),
            generateDashboard(context),
          ],
        ),
      ),
    );
  }

  Widget generateMenu(BuildContext context) {
    return SlideTransition(
      position: _menuOffsetAnimation,
      child: ScaleTransition(
        scale: _scaleMenuAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Dashboard", style: menuFontStyle),
                SizedBox(height: 25),
                Text("Messages", style: menuFontStyle),
                SizedBox(height: 25),
                Text("Utility Bills", style: menuFontStyle),
                SizedBox(height: 25),
                Text("Fund Transfer", style: menuFontStyle),
                SizedBox(height: 25),
                Text("Branches", style: menuFontStyle),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget generateDashboard(BuildContext context) {
    return AnimatedPositioned(
      top: 0,
      bottom: 0,
      left: isMenuOpen ? screenWidth * 0.4 : 0,
      right: isMenuOpen ? screenWidth * -0.4 : 0,
      duration: _duration,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius:
              isMenuOpen ? BorderRadius.all(Radius.circular(10)) : null,
          elevation: 8,
          color: menuBackgroundColor,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (isMenuOpen) {
                              _animationController.reverse();
                            } else {
                              _animationController.forward();
                            }
                            isMenuOpen = !isMenuOpen;
                          });
                        },
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "My Cards",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 200,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          color: Colors.pink,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.blue,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.green,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Student $index"),
                        trailing: Icon(Icons.add),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
