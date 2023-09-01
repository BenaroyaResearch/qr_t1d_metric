This information is also in the readme.docx file

# Submission of code and test data for publication 
This file includes documentation relevant to code and test data submitted in association with the manuscript entitled “A Standardized Metric to Enhance Clinical Trial Design and Outcome Interpretation in Type 1 Diabetes” (2023), authored by Alyssa Ylescupidez, Henry T Bahnson, Colin O’Rourke, Sandra Lord, Cate Speake, Carla J Greenbaum at the Center for Interventional Immunology, Benaroya Research Institute at Virginia Mason; Seattle, WA, USA. 

Software required to run enclosed codes are JMP Pro 16 (SAS Institute Inc., Cary, NC, USA) and SAS software version 9.4 (SAS Institute Inc., Cary, NC, USA). Run time dependent on size of dataset; using test data run time of all code <1 minute. 

# Table 1. Contents of code and test data submission folder. 
Type	File name	File type	Description 
Code	SAS script for QR calculations	.sas	SAS script for computing QR and relevant analyses.
Code	JMP JSL script for GLM	.jsl	JSL script for fitting generalized linear models.
Data	test_qr_input	.sas7bdat	Example of input data needed to run SAS script.
Data	test_qr_output	.sas7bdat	Example of output data after running SAS code to compute predicted C-peptide and QR values.
Data	test_qr_output	.jmp	Converted test_qr_output.sas7bdat file to JMP format for JSL script to be run. The .jmp file also has JSL script saved to table: RUN GLM. 
 
# Table 2. Metadata for test_qr_input.sas7bdat, input data required to run SAS script. 
Variable Name	Variable Label	Variable Type*	Variable Length	Variable Number
study	 Study 	2	5	1
Participant_id	 Participant_ID	2	5	2
active_or_placebo	Active Treatment or Placebo Group	2	7	3
Age_at_screening	Baseline Age (years)	1	8	4
baseline_mean_cpep_auc_nmoll	Baseline C-peptide AUC Mean (nmol/L)	1	8	5
year1_mean_cpep_auc_nmoll	1 Year C-peptide AUC Mean (nmol/L)	1	8	6
mo3_mean_cpep_auc_nmoll	3 Month C-peptide AUC Mean (nmol/L)	1	8	7
mo6_mean_cpep_auc_nmoll	6 Month C-peptide AUC Mean (nmol/L)	1	8	8
mo9_mean_cpep_auc_nmoll	9 Month C-peptide AUC Mean (nmol/L)	1	8	9
mo18_mean_cpep_auc_nmoll	18 Month C-peptide AUC Mean (nmol/L)	1	8	10
mo24_mean_cpep_auc_nmoll	24 Month C-peptide AUC Mean (nmol/L)	1	8	11
mo30_mean_cpep_auc_nmoll	30 Month C-peptide AUC Mean (nmol/L)	1	8	12
mo36_mean_cpep_auc_nmoll	36 Month C-peptide AUC Mean (nmol/L)	1	8	13
*Variable Type 1 = numeric, 2 = character.  
Table 3. Metadata for test_qr_output.sas7bdat, output dataset from running SAS script.  
Variable Name	Variable Label	Variable	Variable	Variable
		Type*	Length	Number
study	 Study	2	5	1
Participant_id	 Participant_ID	2	5	2
active_or_placebo	Active Treatment or Placebo Group	2	7	3
Age_at_screening	Baseline Age (years)	1	8	4
baseline_mean_cpep_auc_nmoll	Baseline C-peptide AUC Mean (nmol/L)	1	8	5
year1_mean_cpep_auc_nmoll	1 Year C-peptide AUC Mean (nmol/L)	1	8	6
mo3_mean_cpep_auc_nmoll	3 Month C-peptide AUC Mean (nmol/L)	1	8	7
mo6_mean_cpep_auc_nmoll	6 Month C-peptide AUC Mean (nmol/L)	1	8	8
mo9_mean_cpep_auc_nmoll	9 Month C-peptide AUC Mean (nmol/L)	1	8	9
mo18_mean_cpep_auc_nmoll	18 Month C-peptide AUC Mean (nmol/L)	1	8	10
mo24_mean_cpep_auc_nmoll	24 Month C-peptide AUC Mean (nmol/L)	1	8	11
mo30_mean_cpep_auc_nmoll	30 Month C-peptide AUC Mean (nmol/L)	1	8	12
mo36_mean_cpep_auc_nmoll	36 Month C-peptide AUC Mean (nmol/L)	1	8	13
expectedy1_meanAUC_nmoll	Expected 1 Year C-peptide AUC Mean (nmol/L) ln(x+1)	1	8	14
expectedmo3_meanAUC_nmoll	Expected 3 Month C-peptide AUC Mean (nmol/L) ln(x+1)	1	8	15
expectedmo6_meanAUC_nmoll	Expected 6 Month C-peptide AUC Mean (nmol/L) ln(x+1)	1	8	16
expectedmo9_meanAUC_nmoll	Expected 9 Month C-peptide AUC Mean (nmol/L) ln(x+1)	1	8	17
expectedmo18_meanAUC_nmoll	Expected 18 Month C-peptide AUC Mean (nmol/L) ln(x+1)	1	8	18
expectedmo24_meanAUC_nmoll	Expected 24 Month C-peptide AUC Mean (nmol/L) ln(x+1)	1	8	19
expectedmo30_meanAUC_nmoll	Expected 30 Month C-peptide AUC Mean (nmol/L) ln(x+1)	1	8	20
expectedmo36_meanAUC_nmoll	Expected 36 Month C-peptide AUC Mean (nmol/L) ln(x+1)	1	8	21
baseline_mean_cpep_auc_ln_nmoll	Baseline C-peptide AUC Mean (nmol/L) ln(x+1)	1	8	22
mo3_mean_cpep_auc_ln_nmoll	3 Month C-peptide AUC Mean (nmol/L) ln(x+1)	1	8	23
mo6_mean_cpep_auc_ln_nmoll	6 Month C-peptide AUC Mean (nmol/L) ln(x+1)	1	8	24
mo9_mean_cpep_auc_ln_nmoll	9 Month C-peptide AUC Mean (nmol/L) ln(x+1)	1	8	25
year1_mean_cpep_auc_ln_nmoll	1 Year C-peptide AUC Mean (nmol/L) ln(x+1)	1	8	26
mo18_mean_cpep_auc_ln_nmoll	18 Month C-peptide AUC Mean (nmol/L) ln(x+1)	1	8	27
mo24_mean_cpep_auc_ln_nmoll	24 Month C-peptide AUC Mean (nmol/L) ln(x+1)	1	8	28
mo30_mean_cpep_auc_ln_nmoll	30 Month C-peptide AUC Mean (nmol/L) ln(x+1)	1	8	29
mo36_mean_cpep_auc_ln_nmoll	36 Month C-peptide AUC Mean (nmol/L) ln(x+1)	1	8	30
QR_meanAUC_nmoll	QR	1	8	31
QR3m_meanAUC_nmoll	3 Month QR	1	8	32
QR6m_meanAUC_nmoll	6 Month QR	1	8	33
QR9m_meanAUC_nmoll	9 Month QR	1	8	34
QR18m_meanAUC_nmoll	18 Month QR	1	8	35
QR24m_meanAUC_nmoll	24 Month QR	1	8	36
QR30m_meanAUC_nmoll	30 Month QR	1	8	37
QR36m_meanAUC_nmoll	36 Month QR	1	8	38
Resp_Nonresp_QR_meanAUC	QR Responder or Non-Responder	2	21	39
Resp_Nonresp_QR_meanAUC_01	Responder (QR >=0)	1	8	40
Weight		1	8	41
*Variable Type 1 = numeric, 2 = character.
