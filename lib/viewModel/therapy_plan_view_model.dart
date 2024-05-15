import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class TherapyPlanViewModel extends GetxController {
  late List<Map<String, dynamic>> tableData;
  Rx<TextEditingController> childNameController = TextEditingController().obs;
  Rx<TextEditingController> ageNameController = TextEditingController().obs;

  Future<void> fetchDataFromFirebase() async {
    tableData = [
      {'name': 'John', 'age': 30},
      {'name': 'Alice', 'age': 25},
      {'name': 'Bob', 'age': 35},
      {'name': 'Bob', 'age': 35},
      {'name': 'Bob', 'age': 35},
      {'name': 'Bob', 'age': 35},
      {'name': 'Bob', 'age': 35},
      {'name': 'Bob', 'age': 35},
      {'name': 'Bob', 'age': 35},
      {'name': 'Bob', 'age': 35},
      {'name': 'Bob', 'age': 35},
    ];
  }

  Future<void> generateAndSendPDF() async {
    /// For Generate Pdf
    final pdf = pw.Document();
    final font =
        pw.Font.ttf(await rootBundle.load('assets/fonts/OpenSans-Regular.ttf'));
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Table.fromTextArray(
          data: <List<String>>[
            ['Name', 'Age'],
            ...tableData.map((data) => [data['name'], data['age'].toString()]),
          ],
          cellStyle: pw.TextStyle(font: font),
          headerStyle: pw.TextStyle(font: font),
        );
      },
    ));

    final Uint8List pdfBytes = await pdf.save();
    final directory = await getApplicationDocumentsDirectory();
    final pdfFile = File('${directory.path}/table_data.pdf');
    await pdfFile.writeAsBytes(pdfBytes);

    /// Sending PDF via email
    final smtpServer = gmail('dhruvi.madvise@gmail.com', 'wjulhfrnfprfcfom');
    final message = Message()
      ..from = const Address('dhruvi.madvise@gmail.com', 'SessionMate')
      ..recipients.add('dev.dhruvirakholiya@gmail.com')
      ..subject = 'Table Data'
      ..text = 'Attached is the table data'
      ..attachments.add(
        FileAttachment(pdfFile),
      );
    try {
      final sendReport = await send(message, smtpServer);
      if (kDebugMode) {
        print('Message sent: $sendReport');
      }
    } on MailerException catch (e) {
      if (kDebugMode) {
        print('Message not sent. $e');
      }
    }

    /// send pdf on whatsapp
    ///======= Upload the PDF file to Firebase Storage
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('pdfs').child('table_data.pdf');
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

      /*    /// send as file
      if (pdfFile.path.isEmpty) {
        Share.share(pdfFile.path);
      } else {
        await Share.shareXFiles([XFile(pdfFile.path)], text: '');
      }*/
    } catch (e) {
      if (kDebugMode) {
        print('Error launching WhatsApp: $e');
      }
    }

    /*   try {
      if (pdfFile.path.isEmpty) {
        Share.share(pdfFile.path);
      } else {
        await Share.shareXFiles([XFile(pdfFile.path)],
            text: '');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error launching WhatsApp: $e');
      }
    }*/
  }
}
