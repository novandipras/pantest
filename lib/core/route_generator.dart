import 'package:flutter/material.dart';

import 'package:pantest/lib.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    final args = settings.arguments;
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case ListUserPage.routeName:
        return MaterialPageRoute(builder: (_) => const ListUserPage());
      case ListLikeDataSavedPage.routeName:
        return MaterialPageRoute(builder: (_) => const ListLikeDataSavedPage());
      case ExplorePage.routeName:
        return MaterialPageRoute(builder: (_) => const ExplorePage());
      case TagExplorePage.routeName:
        if (args is TagExplorePageArguments) {
          return MaterialPageRoute(
            builder: (_) => TagExplorePage(
              args: args,
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => const UnderConstructionPage());
      case ProfilePage.routeName:
        if (args is ProfilePageArguments) {
          return MaterialPageRoute(
            builder: (_) => ProfilePage(
              args: args,
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => const UnderConstructionPage());
      case UnderConstructionPage.routeName:
        return MaterialPageRoute(builder: (_) => const UnderConstructionPage());
      default:
        return MaterialPageRoute(builder: (context) {
          ScreenUtil.init(context,
              designSize: Size(
                MediaQuery.sizeOf(context).width,
                MediaQuery.sizeOf(context).height,
              ));
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Segera Hadir",
                        style: GoogleFonts.roboto(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Tunggu, Ya.... Kami Sedang Menyiapkan Fitur Yang Istimewa Untuk Kamu",
                        style: GoogleFonts.roboto(
                            fontSize: 16.sp, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
    }
  }
}
