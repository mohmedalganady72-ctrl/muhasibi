import 'package:ccount/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CardeNoteWidget extends StatelessWidget {
  String? body;
  String? date;
  String? time;
  CardeNoteWidget({super.key, this.body, this.date, this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: AppColor.borderCard)),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "${body!.length > 20 ? "  ${body.toString().substring(0, 20)}....." : body!}",
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Iconsax.calendar_edit,
                    color: Color.fromARGB(209, 114, 168, 204),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "${date}",
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(209, 114, 168, 204)),
                  )
                ],
              ),
              SizedBox(width: 15.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Iconsax.clock,
                    color: Color.fromARGB(209, 114, 168, 204),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "${time}",
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(209, 114, 168, 204)),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
