use "/Users/anna02pd2013/Desktop/alcohol treatment 3 (cleaned).dta"
use "/Users/anna02pd2013/Desktop/alcohol treatment 3 (cleaned).dta"
stset r_time, fail(relapse)
stcox familystrong prior age trt priorXage
gen familystrong ==3 if family=3
gen familystrong =1 if family==3
replace familystrong = 0 if family!=3
stcox familystrong prior age trt priorXage
gen priorXage = prior*age
stcox familystrong prior age trt priorXage
predict riskscore, xb
summarize riskscore, detial
summarize riskscore, detail
sort riskscore
quietly stcox familystrong prior age trt priorXage, nohr basesurv(s5)
gen sv5_5 = s5^(exp(-0.68))
gen sv5_25 = s5^(exp(-0.486))
gen sv5_50 = s5^(exp(-0.306))
gen sv5_75 = s5^(exp(-0.111))
gen sv5_95 = s5^(exp(0.285))
sort r_time
twoway line s5_5 s5_25 s5_50 s5_75 s5_95 r_time
twoway line sv5_5 sv5_25 sv5_50 sv5_75 sv5_95 r_time
stcurve, survival at(age=30) at2(age=60)
stcurve, survival at(age=25) at2(age=50)
stcurve, survival at1(age=20) at2(age=30) at3(age=40) at4(age=50)
stcurve, survival at1(prior=5) at2(prior=10) at3(age=15) 
stcurve, survival at1(prior=5) at2(prior=10) at3(prior=15) 
lincom _b[age]*30+_b[priorXage]*1, hr
lincom _b[age]*30+_b[priorXage]*1, hr
