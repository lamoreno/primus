{smcl}
{* *! version 1.0.0  11nov2017}{...}
{viewerdialog primus "dialog primus"}{...}
{vieweralsosee "[PRIMUS] intro" "mansection PRIMUS intro"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[PRIMUS] Glossary" "help primus_glossary"}{...}
{vieweralsosee "[PRIMUS] intro substantive" "help primus_intro_substantive"}{...}
{vieweralsosee "[PRIMUS] styles" "help primus_styles"}{...}
{vieweralsosee "[PRIMUS] workflow" "help primus_workflow"}{...}
{viewerjumpto "Description" "primus##description"}{...}
{viewerjumpto "Remarks" "primus##remarks"}{...}
{viewerjumpto "Acknowledgments" "primus##ack"}{...}
{title:Title}

{hline}
help for {cmd:primus} {right:World Bank/Poverty and Equity GP - GSG1}
{hline}

{p2colset 5 19 21 2}{...}
{p2col :{manlink PRIMUS intro} {hline 2}}Introduction to primus - PRIMUS packages{p_end}
{p2colreset}{...}

{p 8 9 9}
{it:[Suggestion:  Read}
{bf:{help primus_intro_substantive:[PRIMUS] intro substantive}}
{it:first.]}


{marker description}{...}
{title:Description}

    {c TLC}{hline 62}{c TRC}
    {c |} The {cmd:primus} suite of commands deals approval of poverty {col 68}{c |}
    {c |} indicators based on the microdata submitted to PRIMUS. {col 68}{c |}
    {c |} Currently, there are three approval roles in the system. {col 68}{c |}
    {c |} They are Regional team, DECDG, and Povcalnet {col 68}{c |}
    {c |}{col 68}{c |}
    {c |} To become familiar with {cmd:primus} as quickly as possible,{col 68}{c |}
    {c |} you can do the following{col 68}{c |}
    {c |}{col 68}{c |}
    {c |}    1.  See {it:{help sae##example:A simple example}} under {...}
{bf:{help sae##remarks:Remarks}} below.{col 68}{c |}
    {c |}{col 68}{c |}
    {c |}    2.  To upload the data into PRIMUS, see{col 68}{c |}
    {c |}        {bf:{help primus_upload:[PRIMUS] primus upload}}{col 68}{c |}    
    {c |}{col 68}{c |}
    {c |}    3.  To query the status of PRIMUS transaction, see{col 68}{c |}
    {c |}        {bf:{help primus_query:[PRIMUS] primus query}}{col 68}{c |}
    {c |}{col 68}{c |}
    {c |}    4.  To download the indicators submitted into PRIMUS, see{col 68}{c |}
    {c |}        {bf:{help primus_download:[PRIMUS] primus download}}{col 68}{c |}
    {c |}{col 68}{c |}
    {c |}    5.  To act (confirm, reject, or approved) transactions in {col 68}{c |}
    {c |}        in PRIMUS, see{col 68}{c |}
    {c |}        {bf:{help primus_action:[PRIMUS] primus action}}{col 68}{c |}
    {c BLC}{hline 62}{c BRC}


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
Remarks are presented under the following headings:

	{help primus##example:A simple example}
	

{marker example}{...}
{title:{it:A simple example}}

{pstd}
Step 1. We are about to upload GEO 2015 data into PRIMUS:

{phang}{cmd:. primus, countrycode(GEO) year(2015) welfare(gallT) welfaretype(CONS) welfshprosperity(gallT2) welfshprtype(CONS) weight(weight1) weighttype(FW) hsize(hhsize) hhid(hhid1) cpi(cpi2011) cpiperiod(year) ppp(icp2011) welfaredef(gallT) urban(urb) survey("HIS") vermast("`vermast_p'") harmonization(ECAPOV) veralt("`veralt_p'") othervariables(quarter gallT2) icpbase(2011) save13 module(GPWG) output(C:Temp\test.xlsx)} {p_end}

{pstd}
Step 2. We then query the status of the PRIMUS transactions with the overall status as PENDING, either for the ECA region as a whole or by the transaction ID reported above. 

{phang}{cmd:. primus query, overallstatus(PENDING)} {p_end}
{pstd}

{pstd} 
Step 3. We then download the indicators submitted to PRIMUS based on the data you sent in Step 1.

{phang}{cmd:. primus download, tranxid(TRN-000008971-ECA-GEO-U0FHW)} {p_end}

{pstd} Step 4. After you check and confirm the poverty and inequality numbers in PRIMUS system, you can act on it with ONE of the follow choices: 

{phang}{cmd:. primus action, tranxid(TRN-000008971-ECA-GEO-U0FHW) indexid(1) decision(CONFIRMED)} {p_end}
{pstd} 4a. User put a "CONFIRMED" action on the transaction, this is the first step of the PRIMUS workflow. After the confirmation of the Uploader, the transaction will be available for the approvers to act upon.

{phang}{cmd:. primus action, tranxid(TRN-000008971-ECA-GEO-U0FHW) decision(approved)} {p_end}
{pstd} 4b. User put a "APPROVED" action on the transaction. This is only possible when Uploader had confirmed or no one from the approver's role have act upon the transaction. Transaction cannot be approved/rejected more than one or change the action after it goes through.

{phang}{cmd:. primus action, tranxid(TRN-000008971-ECA-GEO-U0FHW) indexid(1) decision(rejected) comments(The numbers are not correct due to chanegs in welfare)} {p_end}
{pstd} 4c. User put a "REJECTED" action on the transaction. In this case, it could be the rejection from the uploader role or from the approver role, depending on the stage of the transaction ID. Comments are required for any rejections.

{marker order}{...}
{title:{it:Suggested reading order}}

{p 4 4 2}
The order of suggested reading of this manual is

	{bf:[PRIMUS] intro} 
	{bf:{help primus_upload:[PRIMUS] primus upload}}	
	{bf:{help primus_query:[PRIMUS] primus query}}
	{bf:{help primus_download:[PRIMUS] primus download}} 
	{bf:{help primus_action:[PRIMUS] primus action}}

{p 4 4 2}
Programmers will want to see 
{bf:{help primus_technical:[PRIMUS] technical}}.

{marker references}{...}
{title:References}
{marker R2004}{...}
{p 4 8 2}
Authors. 2018.
    {browse "http://www.worldbank.org":PRIMUS workflow.}
    {it:Working Paper} 1: 1-8. 
	
{p 4 4 2} List of papers here.
{p_end}

{title:Authors}	
	{p 4 4 2}World Bank{p_end}

{title:Thanks for citing {cmd:primus} as follows}

{p 4 4 2}{cmd: primus} is a user-written program that is freely distributed to the research community. {p_end}

{p 4 4 2}Please use the following citation:{p_end}
{p 4 4 2}World Bank. (2017). “{cmd:primus}: Stata module to ...”. World Bank.
{p_end}

{title:Acknowledgements}
    {p 4 4 2}We would like to thank .... 
	All errors and ommissions are exclusively our responsibility.{p_end}
