import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:session_mate/modal/razor_pay_refund_response_model.dart';
import 'package:session_mate/utils/app_snackbar.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';

class MyPlanViewModel extends GetxController {
  RazorPayRefundResponseModel? razorPayRefundData;
  var userDetail = jsonDecode(SharedPreferenceUtils.getUserDetail());

  Future<void> razorPayRefundApi({required int amount}) async {
    try {
      Map<String, dynamic> body = {"amount": amount * 100};
      print("userDetail==>$userDetail");
      final response = await http.post(
        Uri.parse(
            "https://api.razorpay.com/v1/payments/${userDetail?["payment_id"]}/refund"
            // "https://api.razorpay.com/v1/payments/pay_OFOmdGodjSjkCj/refund"
            ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Basic cnpwX2xpdmVfMkp4SkxwQjJzbWF4R2M6MHlud2lONGYyUm9zQXlnTGdRNXI1UXdv'
        },
        body: jsonEncode(body),
      );
      print("Data response: ${response.body}");
      print('response.statusCode: ${response.statusCode}');
      if (response.statusCode == 200) {
        RazorPayRefundResponseModel razorPayRefundResponseModel =
            razorPayRefundResponseModelFromJson(response.body);
        if (razorPayRefundResponseModel.status == "processed") {
          showSussesSnackBar('', 'Your refund is in process');
        }
        razorPayRefundData = razorPayRefundResponseModel;
      } else if (response.statusCode == 400) {
        var errorResponse = jsonDecode(response.body);
        print("errorResponse--${errorResponse}");
        showSussesSnackBar('', errorResponse["error"]["description"]);
      } else {
        showErrorSnackBar('', 'Failed Refund');
      }
    } catch (e) {
      print(e);
    }
  }
}
