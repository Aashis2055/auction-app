class NotificationModel {
  final String _id;
  final String message;
  final String u_id;
  final String date;
  final String type;
  final String addedDate;
  NotificationModel(this._id, this.message, this.u_id, this.date, this.type, this.addedDate);
  NotificationModel.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        message = json['message'],
        u_id = json['u_id'],
        date = json['date'],
        type = json['type'],
        addedDate = json['added_at'].toString();
  Map<String, String> toJson() =>
      {'_id': _id, 'message': message, 'u_id': u_id, 'date': date};
}
