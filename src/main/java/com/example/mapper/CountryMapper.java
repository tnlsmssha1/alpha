package com.example.mapper;

import java.sql.JDBCType;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.model.Country;

@Mapper
public interface CountryMapper {
	
	@Select("select * from country")
	List<Country> selectAll();
	
	@Select("select distinct continent from country")
	List<String> selectContinents();
	
	@Select("""
			select distinct region 
			from country
			where continent=#{continent, jdbcType=VARCHAR}
			""")
	List<String> selectRegions(String continent);
	
	@Select("""
			select * 
			from country
			where continent=#{continent}
			""")
	List<Country> selectAllByContinent(String continent);
	
	@Select("""
			select * 
			from country
			where continent=#{continent}
			  and region=#{region}
			""")
	List<Country> selectAllByContinentAndRegion(@Param("continent") String continent, @Param("region") String region);
	// 2개 이상의 검색 값이 들어가면 위 코드처럼 @Param()을 작성해줘야 하고 괄호안에는 각 변수에 해당하는 이름을 붙여준다.
	
	
	
}
