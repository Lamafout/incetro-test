import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incetro_test/di/di.dart';
import 'package:incetro_test/res/pages/favorites_page.dart';
import 'package:incetro_test/res/pages/main_page.dart';
import 'package:incetro_test/res/pages/profile_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  setupDi();
  runApp(MyCyprus());
}

class MyCyprus extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
    ? const CupertinoApp(
      theme: CupertinoThemeData(
          primaryContrastingColor: Color(0xFF32ade6),
          textTheme: CupertinoTextThemeData(
            navLargeTitleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
            navTitleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
            textStyle: TextStyle(color: Colors.black54, fontSize: 16),
          ),
          scaffoldBackgroundColor: Color(0xFFf2f2f7),
        ),
        title: 'MyCyprus',
      home: HomePage(),
    )
    : MaterialApp(
      theme: ThemeData(
          iconTheme: const IconThemeData(color:Color(0xFF32ade6)),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18, fontFamily: 'Roboto'),
            titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,  fontSize: 18, fontFamily: 'Roboto'),
            titleMedium: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1, fontFamily: 'Roboto-Thin'),
          ),
          scaffoldBackgroundColor: const Color(0xFFf2f2f7),
      ),
      title: 'MyCyprus',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 1;
  _onTap(index){
    //TODO с помощью блок листенера сделать проверку на стейт 
    setState(() {
      _selectedPage = index;
    });
  }
  final _pages = const [FavoritesPage(), MainPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
    ? CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.heart_fill,
              ),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.house_alt_fill,
              ),
              label: 'Main',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.person_fill,
              ),
              label: 'Person',
            ),
          ]
        ), 
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return const CupertinoPageScaffold(child: FavoritesPage());
            case 1:
              return const CupertinoPageScaffold(child: MainPage());
            case 2:
              return const CupertinoPageScaffold(child: ProfilePage());
            default:
              return const CupertinoPageScaffold(child: MainPage());
          }
        },
      )
    : Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              SizedBox(
                height: 30,
                width: 30,
                child: Stack(
                  children: [
                    Center(
                      child:
                        Icon(
                          CupertinoIcons.heart,
                          color: Theme.of(context).iconTheme.color,
                          size: 32,
                        ),
                    ),
                      Center(
                        child: Text(
                          '17',
                          style: TextStyle(
                            color: Theme.of(context).iconTheme.color,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ),
                  ],
                ),
              )
            ],
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Restaraunts'),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: _pages[_selectedPage],
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: _onTap,
        items: const [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.heart_fill,
              ),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.house_alt_fill,
              ),
              label: 'Main',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.person_fill,
              ),
              label: 'Person',
            ),
          ],

      ),
    );
  }
}