class TransfersModel{
  int? id;
  int? senderId;
  int? receiverId;
  int? amount;
  String? timestamp;

  TransfersModel({
    required int this.senderId,
    required int this.receiverId,
    required int this.amount,
    required this.timestamp,
  });

  TransfersModel.fromJson(Map<String, dynamic> map) {
    id = map["id"];
    senderId = map["sender_id"];
    receiverId = map["receiver_id"];
    amount = map["amount"];
    timestamp = map["timestamp"];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'sender_id' :senderId,
      'receiver_id': receiverId,
      'amount' :amount,
      'timestamp' :timestamp
    };
  }
}