import React from "react";
import ReactDOM from "react-dom/client"
import Alpha from "./util/alpha.js";
import { sprintf } from "sprintf-js";
import sleep from "es7-sleep"

import "./css/fill.css"

let root=ReactDOM.createRoot(document.querySelector('#root'))

class App extends React.Component{
	
	constructor(){
		super();
		for(let i=0;i<20;i++){
			this.state.surface[i]=[];
			for(let j=0;j<40;j++){
				let alpha=new Alpha();
				alpha.fg='black';
				alpha.bg='black';
				this.state.surface[i][j]=alpha;
				
			}
		}
		console.log(this.state.surface);
	}
	
	state={
		surface: [],
		forCount:0,
		count:0,
		ellipse:0,
		disabled: false,
	}
	
	async fill(){
		for(;;){
			this.state.forCount++;
			let alpha=new Alpha();
			let a=this.state.surface[alpha.line-1][alpha.column-1]
			
			if(a.fg=='black'&&a.bg=='black'){
				this.state.count++;
			}
			
			this.state.surface[alpha.line-1][alpha.column-1]=alpha;
			this.forceUpdate();
			await sleep(1);
			
			if(this.state.count==800){
				this.state.disabled=flase;
				this.forceUpdate();
				break;
			}
		}
	}
	async timer(){
		for(;;){
			this.state.ellipse++;
			await sleep(1000);
		}
	}
	btnCreate_click(e){
		this.state.disabled=true;
		this.forceUpdate();
		
		this.fill();
		this.timer();
		
	}
	
	render(){
		return(
			<>
			<button disabled={this.state.disabled} onClick={(event)=>this.btnCreate_click(event)}>Start</button>
			<hr/>
			<table width={200} border={1}>
				<thead>
				<tr>
					<th>forCount</th>		
					<th>count</th>		
					<th>ellipse</th>		
				</tr>
				</thead>
				<tbody>
				<tr align="center">
					<td>{this.state.forCount}</td>
					<td>{this.state.count}</td>
					<td>{this.state.ellipse}</td>
				</tr>	
				</tbody>
			</table>
			<hr/>
			<table className="collapse"
				   onMouseDown={event=>event.preventDefault()}
				   onContextMenu={event=>event.preventDefault()}>
				<tbody>
				{
					this.state.surface.map((row,k)=> 
						<tr key={k}>
							{
								row.map((v,k)=>
									<td key={k} style={{color:v.fg,background:v.bg}}>{v.ch}</td>
								)
							}
						</tr>
					)
				}
				</tbody>
			</table>
			</>
		)
	}
}

root.render(<App/>)