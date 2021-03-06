*Before we start
ssc install cmogram
ssc install rdrobust 
net install rddensity, from(https://raw.githubusercontent.com/rdpackages/rddensity/master/stata) replace
net install lpdensity, from(https://sites.google.com/site/nppackages/lpdensity/stata) replace


*q3 & q4---
gen bacc=0
replace bacc=1 if bac1>=0.08
hist bac1

*---

*q5---

reg bacc white male aged acc, robust

*---

*q6---

cmogram acc bac1, cut(0.08) scatter line(0.08) lfit
cmogram acc bac1, cut(0.08) scatter line(0.08) qfit

cmogram male bac1, cut(0.08) scatter line(0.08) lfit
cmogram male bac1, cut(0.08) scatter line(0.08) qfit

cmogram white bac1, cut(0.08) scatter line(0.08) lfit
cmogram white bac1, cut(0.08) scatter line(0.08) qfit

cmogram aged bac1, cut(0.08) scatter line(0.08) lfit
cmogram aged bac1, cut(0.08) scatter line(0.08) qfit

*---

*q7---

gen bac1_c = bac1 - 0.08
gen baccbac1_c = bacc*bac1_c
gen bac1_c2 = bac1^2
gen bac1_c3 = bac1*bac1*bac1

xi: reg recidivism male white age acc i.bacc*bac1 if bac1>=0.03 & bac1<=0.13, robust
xi: reg recidivism male white age acc bacc##(c.bac1_c c.bac1_c2) if bac1>=0.03 & bac1<=0.13, robust
xi: reg recidivism male white age acc bacc##(c.bac1_c c.bac1_c2 c.bac1_c3) if bac1>=0.03 & bac1<=0.13, robust

xi: reg recidivism male white age acc i.bacc*bac1 if bac1>=0.055 & bac1<=0.105, robust
xi: reg recidivism male white age acc bacc##(c.bac1_c c.bac1_c2) if bac1>=0.055 & bac1<=0.105, robust
xi: reg recidivism male white age acc bacc##(c.bac1_c c.bac1_c2 c.bac1_c3) if bac1>=0.055 & bac1<=0.155, robust

rddensity bac1, c(0.08) plot

rdrobust recidivism bac1, c(0.08)


*q8---

cmogram recidivism bac1 if bac1<0.15, cut(0.08) scatter line(0.08) lfit
cmogram recidivism bac1 if bac1<0.15, cut(0.08) scatter line(0.08) qfit


---

gen baccbac1 = bacc*bac1
reg recidivism male white age acc bacc bac1 baccbac1, robust


cmogram recidivism bac1 , cut(0.08) scatter line(0.08) lfit
cmogram recidivism bac1, cut(0.08) scatter line(0.08) qfit
