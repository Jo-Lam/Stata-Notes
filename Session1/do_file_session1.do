*Tutorial 1 - step by step do.file
*1) Set current directory - copy your selected file-path and paste.
cd"C:\Users\Joseph\Desktop\INTREPID II\STATA Teaching Materials\Stata-Notes\Session1"

*To understand your data - 
*use these commands - browse, describe, summarize, codebook, list

*browse: opens data editor
browse
browse if age > 30

*describe - try to use <help> to understand what describe does
help describe
describe

*codebook - understand your data - texts, continuous, categorical?
codebook 
codebook gender

*summarize - descriptive statistics - particularly useful or continuous variables
summarize
summarize age panss_p 

*list - print out the selected variables, similarly you can add conditions and select which variables to be listed - particularly useful to identify individuals with missing data.
list
list if gender == 1
list sub_id if gender == .

*generate and replace
generate age_miss = .
replace age_miss = 1 if age ==.
replace age_miss = 0 if age !=.

*replacing variables to be included (cases/control & panss>=14)
*boolean operators AND (&), OR (|)
replace include = 1 if case_control_rel != 3 & panss_p >= 14
replace include = 0 if include ==.
*solution 2 - does the same thing, do you know why?
replace include = 1 if case_control_rel == 1 & panss_p >= 14| case_control_rel == 2 & panss_p >= 14 

*Which variable contains missing data?
codebook age gender
tabulate age, miss
tabulate gender, miss

*why does tab gender looks so much better than tab age? - gender is categorical and age is continuous! add the function "miss", after comma would print the missing data as well.
summarize age

*Generate variable nomiss to only include variables with no missing data in all variables as 1. 

*vijay's attempt
gen nomiss_vijay =.
replace nomiss_vijay = 1 if age != . & nomiss_vijay == . | gender != . & nomiss_vijay == . //(200 real changes)

replace nomiss_vijay = 0 if age == . & nomiss_vijay == . | gender == . & nomiss_vijay == . //(0 real changes)

*all 200 variables = 1, why is that happening? what information can we deduce from this? - we can deduce that no individual has missing data in both gender and age. However, this code does not achieve what is being asked to.

*lauren
generate nomiss_lauren = .
replace nomiss_lauren = 1 if age != . & gender != . //(158 real changes)
replace nomiss_lauren = 0 if age == . | gender == . //(42 real changes)

*Lauren's code made it work! Lauren marks variable as 1 if they have no missing data in BOTH age & gender. This would mean that if a variable has missing data. Lauren's second come replaces variable as 0 if age OR gender is missing. Well done Lauren!

*Next, create a variable include2, that includes only cases that is older or equal to 18, and younger or equal to 24, and has panss positive subscale score over 30.

*lauren 
generate include2_lauren = .
replace include2_lauren = 1 if age >= 18 & age <= 24 & panss_p > 30
replace include2_lauren = 0 if age < 18 | age > 24 | panss_p <= 30

*vijay
gen include2_vijay =.
replace include2_vijay = 1 if age >= 18 & age <= 24 & panss_p >= 30
replace include2_vijay = 0 if age < 18 & age > 24 & panss_p < 30

*Both of the above codes resulted no observations. Why?

*vijay second guess
gen include2_vijay2 =.
replace include2_vijay2 = 1 if age >= 18 | age <= 24 & panss_p >= 30 //1 (200 real changes, everything == 1)

replace include2_vijay2 = 1 if age >= 18 & panss_p >= 30 //2 (0 changes)
replace include2_vijay2 = 1 if age <= 24 & panss_p >= 30 //3 (0 changes)

*Quesion: Does 1 do the same as 2 & 3?
*Answer: NO! But why?
*Answer: the OR(|) operator is not setup correctly. If you want 1 to work the same as 2 & 3, you should type:
replace include2_vijay2 = 1 if age >= 18 & panss_p >= 30  | age <= 24 & panss_p >= 30 

*Why is there no observations? You have to FIRST understand your data. 
summarize age
tabstat age, s(n mean sd min max)

summarize panss_p
tabstat panss_p, s(n mean sd min max)
*The largest value of panss_p in our sample is 29! Of course there is no observations with panss_p > 30, therefore, none of the individuals should be included!

*The lesson is, have a good understanding of your dataset before jumping straight into coding. A lot of meanings would be lost if we do not understand what is going on in your data!

*This is all for Session 1, please feel free to email joseph.1.lam@kcl.ac.uk if you have any questions!