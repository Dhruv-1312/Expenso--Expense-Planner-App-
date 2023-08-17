import 'package:expenso/Providers/user_provider.dart';
import 'package:expenso/utils/golabalvar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
    addData();
  }

  addData() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshUser();
  }

  int _page = 0;
  late PageController pageController;

  navigationtapped(int page) {
    pageController.jumpToPage(page);
  }

  void pagechange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: pagechange,
        children: screenitems,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home,
              color: (_page == 0) ? Colors.black : Colors.grey,
            ),
            label: '',
          ),
          NavigationDestination(
              icon: Icon(
                Icons.analytics,
                color: (_page == 1) ? Colors.black : Colors.grey,
              ),
              label: ''),
          NavigationDestination(
              icon: Icon(
                Icons.add_box_rounded,
                color: (_page == 2) ? Colors.black : Colors.grey,
              ),
              label: ''),
          NavigationDestination(
              icon: Icon(
                Icons.person,
                color: (_page == 3) ? Colors.black : Colors.grey,
              ),
              label: ''),
        ],
        onDestinationSelected: navigationtapped,
        selectedIndex: _page,
      ),
    );
  }
}
