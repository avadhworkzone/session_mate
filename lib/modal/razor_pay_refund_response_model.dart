import 'dart:convert';
RazorPayRefundResponseModel razorPayRefundResponseModelFromJson(String str) => RazorPayRefundResponseModel.fromJson(json.decode(str));
String razorPayRefundResponseModelToJson(RazorPayRefundResponseModel data) => json.encode(data.toJson());
class RazorPayRefundResponseModel {
  RazorPayRefundResponseModel({
      this.id, 
      this.entity, 
      this.amount, 
      this.receipt, 
      this.currency, 
      this.paymentId, 
      this.notes, 
      this.acquirerData, 
      this.createdAt, 
      this.batchId, 
      this.status, 
      this.speedProcessed, 
      this.speedRequested,});

  RazorPayRefundResponseModel.fromJson(dynamic json) {
    id = json['id'];
    entity = json['entity'];
    amount = json['amount'];
    receipt = json['receipt'];
    currency = json['currency'];
    paymentId = json['payment_id'];
   /* if (json['notes'] != null) {
      notes = [];
      json['notes'].forEach((v) {
        notes?.add(Dynamic.fromJson(v));
      });
    }*/
    acquirerData = json['acquirer_data'] != null ? AcquirerData.fromJson(json['acquirer_data']) : null;
    createdAt = json['created_at'];
    batchId = json['batch_id'];
    status = json['status'];
    speedProcessed = json['speed_processed'];
    speedRequested = json['speed_requested'];
  }
  String? id;
  String? entity;
  num? amount;
  dynamic receipt;
  String? currency;
  String? paymentId;
  List<dynamic>? notes;
  AcquirerData? acquirerData;
  num? createdAt;
  dynamic batchId;
  String? status;
  String? speedProcessed;
  String? speedRequested;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['entity'] = entity;
    map['amount'] = amount;
    map['receipt'] = receipt;
    map['currency'] = currency;
    map['payment_id'] = paymentId;
   /* if (notes != null) {
      map['notes'] = notes?.map((v) => v.toJson()).toList();
    }*/
    if (acquirerData != null) {
      map['acquirer_data'] = acquirerData?.toJson();
    }
    map['created_at'] = createdAt;
    map['batch_id'] = batchId;
    map['status'] = status;
    map['speed_processed'] = speedProcessed;
    map['speed_requested'] = speedRequested;
    return map;
  }

}

AcquirerData acquirerDataFromJson(String str) => AcquirerData.fromJson(json.decode(str));
String acquirerDataToJson(AcquirerData data) => json.encode(data.toJson());
class AcquirerData {
  AcquirerData({
      this.arn,});

  AcquirerData.fromJson(dynamic json) {
    arn = json['arn'];
  }
  dynamic arn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['arn'] = arn;
    return map;
  }

}