import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:session_mate/service/therapy_plan_service.dart';
import 'package:session_mate/utils/app_constant.dart';
import 'package:session_mate/utils/app_snackbar.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/view/bottomBar/bottom_bar_screen.dart';
import 'package:session_mate/viewModel/assessment_plan_view_model.dart';
import 'package:share_plus/share_plus.dart';

class TherapyPlanViewModel extends GetxController {
  late List<Map<String, dynamic>> tableData;
  Rx<TextEditingController> childNameController = TextEditingController().obs;
  String childNameText = "";
  Rx<TextEditingController> ageNameController = TextEditingController().obs;
  String childAgeText = "";
  AssessmentAndPlanViewModel assessmentAndPlanViewModel = Get.find();

  RxList<CombinedData> combinedList = <CombinedData>[].obs;
  RxList selectedGoalData = [].obs;
  RxList selectedSubGoalData = [].obs;
  RxList selectedCurrentLevelData = [].obs;
  RxList selectedStrategiesData = [].obs;

  /// FOR FETCH ALL DATA
  void combineAllSelectedData() {
    for (var item in assessmentAndPlanViewModel.goalSelectedList) {
      selectedGoalData.add(item["name"]);
    }
    print(selectedGoalData);
    for (var item in assessmentAndPlanViewModel.subGoalSelectedList) {
      selectedSubGoalData.add(item["name"]);
    }
    print(selectedSubGoalData);
    for (var item in assessmentAndPlanViewModel.currentLevelSelectedList) {
      selectedCurrentLevelData.add(item["name"]);
    }
    print(selectedCurrentLevelData);
    for (var item in assessmentAndPlanViewModel.strategiesSelectedList) {
      selectedStrategiesData.add(item["name"]);
    }
    print(selectedStrategiesData);

    // userTherapyDataModel.value?.sessionId = assessmentAndPlanViewModel.sessionData.value?.id ?? "";
    // print(assessmentAndPlanViewModel.sessionData.value?.id);
    // print(userTherapyDataModel.value?.sessionId);
    // userTherapyDataModel.value?.userId = SharedPreferenceUtils.getUserId();
    // userTherapyDataModel.value?.childName = childNameController.toString();
    // userTherapyDataModel.value?.childAge = int.parse(ageNameController.toString());
    // userTherapyDataModel.value?.goal = selectedGoalData;
    // userTherapyDataModel.value?.subGoal = selectedSubGoalData;
    // userTherapyDataModel.value?.currentLevel = selectedCurrentLevelData;
    // userTherapyDataModel.value?.strategies = selectedStrategiesData;
  }

  void setTherapyData({required String therapistName}) {
    combineAllSelectedData();
    Map<String, dynamic> data = {
      "sessionId": assessmentAndPlanViewModel.sessionData.value?.id,
      "userId": SharedPreferenceUtils.getUserId(),
      'therapistName': therapistName,
      "childName": childNameText,
      "childAge": childAgeText,
      "goal": selectedGoalData,
      "subGoal": selectedSubGoalData,
      "currentLevel": selectedCurrentLevelData,
      "strategies": selectedStrategiesData,
      "UserName": assessmentAndPlanViewModel.childNameSelectedList.value
    };

    print(data);
    TherapyPlanService()
        .setUserTherapyData(data)
        .then((value) => print("Status === <><><> === $value"));
  }

  void combineLists() {
    combinedList.clear();
    int maxLength = [
      assessmentAndPlanViewModel.goalSelectedList.length,
      assessmentAndPlanViewModel.subGoalSelectedList.length,
      assessmentAndPlanViewModel.currentLevelSelectedList.length,
      assessmentAndPlanViewModel.strategiesSelectedList.length
    ].reduce((a, b) => a > b ? a : b);

    for (int i = 0; i < maxLength; i++) {
      combinedList.add(CombinedData(
        category: i < assessmentAndPlanViewModel.goalSelectedList.length
            ? assessmentAndPlanViewModel.goalSelectedList[i]['name']
            : '',
        subCategory: i < assessmentAndPlanViewModel.subGoalSelectedList.length
            ? assessmentAndPlanViewModel.subGoalSelectedList[i]['name']
            : '',
        currentLevel:
            i < assessmentAndPlanViewModel.currentLevelSelectedList.length
                ? assessmentAndPlanViewModel.currentLevelSelectedList[i]['name']
                : '',
        plannedStrategies:
            i < assessmentAndPlanViewModel.strategiesSelectedList.length
                ? assessmentAndPlanViewModel.strategiesSelectedList[i]['name']
                : '',
      ));
    }
  }

  Future<void> generateAndSendPDFOnEmail({required String userEmailId}) async {
    combineLists();

    /// For Generate Pdf
    final cellStyleFont =
        pw.Font.ttf(await rootBundle.load('assets/fonts/OpenSans-Regular.ttf'));
    final headerStyleFont =
        pw.Font.ttf(await rootBundle.load('assets/fonts/OpenSans-Bold.ttf'));
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      build: (
        pw.Context context,
      ) {
        return pw.Table.fromTextArray(
          data: <List<String>>[
            ['Category', 'Sub Category', 'Current Level', 'Planned Strategies'],
            ...combinedList.map((data) => [
                  data.category,
                  data.subCategory,
                  data.currentLevel,
                  data.plannedStrategies,
                ]),
          ],
          cellStyle: pw.TextStyle(
            font: cellStyleFont,
          ),
          headerStyle: pw.TextStyle(font: headerStyleFont),
          tableWidth: pw.TableWidth.max,
          headerPadding: pw.EdgeInsets.symmetric(horizontal: 10.w),
          cellPadding: pw.EdgeInsets.symmetric(horizontal: 10.w),
          columnWidths: {
            0: const pw.FixedColumnWidth(80),
            1: const pw.FixedColumnWidth(80),
            2: const pw.FixedColumnWidth(60),
            3: const pw.FixedColumnWidth(150),
          },
        );
      },
    ));

    final Uint8List pdfBytes = await pdf.save();
    final directory = await getApplicationDocumentsDirectory();
    final pdfFile = File('${directory.path}/therapy_plan.pdf');
    await pdfFile.writeAsBytes(pdfBytes);

    /// Sending PDF via email
    final smtpServer = gmail('dhruvi.madvise@gmail.com', 'wjulhfrnfprfcfom');
    final message = Message()
      ..from = const Address('dhruvi.madvise@gmail.com', 'SessionMate')
      ..recipients.add(userEmailId)
      ..subject = 'Therapy Plan'
      ..text = 'Attached is the Therapy Plan'
      ..attachments.add(
        FileAttachment(pdfFile),
      );
    try {
      final sendReport = await send(message, smtpServer);
      if (kDebugMode) {
        print('Message sent: $sendReport');
      }
      showSussesSnackBar(
          'Send successfully', 'Send pdf successfully on your email');
      Get.offAll(const BottomBar());
    } on MailerException catch (e) {
      if (kDebugMode) {
        print('Message not sent. $e');
      }
      showErrorSnackBar('Error!!', 'Failed to send pdf');
    }
  }

  Future<void> generateAndSendPdfOnWhatsApp() async {
    combineLists();

    /// For Generate Pdf
    final cellStyleFont =
        pw.Font.ttf(await rootBundle.load('assets/fonts/OpenSans-Regular.ttf'));
    final headerStyleFont =
        pw.Font.ttf(await rootBundle.load('assets/fonts/OpenSans-Bold.ttf'));
    final pdfTable = pw.Document();
    pdfTable.addPage(pw.Page(
      build: (
        pw.Context context,
      ) {
        return pw.Table.fromTextArray(
          data: <List<String>>[
            ['Category', 'Sub Category', 'Current Level', 'Planned Strategies'],
            ...combinedList.map((data) => [
                  data.category,
                  data.subCategory,
                  data.currentLevel,
                  data.plannedStrategies,
                ]),
          ],
          cellStyle: pw.TextStyle(
            font: cellStyleFont,
          ),
          headerStyle: pw.TextStyle(font: headerStyleFont),
          tableWidth: pw.TableWidth.max,
          headerPadding: pw.EdgeInsets.symmetric(horizontal: 10.w),
          cellPadding: pw.EdgeInsets.symmetric(horizontal: 10.w),
          columnWidths: {
            0: const pw.FixedColumnWidth(80),
            1: const pw.FixedColumnWidth(80),
            2: const pw.FixedColumnWidth(60),
            3: const pw.FixedColumnWidth(150),
          },
        );
      },
    ));

    final Uint8List pdfBytes = await pdfTable.save();
    final directory = await getApplicationDocumentsDirectory();
    final pdfFile = File('${directory.path}/therapy_plan.pdf');
    await pdfFile.writeAsBytes(pdfBytes);

    /// SHARE PDF ON WHATSAPP WITH OPTION
    try {
      if (pdfFile.path.isEmpty) {
        Share.share(pdfFile.path);
      } else {
        await Share.shareXFiles([XFile(pdfFile.path)], text: '');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error launching WhatsApp: $e');
      }
    }

    /// SEND PDF LINK ON WHATSAPP
    /* ///======= Upload the PDF file to Firebase Storage
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('pdfs').child('therapy_plan.pdf');
    await storageRef.putFile(pdfFile);
    final downloadUrl = await storageRef.getDownloadURL();
    String phoneNumber = '9313343685';
    // SharedPreferenceUtils.getUserPhoneNumber();
    String messageText = downloadUrl;
    String encodedMessage = Uri.encodeComponent(messageText);
    var whatsappUrl =
        Uri.parse('whatsapp://send?phone=$phoneNumber&text=$encodedMessage');

    /// Launch the WhatsApp URL
    try {
      /// send as url
      await launchUrl(whatsappUrl);
    } catch (e) {
      if (kDebugMode) {
        print('Error launching WhatsApp: $e');
      }
    }*/
  }
}
