import React from "react";
import { sprintf } from "sprintf-js";
import sleep from "es7-sleep"
import withRouter from "./withRouter.js";


class List extends React.Component{
	constructor(){
		super();
		console.log("constructor...")
	}
	
	componentDidMount(){
		console.log("componenet...")
		this.init();
	}
	
	async init(){
		let response=await fetch("/rest/dept");
		let json=await response.json();
		
		this.state.data=json.data;
		console.log(this.state.data)
		this.forceUpdate();
	}
	
	state={
		data:[]
	}
	
	render(){
		return(
			<>
			<h1>부서 목록</h1>
			<hr/>
			<table border={1}>
				<thead>
					<tr>
						<th>deptno</th>
						<th>dname</th>
						<th>loc</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
				{
					this.state.data.map(dept =>
						<tr key={dept.deptno}>
							<td>{dept.deptno}</td>
							<td>{dept.dname}</td>
							<td>{dept.loc}</td>
							<td>Update</td>
							<td>Delete</td>
						</tr>
					)
				}
				</tbody>
			</table>
			</>
		)
	}
}

export default withRouter(List);
