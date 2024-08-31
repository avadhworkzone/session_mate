import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:session_mate/view/scan_card_screen/scan_card_screen.dart';
import 'package:credit_card_scanner/credit_card_scanner.dart';

class AddBankCardViewModel extends GetxController {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController mmVvController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  RxBool isFocusField = false.obs;

  FocusNode focusNode = FocusNode();

  Future<void> scanCardBtnTap() async {

    var cardDetails = await CardScanner.scanCard(
      scanOptions: CardScanOptions()
    );
    // Get.to(() => ScanCardScreen());
  }

  void mmVvFieldOnChange(text) {
    if (text.length == 2 && !text.contains('/')) {
      text += '/';
      mmVvController.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    } else if (text.length == 3 && text[2] == '/') {
      text = text.substring(0, 2);
      mmVvController.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }


}