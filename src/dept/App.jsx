import React from "react";
import ReactDOM from "react-dom/client"
import {BrowserRouter, Route, Routes} from 'react-router-dom'
import { sprintf } from "sprintf-js";
import sleep from "es7-sleep"
import List from "./List.jsx"
import"./App.css"


class App extends React.Component{
	
	render(){
		return(
			<Routes>
				<Route path="/rest/dept" element={<List/>}/>
			</Routes>
		)
	}
}

let root=ReactDOM.createRoot(document.querySelector('#root'))
root.render(
	<BrowserRouter>
		<App/>
	</BrowserRouter>	
)