import 'package:ccount/features/debt/presentation/controllers/note_controller.dart';
import 'package:ccount/core/constant/app_color.dart';
import 'package:ccount/core/shared/container_icon.dart';
import 'package:ccount/core/shared/floating_botton.dart';
import 'package:ccount/core/theme/theme_mode/text_style.dart';
import 'package:ccount/features/debt/presentation/client/view/note_client_edit.dart';
import 'package:ccount/features/debt/presentation/client/view/page_client_transaction.dart';
import 'package:ccount/features/debt/presentation/client/widget/card_note_widget.dart';
import 'package:ccount/features/debt/presentation/client/widget/columen_icon_widget.dart';
import 'package:ccount/features/home/presentation/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:iconsax/iconsax.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    NoteController control = Get.put(NoteController());
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 40.h, right: 10.w, left: 10.w),
          child: FloatingButton(
              icon: Icons.add,
              label: "54".tr,
              onTap: () {
                control.goToNoteAdd();
              }),
        ),
        appBar: AppBar(
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          title: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
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
                      Text("55".tr),
                      // Text(
                      //   control.updated ? "63".tr : "62".tr,
                      //   textAlign: TextAlign.center,
                      // ),
                      Text("${control.nameCustomer}",
                          style: TextStyleTheme.captionNormal),
                    ],
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.off(PageClientTransaction(),
                      transition: Transition.rightToLeft,
                      arguments: control.idCustomer);
                },
                icon: Icon(Iconsax.arrow_left_2))
          ],
        ),
        body: GetBuilder<NoteController>(
          builder: (_controller) => _controller.noteList.isEmpty
              ? Center(
                  child: Text("56".tr),
                )
              : Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Visibility(
                        visible: _controller.selected,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (_controller.selectedNoteList.length ==
                                        _controller.noteList.length) {
                                      _controller.removeAllFromSelectedList();
                                    } else {
                                      _controller.addAllToSelectedList();
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: ContainerIcon(
                                          colorBackground: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: 1.w,
                                              height: 20.h,
                                              child: Checkbox(
                                                value: _controller.checkAll,
                                                onChanged: (value) {
                                                  if (value!) {
                                                    _controller
                                                        .removeAllFromSelectedList();
                                                  } else {
                                                    _controller
                                                        .addAllToSelectedList();
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text("الكل",
                                          style: TextStyleTheme.caption)
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {},
                                  child: buildIconColumn(
                                      Iconsax.bill,
                                      "42".tr,
                                      AppColor.IconButton,
                                      AppColor.backgroundIcon),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await _controller.removeSelectedNote();
                                  },
                                  child: buildIconColumn(
                                      Iconsax.trash,
                                      "حذف",
                                      AppColor.IconButton,
                                      AppColor.backgroundIcon),
                                ),
                                GestureDetector(
                                  onTap: () async {},
                                  child: buildIconColumn(
                                      Iconsax.arrow_swap_horizontal,
                                      "67".tr,
                                      AppColor.IconButton,
                                      AppColor.backgroundIcon),
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: buildIconColumn(
                                        Iconsax.message,
                                        "40".tr,
                                        AppColor.IconButton,
                                        AppColor.backgroundIcon)),
                              ]),
                        ),
                      ),
                      Expanded(
                        child: GetBuilder<NoteController>(
                          builder: (_controllere) => ListView.builder(
                            itemCount: _controllere.noteList.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onLongPress: () {
                                if (!_controllere.selected) {
                                  _controllere.addToSelectedList(index);
                                }
                              },
                              onTap: () {
                                if (_controllere.selected) {
                                  _controllere.selectedNoteList.contains(index)
                                      ? _controllere
                                          .removeFromSelectedList(index)
                                      : _controllere.addToSelectedList(index);
                                } else {
                                  _controllere
                                      .editNote(_controllere.noteList[index]);
                                }
                              },
                              child: Row(
                                children: [
                                  Visibility(
                                      visible: _controllere.selected,
                                      child: Checkbox(
                                        value: _controllere.selectedNoteList
                                            .contains(index),
                                        onChanged: (value) {
                                          if (value!) {
                                            _controllere
                                                .addToSelectedList(index);
                                          } else {
                                            _controllere
                                                .removeFromSelectedList(index);
                                          }
                                        },
                                      )),
                                  Expanded(
                                    child: CardeNoteWidget(
                                        body: _controllere.noteList[index].body,
                                        date: _controllere.noteList[index].date,
                                        time:
                                            _controllere.noteList[index].time),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}

