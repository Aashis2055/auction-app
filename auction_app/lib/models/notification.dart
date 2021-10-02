class NotificationModel {
  final String _id;
  final String message;
  final String uId;
  final String date;
  final String type;
  final String addedDate;
  NotificationModel(this._id, this.message, this.uId, this.date, this.type, this.addedDate);
  NotificationModel.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        message = json['message'],
        uId = json['u_id'],
        date = json['date'],
        type = json['type'],
        addedDate = json['added_at'].toString();
  Map<String, String> toJson() =>
      {'_id': _id, 'message': message, 'u_id': uId, 'date': date};
}
