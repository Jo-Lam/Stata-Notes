*Creating Pseudo-data for practicals
keep in 1/200 
*sub_ID, random integers between 10000 and 35000
replace sub_id = int(runiform(10000,35000))
*site_scr, extract form first digit of sub_id
replace site_scr = 1 if sub_id > 10000 & sub_id <= 19999
replace site_scr = 2 if sub_id >= 20000 & sub_id <= 29999
replace site_scr = 3 if sub_id >= 30000 & sub_id <= 35000
*case_control_rel, integers between 1 - 3
replace case_control_rel = int(runiform(1,4))
*gender, integers between 1 - 2 
replace gender = int(runiform(1,3))
replace gender =. in 130/150
*date of birth, 
replace DOB = floor((mdy(12,31,2000)-mdy(12,1,1956)+1)*runiform() + mdy(12,1,1956))
format DOB %td
*age
gen date_today = date("$S_DATE","DMY")
gen Age = int((date_today - DOB)/365)
drop date_today age
order Age, before(DOB)
replace Age = . in 60/80
lab var Age age
rename Age age

*ethnicity
replace ethnicity = int(runiform(1,6))

*source
gen source = int(runiform(1,4))
lab def source 1"Psychiatric service"2"Informal practices"3"Religious settings"
lab var source source
lab val source source

*PANSS_p
gen panss_p = int(rnormal(18.20,5))
lab var panss_p "PANSS Positive Symptom Score"
recode panss_p (1/6 = 7)

drop panss
*categorise panss_p, for example
*7 - 14 mild
*15 - 35 moderate
*36 - 49 severe

*replace panss = int(rnormal(77,15))
*lab var panss "PANSS Total Score"

gen include =.
lab var include "Include in Analysis?"
order age DOB gender ethnicity site_scr case_control_rel source panss_p, after (sub_id)
