import 'package:flutter/material.dart';
import 'package:pantest/lib.dart';

class TagChips extends StatelessWidget {
  const TagChips({super.key,required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, TagExplorePage.routeName,arguments: TagExplorePageArguments(tag: tag));
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            100.r,
          ),
        ),
      ),
      child: Text(tag,
          style: GoogleFonts.roboto(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )),
    );
  }
}
