import 'package:ccount/controller/client-controller.dart';
import 'package:ccount/controller/note-controller.dart';
import 'package:ccount/core/constant/app-color.dart';
import 'package:ccount/core/constant/app-size.dart';
import 'package:ccount/core/shared/data-file.dart';
import 'package:ccount/core/shared/floating-botton.dart';
import 'package:ccount/core/shared/row-filde-icon.dart';
import 'package:ccount/core/theme/themeMode/Text-style.dart';
import 'package:ccount/test/table-tast.dart';
import 'package:ccount/view/debt/client/view/notes-page.dart';
import 'package:ccount/view/home/view/home.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'package:iconsax/iconsax.dart';

class NoteClientEditScreen extends StatelessWidget {
  const NoteClientEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NoteController control = Get.find<NoteController>();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      appBar: AppBar(
        automaticallyImplyLeading: F,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                control.clearController();
                // control.backToNotePage();
                Get.back();

                // Get.off(()=>NotesPage());
              },
              icon: Icon(Iconsax.arrow_left_2))
        ],
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.user,
              size: 17.sp,
            ),
            SizedBox(
              width: 5.w,
            ),
            Column(
              children: [
                Text(
                  control.updated ? "63".tr : "62".tr,
                  textAlign: TextAlign.center,
                ),
                Text("${control.nameCustomer}",
                    style: TextStyleTheme.captionNormal),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: FloatingButton(
            label: control.updated ? "15".tr : "29".tr,
            onTap: () {
              control.updated ? control.updateNote() : control.addNewNote();
            }),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: 70,
            // color: ,
            child: SizedBox(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150.w,
                              child: GetBuilder<NoteController>(
                                builder: (_controller) => GestureDetector(
                                  onTap: () {
                                    _controller.getDaterCelunder(context);
                                  },
                                  child: AbsorbPointer(
                                    child: DataField(
                                      prefixIcon: Icon(
                                        Iconsax.calendar_edit,
                                        color: AppColor.IconButton,
                                        size: 25,
                                      ),
                                      controller: _controller.dateController,
                                      hintText: "${_controller.noteDate}",
                                      // initialValue: "${controller.clientDate}"
                                      //     "${controller.clientTime}",
                                      // readOnly: true,

                                      keyboardType: TextInputType.datetime,
                                      // controller: TextEditingController(),
                                      validator: (value) {
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 25.w,
                            ),
                            SizedBox(
                              width: 150.w,
                              child: GetBuilder<NoteController>(
                                builder: (_controller) => GestureDetector(
                                  onTap: () {
                                    _controller.getTimeCelunder(context);
                                  },
                                  child: AbsorbPointer(
                                    child: DataField(
                                      prefixIcon: Icon(
                                        Iconsax.clock,
                                        color: AppColor.IconButton,
                                        size: 25,
                                      ),
                                      controller: _controller.timeController,

                                      hintText: "${_controller.noteTime}",
                                      readOnly: true,

                                      keyboardType: TextInputType.datetime,
                                      // controller: TextEditingController(),
                                      validator: (value) {
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<NoteController>(
              builder: (_controller) => TextFormField(
                controller: _controller.noteBodyController,
                maxLines: 1000,
                autofocus: T,
                decoration: InputDecoration(
                    hintText: "64".tr,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none),
              ),
            ),
          )
        ],
      ),
    );
  }
}
