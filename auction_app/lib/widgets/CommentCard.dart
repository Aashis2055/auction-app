import 'package:auction_app/models/comment.dart';
import 'package:flutter/material.dart';
class CommentCard extends StatelessWidget {
  final Comment comment;
  CommentCard(this.comment);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(comment.comment),
        subtitle: comment.reply == null? Text('No Reply') : Text(comment.reply.reply)
      )
    );
  }
}