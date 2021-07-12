import React, { Component } from 'react'

export default class Filter extends Component {
    render() {
        let cssStyle = {
            backgroundColor: 'Red',
            visibility: this.props.visible ? '' : 'hidden'
        }
        return (
            <div style={cssStyle}>
                The Filter Box
            </div>
        )
    }
}
