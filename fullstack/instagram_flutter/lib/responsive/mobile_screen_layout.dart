import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

enum Page { home, search, add, notifications, profile }

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  late final PageController _pageController;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Page _current = Page.home;
    return SafeArea(
      child: Scaffold(
        body: const Center(child: Text('mobile')),
        bottomNavigationBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _current == Page.home ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  color:
                      _current == Page.search ? primaryColor : secondaryColor),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle,
                  color: _current == Page.add ? primaryColor : secondaryColor),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: _current == Page.notifications
                    ? primaryColor
                    : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _current == Page.profile ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor,
            )
          ],
          onTap: null,
        ),
      ),
    );
  }
}
