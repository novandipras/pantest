import 'package:flutter/material.dart';

import 'package:pantest/lib.dart';

class ListLikeDataSavedPage extends StatefulWidget {
  const ListLikeDataSavedPage({super.key});

  static const routeName = '/listLikeDataSavedPage';

  @override
  State<ListLikeDataSavedPage> createState() => _ListLikeDataSavedPageState();
}

class _ListLikeDataSavedPageState extends State<ListLikeDataSavedPage> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injection<LikesPostBloc>()
        ..add(
          OnInitLikesPostEvent(),
        ),
      child: Builder(builder: (context) {
        return BlocBuilder<LikesPostBloc, LikesPostState>(
          builder: (context, stateLikesPost) {
            if (stateLikesPost.listData == null ||
                stateLikesPost.listData!.isNotEmpty) {
              return const Center(
                child: Text(
                  'List Empty',
                ),
              );
            } else {
              return ListView.builder(
                controller: controller,
                itemCount: stateLikesPost.listData?.length ?? 0,
                itemBuilder: (context, index) {
                  DataSavedPostModel? data = stateLikesPost.listData?[index];
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
                                  ) ??
                                  '',
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
                                  LikeIcon(
                                    counter: data.likes,
                                    id: data.id,
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(
                                      Icons.insert_comment_outlined,
                                      color: Colors.grey,
                                    ),
                                  ),
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
                      ],
                    ),
                  );
                },
              );
            }
          },
        );
      }),
    );
  }
}
