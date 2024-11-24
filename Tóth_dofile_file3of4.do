****ANALYSIS MASTER THESIS ****
****Zsanett Bettina Tóth ****
****STUDENT ID: 6242896 ****

pwd
import excel "C:/Users/tothzsanett/Library/Mobile Documents/com~apple~CloudDocs/Uni/MPP/thesis/3.0/data/Final_data.xlsx", sheet("Sheet1") firstrow clear

encode Region, generate(Reg)

drop if Year <=2012

gen europe_region = .

asdoc sum Gender_Eq_Index Act_Rate_F Digital_Skill_F Digital_Skill_M Employed_Usually GDP_exp Gender_Pay_Gap Internet_Use_F Internet_Use_M Self_Employed_Usually

asdoc pwcorr Gender_Eq_Index Act_Rate_F Digital_Skill_F Digital_Skill_M Employed_Usually GDP_exp Gender_Pay_Gap Internet_Use_F Internet_Use_M Self_Employed_Usually, sig star(0.05)

preserve
collapse (mean) Gender_Eq_Index Digital_Skill_F, by(Country Reg)
twoway (scatter Gender_Eq_Index Digital_Skill_F, sort mlabel(Country Reg) colorvar(Reg) colorstart(gold) colorend(purple) colordiscrete coloruseplegend), ytitle(`"Gender Equality Index"') xtitle(`"Female Digital Skill"') plegend(order( 2 "Eastern EU" 1 "Western EU") rows(1) region(fcolor(white) lcolor(black)) bmargin(tiny) position(6))
restore

preserve
collapse (mean) Gender_Eq_Index Internet_Use_F, by(Country Reg)
twoway (scatter Gender_Eq_Index Internet_Use_F, sort mlabel(Country Reg) colorvar(Reg) colorstart(gold) colorend(purple) colordiscrete coloruseplegend), ytitle(`"Gender Equality Index"') xtitle(`"Female Internet Use"') plegend(order( 2 "Eastern EU" 1 "Western EU") rows(1) region(fcolor(white) lcolor(black)) bmargin(tiny) position(6))
restore


preserve
collapse (mean) Gender_Eq_Index Gender_Pay_Gap, by(Country Reg)
twoway (scatter Gender_Eq_Index Gender_Pay_Gap, sort mlabel(Country Reg) colorvar(Reg) colorstart(gold) colorend(purple) colordiscrete coloruseplegend), ytitle(`"Gender Equality Index"') xtitle(`"Gender Pay Gap"') plegend(order( 2 "Eastern EU" 1 "Western EU") rows(1) region(fcolor(white) lcolor(black)) bmargin(tiny) position(6))
restore


ttest Digital_Skill_M == Digital_Skill_F, unpaired
ttest Gender_Eq_Index, by(Reg)

xtset C_ID Year

reg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F
asdoc vif

*EU
*Pooled OLS estimate
reg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F
outreg2 using Table_6, word replace ctitle(Pooled OLS) label dec(3) title(Digitalization and Gender Equality in EU) 

*Random effects (RE) estimate 
xtreg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F

*Test of Pooled OLS and RE
xttest0

*Fixed effect (FE) estimate
xtreg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F, fe
outreg2 using Table_6, word append ctitle(Fixed Effect) label dec(3) title(Digitalization and Gender Equality in EU) 

*RE estimate
xtreg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F, re
outreg2 using Table_6, word append ctitle(Random Effect) label dec(3) title(Digitalization and Gender Equality in EU)  

*Hausman Test
xtreg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F , fe
estimate store FE
xtreg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F , re
estimate store RE
hausman FE RE


*Eastern EU
*Pooled estimate
reg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F if Reg==1
outreg2 using Table_7, word replace ctitle(Pooled OLS) label dec(3) title(Digitalization and Gender Equality in Eastern EU) 

*RE estimate 
xtreg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F if Reg==1

*Test of Pool and RE
xttest0

*FE estimate
xtreg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F if Reg==1, fe
outreg2 using Table_7, word append ctitle(Fixed Effect) label dec(3) title(Digitalization and Gender Equality in Eastern EU)  

*RE Estimate
xtreg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F if Reg==1, re
outreg2 using Table_7, word append ctitle(Random Effect) label dec(3) title(Digitalization and Gender Equality in Eastern EU)  

*Hausman Test
xtreg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F if Reg==1, fe
estimate store FE
xtreg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F if Reg==1, re
estimate store RE
hausman FE RE


*Western EU
*Pooled estimate
reg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F if Reg==2
outreg2 using Table_8, word replace ctitle(Pooled OLS) label dec(3) title(Digitalization and Gender Equality in Western EU) 

*RE estimate 
xtreg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F if Reg==2

*Test of Pool and RE
xttest0

*FE estimate
xtreg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F if Reg==2, fe
outreg2 using Table_8, word append ctitle(Fixed Effect) label dec(3) title(Digitalization and Gender Equality in Western EU)  

*RE Estimate
xtreg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F if Reg==2, re
outreg2 using Table_8, word append ctitle(Random Effect) label dec(3) title(Digitalization and Gender Equality in Western EU)  

*Hausman Test
xtreg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F if Reg==2, fe
estimate store FE
xtreg Gender_Eq_Index Digital_Skill_F Act_Rate_F GDP_exp Gender_Pay_Gap Employed_Usually Self_Employed_Usually Internet_Use_F if Reg==2, re
estimate store RE
hausman FE RE
