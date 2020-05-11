forvalues x = 1/12{
    gen ht`x' = round(runiform(5,7),0.1)
	lab var ht`x' ht`x'
}

*Example 1

forvalues i = 1/12{
    gen kgwt`i' = wt`i'/2.2
}

foreach var of varlist wt1-wt12{
    gen kg`var' = `var'/2.2
}


forvalues x = 1/12 {
generate kgwt`x' = wt`x'/2.2
generate mht`x'  = ht`x' * 2.54/100
generate bmi`x'  = kgwt`x'/(mht`x'^2) 
}

*Example 2
*use example2.dta
*follow paper
replace gender = .a if gender ==. //missing
replace gender = .b if gender ==. //not applicable


*Example 3



*Example 4 ( = example 3 on notes)


