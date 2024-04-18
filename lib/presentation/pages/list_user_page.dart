import 'package:flutter/material.dart';
import 'package:pantest/lib.dart';

class ListUserPage extends StatefulWidget {
  const ListUserPage({super.key});

  static const routeName = "/listUserPage";

  @override
  State<ListUserPage> createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injection<ListUserBloc>()
            ..add(
              OnInitListUserEvent(),
            ),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Contributor',
                style: GoogleFonts.roboto(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ),
          body: BlocBuilder<ListUserBloc, ListUserState>(
            builder: (context, stateListUser) {
              return NotificationListener(
                onNotification: (value) {
                  if (value is ScrollEndNotification) {
                    if ((controller.position.pixels ==
                            controller.position.maxScrollExtent) &&
                        (stateListUser.requestState != RequestState.loading)) {
                      BlocProvider.of<ListUserBloc>(context)
                          .add(OnNextPageListUserEvent(context: context));
                    }
                  }
                  return true;
                },
                child: Stack(
                  children: [
                    ListView.builder(
                      controller: controller,
                      itemCount: stateListUser.listDataUser?.length ?? 0,
                      itemBuilder: (context, index) {
                        DataUser? data = stateListUser.listDataUser?[index];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: 24.w,
                                left: 24.w,
                                top: index == 0 ? 8.h : 0,
                                bottom: 16.h,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, ProfilePage.routeName,
                                      arguments: ProfilePageArguments(
                                        idUser: data!.id!,
                                      ));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 24.h, horizontal: 16.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.r),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey.withOpacity(0.5),
                                      )),
                                  child: Row(
                                    children: [
                                      ClipOval(
                                        child: Image.network(
                                          data?.picture ?? '',
                                          width: 30,
                                          height: 30,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      Text(
                                        [
                                          data?.title,
                                          data?.firstName,
                                          data?.lastName,
                                        ].join(' '),
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (data?.id == stateListUser.listDataUser?.last.id)
                              ListView.builder(
                                  itemCount: 3,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        right: 24.w,
                                        left: 24.w,
                                        top: index == 0 ? 8.h : 0,
                                        bottom: 16.h,
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        child: SizedBox(
                                          height: 70.h,
                                          child: const LoadingShimmer(),
                                        ),
                                      ),
                                    );
                                  }),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
