import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pantest/lib.dart';

class LikeIcon extends StatelessWidget {
  const LikeIcon({
    super.key,
    this.counter,
    this.id,
  });

  final int? counter;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {},
            child: false
                ? const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.grey,
                  )
                : const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(
            counter.toString() ?? '',
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 16.sp,
            ),
          )
        ],
      ),
    );
  }
}
