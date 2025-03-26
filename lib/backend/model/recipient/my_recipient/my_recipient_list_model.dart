import 'dart:convert';

MyRecipientListModel myRecipientListModelFromJson(String str) =>
    MyRecipientListModel.fromJson(json.decode(str));

String myRecipientListModelToJson(MyRecipientListModel data) =>
    json.encode(data.toJson());

class MyRecipientListModel {
  final Message message;
  final Data data;

  MyRecipientListModel({
    required this.message,
    required this.data,
  });

  factory MyRecipientListModel.fromJson(Map<String, dynamic> json) =>
      MyRecipientListModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  final List<ReceiverRecipient> receiverRecipients;

  Data({
    required this.receiverRecipients,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        receiverRecipients: List<ReceiverRecipient>.from(
            json["receiver_recipients"]
                .map((x) => ReceiverRecipient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "receiver_recipients":
            List<dynamic>.from(receiverRecipients.map((x) => x.toJson())),
      };
}

class ReceiverRecipient {
  final int id;
  final int country;
  final String countryName;
  final String trxType;
  final String recipientType;
  final String trxTypeName;
  final String alias;
  final String firstname;
  final String lastname;
  final String email;
  final String mobileCode;
  final String mobile;
  final String city;
  final String state;
  final String address;
  final String zipCode;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReceiverRecipient({
    required this.id,
    required this.country,
    required this.countryName,
    required this.trxType,
    required this.recipientType,
    required this.trxTypeName,
    required this.alias,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.mobileCode,
    required this.mobile,
    required this.city,
    required this.state,
    required this.address,
    required this.zipCode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReceiverRecipient.fromJson(Map<String, dynamic> json) =>
      ReceiverRecipient(
        id: json["id"],
        country: json["country"],
        countryName: json["country_name"],
        trxType: json["trx_type"],
        recipientType: json["recipient_type"],
        trxTypeName: json["trx_type_name"],
        alias: json["alias"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        mobileCode: json["mobile_code"],
        mobile: json["mobile"],
        city: json["city"],
        state: json["state"],
        address: json["address"],
        zipCode: json["zip_code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "country_name": countryName,
        "trx_type": trxType,
        "recipient_type": recipientType,
        "trx_type_name": trxTypeName,
        "alias": alias,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "mobile_code": mobileCode,
        "mobile": mobile,
        "city": city,
        "state": state,
        "address": address,
        "zip_code": zipCode,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Message {
  final List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
