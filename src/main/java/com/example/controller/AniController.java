package com.example.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.util.Alpha;
import com.example.util.Color;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/ani")
public class AniController {
	
	
	@GetMapping("/CURL")
	void fill(Model model) {
		
		Alpha[][] alphas = new Alpha[20][40];
		for(var i=0; i<alphas.length; i++) {
			for( var j=0; j<alphas[i].length; j++) {
				alphas[i][j] = new Alpha();
			}
		}
		model.addAttribute("surface", alphas);
	}
	@GetMapping("/data")
	@ResponseBody
	Alpha data() {
		return new Alpha();
	}
}
