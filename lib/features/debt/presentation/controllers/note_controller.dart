import 'package:ccount/core/function/date_time.dart';
import 'package:ccount/features/debt/data/models/note_model.dart';
import 'package:ccount/features/debt/data/models/sequance_model.dart';
import 'package:ccount/features/debt/data/repositories/note_repostry.dart';
import 'package:ccount/features/debt/data/repositories/sequance_repo.dart';
import 'package:ccount/features/debt/presentation/client/view/note_client_edit.dart';
import 'package:ccount/features/debt/presentation/client/view/notes_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class NoteController extends GetxController {
// controller init stert

  TextEditingController dateController = TextEditingController();

  TextEditingController timeController = TextEditingController();
  TextEditingController noteBodyController = TextEditingController();

// controller init end

  // variavbles start
  String? noteTime;
  String? noteDate;
  bool state = false;
  SequanceRepo seqRep = Get.find();
  List<NoteModel> noteList = [];
  List<int> selectedNoteList = <int>[];
  // bool selected = false;
//
  NoteRepostry noteRepo = Get.find();

  NoteModel? noteModel;
  bool updated = false;
  int? id;
  String? nameCustomer;
  int? idCustomer;
  int? sequancNote;
  // variavbles end

// all meathode start

  get selected => selectedNoteList.isNotEmpty;
  get checkAll => selectedNoteList.length == noteList.length;
  getSequancNote() async {
    var sequanc = await seqRep.getSequanceByName("note");

    if (sequanc!.sequanceName == null) {
      seqRep.addSequance(SequanceModel(
        sequanceName: "note",
        sequanceNumber: 0,
      ));
      sequancNote = 0;
    } else {
      sequancNote = sequanc.sequanceNumber!;
    }
  }

  addToSelectedList(int index) {
    selectedNoteList.add(index);
    update();
  }

  removeFromSelectedList(int index) {
    selectedNoteList.remove(index);
    update();
  }

  addAllToSelectedList() {
    for (int i = 0; i < noteList.length; i++) {
      selectedNoteList.add(i);
    }
    update();
  }

  removeAllFromSelectedList() {
    selectedNoteList = [];
    update();
  }

  removeSelectedNote() async {
    for (int i in selectedNoteList) {
      await noteRepo.deleteNote(noteList[i].id!);

      noteList.removeAt(i);
    }
    selectedNoteList = [];
    update();
  }

//  dateTime start

  getDaterCelunder(
    BuildContext context,
  ) async {
    Map<String, dynamic> mapDate = await getDataTimerCelunderFun(
        context, OmniDateTimePickerType.date, parseDate(noteDate!));

    noteDate = mapDate["date"];
    dateController.text = noteDate!;

    update();
  }

  getAllNoteByIdCustomer() async {
    final notes = await noteRepo.getNoteByIdCustomer(idCustomer!);

    noteList.addAll(notes);

    state = true;
    update();
  }

  getTimeCelunder(
    BuildContext context,
  ) async {
    Map<String, dynamic> mapDate = await getDataTimerCelunderFun(
        context, OmniDateTimePickerType.dateAndTime, null);

    noteTime = mapDate["time"];
    timeController.text = noteTime!;

    update();
  }
//  dateTime end

  editNote(NoteModel note) {
    print("===================================");
    print("==============${note.id}=====================");
    print("===================================");
    clearController();
    timeController.text = note.time!;
    dateController.text = note.date!;
    noteBodyController.text = note.body!;
    goToNoteAdd();
    idCustomer = note.customerID;
    id = note.id;
    updated = true;
    update();
  }

  updateNote() async {
    noteModel = NoteModel(
        id: id,
        body: noteBodyController.text,
        customerID: idCustomer,
        date: dateController.text,
        time: timeController.text);

    await noteRepo.updateNote(noteModel!);
    int a = 0;
    int b = 0;
    for (NoteModel not in noteList) {
      a = a + 1;

      if (not.id == id) {
        b = a;
        break;
      }
    }

    noteList[b - 1] = noteModel!;
    update();
    clearController();
    Get.back();
    // Get.off(NotesPage(), transition: Transition.rightToLeft);
  }

  goToNoteAdd() {
    updated = false;
    update();
    Get.to(NoteClientEditScreen(),
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 300));
  }

  // backToNotePage() {
  //   updated = false;
  //   update();
  //   Get.off(NotesPage(),
  //       transition: Transition.rightToLeft,
  //       duration: Duration(milliseconds: 300));
  // }

  addNewNote() async {
    if (noteBodyController.text.toString().trim().isEmpty) {
      // Get.showSnackbar(GetSnackBar(
      //   title: "errore",
      // ));
    } else {
      print("=============sequancNote================");
      print("===========$sequancNote==================");
      print("=============================");
      noteModel = NoteModel(
          id: sequancNote,
          body: noteBodyController.text.toString().trim(),
          customerID: idCustomer,
          date: noteDate,
          time: noteTime);
      await seqRep.incrementSequance("note");
      await noteRepo.addNote(noteModel!);
      // final s = await noteRepo.getAllNote();
      sequancNote = sequancNote! + 1;
      noteList.add(noteModel!);
      update();
      // Get.showSnackbar(GetSnackBar(
      //   title: "secssfule",
      // ));

      clearController();
      // Get.off(NoteClientScreen());

      Get.off(NotesPage(), transition: Transition.rightToLeft);
    }
  }

  clearController() {
    noteBodyController.clear();
    timeController.clear();
    dateController.clear();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  //   timeController.dispose();
  //   noteBodyController.dispose();
  //   dateController.dispose();
  // }

  @override
  void onInit() async {
    super.onInit();
    noteDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    noteTime = DateFormat('hh:mm a').format(DateTime.now());
    final idAndNameCustomer = Get.arguments;
    idCustomer = idAndNameCustomer["id"];
    nameCustomer = idAndNameCustomer["name"];

    dateController.text = "$noteDate ";
    timeController.text = "$noteTime ";
    getSequancNote();
    await getAllNoteByIdCustomer();
  }
// all meathode end
}

