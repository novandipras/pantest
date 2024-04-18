import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pantest/lib.dart';

class ProfilePageArguments {
  const ProfilePageArguments({required this.idUser});

  final String idUser;
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.args,
  });

  final ProfilePageArguments args;

  static const routeName = "/profilePage";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ScrollController controller;
  ValueNotifier<bool> isExpandVN = ValueNotifier(false);

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
          create: (context) => injection<ProfileBloc>()
            ..add(
              OnGetProfile(
                idUser: widget.args.idUser,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => injection<PostingOnProfileBloc>()
            ..add(
              OnInitPostingOnProfileEvent(
                id: widget.args.idUser,
              ),
            ),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: Colors.white,
                  expandedHeight: ScreenUtil().screenHeight * 0.2,
                  flexibleSpace: FlexibleSpaceBar(
                      background: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, stateProfile) {
                      if (stateProfile.requestState == RequestState.loaded) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: 24.w,
                            left: 24.w,
                            top: 24.h,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ProfilePage.routeName,
                                  arguments: ProfilePageArguments(
                                    idUser:
                                        stateProfile.profileResponseModel!.id!,
                                  ));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 24.h, horizontal: 16.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          [
                                            stateProfile
                                                .profileResponseModel?.title,
                                            stateProfile.profileResponseModel
                                                ?.firstName,
                                            stateProfile
                                                .profileResponseModel?.lastName,
                                          ].join(' '),
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(
                                        stateProfile
                                                .profileResponseModel?.email ??
                                            '',
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        stateProfile
                                                .profileResponseModel?.phone ??
                                            '',
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Flexible(
                                    child: ClipOval(
                                      child: Image.network(
                                        stateProfile.profileResponseModel
                                                ?.picture ??
                                            '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const LoadingShimmer();
                      }
                    },
                  )),
                  floating: true,
                  snap: true,
                  pinned: true,
                ),
              ];
            },
            body: BlocBuilder<PostingOnProfileBloc, PostingOnProfileState>(
              builder: (context, statePostingOnProfile) {
                return NotificationListener(
                  onNotification: (value) {
                    if (value is ScrollEndNotification) {
                      if ((controller.position.pixels ==
                              controller.position.maxScrollExtent) &&
                          (statePostingOnProfile.requestState !=
                              RequestState.loading)) {
                        BlocProvider.of<PostingOnProfileBloc>(context)
                            .add(OnNextPagePostingOnProfileEvent(
                          context: context,
                          id: widget.args.idUser,
                        ));
                      }
                    }
                    return true;
                  },
                  child: ListView.builder(
                    controller: controller,
                    itemCount: statePostingOnProfile.listData?.length ?? 0,
                    itemBuilder: (context, index) {
                      DataPostProfile? data =
                          statePostingOnProfile.listData?[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          top: index == 0 ? 8.h : 0,
                          bottom: 24.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                child: Text(
                                  DateFormat(
                                        'dd MMMM yyyy , K:mm a',
                                        'id_ID',
                                      ).format(
                                        (DateTime.parse(
                                          data!.publishDate!,
                                        )),
                                      ),
                                  style: GoogleFonts.roboto(
                                    color: Colors.black.withOpacity(0.4),
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Image.network(
                              data.image ?? '',
                              fit: BoxFit.fitWidth,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.text ?? '',
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.favorite_border_outlined,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            Text(
                                              data.likes.toString(),
                                              style: GoogleFonts.roboto(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      ValueListenableBuilder(
                                          valueListenable: isExpandVN,
                                          builder: (context, value, child) {
                                            return GestureDetector(
                                              onTap: () {
                                                isExpandVN.value = !value;
                                              },
                                              child: const SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: Icon(
                                                  Icons.insert_comment_outlined,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().screenWidth,
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      spacing: 4,
                                      runSpacing: 4,
                                      children: data.tags!.map((i) {
                                        return TagChips(
                                          tag: i,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  ValueListenableBuilder(
                                      valueListenable: isExpandVN,
                                      builder: (context, value, child) {
                                        return Visibility(
                                          visible: value,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 24),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('Comments',
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.black,
                                                      fontSize: 16.sp,
                                                    )),
                                                TextFormField(),
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            if (data.id ==
                                statePostingOnProfile.listData?.last.id)
                              ListView.builder(
                                  itemCount: 3,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        top: index == 0 ? 8.h : 0,
                                        bottom: 16.h,
                                      ),
                                      child: SizedBox(
                                        height: 100.h,
                                        child: const LoadingShimmer(),
                                      ),
                                    );
                                  }),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
