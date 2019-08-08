class SaveDataClass {
  String Message;
  bool IsSuccess;
  bool IsRecord;
  String Data;

  SaveDataClass({this.Message, this.IsSuccess,this.IsRecord, this.Data});

  factory SaveDataClass.fromJson(Map<String, dynamic> json) {
    return SaveDataClass(
        Message: json['Message'] as String,
        IsSuccess: json['IsSuccess'] as bool,
        IsRecord: json['IsRecord'] as bool,
        Data: json['Data'] as String);
  }
}