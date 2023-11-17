package com.example.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.mapper.CityMapper;
import com.example.model.City;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/city")
public class CityController {
	
	@Autowired
	CityMapper mapper;

	@GetMapping("/list")
	String list(String code, Long population, Model model) {

		var list = mapper.searchAll(code, population);
		
		model.addAttribute("list", list);
		
		var codes = mapper.selectCountryCodes();
		model.addAttribute("codes", codes);
		
		return "city/list";
	}
}
