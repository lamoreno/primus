*! version 0.1.1  12Sep2014
*! Copyright (C) World Bank 2017-2024 

* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.

* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.

* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.

cap program drop primus_download
program primus_download, rclass
	version 16.0
	syntax [anything], [TRANxid(string) FILElist INDicator meta Folders EXPlore PROCessid(string) COUNtry(string) Year(string) SURVname(string)]	
	
	*global errcodep 0
	
	tempfile primusout
	if "`meta'"~="" & "`folders'"~="" {
		noi dis as error "One option is allowed: meta or folders, not together."
		global errcodep = 1
		error 198
	}
	
	if "`filelist'"~="" & "`indicator'"~="" {
		noi dis as error "One option is allowed: filelist or indicator, not together."
		global errcodep = 1
		error 198
	}
	
	//4 meta server list
	if "`meta'"~="" {
		primus_api, option(4) outfile(`primusout')
		if `primusrc'==0 {
			cap insheet using "`primusout'", clear
			if _rc==0 {
				noi dis as text in yellow "PRIMUS metadata is loaded in Stata. Browse and see."
			}
			else {
				noi dis as error "Unknow error - Unable to load the meta datafile."	
				global errcodep `=_rc'
				error `=_rc'
			}			
		}
		else {
			primus_message, error(`=_rc')
			global errcodep `=_rc'			
			error 1						
		}
	} //meta
	
	//5 folder and file ext based on processid
	if "`folders'"~="" {
		if "`processid'"~="" {
			primus_api, option(5) query("processid=`processid'&server=${webserver}") outfile(`primusout')
			if `primusrc'==0 {
				cap insheet using "`primusout'", clear
				if _rc==0 {
					noi dis as text in yellow "PRIMUS folder structure and file extensions is loaded in Stata. Browse and see."
				}
				else {
					noi dis as error "Unknow error - Unable to load the meta datafile."	
					global errcodep `=_rc'
					error `=_rc'	
				}			
			}
			else {
				primus_message, error(`=_rc')
				global errcodep `=_rc'			
				error 1						
			}
		}
		else {
			noi dis as error "Processid() is needed with "folders" option. For example, primus download, folders processid(6)"
			global errcodep = 198
			error 198
		}
	} //folders
	
	//Explore survname across the system
	if "`explore'"~="" {
		local RequestKey server=${webserver}

		local loclist country year survname 
		foreach loc of local loclist {
			if "``loc''" ~="" {
				local `loc' `=upper("``loc''")'
				if "`loc'"=="country" | "`loc'"=="year" | "`loc'"=="tranxid" {
					local `loc' :  subinstr local `loc' " " "", all					
					local RequestKey `RequestKey'&`loc'=``loc''
				}
				else { //other locs with checks
					if `=wordcount("``loc''")' > 1 {
						noi disp in red `"The input on the `loc'() is not correct. Available options are: ``loc'list'; and one region at a time."'
						global errcodep = 198
						error 198
					}
					else {
						if (!inlist("``loc''",``loc'list')) {
							noi disp in red `"The input on the region() is not correct. Available options are: ``loc'list'."'
							global errcodep = 198
							error 198
						}
						else {							
							local RequestKey `RequestKey'&``loc'key'=``loc''
						}
					}
				}	
			} //real loc	
		} //loclist
		
		primus_api, option(7) query("`RequestKey'") outfile(`primusout')
		if `primusrc'==0 {
			cap insheet using "`primusout'", clear
			if _rc==0 {
				noi dis as text in yellow "PRIMUS survnames are loaded in Stata. Browse and see."
			}
			else {
				noi dis as error "Unknow error - Unable to load the meta datafile."	
				global errcodep `=_rc'
				error `=_rc'		
			}			
		}
		else {
			primus_message, error(`=_rc')
			global errcodep `=_rc'			
			error 1						
		}
	} //explore
	
	//Load transactions details of harmonized process and file list in a transaction
	if "`tranxid'"~="" {
		if `= wordcount("`tranxid'")' > 1 {
			local tranxid0
			foreach tranx of local tranxid {
				if "`tranxid0'"~=""  local tranxid0 "`tranxid0',`tranx'"
				else local tranxid0 `tranx'
			}
		}
		else local tranxid0 `tranxid'
		if "`indicator'"~="" local option 2a
		if "`filelist'"~="" local option 2b
		
		primus_api, option(`option') query("tranx=`tranxid0'&processid=`processid'&server=${webserver}") outfile(`primusout')
		if `primusrc'==0 {
			cap insheet using "`primusout'", clear
			if _rc==0 {
				noi dis as text in yellow "PRIMUS data is loaded in Stata. Browse and see."
			}
			else {
				noi dis as error "Unknow error - Unable to load the meta datafile."	
				global errcodep `=_rc'
				error `=_rc'	
			}			
		}
		else {
			primus_message, error(`=_rc')
			global errcodep `=_rc'			
			error 1						
		}		
	} //tranxid
	
end
