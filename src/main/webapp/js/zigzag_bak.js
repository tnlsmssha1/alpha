



window.onload = () => {

	/** @type {HTMLTableElement} */	
	let surface = document.querySelector('#surface');
	
	surface.onmousedown = e => e.preventDefault();
	surface.oncontextmenu = e => e.preventDefault();
	
	/** @type {HTMLButtonElement} */
	let btnCreate = document.querySelector('#btnCreate');
	
	btnCreate.onclick = e => {
		console.log("btnCreate...");
		let zigzag = new ZigZag();
		zigzag.run();
	}
}

let Alpha = {
	line: 0,
	column: 0,
	fg: 0,
	bg: 0,
	ch: ''
};

class ZigZag {
	constructor() {
		/** @type {HTMLTableElement} */
		this.surface = document.querySelector('#surface');
	}
	
	show() {
		let td = this.surface.rows[this.alpha.line-1].cells[this.alpha.column-1];
		td.style.color = this.alpha.fg;
		td.style.background = this.alpha.bg;
		td.innerText = this.alpha.ch;
	}
	
	hide() {
		
	}
	
	async run() {
		let response = await fetch('/alpha/data');
		/** @type {Alpha}*/
		this.alpha = await response.json();
		console.log(this.alpha);
		
		this.show();
		
	}
}


