import React from 'react'

export default function CommentTile(props) {
    return (
        <div className="comment-tile">
            <div>
                {props.comment.comment}
            </div>
            <span>{props.comment.added_date}</span>
            <div className="reply-tile">
                {
                    props.reply? <div>No reply Yest</div> : <div>{props.comment.reply}</div>
                }
            </div>
        </div>
    )
}
