import 'package:flutter/material.dart';

import 'package:pantest/lib.dart';

class TagExplorePageArguments {
  const TagExplorePageArguments({this.tag});

  final String? tag;
}

class TagExplorePage extends StatefulWidget {
  const TagExplorePage({
    super.key,
    this.args,
  });

  final TagExplorePageArguments? args;

  static const routeName = '/tagExplorePage';

  @override
  State<TagExplorePage> createState() => _TagExplorePageState();
}

class _TagExplorePageState extends State<TagExplorePage> {
  late ScrollController controller;
  ValueNotifier<bool> isExpandVN = ValueNotifier(false);


  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injection<ExploreBloc>()
        ..add(
          OnInitPostingOnTagExploreEvent(tag: widget.args!.tag!),
        ),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              '"${widget.args!.tag!}"',
              style: GoogleFonts.roboto(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: BlocBuilder<ExploreBloc, ExploreState>(
            builder: (context, stateExplore) {
              return NotificationListener(
                onNotification: (value) {
                  if (value is ScrollEndNotification) {
                    if ((controller.position.pixels ==
                            controller.position.maxScrollExtent) &&
                        (stateExplore.requestState != RequestState.loading)) {
                      BlocProvider.of<ExploreBloc>(context)
                          .add(OnNextPagePostingOnTagExploreEvent(
                        context: context,
                        tag: widget.args!.tag!,
                      ));
                    }
                  }
                  return true;
                },
                child: ListView.builder(
                  controller: controller,
                  itemCount: stateExplore.listData?.length ?? 0,
                  itemBuilder: (context, index) {
                    DataExplore? data = stateExplore.listData?[index];
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
                          if (data.id == stateExplore.listData?.last.id)
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
        );
      }),
    );
  }
}
