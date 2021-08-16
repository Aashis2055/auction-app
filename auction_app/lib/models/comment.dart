class Comment {
  final String uId;
  final String vId;
  final String comment;
  final String addedDate;
  final Reply reply;
  Comment(this.uId, this.vId, this.comment, this.addedDate, this.reply);
  Comment.fromJson(Map<String, dynamic> json)
      : uId = json['u_id'],
        vId = json['v_id'],
        comment = json['comment'],
        addedDate = json['added_date'],
        reply = Reply.fromJson(json['reply']);
}

class Reply {
  final String reply;
  final String uID;
  Reply(this.reply, this.uID);
  Reply.fromJson(Map<String, dynamic> json)
      : reply = json['reply'],
        uID = json['u_id'];
}


