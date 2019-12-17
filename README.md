# primus - Stata ado files
The World Bank Group monitors and reports statistics on poverty and shared prosperity in order to operationalize and monitor its “twin goals.” This involves a process for data collection, production, review, and dissemination among multiple teams within the organization. 

The Primus system is designed to facilitate this process of generating internal estimates of the World Bank’s poverty indicators and reduce the time needed for resolving discrepancies. It is a workflow management platform for the submission, review and approval of poverty estimates and a tracking facility to capture the inputs and results of the estimation process for future reference and audits.

The Primus ado files for Stata in this GitHub repo are a critical component of this process. These allow for data sharing and file upload service that ensures that estimations are based on identical source data. 

The SM20 version (released in December 2019) incorporates the following changes to the SM19 version: 

-	Age can now be a decimal for individuals younger than 5 yrs, consistent with GMD 2.0 specifications
-	The following variables (previously optional) are now mandatory in every GMD upload: imp_wat_rec, imp_san_rec, landphone, cellphone, computer, electricity. Primus now gives an error message if a user attempts to upload a GMD file without these variables. 
-	Fixed an minor error in the variable check for empstat
-	The CPI database now allows for uploading multiple surveys within a given year. Please note that it is not necessary to include cpi and ppp in the upload file, since these will be automatically merged later. We now use V04 of the CPI database, unlike V03 in the SM19 files.

Please send any suggestions for improvement to the D4G Central Team (Nobuo Yoshida and Minh Cong Nguyen) or to Ani Rudra Silwal (asilwal@worldbank.org).
