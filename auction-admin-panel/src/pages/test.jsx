import React, { Component } from 'react'
import { withRouter } from 'react-router'

class Test extends Component {
    render() {
        console.log(this.props.match);
        return (
            <div>
                The test page
            </div>
        )
    }
}
export default withRouter(Test);
