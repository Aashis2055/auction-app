class NotificationModel {
  final String _id;
  final String message;
  final String u_id;
  final String date;
  final String type;
  NotificationModel(this._id, this.message, this.u_id, this.date, this.type);
  NotificationModel.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        message = json['message'],
        u_id = json['u_id'],
        date = json['date'],
        type = json['type'];
  Map<String, String> toJson() =>
      {'_id': _id, 'message': message, 'u_id': u_id, 'date': date};
}
