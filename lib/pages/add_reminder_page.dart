import 'package:care_on/components/bottom_sheet_data.dart';
import 'package:care_on/components/description_data.dart';
import 'package:care_on/components/textfield.dart';
import 'package:care_on/models/reminder_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddReminderPage extends StatefulWidget {
  Reminder? existedReminder;
  AddReminderPage({super.key});
  AddReminderPage.existed(Reminder reminder, {super.key}) {
    existedReminder = reminder;
  }

  @override
  State<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  String time = "";
  String textSelectedDays = "Chọn ngày";
  String description = "Nhập nhãn";
  bool needAlarm = false;
  bool isSwitched = false;
  bool repeatSwitched = false;
  bool onRepeat = false;
  List<String> daysOfWeekFull = [
    "Thứ 2",
    "Thứ 3",
    "Thứ 4",
    "Thứ 5",
    "Thứ 6",
    "Thứ 7",
    "Chủ nhật"
  ];
  List<String> daysOfWeek = [
    "Th 2",
    "Th 3",
    "Th 4",
    "Th 5",
    "Th 6",
    "Th 7",
    "CN"
  ];
  List<bool> selectedDays = List.filled(7, false);

  void _showBottomSheet(BuildContext context) {
    BottomSheetData bottomSheetData = BottomSheetData(
      updateTextSelectedDays: (String newText) {
        setState(() {
          textSelectedDays = newText;
        });
      },
      updateSelectedDays: (List<bool> newSelectedDays) {
        setState(() {
          selectedDays = newSelectedDays;
        });
      },
    );
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: daysOfWeek.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Text(
                              daysOfWeekFull[index],
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          value: selectedDays[index],
                          onChanged: (bool? value) {
                            setState(() {
                              selectedDays[index] = value!;
                              // Gọi hàm callback để cập nhật trạng thái từ bên ngoài
                              bottomSheetData.updateSelectedDays(selectedDays);
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffD9D9D9),
                              fixedSize: Size(138, 48),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            Navigator.pop(
                                context); // Đóng bottom sheet khi nhấn Cancel
                          },
                          child: Text(
                            'Hủy',
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff3AB5FF),
                              fixedSize: Size(138, 48),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            // Xử lý khi nhấn OK
                            String selectedDaysText = "";
                            for (int i = 0; i < selectedDays.length; i++) {
                              if (selectedDays[i]) {
                                selectedDaysText += daysOfWeek[i] + ", ";
                              }
                            }
                            selectedDaysText = selectedDaysText.isNotEmpty
                                ? selectedDaysText.substring(
                                    0, selectedDaysText.length - 2)
                                : "Chọn ngày";

                            setState(() {
                              bottomSheetData
                                  .updateTextSelectedDays(selectedDaysText);
                            });
                            Navigator.pop(
                                context); // Đóng bottom sheet sau khi chọn xong
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showLabelBottomSheet(BuildContext context) {
    DescriptionData descriptionData = DescriptionData(
      updateDescription: (String newText) {
        setState(() {
          description = newText;
        });
      },
    );

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                height: 230,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Thêm nhãn hoạt động',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    MyTextField(
                        controller: descriptionController,
                        hintText: "Nhập nhãn",
                        obscureText: false,
                        inputType: TextInputType.text),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffD9D9D9),
                              fixedSize: Size(138, 48),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            Navigator.pop(
                                context); // Đóng bottom sheet khi nhấn Cancel
                          },
                          child: Text(
                            'Hủy',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff3AB5FF),
                              fixedSize: Size(138, 48),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            setState(() {
                              descriptionData.updateDescription(
                                  descriptionController.text.isEmpty
                                      ? "Nhập nhãn"
                                      : descriptionController.text);
                            });
                            Navigator.pop(
                                context); // Đóng bottom sheet khi nhấn OK
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedTime = TimeOfDay.now();
    time =
        "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
  }

  void updateReminderToFirestore() {
    if (titleController.value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Vui lòng nhập tên hoạt động nhắc nhở!',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          duration: Duration(seconds: 2), // Thời gian hiển thị SnackBar
        ),
      );
    } else {
      if (textSelectedDays == "Chọn ngày") {
        SnackBar(
          content: Text(
            'Vui lòng chọn ngày hoạt động!',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          duration: Duration(seconds: 2), // Thời gian hiển thị SnackBar
        );
      } else {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        String? reminderId;
        if (widget.existedReminder == null) {
          reminderId = FirebaseFirestore.instance.collection('notes').doc().id;
        } else {
          reminderId = widget.existedReminder!.reminderId;
        }

        Reminder newReminder = Reminder(
            title: titleController.text,
            description: description == "Nhập nhãn" ? "" : description,
            needAlarm: needAlarm,
            onRepeat: onRepeat,
            reminderId: reminderId,
            reminderOn: textSelectedDays,
            timeStart: time,
            userId: userId);

        FirebaseFirestore.instance
            .collection('reminders')
            .doc(reminderId)
            .set(newReminder.toMap())
            .then((value) {
          print("Nhắc nhở đã được cập nhật với ID: $reminderId");
          Navigator.pop(context);
        }).catchError((error) {
          print("Lỗi khi cập nhật nhắc nhở: $error");
        });
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffF4F6FB),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xffF4F6FB),
        title: Text(
          "Nhắc nhở",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: IconThemeData(size: 28, color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        actions: [
          widget.existedReminder == null
              ? SizedBox()
              : IconButton(
                  onPressed: () {
                    // _confirmDeleteBudget(context);
                  },
                  icon: Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                updateReminderToFirestore();
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 25),
            child: TextField(
              maxLines: null,
              controller: titleController,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Tên hoạt động"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 25),
            child: Row(
              children: [
                Text(
                  "Bắt đầu lúc",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    final TimeOfDay? timeOfDay = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                        initialEntryMode: TimePickerEntryMode.dial);
                    if (timeOfDay != null) {
                      setState(() {
                        selectedTime = timeOfDay;
                        time =
                            "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
                      });
                    }
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(
                          time,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff777777)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: SizedBox(
                          height: 17,
                          width: 17,
                          child: Image.asset("lib/images/goto.png"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28, left: 25),
            child: Row(
              children: [
                Text(
                  "Ngày hoạt động",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // show bottom sheet chọn ngày
                    _showBottomSheet(context);
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 155),
                          child: Text(
                            textSelectedDays,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff777777)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: SizedBox(
                          height: 17,
                          width: 17,
                          child: Image.asset("lib/images/goto.png"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 23, left: 25),
            child: Row(
              children: [
                Text(
                  "Lặp lại",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CupertinoSwitch(
                      activeColor: Color(0xff3AB5FF),
                      value: repeatSwitched,
                      onChanged: (bool value) {
                        setState(() {
                          repeatSwitched = value;
                          onRepeat = value;
                        });
                      }),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 23, left: 25),
            child: Row(
              children: [
                Text(
                  "Đặt thông báo",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CupertinoSwitch(
                      activeColor: Color(0xff3AB5FF),
                      value: isSwitched,
                      onChanged: (bool value) {
                        setState(() {
                          isSwitched = value;
                          needAlarm = value;
                        });
                      }),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              _showLabelBottomSheet(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 12, top: 10),
              child: Container(
                width: 367,
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0x7fd9d9d9)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text("Nhãn",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 150),
                        child: Text(
                          description,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff777777)),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
