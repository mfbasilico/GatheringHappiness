clear all
set more off

use  GH2025_Dataset.dta

//***// A: Adjusting for Missing Observations //***//
//Reference: pages 7-8 of Giuliano, Paola, and Nathan Nunn. "Ancestral characteristics of modern populations." Economic History of Developing Regions 33, no. 1 (2018): 1-17.

// v42 Coding
gen Murdock_v42_HunterGatherer = (v42_grp2 + v42_grp4) / (1-v42_grp1)
label var Murdock_v42_HunterGatherer "Hunting or Gathering Predominant"

gen Murdock_v42_Gatherer = (v42_grp2) / (1-v42_grp1)
label var Murdock_v42_Gatherer "Gathering Predominant"

gen Murdock_v42_Hunter = (v42_grp4) / (1-v42_grp1)
label var Murdock_v42_Hunter "Hunting Predominant"

gen Murdock_v42_Fishing = (v42_grp3) / (1-v42_grp1)
label var Murdock_v42_Fishing "Fishing Predominant"

gen Murdock_v42_FishHunterGatherer = (v42_grp2 + v42_grp4) / (1-v42_grp1)
label var Murdock_v42_FishHunterGatherer "Hunting, Gathering or Fishing Predominant"

/// Controls
// v8 Any Polgynyous
gen Murdock_v8_AnyPolygynous = (v8_grp5*1 + v8_grp6*1) / (1-v8_grp1)
label var Murdock_v8_AnyPolygynous "Polygynous"

// v30 Economic Complexity
gen Murdock_v30_AveComplex = (v30_grp2*1 + v30_grp3*2 + v30_grp4*3 + v30_grp5*4 + v30_grp6*5 + v30_grp7*6 + v30_grp8*7 + v30_grp9*8) / (1-v30_grp1)
label var Murdock_v30_AveComplex "Average Settlement Complexity"

// v33 Pol Heirarchy
gen Murdock_v33_AveLevelsJH = (v33_grp3 + v33_grp4*2 + v33_grp5*3 + v33_grp6*4) / (1-v33_grp1)
label var Murdock_v33_AveLevelsJH "Average Level of Political Hierarchy"

// v39 Plow
gen Murdock_v39_PlowAboriginal = (v39_grp4) / (1-v39_grp1)
label var Murdock_v39_PlowAboriginal "Plough Use"

// v43 Martilineal Descent
gen Murdock_v43_Matrilineal = v43_grp4 / (1-v43_grp1)
label var Murdock_v43_Matrilineal "Matrilineal Descent"

// v43 Patrilineal Descent
gen Murdock_v43_Patrilineal = v43_grp2 / (1-v43_grp1)
label var Murdock_v43_Patrilineal "Patrilineal Descent"

// Enke Kinship Score
gen Murdock_vx_EnkeKinship = kinship_score
label var Murdock_vx_EnkeKinship "Kinship Score"

keep Murdock_v42_Fishing Murdock_v42_Gatherer Murdock_v42_HunterGatherer Murdock_v42_FishHunterGatherer Murdock_v42_Hunter Murdock_v33_AveLevelsJH Murdock_v30_AveComplex Murdock_v43_Patrilineal Murdock_v43_Matrilineal Murdock_v8_AnyPolygynous Murdock_v39_PlowAboriginal Murdock_vx_EnkeKinship logGDPPerCap2019_WDI Happy LifSat continent


//***// B: TABLES //***//

vl create CONTROLHX = (Murdock_v33_AveLevelsJH Murdock_v30_AveComplex Murdock_v43_Patrilineal Murdock_v43_Matrilineal Murdock_v8_AnyPolygynous Murdock_v39_PlowAboriginal Murdock_vx_EnkeKinship)
encode continent, gen(continent_factor)


//Table 1:
reg Happy Murdock_v42_Gatherer, r
est store I1
outreg2 using PO_Table1.xls, replace label

reg Happy Murdock_v42_Gatherer logGDPPerCap2019_WDI, r
est store I2
outreg2 using PO_Table1.xls, append label

reg Happy Murdock_v42_Gatherer logGDPPerCap2019_WDI i.continent_factor, r
est store I3
outreg2 using PO_Table1.xls, append label keep (Happy Murdock_v42_Gatherer logGDPPerCap2019_WDI) addtext(Continent FE, YES)
		
reg Happy Murdock_v42_Gatherer logGDPPerCap2019_WDI $CONTROLHX, r
est store I4
outreg2 using PO_Table1.xls, append label 

reg Happy Murdock_v42_Gatherer logGDPPerCap2019_WDI $CONTROLHX i.continent_factor, r
est store I5
outreg2 using PO_Table1.xls, append label keep (Happy Murdock_v42_Gatherer logGDPPerCap2019_WDI $CONTROLHX) addtext(Continent FE, YES)


//Table 2:
reg Happy Murdock_v42_Hunter, r
est store I1
outreg2 using PO_Table2.xls, replace label

reg Happy Murdock_v42_Hunter logGDPPerCap2019_WDI, r
est store I2
outreg2 using PO_Table2.xls, append label

reg Happy Murdock_v42_Hunter logGDPPerCap2019_WDI i.continent_factor, r
est store I3
outreg2 using PO_Table2.xls, append label keep (Happy Murdock_v42_Hunter logGDPPerCap2019_WDI) addtext(Continent FE, YES)
		
reg Happy Murdock_v42_Hunter logGDPPerCap2019_WDI $CONTROLHX, r
est store I4
outreg2 using PO_Table2.xls, append label 

reg Happy Murdock_v42_Hunter logGDPPerCap2019_WDI $CONTROLHX i.continent_factor, r
est store I5
outreg2 using PO_Table2.xls, append label keep (Happy Murdock_v42_Hunter logGDPPerCap2019_WDI $CONTROLHX) addtext(Continent FE, YES)

//Table 3:
reg Happy Murdock_v42_HunterGatherer, r
est store I1
outreg2 using PO_Table3.xls, replace label

reg Happy Murdock_v42_HunterGatherer logGDPPerCap2019_WDI, r
est store I2
outreg2 using PO_Table3.xls, append label

reg Happy Murdock_v42_HunterGatherer logGDPPerCap2019_WDI i.continent_factor, r
est store I3
outreg2 using PO_Table3.xls, append label keep (Happy Murdock_v42_HunterGatherer logGDPPerCap2019_WDI) addtext(Continent FE, YES)
		
reg Happy Murdock_v42_HunterGatherer logGDPPerCap2019_WDI $CONTROLHX, r
est store I4
outreg2 using PO_Table3.xls, append label 

reg Happy Murdock_v42_HunterGatherer logGDPPerCap2019_WDI $CONTROLHX i.continent_factor, r
est store I5
outreg2 using PO_Table3.xls, append label keep (Happy Murdock_v42_HunterGatherer logGDPPerCap2019_WDI $CONTROLHX) addtext(Continent FE, YES)

//Table 4:
reg LifSat Murdock_v42_Gatherer, r
est store I1
outreg2 using PO_Table4.xls, replace label

reg LifSat Murdock_v42_Gatherer logGDPPerCap2019_WDI, r
est store I2
outreg2 using PO_Table4.xls, append label

reg LifSat Murdock_v42_Gatherer logGDPPerCap2019_WDI i.continent_factor, r
est store I3
outreg2 using PO_Table4.xls, append label keep (LifSat Murdock_v42_Gatherer logGDPPerCap2019_WDI) addtext(Continent FE, YES)
		
reg LifSat Murdock_v42_Gatherer logGDPPerCap2019_WDI $CONTROLHX, r
est store I4
outreg2 using PO_Table4.xls, append label 

reg LifSat Murdock_v42_Gatherer logGDPPerCap2019_WDI $CONTROLHX i.continent_factor, r
est store I5
outreg2 using PO_Table4.xls, append label keep (LifSat Murdock_v42_Gatherer logGDPPerCap2019_WDI $CONTROLHX) addtext(Continent FE, YES)



//***// Appendix Tables //***//
//Table S1: 
reg LifSat Murdock_v42_Hunter, r
est store I1
outreg2 using PO_TableS1.xls, replace label

reg LifSat Murdock_v42_Hunter logGDPPerCap2019_WDI, r
est store I2
outreg2 using PO_TableS1.xls, append label

reg LifSat Murdock_v42_Hunter logGDPPerCap2019_WDI i.continent_factor, r
est store I3
outreg2 using PO_TableS1.xls, append label keep (LifSat Murdock_v42_Hunter logGDPPerCap2019_WDI) addtext(Continent FE, YES)
		
reg LifSat Murdock_v42_Hunter logGDPPerCap2019_WDI $CONTROLHX, r
est store I4
outreg2 using PO_TableS1.xls, append label 

reg LifSat Murdock_v42_Hunter logGDPPerCap2019_WDI $CONTROLHX i.continent_factor, r
est store I5
outreg2 using PO_TableS1.xls, append label keep (LifSat Murdock_v42_Hunter logGDPPerCap2019_WDI $CONTROLHX) addtext(Continent FE, YES)


//Table S2: 
reg LifSat Murdock_v42_HunterGatherer, r
est store I1
outreg2 using PO_TableS2.xls, replace label

reg LifSat Murdock_v42_HunterGatherer logGDPPerCap2019_WDI, r
est store I2
outreg2 using PO_TableS2.xls, append label

reg LifSat Murdock_v42_HunterGatherer logGDPPerCap2019_WDI i.continent_factor, r
est store I3
outreg2 using PO_TableS2.xls, append label keep (LifSat Murdock_v42_HunterGatherer logGDPPerCap2019_WDI) addtext(Continent FE, YES)
		
reg LifSat Murdock_v42_HunterGatherer logGDPPerCap2019_WDI $CONTROLHX, r
est store I4
outreg2 using PO_TableS2.xls, append label 

reg LifSat Murdock_v42_HunterGatherer logGDPPerCap2019_WDI $CONTROLHX i.continent_factor, r
est store I5
outreg2 using PO_TableS2.xls, append label keep (LifSat Murdock_v42_HunterGatherer logGDPPerCap2019_WDI $CONTROLHX) addtext(Continent FE, YES)


//Table S3:
reg Happy Murdock_v42_Fishing, r
est store I1
outreg2 using PO_TableS3.xls, replace label

reg Happy Murdock_v42_Fishing logGDPPerCap2019_WDI, r
est store I2
outreg2 using PO_TableS3.xls, append label

reg Happy Murdock_v42_Fishing logGDPPerCap2019_WDI i.continent_factor, r
est store I3
outreg2 using PO_TableS3.xls, append label keep (Happy Murdock_v42_Fishing logGDPPerCap2019_WDI) addtext(Continent FE, YES)
		
reg Happy Murdock_v42_Fishing logGDPPerCap2019_WDI $CONTROLHX, r
est store I4
outreg2 using PO_TableS3.xls, append label 

reg Happy Murdock_v42_Fishing logGDPPerCap2019_WDI $CONTROLHX i.continent_factor, r
est store I5
outreg2 using PO_TableS3.xls, append label keep (Happy Murdock_v42_Fishing logGDPPerCap2019_WDI $CONTROLHX) addtext(Continent FE, YES)

//Table S4:
reg Happy Murdock_v42_FishHunterGatherer, r
est store I1
outreg2 using PO_TableS4.xls, replace label

reg Happy Murdock_v42_FishHunterGatherer logGDPPerCap2019_WDI, r
est store I2
outreg2 using PO_TableS4.xls, append label

reg Happy Murdock_v42_FishHunterGatherer logGDPPerCap2019_WDI i.continent_factor, r
est store I3
outreg2 using PO_TableS4.xls, append label keep (Happy Murdock_v42_FishHunterGatherer logGDPPerCap2019_WDI) addtext(Continent FE, YES)
		
reg Happy Murdock_v42_FishHunterGatherer logGDPPerCap2019_WDI $CONTROLHX, r
est store I4
outreg2 using PO_TableS4.xls, append label 

reg Happy Murdock_v42_FishHunterGatherer logGDPPerCap2019_WDI $CONTROLHX i.continent_factor, r
est store I5
outreg2 using PO_TableS4.xls, append label keep (Happy Murdock_v42_FishHunterGatherer logGDPPerCap2019_WDI $CONTROLHX) addtext(Continent FE, YES)

//Table S5: 
reg LifSat Murdock_v42_FishHunterGatherer, r
est store I1
outreg2 using PO_TableS5.xls, replace label

reg LifSat Murdock_v42_FishHunterGatherer logGDPPerCap2019_WDI, r
est store I2
outreg2 using PO_TableS5.xls, append label

reg LifSat Murdock_v42_FishHunterGatherer logGDPPerCap2019_WDI i.continent_factor, r
est store I3
outreg2 using PO_TableS5.xls, append label keep (LifSat Murdock_v42_FishHunterGatherer logGDPPerCap2019_WDI) addtext(Continent FE, YES)
		
reg LifSat Murdock_v42_FishHunterGatherer logGDPPerCap2019_WDI $CONTROLHX, r
est store I4
outreg2 using PO_TableS5.xls, append label 

reg LifSat Murdock_v42_FishHunterGatherer logGDPPerCap2019_WDI $CONTROLHX i.continent_factor, r
est store I5
outreg2 using PO_TableS5.xls, append label keep (LifSat Murdock_v42_FishHunterGatherer logGDPPerCap2019_WDI $CONTROLHX) addtext(Continent FE, YES)



//***// Descriptive Statistics //***//
sum Murdock_v42_Gatherer
sum Murdock_v42_Hunter
sum Murdock_v42_HunterGatherer
