import React from 'react'

export default function CommentTile(props) {
    const deleteComment = async()=>{
        props.delete.deleteComment(props.index)
    }
    const deleteReply = async()=>{
        props.delete.deleteReply(props.index);
    }
    return (
        <div className="comment-tile">
            <div>
                {props.comment.comment}
            </div>
            <span>{props.comment.added_date}</span>
            <button onClick={deleteComment}>Delete</button>
            <div className="reply-tile">
                {
                    
                    props.comment.reply === null? <div>No reply Yest</div> : <div>{props.comment.reply.reply} <button onClick={deleteReply}>Delete </button> </div>
                }
            </div>
        </div>
    )
    
}
