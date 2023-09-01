libname qr "C:\Users\aylescupidez\Box\QR CURRENT\NATURE COMMS RESUBMISSION\FINAL AUG 2023 QR\CODE SUBMISSION"; 

/* Required data for QR computation at minimum are: 
		Baseline and 1 year C-peptide  AUC mean (nmol/L) from 2 hour mixed meal tolerance test
		Age in years
	  Input QR dataset should also include:
		treatment group 
		study if doing cross-study comparisons */

data QR_input; 
	set qr.test_QR_input;
	run; 

data test_qr_output;
	set QR_input; 

		/* calculate the model-predicted values from the Bundy et al published QR model equation */
		/* published model is for 1 year; the predicted C-peptide values are log(x+1) transformed */ 
		expectedy1_meanAUC_nmoll = -0.191 + 0.812*log(baseline_mean_cpep_AUC_nmoll+1) +0.00638*Age_At_Screening;
		 
		/* since the published QR model is an ANCOVA linear model, we can extrapolate predicted values at other timepoints */
		/* for example 6 months is halfway between baseline and 1 year
			so we can determine predicted 6 months = (predicted 1 year C-peptide - baseline C-peptide) / 2 + baseline C-peptide*/
		expectedmo3_meanAUC_nmoll = ((-0.191 + 0.812*log(baseline_mean_cpep_AUC_nmoll+1) + 0.00638*Age_At_Screening) - log(baseline_mean_cpep_AUC_nmoll+1))/4 + log(baseline_mean_cpep_AUC_nmoll+1) ;
		expectedmo6_meanAUC_nmoll = ((-0.191 + 0.812*log(baseline_mean_cpep_AUC_nmoll+1) + 0.00638*Age_At_Screening) - log(baseline_mean_cpep_AUC_nmoll+1))/2 + log(baseline_mean_cpep_AUC_nmoll+1) ;
		expectedmo9_meanAUC_nmoll = ((-0.191 + 0.812*log(baseline_mean_cpep_AUC_nmoll+1) + 0.00638*Age_At_Screening) - log(baseline_mean_cpep_AUC_nmoll+1))*(3/4) + log(baseline_mean_cpep_AUC_nmoll+1) ;

		expectedmo18_meanAUC_nmoll = ((-0.191 + 0.812*log(baseline_mean_cpep_AUC_nmoll+1) + 0.00638*Age_At_Screening) - log(baseline_mean_cpep_AUC_nmoll+1))*(3/2) + log(baseline_mean_cpep_AUC_nmoll+1) ;
		expectedmo24_meanAUC_nmoll = ((-0.191 + 0.812*log(baseline_mean_cpep_AUC_nmoll+1) + 0.00638*Age_At_Screening) - log(baseline_mean_cpep_AUC_nmoll+1))*(2) + log(baseline_mean_cpep_AUC_nmoll+1) ;
		expectedmo30_meanAUC_nmoll = ((-0.191 + 0.812*log(baseline_mean_cpep_AUC_nmoll+1) + 0.00638*Age_At_Screening) - log(baseline_mean_cpep_AUC_nmoll+1))*(5/2) + log(baseline_mean_cpep_AUC_nmoll+1) ;
		expectedmo36_meanAUC_nmoll = ((-0.191 + 0.812*log(baseline_mean_cpep_AUC_nmoll+1) + 0.00638*Age_At_Screening) - log(baseline_mean_cpep_AUC_nmoll+1))*(3) + log(baseline_mean_cpep_AUC_nmoll+1) ;
		 
		/* raw C-peptide AUC mean values at all timepoints */
		array mean_cpep_auc (9) 
		baseline_mean_cpep_auc_nmoll
		mo3_mean_cpep_auc_nmoll
		mo6_mean_cpep_auc_nmoll 
		mo9_mean_cpep_auc_nmoll
		year1_mean_cpep_auc_nmoll
		mo18_mean_cpep_auc_nmoll
		mo24_mean_cpep_auc_nmoll
		mo30_mean_cpep_auc_nmoll
		mo36_mean_cpep_auc_nmoll;

		/* for log raw C-peptide AUC mean values (log (x+1)) at all timepoints */ 
		array mean_cpep_auc_ln (9) 
		baseline_mean_cpep_auc_ln_nmoll 
		mo3_mean_cpep_auc_ln_nmoll
		mo6_mean_cpep_auc_ln_nmoll
		mo9_mean_cpep_auc_ln_nmoll
		year1_mean_cpep_auc_ln_nmoll
		mo18_mean_cpep_auc_ln_nmoll
		mo24_mean_cpep_auc_ln_nmoll
		mo30_mean_cpep_auc_ln_nmoll
		mo36_mean_cpep_auc_ln_nmoll;

		/* calculate log of C-peptide AUC mean at each timepoint */ 
		do i = 1 to 9; 
		mean_cpep_auc_ln(i) = log(mean_cpep_auc(i)+1); 
		end; 
		drop i; 

		/* compute QR as described in Bundy et al paper (e.g., observed - predicted C-peptide), where values are log-transformed */ 
		QR_meanAUC_nmoll = log(year1_mean_cpep_auc_nmoll+1)- expectedy1_meanAUC_nmoll;

		QR3m_meanAUC_nmoll = log(mo3_mean_cpep_auc_nmoll+1) - expectedmo3_meanAUC_nmoll; 
		QR6m_meanAUC_nmoll = log(mo6_mean_cpep_auc_nmoll+1) - expectedmo6_meanAUC_nmoll; 
		QR9m_meanAUC_nmoll = log(mo9_mean_cpep_auc_nmoll+1) - expectedmo9_meanAUC_nmoll; 
		QR18m_meanAUC_nmoll = log(mo18_mean_cpep_auc_nmoll+1) - expectedmo18_meanAUC_nmoll; 
		QR24m_meanAUC_nmoll = log(mo24_mean_cpep_auc_nmoll+1) - expectedmo24_meanAUC_nmoll; 
		QR30m_meanAUC_nmoll = log(mo30_mean_cpep_auc_nmoll+1) - expectedmo30_meanAUC_nmoll; 
		QR36m_meanAUC_nmoll = log(mo36_mean_cpep_auc_nmoll+1) - expectedmo36_meanAUC_nmoll; 

		/* for binary variables (character and numeric) derived from QR */
		/* positive QR indicates responders (better-than-expected) and negative QR indicates non-responders (worse-than-expected) */
			 if . < QR_meanAUC_nmoll < 0 then Resp_Nonresp_QR_meanAUC = "Non-Responder (QR <0)"; 
		else if     QR_meanAUC_nmoll>= 0 then Resp_Nonresp_QR_meanAUC = "Responder (QR >=0)";
		else if    QR_meanAUC_nmoll = . then Resp_Nonresp_QR_meanAUC = "";

			 if . < QR_meanAUC_nmoll < 0 then Resp_Nonresp_QR_meanAUC_01 = 0; 
		else if     QR_meanAUC_nmoll>= 0 then Resp_Nonresp_QR_meanAUC_01 = 1;
		else if    QR_meanAUC_nmoll = . then Resp_Nonresp_QR_meanAUC_01 = .;

		/* weighted so that active and placebo participants
			   are equally represented in producing probability curves. 
			   For example proportion placebo = 0.659 and proportion active = 0.340
			   then weight for placebo = 1 and weight for active = 0.659/0.340 = 1.938235 */ 
		if active_or_placebo eq "Active" then Weight = 1.938235; 
		else if active_or_placebo eq "Placebo" then Weight = 1; 
		else Weight = . ; 

		label
				Resp_Nonresp_QR_meanAUC = "QR Responder or Non-Responder"
				Resp_Nonresp_QR_meanAUC_01 = "Responder (QR >=0)"

				QR_meanAUC_nmoll = "QR" /* QR generally refers to 1 year */ 
				QR3m_meanAUC_nmoll = "3 Month QR"
				QR6m_meanAUC_nmoll = "6 Month QR"
				QR9m_meanAUC_nmoll = "9 Month QR"
				QR18m_meanAUC_nmoll = "18 Month QR"
				QR24m_meanAUC_nmoll = "24 Month QR"
				QR30m_meanAUC_nmoll = "30 Month QR"
				QR36m_meanAUC_nmoll = "36 Month QR"

				baseline_mean_cpep_auc_nmoll = "Baseline C-peptide AUC Mean (nmol/L)"
				year1_mean_cpep_auc_nmoll = "1 Year C-peptide AUC Mean (nmol/L)"
				mo3_mean_cpep_auc_nmoll = "3 Month C-peptide AUC Mean (nmol/L)"
				mo6_mean_cpep_auc_nmoll = "6 Month C-peptide AUC Mean (nmol/L)"
				mo9_mean_cpep_auc_nmoll = "9 Month C-peptide AUC Mean (nmol/L)" 
				mo18_mean_cpep_auc_nmoll = "18 Month C-peptide AUC Mean (nmol/L)" 
				mo24_mean_cpep_auc_nmoll = "24 Month C-peptide AUC Mean (nmol/L)" 
				mo30_mean_cpep_auc_nmoll = "30 Month C-peptide AUC Mean (nmol/L)" 
				mo36_mean_cpep_auc_nmoll = "36 Month C-peptide AUC Mean (nmol/L)" 

				baseline_mean_cpep_auc_ln_nmoll = "Baseline C-peptide AUC Mean (nmol/L) ln(x+1)"
				year1_mean_cpep_auc_ln_nmoll = "1 Year C-peptide AUC Mean (nmol/L) ln(x+1)"
				mo3_mean_cpep_auc_ln_nmoll = "3 Month C-peptide AUC Mean (nmol/L) ln(x+1)"
				mo6_mean_cpep_auc_ln_nmoll = "6 Month C-peptide AUC Mean (nmol/L) ln(x+1)"
				mo9_mean_cpep_auc_ln_nmoll = "9 Month C-peptide AUC Mean (nmol/L) ln(x+1)"
				mo18_mean_cpep_auc_ln_nmoll = "18 Month C-peptide AUC Mean (nmol/L) ln(x+1)"
				mo24_mean_cpep_auc_ln_nmoll = "24 Month C-peptide AUC Mean (nmol/L) ln(x+1)"
				mo30_mean_cpep_auc_ln_nmoll = "30 Month C-peptide AUC Mean (nmol/L) ln(x+1)"
				mo36_mean_cpep_auc_ln_nmoll = "36 Month C-peptide AUC Mean (nmol/L) ln(x+1)"

				expectedmo3_meanAUC_nmoll = "Expected 3 Month C-peptide AUC Mean (nmol/L) ln(x+1)" 
				expectedmo6_meanAUC_nmoll = "Expected 6 Month C-peptide AUC Mean (nmol/L) ln(x+1)" 
				expectedmo9_meanAUC_nmoll = "Expected 9 Month C-peptide AUC Mean (nmol/L) ln(x+1)" 
				expectedy1_meanAUC_nmoll = "Expected 1 Year C-peptide AUC Mean (nmol/L) ln(x+1)" 
				expectedmo18_meanAUC_nmoll = "Expected 18 Month C-peptide AUC Mean (nmol/L) ln(x+1)" 
				expectedmo24_meanAUC_nmoll = "Expected 24 Month C-peptide AUC Mean (nmol/L) ln(x+1)" 
				expectedmo30_meanAUC_nmoll = "Expected 30 Month C-peptide AUC Mean (nmol/L) ln(x+1)" 
				expectedmo36_meanAUC_nmoll = "Expected 36 Month C-peptide AUC Mean (nmol/L) ln(x+1)" 	;
		run;

data qr. test_qr_output; 
	set test_qr_output; 
	run; 

/* export JMP format to run JSL scripts */
proc export data = test_QR_output 
	outfile = "C:\Users\aylescupidez\Box\QR CURRENT\NATURE COMMS RESUBMISSION\FINAL AUG 2023 QR\CODE SUBMISSION\test_QR_output.jmp" label
	dbms = JMP REPLACE; 
	run;  

/* this macro fits generalized linear models to placebo participants such that OUTCOME C-PEPTIDE = BASELINE C-PEPTIDE + AGE */ 
/* models use other timepoints of interest as baseline and predicted outcome timepoints (i.e., baseline 3, 6, 9 months, etc.; outcome 6, 9, 12, 18 months, etc)  */ 
/* PARAMETERS: &pred is the covariate/predictive timepoint, and 
									&out is the outcome we want to predict  - corresponding to ln+1 cpeptide at timepoint of interest */ 
/* ACCEPTABLE VALUES: acceptable values for &pred and &out are
												baseline, 1year, mo3, mo6, mo9, mo18, mo24, mo30, mo36 */
%macro fitancova(pred, out); 

	/* fit model ONLY in placebo, including only age and c-peptide as covariates */  
	proc glm data = test_QR_output(where = (Active_or_Placebo = "Placebo" )); 
		model &out._mean_cpep_auc_ln_nmoll = &pred._mean_cpep_auc_ln_nmoll Age_At_Screening  / solution p clparm; 
		output out = anc_plb_&pred._&out. p = &out._pred_meanauc_nmoll_plb; 
		ods output parameterestimates = est_ci_&pred._&out._plb fitstatistics = rsq_&pred._&out._plb_0; 
		quit; 

	data rsq_&pred._&out._plb_1; 
		set rsq_&pred._&out._plb_0; 
		format predictor outcome $20. ; 
		predictor = "&pred"; 
		outcome = "&out"; 
		run; 

	/* select age coefficient into a macro variable to plug into equation and calculate expected cpep */ 
	proc sql noprint; 
		select estimate into :ageb_plb
		from est_ci_&pred._&out._plb
		where find(parameter, "age", "i"); 
		quit; 
		%put age coeff &ageb_plb; 

	/* select c-pep coefficient into a macro variable to plug into equation and calculate expected cpep */ 
	proc sql noprint; 
		select estimate into :pepb_plb
		from est_ci_&pred._&out._plb
		where find(parameter, "pep", "i") ; 
		quit; 
		%put cpep coeff &pepb_plb; 
		
	/* select intercept into a macro variable to plug into equation and calculate expected cpep */ 
	proc sql noprint; 
		select estimate into :int_plb 
		from est_ci_&pred._&out._plb
		where find(parameter, "intercept", "i") ; 
		quit; 
		%put intercept  &int_plb; 

	/* NOTE expected cpep v2 corresponds to ln+1 transformed cpep and is calculated from estimates 
		in model fit to PLACEBO ONLY */ 
	data adj_pep_&pred._&out._0; 
		set test_QR_output(keep = Active_or_placebo study Participant_ID Age_At_Screening &out._mean_cpep_auc_nmoll  &out._mean_cpep_auc_ln_nmoll  &pred._mean_cpep_auc_nmoll); 
		&pred._adj_&out._mAUC_nmoll_ln = &int_plb + (&pepb_plb* (log(&pred._mean_cpep_auc_nmoll + 1)))  + (&ageb_plb*Age_At_Screening); 
		QR_&pred._&out. =  log(&out._mean_cpep_auc_nmoll + 1) - &pred._adj_&out._mAUC_nmoll_ln;
	
		format age_coeff cpep_coeff intercept BEST12. ; 
		age_coeff = &ageb_plb; 
		cpep_coeff = &pepb_plb; 
		intercept = &int_plb;  

		label 	QR_&pred._&out. = "New &out QR, &pred Adjusted"
					&pred._adj_&out._mAUC_nmoll_ln = "&pred Adjusted Mean C-pep AUC (nmol/L) at &out (log(x+1))"
					age_coeff = "Age Coefficient"
					cpep_coeff = "C-Peptide Coefficient"
					intercept = "Intercept";
		run; 

%mend fitancova; 


/* fit ANCOVA models with specified baseline and outcome timepoints */
/* the first model %fitancova(Baseline, Year1) corresponds to the 'Revised ANCOVA model', 
	and fits an ANCOVA model to the dataset following the exact same methodology as done for the original QR model */ 
%fitancova(Baseline, Year1); 
%fitancova(Baseline, Mo3); 
%fitancova(Baseline, Mo6); 
%fitancova(Baseline, Mo18); 
%fitancova(Baseline, Mo24); 
%fitancova(Mo3, Mo6); 
%fitancova(Mo3, Year1);
%fitancova(Mo3, Mo18);
%fitancova(Mo3, Mo24);
%fitancova(Mo6, Year1); 
%fitancova(Mo6, Mo18); 
%fitancova(Mo6, Mo24); 
%fitancova(Year1, Mo18); 
%fitancova(Year1, Mo24); 
%fitancova(Mo18, Mo24);


/* compile output Rsquare for pred & outcomes */ 
data rsquare; 
	set Rsq_Baseline_Year1_plb_1
		Rsq_Baseline_Mo3_plb_1
		Rsq_Baseline_Mo6_plb_1
		Rsq_Baseline_Mo18_plb_1
		Rsq_Baseline_Mo24_plb_1
		Rsq_Mo3_Mo6_plb_1
		Rsq_Mo3_Year1_plb_1
		Rsq_Mo3_Mo18_plb_1
		Rsq_Mo3_Mo24_plb_1
		Rsq_Mo6_Year1_plb_1
		Rsq_Mo6_Mo18_plb_1
		Rsq_Mo6_Mo24_plb_1
		Rsq_Year1_Mo18_plb_1
		Rsq_Year1_Mo24_plb_1
		Rsq_Mo18_Mo24_plb_1;

	/* prednum and outnum are numeric variables 
		for timepoints, and useful for ordering records */
	if predictor = "Baseline" then prednum = -1; 
	if predictor = "Mo3" then prednum = 3; 
	if predictor = "Mo6" then prednum = 6; 
	if predictor = "Year1" then prednum = 12; 
	if predictor = "Mo18" then prednum = 18; 
	if predictor = "Mo24" then prednum = 24; 

	if outcome = "Baseline" then outnum = -1; 
	if outcome = "Mo3" then outnum = 3; 
	if outcome = "Mo6" then outnum = 6; 
	if outcome = "Year1" then outnum = 12; 
	if outcome = "Mo18" then outnum = 18; 
	if outcome = "Mo24" then outnum = 24; 
run; 

/* t-test to determine treatment effect using QR */ 
/* where treatment effect is just the difference between treatment groups, Active - Placebo */
/* pooled method assuming equal variances since QR is standardized metric */
proc ttest data = test_QR_output alpha = 0.05; 
	class active_or_placebo;
	by study; 
	var QR_meanAUC_nmoll ; /* could use computed QR at other timepoints here also to determine treatment effect at other timepoints */ 
	ods output ttests = tt2 statistics = st2 ; 
	run; 

