#' @title Nursing Workforce Survey Data
#'
#' @description This dataset is a subset of the National Sample Survey of Registered Nurses and
#' the National Sample Survey of Nurse Practitioners. A random sample of 5,000 records was
#' selected from the Registered Nurses Sample (2008 SPSS Format) for use with this package. 
#' For more information about the Nursing Workforce Survey Dataset, visit
#' https://data.hrsa.gov/topics/health-workforce/nchwa/nursing-workforce-survey-data.
#'
#' @format A tibble with 5,000 rows and 865 columns:
#' \describe{
#' \item{Q1}{Actively licensed RN}
#' \item{Q2STATE}{State of first RN license}
#' \item{Q2YEAR}{Year of first RN license}
#' \item{Q4MONTH}{Month graduated initial RN ed program}
#' \item{Q4YEAR}{Year graduated initial RN ed program}
#' \item{Q5STATE}{State initial RN ed program located}
#' \item{Q5COU}{Country initial RN ed program located}
#' \item{Q6_0}{No degree prior to RN ed program}
#' \item{Q6_1}{AD prior to RN ed program}
#' \item{Q6_2}{Bachelor's prior to RN ed program}
#' \item{Q6_3}{Master's prior to RN ed program}
#' \item{Q6_4}{Doctorate prior to RN ed program}
#' \item{Q6_5}{Other degree prior to RN ed program}
#' \item{Q7}{Field for highest degree before RN ed}
#' \item{Q8}{Licensed LPN/LVN}
#' \item{Q9_0}{No health-related position before RN ed}
#' \item{Q9_1}{Nursing Aide/Asst before RN ed}
#' \item{Q9_2}{Home health aide/asst before RN ed}
#' \item{Q9_3}{LPN/LVN before RN ed}
#' \item{Q9_4}{EMT before RN ed}
#' \item{Q9_5}{Medical asst before RN ed}
#' \item{Q9_6}{Dental asst before RN ed}
#' \item{Q9_7}{Allied Health/Lab tech before RN ed}
#' \item{Q9_8}{Health care manager before RN ed}
#' \item{Q9_9}{Health care clerk before RN ed}
#' \item{Q9_10}{Military med corps before RN ed}
#' \item{Q9_11}{MD before RN ed}
#' \item{Q9_12}{Midwife before RN ed}
#' \item{Q9_13}{Other health-related position before RN ed}
#' \item{Q10_1}{Financed initial RN ed - Health-related employment}
#' \item{Q10_2}{Financed initial RN ed - Nonhealth-related employment}
#' \item{Q10_3}{Financed initial RN ed - Other household members}
#' \item{Q10_4}{Financed initial RN ed - Personal savings}
#' \item{Q10_5}{Financed initial RN ed - Other family resources}
#' \item{Q10_6}{Financed initial RN ed - Employer tuition reimbursement}
#' \item{Q10_7}{Financed initial RN ed - Federal scholarship/grant}
#' \item{Q10_8}{Financed initial RN ed - Federal assisted loan}
#' \item{Q10_9}{Financed initial RN ed - Other loan}
#' \item{Q10_10}{Financed initial RN ed - State/local gov't scholarship/grant}
#' \item{Q10_11}{Financed initial RN ed - Non-gov't scholarship/grant}
#' \item{Q10_12}{Financed initial RN ed - Other resources}
#' \item{Q11A_0}{No emergency preparedness training received/provided}
#' \item{Q11A_1}{Training received/provided - Chemical accident/attack}
#' \item{Q11A_2}{Training received/provided - Nuclear/radiological accident/attack}
#' \item{Q11A_3}{Training received/provided - Infectious disease epidemics}
#' \item{Q11A_4}{Training received/provided - Biological accident/attack}
#' \item{Q11A_5}{Training received/provided - Natural disaster}
#' \item{Q11A_6}{Training received/provided - Other public health emergencies}
#' \item{Q11BREC}{Total number of training hours received}
#' \item{Q11BPROV}{Total number of training hours provided}
#' \item{Q11C}{Best prepared emergency area}
#' \item{Q12}{Know disaster/emergency plan at work}
#' \item{Q13}{Additional degrees after RN program}
#' \item{Q14}{Completed APRN program}
#' \item{Q14A_A}{Prepared as NP}
#' \item{Q14B_A}{NP program length}
#' \item{Q14C_A}{Highest NP program credential}
#' \item{Q14D_A}{Year received NP credential}
#' \item{Q14E_A}{NP certification national org}
#' \item{Q14E2_A}{NP certification required for job}
#' \item{Q14F_A}{NP State Board license/recognition}
#' \item{Q14F2_A}{NP State Board license/recognition required for job}
#' \item{Q14A_B}{Prepared as CNS}
#' \item{Q14B_B}{CNS program length}
#' \item{Q14C_B}{Highest CNS program credential}
#' \item{Q14D_B}{Year received CNS credential}
#' \item{Q14E_B}{CNS certification national org}
#' \item{Q14E2_B}{CNS certification required for job}
#' \item{Q14F_B}{CNS State Board license/recognition}
#' \item{Q14F2_B}{CNS State Board license/recognition  required for job}
#' \item{Q14A_C}{Prepared as NM}
#' \item{Q14B_C}{NM program length}
#' \item{Q14C_C}{Highest NM program credential}
#' \item{Q14D_C}{Year received NM credential}
#' \item{Q14E_C}{NM certification national org}
#' \item{Q14E2_C}{NM certification required for job}
#' \item{Q14F_C}{NM State Board license/recognition}
#' \item{Q14F2_C}{NM Sate Board license/recognition  required for job}
#' \item{Q14A_D}{Prepared as NA}
#' \item{Q14B_D}{NA program length}
#' \item{Q14C_D}{Highest NA program credential}
#' \item{Q14D_D}{Year received NA credential}
#' \item{Q14E_D}{NA certification national org}
#' \item{Q14E2_D}{NA certification required for job}
#' \item{Q14F_D}{NA State Board license/recognition}
#' \item{Q14F2_D}{NA State Board license/recognition  required for job}
#' \item{Q15}{Currently enrolled in formal ed program 2008}
#' \item{Q16}{Type of formal ed program 2008}
#' \item{Q17A}{FT/PT student 2008}
#' \item{Q17B}{Percent distance-based courses 2008}
#' \item{Q18}{Type of degree/certificate 2008}
#' \item{Q19}{Currently employed in nursing 2008}
#' \item{Q20}{Active RN license required}
#' \item{Q21STATE}{State principal RN position}
#' \item{Q22}{Principal RN position type 2008}
#' \item{Q23}{Principal RN position setting 2008}
#' \item{Q24}{Principal RN job title 2008}
#' \item{Q25}{FT/PT principal RN position in 2008}
#' \item{Q26}{Months worked principal RN position 2008}
#' \item{Q27A}{Number hours worked}
#' \item{Q27B}{Number on-call hours}
#' \item{Q27C}{Number overtime hours}
#' \item{Q27D}{Number mandatory overtime hours}
#' \item{Q27E}{Number paid/unpaid stand-by hours}
#' \item{Q27F}{Number hours paid stand-by rate}
#' \item{Q28A}{Percent patient care & charting}
#' \item{Q28B}{Percent non-nursing tasks}
#' \item{Q28C}{Percent consultation}
#' \item{Q28D}{Percent supervision & management}
#' \item{Q28E}{Percent administration}
#' \item{Q28F}{Percent research}
#' \item{Q28G}{Percent teaching, orientating students}
#' \item{Q28H}{Percent other activities}
#' \item{Q29A_1}{Level of care - General/specialty inpatient}
#' \item{Q29A_2}{Level of care - Critical/intensive care}
#' \item{Q29A_3}{Level of care - Step down, transitional care}
#' \item{Q29A_4}{Level of care - Sub-acute care}
#' \item{Q29A_5}{Level of care - Emergency care}
#' \item{Q29A_6}{Level of care - Urgent care}
#' \item{Q29A_7}{Level of care -Rehabilitation}
#' \item{Q29A_8}{Level of care - Long-term care}
#' \item{Q29A_9}{Level of care - Surgery}
#' \item{Q29A_10}{Level of care - Ambulatory care}
#' \item{Q29A_11}{Level of care - Ancillary care}
#' \item{Q29A_12}{Level of care - Home health}
#' \item{Q29A_13}{Level of care - Public health}
#' \item{Q29A_14}{Level of care - Education}
#' \item{Q29A_15}{Level of care  - Business}
#' \item{Q29A_16}{Level of care - Research}
#' \item{Q29A_17}{Level of care - Other specify}
#' \item{Q29B}{Primary patient population}
#' \item{Q29C_1}{No patient care principal position}
#' \item{Q29C_2}{Clinical specialty - General surgery}
#' \item{Q29C_3}{Clinical specialty - Critical care}
#' \item{Q29C_4}{Clinical specialty - Cardiac care}
#' \item{Q29C_5}{Clinical specialty - Chronic care}
#' \item{Q29C_6}{Clinical specialty - Dermatology}
#' \item{Q29C_7}{Clinical specialty - Emergency/trauma}
#' \item{Q29C_8}{Clinical specialty - Gastrointestinal}
#' \item{Q29C_9}{Clinical specialty - Gynecology}
#' \item{Q29C_10}{Clinical specialty - Hospice}
#' \item{Q29C_11}{Clinical specialty - Infectious disease}
#' \item{Q29C_12}{Clinical specialty - Labor & delivery}
#' \item{Q29C_13}{Clinical specialty - Neurological}
#' \item{Q29C_14}{Clinical specialty - Obstetrics}
#' \item{Q29C_15}{Clinical specialty - Occupational health}
#' \item{Q29C_16}{Clinical specialty - Oncology}
#' \item{Q29C_17}{Clinical specialty - Primary care}
#' \item{Q29C_18}{Clinical specialty - Psychiatric/mental health}
#' \item{Q29C_19}{Clinical specialty - Pulmonary/respiratory}
#' \item{Q29C_20}{Clinical specialty - Radiology}
#' \item{Q29C_21}{Clinical specialty - Renal/dialysis}
#' \item{Q29C_22}{Clinical specialty - No specific area}
#' \item{Q29C_23}{Clinical specialty - Other specialty}
#' \item{Q30}{Pre-tax earnings principal RN position 2008}
#' \item{Q31}{Represented by labor union 2008}
#' \item{Q32A}{Intentions regarding principal RN position}
#' \item{Q32B}{Plans to remain in nursing profession}
#' \item{Q33}{Hold other paid RN positions 2008}
#' \item{Q34_1}{Secondary RN position - Employee at org/facility}
#' \item{Q34_2}{Secondary RN position - Employed thru employment agency}
#' \item{Q34_3}{Secondary RN position - Employed as traveling nurse}
#' \item{Q34_4}{Secondary RN position - Self-employed, working as-needed}
#' \item{Q35_1}{Secondary RN position - Hospital setting}
#' \item{Q35_2}{Secondary RN position - Nursing home/Extended care setting}
#' \item{Q35_3}{Secondary RN position - Academic ed program setting}
#' \item{Q35_4}{Secondary RN position - Home health setting}
#' \item{Q35_5}{Secondary RN position - Public/community health setting}
#' \item{Q35_6}{Secondary RN position - School health service setting}
#' \item{Q35_7}{Secondary RN position - Occupational health  setting}
#' \item{Q35_8}{Secondary RN position - Ambulatory care setting}
#' \item{Q35_9}{Secondary RN position - Insurance claims/benefits setting}
#' \item{Q35_10}{Secondary RN position - Telehealth, telenursing or call center setting}
#' \item{Q35_11}{Secondary RN position - Other specify (setting)}
#' \item{Q36A_1}{Weeks per year (additional RN job #'1)}
#'                               \item{Q36B_1}{Avg hours per week (additional RN job #'1)}
#'                                                                 \item{Q36C_1}{State (additional RN job #'1)}
#'                                                                                      \item{Q36A_2}{Weeks per year (additional RN job #' 2)}
#'                                                                                                                    \item{Q36B_2}{Avg hours per week (additional RN job #'2)}
#'                                                                                                                                                      \item{Q36C_2}{State (additional RN job #'2)}
#' \item{Q36A_3}{Weeks per year (all other RN jobs)}
#' \item{Q36B_3}{Avg hours per week (all other RN jobs)}
#' \item{Q37}{Pre-tax earnings other RN positions 2008}
#' \item{Q38}{Paid RN work intentions}
#' \item{Q39A}{Months actively looking for paid RN work}
#' \item{Q40}{Looking for FT/PT position}
#' \item{Q41}{Plan to return to paid RN work}
#' \item{Q42}{Last employed/self-employed as RN}
#' \item{Q43_1}{Reason not RN - Retired}
#' \item{Q43_2}{Reason not RN - Personal}
#' \item{Q43_3}{Reason not RN - Burnout}
#' \item{Q43_4}{Reason not RN - Work stress}
#' \item{Q43_5}{Reason not RN - Scheduling}
#' \item{Q43_6}{Reason not RN - Physical demands}
#' \item{Q43_7}{Reason not RN - Disability}
#' \item{Q43_8}{Reason not RN - Illness}
#' \item{Q43_9}{Reason not RN - Inadequate staffing}
#' \item{Q43_10}{Reason not RN - Low salary}
#' \item{Q43_11}{Reason not RN - Out-of-date skills}
#' \item{Q43_12}{Reason not RN - Liability concerns}
#' \item{Q43_13}{Reason not RN - Lack of collaboration}
#' \item{Q43_14}{Reason not RN - Unable to be RN on professional level}
#' \item{Q43_15}{Reason not RN - Lack advancement opportunities}
#' \item{Q43_16}{Reason not RN - Lack good leadership}
#' \item{Q43_17}{Reason not RN - Career change}
#' \item{Q43_18}{Reason not RN - Difficulty finding RN position}
#' \item{Q43_19}{Reason not RN - Travel}
#' \item{Q43_20}{Reason not RN - Volunteering in nursing}
#' \item{Q43_21}{Reason not RN - Back to school}
#' \item{Q43_22}{Reason not RN - Other reason}
#' \item{Q44}{Non-RN employment 2008}
#' \item{Q45}{Non-RN employment health-related 2008}
#' \item{Q46A}{Field of non-RN principal position}
#' \item{Q46B}{Non-RN position job title}
#' \item{Q47}{Months worked non-RN position}
#' \item{Q48}{Avg hours per week non-RN position}
#' \item{Q49}{Pre-tax earnings non-RN position}
#' \item{Q50}{Years worked as RN (since 1st U.S. RN license)}
#' \item{Q51}{Left nursing 1 or more years since becoming RN}
#' \item{Q51YRS}{Total years not working in nursing}
#' \item{Q52}{Employed as RN 1 year ago}
#' \item{Q53}{FT/PT principal RN position in 2007}
#' \item{Q54}{Employed with current employer in 2007}
#' \item{Q55STATE}{State 2007 principal RN position}
#' \item{Q56_1}{Job change - Burnout}
#' \item{Q56_2}{Job change - Work stress}
#' \item{Q56_3}{Job change - Interest in other position}
#' \item{Q56_4}{Job change - Lack advancement}
#' \item{Q56_5}{Job change - Lack collaboration}
#' \item{Q56_6}{Job change - Lack leadership}
#' \item{Q56_7}{Job change - Career advancement}
#' \item{Q56_8}{Job change - Inadequate staffing}
#' \item{Q56_9}{Job change - Differences with colleagues}
#' \item{Q56_10}{Job change - Physical demands}
#' \item{Q56_11}{Job change - Do kind of nursing I like}
#' \item{Q56_12}{Job change - Better pay/benefits}
#' \item{Q56_13}{Job change - Scheduling}
#' \item{Q56_14}{Job change - Relocation}
#' \item{Q56_15}{Job change - Shift in positions/reorganization}
#' \item{Q56_16}{Job change - Lay offs/downsizing}
#' \item{Q56_17}{Job change - Sign-on bonus offered}
#' \item{Q56_18}{Job change - Personal}
#' \item{Q56_19}{Job change - Back to school}
#' \item{Q56_20}{Job change - Retired}
#' \item{Q56_21}{Job change - Disability}
#' \item{Q56_22}{Job change - Illness}
#' \item{Q56_23}{Job change - Other}
#' \item{Q57}{Employment setting 2007 principal RN position}
#' \item{Q58}{Satisfaction with principal/most recent RN job}
#' \item{Q59STATE}{Current state residence}
#' \item{Q60}{Reside in same city/town a year ago}
#' \item{Q61STATE}{State 2007 residence}
#' \item{Q62}{Gender}
#' \item{Q63}{Year of birth}
#' \item{Q64A}{Latino/Hispanic ethnicity}
#' \item{Q65_1}{No other languages}
#' \item{Q65_2}{Spanish language}
#' \item{Q65_3}{Filipino language}
#' \item{Q65_5}{French language}
#' \item{Q66}{Marital status}
#' \item{Q67_1}{No dependents at home}
#' \item{Q67_2}{Children less than 6 years at home}
#' \item{Q67_3}{Children 6 to 18 years at home}
#' \item{Q67_4}{Other adults at home}
#' \item{Q67_5}{Others living elsewhere}
#' \item{Q68}{Current, pre-tax annual household income}
#' \item{Q70A}{Current National RN certifications}
#' \item{Q70B_0}{No current skill-based certifications}
#' \item{Q70B_1}{Life Support certification}
#' \item{Q70B_2}{Resuscitation certification}
#' \item{Q70B_3}{Emergency medicine certification}
#' \item{Q70B_4}{Trauma certification}
#' \item{Q70B_5}{1st Other skill-based certification}
#' \item{Q70B_6}{2nd Other skill-based certification}
#' \item{Q70C_31}{Nurse Midwife (CNM) certification}
#' \item{Q70C_32}{Nurse Anesthetist (CRNA) certification}
#' \item{Q70D_0}{Other National RN certifications}
#' \item{SOURCE}{Data collection type}
#' \item{SUBMISSION_DATE}{Submission date}
#' \item{Q9_14}{Student Nurse Externship}
#' \item{Q29C_24}{Clinical specialty - Plastic/Cosmetic Surgery}
#' \item{Q29C_25}{Clinical specialty - Orthopedic}
#' \item{Q29C_26}{Clinical specialty - Endocrinology}
#' \item{Q29C_27}{Clinical specialty - Urology}
#' \item{Q9_16}{Health Educator before RN ed}
#' \item{Q9_15}{Mental Health/Psychiatric work before RN ed}
#' \item{Q29A_18}{Level of care - Informatics}
#' \item{Q29A_19}{Level of care - Flight nurse/med air transport}
#' \item{Q29C_28}{Clinical specialty - Infusion/IV}
#' \item{Q29C_29}{Clinical specialty - Ophthalmology}
#' \item{Q29C_30}{Clinical specialty - Otolaryngology/ENT}
#' \item{Q35_12}{Secondary RN position - Military/Reserves/National Guard setting}
#' \item{Q35_13}{Secondary RN position - Medical Legal setting}
#' \item{Q35_14}{Secondary RN position - Consultant/Contractor setting}
#' \item{Q56_24}{Job change - Contract ended}
#' \item{IMPQ6_0}{Imputation flag for Q6_0}
#' \item{IMPQ8}{Imputation flag for Q8}
#' \item{IMPQ9_0}{Imputation flag for Q9_0}
#' \item{IMPQ11A_0}{Imputation flag for Q11A_0}
#' \item{IMPQ12}{Imputation flag for Q12}
#' \item{IMPQ15}{Imputation flag for Q15}
#' \item{IMPQ44}{Imputation flag for Q44}
#' \item{IMPQ60}{Imputation flag for Q60}
#' \item{IMPQ62}{Imputation flag for Q62}
#' \item{IMPQ67_1}{Imputation flag for Q67_1}
#' \item{IMPQ63}{Imputation flag for Q63}
#' \item{IMPQ4YEAR}{Imputation flag for Q4YEAR}
#' \item{IMPQ2YEAR}{Imputation flag for Q2YEAR}
#' \item{IMPQ50}{Imputation flag for Q50}
#' \item{IMPQ9_1}{Imputation flag for Q9_1}
#' \item{IMPQ9_2}{Imputation flag for Q9_2}
#' \item{IMPQ9_3}{Imputation flag for Q9_3}
#' \item{IMPQ9_4}{Imputation flag for Q9_4}
#' \item{IMPQ9_5}{Imputation flag for Q9_5}
#' \item{IMPQ9_6}{Imputation flag for Q9_6}
#' \item{IMPQ9_7}{Imputation flag for Q9_7}
#' \item{IMPQ9_8}{Imputation flag for Q9_8}
#' \item{IMPQ9_9}{Imputation flag for Q9_9}
#' \item{IMPQ9_10}{Imputation flag for Q9_10}
#' \item{IMPQ9_11}{Imputation flag for Q9_11}
#' \item{IMPQ9_12}{Imputation flag for Q9_12}
#' \item{IMPQ9_13}{Imputation flag for Q9_13}
#' \item{IMPQ9_14}{Imputation flag for Q9_14}
#' \item{IMPQ9_15}{Imputation flag for Q9_15}
#' \item{IMPQ9_16}{Imputation flag for Q9_16}
#' \item{IMPQ10_1}{Imputation flag for Q10_1}
#' \item{IMPQ10_2}{Imputation flag for Q10_2}
#' \item{IMPQ10_3}{Imputation flag for Q10_3}
#' \item{IMPQ10_4}{Imputation flag for Q10_4}
#' \item{IMPQ10_5}{Imputation flag for Q10_5}
#' \item{IMPQ10_6}{Imputation flag for Q10_6}
#' \item{IMPQ10_7}{Imputation flag for Q10_7}
#' \item{IMPQ10_8}{Imputation flag for Q10_8}
#' \item{IMPQ10_9}{Imputation flag for Q10_9}
#' \item{IMPQ10_10}{Imputation flag for Q10_10}
#' \item{IMPQ10_11}{Imputation flag for Q10_11}
#' \item{IMPQ10_12}{Imputation flag for Q10_12}
#' \item{IMPQ68}{Imputation flag for Q68}
#' \item{IMPQ52}{Imputation flag for Q52}
#' \item{IMPQ58}{Imputation flag for Q58}
#' \item{IMPQ64A}{Imputation flag for Q64A}
#' \item{IMPQ64B_1}{Imputation flag for Q64B_1}
#' \item{IMPQ64B_2}{Imputation flag for Q64B_2}
#' \item{IMPQ64B_3}{Imputation flag for Q64B_3}
#' \item{IMPQ64B_4}{Imputation flag for Q64B_4}
#' \item{IMPQ64B_5}{Imputation flag for Q64B_5}
#' \item{IMPQ65_1}{Imputation flag for Q65_1}
#' \item{IMPQ65_2}{Imputation flag for Q65_2}
#' \item{IMPQ65_3}{Imputation flag for Q65_3}
#' \item{IMPQ65_4}{Imputation flag for Q65_4}
#' \item{IMPQ65_5}{Imputation flag for Q65_5}
#' \item{IMPQ65_6}{Imputation flag for Q65_6}
#' \item{IMPQ65_7}{Imputation flag for Q65_7}
#' \item{IMPQ65_8}{Imputation flag for Q65_8}
#' \item{IMPQ65_9}{Imputation flag for Q65_9}
#' \item{IMPQ65_10}{Imputation flag for Q65_10}
#' \item{IMPQ65_11}{Imputation flag for Q65_11}
#' \item{IMPQ65_12}{Imputation flag for Q65_12}
#' \item{IMPQ65_13}{Imputation flag for Q65_13}
#' \item{IMPQ65_14}{Imputation flag for Q65_14}
#' \item{IMPQ65_15}{Imputation flag for Q65_15}
#' \item{IMPQ65_16}{Imputation flag for Q65_16}
#' \item{IMPQ65_17}{Imputation flag for Q65_17}
#' \item{IMPQ65_18}{Imputation flag for Q65_18}
#' \item{IMPQ65_19}{Imputation flag for Q65_19}
#' \item{IMPQ65_20}{Imputation flag for Q65_20}
#' \item{IMPQ65_21}{Imputation flag for Q65_21}
#' \item{IMPQ65_22}{Imputation flag for Q65_22}
#' \item{IMPQ65_23}{Imputation flag for Q65_23}
#' \item{IMPQ65_24}{Imputation flag for Q65_24}
#' \item{IMPQ65_25}{Imputation flag for Q65_25}
#' \item{IMPQ65_26}{Imputation flag for Q65_26}
#' \item{IMPQ65_27}{Imputation flag for Q65_27}
#' \item{IMPQ67_2}{Imputation flag for Q67_2}
#' \item{IMPQ67_3}{Imputation flag for Q67_3}
#' \item{IMPQ67_4}{Imputation flag for Q67_4}
#' \item{IMPQ67_5}{Imputation flag for Q67_5}
#' \item{IMPQ3}{Imputation flag for Q3}
#' \item{IMPQ4MONTH}{Imputation flag for Q4MONTH}
#' \item{IMPQ6_1}{Imputation flag for Q6_1}
#' \item{IMPQ6_2}{Imputation flag for Q6_2}
#' \item{IMPQ6_3}{Imputation flag for Q6_3}
#' \item{IMPQ6_4}{Imputation flag for Q6_4}
#' \item{IMPQ6_5}{Imputation flag for Q6_5}
#' \item{IMPQ7}{Imputation flag for Q7}
#' \item{IMPQ11A_1}{Imputation flag for Q11A_1}
#' \item{IMPQ11A_2}{Imputation flag for Q11A_2}
#' \item{IMPQ11A_3}{Imputation flag for Q11A_3}
#' \item{IMPQ11A_4}{Imputation flag for Q11A_4}
#' \item{IMPQ11A_5}{Imputation flag for Q11A_5}
#' \item{IMPQ11A_6}{Imputation flag for Q11A_6}
#' \item{IMPQ11BPROV}{Imputation flag for Q11BPROV}
#' \item{IMPQ11BREC}{Imputation flag for Q11BREC}
#' \item{IMPQ11C}{Imputation flag for Q11C}
#' \item{IMPQ13A_A}{Imputation flag for Q13A_A}
#' \item{IMPQ13A_B}{Imputation flag for Q13A_B}
#' \item{IMPQ13A_C}{Imputation flag for Q13A_C}
#' \item{IMPQ13A_D}{Imputation flag for Q13A_D}
#' \item{IMPQ13A_E}{Imputation flag for Q13A_E}
#' \item{IMPQ13A_F}{Imputation flag for Q13A_F}
#' \item{IMPQ13A_G}{Imputation flag for Q13A_G}
#' \item{IMPQ13A_H}{Imputation flag for Q13A_H}
#' \item{IMPQ13A_I}{Imputation flag for Q13A_I}
#' \item{IMPQ13A_J}{Imputation flag for Q13A_J}
#' \item{IMPQ13B_C}{Imputation flag for Q13B_C}
#' \item{IMPQ13B_D}{Imputation flag for Q13B_D}
#' \item{IMPQ13B_E}{Imputation flag for Q13B_E}
#' \item{IMPQ13B_F}{Imputation flag for Q13B_F}
#' \item{IMPQ13B_G}{Imputation flag for Q13B_G}
#' \item{IMPQ13B_H}{Imputation flag for Q13B_H}
#' \item{IMPQ13B_I}{Imputation flag for Q13B_I}
#' \item{IMPQ13B_J}{Imputation flag for Q13B_J}
#' \item{IMPQ13C_F}{Imputation flag for Q13C_F}
#' \item{IMPQ13C_G}{Imputation flag for Q13C_G}
#' \item{IMPQ13C_H}{Imputation flag for Q13C_H}
#' \item{IMPQ13C_I}{Imputation flag for Q13C_I}
#' \item{IMPQ13C_J}{Imputation flag for Q13C_J}
#' \item{IMPQ13D_A}{Imputation flag for Q13D_A}
#' \item{IMPQ13D_B}{Imputation flag for Q13D_B}
#' \item{IMPQ13D_C}{Imputation flag for Q13D_C}
#' \item{IMPQ13D_D}{Imputation flag for Q13D_D}
#' \item{IMPQ13D_E}{Imputation flag for Q13D_E}
#' \item{IMPQ13D_F}{Imputation flag for Q13D_F}
#' \item{IMPQ13D_G}{Imputation flag for Q13D_G}
#' \item{IMPQ13D_H}{Imputation flag for Q13D_H}
#' \item{IMPQ13D_I}{Imputation flag for Q13D_I}
#' \item{IMPQ13D_J}{Imputation flag for Q13D_J}
#' \item{IMPQ13F_A}{Imputation flag for Q13F_A}
#' \item{IMPQ13F_B}{Imputation flag for Q13F_B}
#' \item{IMPQ13F_C}{Imputation flag for Q13F_C}
#' \item{IMPQ13F_D}{Imputation flag for Q13F_D}
#' \item{IMPQ13F_E}{Imputation flag for Q13F_E}
#' \item{IMPQ13F_F}{Imputation flag for Q13F_F}
#' \item{IMPQ13F_G}{Imputation flag for Q13F_G}
#' \item{IMPQ13F_H}{Imputation flag for Q13F_H}
#' \item{IMPQ13F_I}{Imputation flag for Q13F_I}
#' \item{IMPQ13F_J}{Imputation flag for Q13F_J}
#' \item{IMPQ16}{Imputation flag for Q16}
#' \item{IMPQ17A}{Imputation flag for Q17A}
#' \item{IMPQ17B}{Imputation flag for Q17B}
#' \item{IMPQ18}{Imputation flag for Q18}
#' \item{IMPQ20}{Imputation flag for Q20}
#' \item{IMPQ22}{Imputation flag for Q22}
#' \item{IMPQ25}{Imputation flag for Q25}
#' \item{IMPQ26}{Imputation flag for Q26}
#' \item{IMPQ27C}{Imputation flag for Q27C}
#' \item{IMPQ27B}{Imputation flag for Q27B}
#' \item{IMPQ27A}{Imputation flag for Q27A}
#' \item{IMPQ27D}{Imputation flag for Q27D}
#' \item{IMPQ27E}{Imputation flag for Q27E}
#' \item{IMPQ27F}{Imputation flag for Q27F}
#' \item{IMPQ28A}{Imputation flag for Q28A}
#' \item{IMPQ28B}{Imputation flag for Q28B}
#' \item{IMPQ28C}{Imputation flag for Q28C}
#' \item{IMPQ28D}{Imputation flag for Q28D}
#' \item{IMPQ28E}{Imputation flag for Q28E}
#' \item{IMPQ28F}{Imputation flag for Q28F}
#' \item{IMPQ28G}{Imputation flag for Q28G}
#' \item{IMPQ28H}{Imputation flag for Q28H}
#' \item{IMPQ30}{Imputation flag for Q30}
#' \item{IMPQ31}{Imputation flag for Q31}
#' \item{IMPQ32A}{Imputation flag for Q32A}
#' \item{IMPQ32B}{Imputation flag for Q32B}
#' \item{IMPQ33}{Imputation flag for Q33}
#' \item{IMPQ34_1}{Imputation flag for Q34_1}
#' \item{IMPQ34_2}{Imputation flag for Q34_2}
#' \item{IMPQ34_3}{Imputation flag for Q34_3}
#' \item{IMPQ34_4}{Imputation flag for Q34_4}
#' \item{IMPQ35_1}{Imputation flag for Q35_1}
#' \item{IMPQ35_2}{Imputation flag for Q35_2}
#' \item{IMPQ35_3}{Imputation flag for Q35_3}
#' \item{IMPQ35_4}{Imputation flag for Q35_4}
#' \item{IMPQ35_5}{Imputation flag for Q35_5}
#' \item{IMPQ35_6}{Imputation flag for Q35_6}
#' \item{IMPQ35_7}{Imputation flag for Q35_7}
#' \item{IMPQ35_8}{Imputation flag for Q35_8}
#' \item{IMPQ35_9}{Imputation flag for Q35_9}
#' \item{IMPQ35_10}{Imputation flag for Q35_10}
#' \item{IMPQ35_11}{Imputation flag for Q35_11}
#' \item{IMPQ35_12}{Imputation flag for Q35_12}
#' \item{IMPQ35_13}{Imputation flag for Q35_13}
#' \item{IMPQ35_14}{Imputation flag for Q35_14}
#' \item{IMPQ36A_1}{Imputation flag for Q36A_1}
#' \item{IMPQ36A_2}{Imputation flag for Q36A_2}
#' \item{IMPQ36A_3}{Imputation flag for Q36A_3}
#' \item{IMPQ36B_1}{Imputation flag for Q36B_1}
#' \item{IMPQ36B_2}{Imputation flag for Q36B_2}
#' \item{IMPQ36B_3}{Imputation flag for Q36B_3}
#' \item{IMPQ36C_1CY}{Imputation flag for Q36C_1CY}
#' \item{IMPQ36C_2CY}{Imputation flag for Q36C_2CY}
#' \item{IMPQ37}{Imputation flag for Q37}
#' \item{IMPQ38}{Imputation flag for Q38}
#' \item{IMPQ39A}{Imputation flag for Q39A}
#' \item{IMPQ40}{Imputation flag for Q40}
#' \item{IMPQ41}{Imputation flag for Q41}
#' \item{IMPQ43_1}{Imputation flag for Q43_1}
#' \item{IMPQ43_2}{Imputation flag for Q43_2}
#' \item{IMPQ43_3}{Imputation flag for Q43_3}
#' \item{IMPQ43_4}{Imputation flag for Q43_4}
#' \item{IMPQ43_5}{Imputation flag for Q43_5}
#' \item{IMPQ43_6}{Imputation flag for Q43_6}
#' \item{IMPQ43_7}{Imputation flag for Q43_7}
#' \item{IMPQ43_8}{Imputation flag for Q43_8}
#' \item{IMPQ43_9}{Imputation flag for Q43_9}
#' \item{IMPQ43_10}{Imputation flag for Q43_10}
#' \item{IMPQ43_11}{Imputation flag for Q43_11}
#' \item{IMPQ43_12}{Imputation flag for Q43_12}
#' \item{IMPQ43_13}{Imputation flag for Q43_13}
#' \item{IMPQ43_14}{Imputation flag for Q43_14}
#' \item{IMPQ43_15}{Imputation flag for Q43_15}
#' \item{IMPQ43_16}{Imputation flag for Q43_16}
#' \item{IMPQ43_17}{Imputation flag for Q43_17}
#' \item{IMPQ43_18}{Imputation flag for Q43_18}
#' \item{IMPQ43_19}{Imputation flag for Q43_19}
#' \item{IMPQ43_20}{Imputation flag for Q43_20}
#' \item{IMPQ43_21}{Imputation flag for Q43_21}
#' \item{IMPQ43_22}{Imputation flag for Q43_22}
#' \item{IMPQ45}{Imputation flag for Q45}
#' \item{IMPQ46A}{Imputation flag for Q46A}
#' \item{IMPQ46B}{Imputation flag for Q46B}
#' \item{IMPQ47}{Imputation flag for Q47}
#' \item{IMPQ48}{Imputation flag for Q48}
#' \item{IMPQ49}{Imputation flag for Q49}
#' \item{IMPQ51}{Imputation flag for Q51}
#' \item{IMPQ51YRS}{Imputation flag for Q51YRS}
#' \item{IMPQ42}{Imputation flag for Q42}
#' \item{IMPQ53}{Imputation flag for Q53}
#' \item{IMPQ54}{Imputation flag for Q54}
#' \item{IMPQ56_1}{Imputation flag for Q56_1}
#' \item{IMPQ56_2}{Imputation flag for Q56_2}
#' \item{IMPQ56_3}{Imputation flag for Q56_3}
#' \item{IMPQ56_4}{Imputation flag for Q56_4}
#' \item{IMPQ56_5}{Imputation flag for Q56_5}
#' \item{IMPQ56_6}{Imputation flag for Q56_6}
#' \item{IMPQ56_7}{Imputation flag for Q56_7}
#' \item{IMPQ56_8}{Imputation flag for Q56_8}
#' \item{IMPQ56_9}{Imputation flag for Q56_9}
#' \item{IMPQ56_10}{Imputation flag for Q56_10}
#' \item{IMPQ56_11}{Imputation flag for Q56_11}
#' \item{IMPQ56_12}{Imputation flag for Q56_12}
#' \item{IMPQ56_13}{Imputation flag for Q56_13}
#' \item{IMPQ56_14}{Imputation flag for Q56_14}
#' \item{IMPQ56_15}{Imputation flag for Q56_15}
#' \item{IMPQ56_16}{Imputation flag for Q56_16}
#' \item{IMPQ56_17}{Imputation flag for Q56_17}
#' \item{IMPQ56_18}{Imputation flag for Q56_18}
#' \item{IMPQ56_19}{Imputation flag for Q56_19}
#' \item{IMPQ56_20}{Imputation flag for Q56_20}
#' \item{IMPQ56_21}{Imputation flag for Q56_21}
#' \item{IMPQ56_22}{Imputation flag for Q56_22}
#' \item{IMPQ56_23}{Imputation flag for Q56_23}
#' \item{IMPQ56_24}{Imputation flag for Q56_24}
#' \item{IMPQ66}{Imputation flag for Q66}
#' \item{IMPQ2STATE}{Imputation flag for Q2STATE}
#' \item{IMPQ5STATE}{Imputation flag for Q5STATE}
#' \item{IMPQ55STATE}{Imputation flag for Q55STATE}
#' \item{IMPQ57}{Imputation flag for Q57}
#' \item{IMPQ61STATE}{Imputation flag for Q61STATE}
#' \item{IMPQ36C_1}{Imputation flag for Q36C_1}
#' \item{IMPQ36C_2}{Imputation flag for Q36C_2}
#' \item{AGE}{Age of RN in 2007}
#' \item{AGE_GP}{Ages grouped}
#' \item{MAR_ADULT}{Marital status & adult dependants}
#' \item{MAR_CHLD}{Marital status & children}
#' \item{NLANG}{Non-English languages spoken category count}
#' \item{RACE}{Single races}
#' \item{RAC_ETHN}{Race/ethnicity}
#' \item{RACE_GP}{Race/ethnicity grouped}
#' \item{HN_YEAR}{Year received highest nursing ed}
#' \item{HN_AGE}{Age at highest nursing ed}
#' \item{H_YEAR}{Year received highest nursing/nursing-related ed}
#' \item{AGE_GRAD}{Age at graduation - initial RN ed}
#' \item{GRAD_YR}{Initial RN ed graduation year}
#' \item{YR_IN_HN}{Years between initial and highest RN ed}
#' \item{YR_SINCE}{Years since graduated from initial RN ed program}
#' \item{YRSNC_GP}{Years since graduated from initial RN ed grouped}
#' \item{EDU_ENRLD}{Enrolled upgrade ed program}
#' \item{GRAD_WHR}{Graduated U.S. or non-U.S. RN program}
#' \item{NFINANCE}{Finance means initial RN ed category count}
#' \item{NTRAINING}{Emergency/disaster training areas category count}
#' \item{CH_CAREER}{Employment change - career}
#' \item{CH_PERSFAM}{Employment change - personal}
#' \item{CH_RETIRE}{Employment change - retirement}
#' \item{CH_WRKPLCE}{Employment change - workplace}
#' \item{CH_OTHER}{Employment change - other}
#' \item{NCHREASN}{Reasons position change category count}
#' \item{DOMFUNCT}{Dominant function}
#' \item{EMP_STAT}{Employment status 2008 detailed}
#' \item{EMPL_08}{RN employment status 2008}
#' \item{EMPL_07}{RN employment status 2007}
#' \item{EMP08_07}{Employed in nursing 2008 & 2007}
#' \item{EMPL_TES}{Employed by Temporary Employment Service (TES)}
#' \item{EMPL_ORG}{Employed by organization/facility}
#' \item{EMPL_SELF}{Self-employed in nursing}
#' \item{HRS_YR}{Estimated hours per year for principal RN position}
#' \item{LST_WRKD}{Years since paid RN}
#' \item{NOT_CAREER}{Not working - career}
#' \item{NOT_PERSFAM}{Not working - personal}
#' \item{NOT_RETIRE}{Not working - retired}
#' \item{NOT_WORKPLACE}{Not working - workplace}
#' \item{NOT_OTHER}{Not working - other}
#' \item{NNOTRN}{Reasons not working as RN category count}
#' \item{POSITION}{Position title grouped}
#' \item{NLEVCARE}{Levels of care principal RN job category count}
#' \item{NSPECIALTY}{Clinical specialties principal RN job category count}
#' \item{SETSUM08}{Employment setting summary 2008}
#' \item{SETSUM07}{Employment setting summary 2007}
#' \item{SET07_08}{RN employment setting 2007 versus 2008}
#' \item{TOTSAL}{Total earnings from all nursing and non-nursing employment}
#' \item{NWKSTATE}{Number of States in which RN works}
#' \item{NHLTHJOB}{Health-related jobs pre-RN category count}
#' \item{APN_CNS}{Clinical Nurse Specialist status}
#' \item{APN_NP}{Nurse practitioner status}
#' \item{APN_NA}{Nurse Anesthetist status}
#' \item{APN_NM}{Nurse midwife status}
#' \item{APN_COMBOS}{APRN status combinations}
#' \item{Q21_FIPSST}{FIPS state 2008 principal RN position}
#' \item{Q21_DIV}{Census division 2008 principal RN position}
#' \item{Q59_FIPSST}{FIPS State 2008 residence}
#' \item{Q59_DIV}{Census division 2008 residence}
#' \item{G_ST08}{Geocode for State on 3/10/2008}
#' \item{G_RG08}{Geocode for Census Division on 3/10/2008}
#' \item{RN_POP}{RN working/living in U.S. 2008}
#' \item{RKRNWGTA}{Raked weight}
#' \item{RKRNWGTA1}{Raked weight 1}
#' \item{RKRNWGTA2}{Raked weight 2}
#' \item{RKRNWGTA3}{Raked weight 3}
#' \item{RKRNWGTA4}{Raked weight 4}
#' \item{RKRNWGTA5}{Raked weight 5}
#' \item{RKRNWGTA6}{Raked weight 6}
#' \item{RKRNWGTA7}{Raked weight 7}
#' \item{RKRNWGTA8}{Raked weight 8}
#' \item{RKRNWGTA9}{Raked weight 9}
#' \item{RKRNWGTA10}{Raked weight 10}
#' \item{RKRNWGTA11}{Raked weight 11}
#' \item{RKRNWGTA12}{Raked weight 12}
#' \item{RKRNWGTA13}{Raked weight 13}
#' \item{RKRNWGTA14}{Raked weight 14}
#' \item{RKRNWGTA15}{Raked weight 15}
#' \item{RKRNWGTA16}{Raked weight 16}
#' \item{RKRNWGTA17}{Raked weight 17}
#' \item{RKRNWGTA18}{Raked weight 18}
#' \item{RKRNWGTA19}{Raked weight 19}
#' \item{RKRNWGTA20}{Raked weight 20}
#' \item{RKRNWGTA21}{Raked weight 21}
#' \item{RKRNWGTA22}{Raked weight 22}
#' \item{RKRNWGTA23}{Raked weight 23}
#' \item{RKRNWGTA24}{Raked weight 24}
#' \item{RKRNWGTA25}{Raked weight 25}
#' \item{RKRNWGTA26}{Raked weight 26}
#' \item{RKRNWGTA27}{Raked weight 27}
#' \item{RKRNWGTA28}{Raked weight 28}
#' \item{RKRNWGTA29}{Raked weight 29}
#' \item{RKRNWGTA30}{Raked weight 30}
#' \item{RKRNWGTA31}{Raked weight 31}
#' \item{RKRNWGTA32}{Raked weight 32}
#' \item{RKRNWGTA33}{Raked weight 33}
#' \item{RKRNWGTA34}{Raked weight 34}
#' \item{RKRNWGTA35}{Raked weight 35}
#' \item{RKRNWGTA36}{Raked weight 36}
#' \item{RKRNWGTA37}{Raked weight 37}
#' \item{RKRNWGTA38}{Raked weight 38}
#' \item{RKRNWGTA39}{Raked weight 39}
#' \item{RKRNWGTA40}{Raked weight 40}
#' \item{RKRNWGTA41}{Raked weight 41}
#' \item{RKRNWGTA42}{Raked weight 42}
#' \item{RKRNWGTA43}{Raked weight 43}
#' \item{RKRNWGTA44}{Raked weight 44}
#' \item{RKRNWGTA45}{Raked weight 45}
#' \item{RKRNWGTA46}{Raked weight 46}
#' \item{RKRNWGTA47}{Raked weight 47}
#' \item{RKRNWGTA48}{Raked weight 48}
#' \item{RKRNWGTA49}{Raked weight 49}
#' \item{RKRNWGTA50}{Raked weight 50}
#' \item{RKRNWGTA51}{Raked weight 51}
#' \item{RKRNWGTA52}{Raked weight 52}
#' \item{RKRNWGTA53}{Raked weight 53}
#' \item{RKRNWGTA54}{Raked weight 54}
#' \item{RKRNWGTA55}{Raked weight 55}
#' \item{RKRNWGTA56}{Raked weight 56}
#' \item{RKRNWGTA57}{Raked weight 57}
#' \item{RKRNWGTA58}{Raked weight 58}
#' \item{RKRNWGTA59}{Raked weight 59}
#' \item{RKRNWGTA60}{Raked weight 60}
#' \item{RKRNWGTA61}{Raked weight 61}
#' \item{RKRNWGTA62}{Raked weight 62}
#' \item{RKRNWGTA63}{Raked weight 63}
#' \item{RKRNWGTA64}{Raked weight 64}
#' \item{RKRNWGTA65}{Raked weight 65}
#' \item{RKRNWGTA66}{Raked weight 66}
#' \item{RKRNWGTA67}{Raked weight 67}
#' \item{RKRNWGTA68}{Raked weight 68}
#' \item{RKRNWGTA69}{Raked weight 69}
#' \item{RKRNWGTA70}{Raked weight 70}
#' \item{RKRNWGTA71}{Raked weight 71}
#' \item{RKRNWGTA72}{Raked weight 72}
#' \item{RKRNWGTA73}{Raked weight 73}
#' \item{RKRNWGTA74}{Raked weight 74}
#' \item{RKRNWGTA75}{Raked weight 75}
#' \item{RKRNWGTA76}{Raked weight 76}
#' \item{RKRNWGTA77}{Raked weight 77}
#' \item{RKRNWGTA78}{Raked weight 78}
#' \item{RKRNWGTA79}{Raked weight 79}
#' \item{RKRNWGTA80}{Raked weight 80}
#' \item{RKRNWGTA81}{Raked weight 81}
#' \item{RKRNWGTA82}{Raked weight 82}
#' \item{RKRNWGTA83}{Raked weight 83}
#' \item{RKRNWGTA84}{Raked weight 84}
#' \item{RKRNWGTA85}{Raked weight 85}
#' \item{RKRNWGTA86}{Raked weight 86}
#' \item{RKRNWGTA87}{Raked weight 87}
#' \item{RKRNWGTA88}{Raked weight 88}
#' \item{RKRNWGTA89}{Raked weight 89}
#' \item{RKRNWGTA90}{Raked weight 90}
#' \item{RKRNWGTA91}{Raked weight 91}
#' \item{RKRNWGTA92}{Raked weight 92}
#' \item{RKRNWGTA93}{Raked weight 93}
#' \item{RKRNWGTA94}{Raked weight 94}
#' \item{RKRNWGTA95}{Raked weight 95}
#' \item{RKRNWGTA96}{Raked weight 96}
#' \item{RKRNWGTA97}{Raked weight 97}
#' \item{RKRNWGTA98}{Raked weight 98}
#' \item{RKRNWGTA99}{Raked weight 99}
#' \item{RKRNWGTA100}{Raked weight 100}
#' \item{Q2_DIV}{Census division State of first RN license}
#' \item{Q5_FIPSST}{FIPS State initial RN ed program}
#' \item{Q5_DIV}{Census division initial RN ed program}
#' \item{REG_B_ED}{Census division of initial RN ed}
#' \item{REG_EMPL}{Census division of 2008 employment}
#' \item{REG_RESI}{Census division of 2008 residence}
#' \item{Q55_FIPSST}{FIPS state 2007 principal RN position}
#' \item{Q55_DIV}{Census division State of 2007 RN position}
#' \item{Q61_FIPSST}{FIPS State 2007 residence}
#' \item{Q61_DIV}{Census division 2007 residence}
#' \item{G_ST07}{Geocode for State on 3/10/2007}
#' \item{G_RG07}{Geocode for Census Division on 3/10/2007}
#' \item{G_MSA07}{Geocode for metro/non-metro on 3/10/2007}
#' \item{G_MSA08}{Geocode for metro/non-metro on 3/10/2008}
#' \item{GD_GEOST}{State of graduations v. current GEO State}
#' \item{RCTY_SME}{County of residence in 2007 and 2008}
#' \item{RST_SME}{State of residence in 2007 and 2008}
#' \item{RCCC4Q21}{Standard four category RUCA code - Q21}
#' \item{RCCC3Q21}{Standard three category RUCA code - Q21}
#' \item{RCCC4Q55}{Standard four category RUCA code - Q55}
#' \item{RCCC3Q55}{Standard three category RUCA code - Q55}
#' \item{RCCC4Q59}{Standard four category RUCA code - Q59}
#' \item{RCCC3Q59}{Standard three category RUCA code - Q59}
#' \item{RCCC4Q61}{Standard four category RUCA code - Q61}
#' \item{RCCC3Q61}{Standard three category RUCA code - Q61}
#' \item{Q5COU_CONT}{Continent initial RN ed program located}
#' \item{NLC}{RN Licensure Compact}
#' \item{TOTRNHRS_YR}{Total RN hours worked per year}
#' \item{CERT_ANST}{Anesthesiology certification}
#' \item{CERT_ADDI}{Addictions certification}
#' \item{CERT_ADMN}{Administrator certification}
#' \item{CERT_AMBU}{Ambulatory Care certification}
#' \item{CERT_AMBS}{Ambulatory Surgical certification}
#' \item{CERT_CARD}{Cardiac Rehabilitation certification}
#' \item{CERT_CASE}{Case Management certification}
#' \item{CERT_COLL}{College Health certification}
#' \item{CERT_COMM}{Community Health certification}
#' \item{CERT_CNED}{Continuing Ed/Staff Dev certification}
#' \item{CERT_COUN}{Counselor certification}
#' \item{CERT_CRIT}{Critical Care certification}
#' \item{CERT_DIAB}{Diabetes Educator certification}
#' \item{CERT_FAMI}{Family Practice certification}
#' \item{CERT_FLGT}{Flight certification}
#' \item{CERT_GAST}{Gastroenterology certification}
#' \item{CERT_GENN}{General Practice certification}
#' \item{CERT_GENS}{General Surgery certification}
#' \item{CERT_GERO}{Gerontology certification}
#' \item{CERT_HEMO}{Hemodialysis certification}
#' \item{CERT_HOLI}{Holistic Health certification}
#' \item{CERT_HOME}{Home Health certification}
#' \item{CERT_HOSP}{Hospice certification}
#' \item{CERT_INFC}{Infection Control certification}
#' \item{CERT_INFD}{Infectious Disease certification}
#' \item{CERT_INFO}{Informatics certification}
#' \item{CERT_INFU}{Infusion Therapy certification}
#' \item{CERT_LACT}{Lactation Consult certification}
#' \item{CERT_LEGL}{Legal Nurse certification}
#' \item{CERT_MATN}{Maternal Newborn certification}
#' \item{CERT_MEDS}{Medical-Surgical certification}
#' \item{CERT_NEIN}{Neonatal Intensive care certification}
#' \item{CERT_NELO}{Neonatal, Low Risk certification}
#' \item{CERT_NEPH}{Nephrology certification}
#' \item{CERT_NEUR}{Neuroscience certification}
#' \item{CERT_NUED}{Nurse Educator certification}
#' \item{CERT_OBST}{Obstetric, Inpatient certification}
#' \item{CERT_OCCH}{Occupational Health certification}
#' \item{CERT_ONCO}{Oncology certification}
#' \item{CERT_ORTH}{Orthopedic certification}
#' \item{CERT_PAIN}{Pain Management certification}
#' \item{CERT_PEDI}{Pediatrics certification}
#' \item{CERT_PERI}{Perinatal certification}
#' \item{CERT_PSYC}{Psych/Mental Health certification}
#' \item{CERT_QUAL}{Quality Care certification}
#' \item{CERT_RADI}{Radiological certification}
#' \item{CERT_FRST}{RNs First Asst certification}
#' \item{CERT_REHA}{Rehabilitation certification}
#' \item{CERT_RSCH}{Research certification}
#' \item{CERT_SCHL}{School certification}
#' \item{CERT_TRANS}{Transplantation certification}
#' \item{CERT_UROL}{Urology certification}
#' \item{CERT_WOMN}{Women's Health certification}
#' \item{CERT_WOUN}{Wound Care certification}
#' \item{CERT_TELE}{Telemetry certification}
#' \item{OASIAN}{Other Asian (non-Filipino) language}
#' \item{NSKLCERT}{Skill-based certification category count}
#' \item{NAPNCERT}{Advanced practice RN certification category count}
#' \item{NNTLCERT}{National nursing certification category count}
#' \item{Q3_PUF}{Initial RN degree/credential for PUF}
#' \item{PREP_SUM_PUF}{Highest RN/RN-related ed summary for PUF}
#' \item{LI_RESST}{State of first license versus GEO State  for 2008}
#' \item{LICST_CT}{Number of States in which RN currently licensed}
#' \item{ID_GENERAL}{Randomly assigned ID for general file}
#' \item{IMPQ29C_1}{Imputation flag for Q29C_1}
#' \item{IMPQ29C_2}{Imputation flag for Q29C_2}
#' \item{IMPQ29C_3}{Imputation flag for Q29C_3}
#' \item{IMPQ29C_4}{Imputation flag for Q29C_4}
#' \item{IMPQ29C_5}{Imputation flag for Q29C_5}
#' \item{IMPQ29C_6}{Imputation flag for Q29C_6}
#' \item{IMPQ29C_7}{Imputation flag for Q29C_7}
#' \item{IMPQ29C_8}{Imputation flag for Q29C_8}
#' \item{IMPQ29C_9}{Imputation flag for Q29C_9}
#' \item{IMPQ29C_10}{Imputation flag for Q29C_10}
#' \item{IMPQ29C_11}{Imputation flag for Q29C_11}
#' \item{IMPQ29C_12}{Imputation flag for Q29C_12}
#' \item{IMPQ29C_13}{Imputation flag for Q29C_13}
#' \item{IMPQ29C_14}{Imputation flag for Q29C_14}
#' \item{IMPQ29C_15}{Imputation flag for Q29C_15}
#' \item{IMPQ29C_16}{Imputation flag for Q29C_16}
#' \item{IMPQ29C_17}{Imputation flag for Q29C_17}
#' \item{IMPQ29C_18}{Imputation flag for Q29C_18}
#' \item{IMPQ29C_19}{Imputation flag for Q29C_19}
#' \item{IMPQ29C_20}{Imputation flag for Q29C_20}
#' \item{IMPQ29C_21}{Imputation flag for Q29C_21}
#' \item{IMPQ29C_22}{Imputation flag for Q29C_22}
#' \item{IMPQ29C_23}{Imputation flag for Q29C_23}
#' \item{IMPQ29C_24}{Imputation flag for Q29C_24}
#' \item{IMPQ29C_25}{Imputation flag for Q29C_25}
#' \item{IMPQ29C_26}{Imputation flag for Q29C_26}
#' \item{IMPQ29C_27}{Imputation flag for Q29C_27}
#' \item{IMPQ29C_28}{Imputation flag for Q29C_28}
#' \item{IMPQ29C_29}{Imputation flag for Q29C_29}
#' \item{IMPQ29C_30}{Imputation flag for Q29C_30}
#' \item{IMPQ29A_1}{Imputation flag for Q29A_1}
#' \item{IMPQ29A_2}{Imputation flag for Q29A_2}
#' \item{IMPQ29A_3}{Imputation flag for Q29A_3}
#' \item{IMPQ29A_4}{Imputation flag for Q29A_4}
#' \item{IMPQ29A_5}{Imputation flag for Q29A_5}
#' \item{IMPQ29A_6}{Imputation flag for Q29A_6}
#' \item{IMPQ29A_7}{Imputation flag for Q29A_7}
#' \item{IMPQ29A_8}{Imputation flag for Q29A_8}
#' \item{IMPQ29A_9}{Imputation flag for Q29A_9}
#' \item{IMPQ29A_10}{Imputation flag for Q29A_10}
#' \item{IMPQ29A_11}{Imputation flag for Q29A_11}
#' \item{IMPQ29A_12}{Imputation flag for Q29A_12}
#' \item{IMPQ29A_13}{Imputation flag for Q29A_13}
#' \item{IMPQ29A_14}{Imputation flag for Q29A_14}
#' \item{IMPQ29A_15}{Imputation flag for Q29A_15}
#' \item{IMPQ29A_16}{Imputation flag for Q29A_16}
#' \item{IMPQ29A_17}{Imputation flag for Q29A_17}
#' \item{IMPQ29A_18}{Imputation flag for Q29A_18}
#' \item{IMPQ29A_19}{Imputation flag for Q29A_19}
#' }
"nursing_work"
