import 'BottomBar/AudioInput.dart';
import 'BottomBar/Chat/TextInput.dart';
import 'BottomBar/OCRInput.dart';
import 'package:flutter/material.dart';
import 'package:jal_anveshak/Screens/Drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserPage extends StatefulWidget {
  const UserPage(
      {Key? key, required this.token, required this.name, required this.userId})
      : super(key: key);
  final String token, name, userId;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int currentIndex = 1;
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = const [
    OCRInput(),
    TextInput(),
    AudioInput(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          
          },
          backgroundColor: Colors.cyan[500],
          child: const FaIcon(FontAwesomeIcons.robot),
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: Image.asset(
                'assets/images/new_profile.png',
                height: height * (42 / 804),
                width: width * (42 / 340),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black,
              selectedFontSize: 18,
              unselectedFontSize: 14,
              iconSize: 27,
              showUnselectedLabels: false,
              currentIndex: currentIndex,
              onTap: (index) => setState(() {
                currentIndex = index;
              }),
              items: [
                BottomNavigationBarItem(
                  icon: const FaIcon(
                    Icons.account_balance,
                    color: Colors.black,
                  ),
                  label: AppLocalizations.of(context)!.forum,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                  ),
                  label: AppLocalizations.of(context)!.home,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.auto_graph_outlined,
                    color: Colors.black,
                  ),
                  label: AppLocalizations.of(context)!.news,
                ),
              ],
            ),
          ),
        ),
        drawer: const NavigationDrawer1(),
      ),
    );
  }
}
