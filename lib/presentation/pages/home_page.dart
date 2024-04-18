import 'package:flutter/material.dart';

import 'package:pantest/lib.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/homePage";

  const HomePage({
    super.key,
    this.initPage,
  });

  final int? initPage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(
      initialPage: widget.initPage ?? 0,
    );
    super.initState();
  }

  List<Map<String, dynamic>> listScreen({
    required HomeNavbarBloc homeNavbarBloc,
  }) =>
      [
        {
          'screen': const ListUserPage(),
          'nav_item': {
            'title': 'User',
            'image': Icons.people,
            'onTap': () {
              homeNavbarBloc.add(const ChangeHomeScreen(page: 0));
            }
          }
        },
        {
          'screen': const ListLikeDataSavedPage(),
          'nav_item': {
            'title': 'Likes',
            'image': Icons.favorite,
            'onTap': () {
              homeNavbarBloc.add(const ChangeHomeScreen(page: 1));
            }
          }
        },
        {
          'screen': const ExplorePage(),
          'nav_item': {
            'title': 'Explore',
            'image': Icons.explore,
            'onTap': () {
              homeNavbarBloc.add(const ChangeHomeScreen(page: 2));
            }
          }
        },
      ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(
          MediaQuery.sizeOf(context).width,
          MediaQuery.sizeOf(context).height,
        ));
    return PopScope(
      canPop: false,
      child: BlocProvider(
        create: (context) => injection<HomeNavbarBloc>(),
        child: Builder(builder: (context) {
          List<Map<String, dynamic>> listScreenItem = listScreen(
            homeNavbarBloc: BlocProvider.of<HomeNavbarBloc>(context),
          );
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                HomeScreen(
                  pageController: pageController,
                  listScreen: listScreenItem,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 1,
                          spreadRadius: 0.0,
                          offset: const Offset(
                            -0.0,
                            -2.0,
                          ), // shadow direction: bottom right
                        )
                      ],
                    ),
                    child: HomeBottomNavigationBar(
                      listScreen: listScreenItem,
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.pageController,
    required this.listScreen,
  });

  final PageController pageController;
  final List<Map<String, dynamic>> listScreen;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeNavbarBloc, int>(
      listener: (context, state) {
        pageController.jumpToPage(state);
      },
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        pageSnapping: false,
        controller: pageController,
        children: listScreen
            .map((e) => KeepAliveWidget(child: e['screen'] as Widget))
            .toList(),
      ),
    );
  }
}

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({
    super.key,
    required this.listScreen,
  });

  final List<Map<String, dynamic>> listScreen;

  @override
  Widget build(BuildContext context) {
    double tinggiNavBar = ScreenUtil().screenHeight * 0.1;
    return SizedBox(
      height: tinggiNavBar,
      child: Stack(
        children: [
          Container(
            height: tinggiNavBar,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.blue),
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(listScreen.length, (index) {
                Map<String, dynamic> e = listScreen[index];
                return BlocBuilder<HomeNavbarBloc, int>(
                  builder: (context, stateEssNavbar) {
                    return Material(
                      color: Colors.transparent,
                      shape: const CircleBorder(),
                      child: InkWell(
                        splashColor: Colors.white38,
                        customBorder: const CircleBorder(),
                        onTap: e['nav_item']['onTap'],
                        child: Container(
                            height: tinggiNavBar,
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Icon(
                                    e['nav_item']['image'],
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  e['nav_item']['title'],
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Icon(
                                  Icons.circle,
                                  color: index == stateEssNavbar
                                      ? Colors.white
                                      : Colors.transparent,
                                  size: 8,
                                )
                              ],
                            )),
                      ),
                    );
                  },
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
