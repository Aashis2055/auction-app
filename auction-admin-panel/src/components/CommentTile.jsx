import React from 'react'

export default function CommentTile(props) {
    console.log(props.reply);
    return (
        <div className="comment-tile">
            <div>
                {props.comment.comment}
            </div>
            <span>{props.comment.added_date}</span>
            <button>Delete</button>
            <div className="reply-tile">
                {
                    
                    props.reply? <div>No reply Yest</div> : <div>{props.comment.reply} <button>Delete </button> </div>
                }
            </div>
        </div>
    )
}
