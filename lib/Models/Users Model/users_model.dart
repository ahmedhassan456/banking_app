class UsersModel{
  int? id;
  String? name;
  String? email;
  int? currentBalance;

  UsersModel.fromJson(Map<String, dynamic> map){
    id = map["id"];
    name = map["name"];
    email = map["email"];
    currentBalance = map["current_balance"];
  }

  Map<String, dynamic> toMap() 
  {
    return {
      'id' :id,
      'name' :name,
      'email': email,
      'current_balance' :currentBalance,
    };
  }
}