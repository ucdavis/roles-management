module UcdLookups
	MAJORS = {}
	DEPT_CODES = {}
	TITLE_CODES = {}
  
  MANUAL_INCLUDES = ['aeguyer','millerlm','djmoglen','mebalvin','mckinney','ssantam','tmheath','rnanakul','olichney','sukkim','jpokorny','bgrunewa','rabronst','kbaynes','szneena','pcmundy','wjarrold','julieluu','steichho','chuff','cmachado','alamsyah','schuang','clare186','ladyd252','aheusser','pkubitz','kshap','bbrelles','blmiss','pjdegenn','cdaniels','jyiwang','anschnei','eaisham','ralatif','cwbishop','fddiaz','jinchen','ajkou','sphan127','ndelie','weidner']
  
  DEPT_TRANSLATIONS = {
      'AFRICAN AMERICAN AFRICAN STDS' => 'HISTORY',
      'ASIAN AMERICAN' => 'HISTORY',
      'CALIFORNIA NATIONAL PRIMATE RESEARCH CENTER (CNPRC)' => 'PSYCHOLOGY',
      'CENTER FOR MIND & BRAIN' => 'CENTER FOR MIND AND BRAIN',
      'CENTER FOR NEUROSCIENCE' => 'PSYCHOLOGY',
      'DSS IT SHARED SERVICE CENTER' => 'DSS IT SERVICE CENTER',
      'History' => 'HISTORY',
      'HISTORY PROJECT UCD' => 'HISTORY PROJECT',
      'INTERCOLLEGIATE ATHLETICS (ICA)' => 'PHYSICAL EDUCATION PROGRAM',
      'Middle East/South Asia Stds Prog' => 'MIDDLE EAST/SOUTH ASIA PROGRAM',
      'PRIMATE CENTER' => 'PSYCHOLOGY',
      'HUMAN AND COMMUNITY DEVELOPMENT' => 'CENTER FOR MIND AND BRAIN',
      'HUMAN & COMMUNITY DEVELOPMENT' => 'CENTER FOR MIND AND BRAIN',
      'UCDHS: NEUROLOGY, DEPARTMENT OF : MED' => 'CENTER FOR MIND AND BRAIN',
      'UCDHS: NEUROLOGY, DEPARTMENT OF : MED' => 'CENTER FOR MIND AND BRAIN',
      'UCDHS: PEDS CHILD DEVELOPMENT' => 'CENTER FOR MIND AND BRAIN',
      'UCDHS: PSYCHIATRY AND BEHAVIORAL SCIENCES, DEPT OF' => 'CENTER FOR MIND AND BRAIN',
      'MED:PSYCHIATRY & BEHAV SCI' => 'CENTER FOR MIND AND BRAIN',
      'MED:PSYCHIATRY & BEHAV SCI' => 'CENTER FOR MIND AND BRAIN',
      'MED:PSYCHIATRY & BEHAV SCI' => 'CENTER FOR MIND AND BRAIN',
      'NEUROLOGY: MED' => 'CENTER FOR MIND AND BRAIN',
      'EDUCATION - PH.D.' => 'CENTER FOR MIND AND BRAIN',
      'EDUCATION, School of' => 'CENTER FOR MIND AND BRAIN',
      'BIOMEDICAL ENGINEERING' => 'CENTER FOR MIND AND BRAIN',
      'NEUROSCIENCE' => 'CENTER FOR MIND AND BRAIN',
      'ENVIRONMENTAL TOXICOLOGY' => 'ANTHROPOLOGY',
      'TEMPORARY EMPLOYMENT SERVICES (TES)' => 'TEMPORARY EMPLOYMENT SERVICES',
      'MICROBIOLOGY' => 'DSS IT SERVICE CENTER'
  }
  
	MAJORS["Anthropology"] = "040020"
	MAJORS["Linguistics"] = "040210"
	MAJORS["Philosophy"] = "040250"
	MAJORS["Psychology"] = "040290"
	MAJORS["Political Science"] = "040280"
	MAJORS["Communication"] = "040310"
	MAJORS["Economics"] = "040110"
	MAJORS["Sociology"] = "040320"
	MAJORS["History"] = "040180"

	DEPT_CODES["040325"] = {}
		DEPT_CODES["040325"]["name"] = "SOCIAL SCIENCES PROGRAM"
		DEPT_CODES["040325"]["company"] = "040390"
		DEPT_CODES["040325"]["manager"] = "laklkegr"

	DEPT_CODES["040027"] = {}
		DEPT_CODES["040027"]["name"] = "MIDDLE EAST/SOUTH ASIA PROGRAM"
		DEPT_CODES["040027"]["company"] = "040390"
		DEPT_CODES["040027"]["manager"] = "laklkegr"

	DEPT_CODES["040280"] = {}
		DEPT_CODES["040280"]["name"] = "POLITICAL SCIENCE"
		DEPT_CODES["040280"]["company"] = "040114"
		DEPT_CODES["040280"]["manager"] = "cckoga"

	DEPT_CODES["040110"] = {}
		DEPT_CODES["040110"]["name"] = "ECONOMICS"
		DEPT_CODES["040110"]["company"] = "040111"
		DEPT_CODES["040110"]["manager"] = "keminer"

	DEPT_CODES["040390"] = {}
		DEPT_CODES["040390"]["name"] = "COM, PHIL & LIN RED CLUSTER"
		DEPT_CODES["040390"]["company"] = "040390"
		DEPT_CODES["040390"]["manager"] = "laklkegr"

	DEPT_CODES["040320"] = {}
		DEPT_CODES["040320"]["name"] = "SOCIOLOGY"
		DEPT_CODES["040320"]["company"] = "040112"
		DEPT_CODES["040320"]["manager"] = "bandit"

	DEPT_CODES["040385"] = {}
		DEPT_CODES["040385"]["name"] = "CTR: HISTORY,SOCIETY & CULTURE"
		DEPT_CODES["040385"]["company"] = "040390"
		DEPT_CODES["040385"]["manager"] = "laklkegr"

	DEPT_CODES["040290"] = {}
		DEPT_CODES["040290"]["name"] = "PSYCHOLOGY"
		DEPT_CODES["040290"]["company"] = "040113"
		DEPT_CODES["040290"]["manager"] = "crcasell"

	DEPT_CODES["040360"] = {}
		DEPT_CODES["040360"]["name"] = "INTERNATIONAL RELATIONS"
		DEPT_CODES["040360"]["company"] = "040114"
		DEPT_CODES["040360"]["manager"] = "cckoga"

	DEPT_CODES["040256"] = {}
		DEPT_CODES["040256"]["name"] = "CENTER FOR INNOVATION STUDIES"
		DEPT_CODES["040256"]["company"] = "040390"
		DEPT_CODES["040256"]["manager"] = "laklkegr"

	DEPT_CODES["040076"] = {}
		DEPT_CODES["040076"]["name"] = "SOCIAL SCIENCES COMPUTING LAB"
		DEPT_CODES["040076"]["company"] = "040114"
		DEPT_CODES["040076"]["manager"] = "cckoga"

	DEPT_CODES["040250"] = {}
		DEPT_CODES["040250"]["name"] = "PHILOSOPHY"
		DEPT_CODES["040250"]["company"] = "040390"
		DEPT_CODES["040250"]["manager"] = "laklkegr"

	DEPT_CODES["040014"] = {}
		DEPT_CODES["040014"]["name"] = "DSS IT SHARED SERVICE CENTER"
		DEPT_CODES["040014"]["company"] = "040008"
		DEPT_CODES["040014"]["manager"] = "jeremy"

	DEPT_CODES["040017"] = {}
		DEPT_CODES["040017"]["name"] = "DSS RESEARCH SERVICE CENTER"
		DEPT_CODES["040017"]["company"] = "040008"
		DEPT_CODES["040017"]["manager"] = "rmtapia"

	DEPT_CODES["040016"] = {}
		DEPT_CODES["040016"]["name"] = "DSS HR/PAYROLL SERVICE CENTER"
		DEPT_CODES["040016"]["company"] = "040008"
		DEPT_CODES["040016"]["manager"] = "srroth"

	DEPT_CODES["040114"] = {}
		DEPT_CODES["040114"]["name"] = "POLI SCI, IR ORANGE CLUSTER"
		DEPT_CODES["040114"]["company"] = "040114"
		DEPT_CODES["040114"]["manager"] = "cckoga"

	DEPT_CODES["040115"] = {}
		DEPT_CODES["040115"]["name"] = "UC CENTER SACRAMENTO"
		DEPT_CODES["040115"]["company"] = "040114"
		DEPT_CODES["040115"]["manager"] = "cckoga"

	DEPT_CODES["040008"] = {}
		DEPT_CODES["040008"]["name"] = "L&S DEANS - SOCIAL SCIENCES"
		DEPT_CODES["040008"]["company"] = "040008"
		DEPT_CODES["040008"]["manager"] = "srroth"

	DEPT_CODES["040009"] = {}
		DEPT_CODES["040009"]["name"] = "HEMISPHERIC INSTITUTE-AMERICAS"
		DEPT_CODES["040009"]["company"] = "040390"
		DEPT_CODES["040009"]["manager"] = "laklkegr"

	DEPT_CODES["040020"] = {}
		DEPT_CODES["040020"]["name"] = "ANTHROPOLOGY"
		DEPT_CODES["040020"]["company"] = "040112"
		DEPT_CODES["040020"]["manager"] = "bandit"

	DEPT_CODES["040111"] = {}
		DEPT_CODES["040111"]["name"] = "ECON, HIS, MS BLUE CLUSTER"
		DEPT_CODES["040111"]["company"] = "040111"
		DEPT_CODES["040111"]["manager"] = "keminer"

	DEPT_CODES["040112"] = {}
		DEPT_CODES["040112"]["name"] = "ANT, SOC GREEN CLUSTER"
		DEPT_CODES["040112"]["company"] = "040112"
		DEPT_CODES["040112"]["manager"] = "bandit"

	DEPT_CODES["040113"] = {}
		DEPT_CODES["040113"]["name"] = "PSYCH, CMB YELLOW CLUSTER"
		DEPT_CODES["040113"]["company"] = "040113"
		DEPT_CODES["040113"]["manager"] = "crcasell"

	DEPT_CODES["040235"] = {}
		DEPT_CODES["040235"]["name"] = "CENTER FOR MIND & BRAIN"
		DEPT_CODES["040235"]["company"] = "040113"
		DEPT_CODES["040235"]["manager"] = "crcasell"

	DEPT_CODES["040182"] = {}
		DEPT_CODES["040182"]["name"] = "CALIFORNIA HISTORY SS PROJECT"
		DEPT_CODES["040182"]["company"] = "040111"
		DEPT_CODES["040182"]["manager"] = "mctygue"

	DEPT_CODES["040181"] = {}
		DEPT_CODES["040181"]["name"] = "HISTORY PROJECT UCD"
		DEPT_CODES["040181"]["company"] = "040111"
		DEPT_CODES["040181"]["manager"] = "ptindall"

	DEPT_CODES["040180"] = {}
		DEPT_CODES["040180"]["name"] = "HISTORY"
		DEPT_CODES["040180"]["company"] = "040111"
		DEPT_CODES["040180"]["manager"] = "keminer"

	DEPT_CODES["040230"] = {}
		DEPT_CODES["040230"]["name"] = "MILITARY SCIENCE"
		DEPT_CODES["040230"]["company"] = "040111"
		DEPT_CODES["040230"]["manager"] = "keminer"

	DEPT_CODES["040150"] = {}
		DEPT_CODES["040150"]["name"] = "GEOGRAPHY"
		DEPT_CODES["040150"]["company"] = "040390"
		DEPT_CODES["040150"]["manager"] = "laklkegr"

	DEPT_CODES["040310"] = {}
		DEPT_CODES["040310"]["name"] = "COMMUNICATION"
		DEPT_CODES["040310"]["company"] = "040390"
		DEPT_CODES["040310"]["manager"] = "laklkegr"

	DEPT_CODES["040265"] = {}
		DEPT_CODES["040265"]["name"] = "PHYSICAL EDUCATION PROGRAM"
		DEPT_CODES["040265"]["company"] = "040008"
		DEPT_CODES["040265"]["manager"] = "srroth"

	DEPT_CODES["040026"] = {}
		DEPT_CODES["040026"]["name"] = "EAST ASIAN STUDIES PROGRAM"
		DEPT_CODES["040026"]["company"] = "040390"
		DEPT_CODES["040026"]["manager"] = "laklkegr"

	DEPT_CODES["040255"] = {}
		DEPT_CODES["040255"]["name"] = "SCIENCE & TECHNOLOGY STUDIES"
		DEPT_CODES["040255"]["company"] = "040390"
		DEPT_CODES["040255"]["manager"] = "laklkegr"

	DEPT_CODES["040210"] = {}
		DEPT_CODES["040210"]["name"] = "LINGUISTICS"
		DEPT_CODES["040210"]["company"] = "040390"
		DEPT_CODES["040210"]["manager"] = "laklkegr"


	TITLE_CODES["4726"] = {}
		TITLE_CODES["4726"]["title"] = "_____ASSISTANT III-SUPVR"
		TITLE_CODES["4726"]["program"] = "PSS"
		TITLE_CODES["4726"]["unit"] = "99"

	TITLE_CODES["4721"] = {}
		TITLE_CODES["4721"]["title"] = "ABSTRACTOR, PAT REC III-SUPVR"
		TITLE_CODES["4721"]["program"] = "PSS"
		TITLE_CODES["4721"]["unit"] = "99"

	TITLE_CODES["7611"] = {}
		TITLE_CODES["7611"]["title"] = "ACCOUNTANT IV - SUPERVISOR"
		TITLE_CODES["7611"]["program"] = "PSS"
		TITLE_CODES["7611"]["unit"] = "99"

	TITLE_CODES["8148"] = {}
		TITLE_CODES["8148"]["title"] = "FARM MAINTENANCE WORKER, SR"
		TITLE_CODES["8148"]["program"] = "PSS"
		TITLE_CODES["8148"]["unit"] = "SX"

	TITLE_CODES["6306"] = {}
		TITLE_CODES["6306"]["title"] = "PUBLIC INFO REP, SR - SUPERV"
		TITLE_CODES["6306"]["program"] = "PSS"
		TITLE_CODES["6306"]["unit"] = "99"

	TITLE_CODES["8304"] = {}
		TITLE_CODES["8304"]["title"] = "TECHNICIAN,ELECTRONICS,TRAINEE"
		TITLE_CODES["8304"]["program"] = "PSS"
		TITLE_CODES["8304"]["unit"] = "TX"

	TITLE_CODES["4022"] = {}
		TITLE_CODES["4022"]["title"] = "REFEREE/UMPIRE"
		TITLE_CODES["4022"]["program"] = "PSS"
		TITLE_CODES["4022"]["unit"] = "99"

	TITLE_CODES["8302"] = {}
		TITLE_CODES["8302"]["title"] = "TECHNICIAN, ELECTRONICS, SR"
		TITLE_CODES["8302"]["program"] = "PSS"
		TITLE_CODES["8302"]["unit"] = "TX"

	TITLE_CODES["8301"] = {}
		TITLE_CODES["8301"]["title"] = "TECHNICIAN, ELECTRONICS, PRIN"
		TITLE_CODES["8301"]["program"] = "PSS"
		TITLE_CODES["8301"]["unit"] = "TX"

	TITLE_CODES["4021"] = {}
		TITLE_CODES["4021"]["title"] = "SPORTS ASSISTANT"
		TITLE_CODES["4021"]["program"] = "PSS"
		TITLE_CODES["4021"]["unit"] = "SX"

	TITLE_CODES["8267"] = {}
		TITLE_CODES["8267"]["title"] = "LOCKSMITH, APPRENTICE"
		TITLE_CODES["8267"]["program"] = "PSS"
		TITLE_CODES["8267"]["unit"] = "K3"

	TITLE_CODES["4722"] = {}
		TITLE_CODES["4722"]["title"] = "_____ASSISTANT III"
		TITLE_CODES["4722"]["program"] = "PSS"
		TITLE_CODES["4722"]["unit"] = "CX"

	TITLE_CODES["6952"] = {}
		TITLE_CODES["6952"]["title"] = "SENIOR ARCHITECT - SUPERVISOR"
		TITLE_CODES["6952"]["program"] = "PSS"
		TITLE_CODES["6952"]["unit"] = "99"

	TITLE_CODES["9073"] = {}
		TITLE_CODES["9073"]["title"] = "RADIATION EQUIP SPECIALIST"
		TITLE_CODES["9073"]["program"] = "PSS"
		TITLE_CODES["9073"]["unit"] = "EX"

	TITLE_CODES["5821"] = {}
		TITLE_CODES["5821"]["title"] = "LINEN SERV WKER, SR HEAD"
		TITLE_CODES["5821"]["program"] = "PSS"
		TITLE_CODES["5821"]["unit"] = "SX"

	TITLE_CODES["5822"] = {}
		TITLE_CODES["5822"]["title"] = "LINEN SERVICE WORKER, HEAD"
		TITLE_CODES["5822"]["program"] = "PSS"
		TITLE_CODES["5822"]["unit"] = "SX"

	TITLE_CODES["8093"] = {}
		TITLE_CODES["8093"]["title"] = "COGEN OPERATOR, APPRENTICE"
		TITLE_CODES["8093"]["program"] = "PSS"
		TITLE_CODES["8093"]["unit"] = "K3"

	TITLE_CODES["5824"] = {}
		TITLE_CODES["5824"]["title"] = "LINEN SERV WKER, SR HEAD-SUPVR"
		TITLE_CODES["5824"]["program"] = "PSS"
		TITLE_CODES["5824"]["unit"] = "99"

	TITLE_CODES["8090"] = {}
		TITLE_CODES["8090"]["title"] = "IRRIGATION SPECIALIST"
		TITLE_CODES["8090"]["program"] = "PSS"
		TITLE_CODES["8090"]["unit"] = "SX"

	TITLE_CODES["3720"] = {}
		TITLE_CODES["3720"]["title"] = "ASST FACULTY CONSULTANT IN----"
		TITLE_CODES["3720"]["program"] = "ACADEMIC"
		TITLE_CODES["3720"]["unit"] = "99"

	TITLE_CODES["9320"] = {}
		TITLE_CODES["9320"]["title"] = "COMMUNITY HEALTH PROGRAM CHIEF"
		TITLE_CODES["9320"]["program"] = "PSS"
		TITLE_CODES["9320"]["unit"] = "99"

	TITLE_CODES["8261"] = {}
		TITLE_CODES["8261"]["title"] = "HIGH VOLT ELECTRICIAN, APPREN"
		TITLE_CODES["8261"]["program"] = "PSS"
		TITLE_CODES["8261"]["unit"] = "K3"

	TITLE_CODES["7512"] = {}
		TITLE_CODES["7512"]["title"] = "MANAGEMENT SERVICES OFFICER I"
		TITLE_CODES["7512"]["program"] = "PSS"
		TITLE_CODES["7512"]["unit"] = "99"

	TITLE_CODES["3999"] = {}
		TITLE_CODES["3999"]["title"] = "MISCELLANEOUS"
		TITLE_CODES["3999"]["program"] = "ACADEMIC"
		TITLE_CODES["3999"]["unit"] = "99"

	TITLE_CODES["3998"] = {}
		TITLE_CODES["3998"]["title"] = "SALARY SUPPLEMENTATION"
		TITLE_CODES["3998"]["program"] = "ACADEMIC"
		TITLE_CODES["3998"]["unit"] = "87"

	TITLE_CODES["8885"] = {}
		TITLE_CODES["8885"]["title"] = "SPECIALIST, CLINICAL"
		TITLE_CODES["8885"]["program"] = "PSS"
		TITLE_CODES["8885"]["unit"] = "99"

	TITLE_CODES["3995"] = {}
		TITLE_CODES["3995"]["title"] = "EAP-TEMP FACULTY HOUSING ALLOW"
		TITLE_CODES["3995"]["program"] = "ACADEMIC"
		TITLE_CODES["3995"]["unit"] = "87"

	TITLE_CODES["5651"] = {}
		TITLE_CODES["5651"]["title"] = "FOOD SERVICE WORKER, SR"
		TITLE_CODES["5651"]["program"] = "PSS"
		TITLE_CODES["5651"]["unit"] = "SX"

	TITLE_CODES["3993"] = {}
		TITLE_CODES["3993"]["title"] = "FACULTY RECRUITMENT ALLOWANCE"
		TITLE_CODES["3993"]["program"] = "ACADEMIC"
		TITLE_CODES["3993"]["unit"] = "87"

	TITLE_CODES["3991"] = {}
		TITLE_CODES["3991"]["title"] = "ADDL COMP-VETERANS ADMIN SRVC"
		TITLE_CODES["3991"]["program"] = "ACADEMIC"
		TITLE_CODES["3991"]["unit"] = "87"

	TITLE_CODES["3990"] = {}
		TITLE_CODES["3990"]["title"] = "ADDL COMP-HGH&OLIVE VIEW MCS"
		TITLE_CODES["3990"]["program"] = "ACADEMIC"
		TITLE_CODES["3990"]["unit"] = "87"

	TITLE_CODES["8184"] = {}
		TITLE_CODES["8184"]["title"] = "MECHANIC, HVAC, LEAD"
		TITLE_CODES["8184"]["program"] = "PSS"
		TITLE_CODES["8184"]["unit"] = "K3"

	TITLE_CODES["3005"] = {}
		TITLE_CODES["3005"]["title"] = "_____ IN THE A.E.S.-F.E.R.P."
		TITLE_CODES["3005"]["program"] = "ACADEMIC"
		TITLE_CODES["3005"]["unit"] = "FX"

	TITLE_CODES["6099"] = {}
		TITLE_CODES["6099"]["title"] = "PRINCIPAL ARTIST - SUPERVISOR"
		TITLE_CODES["6099"]["program"] = "PSS"
		TITLE_CODES["6099"]["unit"] = "99"

	TITLE_CODES["7624"] = {}
		TITLE_CODES["7624"]["title"] = "AUDITOR II"
		TITLE_CODES["7624"]["program"] = "PSS"
		TITLE_CODES["7624"]["unit"] = "99"

	TITLE_CODES["9612"] = {}
		TITLE_CODES["9612"]["title"] = "STAFF RESEARCH ASSOC II"
		TITLE_CODES["9612"]["program"] = "PSS"
		TITLE_CODES["9612"]["unit"] = "RX"

	TITLE_CODES["4732"] = {}
		TITLE_CODES["4732"]["title"] = "CODER, HEALTH INFORMATION IV"
		TITLE_CODES["4732"]["program"] = "PSS"
		TITLE_CODES["4732"]["unit"] = "EX"

	TITLE_CODES["4733"] = {}
		TITLE_CODES["4733"]["title"] = "CODER, HEALTH INFORMATION III"
		TITLE_CODES["4733"]["program"] = "PSS"
		TITLE_CODES["4733"]["unit"] = "EX"

	TITLE_CODES["4730"] = {}
		TITLE_CODES["4730"]["title"] = " ---ASSISTANT II, PER DIEM"
		TITLE_CODES["4730"]["program"] = "PSS"
		TITLE_CODES["4730"]["unit"] = "CX"

	TITLE_CODES["4731"] = {}
		TITLE_CODES["4731"]["title"] = " ---ASSISTANT III, PER DIEM"
		TITLE_CODES["4731"]["program"] = "PSS"
		TITLE_CODES["4731"]["unit"] = "CX"

	TITLE_CODES["8307"] = {}
		TITLE_CODES["8307"]["title"] = "BLDG MAINTENANCE WRKR, MC"
		TITLE_CODES["8307"]["program"] = "PSS"
		TITLE_CODES["8307"]["unit"] = "SX"

	TITLE_CODES["1974"] = {}
		TITLE_CODES["1974"]["title"] = "ACT ASSOC PROF-AY-BUS/ECON/ENG"
		TITLE_CODES["1974"]["program"] = "ACADEMIC"
		TITLE_CODES["1974"]["unit"] = "A3"

	TITLE_CODES["2312"] = {}
		TITLE_CODES["2312"]["title"] = "TEACHING ASST.-GSHIP/NON-REP"
		TITLE_CODES["2312"]["program"] = "ACADEMIC"
		TITLE_CODES["2312"]["unit"] = "99"

	TITLE_CODES["2313"] = {}
		TITLE_CODES["2313"]["title"] = "TEACHG ASST.-NON-GSHIP/NON-REP"
		TITLE_CODES["2313"]["program"] = "ACADEMIC"
		TITLE_CODES["2313"]["unit"] = "99"

	TITLE_CODES["2310"] = {}
		TITLE_CODES["2310"]["title"] = "TEACHING ASSISTANT - GSHIP"
		TITLE_CODES["2310"]["program"] = "ACADEMIC"
		TITLE_CODES["2310"]["unit"] = "BX"

	TITLE_CODES["2311"] = {}
		TITLE_CODES["2311"]["title"] = "TEACHING ASSISTANT-NON-GSHIP"
		TITLE_CODES["2311"]["program"] = "ACADEMIC"
		TITLE_CODES["2311"]["unit"] = "BX"

	TITLE_CODES["8303"] = {}
		TITLE_CODES["8303"]["title"] = "TECHNICIAN, ELECTRONICS"
		TITLE_CODES["8303"]["program"] = "PSS"
		TITLE_CODES["8303"]["unit"] = "TX"

	TITLE_CODES["8957"] = {}
		TITLE_CODES["8957"]["title"] = "SCIENTIST,CLIN LAB,APPRENTICE"
		TITLE_CODES["8957"]["program"] = "PSS"
		TITLE_CODES["8957"]["unit"] = "HX"

	TITLE_CODES["199"] = {}
		TITLE_CODES["199"]["title"] = "SPEC LV SAL W EXEC & SEARLES"
		TITLE_CODES["199"]["program"] = "MSP"
		TITLE_CODES["199"]["unit"] = "99"

	TITLE_CODES["198"] = {}
		TITLE_CODES["198"]["title"] = "TEMP SALARY SUPP WITH EXEC TTL"
		TITLE_CODES["198"]["program"] = "MSP"
		TITLE_CODES["198"]["unit"] = "99"

	TITLE_CODES["195"] = {}
		TITLE_CODES["195"]["title"] = "SUM DIFF WITH EXEC TITLE"
		TITLE_CODES["195"]["program"] = "MSP"
		TITLE_CODES["195"]["unit"] = "99"

	TITLE_CODES["197"] = {}
		TITLE_CODES["197"]["title"] = "SPEC LV SAL WITH EXEC CONT"
		TITLE_CODES["197"]["program"] = "MSP"
		TITLE_CODES["197"]["unit"] = "99"

	TITLE_CODES["196"] = {}
		TITLE_CODES["196"]["title"] = "ADMIN STIPEND WITH EXEC TITLE"
		TITLE_CODES["196"]["program"] = "MSP"
		TITLE_CODES["196"]["unit"] = "99"

	TITLE_CODES["7678"] = {}
		TITLE_CODES["7678"]["title"] = "PUBLICATIONS MANAGER, SR"
		TITLE_CODES["7678"]["program"] = "PSS"
		TITLE_CODES["7678"]["unit"] = "99"

	TITLE_CODES["8263"] = {}
		TITLE_CODES["8263"]["title"] = "UPHOLSTERER"
		TITLE_CODES["8263"]["program"] = "PSS"
		TITLE_CODES["8263"]["unit"] = "TX"

	TITLE_CODES["8880"] = {}
		TITLE_CODES["8880"]["title"] = "SPECIALIST, CLINICAL"
		TITLE_CODES["8880"]["program"] = "PSS"
		TITLE_CODES["8880"]["unit"] = "99"

	TITLE_CODES["3234"] = {}
		TITLE_CODES["3234"]["title"] = "ASSOC FIELD PROGRAM SUPERVISOR"
		TITLE_CODES["3234"]["program"] = "ACADEMIC"
		TITLE_CODES["3234"]["unit"] = "FX"

	TITLE_CODES["6344"] = {}
		TITLE_CODES["6344"]["title"] = "STAGE HELPER"
		TITLE_CODES["6344"]["program"] = "PSS"
		TITLE_CODES["6344"]["unit"] = "TX"

	TITLE_CODES["4659"] = {}
		TITLE_CODES["4659"]["title"] = "BILLER, PATIENT V - SUPERVISOR"
		TITLE_CODES["4659"]["program"] = "PSS"
		TITLE_CODES["4659"]["unit"] = "99"

	TITLE_CODES["8898"] = {}
		TITLE_CODES["8898"]["title"] = "ANESTHESIA TECHNICIAN II"
		TITLE_CODES["8898"]["program"] = "PSS"
		TITLE_CODES["8898"]["unit"] = "EX"

	TITLE_CODES["1454"] = {}
		TITLE_CODES["1454"]["title"] = "ASSOC PROF OF CLIN_____-HCOMP"
		TITLE_CODES["1454"]["program"] = "ACADEMIC"
		TITLE_CODES["1454"]["unit"] = "A3"

	TITLE_CODES["1455"] = {}
		TITLE_CODES["1455"]["title"] = "ASST PROF OF CLIN_____-HCOMP"
		TITLE_CODES["1455"]["program"] = "ACADEMIC"
		TITLE_CODES["1455"]["unit"] = "A3"

	TITLE_CODES["8209"] = {}
		TITLE_CODES["8209"]["title"] = "REFRIGERATION MECH, APPRENTICE"
		TITLE_CODES["8209"]["program"] = "PSS"
		TITLE_CODES["8209"]["unit"] = "K3"

	TITLE_CODES["1456"] = {}
		TITLE_CODES["1456"]["title"] = "PROF OF CLIN___-GENCOMP-B"
		TITLE_CODES["1456"]["program"] = "ACADEMIC"
		TITLE_CODES["1456"]["unit"] = "A3"

	TITLE_CODES["8881"] = {}
		TITLE_CODES["8881"]["title"] = "SPECIALIST, CLINICAL, SUPVR"
		TITLE_CODES["8881"]["program"] = "PSS"
		TITLE_CODES["8881"]["unit"] = "99"

	TITLE_CODES["1457"] = {}
		TITLE_CODES["1457"]["title"] = "ASO PROF OF CLIN___-GENCOMP-B"
		TITLE_CODES["1457"]["program"] = "ACADEMIC"
		TITLE_CODES["1457"]["unit"] = "A3"

	TITLE_CODES["8207"] = {}
		TITLE_CODES["8207"]["title"] = "CABINET MAKER, APPRENTICE"
		TITLE_CODES["8207"]["program"] = "PSS"
		TITLE_CODES["8207"]["unit"] = "K3"

	TITLE_CODES["1450"] = {}
		TITLE_CODES["1450"]["title"] = "PROFESSOR OF CLINICAL_____-FY"
		TITLE_CODES["1450"]["program"] = "ACADEMIC"
		TITLE_CODES["1450"]["unit"] = "A3"

	TITLE_CODES["2260"] = {}
		TITLE_CODES["2260"]["title"] = "FIELD WORK CONSULTANT-ACAD YR"
		TITLE_CODES["2260"]["program"] = "ACADEMIC"
		TITLE_CODES["2260"]["unit"] = "IX"

	TITLE_CODES["2261"] = {}
		TITLE_CODES["2261"]["title"] = "FLD.WORK CONSULT-AY-CONTINUING"
		TITLE_CODES["2261"]["program"] = "ACADEMIC"
		TITLE_CODES["2261"]["unit"] = "IX"

	TITLE_CODES["2266"] = {}
		TITLE_CODES["2266"]["title"] = "FLD.WORK CONSULT-FY-CONTINUING"
		TITLE_CODES["2266"]["program"] = "ACADEMIC"
		TITLE_CODES["2266"]["unit"] = "IX"

	TITLE_CODES["1451"] = {}
		TITLE_CODES["1451"]["title"] = "ASSOC PROF OF CLINICAL_____-FY"
		TITLE_CODES["1451"]["program"] = "ACADEMIC"
		TITLE_CODES["1451"]["unit"] = "A3"

	TITLE_CODES["3580"] = {}
		TITLE_CODES["3580"]["title"] = "COURSE AUTHOR- UNIV EXTENSION"
		TITLE_CODES["3580"]["program"] = "ACADEMIC"
		TITLE_CODES["3580"]["unit"] = "99"

	TITLE_CODES["9154"] = {}
		TITLE_CODES["9154"]["title"] = "BIOMEDICAL EQUIPMENT TECH IV"
		TITLE_CODES["9154"]["program"] = "PSS"
		TITLE_CODES["9154"]["unit"] = "EX"

	TITLE_CODES["9157"] = {}
		TITLE_CODES["9157"]["title"] = "BIOMEDICAL EQUIPMENT TECH I"
		TITLE_CODES["9157"]["program"] = "PSS"
		TITLE_CODES["9157"]["unit"] = "EX"

	TITLE_CODES["9156"] = {}
		TITLE_CODES["9156"]["title"] = "BIOMEDICAL EQUIPMENT TECH II"
		TITLE_CODES["9156"]["program"] = "PSS"
		TITLE_CODES["9156"]["unit"] = "EX"

	TITLE_CODES["9151"] = {}
		TITLE_CODES["9151"]["title"] = "MENTAL HEALTH THERAPIST I"
		TITLE_CODES["9151"]["program"] = "PSS"
		TITLE_CODES["9151"]["unit"] = "HX"

	TITLE_CODES["1452"] = {}
		TITLE_CODES["1452"]["title"] = "ASST PROF OF CLINICAL_____-FY"
		TITLE_CODES["1452"]["program"] = "ACADEMIC"
		TITLE_CODES["1452"]["unit"] = "A3"

	TITLE_CODES["3001"] = {}
		TITLE_CODES["3001"]["title"] = " -----IN THE A.E.S.-SFT-VM"
		TITLE_CODES["3001"]["program"] = "ACADEMIC"
		TITLE_CODES["3001"]["unit"] = "FX"

	TITLE_CODES["9152"] = {}
		TITLE_CODES["9152"]["title"] = "MENTAL HEALTH THERAPIST II"
		TITLE_CODES["9152"]["program"] = "PSS"
		TITLE_CODES["9152"]["unit"] = "HX"

	TITLE_CODES["9256"] = {}
		TITLE_CODES["9256"]["title"] = "____ASSISTANT, HOSP, II-SUPVR"
		TITLE_CODES["9256"]["program"] = "PSS"
		TITLE_CODES["9256"]["unit"] = "99"

	TITLE_CODES["9257"] = {}
		TITLE_CODES["9257"]["title"] = "HOSPITAL UNIT SERV COORD III"
		TITLE_CODES["9257"]["program"] = "PSS"
		TITLE_CODES["9257"]["unit"] = "EX"

	TITLE_CODES["9526"] = {}
		TITLE_CODES["9526"]["title"] = "TECHNICIAN, ANIMAL, ASST"
		TITLE_CODES["9526"]["program"] = "PSS"
		TITLE_CODES["9526"]["unit"] = "SX"

	TITLE_CODES["1453"] = {}
		TITLE_CODES["1453"]["title"] = "PROFESSOR OF CLINICAL___-HCOMP"
		TITLE_CODES["1453"]["program"] = "ACADEMIC"
		TITLE_CODES["1453"]["unit"] = "A3"

	TITLE_CODES["9252"] = {}
		TITLE_CODES["9252"]["title"] = "____ASSISTANT, HOSPITAL, II"
		TITLE_CODES["9252"]["program"] = "PSS"
		TITLE_CODES["9252"]["unit"] = "EX"

	TITLE_CODES["9253"] = {}
		TITLE_CODES["9253"]["title"] = " -ASSISTANT, HOSPITAL, I"
		TITLE_CODES["9253"]["program"] = "PSS"
		TITLE_CODES["9253"]["unit"] = "EX"

	TITLE_CODES["9250"] = {}
		TITLE_CODES["9250"]["title"] = "PHARMACIST II, PER DIEM"
		TITLE_CODES["9250"]["program"] = "PSS"
		TITLE_CODES["9250"]["unit"] = "HX"

	TITLE_CODES["9251"] = {}
		TITLE_CODES["9251"]["title"] = "____ASSISTANT, HOSPITAL, III"
		TITLE_CODES["9251"]["program"] = "PSS"
		TITLE_CODES["9251"]["unit"] = "EX"

	TITLE_CODES["8075"] = {}
		TITLE_CODES["8075"]["title"] = "LABORER, LEAD"
		TITLE_CODES["8075"]["program"] = "PSS"
		TITLE_CODES["8075"]["unit"] = "SX"

	TITLE_CODES["108"] = {}
		TITLE_CODES["108"]["title"] = "DEAN (FUNCTL AREA)-EXEC"
		TITLE_CODES["108"]["program"] = "MSP"
		TITLE_CODES["108"]["unit"] = "99"

	TITLE_CODES["109"] = {}
		TITLE_CODES["109"]["title"] = "(FTL AREA)DEAN (FTL AREA)-EXEC"
		TITLE_CODES["109"]["program"] = "MSP"
		TITLE_CODES["109"]["unit"] = "99"

	TITLE_CODES["102"] = {}
		TITLE_CODES["102"]["title"] = "(FUNCTL AREA) OFFICER-EXEC"
		TITLE_CODES["102"]["program"] = "MSP"
		TITLE_CODES["102"]["unit"] = "99"

	TITLE_CODES["103"] = {}
		TITLE_CODES["103"]["title"] = "(FTL AREA) OF (FTL AREA)-EXEC"
		TITLE_CODES["103"]["program"] = "MSP"
		TITLE_CODES["103"]["unit"] = "99"

	TITLE_CODES["100"] = {}
		TITLE_CODES["100"]["title"] = "MANAGEMENT PROGRAM(UNTITLED)"
		TITLE_CODES["100"]["program"] = "MSP"
		TITLE_CODES["100"]["unit"] = "99"

	TITLE_CODES["101"] = {}
		TITLE_CODES["101"]["title"] = "(FUNCTL AREA) MANAGER-EXEC"
		TITLE_CODES["101"]["program"] = "MSP"
		TITLE_CODES["101"]["unit"] = "99"

	TITLE_CODES["106"] = {}
		TITLE_CODES["106"]["title"] = "COORDINATOR (FUNCTL AREA)-EXEC"
		TITLE_CODES["106"]["program"] = "MSP"
		TITLE_CODES["106"]["unit"] = "99"

	TITLE_CODES["107"] = {}
		TITLE_CODES["107"]["title"] = "(FUNCTL AREA)COORDINATOR-EXEC"
		TITLE_CODES["107"]["program"] = "MSP"
		TITLE_CODES["107"]["unit"] = "99"

	TITLE_CODES["104"] = {}
		TITLE_CODES["104"]["title"] = "ADMINISTRATOR (FTL AREA)-EXEC"
		TITLE_CODES["104"]["program"] = "MSP"
		TITLE_CODES["104"]["unit"] = "99"

	TITLE_CODES["105"] = {}
		TITLE_CODES["105"]["title"] = "(FTL AREA) ADMINISTRATOR-EXEC"
		TITLE_CODES["105"]["program"] = "MSP"
		TITLE_CODES["105"]["unit"] = "99"

	TITLE_CODES["4813"] = {}
		TITLE_CODES["4813"]["title"] = "COMPUTER OPERATOR"
		TITLE_CODES["4813"]["program"] = "PSS"
		TITLE_CODES["4813"]["unit"] = "TX"

	TITLE_CODES["4620"] = {}
		TITLE_CODES["4620"]["title"] = "COLLECTIONS MANAGER"
		TITLE_CODES["4620"]["program"] = "PSS"
		TITLE_CODES["4620"]["unit"] = "99"

	TITLE_CODES["900"] = {}
		TITLE_CODES["900"]["title"] = "DIRECTOR"
		TITLE_CODES["900"]["program"] = "ACADEMIC"
		TITLE_CODES["900"]["unit"] = "99"

	TITLE_CODES["4810"] = {}
		TITLE_CODES["4810"]["title"] = "COMPUTER OPERATIONS SUPV, SR"
		TITLE_CODES["4810"]["program"] = "PSS"
		TITLE_CODES["4810"]["unit"] = "99"

	TITLE_CODES["3000"] = {}
		TITLE_CODES["3000"]["title"] = " ----- IN THE A.E.S."
		TITLE_CODES["3000"]["program"] = "ACADEMIC"
		TITLE_CODES["3000"]["unit"] = "FX"

	TITLE_CODES["907"] = {}
		TITLE_CODES["907"]["title"] = "ACTING DIRECTOR"
		TITLE_CODES["907"]["program"] = "ACADEMIC"
		TITLE_CODES["907"]["unit"] = "99"

	TITLE_CODES["2040"] = {}
		TITLE_CODES["2040"]["title"] = "HS ASST CLIN PROFESSOR-ACAD YR"
		TITLE_CODES["2040"]["program"] = "ACADEMIC"
		TITLE_CODES["2040"]["unit"] = "99"

	TITLE_CODES["2041"] = {}
		TITLE_CODES["2041"]["title"] = "ASST CLIN PROF-DENT-50%/+ AY"
		TITLE_CODES["2041"]["program"] = "ACADEMIC"
		TITLE_CODES["2041"]["unit"] = "99"

	TITLE_CODES["4422"] = {}
		TITLE_CODES["4422"]["title"] = "COUNSELOR I"
		TITLE_CODES["4422"]["program"] = "PSS"
		TITLE_CODES["4422"]["unit"] = "99"

	TITLE_CODES["1511"] = {}
		TITLE_CODES["1511"]["title"] = "ASSOCIATE IN __- FY-GSHIP"
		TITLE_CODES["1511"]["program"] = "ACADEMIC"
		TITLE_CODES["1511"]["unit"] = "BX"

	TITLE_CODES["4420"] = {}
		TITLE_CODES["4420"]["title"] = "COUNSELOR SUPERVISOR"
		TITLE_CODES["4420"]["program"] = "PSS"
		TITLE_CODES["4420"]["unit"] = "99"

	TITLE_CODES["4421"] = {}
		TITLE_CODES["4421"]["title"] = "COUNSELOR II"
		TITLE_CODES["4421"]["program"] = "PSS"
		TITLE_CODES["4421"]["unit"] = "99"

	TITLE_CODES["9499"] = {}
		TITLE_CODES["9499"]["title"] = "THERAPIST, OCCUPATIONAL I"
		TITLE_CODES["9499"]["program"] = "PSS"
		TITLE_CODES["9499"]["unit"] = "HX"

	TITLE_CODES["9285"] = {}
		TITLE_CODES["9285"]["title"] = "COUNSELOR, GENETIC III"
		TITLE_CODES["9285"]["program"] = "PSS"
		TITLE_CODES["9285"]["unit"] = "HX"

	TITLE_CODES["9238"] = {}
		TITLE_CODES["9238"]["title"] = "PHARMACIST-SUPERVISOR"
		TITLE_CODES["9238"]["program"] = "PSS"
		TITLE_CODES["9238"]["unit"] = "99"

	TITLE_CODES["9284"] = {}
		TITLE_CODES["9284"]["title"] = "COUNSELOR, GENETIC III-SUPV"
		TITLE_CODES["9284"]["program"] = "PSS"
		TITLE_CODES["9284"]["unit"] = "99"

	TITLE_CODES["4952"] = {}
		TITLE_CODES["4952"]["title"] = "WORD PROCESSING SPECIALIST, SR"
		TITLE_CODES["4952"]["program"] = "PSS"
		TITLE_CODES["4952"]["unit"] = "CX"

	TITLE_CODES["4953"] = {}
		TITLE_CODES["4953"]["title"] = "WORD PROCESSING SPECIALIST"
		TITLE_CODES["4953"]["program"] = "PSS"
		TITLE_CODES["4953"]["unit"] = "CX"

	TITLE_CODES["4950"] = {}
		TITLE_CODES["4950"]["title"] = "WORD PROCESSING SUPVR"
		TITLE_CODES["4950"]["program"] = "PSS"
		TITLE_CODES["4950"]["unit"] = "99"

	TITLE_CODES["1512"] = {}
		TITLE_CODES["1512"]["title"] = "ASSOCIATE IN __-FY-NON-GSHIP"
		TITLE_CODES["1512"]["program"] = "ACADEMIC"
		TITLE_CODES["1512"]["unit"] = "BX"

	TITLE_CODES["2160"] = {}
		TITLE_CODES["2160"]["title"] = "JR SUPRVSR OF PHYS ED-ACAD YR"
		TITLE_CODES["2160"]["program"] = "ACADEMIC"
		TITLE_CODES["2160"]["unit"] = "99"

	TITLE_CODES["9286"] = {}
		TITLE_CODES["9286"]["title"] = "COUNSELOR, GENETIC II-SUPV"
		TITLE_CODES["9286"]["program"] = "PSS"
		TITLE_CODES["9286"]["unit"] = "99"

	TITLE_CODES["9341"] = {}
		TITLE_CODES["9341"]["title"] = "SOCIAL WORK ASSOCIATE"
		TITLE_CODES["9341"]["program"] = "PSS"
		TITLE_CODES["9341"]["unit"] = "HX"

	TITLE_CODES["9281"] = {}
		TITLE_CODES["9281"]["title"] = "PHARMACY TECHNICIAN III"
		TITLE_CODES["9281"]["program"] = "PSS"
		TITLE_CODES["9281"]["unit"] = "EX"

	TITLE_CODES["9342"] = {}
		TITLE_CODES["9342"]["title"] = "SOCIAL WORK ASSOCIATE, ASST"
		TITLE_CODES["9342"]["program"] = "PSS"
		TITLE_CODES["9342"]["unit"] = "HX"

	TITLE_CODES["8919"] = {}
		TITLE_CODES["8919"]["title"] = "TECHNICIAN, EMERG TRAUMA, SR"
		TITLE_CODES["8919"]["program"] = "PSS"
		TITLE_CODES["8919"]["unit"] = "EX"

	TITLE_CODES["9328"] = {}
		TITLE_CODES["9328"]["title"] = "CLIN RESEARCH COORD SUPERVISOR"
		TITLE_CODES["9328"]["program"] = "PSS"
		TITLE_CODES["9328"]["unit"] = "99"

	TITLE_CODES["5116"] = {}
		TITLE_CODES["5116"]["title"] = "CUSTODIAN, SR"
		TITLE_CODES["5116"]["program"] = "PSS"
		TITLE_CODES["5116"]["unit"] = "SX"

	TITLE_CODES["3298"] = {}
		TITLE_CODES["3298"]["title"] = "RESEARCH ASSOCIATE(W/O SALARY)"
		TITLE_CODES["3298"]["program"] = "ACADEMIC"
		TITLE_CODES["3298"]["unit"] = "99"

	TITLE_CODES["1908"] = {}
		TITLE_CODES["1908"]["title"] = "ASST ADJUNCT PROFESSOR-SFT-VM"
		TITLE_CODES["1908"]["program"] = "ACADEMIC"
		TITLE_CODES["1908"]["unit"] = "99"

	TITLE_CODES["1909"] = {}
		TITLE_CODES["1909"]["title"] = "ASSOC ADJUNCT PROFESSOR-SFT-VM"
		TITLE_CODES["1909"]["program"] = "ACADEMIC"
		TITLE_CODES["1909"]["unit"] = "99"

	TITLE_CODES["1906"] = {}
		TITLE_CODES["1906"]["title"] = "PROFESSOR IN RESIDENCE-SFT-VM"
		TITLE_CODES["1906"]["program"] = "ACADEMIC"
		TITLE_CODES["1906"]["unit"] = "A3"

	TITLE_CODES["1907"] = {}
		TITLE_CODES["1907"]["title"] = "ADJUNCT INSTRUCTOR-SFT-VM"
		TITLE_CODES["1907"]["program"] = "ACADEMIC"
		TITLE_CODES["1907"]["unit"] = "99"

	TITLE_CODES["1904"] = {}
		TITLE_CODES["1904"]["title"] = "ASST PROF IN RESIDENCE-SFT-VM"
		TITLE_CODES["1904"]["program"] = "ACADEMIC"
		TITLE_CODES["1904"]["unit"] = "A3"

	TITLE_CODES["1905"] = {}
		TITLE_CODES["1905"]["title"] = "ASSOC PROF IN RESIDENCE-SFT-VM"
		TITLE_CODES["1905"]["program"] = "ACADEMIC"
		TITLE_CODES["1905"]["unit"] = "A3"

	TITLE_CODES["1902"] = {}
		TITLE_CODES["1902"]["title"] = "ACTING PROFESSOR-SFT-VM"
		TITLE_CODES["1902"]["program"] = "ACADEMIC"
		TITLE_CODES["1902"]["unit"] = "A3"

	TITLE_CODES["1903"] = {}
		TITLE_CODES["1903"]["title"] = "INSTR IN RESIDENCE-SFT-VM"
		TITLE_CODES["1903"]["program"] = "ACADEMIC"
		TITLE_CODES["1903"]["unit"] = "A3"

	TITLE_CODES["1900"] = {}
		TITLE_CODES["1900"]["title"] = "ACTING ASSOC PROFESSOR-SFT-VM"
		TITLE_CODES["1900"]["program"] = "ACADEMIC"
		TITLE_CODES["1900"]["unit"] = "A3"

	TITLE_CODES["1901"] = {}
		TITLE_CODES["1901"]["title"] = "PROFESSOR-SFT-VM"
		TITLE_CODES["1901"]["program"] = "ACADEMIC"
		TITLE_CODES["1901"]["unit"] = "A3"

	TITLE_CODES["8941"] = {}
		TITLE_CODES["8941"]["title"] = "TECHNICIAN, ECHOCARDIO, PRIN"
		TITLE_CODES["8941"]["program"] = "PSS"
		TITLE_CODES["8941"]["unit"] = "EX"

	TITLE_CODES["8940"] = {}
		TITLE_CODES["8940"]["title"] = "SCIENTIST, CLINICAL LAB"
		TITLE_CODES["8940"]["program"] = "PSS"
		TITLE_CODES["8940"]["unit"] = "HX"

	TITLE_CODES["8943"] = {}
		TITLE_CODES["8943"]["title"] = "TECHNICIAN, ECHOCARDIOGRAPHIC"
		TITLE_CODES["8943"]["program"] = "PSS"
		TITLE_CODES["8943"]["unit"] = "EX"

	TITLE_CODES["3451"] = {}
		TITLE_CODES["3451"]["title"] = "ASSOC COOP EXT ADVISOR"
		TITLE_CODES["3451"]["program"] = "ACADEMIC"
		TITLE_CODES["3451"]["unit"] = "FX"

	TITLE_CODES["8945"] = {}
		TITLE_CODES["8945"]["title"] = "PHYSICAL THERAPY ASSISTANT II"
		TITLE_CODES["8945"]["program"] = "PSS"
		TITLE_CODES["8945"]["unit"] = "EX"

	TITLE_CODES["5113"] = {}
		TITLE_CODES["5113"]["title"] = "CUSTODIAN, LEAD"
		TITLE_CODES["5113"]["program"] = "PSS"
		TITLE_CODES["5113"]["unit"] = "SX"

	TITLE_CODES["8947"] = {}
		TITLE_CODES["8947"]["title"] = "CERT OCCUP THERAPY ASST III"
		TITLE_CODES["8947"]["program"] = "PSS"
		TITLE_CODES["8947"]["unit"] = "EX"

	TITLE_CODES["8946"] = {}
		TITLE_CODES["8946"]["title"] = "PHYSICAL THERAPY ASSISTANT I"
		TITLE_CODES["8946"]["program"] = "PSS"
		TITLE_CODES["8946"]["unit"] = "EX"

	TITLE_CODES["3513"] = {}
		TITLE_CODES["3513"]["title"] = "COORD OF PUBLIC PROGRAMS II"
		TITLE_CODES["3513"]["program"] = "ACADEMIC"
		TITLE_CODES["3513"]["unit"] = "FX"

	TITLE_CODES["7264"] = {}
		TITLE_CODES["7264"]["title"] = "ANALYST, PUBLIC ADMIN, ASST"
		TITLE_CODES["7264"]["program"] = "PSS"
		TITLE_CODES["7264"]["unit"] = "99"

	TITLE_CODES["3511"] = {}
		TITLE_CODES["3511"]["title"] = "COORD OF PUBLIC PROGRAMS III"
		TITLE_CODES["3511"]["program"] = "ACADEMIC"
		TITLE_CODES["3511"]["unit"] = "FX"

	TITLE_CODES["9347"] = {}
		TITLE_CODES["9347"]["title"] = "MEDICAL REC ADMIN, PR - SUPVR"
		TITLE_CODES["9347"]["program"] = "PSS"
		TITLE_CODES["9347"]["unit"] = "99"

	TITLE_CODES["7261"] = {}
		TITLE_CODES["7261"]["title"] = "ANALYST,PUBLIC ADMINISTR, PRIN"
		TITLE_CODES["7261"]["program"] = "PSS"
		TITLE_CODES["7261"]["unit"] = "99"

	TITLE_CODES["7260"] = {}
		TITLE_CODES["7260"]["title"] = "PUBLIC ADMIN ANALYST SUPV"
		TITLE_CODES["7260"]["program"] = "PSS"
		TITLE_CODES["7260"]["unit"] = "99"

	TITLE_CODES["3515"] = {}
		TITLE_CODES["3515"]["title"] = "COORD OF PUBLIC PROGRAMS I"
		TITLE_CODES["3515"]["program"] = "ACADEMIC"
		TITLE_CODES["3515"]["unit"] = "FX"

	TITLE_CODES["7262"] = {}
		TITLE_CODES["7262"]["title"] = "ANALYST,PUBLIC ADMINISTRAT, SR"
		TITLE_CODES["7262"]["program"] = "PSS"
		TITLE_CODES["7262"]["unit"] = "99"

	TITLE_CODES["9348"] = {}
		TITLE_CODES["9348"]["title"] = "MEDICAL REC ADMIN, SR - SUPVR"
		TITLE_CODES["9348"]["program"] = "PSS"
		TITLE_CODES["9348"]["unit"] = "99"

	TITLE_CODES["6203"] = {}
		TITLE_CODES["6203"]["title"] = "PROJECTIONIST"
		TITLE_CODES["6203"]["program"] = "PSS"
		TITLE_CODES["6203"]["unit"] = "TX"

	TITLE_CODES["8300"] = {}
		TITLE_CODES["8300"]["title"] = "TECHNICIAN, ELECTRONICS, SUPVR"
		TITLE_CODES["8300"]["program"] = "PSS"
		TITLE_CODES["8300"]["unit"] = "99"

	TITLE_CODES["7781"] = {}
		TITLE_CODES["7781"]["title"] = "BUYER II - SUPERVISOR"
		TITLE_CODES["7781"]["program"] = "PSS"
		TITLE_CODES["7781"]["unit"] = "99"

	TITLE_CODES["1785"] = {}
		TITLE_CODES["1785"]["title"] = "ASSOC PROF IN RES-FY-MEDCOMP"
		TITLE_CODES["1785"]["program"] = "ACADEMIC"
		TITLE_CODES["1785"]["unit"] = "A3"

	TITLE_CODES["9041"] = {}
		TITLE_CODES["9041"]["title"] = "PROSTHETIST/ORTHOTIST, SR"
		TITLE_CODES["9041"]["program"] = "PSS"
		TITLE_CODES["9041"]["unit"] = "EX"

	TITLE_CODES["8044"] = {}
		TITLE_CODES["8044"]["title"] = "OPTOMETRIST, SR-SUPVR"
		TITLE_CODES["8044"]["program"] = "PSS"
		TITLE_CODES["8044"]["unit"] = "99"

	TITLE_CODES["7511"] = {}
		TITLE_CODES["7511"]["title"] = "MANAGEMENT SERVICES OFFICER II"
		TITLE_CODES["7511"]["program"] = "PSS"
		TITLE_CODES["7511"]["unit"] = "99"

	TITLE_CODES["9329"] = {}
		TITLE_CODES["9329"]["title"] = "CLIN RESEARCH COORD SUPVSR, SR"
		TITLE_CODES["9329"]["program"] = "PSS"
		TITLE_CODES["9329"]["unit"] = "99"

	TITLE_CODES["5119"] = {}
		TITLE_CODES["5119"]["title"] = "CUSTODIAN SUPV, ASST."
		TITLE_CODES["5119"]["program"] = "PSS"
		TITLE_CODES["5119"]["unit"] = "99"

	TITLE_CODES["7510"] = {}
		TITLE_CODES["7510"]["title"] = "MANAGEMENT SERVS OFFICER III"
		TITLE_CODES["7510"]["program"] = "PSS"
		TITLE_CODES["7510"]["unit"] = "99"

	TITLE_CODES["7162"] = {}
		TITLE_CODES["7162"]["title"] = "ENGINEERING AID, SR"
		TITLE_CODES["7162"]["program"] = "PSS"
		TITLE_CODES["7162"]["unit"] = "TX"

	TITLE_CODES["3018"] = {}
		TITLE_CODES["3018"]["title"] = "VST ASSOC ----- IN THE A.E.S."
		TITLE_CODES["3018"]["program"] = "ACADEMIC"
		TITLE_CODES["3018"]["unit"] = "99"

	TITLE_CODES["5424"] = {}
		TITLE_CODES["5424"]["title"] = "DIETITIAN, SR"
		TITLE_CODES["5424"]["program"] = "PSS"
		TITLE_CODES["5424"]["unit"] = "99"

	TITLE_CODES["99"] = {}
		TITLE_CODES["99"]["title"] = "MANAGER (FUNCTL AREA)-EXEC"
		TITLE_CODES["99"]["program"] = "MSP"
		TITLE_CODES["99"]["unit"] = "99"

	TITLE_CODES["98"] = {}
		TITLE_CODES["98"]["title"] = "(FTL AREA) DIR (FTL AREA)-EXEC"
		TITLE_CODES["98"]["program"] = "MSP"
		TITLE_CODES["98"]["unit"] = "99"

	TITLE_CODES["3392"] = {}
		TITLE_CODES["3392"]["title"] = "ASSOC PROJECT_____-FISCAL YEAR"
		TITLE_CODES["3392"]["program"] = "ACADEMIC"
		TITLE_CODES["3392"]["unit"] = "FX"

	TITLE_CODES["9028"] = {}
		TITLE_CODES["9028"]["title"] = "PERFUSIONIST"
		TITLE_CODES["9028"]["program"] = "PSS"
		TITLE_CODES["9028"]["unit"] = "EX"

	TITLE_CODES["8015"] = {}
		TITLE_CODES["8015"]["title"] = "COMM HEALTH PROG REP-SUPVR"
		TITLE_CODES["8015"]["program"] = "PSS"
		TITLE_CODES["8015"]["unit"] = "99"

	TITLE_CODES["8904"] = {}
		TITLE_CODES["8904"]["title"] = "HOSPITAL ASST, SR"
		TITLE_CODES["8904"]["program"] = "PSS"
		TITLE_CODES["8904"]["unit"] = "EX"

	TITLE_CODES["91"] = {}
		TITLE_CODES["91"]["title"] = "ASST V CHAN (FUNCTL AREA)-EXEC"
		TITLE_CODES["91"]["program"] = "MSP"
		TITLE_CODES["91"]["unit"] = "99"

	TITLE_CODES["90"] = {}
		TITLE_CODES["90"]["title"] = "ASSO V CHAN (FUNCTL AREA)-EXEC"
		TITLE_CODES["90"]["program"] = "MSP"
		TITLE_CODES["90"]["unit"] = "99"

	TITLE_CODES["93"] = {}
		TITLE_CODES["93"]["title"] = "DIRECTOR (FUNCTL AREA)-EXEC"
		TITLE_CODES["93"]["program"] = "MSP"
		TITLE_CODES["93"]["unit"] = "99"

	TITLE_CODES["92"] = {}
		TITLE_CODES["92"]["title"] = "ASST V CHAN (SAFETY)-EXEC"
		TITLE_CODES["92"]["program"] = "MSP"
		TITLE_CODES["92"]["unit"] = "99"

	TITLE_CODES["95"] = {}
		TITLE_CODES["95"]["title"] = "ASSOC DIR (FUNCTL AREA)-EXEC"
		TITLE_CODES["95"]["program"] = "MSP"
		TITLE_CODES["95"]["unit"] = "99"

	TITLE_CODES["94"] = {}
		TITLE_CODES["94"]["title"] = "DEPUTY DIR (FUNCTL AREA)-EXEC"
		TITLE_CODES["94"]["program"] = "MSP"
		TITLE_CODES["94"]["unit"] = "99"

	TITLE_CODES["97"] = {}
		TITLE_CODES["97"]["title"] = "(FUNCTL AREA) DIRECTOR-EXEC"
		TITLE_CODES["97"]["program"] = "MSP"
		TITLE_CODES["97"]["unit"] = "99"

	TITLE_CODES["96"] = {}
		TITLE_CODES["96"]["title"] = "ASST DIR (FUNCTL AREA)-EXEC"
		TITLE_CODES["96"]["program"] = "MSP"
		TITLE_CODES["96"]["unit"] = "99"

	TITLE_CODES["1623"] = {}
		TITLE_CODES["1623"]["title"] = "SENIOR LECTURER SOE-GENCOMP-B"
		TITLE_CODES["1623"]["program"] = "ACADEMIC"
		TITLE_CODES["1623"]["unit"] = "A3"

	TITLE_CODES["1622"] = {}
		TITLE_CODES["1622"]["title"] = "LECTURER SOE-GENCOMP-B"
		TITLE_CODES["1622"]["program"] = "ACADEMIC"
		TITLE_CODES["1622"]["unit"] = "A3"

	TITLE_CODES["1621"] = {}
		TITLE_CODES["1621"]["title"] = "SR LECT W/SEC EMPL EMERITUS"
		TITLE_CODES["1621"]["program"] = "ACADEMIC"
		TITLE_CODES["1621"]["unit"] = "A3"

	TITLE_CODES["1620"] = {}
		TITLE_CODES["1620"]["title"] = "LECTURER W/SEC EMPL EMERITUS"
		TITLE_CODES["1620"]["program"] = "ACADEMIC"
		TITLE_CODES["1620"]["unit"] = "A3"

	TITLE_CODES["1627"] = {}
		TITLE_CODES["1627"]["title"] = "SENIOR LECTURER SOE-FY-MEDCOMP"
		TITLE_CODES["1627"]["program"] = "ACADEMIC"
		TITLE_CODES["1627"]["unit"] = "A3"

	TITLE_CODES["1626"] = {}
		TITLE_CODES["1626"]["title"] = "LECTURER SOE-FY-MEDCOMP"
		TITLE_CODES["1626"]["program"] = "ACADEMIC"
		TITLE_CODES["1626"]["unit"] = "A3"

	TITLE_CODES["1625"] = {}
		TITLE_CODES["1625"]["title"] = "SENIOR LECTURER SOE-GENCOMP-A"
		TITLE_CODES["1625"]["program"] = "ACADEMIC"
		TITLE_CODES["1625"]["unit"] = "A3"

	TITLE_CODES["1624"] = {}
		TITLE_CODES["1624"]["title"] = "LECTURER SOE-GENCOMP-A"
		TITLE_CODES["1624"]["program"] = "ACADEMIC"
		TITLE_CODES["1624"]["unit"] = "A3"

	TITLE_CODES["1629"] = {}
		TITLE_CODES["1629"]["title"] = "SENIOR LECTURER SOE-FY-GENCOMP"
		TITLE_CODES["1629"]["program"] = "ACADEMIC"
		TITLE_CODES["1629"]["unit"] = "A3"

	TITLE_CODES["1628"] = {}
		TITLE_CODES["1628"]["title"] = "LECTURER SOE-FY-GENCOMP"
		TITLE_CODES["1628"]["program"] = "ACADEMIC"
		TITLE_CODES["1628"]["unit"] = "A3"

	TITLE_CODES["3209"] = {}
		TITLE_CODES["3209"]["title"] = "RES ---- - RECALLED"
		TITLE_CODES["3209"]["program"] = "ACADEMIC"
		TITLE_CODES["3209"]["unit"] = "FX"

	TITLE_CODES["3208"] = {}
		TITLE_CODES["3208"]["title"] = "VST RES ---- - FISCAL YEAR"
		TITLE_CODES["3208"]["program"] = "ACADEMIC"
		TITLE_CODES["3208"]["unit"] = "99"

	TITLE_CODES["8935"] = {}
		TITLE_CODES["8935"]["title"] = "TECHNICIAN, ECHO, SR, P.D."
		TITLE_CODES["8935"]["program"] = "PSS"
		TITLE_CODES["8935"]["unit"] = "EX"

	TITLE_CODES["8936"] = {}
		TITLE_CODES["8936"]["title"] = "SCIENTIST SPEC,CLIN LAB,SR SUP"
		TITLE_CODES["8936"]["program"] = "PSS"
		TITLE_CODES["8936"]["unit"] = "99"

	TITLE_CODES["8937"] = {}
		TITLE_CODES["8937"]["title"] = "SCIENTIST,CLIN LAB,SUPERVISING"
		TITLE_CODES["8937"]["program"] = "PSS"
		TITLE_CODES["8937"]["unit"] = "99"

	TITLE_CODES["8930"] = {}
		TITLE_CODES["8930"]["title"] = "TECHNICIAN, SURGICAL, SR"
		TITLE_CODES["8930"]["program"] = "PSS"
		TITLE_CODES["8930"]["unit"] = "EX"

	TITLE_CODES["8931"] = {}
		TITLE_CODES["8931"]["title"] = "TECHNICIAN, SURGICAL"
		TITLE_CODES["8931"]["program"] = "PSS"
		TITLE_CODES["8931"]["unit"] = "EX"

	TITLE_CODES["8932"] = {}
		TITLE_CODES["8932"]["title"] = "TECHNICIAN, SURGICAL, PER DIEM"
		TITLE_CODES["8932"]["program"] = "PSS"
		TITLE_CODES["8932"]["unit"] = "EX"

	TITLE_CODES["3398"] = {}
		TITLE_CODES["3398"]["title"] = "VISITING ASST PROJECT ____-FY"
		TITLE_CODES["3398"]["program"] = "ACADEMIC"
		TITLE_CODES["3398"]["unit"] = "99"

	TITLE_CODES["8938"] = {}
		TITLE_CODES["8938"]["title"] = "SCIENTIST SPEC,CLIN LAB,SR"
		TITLE_CODES["8938"]["program"] = "PSS"
		TITLE_CODES["8938"]["unit"] = "HX"

	TITLE_CODES["8939"] = {}
		TITLE_CODES["8939"]["title"] = "SCIENTIST SPECIALIST,CL LAB"
		TITLE_CODES["8939"]["program"] = "PSS"
		TITLE_CODES["8939"]["unit"] = "HX"

	TITLE_CODES["9183"] = {}
		TITLE_CODES["9183"]["title"] = "OR EQUIPMENT SPECIALIST PD"
		TITLE_CODES["9183"]["program"] = "PSS"
		TITLE_CODES["9183"]["unit"] = "EX"

	TITLE_CODES["740"] = {}
		TITLE_CODES["740"]["title"] = "COMPUTING RESOURCE MANAGER III"
		TITLE_CODES["740"]["program"] = "MSP"
		TITLE_CODES["740"]["unit"] = "99"

	TITLE_CODES["741"] = {}
		TITLE_CODES["741"]["title"] = "COMPUTING RESOURCE MANAGER II"
		TITLE_CODES["741"]["program"] = "MSP"
		TITLE_CODES["741"]["unit"] = "99"

	TITLE_CODES["742"] = {}
		TITLE_CODES["742"]["title"] = "PROGRAMMER/ANALYST IV"
		TITLE_CODES["742"]["program"] = "MSP"
		TITLE_CODES["742"]["unit"] = "99"

	TITLE_CODES["743"] = {}
		TITLE_CODES["743"]["title"] = "MANAGEMENT SERVICES OFFICER IV"
		TITLE_CODES["743"]["program"] = "MSP"
		TITLE_CODES["743"]["unit"] = "99"

	TITLE_CODES["744"] = {}
		TITLE_CODES["744"]["title"] = "COMPUTER RESOURCE MGR III"
		TITLE_CODES["744"]["program"] = "MSP"
		TITLE_CODES["744"]["unit"] = "99"

	TITLE_CODES["745"] = {}
		TITLE_CODES["745"]["title"] = "PATENT ADVISOR III"
		TITLE_CODES["745"]["program"] = "MSP"
		TITLE_CODES["745"]["unit"] = "99"

	TITLE_CODES["746"] = {}
		TITLE_CODES["746"]["title"] = "COMPUTER RESOURCE MGR II"
		TITLE_CODES["746"]["program"] = "MSP"
		TITLE_CODES["746"]["unit"] = "99"

	TITLE_CODES["747"] = {}
		TITLE_CODES["747"]["title"] = "PRINCIPAL ACCOUNTANT"
		TITLE_CODES["747"]["program"] = "MSP"
		TITLE_CODES["747"]["unit"] = "99"

	TITLE_CODES["748"] = {}
		TITLE_CODES["748"]["title"] = "TECHNO IV, COMPUTER & NETWORK"
		TITLE_CODES["748"]["program"] = "MSP"
		TITLE_CODES["748"]["unit"] = "99"

	TITLE_CODES["749"] = {}
		TITLE_CODES["749"]["title"] = "PRINCIPAL AUDITOR"
		TITLE_CODES["749"]["program"] = "MSP"
		TITLE_CODES["749"]["unit"] = "99"

	TITLE_CODES["9181"] = {}
		TITLE_CODES["9181"]["title"] = "RADIOLOGY ASSISTANT, PER DIEM"
		TITLE_CODES["9181"]["program"] = "PSS"
		TITLE_CODES["9181"]["unit"] = "EX"

	TITLE_CODES["7141"] = {}
		TITLE_CODES["7141"]["title"] = "TECHNICIAN, EH&S, PRIN"
		TITLE_CODES["7141"]["program"] = "PSS"
		TITLE_CODES["7141"]["unit"] = "TX"

	TITLE_CODES["3063"] = {}
		TITLE_CODES["3063"]["title"] = " --IN THE AES-B/ECON/ENG-AY-1/9"
		TITLE_CODES["3063"]["program"] = "ACADEMIC"
		TITLE_CODES["3063"]["unit"] = "FX"

	TITLE_CODES["3062"] = {}
		TITLE_CODES["3062"]["title"] = " ---IN THE AES-B/ECON/ENG-AY"
		TITLE_CODES["3062"]["program"] = "ACADEMIC"
		TITLE_CODES["3062"]["unit"] = "FX"

	TITLE_CODES["3061"] = {}
		TITLE_CODES["3061"]["title"] = " --- IN THE AES-ACAD YR - 1/9TH"
		TITLE_CODES["3061"]["program"] = "ACADEMIC"
		TITLE_CODES["3061"]["unit"] = "FX"

	TITLE_CODES["3060"] = {}
		TITLE_CODES["3060"]["title"] = " --- IN THE AES-ACADEMIC YEAR"
		TITLE_CODES["3060"]["program"] = "ACADEMIC"
		TITLE_CODES["3060"]["unit"] = "FX"

	TITLE_CODES["3067"] = {}
		TITLE_CODES["3067"]["title"] = "ACT---IN AES-B/ECON/ENG-AY-1/9"
		TITLE_CODES["3067"]["program"] = "ACADEMIC"
		TITLE_CODES["3067"]["unit"] = "99"

	TITLE_CODES["3066"] = {}
		TITLE_CODES["3066"]["title"] = "ACT---IN THE AES-B/ECON/ENG-AY"
		TITLE_CODES["3066"]["program"] = "ACADEMIC"
		TITLE_CODES["3066"]["unit"] = "99"

	TITLE_CODES["3065"] = {}
		TITLE_CODES["3065"]["title"] = "ACT --- IN THE AES-ACAD YR-1/9"
		TITLE_CODES["3065"]["program"] = "ACADEMIC"
		TITLE_CODES["3065"]["unit"] = "99"

	TITLE_CODES["3064"] = {}
		TITLE_CODES["3064"]["title"] = "ACT---IN THE AES-ACADEMIC YEAR"
		TITLE_CODES["3064"]["program"] = "ACADEMIC"
		TITLE_CODES["3064"]["unit"] = "99"

	TITLE_CODES["7676"] = {}
		TITLE_CODES["7676"]["title"] = "PROGRAM PROMOTION MANAGER I"
		TITLE_CODES["7676"]["program"] = "PSS"
		TITLE_CODES["7676"]["unit"] = "99"

	TITLE_CODES["7677"] = {}
		TITLE_CODES["7677"]["title"] = "PUBLICATIONS MANAGER SUPV"
		TITLE_CODES["7677"]["program"] = "PSS"
		TITLE_CODES["7677"]["unit"] = "99"

	TITLE_CODES["7143"] = {}
		TITLE_CODES["7143"]["title"] = "TECHNICIAN, EH&S"
		TITLE_CODES["7143"]["program"] = "PSS"
		TITLE_CODES["7143"]["unit"] = "TX"

	TITLE_CODES["7672"] = {}
		TITLE_CODES["7672"]["title"] = "PUBLIC INFORMATION REP"
		TITLE_CODES["7672"]["program"] = "PSS"
		TITLE_CODES["7672"]["unit"] = "99"

	TITLE_CODES["7673"] = {}
		TITLE_CODES["7673"]["title"] = "PROGRAM PROMOTION MGR SUPV"
		TITLE_CODES["7673"]["program"] = "PSS"
		TITLE_CODES["7673"]["unit"] = "99"

	TITLE_CODES["7670"] = {}
		TITLE_CODES["7670"]["title"] = "PUBLIC INFO REP SUPERVISOR"
		TITLE_CODES["7670"]["program"] = "PSS"
		TITLE_CODES["7670"]["unit"] = "99"

	TITLE_CODES["7671"] = {}
		TITLE_CODES["7671"]["title"] = "PUBLIC INFORMATION REP, SR"
		TITLE_CODES["7671"]["program"] = "PSS"
		TITLE_CODES["7671"]["unit"] = "99"

	TITLE_CODES["1051"] = {}
		TITLE_CODES["1051"]["title"] = "ASSISTANT PROVOST"
		TITLE_CODES["1051"]["program"] = "ACADEMIC"
		TITLE_CODES["1051"]["unit"] = "99"

	TITLE_CODES["1052"] = {}
		TITLE_CODES["1052"]["title"] = "ASSOCIATE PROVOST"
		TITLE_CODES["1052"]["program"] = "ACADEMIC"
		TITLE_CODES["1052"]["unit"] = "99"

	TITLE_CODES["1053"] = {}
		TITLE_CODES["1053"]["title"] = "SENIOR PRECEPTOR II"
		TITLE_CODES["1053"]["program"] = "ACADEMIC"
		TITLE_CODES["1053"]["unit"] = "99"

	TITLE_CODES["1054"] = {}
		TITLE_CODES["1054"]["title"] = "SENIOR PRECEPTOR I"
		TITLE_CODES["1054"]["program"] = "ACADEMIC"
		TITLE_CODES["1054"]["unit"] = "99"

	TITLE_CODES["1055"] = {}
		TITLE_CODES["1055"]["title"] = "FACULTY ASST TO PROVOST/DEAN"
		TITLE_CODES["1055"]["program"] = "ACADEMIC"
		TITLE_CODES["1055"]["unit"] = "99"

	TITLE_CODES["1057"] = {}
		TITLE_CODES["1057"]["title"] = "ACAD ASST TO T/DIR OF HOSP&CL"
		TITLE_CODES["1057"]["program"] = "ACADEMIC"
		TITLE_CODES["1057"]["unit"] = "99"

	TITLE_CODES["1059"] = {}
		TITLE_CODES["1059"]["title"] = "CHRPRSN-SEN ASMBLY & ACAD CNCL"
		TITLE_CODES["1059"]["program"] = "ACADEMIC"
		TITLE_CODES["1059"]["unit"] = "99"

	TITLE_CODES["3340"] = {}
		TITLE_CODES["3340"]["title"] = "SUPERINTENDENT OF STATION"
		TITLE_CODES["3340"]["program"] = "ACADEMIC"
		TITLE_CODES["3340"]["unit"] = "99"

	TITLE_CODES["5454"] = {}
		TITLE_CODES["5454"]["title"] = "FOOD SERVICE SUPVR"
		TITLE_CODES["5454"]["program"] = "PSS"
		TITLE_CODES["5454"]["unit"] = "99"

	TITLE_CODES["5455"] = {}
		TITLE_CODES["5455"]["title"] = "FOOD SERVICE WORKER, PER DIEM"
		TITLE_CODES["5455"]["program"] = "PSS"
		TITLE_CODES["5455"]["unit"] = "SX"

	TITLE_CODES["5456"] = {}
		TITLE_CODES["5456"]["title"] = "FOOD SERVICE WKR, SR, PER DIEM"
		TITLE_CODES["5456"]["program"] = "PSS"
		TITLE_CODES["5456"]["unit"] = "SX"

	TITLE_CODES["5457"] = {}
		TITLE_CODES["5457"]["title"] = "FOOD SERVICE WKR, PR, PER DIEM"
		TITLE_CODES["5457"]["program"] = "PSS"
		TITLE_CODES["5457"]["unit"] = "SX"

	TITLE_CODES["1793"] = {}
		TITLE_CODES["1793"]["title"] = "HS ASSOC CLIN PROF-GENCOMP-B"
		TITLE_CODES["1793"]["program"] = "ACADEMIC"
		TITLE_CODES["1793"]["unit"] = "99"

	TITLE_CODES["9221"] = {}
		TITLE_CODES["9221"]["title"] = "TECH,STERILE PROCESSING II,PD"
		TITLE_CODES["9221"]["program"] = "PSS"
		TITLE_CODES["9221"]["unit"] = "EX"

	TITLE_CODES["1759"] = {}
		TITLE_CODES["1759"]["title"] = "ASSOCIATE PROF-MEDCOMP-B"
		TITLE_CODES["1759"]["program"] = "ACADEMIC"
		TITLE_CODES["1759"]["unit"] = "A3"

	TITLE_CODES["1758"] = {}
		TITLE_CODES["1758"]["title"] = "ACT ASST PROFESSOR-MEDCOMP-B"
		TITLE_CODES["1758"]["program"] = "ACADEMIC"
		TITLE_CODES["1758"]["unit"] = "99"

	TITLE_CODES["1757"] = {}
		TITLE_CODES["1757"]["title"] = "ASSISTANT PROF-MEDCOMP-B"
		TITLE_CODES["1757"]["program"] = "ACADEMIC"
		TITLE_CODES["1757"]["unit"] = "A3"

	TITLE_CODES["1755"] = {}
		TITLE_CODES["1755"]["title"] = "INSTRUCTOR-MEDCOMP-B"
		TITLE_CODES["1755"]["program"] = "ACADEMIC"
		TITLE_CODES["1755"]["unit"] = "A3"

	TITLE_CODES["9220"] = {}
		TITLE_CODES["9220"]["title"] = "TECH,STERILE PROCESSING I,PD"
		TITLE_CODES["9220"]["program"] = "PSS"
		TITLE_CODES["9220"]["unit"] = "EX"

	TITLE_CODES["1791"] = {}
		TITLE_CODES["1791"]["title"] = "HS CLIN INSTRUCTOR-GENCOMP-B"
		TITLE_CODES["1791"]["program"] = "ACADEMIC"
		TITLE_CODES["1791"]["unit"] = "99"

	TITLE_CODES["1750"] = {}
		TITLE_CODES["1750"]["title"] = "ADJUNCT PROF-GENCOMP-B"
		TITLE_CODES["1750"]["program"] = "ACADEMIC"
		TITLE_CODES["1750"]["unit"] = "99"

	TITLE_CODES["6976"] = {}
		TITLE_CODES["6976"]["title"] = "PROJECT MGR,DESIGN/CONSTR III"
		TITLE_CODES["6976"]["program"] = "PSS"
		TITLE_CODES["6976"]["unit"] = "99"

	TITLE_CODES["6977"] = {}
		TITLE_CODES["6977"]["title"] = "PROJECT MGR,DESIGN/CONSTR IV"
		TITLE_CODES["6977"]["program"] = "PSS"
		TITLE_CODES["6977"]["unit"] = "99"

	TITLE_CODES["6974"] = {}
		TITLE_CODES["6974"]["title"] = "PROJECT MGR,DESIGN/CONSTR I"
		TITLE_CODES["6974"]["program"] = "PSS"
		TITLE_CODES["6974"]["unit"] = "99"

	TITLE_CODES["2852"] = {}
		TITLE_CODES["2852"]["title"] = "SPECIAL READER UCLA-GSHIP"
		TITLE_CODES["2852"]["program"] = "ACADEMIC"
		TITLE_CODES["2852"]["unit"] = "BX"

	TITLE_CODES["6970"] = {}
		TITLE_CODES["6970"]["title"] = "PLANNER SUPERVISOR"
		TITLE_CODES["6970"]["program"] = "PSS"
		TITLE_CODES["6970"]["unit"] = "99"

	TITLE_CODES["5420"] = {}
		TITLE_CODES["5420"]["title"] = "DIETETIC TECH, REGISTERED-SUPV"
		TITLE_CODES["5420"]["program"] = "PSS"
		TITLE_CODES["5420"]["unit"] = "99"

	TITLE_CODES["2855"] = {}
		TITLE_CODES["2855"]["title"] = "READER-NON-GSHIP/NON-REP"
		TITLE_CODES["2855"]["program"] = "ACADEMIC"
		TITLE_CODES["2855"]["unit"] = "99"

	TITLE_CODES["7142"] = {}
		TITLE_CODES["7142"]["title"] = "TECHNICIAN, EH&S, SR"
		TITLE_CODES["7142"]["program"] = "PSS"
		TITLE_CODES["7142"]["unit"] = "TX"

	TITLE_CODES["6978"] = {}
		TITLE_CODES["6978"]["title"] = "PROJECT MGR,DESIGN/CONSTR V"
		TITLE_CODES["6978"]["program"] = "PSS"
		TITLE_CODES["6978"]["unit"] = "99"

	TITLE_CODES["2854"] = {}
		TITLE_CODES["2854"]["title"] = "READER-GSHIP/NON-REP"
		TITLE_CODES["2854"]["program"] = "ACADEMIC"
		TITLE_CODES["2854"]["unit"] = "99"

	TITLE_CODES["1007"] = {}
		TITLE_CODES["1007"]["title"] = "ACTING/INTERIM DEAN"
		TITLE_CODES["1007"]["program"] = "ACADEMIC"
		TITLE_CODES["1007"]["unit"] = "99"

	TITLE_CODES["8248"] = {}
		TITLE_CODES["8248"]["title"] = "PHYSICAL PLANT OPERATOR"
		TITLE_CODES["8248"]["program"] = "PSS"
		TITLE_CODES["8248"]["unit"] = "SX"

	TITLE_CODES["8249"] = {}
		TITLE_CODES["8249"]["title"] = "GLAZIER, APPRENTICE"
		TITLE_CODES["8249"]["program"] = "PSS"
		TITLE_CODES["8249"]["unit"] = "K3"

	TITLE_CODES["8680"] = {}
		TITLE_CODES["8680"]["title"] = "TECHNICIAN,ELEC,PRIN-SUPVR-MF"
		TITLE_CODES["8680"]["program"] = "PSS"
		TITLE_CODES["8680"]["unit"] = "99"

	TITLE_CODES["7632"] = {}
		TITLE_CODES["7632"]["title"] = "AUDITOR III - SUPERVISOR"
		TITLE_CODES["7632"]["program"] = "PSS"
		TITLE_CODES["7632"]["unit"] = "99"

	TITLE_CODES["1794"] = {}
		TITLE_CODES["1794"]["title"] = "HS CLIN PROF-GENCOMP-B"
		TITLE_CODES["1794"]["program"] = "ACADEMIC"
		TITLE_CODES["1794"]["unit"] = "99"

	TITLE_CODES["8246"] = {}
		TITLE_CODES["8246"]["title"] = "SHEETMETAL MECHANIC/MACHINIST"
		TITLE_CODES["8246"]["program"] = "PSS"
		TITLE_CODES["8246"]["unit"] = "K3"

	TITLE_CODES["8247"] = {}
		TITLE_CODES["8247"]["title"] = "PHYSICAL PLANT OPERATOR SUPVR"
		TITLE_CODES["8247"]["program"] = "PSS"
		TITLE_CODES["8247"]["unit"] = "99"

	TITLE_CODES["8244"] = {}
		TITLE_CODES["8244"]["title"] = "WASTE WATER TREAT PLT OP APPR"
		TITLE_CODES["8244"]["program"] = "PSS"
		TITLE_CODES["8244"]["unit"] = "K3"

	TITLE_CODES["8245"] = {}
		TITLE_CODES["8245"]["title"] = "WASTE WATER TREAT PLT OPERATOR"
		TITLE_CODES["8245"]["program"] = "PSS"
		TITLE_CODES["8245"]["unit"] = "K3"

	TITLE_CODES["5423"] = {}
		TITLE_CODES["5423"]["title"] = "DIETITIAN, PRIN-SUPVR"
		TITLE_CODES["5423"]["program"] = "PSS"
		TITLE_CODES["5423"]["unit"] = "99"

	TITLE_CODES["3118"] = {}
		TITLE_CODES["3118"]["title"] = "VISITING ASSOC ASTRONOMER"
		TITLE_CODES["3118"]["program"] = "ACADEMIC"
		TITLE_CODES["3118"]["unit"] = "99"

	TITLE_CODES["3117"] = {}
		TITLE_CODES["3117"]["title"] = "ACTING ASSOCIATE ASTRONOMER"
		TITLE_CODES["3117"]["program"] = "ACADEMIC"
		TITLE_CODES["3117"]["unit"] = "99"

	TITLE_CODES["7171"] = {}
		TITLE_CODES["7171"]["title"] = "TECHNICIAN, DEVELOPMENT, IV"
		TITLE_CODES["7171"]["program"] = "PSS"
		TITLE_CODES["7171"]["unit"] = "TX"

	TITLE_CODES["3110"] = {}
		TITLE_CODES["3110"]["title"] = "ASSOCIATE ASTRONOMER"
		TITLE_CODES["3110"]["program"] = "ACADEMIC"
		TITLE_CODES["3110"]["unit"] = "FX"

	TITLE_CODES["7188"] = {}
		TITLE_CODES["7188"]["title"] = "ENGINEER,DEVELOPMENT,ASST-SUPV"
		TITLE_CODES["7188"]["program"] = "PSS"
		TITLE_CODES["7188"]["unit"] = "99"

	TITLE_CODES["1470"] = {}
		TITLE_CODES["1470"]["title"] = "AST PROF OF CLIN___-FY-GENCOMP"
		TITLE_CODES["1470"]["program"] = "ACADEMIC"
		TITLE_CODES["1470"]["unit"] = "A3"

	TITLE_CODES["1986"] = {}
		TITLE_CODES["1986"]["title"] = "AST RES___-AY-1/9-BUS/ECON/ENG"
		TITLE_CODES["1986"]["program"] = "ACADEMIC"
		TITLE_CODES["1986"]["unit"] = "FX"

	TITLE_CODES["8681"] = {}
		TITLE_CODES["8681"]["title"] = "TECHNICIAN, ELEC,PRIN-MED FAC"
		TITLE_CODES["8681"]["program"] = "PSS"
		TITLE_CODES["8681"]["unit"] = "EX"

	TITLE_CODES["8649"] = {}
		TITLE_CODES["8649"]["title"] = "SUPERINTENDENT, MECH SHOP, SR"
		TITLE_CODES["8649"]["program"] = "PSS"
		TITLE_CODES["8649"]["unit"] = "99"

	TITLE_CODES["1573"] = {}
		TITLE_CODES["1573"]["title"] = "ADJUNCT INSTRUCTOR-FY-GENCOMP"
		TITLE_CODES["1573"]["program"] = "ACADEMIC"
		TITLE_CODES["1573"]["unit"] = "99"

	TITLE_CODES["1572"] = {}
		TITLE_CODES["1572"]["title"] = "PROF IN RES-FY-GENCOMP"
		TITLE_CODES["1572"]["program"] = "ACADEMIC"
		TITLE_CODES["1572"]["unit"] = "A3"

	TITLE_CODES["1571"] = {}
		TITLE_CODES["1571"]["title"] = "ASSOC PROF IN RES-FY-GENCOMP"
		TITLE_CODES["1571"]["program"] = "ACADEMIC"
		TITLE_CODES["1571"]["unit"] = "A3"

	TITLE_CODES["1570"] = {}
		TITLE_CODES["1570"]["title"] = "ASST PROF IN RES FY-GENCOMP"
		TITLE_CODES["1570"]["program"] = "ACADEMIC"
		TITLE_CODES["1570"]["unit"] = "A3"

	TITLE_CODES["7184"] = {}
		TITLE_CODES["7184"]["title"] = "ENGINEER, DEVELOPMENT, JR"
		TITLE_CODES["7184"]["program"] = "PSS"
		TITLE_CODES["7184"]["unit"] = "99"

	TITLE_CODES["1576"] = {}
		TITLE_CODES["1576"]["title"] = "ADJUNCT PROF-FY-GENCOMP"
		TITLE_CODES["1576"]["program"] = "ACADEMIC"
		TITLE_CODES["1576"]["unit"] = "99"

	TITLE_CODES["1575"] = {}
		TITLE_CODES["1575"]["title"] = "ASSOC ADJUNCT PROF-FY-GENCOMP"
		TITLE_CODES["1575"]["program"] = "ACADEMIC"
		TITLE_CODES["1575"]["unit"] = "99"

	TITLE_CODES["1574"] = {}
		TITLE_CODES["1574"]["title"] = "ASST ADJUNCT PROF-FY-GENCOMP"
		TITLE_CODES["1574"]["program"] = "ACADEMIC"
		TITLE_CODES["1574"]["unit"] = "99"

	TITLE_CODES["8918"] = {}
		TITLE_CODES["8918"]["title"] = "NURSE, VOCATIONAL, PER DIEM"
		TITLE_CODES["8918"]["program"] = "PSS"
		TITLE_CODES["8918"]["unit"] = "EX"

	TITLE_CODES["1306"] = {}
		TITLE_CODES["1306"]["title"] = "ASST PROFESSOR-ACAD YR-RECALL"
		TITLE_CODES["1306"]["program"] = "ACADEMIC"
		TITLE_CODES["1306"]["unit"] = "A3"

	TITLE_CODES["1307"] = {}
		TITLE_CODES["1307"]["title"] = "ACT ASST PROFESSOR-ACADEMIC YR"
		TITLE_CODES["1307"]["program"] = "ACADEMIC"
		TITLE_CODES["1307"]["unit"] = "99"

	TITLE_CODES["1300"] = {}
		TITLE_CODES["1300"]["title"] = "ASSISTANT PROFESSOR-ACAD YR"
		TITLE_CODES["1300"]["program"] = "ACADEMIC"
		TITLE_CODES["1300"]["unit"] = "A3"

	TITLE_CODES["1301"] = {}
		TITLE_CODES["1301"]["title"] = "ACT ASST PROFESSOR-ACAD YR-1/9"
		TITLE_CODES["1301"]["program"] = "ACADEMIC"
		TITLE_CODES["1301"]["unit"] = "99"

	TITLE_CODES["1302"] = {}
		TITLE_CODES["1302"]["title"] = "VST ASST PROFESSOR-ACAD YR-1/9"
		TITLE_CODES["1302"]["program"] = "ACADEMIC"
		TITLE_CODES["1302"]["unit"] = "99"

	TITLE_CODES["1303"] = {}
		TITLE_CODES["1303"]["title"] = "ASSISTANT PROFESSOR-AY-1/9TH"
		TITLE_CODES["1303"]["program"] = "ACADEMIC"
		TITLE_CODES["1303"]["unit"] = "A3"

	TITLE_CODES["9810"] = {}
		TITLE_CODES["9810"]["title"] = "FIRE SPECIALIST II - 40 HRS"
		TITLE_CODES["9810"]["program"] = "PSS"
		TITLE_CODES["9810"]["unit"] = "FF"

	TITLE_CODES["1308"] = {}
		TITLE_CODES["1308"]["title"] = "VST ASST PROFESSOR-ACADEMIC YR"
		TITLE_CODES["1308"]["program"] = "ACADEMIC"
		TITLE_CODES["1308"]["unit"] = "99"

	TITLE_CODES["498"] = {}
		TITLE_CODES["498"]["title"] = "TEMP SALARY SUPPL WITH MGT TIT"
		TITLE_CODES["498"]["program"] = "MSP"
		TITLE_CODES["498"]["unit"] = "87"

	TITLE_CODES["8019"] = {}
		TITLE_CODES["8019"]["title"] = "PSYCHOMETRIST, SR-SUPVR"
		TITLE_CODES["8019"]["program"] = "PSS"
		TITLE_CODES["8019"]["unit"] = "99"

	TITLE_CODES["8018"] = {}
		TITLE_CODES["8018"]["title"] = "PSYCHOLOGIST COUNSELING II-SUP"
		TITLE_CODES["8018"]["program"] = "PSS"
		TITLE_CODES["8018"]["unit"] = "99"

	TITLE_CODES["8545"] = {}
		TITLE_CODES["8545"]["title"] = "TECHNICIAN, AGRICUL,PRIN-SUPVR"
		TITLE_CODES["8545"]["program"] = "PSS"
		TITLE_CODES["8545"]["unit"] = "99"

	TITLE_CODES["8016"] = {}
		TITLE_CODES["8016"]["title"] = "COMM HEALTH PROG REP, SR-SUPV"
		TITLE_CODES["8016"]["program"] = "PSS"
		TITLE_CODES["8016"]["unit"] = "99"

	TITLE_CODES["496"] = {}
		TITLE_CODES["496"]["title"] = "ADMIN STIPEND WITH MGT TITLE"
		TITLE_CODES["496"]["program"] = "MSP"
		TITLE_CODES["496"]["unit"] = "87"

	TITLE_CODES["6329"] = {}
		TITLE_CODES["6329"]["title"] = "SR SCENE TECH - SUPERVISOR"
		TITLE_CODES["6329"]["program"] = "PSS"
		TITLE_CODES["6329"]["unit"] = "99"

	TITLE_CODES["490"] = {}
		TITLE_CODES["490"]["title"] = "REGISTRAR"
		TITLE_CODES["490"]["program"] = "MSP"
		TITLE_CODES["490"]["unit"] = "99"

	TITLE_CODES["8012"] = {}
		TITLE_CODES["8012"]["title"] = "SOCIAL WORK ASSOCIATE-SUPVR"
		TITLE_CODES["8012"]["program"] = "PSS"
		TITLE_CODES["8012"]["unit"] = "99"

	TITLE_CODES["492"] = {}
		TITLE_CODES["492"]["title"] = "ENVIR HLTH AND SAFETY OFF/ADMR"
		TITLE_CODES["492"]["program"] = "MSP"
		TITLE_CODES["492"]["unit"] = "99"

	TITLE_CODES["8542"] = {}
		TITLE_CODES["8542"]["title"] = "TECHNICIAN, AGRICULTURAL"
		TITLE_CODES["8542"]["program"] = "PSS"
		TITLE_CODES["8542"]["unit"] = "SX"

	TITLE_CODES["8171"] = {}
		TITLE_CODES["8171"]["title"] = "MECHANIC, PHY PLNT, SUPV, ASST"
		TITLE_CODES["8171"]["program"] = "PSS"
		TITLE_CODES["8171"]["unit"] = "99"

	TITLE_CODES["6222"] = {}
		TITLE_CODES["6222"]["title"] = "PHOTOGRAPHER, SR"
		TITLE_CODES["6222"]["program"] = "PSS"
		TITLE_CODES["6222"]["unit"] = "TX"

	TITLE_CODES["8673"] = {}
		TITLE_CODES["8673"]["title"] = "MECHANICIAN, LAB-MED FAC"
		TITLE_CODES["8673"]["program"] = "PSS"
		TITLE_CODES["8673"]["unit"] = "EX"

	TITLE_CODES["20"] = {}
		TITLE_CODES["20"]["title"] = "ASST PRES (FUNCTIONAL AREA)"
		TITLE_CODES["20"]["program"] = "MSP"
		TITLE_CODES["20"]["unit"] = "99"

	TITLE_CODES["21"] = {}
		TITLE_CODES["21"]["title"] = "UNIVERSITY CONTROLLER"
		TITLE_CODES["21"]["program"] = "MSP"
		TITLE_CODES["21"]["unit"] = "99"

	TITLE_CODES["7776"] = {}
		TITLE_CODES["7776"]["title"] = "BUYER III"
		TITLE_CODES["7776"]["program"] = "PSS"
		TITLE_CODES["7776"]["unit"] = "99"

	TITLE_CODES["9538"] = {}
		TITLE_CODES["9538"]["title"] = "TECH, ANIMAL HEALTH, IV - SUPV"
		TITLE_CODES["9538"]["program"] = "PSS"
		TITLE_CODES["9538"]["unit"] = "99"

	TITLE_CODES["7694"] = {}
		TITLE_CODES["7694"]["title"] = "PUBLICATIONS COORDINATOR, SR"
		TITLE_CODES["7694"]["program"] = "PSS"
		TITLE_CODES["7694"]["unit"] = "99"

	TITLE_CODES["7695"] = {}
		TITLE_CODES["7695"]["title"] = "PUBLICATIONS COORDINATOR"
		TITLE_CODES["7695"]["program"] = "PSS"
		TITLE_CODES["7695"]["unit"] = "99"

	TITLE_CODES["7696"] = {}
		TITLE_CODES["7696"]["title"] = "PUBLICATIONS COORD, SR - SUPVR"
		TITLE_CODES["7696"]["program"] = "PSS"
		TITLE_CODES["7696"]["unit"] = "99"

	TITLE_CODES["6221"] = {}
		TITLE_CODES["6221"]["title"] = "PHOTOGRAPHER, PRIN"
		TITLE_CODES["6221"]["program"] = "PSS"
		TITLE_CODES["6221"]["unit"] = "TX"

	TITLE_CODES["7692"] = {}
		TITLE_CODES["7692"]["title"] = "PUBLICATIONS COORDINATOR SUPV"
		TITLE_CODES["7692"]["program"] = "PSS"
		TITLE_CODES["7692"]["unit"] = "99"

	TITLE_CODES["7693"] = {}
		TITLE_CODES["7693"]["title"] = "PUBLICATIONS COORDINATOR, PRIN"
		TITLE_CODES["7693"]["program"] = "PSS"
		TITLE_CODES["7693"]["unit"] = "99"

	TITLE_CODES["9321"] = {}
		TITLE_CODES["9321"]["title"] = "COMMUNITY HEALTH PROG ASST CHF"
		TITLE_CODES["9321"]["program"] = "PSS"
		TITLE_CODES["9321"]["unit"] = "99"

	TITLE_CODES["6226"] = {}
		TITLE_CODES["6226"]["title"] = "TECHNICIAN, PHOTOGRAPHIC, SR"
		TITLE_CODES["6226"]["program"] = "PSS"
		TITLE_CODES["6226"]["unit"] = "TX"

	TITLE_CODES["7698"] = {}
		TITLE_CODES["7698"]["title"] = "ADMINISTRATIVE SPECIALIST I"
		TITLE_CODES["7698"]["program"] = "PSS"
		TITLE_CODES["7698"]["unit"] = "99"

	TITLE_CODES["9535"] = {}
		TITLE_CODES["9535"]["title"] = "TECHNICIAN, ANIMAL HEALTH III"
		TITLE_CODES["9535"]["program"] = "PSS"
		TITLE_CODES["9535"]["unit"] = "TX"

	TITLE_CODES["8672"] = {}
		TITLE_CODES["8672"]["title"] = "MECHANICIAN, LAB, SR-MED FAC"
		TITLE_CODES["8672"]["program"] = "PSS"
		TITLE_CODES["8672"]["unit"] = "EX"

	TITLE_CODES["7172"] = {}
		TITLE_CODES["7172"]["title"] = "TECHNICIAN, DEVELOPMENT, III"
		TITLE_CODES["7172"]["program"] = "PSS"
		TITLE_CODES["7172"]["unit"] = "TX"

	TITLE_CODES["1701"] = {}
		TITLE_CODES["1701"]["title"] = "RECALL ____-HCOMP"
		TITLE_CODES["1701"]["program"] = "ACADEMIC"
		TITLE_CODES["1701"]["unit"] = "A3"

	TITLE_CODES["1344"] = {}
		TITLE_CODES["1344"]["title"] = "ASST PROF-FY-BUS/ECON/ENG"
		TITLE_CODES["1344"]["program"] = "ACADEMIC"
		TITLE_CODES["1344"]["unit"] = "A3"

	TITLE_CODES["8081"] = {}
		TITLE_CODES["8081"]["title"] = "LEAD VENTILATION MECHANIC"
		TITLE_CODES["8081"]["program"] = "PSS"
		TITLE_CODES["8081"]["unit"] = "K3"

	TITLE_CODES["8684"] = {}
		TITLE_CODES["8684"]["title"] = "TECHNICIAN,ELEC, TRAINEE-MF"
		TITLE_CODES["8684"]["program"] = "PSS"
		TITLE_CODES["8684"]["unit"] = "EX"

	TITLE_CODES["9532"] = {}
		TITLE_CODES["9532"]["title"] = "VETERINARIAN (LAM), ASSOC"
		TITLE_CODES["9532"]["program"] = "PSS"
		TITLE_CODES["9532"]["unit"] = "99"

	TITLE_CODES["4031"] = {}
		TITLE_CODES["4031"]["title"] = "LIFEGUARD"
		TITLE_CODES["4031"]["program"] = "PSS"
		TITLE_CODES["4031"]["unit"] = "TX"

	TITLE_CODES["8265"] = {}
		TITLE_CODES["8265"]["title"] = "LOCKSMITH, LEAD"
		TITLE_CODES["8265"]["program"] = "PSS"
		TITLE_CODES["8265"]["unit"] = "K3"

	TITLE_CODES["9531"] = {}
		TITLE_CODES["9531"]["title"] = "VETERINARIAN (LAM), SR"
		TITLE_CODES["9531"]["program"] = "PSS"
		TITLE_CODES["9531"]["unit"] = "99"

	TITLE_CODES["9326"] = {}
		TITLE_CODES["9326"]["title"] = "COMMUNITY HEALTH PROG REP,ASST"
		TITLE_CODES["9326"]["program"] = "PSS"
		TITLE_CODES["9326"]["unit"] = "99"

	TITLE_CODES["9246"] = {}
		TITLE_CODES["9246"]["title"] = "PHARMACIST, SR"
		TITLE_CODES["9246"]["program"] = "PSS"
		TITLE_CODES["9246"]["unit"] = "HX"

	TITLE_CODES["9218"] = {}
		TITLE_CODES["9218"]["title"] = "TECH,STERILE PROCESSING II"
		TITLE_CODES["9218"]["program"] = "PSS"
		TITLE_CODES["9218"]["unit"] = "EX"

	TITLE_CODES["4131"] = {}
		TITLE_CODES["4131"]["title"] = "ADVISOR,RESIDENT,LANGUAGE HOUS"
		TITLE_CODES["4131"]["program"] = "PSS"
		TITLE_CODES["4131"]["unit"] = "99"

	TITLE_CODES["8293"] = {}
		TITLE_CODES["8293"]["title"] = "TECHNICIAN, TELEVISION"
		TITLE_CODES["8293"]["program"] = "PSS"
		TITLE_CODES["8293"]["unit"] = "TX"

	TITLE_CODES["1708"] = {}
		TITLE_CODES["1708"]["title"] = "RESEARCH PROFESSOR-VERIP"
		TITLE_CODES["1708"]["program"] = "ACADEMIC"
		TITLE_CODES["1708"]["unit"] = "A3"

	TITLE_CODES["8292"] = {}
		TITLE_CODES["8292"]["title"] = "TECHNICIAN, TELEVISION, SR"
		TITLE_CODES["8292"]["program"] = "PSS"
		TITLE_CODES["8292"]["unit"] = "TX"

	TITLE_CODES["8174"] = {}
		TITLE_CODES["8174"]["title"] = "MECHANIC, PHYSICAL PLANT"
		TITLE_CODES["8174"]["program"] = "PSS"
		TITLE_CODES["8174"]["unit"] = "K3"

	TITLE_CODES["5060"] = {}
		TITLE_CODES["5060"]["title"] = "STOREKEEPER, LEAD, SR"
		TITLE_CODES["5060"]["program"] = "PSS"
		TITLE_CODES["5060"]["unit"] = "SX"

	TITLE_CODES["9058"] = {}
		TITLE_CODES["9058"]["title"] = "TECHNOLOGIST, EEG, SUPERVISING"
		TITLE_CODES["9058"]["program"] = "PSS"
		TITLE_CODES["9058"]["unit"] = "99"

	TITLE_CODES["9615"] = {}
		TITLE_CODES["9615"]["title"] = "SRA III - SUPERVISOR"
		TITLE_CODES["9615"]["program"] = "PSS"
		TITLE_CODES["9615"]["unit"] = "99"

	TITLE_CODES["6653"] = {}
		TITLE_CODES["6653"]["title"] = "LINGUISTIC INTERPRETER"
		TITLE_CODES["6653"]["program"] = "PSS"
		TITLE_CODES["6653"]["unit"] = "TX"

	TITLE_CODES["6313"] = {}
		TITLE_CODES["6313"]["title"] = "PUBLIC EVENTS MANAGER"
		TITLE_CODES["6313"]["program"] = "PSS"
		TITLE_CODES["6313"]["unit"] = "99"

	TITLE_CODES["3205"] = {}
		TITLE_CODES["3205"]["title"] = "RES --- - ACAD YR- 1/9TH PYMT"
		TITLE_CODES["3205"]["program"] = "ACADEMIC"
		TITLE_CODES["3205"]["unit"] = "FX"

	TITLE_CODES["6652"] = {}
		TITLE_CODES["6652"]["title"] = "LINGUISTIC INTERPRETER, SR"
		TITLE_CODES["6652"]["program"] = "PSS"
		TITLE_CODES["6652"]["unit"] = "TX"

	TITLE_CODES["9350"] = {}
		TITLE_CODES["9350"]["title"] = "SUPVNG COMM HEALTH PROG-SUPVR"
		TITLE_CODES["9350"]["program"] = "PSS"
		TITLE_CODES["9350"]["unit"] = "99"

	TITLE_CODES["8511"] = {}
		TITLE_CODES["8511"]["title"] = "TRANSIT MAINTENANCE MANAGER"
		TITLE_CODES["8511"]["program"] = "PSS"
		TITLE_CODES["8511"]["unit"] = "99"

	TITLE_CODES["9324"] = {}
		TITLE_CODES["9324"]["title"] = "COMMUNITY HEALTH PROG REP, SR"
		TITLE_CODES["9324"]["program"] = "PSS"
		TITLE_CODES["9324"]["unit"] = "99"

	TITLE_CODES["6650"] = {}
		TITLE_CODES["6650"]["title"] = "LANGUAGE ASST"
		TITLE_CODES["6650"]["program"] = "PSS"
		TITLE_CODES["6650"]["unit"] = "TX"

	TITLE_CODES["4729"] = {}
		TITLE_CODES["4729"]["title"] = " ---ASSISTANT I, PER DIEM"
		TITLE_CODES["4729"]["program"] = "PSS"
		TITLE_CODES["4729"]["unit"] = "CX"

	TITLE_CODES["4728"] = {}
		TITLE_CODES["4728"]["title"] = "_____ASSISTANT I-SUPVR"
		TITLE_CODES["4728"]["program"] = "PSS"
		TITLE_CODES["4728"]["unit"] = "99"

	TITLE_CODES["2301"] = {}
		TITLE_CODES["2301"]["title"] = "TEACHING FELLOW- NON-GSHIP"
		TITLE_CODES["2301"]["program"] = "ACADEMIC"
		TITLE_CODES["2301"]["unit"] = "BX"

	TITLE_CODES["2300"] = {}
		TITLE_CODES["2300"]["title"] = "TEACHING FELLOW - GSHIP"
		TITLE_CODES["2300"]["program"] = "ACADEMIC"
		TITLE_CODES["2300"]["unit"] = "BX"

	TITLE_CODES["2303"] = {}
		TITLE_CODES["2303"]["title"] = "TEACHG FELLOW-NON-GSHIP/NONREP"
		TITLE_CODES["2303"]["program"] = "ACADEMIC"
		TITLE_CODES["2303"]["unit"] = "99"

	TITLE_CODES["2302"] = {}
		TITLE_CODES["2302"]["title"] = "TEACHING FELLOW-GSHIP/NON-REP"
		TITLE_CODES["2302"]["program"] = "ACADEMIC"
		TITLE_CODES["2302"]["unit"] = "99"

	TITLE_CODES["2305"] = {}
		TITLE_CODES["2305"]["title"] = "COMM TEACHING FELLOW - GSHIP"
		TITLE_CODES["2305"]["program"] = "ACADEMIC"
		TITLE_CODES["2305"]["unit"] = "BX"

	TITLE_CODES["4720"] = {}
		TITLE_CODES["4720"]["title"] = "ABSTRACTOR, PAT REC IV-SUPVR"
		TITLE_CODES["4720"]["program"] = "PSS"
		TITLE_CODES["4720"]["unit"] = "99"

	TITLE_CODES["4723"] = {}
		TITLE_CODES["4723"]["title"] = "_____ASSISTANT II"
		TITLE_CODES["4723"]["program"] = "PSS"
		TITLE_CODES["4723"]["unit"] = "CX"

	TITLE_CODES["2306"] = {}
		TITLE_CODES["2306"]["title"] = "COMM TEACHING FELLOW-NON-GSHIP"
		TITLE_CODES["2306"]["program"] = "ACADEMIC"
		TITLE_CODES["2306"]["unit"] = "BX"

	TITLE_CODES["9325"] = {}
		TITLE_CODES["9325"]["title"] = "COMMUNITY HEALTH PROGRAM REP"
		TITLE_CODES["9325"]["program"] = "PSS"
		TITLE_CODES["9325"]["unit"] = "99"

	TITLE_CODES["9717"] = {}
		TITLE_CODES["9717"]["title"] = "DIVING OFFICER"
		TITLE_CODES["9717"]["program"] = "PSS"
		TITLE_CODES["9717"]["unit"] = "TX"

	TITLE_CODES["1878"] = {}
		TITLE_CODES["1878"]["title"] = "ACTING ASST PROFESSOR-SFT-PC"
		TITLE_CODES["1878"]["program"] = "ACADEMIC"
		TITLE_CODES["1878"]["unit"] = "99"

	TITLE_CODES["5841"] = {}
		TITLE_CODES["5841"]["title"] = "LAUNDRY MACHINE OPERATOR, SR"
		TITLE_CODES["5841"]["program"] = "PSS"
		TITLE_CODES["5841"]["unit"] = "SX"

	TITLE_CODES["8485"] = {}
		TITLE_CODES["8485"]["title"] = "AUTO EQUIPMENT OPERATOR, PRIN"
		TITLE_CODES["8485"]["program"] = "PSS"
		TITLE_CODES["8485"]["unit"] = "SX"

	TITLE_CODES["2288"] = {}
		TITLE_CODES["2288"]["title"] = "REMEDIAL TUTOR I - GSHIP"
		TITLE_CODES["2288"]["program"] = "ACADEMIC"
		TITLE_CODES["2288"]["unit"] = "BX"

	TITLE_CODES["2289"] = {}
		TITLE_CODES["2289"]["title"] = "REMEDIAL TUTOR II - GSHIP"
		TITLE_CODES["2289"]["program"] = "ACADEMIC"
		TITLE_CODES["2289"]["unit"] = "BX"

	TITLE_CODES["9121"] = {}
		TITLE_CODES["9121"]["title"] = "NURSE, ANESTHETIST,SR PER DIEM"
		TITLE_CODES["9121"]["program"] = "PSS"
		TITLE_CODES["9121"]["unit"] = "NX"

	TITLE_CODES["8490"] = {}
		TITLE_CODES["8490"]["title"] = "AUTO EQUIP OPERATOR, PER DIEM"
		TITLE_CODES["8490"]["program"] = "PSS"
		TITLE_CODES["8490"]["unit"] = "SX"

	TITLE_CODES["2280"] = {}
		TITLE_CODES["2280"]["title"] = "REMEDIAL TUTOR I - NON-GSHIP"
		TITLE_CODES["2280"]["program"] = "ACADEMIC"
		TITLE_CODES["2280"]["unit"] = "BX"

	TITLE_CODES["2284"] = {}
		TITLE_CODES["2284"]["title"] = "CHILD DEVEL.DEMO.LECT-CONTIN"
		TITLE_CODES["2284"]["program"] = "ACADEMIC"
		TITLE_CODES["2284"]["unit"] = "IX"

	TITLE_CODES["2285"] = {}
		TITLE_CODES["2285"]["title"] = "CHILD DEVELOPMENT DEMO LECT"
		TITLE_CODES["2285"]["program"] = "ACADEMIC"
		TITLE_CODES["2285"]["unit"] = "IX"

	TITLE_CODES["2286"] = {}
		TITLE_CODES["2286"]["title"] = "NURSERY SCHOOL ASSISTANT-GSHIP"
		TITLE_CODES["2286"]["program"] = "ACADEMIC"
		TITLE_CODES["2286"]["unit"] = "BX"

	TITLE_CODES["2287"] = {}
		TITLE_CODES["2287"]["title"] = "NURSERY SCHOOL ASST-NON-GSHIP"
		TITLE_CODES["2287"]["program"] = "ACADEMIC"
		TITLE_CODES["2287"]["unit"] = "BX"

	TITLE_CODES["245"] = {}
		TITLE_CODES["245"]["title"] = "DIRECTOR (FUNCTIONAL AREA)"
		TITLE_CODES["245"]["program"] = "MSP"
		TITLE_CODES["245"]["unit"] = "99"

	TITLE_CODES["4621"] = {}
		TITLE_CODES["4621"]["title"] = "COLLECTIONS REPRESENTATIVE, SR"
		TITLE_CODES["4621"]["program"] = "PSS"
		TITLE_CODES["4621"]["unit"] = "CX"

	TITLE_CODES["4622"] = {}
		TITLE_CODES["4622"]["title"] = "COLLECTIONS REPRESENTATIVE"
		TITLE_CODES["4622"]["program"] = "PSS"
		TITLE_CODES["4622"]["unit"] = "CX"

	TITLE_CODES["7712"] = {}
		TITLE_CODES["7712"]["title"] = "ESTIMATOR, PRINTING, SR"
		TITLE_CODES["7712"]["program"] = "PSS"
		TITLE_CODES["7712"]["unit"] = "TX"

	TITLE_CODES["4624"] = {}
		TITLE_CODES["4624"]["title"] = "COLLECTIONS REP, SR-SUPVR"
		TITLE_CODES["4624"]["program"] = "PSS"
		TITLE_CODES["4624"]["unit"] = "99"

	TITLE_CODES["4625"] = {}
		TITLE_CODES["4625"]["title"] = "COLLECTIONS REP-SUPVR"
		TITLE_CODES["4625"]["program"] = "PSS"
		TITLE_CODES["4625"]["unit"] = "99"

	TITLE_CODES["9602"] = {}
		TITLE_CODES["9602"]["title"] = "LABORATORY ASST III"
		TITLE_CODES["9602"]["program"] = "PSS"
		TITLE_CODES["9602"]["unit"] = "TX"

	TITLE_CODES["2271"] = {}
		TITLE_CODES["2271"]["title"] = "REM TUTOR I-GSHIP/NON-REP"
		TITLE_CODES["2271"]["program"] = "ACADEMIC"
		TITLE_CODES["2271"]["unit"] = "99"

	TITLE_CODES["2270"] = {}
		TITLE_CODES["2270"]["title"] = "REM TUTOR I-NON-GSHIP/NON-REP"
		TITLE_CODES["2270"]["program"] = "ACADEMIC"
		TITLE_CODES["2270"]["unit"] = "99"

	TITLE_CODES["2273"] = {}
		TITLE_CODES["2273"]["title"] = "REM TUTOR II-GSHIP/NON-REP"
		TITLE_CODES["2273"]["program"] = "ACADEMIC"
		TITLE_CODES["2273"]["unit"] = "99"

	TITLE_CODES["2272"] = {}
		TITLE_CODES["2272"]["title"] = "REM TUTOR II-NON-GSHIP/NON-REP"
		TITLE_CODES["2272"]["program"] = "ACADEMIC"
		TITLE_CODES["2272"]["unit"] = "99"

	TITLE_CODES["6284"] = {}
		TITLE_CODES["6284"]["title"] = "HOUSE MANAGER, ASST"
		TITLE_CODES["6284"]["program"] = "PSS"
		TITLE_CODES["6284"]["unit"] = "99"

	TITLE_CODES["6733"] = {}
		TITLE_CODES["6733"]["title"] = "BIBLIOGRAPHER I"
		TITLE_CODES["6733"]["program"] = "PSS"
		TITLE_CODES["6733"]["unit"] = "CX"

	TITLE_CODES["8667"] = {}
		TITLE_CODES["8667"]["title"] = "MECHANICIAN, LAB, SR - SUPVR"
		TITLE_CODES["8667"]["program"] = "PSS"
		TITLE_CODES["8667"]["unit"] = "99"

	TITLE_CODES["9120"] = {}
		TITLE_CODES["9120"]["title"] = "NURSE, INTERIM PERMITTEE"
		TITLE_CODES["9120"]["program"] = "PSS"
		TITLE_CODES["9120"]["unit"] = "99"

	TITLE_CODES["4329"] = {}
		TITLE_CODES["4329"]["title"] = "APPOINTED OFFICIAL,STU ACTVS"
		TITLE_CODES["4329"]["program"] = "PSS"
		TITLE_CODES["4329"]["unit"] = "99"

	TITLE_CODES["9122"] = {}
		TITLE_CODES["9122"]["title"] = "NURSE, ANESTHETIST, PER DIEM"
		TITLE_CODES["9122"]["program"] = "PSS"
		TITLE_CODES["9122"]["unit"] = "NX"

	TITLE_CODES["9469"] = {}
		TITLE_CODES["9469"]["title"] = "SPEECH PATHOLOGIST, SR, P.D."
		TITLE_CODES["9469"]["program"] = "PSS"
		TITLE_CODES["9469"]["unit"] = "HX"

	TITLE_CODES["9124"] = {}
		TITLE_CODES["9124"]["title"] = "NURSE, ADMINISTRATIVE I-SUPVR"
		TITLE_CODES["9124"]["program"] = "PSS"
		TITLE_CODES["9124"]["unit"] = "99"

	TITLE_CODES["8312"] = {}
		TITLE_CODES["8312"]["title"] = "GLASSBLOWER, LABORATORY, SR"
		TITLE_CODES["8312"]["program"] = "PSS"
		TITLE_CODES["8312"]["unit"] = "TX"

	TITLE_CODES["9539"] = {}
		TITLE_CODES["9539"]["title"] = "TECH, ANIMAL HEALTH, III - SUP"
		TITLE_CODES["9539"]["program"] = "PSS"
		TITLE_CODES["9539"]["unit"] = "99"

	TITLE_CODES["9127"] = {}
		TITLE_CODES["9127"]["title"] = "NURSE, CLINICAL IV-SUPVR"
		TITLE_CODES["9127"]["program"] = "PSS"
		TITLE_CODES["9127"]["unit"] = "99"

	TITLE_CODES["8952"] = {}
		TITLE_CODES["8952"]["title"] = "CERT OCCUP THERAPY ASST PD"
		TITLE_CODES["8952"]["program"] = "PSS"
		TITLE_CODES["8952"]["unit"] = "EX"

	TITLE_CODES["4949"] = {}
		TITLE_CODES["4949"]["title"] = "WORD PROCESSIN SPEC,PRIN-SUPVR"
		TITLE_CODES["4949"]["program"] = "PSS"
		TITLE_CODES["4949"]["unit"] = "99"

	TITLE_CODES["9243"] = {}
		TITLE_CODES["9243"]["title"] = " -ASSIST. III, HOSP., P.D."
		TITLE_CODES["9243"]["program"] = "PSS"
		TITLE_CODES["9243"]["unit"] = "EX"

	TITLE_CODES["9534"] = {}
		TITLE_CODES["9534"]["title"] = "TECHNICIAN, ANIMAL HEALTH IV"
		TITLE_CODES["9534"]["program"] = "PSS"
		TITLE_CODES["9534"]["unit"] = "TX"

	TITLE_CODES["9245"] = {}
		TITLE_CODES["9245"]["title"] = " -ASSIST. I, HOSP., P.D."
		TITLE_CODES["9245"]["program"] = "PSS"
		TITLE_CODES["9245"]["unit"] = "EX"

	TITLE_CODES["9244"] = {}
		TITLE_CODES["9244"]["title"] = " -ASSIST. II, HOSP., P.D."
		TITLE_CODES["9244"]["program"] = "PSS"
		TITLE_CODES["9244"]["unit"] = "EX"

	TITLE_CODES["9247"] = {}
		TITLE_CODES["9247"]["title"] = "PHARMACIST, STAFF II"
		TITLE_CODES["9247"]["program"] = "PSS"
		TITLE_CODES["9247"]["unit"] = "HX"

	TITLE_CODES["6281"] = {}
		TITLE_CODES["6281"]["title"] = "HOUSE MANAGER SUPERVISOR"
		TITLE_CODES["6281"]["program"] = "PSS"
		TITLE_CODES["6281"]["unit"] = "99"

	TITLE_CODES["1877"] = {}
		TITLE_CODES["1877"]["title"] = "ASSISTANT PROFESSOR-SFT-PC"
		TITLE_CODES["1877"]["program"] = "ACADEMIC"
		TITLE_CODES["1877"]["unit"] = "A3"

	TITLE_CODES["9632"] = {}
		TITLE_CODES["9632"]["title"] = "MUSEUM PREPARATOR, PRIN"
		TITLE_CODES["9632"]["program"] = "PSS"
		TITLE_CODES["9632"]["unit"] = "TX"

	TITLE_CODES["1875"] = {}
		TITLE_CODES["1875"]["title"] = "INSTRUCTOR-SFT-PC"
		TITLE_CODES["1875"]["program"] = "ACADEMIC"
		TITLE_CODES["1875"]["unit"] = "A3"

	TITLE_CODES["9212"] = {}
		TITLE_CODES["9212"]["title"] = "COORDINATOR, MED OFF SRVC, I"
		TITLE_CODES["9212"]["program"] = "PSS"
		TITLE_CODES["9212"]["unit"] = "EX"

	TITLE_CODES["179"] = {}
		TITLE_CODES["179"]["title"] = "SPEC ASST TT SR VICE PRES"
		TITLE_CODES["179"]["program"] = "MSP"
		TITLE_CODES["179"]["unit"] = "99"

	TITLE_CODES["9042"] = {}
		TITLE_CODES["9042"]["title"] = "PROSTHETIST/ORTHOTIST"
		TITLE_CODES["9042"]["program"] = "PSS"
		TITLE_CODES["9042"]["unit"] = "EX"

	TITLE_CODES["175"] = {}
		TITLE_CODES["175"]["title"] = "CHIEF STRAT & BUS DEF OFC - MC"
		TITLE_CODES["175"]["program"] = "MSP"
		TITLE_CODES["175"]["unit"] = "99"

	TITLE_CODES["174"] = {}
		TITLE_CODES["174"]["title"] = "CHIEF MEDICAL OFFICER - MC"
		TITLE_CODES["174"]["program"] = "MSP"
		TITLE_CODES["174"]["unit"] = "99"

	TITLE_CODES["173"] = {}
		TITLE_CODES["173"]["title"] = "CHIEF INFORMATION OFFICER - MC"
		TITLE_CODES["173"]["program"] = "MSP"
		TITLE_CODES["173"]["unit"] = "99"

	TITLE_CODES["172"] = {}
		TITLE_CODES["172"]["title"] = "CHIEF OPERATING OFFICER - MC"
		TITLE_CODES["172"]["program"] = "MSP"
		TITLE_CODES["172"]["unit"] = "99"

	TITLE_CODES["171"] = {}
		TITLE_CODES["171"]["title"] = "ASSOCIATE VICE PRESIDENT"
		TITLE_CODES["171"]["program"] = "MSP"
		TITLE_CODES["171"]["unit"] = "99"

	TITLE_CODES["1879"] = {}
		TITLE_CODES["1879"]["title"] = "ASSOCIATE PROFESSOR-SFT-PC"
		TITLE_CODES["1879"]["program"] = "ACADEMIC"
		TITLE_CODES["1879"]["unit"] = "A3"

	TITLE_CODES["2051"] = {}
		TITLE_CODES["2051"]["title"] = "ASST CLIN PROF-DENT-50%/+ FY"
		TITLE_CODES["2051"]["program"] = "ACADEMIC"
		TITLE_CODES["2051"]["unit"] = "99"

	TITLE_CODES["2050"] = {}
		TITLE_CODES["2050"]["title"] = "HS ASST CLIN PROFESSOR-FY"
		TITLE_CODES["2050"]["program"] = "ACADEMIC"
		TITLE_CODES["2050"]["unit"] = "99"

	TITLE_CODES["3200"] = {}
		TITLE_CODES["3200"]["title"] = "RESEARCH _____ - FISCAL YEAR"
		TITLE_CODES["3200"]["program"] = "ACADEMIC"
		TITLE_CODES["3200"]["unit"] = "FX"

	TITLE_CODES["2057"] = {}
		TITLE_CODES["2057"]["title"] = "ASST CLINICAL PROFESSOR-VOL"
		TITLE_CODES["2057"]["program"] = "ACADEMIC"
		TITLE_CODES["2057"]["unit"] = "99"

	TITLE_CODES["4826"] = {}
		TITLE_CODES["4826"]["title"] = "MAIL PROCESSOR, SR-SUPVR"
		TITLE_CODES["4826"]["program"] = "PSS"
		TITLE_CODES["4826"]["unit"] = "99"

	TITLE_CODES["8942"] = {}
		TITLE_CODES["8942"]["title"] = "TECHNICIAN, ECHOCARDIO, SR"
		TITLE_CODES["8942"]["program"] = "PSS"
		TITLE_CODES["8942"]["unit"] = "EX"

	TITLE_CODES["4824"] = {}
		TITLE_CODES["4824"]["title"] = "MAIL PROCESSOR, ASST"
		TITLE_CODES["4824"]["program"] = "PSS"
		TITLE_CODES["4824"]["unit"] = "SX"

	TITLE_CODES["4825"] = {}
		TITLE_CODES["4825"]["title"] = "MAIL PROCESSOR, PRIN"
		TITLE_CODES["4825"]["program"] = "PSS"
		TITLE_CODES["4825"]["unit"] = "SX"

	TITLE_CODES["4822"] = {}
		TITLE_CODES["4822"]["title"] = "MAIL PROCESSOR, SR"
		TITLE_CODES["4822"]["program"] = "PSS"
		TITLE_CODES["4822"]["unit"] = "SX"

	TITLE_CODES["4823"] = {}
		TITLE_CODES["4823"]["title"] = "MAIL PROCESSOR"
		TITLE_CODES["4823"]["program"] = "PSS"
		TITLE_CODES["4823"]["unit"] = "SX"

	TITLE_CODES["6282"] = {}
		TITLE_CODES["6282"]["title"] = "HOUSE MANAGER II"
		TITLE_CODES["6282"]["program"] = "PSS"
		TITLE_CODES["6282"]["unit"] = "99"

	TITLE_CODES["4821"] = {}
		TITLE_CODES["4821"]["title"] = "MAIL SERVICE SUPVR"
		TITLE_CODES["4821"]["program"] = "PSS"
		TITLE_CODES["4821"]["unit"] = "99"

	TITLE_CODES["180"] = {}
		TITLE_CODES["180"]["title"] = "SPECIAL ASST TT VICE PRESIDENT"
		TITLE_CODES["180"]["program"] = "MSP"
		TITLE_CODES["180"]["unit"] = "99"

	TITLE_CODES["181"] = {}
		TITLE_CODES["181"]["title"] = "SPEC ASST TT VP (FUNCTL AREA)"
		TITLE_CODES["181"]["program"] = "MSP"
		TITLE_CODES["181"]["unit"] = "99"

	TITLE_CODES["8220"] = {}
		TITLE_CODES["8220"]["title"] = "ROOFER, LEAD"
		TITLE_CODES["8220"]["program"] = "PSS"
		TITLE_CODES["8220"]["unit"] = "K3"

	TITLE_CODES["9044"] = {}
		TITLE_CODES["9044"]["title"] = "PROSTHETICS/ORTHOTICS, ASST"
		TITLE_CODES["9044"]["program"] = "PSS"
		TITLE_CODES["9044"]["unit"] = "EX"

	TITLE_CODES["9335"] = {}
		TITLE_CODES["9335"]["title"] = "CLINICAL RESEARCH COORDINATOR"
		TITLE_CODES["9335"]["program"] = "PSS"
		TITLE_CODES["9335"]["unit"] = "RX"

	TITLE_CODES["9334"] = {}
		TITLE_CODES["9334"]["title"] = "CLIN RESEARCH COORDINATOR, SR"
		TITLE_CODES["9334"]["program"] = "PSS"
		TITLE_CODES["9334"]["unit"] = "RX"

	TITLE_CODES["9336"] = {}
		TITLE_CODES["9336"]["title"] = "CLIN RESEARCH COORDINATOR,ASST"
		TITLE_CODES["9336"]["program"] = "PSS"
		TITLE_CODES["9336"]["unit"] = "RX"

	TITLE_CODES["9331"] = {}
		TITLE_CODES["9331"]["title"] = "CASE MANAGER, COMM SERV, ASST"
		TITLE_CODES["9331"]["program"] = "PSS"
		TITLE_CODES["9331"]["unit"] = "HX"

	TITLE_CODES["9330"] = {}
		TITLE_CODES["9330"]["title"] = "CASE MANAGER, COMM SERVICES"
		TITLE_CODES["9330"]["program"] = "PSS"
		TITLE_CODES["9330"]["unit"] = "HX"

	TITLE_CODES["9333"] = {}
		TITLE_CODES["9333"]["title"] = "CLINICAL RESEARCH SUPERVISOR"
		TITLE_CODES["9333"]["program"] = "PSS"
		TITLE_CODES["9333"]["unit"] = "99"

	TITLE_CODES["9293"] = {}
		TITLE_CODES["9293"]["title"] = "CERT PHLEBOTOMIST TECH II"
		TITLE_CODES["9293"]["program"] = "PSS"
		TITLE_CODES["9293"]["unit"] = "EX"

	TITLE_CODES["9613"] = {}
		TITLE_CODES["9613"]["title"] = "STAFF RESEARCH ASSOC I"
		TITLE_CODES["9613"]["program"] = "PSS"
		TITLE_CODES["9613"]["unit"] = "RX"

	TITLE_CODES["8086"] = {}
		TITLE_CODES["8086"]["title"] = "PEST CONTROL OPERATOR"
		TITLE_CODES["8086"]["program"] = "PSS"
		TITLE_CODES["8086"]["unit"] = "SX"

	TITLE_CODES["7353"] = {}
		TITLE_CODES["7353"]["title"] = "ANALYST VIII"
		TITLE_CODES["7353"]["program"] = "PSS"
		TITLE_CODES["7353"]["unit"] = "99"

	TITLE_CODES["3522"] = {}
		TITLE_CODES["3522"]["title"] = "CONTINUING EDUCATOR III"
		TITLE_CODES["3522"]["program"] = "ACADEMIC"
		TITLE_CODES["3522"]["unit"] = "FX"

	TITLE_CODES["7354"] = {}
		TITLE_CODES["7354"]["title"] = "ANALYST VIII - SUPERVISOR"
		TITLE_CODES["7354"]["program"] = "PSS"
		TITLE_CODES["7354"]["unit"] = "99"

	TITLE_CODES["3289"] = {}
		TITLE_CODES["3289"]["title"] = "ADJUNCT INSTRUCTOR - FISCAL YR"
		TITLE_CODES["3289"]["program"] = "ACADEMIC"
		TITLE_CODES["3289"]["unit"] = "99"

	TITLE_CODES["3288"] = {}
		TITLE_CODES["3288"]["title"] = "ADJUNCT INSTRUCTOR-ACADEMIC YR"
		TITLE_CODES["3288"]["program"] = "ACADEMIC"
		TITLE_CODES["3288"]["unit"] = "99"

	TITLE_CODES["3287"] = {}
		TITLE_CODES["3287"]["title"] = "GSR-TUIT & FEE REM-UCSD-GRP D"
		TITLE_CODES["3287"]["program"] = "ACADEMIC"
		TITLE_CODES["3287"]["unit"] = "99"

	TITLE_CODES["1910"] = {}
		TITLE_CODES["1910"]["title"] = "ADJUNCT PROFESSOR-SFT-VM"
		TITLE_CODES["1910"]["program"] = "ACADEMIC"
		TITLE_CODES["1910"]["unit"] = "99"

	TITLE_CODES["3285"] = {}
		TITLE_CODES["3285"]["title"] = "GSR-TUIT & FEE REM-UCSD-GRP B"
		TITLE_CODES["3285"]["program"] = "ACADEMIC"
		TITLE_CODES["3285"]["unit"] = "99"

	TITLE_CODES["3284"] = {}
		TITLE_CODES["3284"]["title"] = "GRAD STDNT RES-TUIT & FEE REM"
		TITLE_CODES["3284"]["program"] = "ACADEMIC"
		TITLE_CODES["3284"]["unit"] = "99"

	TITLE_CODES["3283"] = {}
		TITLE_CODES["3283"]["title"] = "GRAD STDNT RES-FULL TUIT & PFR"
		TITLE_CODES["3283"]["program"] = "ACADEMIC"
		TITLE_CODES["3283"]["unit"] = "99"

	TITLE_CODES["3282"] = {}
		TITLE_CODES["3282"]["title"] = "GRAD STDNT RES-FULL FEE REM"
		TITLE_CODES["3282"]["program"] = "ACADEMIC"
		TITLE_CODES["3282"]["unit"] = "99"

	TITLE_CODES["3281"] = {}
		TITLE_CODES["3281"]["title"] = "INSTR IN RESIDENCE-FISCAL YR"
		TITLE_CODES["3281"]["program"] = "ACADEMIC"
		TITLE_CODES["3281"]["unit"] = "A3"

	TITLE_CODES["3280"] = {}
		TITLE_CODES["3280"]["title"] = "INSTR IN RESIDENCE-ACADEMIC YR"
		TITLE_CODES["3280"]["program"] = "ACADEMIC"
		TITLE_CODES["3280"]["unit"] = "A3"

	TITLE_CODES["1728"] = {}
		TITLE_CODES["1728"]["title"] = "ASSISTANT ADJUNCT PROF-HCOMP"
		TITLE_CODES["1728"]["program"] = "ACADEMIC"
		TITLE_CODES["1728"]["unit"] = "99"

	TITLE_CODES["8944"] = {}
		TITLE_CODES["8944"]["title"] = "PHYSICAL THERAPY ASSISTANT III"
		TITLE_CODES["8944"]["program"] = "PSS"
		TITLE_CODES["8944"]["unit"] = "EX"

	TITLE_CODES["7210"] = {}
		TITLE_CODES["7210"]["title"] = "STATISTICIAN SUPERVISOR"
		TITLE_CODES["7210"]["program"] = "PSS"
		TITLE_CODES["7210"]["unit"] = "99"

	TITLE_CODES["7211"] = {}
		TITLE_CODES["7211"]["title"] = "STATISTICIAN, PRIN"
		TITLE_CODES["7211"]["program"] = "PSS"
		TITLE_CODES["7211"]["unit"] = "99"

	TITLE_CODES["7212"] = {}
		TITLE_CODES["7212"]["title"] = "STATISTICIAN, SR"
		TITLE_CODES["7212"]["program"] = "PSS"
		TITLE_CODES["7212"]["unit"] = "99"

	TITLE_CODES["7213"] = {}
		TITLE_CODES["7213"]["title"] = "STATISTICIAN"
		TITLE_CODES["7213"]["program"] = "PSS"
		TITLE_CODES["7213"]["unit"] = "99"

	TITLE_CODES["3441"] = {}
		TITLE_CODES["3441"]["title"] = "COOP EXT ADVISOR"
		TITLE_CODES["3441"]["program"] = "ACADEMIC"
		TITLE_CODES["3441"]["unit"] = "FX"

	TITLE_CODES["3225"] = {}
		TITLE_CODES["3225"]["title"] = "ASST RES___-ACAD YR-1/9TH PYMT"
		TITLE_CODES["3225"]["program"] = "ACADEMIC"
		TITLE_CODES["3225"]["unit"] = "FX"

	TITLE_CODES["6215"] = {}
		TITLE_CODES["6215"]["title"] = "PRODUCER-DIRECTOR, ASST"
		TITLE_CODES["6215"]["program"] = "PSS"
		TITLE_CODES["6215"]["unit"] = "TX"

	TITLE_CODES["6214"] = {}
		TITLE_CODES["6214"]["title"] = "PRODUCER-DIRECTOR"
		TITLE_CODES["6214"]["program"] = "PSS"
		TITLE_CODES["6214"]["unit"] = "TX"

	TITLE_CODES["2020"] = {}
		TITLE_CODES["2020"]["title"] = "HS ASSOC CLIN PROF-ACAD YR"
		TITLE_CODES["2020"]["program"] = "ACADEMIC"
		TITLE_CODES["2020"]["unit"] = "99"

	TITLE_CODES["2021"] = {}
		TITLE_CODES["2021"]["title"] = "ASSO CLIN PROF-DENT-50%/+ AY"
		TITLE_CODES["2021"]["program"] = "ACADEMIC"
		TITLE_CODES["2021"]["unit"] = "99"

	TITLE_CODES["6211"] = {}
		TITLE_CODES["6211"]["title"] = "PRODUCER-DIRECTOR, MANAGING"
		TITLE_CODES["6211"]["program"] = "PSS"
		TITLE_CODES["6211"]["unit"] = "99"

	TITLE_CODES["1976"] = {}
		TITLE_CODES["1976"]["title"] = "ACT ASO PROF-AY-1/9-B/ECON/ENG"
		TITLE_CODES["1976"]["program"] = "ACADEMIC"
		TITLE_CODES["1976"]["unit"] = "A3"

	TITLE_CODES["9027"] = {}
		TITLE_CODES["9027"]["title"] = "PERFUSIONIST, SR"
		TITLE_CODES["9027"]["program"] = "PSS"
		TITLE_CODES["9027"]["unit"] = "EX"

	TITLE_CODES["1975"] = {}
		TITLE_CODES["1975"]["title"] = "ACT ASO PRO-FY-BUS/ECON/ENG"
		TITLE_CODES["1975"]["program"] = "ACADEMIC"
		TITLE_CODES["1975"]["unit"] = "A3"

	TITLE_CODES["6219"] = {}
		TITLE_CODES["6219"]["title"] = "PHOTOGRAPHER,PRIN-SUPV"
		TITLE_CODES["6219"]["program"] = "PSS"
		TITLE_CODES["6219"]["unit"] = "99"

	TITLE_CODES["1729"] = {}
		TITLE_CODES["1729"]["title"] = "ASSOCIATE ADJUNCT PROF-HCOMP"
		TITLE_CODES["1729"]["program"] = "ACADEMIC"
		TITLE_CODES["1729"]["unit"] = "99"

	TITLE_CODES["880"] = {}
		TITLE_CODES["880"]["title"] = "OMBUDSMAN-ACADEMIC"
		TITLE_CODES["880"]["program"] = "ACADEMIC"
		TITLE_CODES["880"]["unit"] = "99"

	TITLE_CODES["8652"] = {}
		TITLE_CODES["8652"]["title"] = "MECHANICIAN, LAB, SR"
		TITLE_CODES["8652"]["program"] = "PSS"
		TITLE_CODES["8652"]["unit"] = "TX"

	TITLE_CODES["1973"] = {}
		TITLE_CODES["1973"]["title"] = "ACT PROF-AY-1/9TH-BUS/ECON/ENG"
		TITLE_CODES["1973"]["program"] = "ACADEMIC"
		TITLE_CODES["1973"]["unit"] = "A3"

	TITLE_CODES["9622"] = {}
		TITLE_CODES["9622"]["title"] = "SCANNER II"
		TITLE_CODES["9622"]["program"] = "PSS"
		TITLE_CODES["9622"]["unit"] = "TX"

	TITLE_CODES["1972"] = {}
		TITLE_CODES["1972"]["title"] = "ACT PROF-FY-BUS/ECON/ENG"
		TITLE_CODES["1972"]["program"] = "ACADEMIC"
		TITLE_CODES["1972"]["unit"] = "A3"

	TITLE_CODES["5216"] = {}
		TITLE_CODES["5216"]["title"] = "DISPATCHER, PUBLIC SAFETY"
		TITLE_CODES["5216"]["program"] = "PSS"
		TITLE_CODES["5216"]["unit"] = "CX"

	TITLE_CODES["9059"] = {}
		TITLE_CODES["9059"]["title"] = "TECHNOLOGIST, EEG, PRIN"
		TITLE_CODES["9059"]["program"] = "PSS"
		TITLE_CODES["9059"]["unit"] = "EX"

	TITLE_CODES["5215"] = {}
		TITLE_CODES["5215"]["title"] = "DISPATCHER, PUB SAFETY, ASSIST"
		TITLE_CODES["5215"]["program"] = "PSS"
		TITLE_CODES["5215"]["unit"] = "CX"

	TITLE_CODES["5212"] = {}
		TITLE_CODES["5212"]["title"] = "FIRE FIGHTER, STUDENT RESIDENT"
		TITLE_CODES["5212"]["program"] = "PSS"
		TITLE_CODES["5212"]["unit"] = "99"

	TITLE_CODES["1971"] = {}
		TITLE_CODES["1971"]["title"] = "ACT PROF-ACAD YR-BUS/ECON/ENG"
		TITLE_CODES["1971"]["program"] = "ACADEMIC"
		TITLE_CODES["1971"]["unit"] = "A3"

	TITLE_CODES["9148"] = {}
		TITLE_CODES["9148"]["title"] = "NURSE PRACTITIONER I"
		TITLE_CODES["9148"]["program"] = "PSS"
		TITLE_CODES["9148"]["unit"] = "NX"

	TITLE_CODES["5211"] = {}
		TITLE_CODES["5211"]["title"] = "FIRE FIGHTER, STUDENT RES. SR."
		TITLE_CODES["5211"]["program"] = "PSS"
		TITLE_CODES["5211"]["unit"] = "99"

	TITLE_CODES["9050"] = {}
		TITLE_CODES["9050"]["title"] = "THERAPIST, RESPIRATORY, I"
		TITLE_CODES["9050"]["program"] = "PSS"
		TITLE_CODES["9050"]["unit"] = "EX"

	TITLE_CODES["9051"] = {}
		TITLE_CODES["9051"]["title"] = "THERAPIST,RESPIRA,REG,PER DIEM"
		TITLE_CODES["9051"]["program"] = "PSS"
		TITLE_CODES["9051"]["unit"] = "EX"

	TITLE_CODES["9052"] = {}
		TITLE_CODES["9052"]["title"] = "THERAPIST,RESPIRAT ,PER DIEM"
		TITLE_CODES["9052"]["program"] = "PSS"
		TITLE_CODES["9052"]["unit"] = "EX"

	TITLE_CODES["4014"] = {}
		TITLE_CODES["4014"]["title"] = "COACH--INTERCOL ATHLETIC, ASST"
		TITLE_CODES["4014"]["program"] = "PSS"
		TITLE_CODES["4014"]["unit"] = "99"

	TITLE_CODES["5218"] = {}
		TITLE_CODES["5218"]["title"] = "DISPATCHER, PUB SAFETY--SUPV"
		TITLE_CODES["5218"]["program"] = "PSS"
		TITLE_CODES["5218"]["unit"] = "99"

	TITLE_CODES["3230"] = {}
		TITLE_CODES["3230"]["title"] = "FIELD PROGRAM SUPERVISOR"
		TITLE_CODES["3230"]["program"] = "ACADEMIC"
		TITLE_CODES["3230"]["unit"] = "FX"

	TITLE_CODES["3128"] = {}
		TITLE_CODES["3128"]["title"] = "VISITING ASST ASTRONOMER"
		TITLE_CODES["3128"]["program"] = "ACADEMIC"
		TITLE_CODES["3128"]["unit"] = "99"

	TITLE_CODES["1968"] = {}
		TITLE_CODES["1968"]["title"] = "REGENTS LECTURER"
		TITLE_CODES["1968"]["program"] = "ACADEMIC"
		TITLE_CODES["1968"]["unit"] = "99"

	TITLE_CODES["1969"] = {}
		TITLE_CODES["1969"]["title"] = "HUGHES INVESTIGATOR"
		TITLE_CODES["1969"]["program"] = "ACADEMIC"
		TITLE_CODES["1969"]["unit"] = "99"

	TITLE_CODES["1618"] = {}
		TITLE_CODES["1618"]["title"] = "LECTURER SOE-HCOMP"
		TITLE_CODES["1618"]["program"] = "ACADEMIC"
		TITLE_CODES["1618"]["unit"] = "A3"

	TITLE_CODES["1619"] = {}
		TITLE_CODES["1619"]["title"] = "SENIOR LECTURER SOE-HCOMP"
		TITLE_CODES["1619"]["program"] = "ACADEMIC"
		TITLE_CODES["1619"]["unit"] = "A3"

	TITLE_CODES["1617"] = {}
		TITLE_CODES["1617"]["title"] = "LECTURER W/SEC EMPL-FISCAL YR"
		TITLE_CODES["1617"]["program"] = "ACADEMIC"
		TITLE_CODES["1617"]["unit"] = "A3"

	TITLE_CODES["3238"] = {}
		TITLE_CODES["3238"]["title"] = "FACULTY FELLOW RES. - AY-1/9"
		TITLE_CODES["3238"]["program"] = "ACADEMIC"
		TITLE_CODES["3238"]["unit"] = "FX"

	TITLE_CODES["1615"] = {}
		TITLE_CODES["1615"]["title"] = "LECT-PSOE-FISCAL YR-PART TIME"
		TITLE_CODES["1615"]["program"] = "ACADEMIC"
		TITLE_CODES["1615"]["unit"] = "IX"

	TITLE_CODES["9621"] = {}
		TITLE_CODES["9621"]["title"] = "SCANNER I, SUPERVISING"
		TITLE_CODES["9621"]["program"] = "PSS"
		TITLE_CODES["9621"]["unit"] = "99"

	TITLE_CODES["1613"] = {}
		TITLE_CODES["1613"]["title"] = "SR LECT W/SEC EMPL - FISCAL YR"
		TITLE_CODES["1613"]["program"] = "ACADEMIC"
		TITLE_CODES["1613"]["unit"] = "A3"

	TITLE_CODES["1610"] = {}
		TITLE_CODES["1610"]["title"] = "SR LECT-PSOE-FY-PART TIME"
		TITLE_CODES["1610"]["program"] = "ACADEMIC"
		TITLE_CODES["1610"]["unit"] = "IX"

	TITLE_CODES["8927"] = {}
		TITLE_CODES["8927"]["title"] = "TECHNICIAN, ORTHOPEDIC, PRIN"
		TITLE_CODES["8927"]["program"] = "PSS"
		TITLE_CODES["8927"]["unit"] = "EX"

	TITLE_CODES["8926"] = {}
		TITLE_CODES["8926"]["title"] = "TECHNICIAN, PSYCHIATRIC"
		TITLE_CODES["8926"]["program"] = "PSS"
		TITLE_CODES["8926"]["unit"] = "EX"

	TITLE_CODES["8925"] = {}
		TITLE_CODES["8925"]["title"] = "TECHNICIAN, PSYCHIATRIC, SR"
		TITLE_CODES["8925"]["program"] = "PSS"
		TITLE_CODES["8925"]["unit"] = "EX"

	TITLE_CODES["8924"] = {}
		TITLE_CODES["8924"]["title"] = "TECHNICIAN, PSYCH, PER DIEM"
		TITLE_CODES["8924"]["program"] = "PSS"
		TITLE_CODES["8924"]["unit"] = "EX"

	TITLE_CODES["9149"] = {}
		TITLE_CODES["9149"]["title"] = "NURSE PRACTITIONER III-SUPVR"
		TITLE_CODES["9149"]["program"] = "PSS"
		TITLE_CODES["9149"]["unit"] = "99"

	TITLE_CODES["8920"] = {}
		TITLE_CODES["8920"]["title"] = "TECHNICIAN, EMERGENCY, TRAUMA"
		TITLE_CODES["8920"]["program"] = "PSS"
		TITLE_CODES["8920"]["unit"] = "EX"

	TITLE_CODES["8841"] = {}
		TITLE_CODES["8841"]["title"] = "BOOKBINDER, LIBRARY, SUPVR"
		TITLE_CODES["8841"]["program"] = "PSS"
		TITLE_CODES["8841"]["unit"] = "99"

	TITLE_CODES["8842"] = {}
		TITLE_CODES["8842"]["title"] = "BOOKBINDER, LIBRARY, PRIN"
		TITLE_CODES["8842"]["program"] = "PSS"
		TITLE_CODES["8842"]["unit"] = "GS"

	TITLE_CODES["8843"] = {}
		TITLE_CODES["8843"]["title"] = "BOOKBINDER, LIBRARY, SR"
		TITLE_CODES["8843"]["program"] = "PSS"
		TITLE_CODES["8843"]["unit"] = "GS"

	TITLE_CODES["8844"] = {}
		TITLE_CODES["8844"]["title"] = "BOOKBINDER, LIBRARY"
		TITLE_CODES["8844"]["program"] = "PSS"
		TITLE_CODES["8844"]["unit"] = "GS"

	TITLE_CODES["8845"] = {}
		TITLE_CODES["8845"]["title"] = "BOOKBINDER, LIBRARY, ASSISTANT"
		TITLE_CODES["8845"]["program"] = "PSS"
		TITLE_CODES["8845"]["unit"] = "GS"

	TITLE_CODES["8846"] = {}
		TITLE_CODES["8846"]["title"] = "BOOKBINDER, LIBRARY, SR-SUPVR"
		TITLE_CODES["8846"]["program"] = "PSS"
		TITLE_CODES["8846"]["unit"] = "99"

	TITLE_CODES["8917"] = {}
		TITLE_CODES["8917"]["title"] = "NURSE, VOCATIONAL"
		TITLE_CODES["8917"]["program"] = "PSS"
		TITLE_CODES["8917"]["unit"] = "EX"

	TITLE_CODES["775"] = {}
		TITLE_CODES["775"]["title"] = "ASSOCIATE DENTIST DIPLOMATE"
		TITLE_CODES["775"]["program"] = "MSP"
		TITLE_CODES["775"]["unit"] = "99"

	TITLE_CODES["774"] = {}
		TITLE_CODES["774"]["title"] = "SENIOR DENTIST"
		TITLE_CODES["774"]["program"] = "MSP"
		TITLE_CODES["774"]["unit"] = "99"

	TITLE_CODES["777"] = {}
		TITLE_CODES["777"]["title"] = "ASSISTANT DENTIST"
		TITLE_CODES["777"]["program"] = "MSP"
		TITLE_CODES["777"]["unit"] = "99"

	TITLE_CODES["776"] = {}
		TITLE_CODES["776"]["title"] = "ASSOCIATE DENTIST"
		TITLE_CODES["776"]["program"] = "MSP"
		TITLE_CODES["776"]["unit"] = "99"

	TITLE_CODES["771"] = {}
		TITLE_CODES["771"]["title"] = "ASSOCIATE PHYSICIAN"
		TITLE_CODES["771"]["program"] = "MSP"
		TITLE_CODES["771"]["unit"] = "99"

	TITLE_CODES["770"] = {}
		TITLE_CODES["770"]["title"] = "ASSO PHYSICIAN DIPLOMATE"
		TITLE_CODES["770"]["program"] = "MSP"
		TITLE_CODES["770"]["unit"] = "99"

	TITLE_CODES["773"] = {}
		TITLE_CODES["773"]["title"] = "SENIOR DENTIST DIPLOMATE"
		TITLE_CODES["773"]["program"] = "MSP"
		TITLE_CODES["773"]["unit"] = "99"

	TITLE_CODES["772"] = {}
		TITLE_CODES["772"]["title"] = "ASSISTANT PHYSICIAN"
		TITLE_CODES["772"]["program"] = "MSP"
		TITLE_CODES["772"]["unit"] = "99"

	TITLE_CODES["779"] = {}
		TITLE_CODES["779"]["title"] = "STAFF PHYSICIAN"
		TITLE_CODES["779"]["program"] = "MSP"
		TITLE_CODES["779"]["unit"] = "99"

	TITLE_CODES["778"] = {}
		TITLE_CODES["778"]["title"] = "CONSULTING PHYSICIAN (SHS)"
		TITLE_CODES["778"]["program"] = "MSP"
		TITLE_CODES["778"]["unit"] = "99"

	TITLE_CODES["9338"] = {}
		TITLE_CODES["9338"]["title"] = "COORDINATOR VOL SERVICES I"
		TITLE_CODES["9338"]["program"] = "PSS"
		TITLE_CODES["9338"]["unit"] = "EX"

	TITLE_CODES["7100"] = {}
		TITLE_CODES["7100"]["title"] = "PRINCIPAL DRAFTING TECH - SUPV"
		TITLE_CODES["7100"]["program"] = "PSS"
		TITLE_CODES["7100"]["unit"] = "99"

	TITLE_CODES["7101"] = {}
		TITLE_CODES["7101"]["title"] = "TECHNICIAN, DRAFTING, PRIN"
		TITLE_CODES["7101"]["program"] = "PSS"
		TITLE_CODES["7101"]["unit"] = "TX"

	TITLE_CODES["7102"] = {}
		TITLE_CODES["7102"]["title"] = "TECHNICIAN, DRAFTING, SR"
		TITLE_CODES["7102"]["program"] = "PSS"
		TITLE_CODES["7102"]["unit"] = "TX"

	TITLE_CODES["7103"] = {}
		TITLE_CODES["7103"]["title"] = "TECHNICIAN, DRAFTING"
		TITLE_CODES["7103"]["program"] = "PSS"
		TITLE_CODES["7103"]["unit"] = "TX"

	TITLE_CODES["3351"] = {}
		TITLE_CODES["3351"]["title"] = "ASST PROF IN RSDNC-ACAD YR-1/9"
		TITLE_CODES["3351"]["program"] = "ACADEMIC"
		TITLE_CODES["3351"]["unit"] = "A3"

	TITLE_CODES["3350"] = {}
		TITLE_CODES["3350"]["title"] = "INSTR IN RSDNC-ACAD YR-1/9TH"
		TITLE_CODES["3350"]["program"] = "ACADEMIC"
		TITLE_CODES["3350"]["unit"] = "A3"

	TITLE_CODES["71"] = {}
		TITLE_CODES["71"]["title"] = "FINANCIAL OFFICER"
		TITLE_CODES["71"]["program"] = "MSP"
		TITLE_CODES["71"]["unit"] = "99"

	TITLE_CODES["70"] = {}
		TITLE_CODES["70"]["title"] = "ASSISTANT TREASURER(FUNC AREA)"
		TITLE_CODES["70"]["program"] = "MSP"
		TITLE_CODES["70"]["unit"] = "99"

	TITLE_CODES["7661"] = {}
		TITLE_CODES["7661"]["title"] = "ANALYST, PERSONNEL, PRIN I"
		TITLE_CODES["7661"]["program"] = "PSS"
		TITLE_CODES["7661"]["unit"] = "99"

	TITLE_CODES["7660"] = {}
		TITLE_CODES["7660"]["title"] = "PERSONNEL ANALYST SUPERVISOR"
		TITLE_CODES["7660"]["program"] = "PSS"
		TITLE_CODES["7660"]["unit"] = "99"

	TITLE_CODES["7663"] = {}
		TITLE_CODES["7663"]["title"] = "ANALYST, PERSONNEL"
		TITLE_CODES["7663"]["program"] = "PSS"
		TITLE_CODES["7663"]["unit"] = "99"

	TITLE_CODES["7662"] = {}
		TITLE_CODES["7662"]["title"] = "ANALYST, PERSONNEL, SR"
		TITLE_CODES["7662"]["program"] = "PSS"
		TITLE_CODES["7662"]["unit"] = "99"

	TITLE_CODES["9104"] = {}
		TITLE_CODES["9104"]["title"] = "THERAPIST, RESPIRATORY III-SUP"
		TITLE_CODES["9104"]["program"] = "PSS"
		TITLE_CODES["9104"]["unit"] = "99"

	TITLE_CODES["7664"] = {}
		TITLE_CODES["7664"]["title"] = "ANALYST, PERSONNEL, ASST"
		TITLE_CODES["7664"]["program"] = "PSS"
		TITLE_CODES["7664"]["unit"] = "99"

	TITLE_CODES["3050"] = {}
		TITLE_CODES["3050"]["title"] = "ASSOC IN ------- IN THE A.E.S."
		TITLE_CODES["3050"]["program"] = "ACADEMIC"
		TITLE_CODES["3050"]["unit"] = "FX"

	TITLE_CODES["7666"] = {}
		TITLE_CODES["7666"]["title"] = "SPECIALIST, PARALEGAL, SR."
		TITLE_CODES["7666"]["program"] = "PSS"
		TITLE_CODES["7666"]["unit"] = "99"

	TITLE_CODES["1040"] = {}
		TITLE_CODES["1040"]["title"] = "DEAN-EXTENDED LEARNING"
		TITLE_CODES["1040"]["program"] = "ACADEMIC"
		TITLE_CODES["1040"]["unit"] = "99"

	TITLE_CODES["1047"] = {}
		TITLE_CODES["1047"]["title"] = "ACT/INTERIM PROVOST OF ___COLL"
		TITLE_CODES["1047"]["program"] = "ACADEMIC"
		TITLE_CODES["1047"]["unit"] = "99"

	TITLE_CODES["1045"] = {}
		TITLE_CODES["1045"]["title"] = "FACULTY ASST TO T/VICE CHANC"
		TITLE_CODES["1045"]["program"] = "ACADEMIC"
		TITLE_CODES["1045"]["unit"] = "99"

	TITLE_CODES["1044"] = {}
		TITLE_CODES["1044"]["title"] = "FACULTY ASST TT CHANCELLOR"
		TITLE_CODES["1044"]["program"] = "ACADEMIC"
		TITLE_CODES["1044"]["unit"] = "99"

	TITLE_CODES["5443"] = {}
		TITLE_CODES["5443"]["title"] = "FOOD SERVICE MANAGER, SR"
		TITLE_CODES["5443"]["program"] = "PSS"
		TITLE_CODES["5443"]["unit"] = "99"

	TITLE_CODES["5442"] = {}
		TITLE_CODES["5442"]["title"] = "FOOD SERVICE MANAGER, PRIN"
		TITLE_CODES["5442"]["program"] = "PSS"
		TITLE_CODES["5442"]["unit"] = "99"

	TITLE_CODES["3381"] = {}
		TITLE_CODES["3381"]["title"] = "PROF IN RES-AY-BUS/ECON/ENG"
		TITLE_CODES["3381"]["program"] = "ACADEMIC"
		TITLE_CODES["3381"]["unit"] = "A3"

	TITLE_CODES["5447"] = {}
		TITLE_CODES["5447"]["title"] = "FOOD SERVICE MGR, ASST-SUPVR"
		TITLE_CODES["5447"]["program"] = "PSS"
		TITLE_CODES["5447"]["unit"] = "99"

	TITLE_CODES["5445"] = {}
		TITLE_CODES["5445"]["title"] = "FOOD SERVICE MGR, ASST"
		TITLE_CODES["5445"]["program"] = "PSS"
		TITLE_CODES["5445"]["unit"] = "SX"

	TITLE_CODES["3981"] = {}
		TITLE_CODES["3981"]["title"] = "STATE SAL DIFF-XMURAL-LPNI/NPI"
		TITLE_CODES["3981"]["program"] = "ACADEMIC"
		TITLE_CODES["3981"]["unit"] = "87"

	TITLE_CODES["1681"] = {}
		TITLE_CODES["1681"]["title"] = "LECTURER-PSOE-ACAD YR-1/9-100%"
		TITLE_CODES["1681"]["program"] = "ACADEMIC"
		TITLE_CODES["1681"]["unit"] = "A3"

	TITLE_CODES["1680"] = {}
		TITLE_CODES["1680"]["title"] = "LECTURER-PSOE-ACAD YR-100%"
		TITLE_CODES["1680"]["program"] = "ACADEMIC"
		TITLE_CODES["1680"]["unit"] = "A3"

	TITLE_CODES["1683"] = {}
		TITLE_CODES["1683"]["title"] = "SR LECTURER-PSOE-ACAD YR-100%"
		TITLE_CODES["1683"]["program"] = "ACADEMIC"
		TITLE_CODES["1683"]["unit"] = "A3"

	TITLE_CODES["1682"] = {}
		TITLE_CODES["1682"]["title"] = "LECTURER-PSOE-FISCAL YR-100%"
		TITLE_CODES["1682"]["program"] = "ACADEMIC"
		TITLE_CODES["1682"]["unit"] = "A3"

	TITLE_CODES["1685"] = {}
		TITLE_CODES["1685"]["title"] = "SR LECTURER-PSOE-FY-100%"
		TITLE_CODES["1685"]["program"] = "ACADEMIC"
		TITLE_CODES["1685"]["unit"] = "A3"

	TITLE_CODES["1684"] = {}
		TITLE_CODES["1684"]["title"] = "SR LECTURER-PSOE-AY-1/9-100%"
		TITLE_CODES["1684"]["program"] = "ACADEMIC"
		TITLE_CODES["1684"]["unit"] = "A3"

	TITLE_CODES["1762"] = {}
		TITLE_CODES["1762"]["title"] = "ACT PROFESSOR-MEDCOMP-B"
		TITLE_CODES["1762"]["program"] = "ACADEMIC"
		TITLE_CODES["1762"]["unit"] = "A3"

	TITLE_CODES["1763"] = {}
		TITLE_CODES["1763"]["title"] = "INSTRUCTOR-IN-RES-MEDCOMP-B"
		TITLE_CODES["1763"]["program"] = "ACADEMIC"
		TITLE_CODES["1763"]["unit"] = "A3"

	TITLE_CODES["1760"] = {}
		TITLE_CODES["1760"]["title"] = "ACT ASSOC PROFESSOR-MEDCOMP-B"
		TITLE_CODES["1760"]["program"] = "ACADEMIC"
		TITLE_CODES["1760"]["unit"] = "A3"

	TITLE_CODES["1761"] = {}
		TITLE_CODES["1761"]["title"] = "PROFESSOR-MEDCOMP-B"
		TITLE_CODES["1761"]["program"] = "ACADEMIC"
		TITLE_CODES["1761"]["unit"] = "A3"

	TITLE_CODES["1766"] = {}
		TITLE_CODES["1766"]["title"] = "PROF IN RES-MEDCOMP-B"
		TITLE_CODES["1766"]["program"] = "ACADEMIC"
		TITLE_CODES["1766"]["unit"] = "A3"

	TITLE_CODES["1767"] = {}
		TITLE_CODES["1767"]["title"] = "ADJUNCT INSTRUCTOR-MEDCOMP-B"
		TITLE_CODES["1767"]["program"] = "ACADEMIC"
		TITLE_CODES["1767"]["unit"] = "99"

	TITLE_CODES["1764"] = {}
		TITLE_CODES["1764"]["title"] = "ASST PROF-IN-RES-MEDCOMP-B"
		TITLE_CODES["1764"]["program"] = "ACADEMIC"
		TITLE_CODES["1764"]["unit"] = "A3"

	TITLE_CODES["1765"] = {}
		TITLE_CODES["1765"]["title"] = "ASSOC PROF IN RES-MEDCOMP-B"
		TITLE_CODES["1765"]["program"] = "ACADEMIC"
		TITLE_CODES["1765"]["unit"] = "A3"

	TITLE_CODES["6961"] = {}
		TITLE_CODES["6961"]["title"] = "PLANNER, ED FACILITY, SR-SUPVR"
		TITLE_CODES["6961"]["program"] = "PSS"
		TITLE_CODES["6961"]["unit"] = "99"

	TITLE_CODES["1143"] = {}
		TITLE_CODES["1143"]["title"] = "PROFESSOR-ACAD YR-BUS/ECON/ENG"
		TITLE_CODES["1143"]["program"] = "ACADEMIC"
		TITLE_CODES["1143"]["unit"] = "A3"

	TITLE_CODES["6963"] = {}
		TITLE_CODES["6963"]["title"] = "PLANNER, EDUCATIONAL FACILITY"
		TITLE_CODES["6963"]["program"] = "PSS"
		TITLE_CODES["6963"]["unit"] = "99"

	TITLE_CODES["6962"] = {}
		TITLE_CODES["6962"]["title"] = "PLANNER,EDUCATIONAL FACILTY,SR"
		TITLE_CODES["6962"]["program"] = "PSS"
		TITLE_CODES["6962"]["unit"] = "99"

	TITLE_CODES["1146"] = {}
		TITLE_CODES["1146"]["title"] = "PROF-AY-BUS/ECON/ENG-RECALLED"
		TITLE_CODES["1146"]["program"] = "ACADEMIC"
		TITLE_CODES["1146"]["unit"] = "A3"

	TITLE_CODES["3520"] = {}
		TITLE_CODES["3520"]["title"] = "CONTINUING EDUCATOR I"
		TITLE_CODES["3520"]["program"] = "ACADEMIC"
		TITLE_CODES["3520"]["unit"] = "FX"

	TITLE_CODES["1144"] = {}
		TITLE_CODES["1144"]["title"] = "PROFESSOR - FY -BUS/ECON/ENG"
		TITLE_CODES["1144"]["program"] = "ACADEMIC"
		TITLE_CODES["1144"]["unit"] = "A3"

	TITLE_CODES["1145"] = {}
		TITLE_CODES["1145"]["title"] = "PROFESSOR-AY-1/9-BUS/ECON/ENG"
		TITLE_CODES["1145"]["program"] = "ACADEMIC"
		TITLE_CODES["1145"]["unit"] = "A3"

	TITLE_CODES["6969"] = {}
		TITLE_CODES["6969"]["title"] = "PLANNER, ASST"
		TITLE_CODES["6969"]["program"] = "PSS"
		TITLE_CODES["6969"]["unit"] = "99"

	TITLE_CODES["6968"] = {}
		TITLE_CODES["6968"]["title"] = "PLANNER, ASSOC"
		TITLE_CODES["6968"]["program"] = "PSS"
		TITLE_CODES["6968"]["unit"] = "99"

	TITLE_CODES["1148"] = {}
		TITLE_CODES["1148"]["title"] = "PROF-AY-1/9-BUS/ECON/ENG-RECAL"
		TITLE_CODES["1148"]["program"] = "ACADEMIC"
		TITLE_CODES["1148"]["unit"] = "A3"

	TITLE_CODES["3521"] = {}
		TITLE_CODES["3521"]["title"] = "CONTINUING EDUCATOR II"
		TITLE_CODES["3521"]["program"] = "ACADEMIC"
		TITLE_CODES["3521"]["unit"] = "FX"

	TITLE_CODES["8259"] = {}
		TITLE_CODES["8259"]["title"] = "PLUMBER, APPRENTICE"
		TITLE_CODES["8259"]["program"] = "PSS"
		TITLE_CODES["8259"]["unit"] = "K3"

	TITLE_CODES["8153"] = {}
		TITLE_CODES["8153"]["title"] = "GROUNDSKEEPER GARDENER"
		TITLE_CODES["8153"]["program"] = "PSS"
		TITLE_CODES["8153"]["unit"] = "SX"

	TITLE_CODES["8150"] = {}
		TITLE_CODES["8150"]["title"] = "INSPECTOR-PLANNER-ESTIMATOR,SR"
		TITLE_CODES["8150"]["program"] = "PSS"
		TITLE_CODES["8150"]["unit"] = "K3"

	TITLE_CODES["8151"] = {}
		TITLE_CODES["8151"]["title"] = "INSPECTOR-PLANNER-ESTIMATOR"
		TITLE_CODES["8151"]["program"] = "PSS"
		TITLE_CODES["8151"]["unit"] = "K3"

	TITLE_CODES["9623"] = {}
		TITLE_CODES["9623"]["title"] = "SCANNER I"
		TITLE_CODES["9623"]["program"] = "PSS"
		TITLE_CODES["9623"]["unit"] = "TX"

	TITLE_CODES["3388"] = {}
		TITLE_CODES["3388"]["title"] = "AST PROF IN RES-FY-B/ECON/ENG"
		TITLE_CODES["3388"]["program"] = "ACADEMIC"
		TITLE_CODES["3388"]["unit"] = "A3"

	TITLE_CODES["3286"] = {}
		TITLE_CODES["3286"]["title"] = "GSR-TUIT & FEE REM-UCSD-GRP C"
		TITLE_CODES["3286"]["program"] = "ACADEMIC"
		TITLE_CODES["3286"]["unit"] = "99"

	TITLE_CODES["3389"] = {}
		TITLE_CODES["3389"]["title"] = "AST PRO IN RES-AY-1/9-B/ECN/EN"
		TITLE_CODES["3389"]["program"] = "ACADEMIC"
		TITLE_CODES["3389"]["unit"] = "A3"

	TITLE_CODES["5502"] = {}
		TITLE_CODES["5502"]["title"] = "BAKER, SR"
		TITLE_CODES["5502"]["program"] = "PSS"
		TITLE_CODES["5502"]["unit"] = "SX"

	TITLE_CODES["5100"] = {}
		TITLE_CODES["5100"]["title"] = "CUSTODIAN, PER DIEM"
		TITLE_CODES["5100"]["program"] = "PSS"
		TITLE_CODES["5100"]["unit"] = "SX"

	TITLE_CODES["5501"] = {}
		TITLE_CODES["5501"]["title"] = "BAKER, PRIN"
		TITLE_CODES["5501"]["program"] = "PSS"
		TITLE_CODES["5501"]["unit"] = "99"

	TITLE_CODES["1546"] = {}
		TITLE_CODES["1546"]["title"] = "PROF IN RES-GENCOMP-A"
		TITLE_CODES["1546"]["program"] = "ACADEMIC"
		TITLE_CODES["1546"]["unit"] = "A3"

	TITLE_CODES["1547"] = {}
		TITLE_CODES["1547"]["title"] = "ADJUNCT INSTRUCTOR-GENCOMP-A"
		TITLE_CODES["1547"]["program"] = "ACADEMIC"
		TITLE_CODES["1547"]["unit"] = "99"

	TITLE_CODES["1544"] = {}
		TITLE_CODES["1544"]["title"] = "ASST PROF IN RES-GENCOMP-A"
		TITLE_CODES["1544"]["program"] = "ACADEMIC"
		TITLE_CODES["1544"]["unit"] = "A3"

	TITLE_CODES["1545"] = {}
		TITLE_CODES["1545"]["title"] = "ASSOC PROF IN RES-GENCOMP-A"
		TITLE_CODES["1545"]["program"] = "ACADEMIC"
		TITLE_CODES["1545"]["unit"] = "A3"

	TITLE_CODES["1542"] = {}
		TITLE_CODES["1542"]["title"] = "ACTING PROFESSOR-HCOMP"
		TITLE_CODES["1542"]["program"] = "ACADEMIC"
		TITLE_CODES["1542"]["unit"] = "A3"

	TITLE_CODES["1543"] = {}
		TITLE_CODES["1543"]["title"] = "INSTRUCTOR IN RES-GENCOMP-A"
		TITLE_CODES["1543"]["program"] = "ACADEMIC"
		TITLE_CODES["1543"]["unit"] = "A3"

	TITLE_CODES["1540"] = {}
		TITLE_CODES["1540"]["title"] = "ACTING ASSOC PROFESSOR-HCOMP"
		TITLE_CODES["1540"]["program"] = "ACADEMIC"
		TITLE_CODES["1540"]["unit"] = "A3"

	TITLE_CODES["1541"] = {}
		TITLE_CODES["1541"]["title"] = "PROFESSOR-GENCOMP-A"
		TITLE_CODES["1541"]["program"] = "ACADEMIC"
		TITLE_CODES["1541"]["unit"] = "A3"

	TITLE_CODES["7614"] = {}
		TITLE_CODES["7614"]["title"] = "ACCOUNTANT III - SUPERVISOR"
		TITLE_CODES["7614"]["program"] = "PSS"
		TITLE_CODES["7614"]["unit"] = "99"

	TITLE_CODES["7615"] = {}
		TITLE_CODES["7615"]["title"] = "ACCOUNTANT V"
		TITLE_CODES["7615"]["program"] = "PSS"
		TITLE_CODES["7615"]["unit"] = "99"

	TITLE_CODES["3120"] = {}
		TITLE_CODES["3120"]["title"] = "ASSISTANT ASTRONOMER"
		TITLE_CODES["3120"]["program"] = "ACADEMIC"
		TITLE_CODES["3120"]["unit"] = "FX"

	TITLE_CODES["7617"] = {}
		TITLE_CODES["7617"]["title"] = "ACCOUNTANT III"
		TITLE_CODES["7617"]["program"] = "PSS"
		TITLE_CODES["7617"]["unit"] = "99"

	TITLE_CODES["3127"] = {}
		TITLE_CODES["3127"]["title"] = "ACTING ASSISTANT ASTRONOMER"
		TITLE_CODES["3127"]["program"] = "ACADEMIC"
		TITLE_CODES["3127"]["unit"] = "99"

	TITLE_CODES["1548"] = {}
		TITLE_CODES["1548"]["title"] = "ASST ADJUNCT PROF-GENCOMP-A"
		TITLE_CODES["1548"]["program"] = "ACADEMIC"
		TITLE_CODES["1548"]["unit"] = "99"

	TITLE_CODES["1549"] = {}
		TITLE_CODES["1549"]["title"] = "ASSOC ADJUNCT PROF-GENCOMP-A"
		TITLE_CODES["1549"]["program"] = "ACADEMIC"
		TITLE_CODES["1549"]["unit"] = "99"

	TITLE_CODES["1780"] = {}
		TITLE_CODES["1780"]["title"] = "ACT ASSOC PROFESSOR-FY-MEDCOMP"
		TITLE_CODES["1780"]["program"] = "ACADEMIC"
		TITLE_CODES["1780"]["unit"] = "A3"

	TITLE_CODES["1469"] = {}
		TITLE_CODES["1469"]["title"] = "ASO PROF OF CLIN___-FY-GENCOMP"
		TITLE_CODES["1469"]["program"] = "ACADEMIC"
		TITLE_CODES["1469"]["unit"] = "A3"

	TITLE_CODES["1468"] = {}
		TITLE_CODES["1468"]["title"] = "PROF OF CLIN ____-FY-GENCOMP"
		TITLE_CODES["1468"]["program"] = "ACADEMIC"
		TITLE_CODES["1468"]["unit"] = "A3"

	TITLE_CODES["1781"] = {}
		TITLE_CODES["1781"]["title"] = "PROFESSOR-FY-MEDCOMP"
		TITLE_CODES["1781"]["program"] = "ACADEMIC"
		TITLE_CODES["1781"]["unit"] = "A3"

	TITLE_CODES["1465"] = {}
		TITLE_CODES["1465"]["title"] = "PROF OF CLIN ____-FY-MEDCOMP"
		TITLE_CODES["1465"]["program"] = "ACADEMIC"
		TITLE_CODES["1465"]["unit"] = "A3"

	TITLE_CODES["1464"] = {}
		TITLE_CODES["1464"]["title"] = "AST PROF OF CLIN____-GENCOMP-A"
		TITLE_CODES["1464"]["program"] = "ACADEMIC"
		TITLE_CODES["1464"]["unit"] = "A3"

	TITLE_CODES["1467"] = {}
		TITLE_CODES["1467"]["title"] = "AST PROF OF CLIN___-FY-MEDCOMP"
		TITLE_CODES["1467"]["program"] = "ACADEMIC"
		TITLE_CODES["1467"]["unit"] = "A3"

	TITLE_CODES["1466"] = {}
		TITLE_CODES["1466"]["title"] = "ASO PROF OF CLIN____-FY-MECOMP"
		TITLE_CODES["1466"]["program"] = "ACADEMIC"
		TITLE_CODES["1466"]["unit"] = "A3"

	TITLE_CODES["1461"] = {}
		TITLE_CODES["1461"]["title"] = "AST PROF OF CLIN____-MEDCOMP-B"
		TITLE_CODES["1461"]["program"] = "ACADEMIC"
		TITLE_CODES["1461"]["unit"] = "A3"

	TITLE_CODES["1460"] = {}
		TITLE_CODES["1460"]["title"] = "ASO PROF OF CLIN_-MEDCOMP-B"
		TITLE_CODES["1460"]["program"] = "ACADEMIC"
		TITLE_CODES["1460"]["unit"] = "A3"

	TITLE_CODES["1463"] = {}
		TITLE_CODES["1463"]["title"] = "ASO PROF OF CLIN ___-GENCOMP-A"
		TITLE_CODES["1463"]["program"] = "ACADEMIC"
		TITLE_CODES["1463"]["unit"] = "A3"

	TITLE_CODES["1462"] = {}
		TITLE_CODES["1462"]["title"] = "PROF OF CLIN ____-GENCOMP-A"
		TITLE_CODES["1462"]["program"] = "ACADEMIC"
		TITLE_CODES["1462"]["unit"] = "A3"

	TITLE_CODES["1317"] = {}
		TITLE_CODES["1317"]["title"] = "ACT ASST PROFESSOR -FISCAL YR"
		TITLE_CODES["1317"]["program"] = "ACADEMIC"
		TITLE_CODES["1317"]["unit"] = "99"

	TITLE_CODES["1783"] = {}
		TITLE_CODES["1783"]["title"] = "INSTRUCTOR IN RES-FY-MEDCOMP"
		TITLE_CODES["1783"]["program"] = "ACADEMIC"
		TITLE_CODES["1783"]["unit"] = "A3"

	TITLE_CODES["9222"] = {}
		TITLE_CODES["9222"]["title"] = "TECH III, CENTRAL STERILE, PD"
		TITLE_CODES["9222"]["program"] = "PSS"
		TITLE_CODES["9222"]["unit"] = "EX"

	TITLE_CODES["1310"] = {}
		TITLE_CODES["1310"]["title"] = "ASST PROFESSOR - FISCAL YEAR"
		TITLE_CODES["1310"]["program"] = "ACADEMIC"
		TITLE_CODES["1310"]["unit"] = "A3"

	TITLE_CODES["9610"] = {}
		TITLE_CODES["9610"]["title"] = "STAFF RESEARCH ASSOC IV"
		TITLE_CODES["9610"]["program"] = "PSS"
		TITLE_CODES["9610"]["unit"] = "RX"

	TITLE_CODES["1784"] = {}
		TITLE_CODES["1784"]["title"] = "ASST PROF IN RES-FY-MEDCOMP"
		TITLE_CODES["1784"]["program"] = "ACADEMIC"
		TITLE_CODES["1784"]["unit"] = "A3"

	TITLE_CODES["1318"] = {}
		TITLE_CODES["1318"]["title"] = "VST ASST PROFESSOR -FISCAL YR"
		TITLE_CODES["1318"]["program"] = "ACADEMIC"
		TITLE_CODES["1318"]["unit"] = "99"

	TITLE_CODES["6447"] = {}
		TITLE_CODES["6447"]["title"] = "PROGRAM REPRESENTATIVE III-SUP"
		TITLE_CODES["6447"]["program"] = "PSS"
		TITLE_CODES["6447"]["unit"] = "99"

	TITLE_CODES["8028"] = {}
		TITLE_CODES["8028"]["title"] = "PATHOLOGIST, SPEECH, SR-SUPVR"
		TITLE_CODES["8028"]["program"] = "PSS"
		TITLE_CODES["8028"]["unit"] = "99"

	TITLE_CODES["6910"] = {}
		TITLE_CODES["6910"]["title"] = "CUSTOMER SERVICE REP SUPV"
		TITLE_CODES["6910"]["program"] = "PSS"
		TITLE_CODES["6910"]["unit"] = "99"

	TITLE_CODES["1786"] = {}
		TITLE_CODES["1786"]["title"] = "PROF IN RES-FY-MEDCOMP"
		TITLE_CODES["1786"]["program"] = "ACADEMIC"
		TITLE_CODES["1786"]["unit"] = "A3"

	TITLE_CODES["8022"] = {}
		TITLE_CODES["8022"]["title"] = "REHAB SERV ASSOC CHIEF--SUPVR"
		TITLE_CODES["8022"]["program"] = "PSS"
		TITLE_CODES["8022"]["unit"] = "99"

	TITLE_CODES["8023"] = {}
		TITLE_CODES["8023"]["title"] = "ATHLETIC TRAINER--SUPERVISOR"
		TITLE_CODES["8023"]["program"] = "PSS"
		TITLE_CODES["8023"]["unit"] = "99"

	TITLE_CODES["8020"] = {}
		TITLE_CODES["8020"]["title"] = "PSYCHOLOGIST I-SUPVR"
		TITLE_CODES["8020"]["program"] = "PSS"
		TITLE_CODES["8020"]["unit"] = "99"

	TITLE_CODES["1787"] = {}
		TITLE_CODES["1787"]["title"] = "ADJUNCT INSTRUCTOR-FY-MEDCOMP"
		TITLE_CODES["1787"]["program"] = "ACADEMIC"
		TITLE_CODES["1787"]["unit"] = "99"

	TITLE_CODES["7183"] = {}
		TITLE_CODES["7183"]["title"] = "ENGINEER, DEVELOPMENT, ASST"
		TITLE_CODES["7183"]["program"] = "PSS"
		TITLE_CODES["7183"]["unit"] = "99"

	TITLE_CODES["8027"] = {}
		TITLE_CODES["8027"]["title"] = "PATHOLOIST, SPEECH-SUPVR"
		TITLE_CODES["8027"]["program"] = "PSS"
		TITLE_CODES["8027"]["unit"] = "99"

	TITLE_CODES["6448"] = {}
		TITLE_CODES["6448"]["title"] = "PROGRAM REPRESENTATIVE II-SUP"
		TITLE_CODES["6448"]["program"] = "PSS"
		TITLE_CODES["6448"]["unit"] = "99"

	TITLE_CODES["8025"] = {}
		TITLE_CODES["8025"]["title"] = "THERAPIST, RECREATION I-SUPVR"
		TITLE_CODES["8025"]["program"] = "PSS"
		TITLE_CODES["8025"]["unit"] = "99"

	TITLE_CODES["7113"] = {}
		TITLE_CODES["7113"]["title"] = "ENGINEER, TELEVISION"
		TITLE_CODES["7113"]["program"] = "PSS"
		TITLE_CODES["7113"]["unit"] = "TX"

	TITLE_CODES["1400"] = {}
		TITLE_CODES["1400"]["title"] = "INSTRUCTOR-ACADEMIC YEAR"
		TITLE_CODES["1400"]["program"] = "ACADEMIC"
		TITLE_CODES["1400"]["unit"] = "A3"

	TITLE_CODES["5421"] = {}
		TITLE_CODES["5421"]["title"] = "DIETITIAN, PD"
		TITLE_CODES["5421"]["program"] = "PSS"
		TITLE_CODES["5421"]["unit"] = "HX"

	TITLE_CODES["9316"] = {}
		TITLE_CODES["9316"]["title"] = "SOCIAL WORKER II, CLINICAL P D"
		TITLE_CODES["9316"]["program"] = "PSS"
		TITLE_CODES["9316"]["unit"] = "HX"

	TITLE_CODES["7686"] = {}
		TITLE_CODES["7686"]["title"] = "SENIOR EDITOR - SUPERVISOR"
		TITLE_CODES["7686"]["program"] = "PSS"
		TITLE_CODES["7686"]["unit"] = "99"

	TITLE_CODES["7685"] = {}
		TITLE_CODES["7685"]["title"] = "EDITOR, ASST"
		TITLE_CODES["7685"]["program"] = "PSS"
		TITLE_CODES["7685"]["unit"] = "TX"

	TITLE_CODES["7684"] = {}
		TITLE_CODES["7684"]["title"] = "EDITOR"
		TITLE_CODES["7684"]["program"] = "PSS"
		TITLE_CODES["7684"]["unit"] = "TX"

	TITLE_CODES["7683"] = {}
		TITLE_CODES["7683"]["title"] = "EDITOR, SR"
		TITLE_CODES["7683"]["program"] = "PSS"
		TITLE_CODES["7683"]["unit"] = "99"

	TITLE_CODES["7682"] = {}
		TITLE_CODES["7682"]["title"] = "EDITOR, PRIN"
		TITLE_CODES["7682"]["program"] = "PSS"
		TITLE_CODES["7682"]["unit"] = "99"

	TITLE_CODES["7681"] = {}
		TITLE_CODES["7681"]["title"] = "EDITOR SUPERVISOR"
		TITLE_CODES["7681"]["program"] = "PSS"
		TITLE_CODES["7681"]["unit"] = "99"

	TITLE_CODES["7680"] = {}
		TITLE_CODES["7680"]["title"] = "EDITOR, PRINCIPAL - SUPERVISOR"
		TITLE_CODES["7680"]["program"] = "PSS"
		TITLE_CODES["7680"]["unit"] = "99"

	TITLE_CODES["9236"] = {}
		TITLE_CODES["9236"]["title"] = "GRADUATE INTERN PHARMACIST"
		TITLE_CODES["9236"]["program"] = "PSS"
		TITLE_CODES["9236"]["unit"] = "99"

	TITLE_CODES["2265"] = {}
		TITLE_CODES["2265"]["title"] = "FIELD WORK CONSULTANT - FY"
		TITLE_CODES["2265"]["program"] = "ACADEMIC"
		TITLE_CODES["2265"]["unit"] = "IX"

	TITLE_CODES["9155"] = {}
		TITLE_CODES["9155"]["title"] = "BIOMEDICAL EQUIPMENT TECH III"
		TITLE_CODES["9155"]["program"] = "PSS"
		TITLE_CODES["9155"]["unit"] = "EX"

	TITLE_CODES["8041"] = {}
		TITLE_CODES["8041"]["title"] = "TECHNO, NUC MED, ASSOC CHR-SUP"
		TITLE_CODES["8041"]["program"] = "PSS"
		TITLE_CODES["8041"]["unit"] = "99"

	TITLE_CODES["7214"] = {}
		TITLE_CODES["7214"]["title"] = "STATISTICIAN, ASST"
		TITLE_CODES["7214"]["program"] = "PSS"
		TITLE_CODES["7214"]["unit"] = "99"

	TITLE_CODES["8329"] = {}
		TITLE_CODES["8329"]["title"] = "LEAD OPERATIONS MECHANIC"
		TITLE_CODES["8329"]["program"] = "PSS"
		TITLE_CODES["8329"]["unit"] = "K3"

	TITLE_CODES["4211"] = {}
		TITLE_CODES["4211"]["title"] = "INTERVIEWER, PLACEMENT, PRIN"
		TITLE_CODES["4211"]["program"] = "PSS"
		TITLE_CODES["4211"]["unit"] = "99"

	TITLE_CODES["6283"] = {}
		TITLE_CODES["6283"]["title"] = "HOUSE MANAGER I"
		TITLE_CODES["6283"]["program"] = "PSS"
		TITLE_CODES["6283"]["unit"] = "99"

	TITLE_CODES["9288"] = {}
		TITLE_CODES["9288"]["title"] = "COUNSELOR, GENETIC I"
		TITLE_CODES["9288"]["program"] = "PSS"
		TITLE_CODES["9288"]["unit"] = "HX"

	TITLE_CODES["9150"] = {}
		TITLE_CODES["9150"]["title"] = "NURSE PRACTITIONER II-SUPVR"
		TITLE_CODES["9150"]["program"] = "PSS"
		TITLE_CODES["9150"]["unit"] = "99"

	TITLE_CODES["8046"] = {}
		TITLE_CODES["8046"]["title"] = "PHYSICIST, HOSP RADIATION-SUP"
		TITLE_CODES["8046"]["program"] = "PSS"
		TITLE_CODES["8046"]["unit"] = "99"

	TITLE_CODES["4122"] = {}
		TITLE_CODES["4122"]["title"] = "RESIDENT ADVISOR"
		TITLE_CODES["4122"]["program"] = "PSS"
		TITLE_CODES["4122"]["unit"] = "99"

	TITLE_CODES["4121"] = {}
		TITLE_CODES["4121"]["title"] = "RESIDENT DIRECTOR I"
		TITLE_CODES["4121"]["program"] = "PSS"
		TITLE_CODES["4121"]["unit"] = "99"

	TITLE_CODES["4120"] = {}
		TITLE_CODES["4120"]["title"] = "RESIDENT ADVISOR SUPERVISOR"
		TITLE_CODES["4120"]["program"] = "PSS"
		TITLE_CODES["4120"]["unit"] = "99"

	TITLE_CODES["8107"] = {}
		TITLE_CODES["8107"]["title"] = "PAINTER, APPRENTICE"
		TITLE_CODES["8107"]["program"] = "PSS"
		TITLE_CODES["8107"]["unit"] = "K3"

	TITLE_CODES["4126"] = {}
		TITLE_CODES["4126"]["title"] = "RESIDENT ASST"
		TITLE_CODES["4126"]["program"] = "PSS"
		TITLE_CODES["4126"]["unit"] = "99"

	TITLE_CODES["4125"] = {}
		TITLE_CODES["4125"]["title"] = "RESIDENT, HEAD"
		TITLE_CODES["4125"]["program"] = "PSS"
		TITLE_CODES["4125"]["unit"] = "99"

	TITLE_CODES["4124"] = {}
		TITLE_CODES["4124"]["title"] = "RESIDENT ASSISTANT SUPERVISOR"
		TITLE_CODES["4124"]["program"] = "PSS"
		TITLE_CODES["4124"]["unit"] = "99"

	TITLE_CODES["9524"] = {}
		TITLE_CODES["9524"]["title"] = "TECHNICIAN, ANIMAL, SR"
		TITLE_CODES["9524"]["program"] = "PSS"
		TITLE_CODES["9524"]["unit"] = "TX"

	TITLE_CODES["7539"] = {}
		TITLE_CODES["7539"]["title"] = "ASSISTANT TO THE ____II- SUPVR"
		TITLE_CODES["7539"]["program"] = "PSS"
		TITLE_CODES["7539"]["unit"] = "99"

	TITLE_CODES["7538"] = {}
		TITLE_CODES["7538"]["title"] = "ASSISTANT TO THE ____I - SUPVR"
		TITLE_CODES["7538"]["program"] = "PSS"
		TITLE_CODES["7538"]["unit"] = "99"

	TITLE_CODES["9525"] = {}
		TITLE_CODES["9525"]["title"] = "TECHNICIAN, ANIMAL"
		TITLE_CODES["9525"]["program"] = "PSS"
		TITLE_CODES["9525"]["unit"] = "TX"

	TITLE_CODES["366"] = {}
		TITLE_CODES["366"]["title"] = "ASST.ADM/COORD/OFC (FUNC AREA)"
		TITLE_CODES["366"]["program"] = "MSP"
		TITLE_CODES["366"]["unit"] = "99"

	TITLE_CODES["6213"] = {}
		TITLE_CODES["6213"]["title"] = "PRODUCER-DIRECTOR, SR"
		TITLE_CODES["6213"]["program"] = "PSS"
		TITLE_CODES["6213"]["unit"] = "TX"

	TITLE_CODES["6270"] = {}
		TITLE_CODES["6270"]["title"] = "USHER SUPERVISOR"
		TITLE_CODES["6270"]["program"] = "PSS"
		TITLE_CODES["6270"]["unit"] = "99"

	TITLE_CODES["363"] = {}
		TITLE_CODES["363"]["title"] = "ASSOC ADM/COORD/OFC (FTL AREA)"
		TITLE_CODES["363"]["program"] = "MSP"
		TITLE_CODES["363"]["unit"] = "99"

	TITLE_CODES["6212"] = {}
		TITLE_CODES["6212"]["title"] = "PRODUCER-DIRECTOR, PRIN"
		TITLE_CODES["6212"]["program"] = "PSS"
		TITLE_CODES["6212"]["unit"] = "99"

	TITLE_CODES["9255"] = {}
		TITLE_CODES["9255"]["title"] = "____ASSISTANT, HOSP, III-SUPVR"
		TITLE_CODES["9255"]["program"] = "PSS"
		TITLE_CODES["9255"]["unit"] = "99"

	TITLE_CODES["7246"] = {}
		TITLE_CODES["7246"]["title"] = "ANALYST II-SUPERVISOR"
		TITLE_CODES["7246"]["program"] = "PSS"
		TITLE_CODES["7246"]["unit"] = "99"

	TITLE_CODES["8106"] = {}
		TITLE_CODES["8106"]["title"] = "PAINTER"
		TITLE_CODES["8106"]["program"] = "PSS"
		TITLE_CODES["8106"]["unit"] = "K3"

	TITLE_CODES["2023"] = {}
		TITLE_CODES["2023"]["title"] = "ASSO CLIN PROF DENT-AY-PTC GEN"
		TITLE_CODES["2023"]["program"] = "ACADEMIC"
		TITLE_CODES["2023"]["unit"] = "99"

	TITLE_CODES["9521"] = {}
		TITLE_CODES["9521"]["title"] = "ANIMAL RESOURCES MANAGER"
		TITLE_CODES["9521"]["program"] = "PSS"
		TITLE_CODES["9521"]["unit"] = "99"

	TITLE_CODES["380"] = {}
		TITLE_CODES["380"]["title"] = "DEAN (FUNCTIONAL AREA)"
		TITLE_CODES["380"]["program"] = "MSP"
		TITLE_CODES["380"]["unit"] = "99"

	TITLE_CODES["6677"] = {}
		TITLE_CODES["6677"]["title"] = "READER FOR THE BLIND"
		TITLE_CODES["6677"]["program"] = "PSS"
		TITLE_CODES["6677"]["unit"] = "TX"

	TITLE_CODES["384"] = {}
		TITLE_CODES["384"]["title"] = "ASST DEAN (FUNCTIONAL AREA)"
		TITLE_CODES["384"]["program"] = "MSP"
		TITLE_CODES["384"]["unit"] = "99"

	TITLE_CODES["385"] = {}
		TITLE_CODES["385"]["title"] = "ASSOC DEAN (FUNTIONAL AREA)"
		TITLE_CODES["385"]["program"] = "MSP"
		TITLE_CODES["385"]["unit"] = "99"

	TITLE_CODES["386"] = {}
		TITLE_CODES["386"]["title"] = "VICE PROVOST (FUNCTIONAL AREA)"
		TITLE_CODES["386"]["program"] = "MSP"
		TITLE_CODES["386"]["unit"] = "99"

	TITLE_CODES["388"] = {}
		TITLE_CODES["388"]["title"] = "ASST. PROVOST"
		TITLE_CODES["388"]["program"] = "MSP"
		TITLE_CODES["388"]["unit"] = "99"

	TITLE_CODES["9523"] = {}
		TITLE_CODES["9523"]["title"] = "TECHNICIAN, ANIMAL, PRIN"
		TITLE_CODES["9523"]["program"] = "PSS"
		TITLE_CODES["9523"]["unit"] = "TX"

	TITLE_CODES["3215"] = {}
		TITLE_CODES["3215"]["title"] = "ASOC RES___-ACAD YR-1/9TH PYMT"
		TITLE_CODES["3215"]["program"] = "ACADEMIC"
		TITLE_CODES["3215"]["unit"] = "FX"

	TITLE_CODES["9611"] = {}
		TITLE_CODES["9611"]["title"] = "STAFF RESEARCH ASSOC III"
		TITLE_CODES["9611"]["program"] = "PSS"
		TITLE_CODES["9611"]["unit"] = "RX"

	TITLE_CODES["9147"] = {}
		TITLE_CODES["9147"]["title"] = "NURSE PRACTITIONER II"
		TITLE_CODES["9147"]["program"] = "PSS"
		TITLE_CODES["9147"]["unit"] = "NX"

	TITLE_CODES["7639"] = {}
		TITLE_CODES["7639"]["title"] = "EMPLOYMENT OFFICER/REP SUPV"
		TITLE_CODES["7639"]["program"] = "PSS"
		TITLE_CODES["7639"]["unit"] = "99"

	TITLE_CODES["6776"] = {}
		TITLE_CODES["6776"]["title"] = "BOOKMENDER, LIBRARY, SR-SUPVR"
		TITLE_CODES["6776"]["program"] = "PSS"
		TITLE_CODES["6776"]["unit"] = "99"

	TITLE_CODES["6772"] = {}
		TITLE_CODES["6772"]["title"] = "BOOKMENDER, LIBRARY, SR"
		TITLE_CODES["6772"]["program"] = "PSS"
		TITLE_CODES["6772"]["unit"] = "SX"

	TITLE_CODES["6773"] = {}
		TITLE_CODES["6773"]["title"] = "BOOKMENDER, LIBRARY"
		TITLE_CODES["6773"]["program"] = "PSS"
		TITLE_CODES["6773"]["unit"] = "SX"

	TITLE_CODES["6330"] = {}
		TITLE_CODES["6330"]["title"] = "THEATRE PRODUCTION SUPV, SR"
		TITLE_CODES["6330"]["program"] = "PSS"
		TITLE_CODES["6330"]["unit"] = "99"

	TITLE_CODES["3216"] = {}
		TITLE_CODES["3216"]["title"] = "ASSOCIATE RESEARCH---SFT"
		TITLE_CODES["3216"]["program"] = "ACADEMIC"
		TITLE_CODES["3216"]["unit"] = "FX"

	TITLE_CODES["3610"] = {}
		TITLE_CODES["3610"]["title"] = "ASSISTANT UNIVERSITY LIBRARIAN"
		TITLE_CODES["3610"]["program"] = "ACADEMIC"
		TITLE_CODES["3610"]["unit"] = "99"

	TITLE_CODES["3612"] = {}
		TITLE_CODES["3612"]["title"] = "LIBRARIAN - CAREER STATUS"
		TITLE_CODES["3612"]["program"] = "ACADEMIC"
		TITLE_CODES["3612"]["unit"] = "LX"

	TITLE_CODES["3613"] = {}
		TITLE_CODES["3613"]["title"] = "LIBRARIAN-POTNTL CAREER STATUS"
		TITLE_CODES["3613"]["program"] = "ACADEMIC"
		TITLE_CODES["3613"]["unit"] = "LX"

	TITLE_CODES["3614"] = {}
		TITLE_CODES["3614"]["title"] = "LIBRARIAN - TEMPORARY STATUS"
		TITLE_CODES["3614"]["program"] = "ACADEMIC"
		TITLE_CODES["3614"]["unit"] = "LX"

	TITLE_CODES["3615"] = {}
		TITLE_CODES["3615"]["title"] = "VISITING LIBRARIAN - FISCAL YR"
		TITLE_CODES["3615"]["program"] = "ACADEMIC"
		TITLE_CODES["3615"]["unit"] = "99"

	TITLE_CODES["3616"] = {}
		TITLE_CODES["3616"]["title"] = "ASSOC LIBRARIAN -CAREER STATUS"
		TITLE_CODES["3616"]["program"] = "ACADEMIC"
		TITLE_CODES["3616"]["unit"] = "LX"

	TITLE_CODES["3617"] = {}
		TITLE_CODES["3617"]["title"] = "ASOC LIBRARIAN-POTNTL CAREER"
		TITLE_CODES["3617"]["program"] = "ACADEMIC"
		TITLE_CODES["3617"]["unit"] = "LX"

	TITLE_CODES["3618"] = {}
		TITLE_CODES["3618"]["title"] = "ASOC LIBRARIAN-TEMP STATUS"
		TITLE_CODES["3618"]["program"] = "ACADEMIC"
		TITLE_CODES["3618"]["unit"] = "LX"

	TITLE_CODES["1779"] = {}
		TITLE_CODES["1779"]["title"] = "ASSOCIATE PROFESSOR-FY-MEDCOMP"
		TITLE_CODES["1779"]["program"] = "ACADEMIC"
		TITLE_CODES["1779"]["unit"] = "A3"

	TITLE_CODES["2290"] = {}
		TITLE_CODES["2290"]["title"] = "REMEDIAL TUTOR II - NON-GSHIP"
		TITLE_CODES["2290"]["program"] = "ACADEMIC"
		TITLE_CODES["2290"]["unit"] = "BX"

	TITLE_CODES["9241"] = {}
		TITLE_CODES["9241"]["title"] = "PHYSICIST, HOSPITAL RAD, ASST"
		TITLE_CODES["9241"]["program"] = "PSS"
		TITLE_CODES["9241"]["unit"] = "HX"

	TITLE_CODES["9237"] = {}
		TITLE_CODES["9237"]["title"] = "PHLEBOTOMIST, PER DIEM"
		TITLE_CODES["9237"]["program"] = "PSS"
		TITLE_CODES["9237"]["unit"] = "EX"

	TITLE_CODES["9483"] = {}
		TITLE_CODES["9483"]["title"] = "THERAPIST, PHYSICAL II"
		TITLE_CODES["9483"]["program"] = "PSS"
		TITLE_CODES["9483"]["unit"] = "99"

	TITLE_CODES["5131"] = {}
		TITLE_CODES["5131"]["title"] = "FOOD SERVICE WORKER, MC"
		TITLE_CODES["5131"]["program"] = "PSS"
		TITLE_CODES["5131"]["unit"] = "SX"

	TITLE_CODES["259"] = {}
		TITLE_CODES["259"]["title"] = "ASST DIR (FUNCTIONAL AREA)"
		TITLE_CODES["259"]["program"] = "MSP"
		TITLE_CODES["259"]["unit"] = "99"

	TITLE_CODES["7054"] = {}
		TITLE_CODES["7054"]["title"] = "ARCHITECT, LANDSCAPE, ASST"
		TITLE_CODES["7054"]["program"] = "PSS"
		TITLE_CODES["7054"]["unit"] = "99"

	TITLE_CODES["9482"] = {}
		TITLE_CODES["9482"]["title"] = "THERAPIST, PHYSICAL III"
		TITLE_CODES["9482"]["program"] = "PSS"
		TITLE_CODES["9482"]["unit"] = "99"

	TITLE_CODES["250"] = {}
		TITLE_CODES["250"]["title"] = "DEPUTY DIR (FUNCTIONAL AREA)"
		TITLE_CODES["250"]["program"] = "MSP"
		TITLE_CODES["250"]["unit"] = "99"

	TITLE_CODES["256"] = {}
		TITLE_CODES["256"]["title"] = "ASSOC DIR (FUNCTIONAL AREA)"
		TITLE_CODES["256"]["program"] = "MSP"
		TITLE_CODES["256"]["unit"] = "99"

	TITLE_CODES["8125"] = {}
		TITLE_CODES["8125"]["title"] = "SHEETMETAL WORKER, LEAD"
		TITLE_CODES["8125"]["program"] = "PSS"
		TITLE_CODES["8125"]["unit"] = "K3"

	TITLE_CODES["9480"] = {}
		TITLE_CODES["9480"]["title"] = "DIVISION ADMINISTRATOR"
		TITLE_CODES["9480"]["program"] = "PSS"
		TITLE_CODES["9480"]["unit"] = "99"

	TITLE_CODES["9240"] = {}
		TITLE_CODES["9240"]["title"] = "PHYSICIST, HOSPITAL RADIATION"
		TITLE_CODES["9240"]["program"] = "PSS"
		TITLE_CODES["9240"]["unit"] = "HX"

	TITLE_CODES["5130"] = {}
		TITLE_CODES["5130"]["title"] = "FOOD SERVICE WORKER, SR, MC"
		TITLE_CODES["5130"]["program"] = "PSS"
		TITLE_CODES["5130"]["unit"] = "SX"

	TITLE_CODES["9485"] = {}
		TITLE_CODES["9485"]["title"] = "THERAPIST, PHYSICAL, PER DIEM"
		TITLE_CODES["9485"]["program"] = "PSS"
		TITLE_CODES["9485"]["unit"] = "99"

	TITLE_CODES["8139"] = {}
		TITLE_CODES["8139"]["title"] = "ELECTRICIAN, APPRENTICE"
		TITLE_CODES["8139"]["program"] = "PSS"
		TITLE_CODES["8139"]["unit"] = "K3"

	TITLE_CODES["3210"] = {}
		TITLE_CODES["3210"]["title"] = "ASSOC RES ---- - FISCAL YEAR"
		TITLE_CODES["3210"]["program"] = "ACADEMIC"
		TITLE_CODES["3210"]["unit"] = "FX"

	TITLE_CODES["6680"] = {}
		TITLE_CODES["6680"]["title"] = "TRANSLATOR/INTERP FOR THE DEAF"
		TITLE_CODES["6680"]["program"] = "PSS"
		TITLE_CODES["6680"]["unit"] = "TX"

	TITLE_CODES["9484"] = {}
		TITLE_CODES["9484"]["title"] = "THERAPIST, PHYSICAL I"
		TITLE_CODES["9484"]["program"] = "PSS"
		TITLE_CODES["9484"]["unit"] = "99"

	TITLE_CODES["2428"] = {}
		TITLE_CODES["2428"]["title"] = "SUBST.TEACHER-CONTINUING APPT."
		TITLE_CODES["2428"]["program"] = "ACADEMIC"
		TITLE_CODES["2428"]["unit"] = "IX"

	TITLE_CODES["7291"] = {}
		TITLE_CODES["7291"]["title"] = "PROGRAMMER II - SUPV"
		TITLE_CODES["7291"]["program"] = "PSS"
		TITLE_CODES["7291"]["unit"] = "99"

	TITLE_CODES["7292"] = {}
		TITLE_CODES["7292"]["title"] = "PROGRAMMER III - SUPV"
		TITLE_CODES["7292"]["program"] = "PSS"
		TITLE_CODES["7292"]["unit"] = "99"

	TITLE_CODES["7293"] = {}
		TITLE_CODES["7293"]["title"] = "PROGRAMMER IV - SUPV"
		TITLE_CODES["7293"]["program"] = "PSS"
		TITLE_CODES["7293"]["unit"] = "99"

	TITLE_CODES["7294"] = {}
		TITLE_CODES["7294"]["title"] = "PROGRAMMER V - SUPV"
		TITLE_CODES["7294"]["program"] = "PSS"
		TITLE_CODES["7294"]["unit"] = "99"

	TITLE_CODES["7295"] = {}
		TITLE_CODES["7295"]["title"] = "PROGRAMMER VI - SUPV"
		TITLE_CODES["7295"]["program"] = "PSS"
		TITLE_CODES["7295"]["unit"] = "99"

	TITLE_CODES["7296"] = {}
		TITLE_CODES["7296"]["title"] = "PROGRAMMER VII - SUPV"
		TITLE_CODES["7296"]["program"] = "PSS"
		TITLE_CODES["7296"]["unit"] = "99"

	TITLE_CODES["4812"] = {}
		TITLE_CODES["4812"]["title"] = "COMPUTER OPERATOR, SR"
		TITLE_CODES["4812"]["program"] = "PSS"
		TITLE_CODES["4812"]["unit"] = "TX"

	TITLE_CODES["9139"] = {}
		TITLE_CODES["9139"]["title"] = "NURSE, CLINICAL II"
		TITLE_CODES["9139"]["program"] = "PSS"
		TITLE_CODES["9139"]["unit"] = "NX"

	TITLE_CODES["9138"] = {}
		TITLE_CODES["9138"]["title"] = "NURSE, CLINICAL III"
		TITLE_CODES["9138"]["program"] = "PSS"
		TITLE_CODES["9138"]["unit"] = "NX"

	TITLE_CODES["4811"] = {}
		TITLE_CODES["4811"]["title"] = "COMPUTER OPERATIONS SUPVR"
		TITLE_CODES["4811"]["program"] = "PSS"
		TITLE_CODES["4811"]["unit"] = "99"

	TITLE_CODES["2427"] = {}
		TITLE_CODES["2427"]["title"] = "SUBSTITUTE TEACHER"
		TITLE_CODES["2427"]["program"] = "ACADEMIC"
		TITLE_CODES["2427"]["unit"] = "IX"

	TITLE_CODES["9036"] = {}
		TITLE_CODES["9036"]["title"] = "PERFUSIONIST, PRIN"
		TITLE_CODES["9036"]["program"] = "PSS"
		TITLE_CODES["9036"]["unit"] = "EX"

	TITLE_CODES["168"] = {}
		TITLE_CODES["168"]["title"] = "ACTG PROVOST (SCHOOL/COL)-EXEC"
		TITLE_CODES["168"]["program"] = "MSP"
		TITLE_CODES["168"]["unit"] = "99"

	TITLE_CODES["169"] = {}
		TITLE_CODES["169"]["title"] = "CHIEF AMBUL & MGD CARE OFFICER"
		TITLE_CODES["169"]["program"] = "MSP"
		TITLE_CODES["169"]["unit"] = "99"

	TITLE_CODES["164"] = {}
		TITLE_CODES["164"]["title"] = "CHIEF EXEC OFFICER - MED CENTR"
		TITLE_CODES["164"]["program"] = "MSP"
		TITLE_CODES["164"]["unit"] = "99"

	TITLE_CODES["165"] = {}
		TITLE_CODES["165"]["title"] = "CHIEF FINANCIAL OFFICER - MC"
		TITLE_CODES["165"]["program"] = "MSP"
		TITLE_CODES["165"]["unit"] = "99"

	TITLE_CODES["166"] = {}
		TITLE_CODES["166"]["title"] = "CHIEF PATIENT CARE SERV OFFCR"
		TITLE_CODES["166"]["program"] = "MSP"
		TITLE_CODES["166"]["unit"] = "99"

	TITLE_CODES["167"] = {}
		TITLE_CODES["167"]["title"] = "PROVOST (SCHOOL/COLLEGE)-EXEC"
		TITLE_CODES["167"]["program"] = "MSP"
		TITLE_CODES["167"]["unit"] = "99"

	TITLE_CODES["160"] = {}
		TITLE_CODES["160"]["title"] = "DEAN (SCHOOL/COLLEGE)-EXEC"
		TITLE_CODES["160"]["program"] = "MSP"
		TITLE_CODES["160"]["unit"] = "99"

	TITLE_CODES["161"] = {}
		TITLE_CODES["161"]["title"] = "EXECUTIVE DIRECTOR-MED CENTER"
		TITLE_CODES["161"]["program"] = "MSP"
		TITLE_CODES["161"]["unit"] = "99"

	TITLE_CODES["162"] = {}
		TITLE_CODES["162"]["title"] = "CHIEF ADM & PROF SERVS OFFICER"
		TITLE_CODES["162"]["program"] = "MSP"
		TITLE_CODES["162"]["unit"] = "99"

	TITLE_CODES["163"] = {}
		TITLE_CODES["163"]["title"] = "ACTING DEAN (SCHOOL/COL)-EXEC"
		TITLE_CODES["163"]["program"] = "MSP"
		TITLE_CODES["163"]["unit"] = "99"

	TITLE_CODES["4687"] = {}
		TITLE_CODES["4687"]["title"] = "TRANSCRIBER, HOSP MED, SR"
		TITLE_CODES["4687"]["program"] = "PSS"
		TITLE_CODES["4687"]["unit"] = "EX"

	TITLE_CODES["4685"] = {}
		TITLE_CODES["4685"]["title"] = "TRANSCRIBER, HOSP MED, SR, PD"
		TITLE_CODES["4685"]["program"] = "PSS"
		TITLE_CODES["4685"]["unit"] = "EX"

	TITLE_CODES["9228"] = {}
		TITLE_CODES["9228"]["title"] = "OR SUPPORT ASSISTANT"
		TITLE_CODES["9228"]["program"] = "PSS"
		TITLE_CODES["9228"]["unit"] = "EX"

	TITLE_CODES["7701"] = {}
		TITLE_CODES["7701"]["title"] = "WRITER SUPERVISOR"
		TITLE_CODES["7701"]["program"] = "PSS"
		TITLE_CODES["7701"]["unit"] = "99"

	TITLE_CODES["4688"] = {}
		TITLE_CODES["4688"]["title"] = "TRANSCRIBER, HOSP MED"
		TITLE_CODES["4688"]["program"] = "PSS"
		TITLE_CODES["4688"]["unit"] = "EX"

	TITLE_CODES["4689"] = {}
		TITLE_CODES["4689"]["title"] = "TRANSCRIBER, HOSP MED,SR-SUPVR"
		TITLE_CODES["4689"]["program"] = "PSS"
		TITLE_CODES["4689"]["unit"] = "99"

	TITLE_CODES["9352"] = {}
		TITLE_CODES["9352"]["title"] = "CHILD LIFE SPECIALIST II"
		TITLE_CODES["9352"]["program"] = "PSS"
		TITLE_CODES["9352"]["unit"] = "HX"

	TITLE_CODES["6191"] = {}
		TITLE_CODES["6191"]["title"] = "MUSICIAN, PRINCIPAL"
		TITLE_CODES["6191"]["program"] = "PSS"
		TITLE_CODES["6191"]["unit"] = "99"

	TITLE_CODES["6192"] = {}
		TITLE_CODES["6192"]["title"] = "MUSICIAN, SR"
		TITLE_CODES["6192"]["program"] = "PSS"
		TITLE_CODES["6192"]["unit"] = "99"

	TITLE_CODES["4423"] = {}
		TITLE_CODES["4423"]["title"] = "COUNSELOR, LEARN SKILLS PR-SUP"
		TITLE_CODES["4423"]["program"] = "PSS"
		TITLE_CODES["4423"]["unit"] = "99"

	TITLE_CODES["2100"] = {}
		TITLE_CODES["2100"]["title"] = "SUPERVISOR OF PHYS ED-ACAD YR"
		TITLE_CODES["2100"]["program"] = "ACADEMIC"
		TITLE_CODES["2100"]["unit"] = "99"

	TITLE_CODES["2510"] = {}
		TITLE_CODES["2510"]["title"] = "TUTOR - NON-STUDENT"
		TITLE_CODES["2510"]["program"] = "ACADEMIC"
		TITLE_CODES["2510"]["unit"] = "BX"

	TITLE_CODES["2106"] = {}
		TITLE_CODES["2106"]["title"] = "SUPRVSR OF PHYS ED-RECALLED-AY"
		TITLE_CODES["2106"]["program"] = "ACADEMIC"
		TITLE_CODES["2106"]["unit"] = "99"

	TITLE_CODES["9616"] = {}
		TITLE_CODES["9616"]["title"] = "SRA II - SUPERVISOR"
		TITLE_CODES["9616"]["program"] = "PSS"
		TITLE_CODES["9616"]["unit"] = "99"

	TITLE_CODES["2735"] = {}
		TITLE_CODES["2735"]["title"] = "STIPEND-OTHER POST-MD TRAINEE"
		TITLE_CODES["2735"]["program"] = "ACADEMIC"
		TITLE_CODES["2735"]["unit"] = "87"

	TITLE_CODES["5117"] = {}
		TITLE_CODES["5117"]["title"] = "CUSTODIAN"
		TITLE_CODES["5117"]["program"] = "PSS"
		TITLE_CODES["5117"]["unit"] = "SX"

	TITLE_CODES["2737"] = {}
		TITLE_CODES["2737"]["title"] = "_____ POST DDS/NON REPRESENTED"
		TITLE_CODES["2737"]["program"] = "ACADEMIC"
		TITLE_CODES["2737"]["unit"] = "99"

	TITLE_CODES["2730"] = {}
		TITLE_CODES["2730"]["title"] = "RESIDENT-VET MEDICINE/NON-REP"
		TITLE_CODES["2730"]["program"] = "ACADEMIC"
		TITLE_CODES["2730"]["unit"] = "99"

	TITLE_CODES["5110"] = {}
		TITLE_CODES["5110"]["title"] = "CUSTODIAN SUPV, PRIN."
		TITLE_CODES["5110"]["program"] = "PSS"
		TITLE_CODES["5110"]["unit"] = "99"

	TITLE_CODES["2732"] = {}
		TITLE_CODES["2732"]["title"] = "OTH POST-MD TRAIN II-VIII/NONR"
		TITLE_CODES["2732"]["program"] = "ACADEMIC"
		TITLE_CODES["2732"]["unit"] = "99"

	TITLE_CODES["5112"] = {}
		TITLE_CODES["5112"]["title"] = "CUSTODIAN SUPVR"
		TITLE_CODES["5112"]["program"] = "PSS"
		TITLE_CODES["5112"]["unit"] = "99"

	TITLE_CODES["5296"] = {}
		TITLE_CODES["5296"]["title"] = "SECURITY OFFICER, SR-SUPVR, MC"
		TITLE_CODES["5296"]["program"] = "PSS"
		TITLE_CODES["5296"]["unit"] = "99"

	TITLE_CODES["9349"] = {}
		TITLE_CODES["9349"]["title"] = "SUPVNG COMM HEALTH PROG MGR"
		TITLE_CODES["9349"]["program"] = "PSS"
		TITLE_CODES["9349"]["unit"] = "99"

	TITLE_CODES["5294"] = {}
		TITLE_CODES["5294"]["title"] = "SECURITY OFFICER, SENIOR, MC"
		TITLE_CODES["5294"]["program"] = "PSS"
		TITLE_CODES["5294"]["unit"] = "SX"

	TITLE_CODES["2738"] = {}
		TITLE_CODES["2738"]["title"] = "CHIEF RESIDENT PHYS/REP"
		TITLE_CODES["2738"]["program"] = "ACADEMIC"
		TITLE_CODES["2738"]["unit"] = "M3"

	TITLE_CODES["8222"] = {}
		TITLE_CODES["8222"]["title"] = "HVAC CONTROL TECHNICIAN"
		TITLE_CODES["8222"]["program"] = "PSS"
		TITLE_CODES["8222"]["unit"] = "K3"

	TITLE_CODES["9618"] = {}
		TITLE_CODES["9618"]["title"] = "MARINE TECH II-NON EXEMPT"
		TITLE_CODES["9618"]["program"] = "PSS"
		TITLE_CODES["9618"]["unit"] = "RX"

	TITLE_CODES["9619"] = {}
		TITLE_CODES["9619"]["title"] = "MARINE TECH III - NON EXEMPT"
		TITLE_CODES["9619"]["program"] = "PSS"
		TITLE_CODES["9619"]["unit"] = "RX"

	TITLE_CODES["3213"] = {}
		TITLE_CODES["3213"]["title"] = "ASSOCIATE RESEARCH___-ACAD YR"
		TITLE_CODES["3213"]["program"] = "ACADEMIC"
		TITLE_CODES["3213"]["unit"] = "FX"

	TITLE_CODES["5058"] = {}
		TITLE_CODES["5058"]["title"] = "STOREKEEPER, PER DIEM"
		TITLE_CODES["5058"]["program"] = "PSS"
		TITLE_CODES["5058"]["unit"] = "SX"

	TITLE_CODES["5059"] = {}
		TITLE_CODES["5059"]["title"] = "STORES WORKER, PER DIEM"
		TITLE_CODES["5059"]["program"] = "PSS"
		TITLE_CODES["5059"]["unit"] = "SX"

	TITLE_CODES["9180"] = {}
		TITLE_CODES["9180"]["title"] = "RADIOLOGY ASSISTANT II"
		TITLE_CODES["9180"]["program"] = "PSS"
		TITLE_CODES["9180"]["unit"] = "EX"

	TITLE_CODES["8955"] = {}
		TITLE_CODES["8955"]["title"] = "CYTOTECHNOLOGIST"
		TITLE_CODES["8955"]["program"] = "PSS"
		TITLE_CODES["8955"]["unit"] = "HX"

	TITLE_CODES["5054"] = {}
		TITLE_CODES["5054"]["title"] = "ENVIRONMENT SVC MGR II, MC"
		TITLE_CODES["5054"]["program"] = "PSS"
		TITLE_CODES["5054"]["unit"] = "99"

	TITLE_CODES["5055"] = {}
		TITLE_CODES["5055"]["title"] = "ENVIRONMENT SVC MGR 1, MC"
		TITLE_CODES["5055"]["program"] = "PSS"
		TITLE_CODES["5055"]["unit"] = "99"

	TITLE_CODES["5056"] = {}
		TITLE_CODES["5056"]["title"] = "FOOD SERVICE SUPERVISOR II, MC"
		TITLE_CODES["5056"]["program"] = "PSS"
		TITLE_CODES["5056"]["unit"] = "99"

	TITLE_CODES["5057"] = {}
		TITLE_CODES["5057"]["title"] = "STOREKEEPER, SR, PER DIEM"
		TITLE_CODES["5057"]["program"] = "PSS"
		TITLE_CODES["5057"]["unit"] = "SX"

	TITLE_CODES["5050"] = {}
		TITLE_CODES["5050"]["title"] = "FOOD SERVICE MANAGER II, MC"
		TITLE_CODES["5050"]["program"] = "PSS"
		TITLE_CODES["5050"]["unit"] = "99"

	TITLE_CODES["5051"] = {}
		TITLE_CODES["5051"]["title"] = "FOOD SERVICE MANAGER 1, MC"
		TITLE_CODES["5051"]["program"] = "PSS"
		TITLE_CODES["5051"]["unit"] = "99"

	TITLE_CODES["5052"] = {}
		TITLE_CODES["5052"]["title"] = "ENVIRONMENTAL SVC SUPVR II, MC"
		TITLE_CODES["5052"]["program"] = "PSS"
		TITLE_CODES["5052"]["unit"] = "99"

	TITLE_CODES["5053"] = {}
		TITLE_CODES["5053"]["title"] = "ENVIRONMENTAL SVC SUPVR I, MC"
		TITLE_CODES["5053"]["program"] = "PSS"
		TITLE_CODES["5053"]["unit"] = "99"

	TITLE_CODES["1814"] = {}
		TITLE_CODES["1814"]["title"] = "HS CLIN PROF-GENCOMP-A"
		TITLE_CODES["1814"]["program"] = "ACADEMIC"
		TITLE_CODES["1814"]["unit"] = "99"

	TITLE_CODES["7209"] = {}
		TITLE_CODES["7209"]["title"] = "STATISTICIAN, PRIN - SUPVR"
		TITLE_CODES["7209"]["program"] = "PSS"
		TITLE_CODES["7209"]["unit"] = "99"

	TITLE_CODES["7208"] = {}
		TITLE_CODES["7208"]["title"] = "STATISTICIAN, SR - SUPERVISOR"
		TITLE_CODES["7208"]["program"] = "PSS"
		TITLE_CODES["7208"]["unit"] = "99"

	TITLE_CODES["1810"] = {}
		TITLE_CODES["1810"]["title"] = "HS CLIN PROF-FY-GENCOMP"
		TITLE_CODES["1810"]["program"] = "ACADEMIC"
		TITLE_CODES["1810"]["unit"] = "99"

	TITLE_CODES["1811"] = {}
		TITLE_CODES["1811"]["title"] = "HS CLIN INSTRUCTOR-GENCOMP-A"
		TITLE_CODES["1811"]["program"] = "ACADEMIC"
		TITLE_CODES["1811"]["unit"] = "99"

	TITLE_CODES["1812"] = {}
		TITLE_CODES["1812"]["title"] = "HS ASST CLIN PROF-GENCOMP-A"
		TITLE_CODES["1812"]["program"] = "ACADEMIC"
		TITLE_CODES["1812"]["unit"] = "99"

	TITLE_CODES["1813"] = {}
		TITLE_CODES["1813"]["title"] = "HS ASSOC CLIN PROF-GENCOMP-A"
		TITLE_CODES["1813"]["program"] = "ACADEMIC"
		TITLE_CODES["1813"]["unit"] = "99"

	TITLE_CODES["877"] = {}
		TITLE_CODES["877"]["title"] = "ACTING ACADEMIC COORDINATOR"
		TITLE_CODES["877"]["program"] = "ACADEMIC"
		TITLE_CODES["877"]["unit"] = "99"

	TITLE_CODES["1535"] = {}
		TITLE_CODES["1535"]["title"] = "INSTRUCTOR-GENCOMP-A"
		TITLE_CODES["1535"]["program"] = "ACADEMIC"
		TITLE_CODES["1535"]["unit"] = "A3"

	TITLE_CODES["2037"] = {}
		TITLE_CODES["2037"]["title"] = "ASSOC CLINICAL PROFESSOR-VOL"
		TITLE_CODES["2037"]["program"] = "ACADEMIC"
		TITLE_CODES["2037"]["unit"] = "99"

	TITLE_CODES["6223"] = {}
		TITLE_CODES["6223"]["title"] = "PHOTOGRAPHER"
		TITLE_CODES["6223"]["program"] = "PSS"
		TITLE_CODES["6223"]["unit"] = "TX"

	TITLE_CODES["6220"] = {}
		TITLE_CODES["6220"]["title"] = "PHOTOGRAPHER, SR SUPV"
		TITLE_CODES["6220"]["program"] = "PSS"
		TITLE_CODES["6220"]["unit"] = "99"

	TITLE_CODES["3091"] = {}
		TITLE_CODES["3091"]["title"] = "JR---IN THE AES-ACAD YR-1/9TH"
		TITLE_CODES["3091"]["program"] = "ACADEMIC"
		TITLE_CODES["3091"]["unit"] = "FX"

	TITLE_CODES["2033"] = {}
		TITLE_CODES["2033"]["title"] = "ASSO CLIN PROF DEN-FY-PTC GE"
		TITLE_CODES["2033"]["program"] = "ACADEMIC"
		TITLE_CODES["2033"]["unit"] = "99"

	TITLE_CODES["6227"] = {}
		TITLE_CODES["6227"]["title"] = "TECHNICIAN, PHOTOGRAPHIC"
		TITLE_CODES["6227"]["program"] = "PSS"
		TITLE_CODES["6227"]["unit"] = "TX"

	TITLE_CODES["2031"] = {}
		TITLE_CODES["2031"]["title"] = "ASSO CLIN PROF-DENT-50%/+ FY"
		TITLE_CODES["2031"]["program"] = "ACADEMIC"
		TITLE_CODES["2031"]["unit"] = "99"

	TITLE_CODES["2030"] = {}
		TITLE_CODES["2030"]["title"] = "HS ASSOC CLIN PROFESSOR-FY"
		TITLE_CODES["2030"]["program"] = "ACADEMIC"
		TITLE_CODES["2030"]["unit"] = "99"

	TITLE_CODES["1533"] = {}
		TITLE_CODES["1533"]["title"] = "VIS ASST PROFESSOR-GENCOMP-PTC"
		TITLE_CODES["1533"]["program"] = "ACADEMIC"
		TITLE_CODES["1533"]["unit"] = "99"

	TITLE_CODES["1532"] = {}
		TITLE_CODES["1532"]["title"] = "VIS ASSO PROFESSOR-GENCOMP-PTC"
		TITLE_CODES["1532"]["program"] = "ACADEMIC"
		TITLE_CODES["1532"]["unit"] = "99"

	TITLE_CODES["8634"] = {}
		TITLE_CODES["8634"]["title"] = "TECHNICIAN, OFFICE MACHINE, I"
		TITLE_CODES["8634"]["program"] = "PSS"
		TITLE_CODES["8634"]["unit"] = "99"

	TITLE_CODES["8254"] = {}
		TITLE_CODES["8254"]["title"] = "REFRIGERATION MECHANIC, LEAD"
		TITLE_CODES["8254"]["program"] = "PSS"
		TITLE_CODES["8254"]["unit"] = "K3"

	TITLE_CODES["3094"] = {}
		TITLE_CODES["3094"]["title"] = "ACT JR---IN THE AES-ACAD YR"
		TITLE_CODES["3094"]["program"] = "ACADEMIC"
		TITLE_CODES["3094"]["unit"] = "99"

	TITLE_CODES["8633"] = {}
		TITLE_CODES["8633"]["title"] = "TECHNICIAN, OFFICE MACHINE, II"
		TITLE_CODES["8633"]["program"] = "PSS"
		TITLE_CODES["8633"]["unit"] = "99"

	TITLE_CODES["3095"] = {}
		TITLE_CODES["3095"]["title"] = "ACT JR---IN THE AES-AY-1/9TH"
		TITLE_CODES["3095"]["program"] = "ACADEMIC"
		TITLE_CODES["3095"]["unit"] = "99"

	TITLE_CODES["1150"] = {}
		TITLE_CODES["1150"]["title"] = "PROFESSOR - SFT-A"
		TITLE_CODES["1150"]["program"] = "ACADEMIC"
		TITLE_CODES["1150"]["unit"] = "A3"

	TITLE_CODES["9551"] = {}
		TITLE_CODES["9551"]["title"] = "BOTANICAL GAR/ARBORETUM MGR,SR"
		TITLE_CODES["9551"]["program"] = "PSS"
		TITLE_CODES["9551"]["unit"] = "99"

	TITLE_CODES["9049"] = {}
		TITLE_CODES["9049"]["title"] = "THERAPIST, RESPIRATORY, REG, I"
		TITLE_CODES["9049"]["program"] = "PSS"
		TITLE_CODES["9049"]["unit"] = "EX"

	TITLE_CODES["8953"] = {}
		TITLE_CODES["8953"]["title"] = "CYTOTECHNOLOGIST, SUPERVISING"
		TITLE_CODES["8953"]["program"] = "PSS"
		TITLE_CODES["8953"]["unit"] = "99"

	TITLE_CODES["8643"] = {}
		TITLE_CODES["8643"]["title"] = "TECHNICIAN, DEV, II-MED FAC"
		TITLE_CODES["8643"]["program"] = "PSS"
		TITLE_CODES["8643"]["unit"] = "EX"

	TITLE_CODES["7631"] = {}
		TITLE_CODES["7631"]["title"] = "AUDITOR IV - SUPERVISOR"
		TITLE_CODES["7631"]["program"] = "PSS"
		TITLE_CODES["7631"]["unit"] = "99"

	TITLE_CODES["9383"] = {}
		TITLE_CODES["9383"]["title"] = "PSYCHOLOGIST II"
		TITLE_CODES["9383"]["program"] = "PSS"
		TITLE_CODES["9383"]["unit"] = "HX"

	TITLE_CODES["3236"] = {}
		TITLE_CODES["3236"]["title"] = "ASST FIELD PROGRAM SUPERVISOR"
		TITLE_CODES["3236"]["program"] = "ACADEMIC"
		TITLE_CODES["3236"]["unit"] = "FX"

	TITLE_CODES["8226"] = {}
		TITLE_CODES["8226"]["title"] = "VENTILATION MECHANIC"
		TITLE_CODES["8226"]["program"] = "PSS"
		TITLE_CODES["8226"]["unit"] = "K3"

	TITLE_CODES["8146"] = {}
		TITLE_CODES["8146"]["title"] = "FARM MAINT WORKER, SR-SUPVR"
		TITLE_CODES["8146"]["program"] = "PSS"
		TITLE_CODES["8146"]["unit"] = "99"

	TITLE_CODES["9047"] = {}
		TITLE_CODES["9047"]["title"] = "THERAPIST, RESPIRATORY, III"
		TITLE_CODES["9047"]["program"] = "PSS"
		TITLE_CODES["9047"]["unit"] = "99"

	TITLE_CODES["9046"] = {}
		TITLE_CODES["9046"]["title"] = "THERAPIST, RESPIRATORY IV"
		TITLE_CODES["9046"]["program"] = "PSS"
		TITLE_CODES["9046"]["unit"] = "99"

	TITLE_CODES["3237"] = {}
		TITLE_CODES["3237"]["title"] = "FACULTY FELLOW RES. - AY"
		TITLE_CODES["3237"]["program"] = "ACADEMIC"
		TITLE_CODES["3237"]["unit"] = "FX"

	TITLE_CODES["1608"] = {}
		TITLE_CODES["1608"]["title"] = "LECTURER W/SEC EMPL-AY-1/9"
		TITLE_CODES["1608"]["program"] = "ACADEMIC"
		TITLE_CODES["1608"]["unit"] = "A3"

	TITLE_CODES["4951"] = {}
		TITLE_CODES["4951"]["title"] = "WORD PROCESSING SPEC, PRIN"
		TITLE_CODES["4951"]["program"] = "PSS"
		TITLE_CODES["4951"]["unit"] = "CX"

	TITLE_CODES["3540"] = {}
		TITLE_CODES["3540"]["title"] = "PROGRAM COORDINATOR"
		TITLE_CODES["3540"]["program"] = "ACADEMIC"
		TITLE_CODES["3540"]["unit"] = "FX"

	TITLE_CODES["3228"] = {}
		TITLE_CODES["3228"]["title"] = "VST ASST RES ----- -FISCAL YR"
		TITLE_CODES["3228"]["program"] = "ACADEMIC"
		TITLE_CODES["3228"]["unit"] = "99"

	TITLE_CODES["1979"] = {}
		TITLE_CODES["1979"]["title"] = "ACT AST PROF-AY-1/9-B/ECON/ENG"
		TITLE_CODES["1979"]["program"] = "ACADEMIC"
		TITLE_CODES["1979"]["unit"] = "99"

	TITLE_CODES["1978"] = {}
		TITLE_CODES["1978"]["title"] = "ACT AST PROF-FY-BUS/ECON/ENG"
		TITLE_CODES["1978"]["program"] = "ACADEMIC"
		TITLE_CODES["1978"]["unit"] = "99"

	TITLE_CODES["1977"] = {}
		TITLE_CODES["1977"]["title"] = "ACT AST PROF-AY-BUS/ECON/ENG"
		TITLE_CODES["1977"]["program"] = "ACADEMIC"
		TITLE_CODES["1977"]["unit"] = "99"

	TITLE_CODES["1600"] = {}
		TITLE_CODES["1600"]["title"] = "SR LECT PSOE-ACAD YR-PART TIME"
		TITLE_CODES["1600"]["program"] = "ACADEMIC"
		TITLE_CODES["1600"]["unit"] = "IX"

	TITLE_CODES["1603"] = {}
		TITLE_CODES["1603"]["title"] = "SR LECT W/SEC EMPL-ACADEMIC YR"
		TITLE_CODES["1603"]["program"] = "ACADEMIC"
		TITLE_CODES["1603"]["unit"] = "A3"

	TITLE_CODES["1602"] = {}
		TITLE_CODES["1602"]["title"] = "SR LECT-PSOE-AY-1/9-PART TIME"
		TITLE_CODES["1602"]["program"] = "ACADEMIC"
		TITLE_CODES["1602"]["unit"] = "IX"

	TITLE_CODES["1605"] = {}
		TITLE_CODES["1605"]["title"] = "LECT-PSOE-ACAD YR-PART TIME"
		TITLE_CODES["1605"]["program"] = "ACADEMIC"
		TITLE_CODES["1605"]["unit"] = "IX"

	TITLE_CODES["1604"] = {}
		TITLE_CODES["1604"]["title"] = "SR LECT W/SEC EMPL-AY-1/9"
		TITLE_CODES["1604"]["program"] = "ACADEMIC"
		TITLE_CODES["1604"]["unit"] = "A3"

	TITLE_CODES["1607"] = {}
		TITLE_CODES["1607"]["title"] = "LECTURER W/SEC EMPL-ACAD YR"
		TITLE_CODES["1607"]["program"] = "ACADEMIC"
		TITLE_CODES["1607"]["unit"] = "A3"

	TITLE_CODES["1606"] = {}
		TITLE_CODES["1606"]["title"] = "LECT-PSOE-AY-1/9TH-PART TIME"
		TITLE_CODES["1606"]["program"] = "ACADEMIC"
		TITLE_CODES["1606"]["unit"] = "IX"

	TITLE_CODES["8912"] = {}
		TITLE_CODES["8912"]["title"] = "PATIENT ESCORT"
		TITLE_CODES["8912"]["program"] = "PSS"
		TITLE_CODES["8912"]["unit"] = "EX"

	TITLE_CODES["8913"] = {}
		TITLE_CODES["8913"]["title"] = "PRACTITIONER, MENTAL HEALTH,SR"
		TITLE_CODES["8913"]["program"] = "PSS"
		TITLE_CODES["8913"]["unit"] = "EX"

	TITLE_CODES["8911"] = {}
		TITLE_CODES["8911"]["title"] = "PATIENT ESCORT, SR"
		TITLE_CODES["8911"]["program"] = "PSS"
		TITLE_CODES["8911"]["unit"] = "EX"

	TITLE_CODES["8916"] = {}
		TITLE_CODES["8916"]["title"] = "NURSE, VOCATIONAL, SR"
		TITLE_CODES["8916"]["program"] = "PSS"
		TITLE_CODES["8916"]["unit"] = "EX"

	TITLE_CODES["1539"] = {}
		TITLE_CODES["1539"]["title"] = "ASSOCIATE PROFESSOR-GENCOMP-A"
		TITLE_CODES["1539"]["program"] = "ACADEMIC"
		TITLE_CODES["1539"]["unit"] = "A3"

	TITLE_CODES["8914"] = {}
		TITLE_CODES["8914"]["title"] = "PRACTITIONER, MENTAL HEALTH"
		TITLE_CODES["8914"]["program"] = "PSS"
		TITLE_CODES["8914"]["unit"] = "EX"

	TITLE_CODES["8915"] = {}
		TITLE_CODES["8915"]["title"] = "NURSE, VOCATIONAL, SR-SUPVR"
		TITLE_CODES["8915"]["program"] = "PSS"
		TITLE_CODES["8915"]["unit"] = "99"

	TITLE_CODES["803"] = {}
		TITLE_CODES["803"]["title"] = "ASSOCIATE VICE CHANCELLOR"
		TITLE_CODES["803"]["program"] = "ACADEMIC"
		TITLE_CODES["803"]["unit"] = "99"

	TITLE_CODES["802"] = {}
		TITLE_CODES["802"]["title"] = "ASSISTANT VICE CHANCELLOR"
		TITLE_CODES["802"]["program"] = "ACADEMIC"
		TITLE_CODES["802"]["unit"] = "99"

	TITLE_CODES["801"] = {}
		TITLE_CODES["801"]["title"] = "AC ASST TT CHANCELLOR"
		TITLE_CODES["801"]["program"] = "ACADEMIC"
		TITLE_CODES["801"]["unit"] = "99"

	TITLE_CODES["800"] = {}
		TITLE_CODES["800"]["title"] = "AC ASST TT VICE CHANCELLOR"
		TITLE_CODES["800"]["program"] = "ACADEMIC"
		TITLE_CODES["800"]["unit"] = "99"

	TITLE_CODES["806"] = {}
		TITLE_CODES["806"]["title"] = "PROG DIR--SCRIPPS INS OF OCGPY"
		TITLE_CODES["806"]["program"] = "ACADEMIC"
		TITLE_CODES["806"]["unit"] = "99"

	TITLE_CODES["804"] = {}
		TITLE_CODES["804"]["title"] = "ACTING/INTERIM ASSOCIATE VC"
		TITLE_CODES["804"]["program"] = "ACADEMIC"
		TITLE_CODES["804"]["unit"] = "99"

	TITLE_CODES["1788"] = {}
		TITLE_CODES["1788"]["title"] = "ASST ADJUNCT PROF-FY-MEDCOMP"
		TITLE_CODES["1788"]["program"] = "ACADEMIC"
		TITLE_CODES["1788"]["unit"] = "99"

	TITLE_CODES["1789"] = {}
		TITLE_CODES["1789"]["title"] = "ASSOC ADJUNCT PROF-FY-MEDCOMP"
		TITLE_CODES["1789"]["program"] = "ACADEMIC"
		TITLE_CODES["1789"]["unit"] = "99"

	TITLE_CODES["768"] = {}
		TITLE_CODES["768"]["title"] = "SENIOR PHYSICIAN DIPLOMATE"
		TITLE_CODES["768"]["program"] = "MSP"
		TITLE_CODES["768"]["unit"] = "99"

	TITLE_CODES["769"] = {}
		TITLE_CODES["769"]["title"] = "SENIOR PHYSICIAN"
		TITLE_CODES["769"]["program"] = "MSP"
		TITLE_CODES["769"]["unit"] = "99"

	TITLE_CODES["762"] = {}
		TITLE_CODES["762"]["title"] = "ANESTHETIST, NURSE, PRIN"
		TITLE_CODES["762"]["program"] = "MSP"
		TITLE_CODES["762"]["unit"] = "99"

	TITLE_CODES["763"] = {}
		TITLE_CODES["763"]["title"] = "ADMINISTRATIVE NURSE V"
		TITLE_CODES["763"]["program"] = "MSP"
		TITLE_CODES["763"]["unit"] = "99"

	TITLE_CODES["760"] = {}
		TITLE_CODES["760"]["title"] = "CHIEF ENGINEER"
		TITLE_CODES["760"]["program"] = "MSP"
		TITLE_CODES["760"]["unit"] = "99"

	TITLE_CODES["761"] = {}
		TITLE_CODES["761"]["title"] = "RESPIRATORY THERAPIST V"
		TITLE_CODES["761"]["program"] = "MSP"
		TITLE_CODES["761"]["unit"] = "99"

	TITLE_CODES["766"] = {}
		TITLE_CODES["766"]["title"] = "CLINICAL NURSE V"
		TITLE_CODES["766"]["program"] = "MSP"
		TITLE_CODES["766"]["unit"] = "99"

	TITLE_CODES["767"] = {}
		TITLE_CODES["767"]["title"] = "MEDICAL SERVICE DIRECTOR"
		TITLE_CODES["767"]["program"] = "MSP"
		TITLE_CODES["767"]["unit"] = "99"

	TITLE_CODES["764"] = {}
		TITLE_CODES["764"]["title"] = "ADMINISTRATIVE NURSE IV"
		TITLE_CODES["764"]["program"] = "MSP"
		TITLE_CODES["764"]["unit"] = "99"

	TITLE_CODES["765"] = {}
		TITLE_CODES["765"]["title"] = "PHARMACIST SUPERVISOR"
		TITLE_CODES["765"]["program"] = "MSP"
		TITLE_CODES["765"]["unit"] = "99"

	TITLE_CODES["3320"] = {}
		TITLE_CODES["3320"]["title"] = "ASSISTANT SPECIALIST"
		TITLE_CODES["3320"]["program"] = "ACADEMIC"
		TITLE_CODES["3320"]["unit"] = "FX"

	TITLE_CODES["7112"] = {}
		TITLE_CODES["7112"]["title"] = "ENGINEER, TELEVISION, SR"
		TITLE_CODES["7112"]["program"] = "PSS"
		TITLE_CODES["7112"]["unit"] = "99"

	TITLE_CODES["7110"] = {}
		TITLE_CODES["7110"]["title"] = "SR TV ENGINEER - SUPERVISOR"
		TITLE_CODES["7110"]["program"] = "PSS"
		TITLE_CODES["7110"]["unit"] = "99"

	TITLE_CODES["8654"] = {}
		TITLE_CODES["8654"]["title"] = "MECHANICIAN, LAB, HELPER"
		TITLE_CODES["8654"]["program"] = "PSS"
		TITLE_CODES["8654"]["unit"] = "TX"

	TITLE_CODES["3041"] = {}
		TITLE_CODES["3041"]["title"] = "VST--- IN THE AES-BUS/ECON/ENG"
		TITLE_CODES["3041"]["program"] = "ACADEMIC"
		TITLE_CODES["3041"]["unit"] = "99"

	TITLE_CODES["3043"] = {}
		TITLE_CODES["3043"]["title"] = "VST AST---IN THE AES-B/ECON/EN"
		TITLE_CODES["3043"]["program"] = "ACADEMIC"
		TITLE_CODES["3043"]["unit"] = "99"

	TITLE_CODES["3042"] = {}
		TITLE_CODES["3042"]["title"] = "VST ASO---IN AES-BUS/ECON/ENG"
		TITLE_CODES["3042"]["program"] = "ACADEMIC"
		TITLE_CODES["3042"]["unit"] = "99"

	TITLE_CODES["3045"] = {}
		TITLE_CODES["3045"]["title"] = "ACT ASO--IN THE AES-B/ECON/ENG"
		TITLE_CODES["3045"]["program"] = "ACADEMIC"
		TITLE_CODES["3045"]["unit"] = "99"

	TITLE_CODES["3044"] = {}
		TITLE_CODES["3044"]["title"] = "ACT --- IN THE AES-B/ECON/ENG"
		TITLE_CODES["3044"]["program"] = "ACADEMIC"
		TITLE_CODES["3044"]["unit"] = "99"

	TITLE_CODES["3046"] = {}
		TITLE_CODES["3046"]["title"] = "ACT AST--IN THE AES-B/ECON/ENG"
		TITLE_CODES["3046"]["program"] = "ACADEMIC"
		TITLE_CODES["3046"]["unit"] = "99"

	TITLE_CODES["1775"] = {}
		TITLE_CODES["1775"]["title"] = "INSTRUCTOR-FY-MEDCOMP"
		TITLE_CODES["1775"]["program"] = "ACADEMIC"
		TITLE_CODES["1775"]["unit"] = "A3"

	TITLE_CODES["1774"] = {}
		TITLE_CODES["1774"]["title"] = "HS CLIN PROF-MEDCOMP-B"
		TITLE_CODES["1774"]["program"] = "ACADEMIC"
		TITLE_CODES["1774"]["unit"] = "99"

	TITLE_CODES["1777"] = {}
		TITLE_CODES["1777"]["title"] = "ASSISTANT PROFESSOR-FY-MEDCOMP"
		TITLE_CODES["1777"]["program"] = "ACADEMIC"
		TITLE_CODES["1777"]["unit"] = "A3"

	TITLE_CODES["6193"] = {}
		TITLE_CODES["6193"]["title"] = "MUSICIAN"
		TITLE_CODES["6193"]["program"] = "PSS"
		TITLE_CODES["6193"]["unit"] = "99"

	TITLE_CODES["1771"] = {}
		TITLE_CODES["1771"]["title"] = "HS CLIN INSTR-MEDCOMP-B"
		TITLE_CODES["1771"]["program"] = "ACADEMIC"
		TITLE_CODES["1771"]["unit"] = "99"

	TITLE_CODES["1770"] = {}
		TITLE_CODES["1770"]["title"] = "ADJUNCT PROF-MEDCOMP-B"
		TITLE_CODES["1770"]["program"] = "ACADEMIC"
		TITLE_CODES["1770"]["unit"] = "99"

	TITLE_CODES["1773"] = {}
		TITLE_CODES["1773"]["title"] = "HS ASOC CLIN PROF-MEDCOMP-B"
		TITLE_CODES["1773"]["program"] = "ACADEMIC"
		TITLE_CODES["1773"]["unit"] = "99"

	TITLE_CODES["1772"] = {}
		TITLE_CODES["1772"]["title"] = "HS ASST CLIN PROF-MEDCOMP-B"
		TITLE_CODES["1772"]["program"] = "ACADEMIC"
		TITLE_CODES["1772"]["unit"] = "99"

	TITLE_CODES["7052"] = {}
		TITLE_CODES["7052"]["title"] = "ARCHITECT, LANDSCAPE, SR"
		TITLE_CODES["7052"]["program"] = "PSS"
		TITLE_CODES["7052"]["unit"] = "99"

	TITLE_CODES["1077"] = {}
		TITLE_CODES["1077"]["title"] = "ACTING/INTERIM VICE PROVOST"
		TITLE_CODES["1077"]["program"] = "ACADEMIC"
		TITLE_CODES["1077"]["unit"] = "99"

	TITLE_CODES["7050"] = {}
		TITLE_CODES["7050"]["title"] = "LANDSCAPE ARCHITECT SUPERVISOR"
		TITLE_CODES["7050"]["program"] = "PSS"
		TITLE_CODES["7050"]["unit"] = "99"

	TITLE_CODES["1072"] = {}
		TITLE_CODES["1072"]["title"] = "ASSOC DIRECTOR-EAP STUDY CNTR"
		TITLE_CODES["1072"]["program"] = "ACADEMIC"
		TITLE_CODES["1072"]["unit"] = "99"

	TITLE_CODES["1778"] = {}
		TITLE_CODES["1778"]["title"] = "ACT ASST PROFESSOR-FY-MEDCOMP"
		TITLE_CODES["1778"]["program"] = "ACADEMIC"
		TITLE_CODES["1778"]["unit"] = "99"

	TITLE_CODES["1070"] = {}
		TITLE_CODES["1070"]["title"] = "DIRECTOR OF EAP STUDY CENTER"
		TITLE_CODES["1070"]["program"] = "ACADEMIC"
		TITLE_CODES["1070"]["unit"] = "99"

	TITLE_CODES["7634"] = {}
		TITLE_CODES["7634"]["title"] = "ADMIN SPECIALIST II - SUPVR"
		TITLE_CODES["7634"]["program"] = "PSS"
		TITLE_CODES["7634"]["unit"] = "99"

	TITLE_CODES["9287"] = {}
		TITLE_CODES["9287"]["title"] = "COUNSELOR, GENETIC II"
		TITLE_CODES["9287"]["program"] = "PSS"
		TITLE_CODES["9287"]["unit"] = "HX"

	TITLE_CODES["9633"] = {}
		TITLE_CODES["9633"]["title"] = "MUSEUM PREPARATOR, SR"
		TITLE_CODES["9633"]["program"] = "PSS"
		TITLE_CODES["9633"]["unit"] = "TX"

	TITLE_CODES["1675"] = {}
		TITLE_CODES["1675"]["title"] = "LECTURER/SR. LECTURER-WOS-AY"
		TITLE_CODES["1675"]["program"] = "ACADEMIC"
		TITLE_CODES["1675"]["unit"] = "99"

	TITLE_CODES["1676"] = {}
		TITLE_CODES["1676"]["title"] = "LECTURER/SR. LECTURER-WOS-FY"
		TITLE_CODES["1676"]["program"] = "ACADEMIC"
		TITLE_CODES["1676"]["unit"] = "99"

	TITLE_CODES["1094"] = {}
		TITLE_CODES["1094"]["title"] = "DEPARTMENT VICE CHAIRPERSON"
		TITLE_CODES["1094"]["program"] = "ACADEMIC"
		TITLE_CODES["1094"]["unit"] = "99"

	TITLE_CODES["1095"] = {}
		TITLE_CODES["1095"]["title"] = "ACTING DEPARTMENT CHAIRPERSON"
		TITLE_CODES["1095"]["program"] = "ACADEMIC"
		TITLE_CODES["1095"]["unit"] = "99"

	TITLE_CODES["1096"] = {}
		TITLE_CODES["1096"]["title"] = "DEPARTMENT CHAIRPERSON"
		TITLE_CODES["1096"]["program"] = "ACADEMIC"
		TITLE_CODES["1096"]["unit"] = "99"

	TITLE_CODES["8224"] = {}
		TITLE_CODES["8224"]["title"] = "ROOFER, APPRENTICE"
		TITLE_CODES["8224"]["program"] = "PSS"
		TITLE_CODES["8224"]["unit"] = "K3"

	TITLE_CODES["8225"] = {}
		TITLE_CODES["8225"]["title"] = "VENTILATION MECH, APPRENTICE"
		TITLE_CODES["8225"]["program"] = "PSS"
		TITLE_CODES["8225"]["unit"] = "K3"

	TITLE_CODES["1092"] = {}
		TITLE_CODES["1092"]["title"] = "STIPEND-RESIDENT"
		TITLE_CODES["1092"]["program"] = "ACADEMIC"
		TITLE_CODES["1092"]["unit"] = "87"

	TITLE_CODES["8227"] = {}
		TITLE_CODES["8227"]["title"] = "REFRIGERATION MECHANIC"
		TITLE_CODES["8227"]["program"] = "PSS"
		TITLE_CODES["8227"]["unit"] = "K3"

	TITLE_CODES["9617"] = {}
		TITLE_CODES["9617"]["title"] = "STAFF RES ASSOC II-NONEXEMPT"
		TITLE_CODES["9617"]["program"] = "PSS"
		TITLE_CODES["9617"]["unit"] = "RX"

	TITLE_CODES["3393"] = {}
		TITLE_CODES["3393"]["title"] = "ASOC PROJECT____-FY-B/ECON/ENG"
		TITLE_CODES["3393"]["program"] = "ACADEMIC"
		TITLE_CODES["3393"]["unit"] = "FX"

	TITLE_CODES["8142"] = {}
		TITLE_CODES["8142"]["title"] = "MACHINIST LEADWORKER"
		TITLE_CODES["8142"]["program"] = "PSS"
		TITLE_CODES["8142"]["unit"] = "K3"

	TITLE_CODES["1098"] = {}
		TITLE_CODES["1098"]["title"] = "SUMMER DIFFERENTIAL"
		TITLE_CODES["1098"]["program"] = "ACADEMIC"
		TITLE_CODES["1098"]["unit"] = "87"

	TITLE_CODES["1099"] = {}
		TITLE_CODES["1099"]["title"] = "ADMINISTRATIVE STIPEND"
		TITLE_CODES["1099"]["program"] = "ACADEMIC"
		TITLE_CODES["1099"]["unit"] = "87"

	TITLE_CODES["3800"] = {}
		TITLE_CODES["3800"]["title"] = " --- EMERITUS(WOS)"
		TITLE_CODES["3800"]["program"] = "ACADEMIC"
		TITLE_CODES["3800"]["unit"] = "99"

	TITLE_CODES["3137"] = {}
		TITLE_CODES["3137"]["title"] = "ACTING JUNIOR ASTRONOMER"
		TITLE_CODES["3137"]["program"] = "ACADEMIC"
		TITLE_CODES["3137"]["unit"] = "99"

	TITLE_CODES["3130"] = {}
		TITLE_CODES["3130"]["title"] = "JUNIOR ASTRONOMER"
		TITLE_CODES["3130"]["program"] = "ACADEMIC"
		TITLE_CODES["3130"]["unit"] = "FX"

	TITLE_CODES["9634"] = {}
		TITLE_CODES["9634"]["title"] = "MUSEUM PREPARATOR"
		TITLE_CODES["9634"]["program"] = "PSS"
		TITLE_CODES["9634"]["unit"] = "TX"

	TITLE_CODES["9954"] = {}
		TITLE_CODES["9954"]["title"] = "INTERN, PSYCHOLOGY"
		TITLE_CODES["9954"]["program"] = "PSS"
		TITLE_CODES["9954"]["unit"] = "99"

	TITLE_CODES["9021"] = {}
		TITLE_CODES["9021"]["title"] = "TECHNOLOGIST,RADIOLOGIC,PRIN"
		TITLE_CODES["9021"]["program"] = "PSS"
		TITLE_CODES["9021"]["unit"] = "EX"

	TITLE_CODES["3039"] = {}
		TITLE_CODES["3039"]["title"] = "ACT JR --- IN THE A.E.S.SFT-VM"
		TITLE_CODES["3039"]["program"] = "ACADEMIC"
		TITLE_CODES["3039"]["unit"] = "FX"

	TITLE_CODES["1550"] = {}
		TITLE_CODES["1550"]["title"] = "LECTURER IN SUMMER SESSION"
		TITLE_CODES["1550"]["program"] = "ACADEMIC"
		TITLE_CODES["1550"]["unit"] = "IX"

	TITLE_CODES["58"] = {}
		TITLE_CODES["58"]["title"] = "ASST SECY OF THE REGENTS"
		TITLE_CODES["58"]["program"] = "MSP"
		TITLE_CODES["58"]["unit"] = "99"

	TITLE_CODES["55"] = {}
		TITLE_CODES["55"]["title"] = "SECRETARY OF THE REGENTS"
		TITLE_CODES["55"]["program"] = "MSP"
		TITLE_CODES["55"]["unit"] = "99"

	TITLE_CODES["57"] = {}
		TITLE_CODES["57"]["title"] = "ASSOC SECY OF THE REGENTS"
		TITLE_CODES["57"]["program"] = "MSP"
		TITLE_CODES["57"]["unit"] = "99"

	TITLE_CODES["3037"] = {}
		TITLE_CODES["3037"]["title"] = "ACT JR ----- IN THE A.E.S."
		TITLE_CODES["3037"]["program"] = "ACADEMIC"
		TITLE_CODES["3037"]["unit"] = "99"

	TITLE_CODES["3030"] = {}
		TITLE_CODES["3030"]["title"] = "JR ----- IN THE A.E.S."
		TITLE_CODES["3030"]["program"] = "ACADEMIC"
		TITLE_CODES["3030"]["unit"] = "FX"

	TITLE_CODES["50"] = {}
		TITLE_CODES["50"]["title"] = "ASSOC VP--ACADEMIC AFFAIRS"
		TITLE_CODES["50"]["program"] = "MSP"
		TITLE_CODES["50"]["unit"] = "99"

	TITLE_CODES["9899"] = {}
		TITLE_CODES["9899"]["title"] = "ADMINISTRATIVE STIPEND-EXEMPT"
		TITLE_CODES["9899"]["program"] = "PSS"
		TITLE_CODES["9899"]["unit"] = "99"

	TITLE_CODES["3034"] = {}
		TITLE_CODES["3034"]["title"] = "JR SPECIALIST IN THE A.E.S."
		TITLE_CODES["3034"]["program"] = "ACADEMIC"
		TITLE_CODES["3034"]["unit"] = "FX"

	TITLE_CODES["5129"] = {}
		TITLE_CODES["5129"]["title"] = "FOOD SERVICE WORKER, PRIN, MC"
		TITLE_CODES["5129"]["program"] = "PSS"
		TITLE_CODES["5129"]["unit"] = "SX"

	TITLE_CODES["4102"] = {}
		TITLE_CODES["4102"]["title"] = "CHILD DEVELOPMENT CENTER MGR"
		TITLE_CODES["4102"]["program"] = "PSS"
		TITLE_CODES["4102"]["unit"] = "99"

	TITLE_CODES["8929"] = {}
		TITLE_CODES["8929"]["title"] = "TECHNICIAN, ORTHOPEDIC"
		TITLE_CODES["8929"]["program"] = "PSS"
		TITLE_CODES["8929"]["unit"] = "EX"

	TITLE_CODES["9020"] = {}
		TITLE_CODES["9020"]["title"] = "TECHNOLOGIST,RAD,ASSOC CHIEF"
		TITLE_CODES["9020"]["program"] = "PSS"
		TITLE_CODES["9020"]["unit"] = "99"

	TITLE_CODES["1410"] = {}
		TITLE_CODES["1410"]["title"] = "INSTRUCTOR - FISCAL YEAR"
		TITLE_CODES["1410"]["program"] = "ACADEMIC"
		TITLE_CODES["1410"]["unit"] = "A3"

	TITLE_CODES["8928"] = {}
		TITLE_CODES["8928"]["title"] = "TECHNICIAN, ORTHOPEDIC, SR"
		TITLE_CODES["8928"]["program"] = "PSS"
		TITLE_CODES["8928"]["unit"] = "EX"

	TITLE_CODES["8035"] = {}
		TITLE_CODES["8035"]["title"] = "THERAPIST, PHYSICAL IV-SUPVR"
		TITLE_CODES["8035"]["program"] = "PSS"
		TITLE_CODES["8035"]["unit"] = "99"

	TITLE_CODES["8034"] = {}
		TITLE_CODES["8034"]["title"] = "THERAPIST, PHYSICAL III-SUPVR"
		TITLE_CODES["8034"]["program"] = "PSS"
		TITLE_CODES["8034"]["unit"] = "99"

	TITLE_CODES["8031"] = {}
		TITLE_CODES["8031"]["title"] = "AUDIOLOGIST, SR-SUPVR"
		TITLE_CODES["8031"]["program"] = "PSS"
		TITLE_CODES["8031"]["unit"] = "99"

	TITLE_CODES["8039"] = {}
		TITLE_CODES["8039"]["title"] = "THERAPIST, OCCUPA IV-SUPVR"
		TITLE_CODES["8039"]["program"] = "PSS"
		TITLE_CODES["8039"]["unit"] = "99"

	TITLE_CODES["8038"] = {}
		TITLE_CODES["8038"]["title"] = "THERAPIST, OCCUPA III-SUPVR"
		TITLE_CODES["8038"]["program"] = "PSS"
		TITLE_CODES["8038"]["unit"] = "99"

	TITLE_CODES["3031"] = {}
		TITLE_CODES["3031"]["title"] = "JR ----- IN THE A.E.S.- SFT-VM"
		TITLE_CODES["3031"]["program"] = "ACADEMIC"
		TITLE_CODES["3031"]["unit"] = "FX"

	TITLE_CODES["6451"] = {}
		TITLE_CODES["6451"]["title"] = "PROGRAM REPRESENTATIVE I - SUP"
		TITLE_CODES["6451"]["program"] = "PSS"
		TITLE_CODES["6451"]["unit"] = "99"

	TITLE_CODES["3294"] = {}
		TITLE_CODES["3294"]["title"] = "ASST RES PROF-MILLER INST- AY"
		TITLE_CODES["3294"]["program"] = "ACADEMIC"
		TITLE_CODES["3294"]["unit"] = "99"

	TITLE_CODES["6453"] = {}
		TITLE_CODES["6453"]["title"] = "PROGRAM REPRESENTATIVE II"
		TITLE_CODES["6453"]["program"] = "PSS"
		TITLE_CODES["6453"]["unit"] = "99"

	TITLE_CODES["6452"] = {}
		TITLE_CODES["6452"]["title"] = "PROGRAM REPRESENTATIVE III"
		TITLE_CODES["6452"]["program"] = "PSS"
		TITLE_CODES["6452"]["unit"] = "99"

	TITLE_CODES["8138"] = {}
		TITLE_CODES["8138"]["title"] = "ELECTRICIAN"
		TITLE_CODES["8138"]["program"] = "PSS"
		TITLE_CODES["8138"]["unit"] = "K3"

	TITLE_CODES["6454"] = {}
		TITLE_CODES["6454"]["title"] = "PROGRAM REPRESENTATIVE I"
		TITLE_CODES["6454"]["program"] = "PSS"
		TITLE_CODES["6454"]["unit"] = "99"

	TITLE_CODES["6901"] = {}
		TITLE_CODES["6901"]["title"] = "ARCHITECT ASSOCIATE SUPERVISOR"
		TITLE_CODES["6901"]["program"] = "PSS"
		TITLE_CODES["6901"]["unit"] = "99"

	TITLE_CODES["3295"] = {}
		TITLE_CODES["3295"]["title"] = "ASST RES PROF-MILLER INST- FY"
		TITLE_CODES["3295"]["program"] = "ACADEMIC"
		TITLE_CODES["3295"]["unit"] = "99"

	TITLE_CODES["8134"] = {}
		TITLE_CODES["8134"]["title"] = "GROUNDS EQUIPMENT OPERATOR"
		TITLE_CODES["8134"]["program"] = "PSS"
		TITLE_CODES["8134"]["unit"] = "SX"

	TITLE_CODES["8522"] = {}
		TITLE_CODES["8522"]["title"] = "MECHANIC, FARM MACHINERY, SR"
		TITLE_CODES["8522"]["program"] = "PSS"
		TITLE_CODES["8522"]["unit"] = "SX"

	TITLE_CODES["8521"] = {}
		TITLE_CODES["8521"]["title"] = "MECHANIC,FARM MACHINERY,SR-SUP"
		TITLE_CODES["8521"]["program"] = "PSS"
		TITLE_CODES["8521"]["unit"] = "99"

	TITLE_CODES["8137"] = {}
		TITLE_CODES["8137"]["title"] = "ELECTRICIAN, LEAD"
		TITLE_CODES["8137"]["program"] = "PSS"
		TITLE_CODES["8137"]["unit"] = "K3"

	TITLE_CODES["8130"] = {}
		TITLE_CODES["8130"]["title"] = "GROUNDS SUPVR, SR"
		TITLE_CODES["8130"]["program"] = "PSS"
		TITLE_CODES["8130"]["unit"] = "99"

	TITLE_CODES["3296"] = {}
		TITLE_CODES["3296"]["title"] = "RESEARCH FELLOW (W/O SALARY)"
		TITLE_CODES["3296"]["program"] = "ACADEMIC"
		TITLE_CODES["3296"]["unit"] = "99"

	TITLE_CODES["8132"] = {}
		TITLE_CODES["8132"]["title"] = "GROUNDSKEEPER, LEAD"
		TITLE_CODES["8132"]["program"] = "PSS"
		TITLE_CODES["8132"]["unit"] = "SX"

	TITLE_CODES["8133"] = {}
		TITLE_CODES["8133"]["title"] = "GROUNDSKEEPER"
		TITLE_CODES["8133"]["program"] = "PSS"
		TITLE_CODES["8133"]["unit"] = "SX"

	TITLE_CODES["3297"] = {}
		TITLE_CODES["3297"]["title"] = "CHI GREEN SCHOLAR - SAN DIEGO"
		TITLE_CODES["3297"]["program"] = "ACADEMIC"
		TITLE_CODES["3297"]["unit"] = "99"

	TITLE_CODES["9248"] = {}
		TITLE_CODES["9248"]["title"] = "PHARMACIST, STAFF I"
		TITLE_CODES["9248"]["program"] = "PSS"
		TITLE_CODES["9248"]["unit"] = "HX"

	TITLE_CODES["3290"] = {}
		TITLE_CODES["3290"]["title"] = "RES PROF-MILLER INST -ACAD YR"
		TITLE_CODES["3290"]["program"] = "ACADEMIC"
		TITLE_CODES["3290"]["unit"] = "99"

	TITLE_CODES["9721"] = {}
		TITLE_CODES["9721"]["title"] = "SCIENTIST, MUSEUM, PRIN"
		TITLE_CODES["9721"]["program"] = "PSS"
		TITLE_CODES["9721"]["unit"] = "99"

	TITLE_CODES["3291"] = {}
		TITLE_CODES["3291"]["title"] = "RES PROF-MILLER INST-FISCAL YR"
		TITLE_CODES["3291"]["program"] = "ACADEMIC"
		TITLE_CODES["3291"]["unit"] = "99"

	TITLE_CODES["3621"] = {}
		TITLE_CODES["3621"]["title"] = "ASST LIBRARIAN-POTNTL CAREER"
		TITLE_CODES["3621"]["program"] = "ACADEMIC"
		TITLE_CODES["3621"]["unit"] = "LX"

	TITLE_CODES["9022"] = {}
		TITLE_CODES["9022"]["title"] = "TECHNOLOGIST, RADIOLOGIC, SR"
		TITLE_CODES["9022"]["program"] = "PSS"
		TITLE_CODES["9022"]["unit"] = "EX"

	TITLE_CODES["3292"] = {}
		TITLE_CODES["3292"]["title"] = "ASOC RES PROF-MILLER INST- AY"
		TITLE_CODES["3292"]["program"] = "ACADEMIC"
		TITLE_CODES["3292"]["unit"] = "99"

	TITLE_CODES["9177"] = {}
		TITLE_CODES["9177"]["title"] = "PHYSICIAN, EXAMINING"
		TITLE_CODES["9177"]["program"] = "PSS"
		TITLE_CODES["9177"]["unit"] = "99"

	TITLE_CODES["3293"] = {}
		TITLE_CODES["3293"]["title"] = "ASOC RES PROF-MILLER INST- FY"
		TITLE_CODES["3293"]["program"] = "ACADEMIC"
		TITLE_CODES["3293"]["unit"] = "99"

	TITLE_CODES["425"] = {}
		TITLE_CODES["425"]["title"] = "EX ASST/SP ASST/ASST(FLT AREA)"
		TITLE_CODES["425"]["program"] = "MSP"
		TITLE_CODES["425"]["unit"] = "99"

	TITLE_CODES["426"] = {}
		TITLE_CODES["426"]["title"] = "CAMPUS COUNSEL"
		TITLE_CODES["426"]["program"] = "MSP"
		TITLE_CODES["426"]["unit"] = "99"

	TITLE_CODES["8966"] = {}
		TITLE_CODES["8966"]["title"] = "TECHNOLOGIST, ULTRASOUND, SR"
		TITLE_CODES["8966"]["program"] = "PSS"
		TITLE_CODES["8966"]["unit"] = "EX"

	TITLE_CODES["9282"] = {}
		TITLE_CODES["9282"]["title"] = "PHARMACY TECHNICIAN II"
		TITLE_CODES["9282"]["program"] = "PSS"
		TITLE_CODES["9282"]["unit"] = "EX"

	TITLE_CODES["9605"] = {}
		TITLE_CODES["9605"]["title"] = "LABORATORY ASST I"
		TITLE_CODES["9605"]["program"] = "PSS"
		TITLE_CODES["9605"]["unit"] = "TX"

	TITLE_CODES["7163"] = {}
		TITLE_CODES["7163"]["title"] = "ENGINEERING AID"
		TITLE_CODES["7163"]["program"] = "PSS"
		TITLE_CODES["7163"]["unit"] = "TX"

	TITLE_CODES["4115"] = {}
		TITLE_CODES["4115"]["title"] = "PLACEMENT INTERVIEWER SUPV"
		TITLE_CODES["4115"]["program"] = "PSS"
		TITLE_CODES["4115"]["unit"] = "99"

	TITLE_CODES["8453"] = {}
		TITLE_CODES["8453"]["title"] = "AIRPORT SERVICES WORKER"
		TITLE_CODES["8453"]["program"] = "PSS"
		TITLE_CODES["8453"]["unit"] = "SX"

	TITLE_CODES["8452"] = {}
		TITLE_CODES["8452"]["title"] = "AIRPORT SERVICES SUPVR"
		TITLE_CODES["8452"]["program"] = "PSS"
		TITLE_CODES["8452"]["unit"] = "99"

	TITLE_CODES["9500"] = {}
		TITLE_CODES["9500"]["title"] = "THERAPIST, OCCUPA, PER DIEM"
		TITLE_CODES["9500"]["program"] = "PSS"
		TITLE_CODES["9500"]["unit"] = "HX"

	TITLE_CODES["4119"] = {}
		TITLE_CODES["4119"]["title"] = "RESIDENT ADVISOR, SR - SUPERV"
		TITLE_CODES["4119"]["program"] = "PSS"
		TITLE_CODES["4119"]["unit"] = "99"

	TITLE_CODES["7668"] = {}
		TITLE_CODES["7668"]["title"] = "PARALEGAL SPECIALIST SUPV"
		TITLE_CODES["7668"]["program"] = "PSS"
		TITLE_CODES["7668"]["unit"] = "99"

	TITLE_CODES["8949"] = {}
		TITLE_CODES["8949"]["title"] = "CERT OCCUP THERAPY ASST I"
		TITLE_CODES["8949"]["program"] = "PSS"
		TITLE_CODES["8949"]["unit"] = "EX"

	TITLE_CODES["7425"] = {}
		TITLE_CODES["7425"]["title"] = "RESIDENCE HALLS MANAGER, ASST"
		TITLE_CODES["7425"]["program"] = "PSS"
		TITLE_CODES["7425"]["unit"] = "99"

	TITLE_CODES["7424"] = {}
		TITLE_CODES["7424"]["title"] = "RESIDENCE HALLS MANAGER"
		TITLE_CODES["7424"]["program"] = "PSS"
		TITLE_CODES["7424"]["unit"] = "99"

	TITLE_CODES["8632"] = {}
		TITLE_CODES["8632"]["title"] = "TECHNICIAN, OFFICE MACHINE,III"
		TITLE_CODES["8632"]["program"] = "PSS"
		TITLE_CODES["8632"]["unit"] = "99"

	TITLE_CODES["8948"] = {}
		TITLE_CODES["8948"]["title"] = "CERT OCCUP THERAPY ASST II"
		TITLE_CODES["8948"]["program"] = "PSS"
		TITLE_CODES["8948"]["unit"] = "EX"

	TITLE_CODES["7540"] = {}
		TITLE_CODES["7540"]["title"] = "ASSISTANT TO THE ____ II"
		TITLE_CODES["7540"]["program"] = "PSS"
		TITLE_CODES["7540"]["unit"] = "99"

	TITLE_CODES["7541"] = {}
		TITLE_CODES["7541"]["title"] = "ASSISTANT TO THE ____ I"
		TITLE_CODES["7541"]["program"] = "PSS"
		TITLE_CODES["7541"]["unit"] = "99"

	TITLE_CODES["9224"] = {}
		TITLE_CODES["9224"]["title"] = "COORDINATOR,MED OFF SRVC,PDIII"
		TITLE_CODES["9224"]["program"] = "PSS"
		TITLE_CODES["9224"]["unit"] = "EX"

	TITLE_CODES["8641"] = {}
		TITLE_CODES["8641"]["title"] = "TECHNICIAN, DEV, IV-MED FAC"
		TITLE_CODES["8641"]["program"] = "PSS"
		TITLE_CODES["8641"]["unit"] = "EX"

	TITLE_CODES["3353"] = {}
		TITLE_CODES["3353"]["title"] = "PROF IN RSDNC-ACAD YR-1/9TH"
		TITLE_CODES["3353"]["program"] = "ACADEMIC"
		TITLE_CODES["3353"]["unit"] = "A3"

	TITLE_CODES["3352"] = {}
		TITLE_CODES["3352"]["title"] = "ASSOC PROF IN RSDNC-AY-1/9TH"
		TITLE_CODES["3352"]["program"] = "ACADEMIC"
		TITLE_CODES["3352"]["unit"] = "A3"

	TITLE_CODES["9261"] = {}
		TITLE_CODES["9261"]["title"] = "MEDICAL REC ADMINISTRATOR,PRIN"
		TITLE_CODES["9261"]["program"] = "PSS"
		TITLE_CODES["9261"]["unit"] = "99"

	TITLE_CODES["9174"] = {}
		TITLE_CODES["9174"]["title"] = "PULMONARY TECHNICIAN II"
		TITLE_CODES["9174"]["program"] = "PSS"
		TITLE_CODES["9174"]["unit"] = "EX"

	TITLE_CODES["7263"] = {}
		TITLE_CODES["7263"]["title"] = "ANALYST, PUBLIC ADMINISTRATION"
		TITLE_CODES["7263"]["program"] = "PSS"
		TITLE_CODES["7263"]["unit"] = "99"

	TITLE_CODES["9116"] = {}
		TITLE_CODES["9116"]["title"] = "HOME HEALTH NURSE III"
		TITLE_CODES["9116"]["program"] = "PSS"
		TITLE_CODES["9116"]["unit"] = "NX"

	TITLE_CODES["9473"] = {}
		TITLE_CODES["9473"]["title"] = "PATHOLOGIST, SPEECH"
		TITLE_CODES["9473"]["program"] = "PSS"
		TITLE_CODES["9473"]["unit"] = "HX"

	TITLE_CODES["6767"] = {}
		TITLE_CODES["6767"]["title"] = "LIBRARY ASST II-SUPVR"
		TITLE_CODES["6767"]["program"] = "PSS"
		TITLE_CODES["6767"]["unit"] = "99"

	TITLE_CODES["6766"] = {}
		TITLE_CODES["6766"]["title"] = "LIBRARY ASST III-SUPVR"
		TITLE_CODES["6766"]["program"] = "PSS"
		TITLE_CODES["6766"]["unit"] = "99"

	TITLE_CODES["6765"] = {}
		TITLE_CODES["6765"]["title"] = "LIBRARY ASST IV-SUPVR"
		TITLE_CODES["6765"]["program"] = "PSS"
		TITLE_CODES["6765"]["unit"] = "99"

	TITLE_CODES["8258"] = {}
		TITLE_CODES["8258"]["title"] = "PLUMBER"
		TITLE_CODES["8258"]["program"] = "PSS"
		TITLE_CODES["8258"]["unit"] = "K3"

	TITLE_CODES["6762"] = {}
		TITLE_CODES["6762"]["title"] = "LIBRARY ASST I"
		TITLE_CODES["6762"]["program"] = "PSS"
		TITLE_CODES["6762"]["unit"] = "CX"

	TITLE_CODES["6761"] = {}
		TITLE_CODES["6761"]["title"] = "LIBRARY ASST II"
		TITLE_CODES["6761"]["program"] = "PSS"
		TITLE_CODES["6761"]["unit"] = "CX"

	TITLE_CODES["6760"] = {}
		TITLE_CODES["6760"]["title"] = "LIBRARY ASST III"
		TITLE_CODES["6760"]["program"] = "PSS"
		TITLE_CODES["6760"]["unit"] = "CX"

	TITLE_CODES["7667"] = {}
		TITLE_CODES["7667"]["title"] = "SPECIALIST, PARALEGAL"
		TITLE_CODES["7667"]["program"] = "PSS"
		TITLE_CODES["7667"]["unit"] = "99"

	TITLE_CODES["9537"] = {}
		TITLE_CODES["9537"]["title"] = "TECHNICIAN, ANIMAL HEALTH I"
		TITLE_CODES["9537"]["program"] = "PSS"
		TITLE_CODES["9537"]["unit"] = "TX"

	TITLE_CODES["5864"] = {}
		TITLE_CODES["5864"]["title"] = "DRAPERY MAKER"
		TITLE_CODES["5864"]["program"] = "PSS"
		TITLE_CODES["5864"]["unit"] = "SX"

	TITLE_CODES["9269"] = {}
		TITLE_CODES["9269"]["title"] = "MEDICAL RECORD ADMSTR-SUPVR"
		TITLE_CODES["9269"]["program"] = "PSS"
		TITLE_CODES["9269"]["unit"] = "99"

	TITLE_CODES["9258"] = {}
		TITLE_CODES["9258"]["title"] = "HOSPITAL UNIT SERV COORD II"
		TITLE_CODES["9258"]["program"] = "PSS"
		TITLE_CODES["9258"]["unit"] = "EX"

	TITLE_CODES["3600"] = {}
		TITLE_CODES["3600"]["title"] = "ASSOCIATE UNIVERSITY LIBRARIAN"
		TITLE_CODES["3600"]["program"] = "ACADEMIC"
		TITLE_CODES["3600"]["unit"] = "99"

	TITLE_CODES["6954"] = {}
		TITLE_CODES["6954"]["title"] = "ARCHITECT, ASSOC"
		TITLE_CODES["6954"]["program"] = "PSS"
		TITLE_CODES["6954"]["unit"] = "99"

	TITLE_CODES["9353"] = {}
		TITLE_CODES["9353"]["title"] = "CHILD LIFE SPECIALIST I"
		TITLE_CODES["9353"]["program"] = "PSS"
		TITLE_CODES["9353"]["unit"] = "HX"

	TITLE_CODES["9259"] = {}
		TITLE_CODES["9259"]["title"] = "HOSPITAL UNIT SERV COORD I"
		TITLE_CODES["9259"]["program"] = "PSS"
		TITLE_CODES["9259"]["unit"] = "EX"

	TITLE_CODES["9498"] = {}
		TITLE_CODES["9498"]["title"] = "THERAPIST, OCCUPATIONAL II"
		TITLE_CODES["9498"]["program"] = "PSS"
		TITLE_CODES["9498"]["unit"] = "HX"

	TITLE_CODES["9032"] = {}
		TITLE_CODES["9032"]["title"] = "ADMITTING WORKER, SR"
		TITLE_CODES["9032"]["program"] = "PSS"
		TITLE_CODES["9032"]["unit"] = "EX"

	TITLE_CODES["8682"] = {}
		TITLE_CODES["8682"]["title"] = "TECHNICIAN, ELEC, SR-MED FAC"
		TITLE_CODES["8682"]["program"] = "PSS"
		TITLE_CODES["8682"]["unit"] = "EX"

	TITLE_CODES["2211"] = {}
		TITLE_CODES["2211"]["title"] = "DEMONSTRATION TEACH-CONTINUING"
		TITLE_CODES["2211"]["program"] = "ACADEMIC"
		TITLE_CODES["2211"]["unit"] = "IX"

	TITLE_CODES["2210"] = {}
		TITLE_CODES["2210"]["title"] = "DEMONSTRATION TEACHER"
		TITLE_CODES["2210"]["program"] = "ACADEMIC"
		TITLE_CODES["2210"]["unit"] = "IX"

	TITLE_CODES["6119"] = {}
		TITLE_CODES["6119"]["title"] = "AV & PHOTO SERVICES SUPVR"
		TITLE_CODES["6119"]["program"] = "PSS"
		TITLE_CODES["6119"]["unit"] = "99"

	TITLE_CODES["6450"] = {}
		TITLE_CODES["6450"]["title"] = "PROGRAM REPRESENTATIVE SUPV"
		TITLE_CODES["6450"]["program"] = "PSS"
		TITLE_CODES["6450"]["unit"] = "99"

	TITLE_CODES["6114"] = {}
		TITLE_CODES["6114"]["title"] = "ILLUSTRATOR, ASST"
		TITLE_CODES["6114"]["program"] = "PSS"
		TITLE_CODES["6114"]["unit"] = "TX"

	TITLE_CODES["7274"] = {}
		TITLE_CODES["7274"]["title"] = "PROGRAMMER/ANALYST III-SUPVR"
		TITLE_CODES["7274"]["program"] = "PSS"
		TITLE_CODES["7274"]["unit"] = "99"

	TITLE_CODES["6110"] = {}
		TITLE_CODES["6110"]["title"] = "PRINCIPAL ILLUSTRATOR - SUPVR"
		TITLE_CODES["6110"]["program"] = "PSS"
		TITLE_CODES["6110"]["unit"] = "99"

	TITLE_CODES["6111"] = {}
		TITLE_CODES["6111"]["title"] = "ILLUSTRATOR, PRIN"
		TITLE_CODES["6111"]["program"] = "PSS"
		TITLE_CODES["6111"]["unit"] = "TX"

	TITLE_CODES["6112"] = {}
		TITLE_CODES["6112"]["title"] = "ILLUSTRATOR, SR"
		TITLE_CODES["6112"]["program"] = "PSS"
		TITLE_CODES["6112"]["unit"] = "TX"

	TITLE_CODES["6113"] = {}
		TITLE_CODES["6113"]["title"] = "ILLUSTRATOR"
		TITLE_CODES["6113"]["program"] = "PSS"
		TITLE_CODES["6113"]["unit"] = "TX"

	TITLE_CODES["6904"] = {}
		TITLE_CODES["6904"]["title"] = "ARCHITECTURAL ASSOC, SR"
		TITLE_CODES["6904"]["program"] = "PSS"
		TITLE_CODES["6904"]["unit"] = "99"

	TITLE_CODES["6693"] = {}
		TITLE_CODES["6693"]["title"] = "TRANSLATOR-NONTECHNICAL"
		TITLE_CODES["6693"]["program"] = "PSS"
		TITLE_CODES["6693"]["unit"] = "TX"

	TITLE_CODES["9033"] = {}
		TITLE_CODES["9033"]["title"] = "ADMITTING WORKER"
		TITLE_CODES["9033"]["program"] = "PSS"
		TITLE_CODES["9033"]["unit"] = "EX"

	TITLE_CODES["6695"] = {}
		TITLE_CODES["6695"]["title"] = "TRANSLATOR, PER DIEM"
		TITLE_CODES["6695"]["program"] = "PSS"
		TITLE_CODES["6695"]["unit"] = "TX"

	TITLE_CODES["6694"] = {}
		TITLE_CODES["6694"]["title"] = "TRANSLATOR-TECHNICAL"
		TITLE_CODES["6694"]["program"] = "PSS"
		TITLE_CODES["6694"]["unit"] = "TX"

	TITLE_CODES["9099"] = {}
		TITLE_CODES["9099"]["title"] = "REPRESENTATIVE, ACCESS, PRIN"
		TITLE_CODES["9099"]["program"] = "PSS"
		TITLE_CODES["9099"]["unit"] = "EX"

	TITLE_CODES["150"] = {}
		TITLE_CODES["150"]["title"] = "ASST TT CHAN (FUNCTIONAL AREA)"
		TITLE_CODES["150"]["program"] = "MSP"
		TITLE_CODES["150"]["unit"] = "99"

	TITLE_CODES["7281"] = {}
		TITLE_CODES["7281"]["title"] = "PROGRAMMER I"
		TITLE_CODES["7281"]["program"] = "PSS"
		TITLE_CODES["7281"]["unit"] = "99"

	TITLE_CODES["5440"] = {}
		TITLE_CODES["5440"]["title"] = "EXECUTIVE CHEF"
		TITLE_CODES["5440"]["program"] = "PSS"
		TITLE_CODES["5440"]["unit"] = "99"

	TITLE_CODES["155"] = {}
		TITLE_CODES["155"]["title"] = "SPEC ASST TT CHANC (FUNC AREA)"
		TITLE_CODES["155"]["program"] = "MSP"
		TITLE_CODES["155"]["unit"] = "99"

	TITLE_CODES["7286"] = {}
		TITLE_CODES["7286"]["title"] = "PROGRAMMER IV"
		TITLE_CODES["7286"]["program"] = "PSS"
		TITLE_CODES["7286"]["unit"] = "99"

	TITLE_CODES["7285"] = {}
		TITLE_CODES["7285"]["title"] = "PROGRAMMER III"
		TITLE_CODES["7285"]["program"] = "PSS"
		TITLE_CODES["7285"]["unit"] = "99"

	TITLE_CODES["7284"] = {}
		TITLE_CODES["7284"]["title"] = "PROGRAMMER II"
		TITLE_CODES["7284"]["program"] = "PSS"
		TITLE_CODES["7284"]["unit"] = "99"

	TITLE_CODES["9106"] = {}
		TITLE_CODES["9106"]["title"] = "TECHNOLOGIST, ULTRASOUND PD"
		TITLE_CODES["9106"]["program"] = "PSS"
		TITLE_CODES["9106"]["unit"] = "EX"

	TITLE_CODES["7289"] = {}
		TITLE_CODES["7289"]["title"] = "PROGRAMMER VII"
		TITLE_CODES["7289"]["program"] = "PSS"
		TITLE_CODES["7289"]["unit"] = "99"

	TITLE_CODES["6900"] = {}
		TITLE_CODES["6900"]["title"] = "PR ARCHITECTURAL ASSOC - SUPVR"
		TITLE_CODES["6900"]["program"] = "PSS"
		TITLE_CODES["6900"]["unit"] = "99"

	TITLE_CODES["9103"] = {}
		TITLE_CODES["9103"]["title"] = "THERAPIST, RESPIRATORY IV-SUPV"
		TITLE_CODES["9103"]["program"] = "PSS"
		TITLE_CODES["9103"]["unit"] = "99"

	TITLE_CODES["9100"] = {}
		TITLE_CODES["9100"]["title"] = "REP-SUPVR, ACCESS, PRIN"
		TITLE_CODES["9100"]["program"] = "PSS"
		TITLE_CODES["9100"]["unit"] = "99"

	TITLE_CODES["9101"] = {}
		TITLE_CODES["9101"]["title"] = "ACCESS SUPERVISOR"
		TITLE_CODES["9101"]["program"] = "PSS"
		TITLE_CODES["9101"]["unit"] = "99"

	TITLE_CODES["8986"] = {}
		TITLE_CODES["8986"]["title"] = "TECHNOLOGIST CYTOGENETIC SUPVR"
		TITLE_CODES["8986"]["program"] = "PSS"
		TITLE_CODES["8986"]["unit"] = "99"

	TITLE_CODES["8523"] = {}
		TITLE_CODES["8523"]["title"] = "MECHANIC, FARM MACHINERY"
		TITLE_CODES["8523"]["program"] = "PSS"
		TITLE_CODES["8523"]["unit"] = "SX"

	TITLE_CODES["1898"] = {}
		TITLE_CODES["1898"]["title"] = "ACTING ASST PROFESSOR-SFT-VM"
		TITLE_CODES["1898"]["program"] = "ACADEMIC"
		TITLE_CODES["1898"]["unit"] = "99"

	TITLE_CODES["1899"] = {}
		TITLE_CODES["1899"]["title"] = "ASSOCIATE PROFESSOR--SFT-VM"
		TITLE_CODES["1899"]["program"] = "ACADEMIC"
		TITLE_CODES["1899"]["unit"] = "A3"

	TITLE_CODES["9239"] = {}
		TITLE_CODES["9239"]["title"] = "PHLEBOTOMIST"
		TITLE_CODES["9239"]["program"] = "PSS"
		TITLE_CODES["9239"]["unit"] = "EX"

	TITLE_CODES["1895"] = {}
		TITLE_CODES["1895"]["title"] = "INSTRUCTOR-SFT-VM"
		TITLE_CODES["1895"]["program"] = "ACADEMIC"
		TITLE_CODES["1895"]["unit"] = "A3"

	TITLE_CODES["6953"] = {}
		TITLE_CODES["6953"]["title"] = "ARCHITECT, SR"
		TITLE_CODES["6953"]["program"] = "PSS"
		TITLE_CODES["6953"]["unit"] = "99"

	TITLE_CODES["1897"] = {}
		TITLE_CODES["1897"]["title"] = "ASSISTANT PROFESSOR-SFT-VM"
		TITLE_CODES["1897"]["program"] = "ACADEMIC"
		TITLE_CODES["1897"]["unit"] = "A3"

	TITLE_CODES["1890"] = {}
		TITLE_CODES["1890"]["title"] = "ADJUNCT PROFESSOR-SFT-PC"
		TITLE_CODES["1890"]["program"] = "ACADEMIC"
		TITLE_CODES["1890"]["unit"] = "99"

	TITLE_CODES["9993"] = {}
		TITLE_CODES["9993"]["title"] = "UNCLASSIFIED A&PS 6"
		TITLE_CODES["9993"]["program"] = "PSS"
		TITLE_CODES["9993"]["unit"] = "99"

	TITLE_CODES["4691"] = {}
		TITLE_CODES["4691"]["title"] = "COMPOSITOR, GRAPHIC, SR"
		TITLE_CODES["4691"]["program"] = "PSS"
		TITLE_CODES["4691"]["unit"] = "CX"

	TITLE_CODES["4922"] = {}
		TITLE_CODES["4922"]["title"] = "ASSISTANT I"
		TITLE_CODES["4922"]["program"] = "PSS"
		TITLE_CODES["4922"]["unit"] = "99"

	TITLE_CODES["4921"] = {}
		TITLE_CODES["4921"]["title"] = "ASSISTANT II"
		TITLE_CODES["4921"]["program"] = "PSS"
		TITLE_CODES["4921"]["unit"] = "99"

	TITLE_CODES["4692"] = {}
		TITLE_CODES["4692"]["title"] = "COMPOSITOR, GRAPHIC"
		TITLE_CODES["4692"]["program"] = "PSS"
		TITLE_CODES["4692"]["unit"] = "CX"

	TITLE_CODES["4694"] = {}
		TITLE_CODES["4694"]["title"] = "COMPOSITOR, GRAPHIC, SR-SUPVR"
		TITLE_CODES["4694"]["program"] = "PSS"
		TITLE_CODES["4694"]["unit"] = "99"

	TITLE_CODES["4925"] = {}
		TITLE_CODES["4925"]["title"] = "STUDENT ASSISTANT IV, NON UC"
		TITLE_CODES["4925"]["program"] = "PSS"
		TITLE_CODES["4925"]["unit"] = "99"

	TITLE_CODES["4924"] = {}
		TITLE_CODES["4924"]["title"] = "STUDENT ASSISTANT III, NON UC"
		TITLE_CODES["4924"]["program"] = "PSS"
		TITLE_CODES["4924"]["unit"] = "99"

	TITLE_CODES["9146"] = {}
		TITLE_CODES["9146"]["title"] = "NURSE PRACTITIONER III"
		TITLE_CODES["9146"]["program"] = "PSS"
		TITLE_CODES["9146"]["unit"] = "NX"

	TITLE_CODES["1768"] = {}
		TITLE_CODES["1768"]["title"] = "ASST ADJUNCT PROF-MEDCOMP-B"
		TITLE_CODES["1768"]["program"] = "ACADEMIC"
		TITLE_CODES["1768"]["unit"] = "99"

	TITLE_CODES["8981"] = {}
		TITLE_CODES["8981"]["title"] = "TECHNICIAN, HOSPITAL LAB IV,PD"
		TITLE_CODES["8981"]["program"] = "PSS"
		TITLE_CODES["8981"]["unit"] = "EX"

	TITLE_CODES["1538"] = {}
		TITLE_CODES["1538"]["title"] = "ACT ASST PROFESSOR-GENCOMP-A"
		TITLE_CODES["1538"]["program"] = "ACADEMIC"
		TITLE_CODES["1538"]["unit"] = "A3"

	TITLE_CODES["1769"] = {}
		TITLE_CODES["1769"]["title"] = "ASSOC ADJUNCT PROF-MEDCOMP-B"
		TITLE_CODES["1769"]["program"] = "ACADEMIC"
		TITLE_CODES["1769"]["unit"] = "99"

	TITLE_CODES["5095"] = {}
		TITLE_CODES["5095"]["title"] = "FOOD SERVICE WORKER, SR, PD,MC"
		TITLE_CODES["5095"]["program"] = "PSS"
		TITLE_CODES["5095"]["unit"] = "SX"

	TITLE_CODES["2851"] = {}
		TITLE_CODES["2851"]["title"] = "READER - NON-GSHIP"
		TITLE_CODES["2851"]["program"] = "ACADEMIC"
		TITLE_CODES["2851"]["unit"] = "BX"

	TITLE_CODES["8524"] = {}
		TITLE_CODES["8524"]["title"] = "MECHANIC, FARM MACHINERY, ASST"
		TITLE_CODES["8524"]["program"] = "PSS"
		TITLE_CODES["8524"]["unit"] = "SX"

	TITLE_CODES["2500"] = {}
		TITLE_CODES["2500"]["title"] = "READER - NON-STUDENT"
		TITLE_CODES["2500"]["program"] = "ACADEMIC"
		TITLE_CODES["2500"]["unit"] = "BX"

	TITLE_CODES["2727"] = {}
		TITLE_CODES["2727"]["title"] = "POST-DDS I-VI/NON-REP"
		TITLE_CODES["2727"]["program"] = "ACADEMIC"
		TITLE_CODES["2727"]["unit"] = "99"

	TITLE_CODES["2726"] = {}
		TITLE_CODES["2726"]["title"] = "RES PHYS/SUBSPE IV-VIII/NONREP"
		TITLE_CODES["2726"]["program"] = "ACADEMIC"
		TITLE_CODES["2726"]["unit"] = "99"

	TITLE_CODES["2725"] = {}
		TITLE_CODES["2725"]["title"] = "CHIEF RESIDENT PHYS/NON-REP"
		TITLE_CODES["2725"]["program"] = "ACADEMIC"
		TITLE_CODES["2725"]["unit"] = "99"

	TITLE_CODES["2724"] = {}
		TITLE_CODES["2724"]["title"] = "RESIDENT PHYS II-IX/NON-REP"
		TITLE_CODES["2724"]["program"] = "ACADEMIC"
		TITLE_CODES["2724"]["unit"] = "99"

	TITLE_CODES["2723"] = {}
		TITLE_CODES["2723"]["title"] = "RESIDENT PHYS II-IX/REP"
		TITLE_CODES["2723"]["program"] = "ACADEMIC"
		TITLE_CODES["2723"]["unit"] = "M3"

	TITLE_CODES["9356"] = {}
		TITLE_CODES["9356"]["title"] = "MEDICAL INTERPRETER II"
		TITLE_CODES["9356"]["program"] = "PSS"
		TITLE_CODES["9356"]["unit"] = "HX"

	TITLE_CODES["9355"] = {}
		TITLE_CODES["9355"]["title"] = "MEDICAL INTERPRETER I"
		TITLE_CODES["9355"]["program"] = "PSS"
		TITLE_CODES["9355"]["unit"] = "HX"

	TITLE_CODES["9354"] = {}
		TITLE_CODES["9354"]["title"] = "CHILD LIFE MANAGER"
		TITLE_CODES["9354"]["program"] = "PSS"
		TITLE_CODES["9354"]["unit"] = "99"

	TITLE_CODES["9609"] = {}
		TITLE_CODES["9609"]["title"] = "STAFF RESEARCH ASSOC. V"
		TITLE_CODES["9609"]["program"] = "PSS"
		TITLE_CODES["9609"]["unit"] = "99"

	TITLE_CODES["9397"] = {}
		TITLE_CODES["9397"]["title"] = "TECHNICIAN II, GI ENDOSCOPY"
		TITLE_CODES["9397"]["program"] = "PSS"
		TITLE_CODES["9397"]["unit"] = "EX"

	TITLE_CODES["8980"] = {}
		TITLE_CODES["8980"]["title"] = "TECHNICIAN, HOSPITAL LAB I,PD"
		TITLE_CODES["8980"]["program"] = "PSS"
		TITLE_CODES["8980"]["unit"] = "EX"

	TITLE_CODES["2729"] = {}
		TITLE_CODES["2729"]["title"] = "PGY2 PHARMACY RESIDENT/NON REP"
		TITLE_CODES["2729"]["program"] = "ACADEMIC"
		TITLE_CODES["2729"]["unit"] = "99"

	TITLE_CODES["2728"] = {}
		TITLE_CODES["2728"]["title"] = "PGY1 PHARMACY RESIDENT/NON REP"
		TITLE_CODES["2728"]["program"] = "ACADEMIC"
		TITLE_CODES["2728"]["unit"] = "99"

	TITLE_CODES["7236"] = {}
		TITLE_CODES["7236"]["title"] = "ANALYST III"
		TITLE_CODES["7236"]["program"] = "PSS"
		TITLE_CODES["7236"]["unit"] = "99"

	TITLE_CODES["7237"] = {}
		TITLE_CODES["7237"]["title"] = "ANALYST IV"
		TITLE_CODES["7237"]["program"] = "PSS"
		TITLE_CODES["7237"]["unit"] = "99"

	TITLE_CODES["7234"] = {}
		TITLE_CODES["7234"]["title"] = "ANALYST I"
		TITLE_CODES["7234"]["program"] = "PSS"
		TITLE_CODES["7234"]["unit"] = "99"

	TITLE_CODES["7235"] = {}
		TITLE_CODES["7235"]["title"] = "ANALYST II"
		TITLE_CODES["7235"]["program"] = "PSS"
		TITLE_CODES["7235"]["unit"] = "99"

	TITLE_CODES["7232"] = {}
		TITLE_CODES["7232"]["title"] = "SURVEY WORKER, SR"
		TITLE_CODES["7232"]["program"] = "PSS"
		TITLE_CODES["7232"]["unit"] = "CX"

	TITLE_CODES["7233"] = {}
		TITLE_CODES["7233"]["title"] = "SURVEY WORKER"
		TITLE_CODES["7233"]["program"] = "PSS"
		TITLE_CODES["7233"]["unit"] = "CX"

	TITLE_CODES["2850"] = {}
		TITLE_CODES["2850"]["title"] = "READER - GSHIP"
		TITLE_CODES["2850"]["program"] = "ACADEMIC"
		TITLE_CODES["2850"]["unit"] = "BX"

	TITLE_CODES["5048"] = {}
		TITLE_CODES["5048"]["title"] = "FOOD SERVICE SUPERVISOR I, MC"
		TITLE_CODES["5048"]["program"] = "PSS"
		TITLE_CODES["5048"]["unit"] = "99"

	TITLE_CODES["9199"] = {}
		TITLE_CODES["9199"]["title"] = "DENTAL ASST"
		TITLE_CODES["9199"]["program"] = "PSS"
		TITLE_CODES["9199"]["unit"] = "EX"

	TITLE_CODES["9213"] = {}
		TITLE_CODES["9213"]["title"] = "COORDINATOR, MED OFF SRVC, II"
		TITLE_CODES["9213"]["program"] = "PSS"
		TITLE_CODES["9213"]["unit"] = "EX"

	TITLE_CODES["9210"] = {}
		TITLE_CODES["9210"]["title"] = "COORDINATOR,MED OFF SERV, PD I"
		TITLE_CODES["9210"]["program"] = "PSS"
		TITLE_CODES["9210"]["unit"] = "EX"

	TITLE_CODES["9211"] = {}
		TITLE_CODES["9211"]["title"] = "COORDINATOR,MED OFF SRVC,PD II"
		TITLE_CODES["9211"]["program"] = "PSS"
		TITLE_CODES["9211"]["unit"] = "EX"

	TITLE_CODES["9216"] = {}
		TITLE_CODES["9216"]["title"] = "COORD, MED OFF SRVC, IV"
		TITLE_CODES["9216"]["program"] = "PSS"
		TITLE_CODES["9216"]["unit"] = "EX"

	TITLE_CODES["9217"] = {}
		TITLE_CODES["9217"]["title"] = "COORD, MED OFF SRVC, IV--SUPVR"
		TITLE_CODES["9217"]["program"] = "PSS"
		TITLE_CODES["9217"]["unit"] = "99"

	TITLE_CODES["7238"] = {}
		TITLE_CODES["7238"]["title"] = "ANALYST V"
		TITLE_CODES["7238"]["program"] = "PSS"
		TITLE_CODES["7238"]["unit"] = "99"

	TITLE_CODES["7239"] = {}
		TITLE_CODES["7239"]["title"] = "ANALYST VI"
		TITLE_CODES["7239"]["program"] = "PSS"
		TITLE_CODES["7239"]["unit"] = "99"

	TITLE_CODES["1807"] = {}
		TITLE_CODES["1807"]["title"] = "HS CLIN INSTRUCTOR-FY-GENCOMP"
		TITLE_CODES["1807"]["program"] = "ACADEMIC"
		TITLE_CODES["1807"]["unit"] = "99"

	TITLE_CODES["1806"] = {}
		TITLE_CODES["1806"]["title"] = "HS CLIN PROF-FY-MEDCOMP"
		TITLE_CODES["1806"]["program"] = "ACADEMIC"
		TITLE_CODES["1806"]["unit"] = "99"

	TITLE_CODES["1805"] = {}
		TITLE_CODES["1805"]["title"] = "HS ASSOC CLIN PROF-FY-MEDCOMP"
		TITLE_CODES["1805"]["program"] = "ACADEMIC"
		TITLE_CODES["1805"]["unit"] = "99"

	TITLE_CODES["1804"] = {}
		TITLE_CODES["1804"]["title"] = "HS ASST CLIN PROF-FY-MEDCOMP"
		TITLE_CODES["1804"]["program"] = "ACADEMIC"
		TITLE_CODES["1804"]["unit"] = "99"

	TITLE_CODES["1803"] = {}
		TITLE_CODES["1803"]["title"] = "HS CLIN INSTRUCTOR-FY-MEDCOMP"
		TITLE_CODES["1803"]["program"] = "ACADEMIC"
		TITLE_CODES["1803"]["unit"] = "99"

	TITLE_CODES["8992"] = {}
		TITLE_CODES["8992"]["title"] = "ASSISTANT, MEDICAL, PER DIEM"
		TITLE_CODES["8992"]["program"] = "PSS"
		TITLE_CODES["8992"]["unit"] = "EX"

	TITLE_CODES["3422"] = {}
		TITLE_CODES["3422"]["title"] = "VST ASST COOP EXT SPECIALIST"
		TITLE_CODES["3422"]["program"] = "ACADEMIC"
		TITLE_CODES["3422"]["unit"] = "99"

	TITLE_CODES["8990"] = {}
		TITLE_CODES["8990"]["title"] = "TECHNOLOGIST RADIOLOGIC SR PD"
		TITLE_CODES["8990"]["program"] = "PSS"
		TITLE_CODES["8990"]["unit"] = "EX"

	TITLE_CODES["8991"] = {}
		TITLE_CODES["8991"]["title"] = "MEDICAL ASSISTANT II, PER DIEM"
		TITLE_CODES["8991"]["program"] = "PSS"
		TITLE_CODES["8991"]["unit"] = "EX"

	TITLE_CODES["8997"] = {}
		TITLE_CODES["8997"]["title"] = "CYTOTECHNOLOGIST, SR, PER DIEM"
		TITLE_CODES["8997"]["program"] = "PSS"
		TITLE_CODES["8997"]["unit"] = "HX"

	TITLE_CODES["1809"] = {}
		TITLE_CODES["1809"]["title"] = "HS ASSOC CLIN PROF-FY-GENCOMP"
		TITLE_CODES["1809"]["program"] = "ACADEMIC"
		TITLE_CODES["1809"]["unit"] = "99"

	TITLE_CODES["1808"] = {}
		TITLE_CODES["1808"]["title"] = "HS ASST CLIN PROF-FY-GENCOMP"
		TITLE_CODES["1808"]["program"] = "ACADEMIC"
		TITLE_CODES["1808"]["unit"] = "99"

	TITLE_CODES["6334"] = {}
		TITLE_CODES["6334"]["title"] = "TECHNICIAN, SCENE, ASST"
		TITLE_CODES["6334"]["program"] = "PSS"
		TITLE_CODES["6334"]["unit"] = "TX"

	TITLE_CODES["2003"] = {}
		TITLE_CODES["2003"]["title"] = "CLIN PROF DENT-AY-PTC GENCO"
		TITLE_CODES["2003"]["program"] = "ACADEMIC"
		TITLE_CODES["2003"]["unit"] = "99"

	TITLE_CODES["2000"] = {}
		TITLE_CODES["2000"]["title"] = "HS CLINICAL PROFESSOR-ACAD YR"
		TITLE_CODES["2000"]["program"] = "ACADEMIC"
		TITLE_CODES["2000"]["unit"] = "99"

	TITLE_CODES["2001"] = {}
		TITLE_CODES["2001"]["title"] = "CLIN PROF-DENTISTRY-50%/+ AY"
		TITLE_CODES["2001"]["program"] = "ACADEMIC"
		TITLE_CODES["2001"]["unit"] = "99"

	TITLE_CODES["2853"] = {}
		TITLE_CODES["2853"]["title"] = "SPECIAL READER-UCLA-NON-GSHIP"
		TITLE_CODES["2853"]["program"] = "ACADEMIC"
		TITLE_CODES["2853"]["unit"] = "BX"

	TITLE_CODES["6331"] = {}
		TITLE_CODES["6331"]["title"] = "THEATRE PRODUCTION SUPVR"
		TITLE_CODES["6331"]["program"] = "PSS"
		TITLE_CODES["6331"]["unit"] = "99"

	TITLE_CODES["6332"] = {}
		TITLE_CODES["6332"]["title"] = "TECHNICIAN, SCENE, SR"
		TITLE_CODES["6332"]["program"] = "PSS"
		TITLE_CODES["6332"]["unit"] = "TX"

	TITLE_CODES["6333"] = {}
		TITLE_CODES["6333"]["title"] = "TECHNICIAN, SCENE"
		TITLE_CODES["6333"]["program"] = "PSS"
		TITLE_CODES["6333"]["unit"] = "TX"

	TITLE_CODES["9458"] = {}
		TITLE_CODES["9458"]["title"] = "ATHLETIC TRAINER"
		TITLE_CODES["9458"]["program"] = "PSS"
		TITLE_CODES["9458"]["unit"] = "99"

	TITLE_CODES["6975"] = {}
		TITLE_CODES["6975"]["title"] = "PROJECT MGR,DESIGN/CONSTR II"
		TITLE_CODES["6975"]["program"] = "PSS"
		TITLE_CODES["6975"]["unit"] = "99"

	TITLE_CODES["9076"] = {}
		TITLE_CODES["9076"]["title"] = "TECHNOLOGIST,RAD,CHIEF-SUPVR"
		TITLE_CODES["9076"]["program"] = "PSS"
		TITLE_CODES["9076"]["unit"] = "99"

	TITLE_CODES["9077"] = {}
		TITLE_CODES["9077"]["title"] = "TECHNOLOGIST,RAD,ASSOC-SUPVR"
		TITLE_CODES["9077"]["program"] = "PSS"
		TITLE_CODES["9077"]["unit"] = "99"

	TITLE_CODES["9075"] = {}
		TITLE_CODES["9075"]["title"] = "TECHNOL,RAD THPY,CHIEF - SUPVR"
		TITLE_CODES["9075"]["program"] = "PSS"
		TITLE_CODES["9075"]["unit"] = "99"

	TITLE_CODES["9072"] = {}
		TITLE_CODES["9072"]["title"] = "RADIATION EQUIP SPECIALIST, SR"
		TITLE_CODES["9072"]["program"] = "PSS"
		TITLE_CODES["9072"]["unit"] = "EX"

	TITLE_CODES["7053"] = {}
		TITLE_CODES["7053"]["title"] = "ARCHITECT, LANDSCAPE, ASSOC"
		TITLE_CODES["7053"]["program"] = "PSS"
		TITLE_CODES["7053"]["unit"] = "99"

	TITLE_CODES["6960"] = {}
		TITLE_CODES["6960"]["title"] = "ED FACILITY PLANNER SUPV"
		TITLE_CODES["6960"]["program"] = "PSS"
		TITLE_CODES["6960"]["unit"] = "99"

	TITLE_CODES["8257"] = {}
		TITLE_CODES["8257"]["title"] = "PLUMBER, LEAD"
		TITLE_CODES["8257"]["program"] = "PSS"
		TITLE_CODES["8257"]["unit"] = "K3"

	TITLE_CODES["9078"] = {}
		TITLE_CODES["9078"]["title"] = "MAMMOGRAPHY TECHNOLOGIST PD"
		TITLE_CODES["9078"]["program"] = "PSS"
		TITLE_CODES["9078"]["unit"] = "EX"

	TITLE_CODES["9025"] = {}
		TITLE_CODES["9025"]["title"] = "TECHNOLOGIST,RADIOLOG,PER DIEM"
		TITLE_CODES["9025"]["program"] = "PSS"
		TITLE_CODES["9025"]["unit"] = "EX"

	TITLE_CODES["9034"] = {}
		TITLE_CODES["9034"]["title"] = "ADMITTING WORKER, PER DIEM"
		TITLE_CODES["9034"]["program"] = "PSS"
		TITLE_CODES["9034"]["unit"] = "EX"

	TITLE_CODES["9024"] = {}
		TITLE_CODES["9024"]["title"] = "TECHNOLOGIST,RADIOLOG,TRAINEE"
		TITLE_CODES["9024"]["program"] = "PSS"
		TITLE_CODES["9024"]["unit"] = "EX"

	TITLE_CODES["6965"] = {}
		TITLE_CODES["6965"]["title"] = "ANALYST, FACILITY REQUIREMENTS"
		TITLE_CODES["6965"]["program"] = "PSS"
		TITLE_CODES["6965"]["unit"] = "99"

	TITLE_CODES["9999"] = {}
		TITLE_CODES["9999"]["title"] = "UNCLASSIFIED"
		TITLE_CODES["9999"]["program"] = "PSS"
		TITLE_CODES["9999"]["unit"] = "99"

	TITLE_CODES["7003"] = {}
		TITLE_CODES["7003"]["title"] = "INSPECTOR, CONSTRUCTION, ASSOC"
		TITLE_CODES["7003"]["program"] = "PSS"
		TITLE_CODES["7003"]["unit"] = "TX"

	TITLE_CODES["8306"] = {}
		TITLE_CODES["8306"]["title"] = "BLDG MAINTENANCE WRKR, SR, MC"
		TITLE_CODES["8306"]["program"] = "PSS"
		TITLE_CODES["8306"]["unit"] = "SX"

	TITLE_CODES["6964"] = {}
		TITLE_CODES["6964"]["title"] = "ANALYST,FACILITY REQUIRE, SR"
		TITLE_CODES["6964"]["program"] = "PSS"
		TITLE_CODES["6964"]["unit"] = "99"

	TITLE_CODES["3258"] = {}
		TITLE_CODES["3258"]["title"] = "ADJUNCT PROFESSOR-ACADEMIC YR"
		TITLE_CODES["3258"]["program"] = "ACADEMIC"
		TITLE_CODES["3258"]["unit"] = "99"

	TITLE_CODES["3259"] = {}
		TITLE_CODES["3259"]["title"] = "ADJUNCT PROFESSOR - FISCAL YR"
		TITLE_CODES["3259"]["program"] = "ACADEMIC"
		TITLE_CODES["3259"]["unit"] = "99"

	TITLE_CODES["1948"] = {}
		TITLE_CODES["1948"]["title"] = "ROTATING RESEARCH PROF - FY"
		TITLE_CODES["1948"]["program"] = "ACADEMIC"
		TITLE_CODES["1948"]["unit"] = "FX"

	TITLE_CODES["7002"] = {}
		TITLE_CODES["7002"]["title"] = "INSPECTOR, CONSTRUCTION, SR"
		TITLE_CODES["7002"]["program"] = "PSS"
		TITLE_CODES["7002"]["unit"] = "TX"

	TITLE_CODES["9289"] = {}
		TITLE_CODES["9289"]["title"] = "COUNSELOR, GENETICS, PER DIEM"
		TITLE_CODES["9289"]["program"] = "PSS"
		TITLE_CODES["9289"]["unit"] = "HX"

	TITLE_CODES["6967"] = {}
		TITLE_CODES["6967"]["title"] = "PLANNER, SR"
		TITLE_CODES["6967"]["program"] = "PSS"
		TITLE_CODES["6967"]["unit"] = "99"

	TITLE_CODES["3250"] = {}
		TITLE_CODES["3250"]["title"] = "PROFESSOR IN RESIDENCE-ACAD YR"
		TITLE_CODES["3250"]["program"] = "ACADEMIC"
		TITLE_CODES["3250"]["unit"] = "A3"

	TITLE_CODES["3251"] = {}
		TITLE_CODES["3251"]["title"] = "PROFESSOR IN RESIDENCE - FY"
		TITLE_CODES["3251"]["program"] = "ACADEMIC"
		TITLE_CODES["3251"]["unit"] = "A3"

	TITLE_CODES["3252"] = {}
		TITLE_CODES["3252"]["title"] = "POSTDOC-EMPLOYEE"
		TITLE_CODES["3252"]["program"] = "ACADEMIC"
		TITLE_CODES["3252"]["unit"] = "PX"

	TITLE_CODES["3253"] = {}
		TITLE_CODES["3253"]["title"] = "POSTDOC-FELLOW"
		TITLE_CODES["3253"]["program"] = "ACADEMIC"
		TITLE_CODES["3253"]["unit"] = "PX"

	TITLE_CODES["3254"] = {}
		TITLE_CODES["3254"]["title"] = "POSTDOC-PAID DIRECT"
		TITLE_CODES["3254"]["program"] = "ACADEMIC"
		TITLE_CODES["3254"]["unit"] = "PX"

	TITLE_CODES["9280"] = {}
		TITLE_CODES["9280"]["title"] = "PHARMACY TECHNICIAN SUPV"
		TITLE_CODES["9280"]["program"] = "PSS"
		TITLE_CODES["9280"]["unit"] = "99"

	TITLE_CODES["9283"] = {}
		TITLE_CODES["9283"]["title"] = "PHARMACY TECHNICIAN I"
		TITLE_CODES["9283"]["program"] = "PSS"
		TITLE_CODES["9283"]["unit"] = "EX"

	TITLE_CODES["7004"] = {}
		TITLE_CODES["7004"]["title"] = "INSPECTOR, CONSTRUCTION, ASST"
		TITLE_CODES["7004"]["program"] = "PSS"
		TITLE_CODES["7004"]["unit"] = "TX"

	TITLE_CODES["8156"] = {}
		TITLE_CODES["8156"]["title"] = "MATERIAL COORDINATOR"
		TITLE_CODES["8156"]["program"] = "PSS"
		TITLE_CODES["8156"]["unit"] = "K3"

	TITLE_CODES["9023"] = {}
		TITLE_CODES["9023"]["title"] = "TECHNOLOGIST,RADIOLOGIC"
		TITLE_CODES["9023"]["program"] = "PSS"
		TITLE_CODES["9023"]["unit"] = "EX"

	TITLE_CODES["8157"] = {}
		TITLE_CODES["8157"]["title"] = "CEMENT MASON/FLOORER APPREN"
		TITLE_CODES["8157"]["program"] = "PSS"
		TITLE_CODES["8157"]["unit"] = "K3"

	TITLE_CODES["810"] = {}
		TITLE_CODES["810"]["title"] = "GRADUATE ADVISOR"
		TITLE_CODES["810"]["program"] = "ACADEMIC"
		TITLE_CODES["810"]["unit"] = "99"

	TITLE_CODES["811"] = {}
		TITLE_CODES["811"]["title"] = "ACADEMIC PROGRAMS ADVISOR"
		TITLE_CODES["811"]["program"] = "ACADEMIC"
		TITLE_CODES["811"]["unit"] = "99"

	TITLE_CODES["812"] = {}
		TITLE_CODES["812"]["title"] = "FACULTY ADVISOR"
		TITLE_CODES["812"]["program"] = "ACADEMIC"
		TITLE_CODES["812"]["unit"] = "99"

	TITLE_CODES["8906"] = {}
		TITLE_CODES["8906"]["title"] = "HOSPITAL ASST, PER DIEM"
		TITLE_CODES["8906"]["program"] = "PSS"
		TITLE_CODES["8906"]["unit"] = "EX"

	TITLE_CODES["9357"] = {}
		TITLE_CODES["9357"]["title"] = "MEDICAL INTERPRETER PER DIEM"
		TITLE_CODES["9357"]["program"] = "PSS"
		TITLE_CODES["9357"]["unit"] = "HX"

	TITLE_CODES["8154"] = {}
		TITLE_CODES["8154"]["title"] = "HIGH VOLT ELECTRICIAN"
		TITLE_CODES["8154"]["program"] = "PSS"
		TITLE_CODES["8154"]["unit"] = "K3"

	TITLE_CODES["8903"] = {}
		TITLE_CODES["8903"]["title"] = "PATIENT ESCORT, P.D."
		TITLE_CODES["8903"]["program"] = "PSS"
		TITLE_CODES["8903"]["unit"] = "EX"

	TITLE_CODES["9471"] = {}
		TITLE_CODES["9471"]["title"] = "SPEECH, PATHOLOGIST, PER DIEM"
		TITLE_CODES["9471"]["program"] = "PSS"
		TITLE_CODES["9471"]["unit"] = "HX"

	TITLE_CODES["719"] = {}
		TITLE_CODES["719"]["title"] = "PR EDUCATIONAL FACILITY PLAN"
		TITLE_CODES["719"]["program"] = "MSP"
		TITLE_CODES["719"]["unit"] = "99"

	TITLE_CODES["3206"] = {}
		TITLE_CODES["3206"]["title"] = "RESEARCH-----SFT"
		TITLE_CODES["3206"]["program"] = "ACADEMIC"
		TITLE_CODES["3206"]["unit"] = "FX"

	TITLE_CODES["717"] = {}
		TITLE_CODES["717"]["title"] = "PRINCIPAL ARCHITECT"
		TITLE_CODES["717"]["program"] = "MSP"
		TITLE_CODES["717"]["unit"] = "99"

	TITLE_CODES["1792"] = {}
		TITLE_CODES["1792"]["title"] = "HS ASST CLIN PROF-GENCOMP-B"
		TITLE_CODES["1792"]["program"] = "ACADEMIC"
		TITLE_CODES["1792"]["unit"] = "99"

	TITLE_CODES["715"] = {}
		TITLE_CODES["715"]["title"] = "CHIEF DIETITIAN"
		TITLE_CODES["715"]["program"] = "MSP"
		TITLE_CODES["715"]["unit"] = "99"

	TITLE_CODES["1790"] = {}
		TITLE_CODES["1790"]["title"] = "ADJUNCT PROF-FY-MEDCOMP"
		TITLE_CODES["1790"]["program"] = "ACADEMIC"
		TITLE_CODES["1790"]["unit"] = "99"

	TITLE_CODES["713"] = {}
		TITLE_CODES["713"]["title"] = "SOCIAL WRKR, CLN, CHF LICENSED"
		TITLE_CODES["713"]["program"] = "MSP"
		TITLE_CODES["713"]["unit"] = "99"

	TITLE_CODES["712"] = {}
		TITLE_CODES["712"]["title"] = "COUNSELING PSYCHOLOGIST III"
		TITLE_CODES["712"]["program"] = "MSP"
		TITLE_CODES["712"]["unit"] = "99"

	TITLE_CODES["711"] = {}
		TITLE_CODES["711"]["title"] = "COUNSELING CTR. MGR. I"
		TITLE_CODES["711"]["program"] = "MSP"
		TITLE_CODES["711"]["unit"] = "99"

	TITLE_CODES["710"] = {}
		TITLE_CODES["710"]["title"] = "COUNSELING CTR. MGR. II"
		TITLE_CODES["710"]["program"] = "MSP"
		TITLE_CODES["710"]["unit"] = "99"

	TITLE_CODES["3330"] = {}
		TITLE_CODES["3330"]["title"] = "JUNIOR SPECIALIST"
		TITLE_CODES["3330"]["program"] = "ACADEMIC"
		TITLE_CODES["3330"]["unit"] = "FX"

	TITLE_CODES["3203"] = {}
		TITLE_CODES["3203"]["title"] = "RESEARCH____ - ACADEMIC YEAR"
		TITLE_CODES["3203"]["program"] = "ACADEMIC"
		TITLE_CODES["3203"]["unit"] = "FX"

	TITLE_CODES["9475"] = {}
		TITLE_CODES["9475"]["title"] = "AUDIOLOGIST"
		TITLE_CODES["9475"]["program"] = "PSS"
		TITLE_CODES["9475"]["unit"] = "HX"

	TITLE_CODES["2071"] = {}
		TITLE_CODES["2071"]["title"] = "CLIN INSTR- DENT - 50%/+ FY"
		TITLE_CODES["2071"]["program"] = "ACADEMIC"
		TITLE_CODES["2071"]["unit"] = "99"

	TITLE_CODES["1069"] = {}
		TITLE_CODES["1069"]["title"] = "ASSOCIATE VICE PROVOST"
		TITLE_CODES["1069"]["program"] = "ACADEMIC"
		TITLE_CODES["1069"]["unit"] = "99"

	TITLE_CODES["1068"] = {}
		TITLE_CODES["1068"]["title"] = "VICE PROVOST"
		TITLE_CODES["1068"]["program"] = "ACADEMIC"
		TITLE_CODES["1068"]["unit"] = "99"

	TITLE_CODES["1702"] = {}
		TITLE_CODES["1702"]["title"] = "RECALL ____-MEDCOMP-B"
		TITLE_CODES["1702"]["program"] = "ACADEMIC"
		TITLE_CODES["1702"]["unit"] = "A3"

	TITLE_CODES["1703"] = {}
		TITLE_CODES["1703"]["title"] = "RECALL ____-GENCOMP-B"
		TITLE_CODES["1703"]["program"] = "ACADEMIC"
		TITLE_CODES["1703"]["unit"] = "A3"

	TITLE_CODES["1704"] = {}
		TITLE_CODES["1704"]["title"] = "RECALL ____-GENCOMP-A"
		TITLE_CODES["1704"]["program"] = "ACADEMIC"
		TITLE_CODES["1704"]["unit"] = "A3"

	TITLE_CODES["1705"] = {}
		TITLE_CODES["1705"]["title"] = "RECALL ____-FY-MEDCOMP"
		TITLE_CODES["1705"]["program"] = "ACADEMIC"
		TITLE_CODES["1705"]["unit"] = "A3"

	TITLE_CODES["1706"] = {}
		TITLE_CODES["1706"]["title"] = "RECALL ____-FY-GENCOMP"
		TITLE_CODES["1706"]["program"] = "ACADEMIC"
		TITLE_CODES["1706"]["unit"] = "A3"

	TITLE_CODES["1707"] = {}
		TITLE_CODES["1707"]["title"] = "RESEARCH PROFESSOR"
		TITLE_CODES["1707"]["program"] = "ACADEMIC"
		TITLE_CODES["1707"]["unit"] = "A3"

	TITLE_CODES["1061"] = {}
		TITLE_CODES["1061"]["title"] = "ACADEMIC ADMINISTRATOR I"
		TITLE_CODES["1061"]["program"] = "ACADEMIC"
		TITLE_CODES["1061"]["unit"] = "99"

	TITLE_CODES["1060"] = {}
		TITLE_CODES["1060"]["title"] = "PROVOST OF ___COLLEGE"
		TITLE_CODES["1060"]["program"] = "ACADEMIC"
		TITLE_CODES["1060"]["unit"] = "99"

	TITLE_CODES["1063"] = {}
		TITLE_CODES["1063"]["title"] = "ACADEMIC ADMINISTRATOR III"
		TITLE_CODES["1063"]["program"] = "ACADEMIC"
		TITLE_CODES["1063"]["unit"] = "99"

	TITLE_CODES["1062"] = {}
		TITLE_CODES["1062"]["title"] = "ACADEMIC ADMINISTRATOR II"
		TITLE_CODES["1062"]["program"] = "ACADEMIC"
		TITLE_CODES["1062"]["unit"] = "99"

	TITLE_CODES["1065"] = {}
		TITLE_CODES["1065"]["title"] = "ACADEMIC ADMINISTRATOR V"
		TITLE_CODES["1065"]["program"] = "ACADEMIC"
		TITLE_CODES["1065"]["unit"] = "99"

	TITLE_CODES["1064"] = {}
		TITLE_CODES["1064"]["title"] = "ACADEMIC ADMINISTRATOR IV"
		TITLE_CODES["1064"]["program"] = "ACADEMIC"
		TITLE_CODES["1064"]["unit"] = "99"

	TITLE_CODES["1067"] = {}
		TITLE_CODES["1067"]["title"] = "ACADEMIC ADMINISTRATOR VII"
		TITLE_CODES["1067"]["program"] = "ACADEMIC"
		TITLE_CODES["1067"]["unit"] = "99"

	TITLE_CODES["1066"] = {}
		TITLE_CODES["1066"]["title"] = "ACADEMIC ADMINISTRATOR VI"
		TITLE_CODES["1066"]["program"] = "ACADEMIC"
		TITLE_CODES["1066"]["unit"] = "99"

	TITLE_CODES["9323"] = {}
		TITLE_CODES["9323"]["title"] = "COMMUNITY HLTH PROGRAM SUPV"
		TITLE_CODES["9323"]["program"] = "PSS"
		TITLE_CODES["9323"]["unit"] = "99"

	TITLE_CODES["9108"] = {}
		TITLE_CODES["9108"]["title"] = "LEAD MAMMOGRAPHY TECHNOLOGIST"
		TITLE_CODES["9108"]["program"] = "PSS"
		TITLE_CODES["9108"]["unit"] = "EX"

	TITLE_CODES["1667"] = {}
		TITLE_CODES["1667"]["title"] = "LECT W/SEC-FISCAL YR-RECALL"
		TITLE_CODES["1667"]["program"] = "ACADEMIC"
		TITLE_CODES["1667"]["unit"] = "A3"

	TITLE_CODES["1666"] = {}
		TITLE_CODES["1666"]["title"] = "LECT W/SEC-AY-RECALL-1/9TH"
		TITLE_CODES["1666"]["program"] = "ACADEMIC"
		TITLE_CODES["1666"]["unit"] = "A3"

	TITLE_CODES["1665"] = {}
		TITLE_CODES["1665"]["title"] = "LECT W/SEC-ACAD YR-RECALL"
		TITLE_CODES["1665"]["program"] = "ACADEMIC"
		TITLE_CODES["1665"]["unit"] = "A3"

	TITLE_CODES["1663"] = {}
		TITLE_CODES["1663"]["title"] = "SR LECT W/SEC-FISCAL YR-RECALL"
		TITLE_CODES["1663"]["program"] = "ACADEMIC"
		TITLE_CODES["1663"]["unit"] = "A3"

	TITLE_CODES["1662"] = {}
		TITLE_CODES["1662"]["title"] = "SR LECT W/SEC-AY-RECALL-1/9TH"
		TITLE_CODES["1662"]["program"] = "ACADEMIC"
		TITLE_CODES["1662"]["unit"] = "A3"

	TITLE_CODES["1660"] = {}
		TITLE_CODES["1660"]["title"] = "SR LECT W/SEC-ACAD YR -RECALL"
		TITLE_CODES["1660"]["program"] = "ACADEMIC"
		TITLE_CODES["1660"]["unit"] = "A3"

	TITLE_CODES["1087"] = {}
		TITLE_CODES["1087"]["title"] = "ACT/INTERIM ASSOC VICE PROVOST"
		TITLE_CODES["1087"]["program"] = "ACADEMIC"
		TITLE_CODES["1087"]["unit"] = "99"

	TITLE_CODES["8232"] = {}
		TITLE_CODES["8232"]["title"] = "HVAC CONTROL TECH, APPRENTICE"
		TITLE_CODES["8232"]["program"] = "PSS"
		TITLE_CODES["8232"]["unit"] = "K3"

	TITLE_CODES["1084"] = {}
		TITLE_CODES["1084"]["title"] = "ASST DIRECTOR-INTERNATL PROGS"
		TITLE_CODES["1084"]["program"] = "ACADEMIC"
		TITLE_CODES["1084"]["unit"] = "99"

	TITLE_CODES["1082"] = {}
		TITLE_CODES["1082"]["title"] = "ASSOC DIRECTOR-INTERNATL PROGS"
		TITLE_CODES["1082"]["program"] = "ACADEMIC"
		TITLE_CODES["1082"]["unit"] = "99"

	TITLE_CODES["1080"] = {}
		TITLE_CODES["1080"]["title"] = "DIRECTOR-INTERNATL PROGRAMS"
		TITLE_CODES["1080"]["program"] = "ACADEMIC"
		TITLE_CODES["1080"]["unit"] = "99"

	TITLE_CODES["4320"] = {}
		TITLE_CODES["4320"]["title"] = "OCCUPATIONAL INFO ADVISOR SUPV"
		TITLE_CODES["4320"]["program"] = "PSS"
		TITLE_CODES["4320"]["unit"] = "99"

	TITLE_CODES["9496"] = {}
		TITLE_CODES["9496"]["title"] = "THERAPIST, OCCUPATIONAL IV"
		TITLE_CODES["9496"]["program"] = "PSS"
		TITLE_CODES["9496"]["unit"] = "99"

	TITLE_CODES["9109"] = {}
		TITLE_CODES["9109"]["title"] = "TECHNOLGIST,ULTRASOUND,LEAD PR"
		TITLE_CODES["9109"]["program"] = "PSS"
		TITLE_CODES["9109"]["unit"] = "EX"

	TITLE_CODES["9722"] = {}
		TITLE_CODES["9722"]["title"] = "SCIENTIST, MUSEUM, SR"
		TITLE_CODES["9722"]["program"] = "PSS"
		TITLE_CODES["9722"]["unit"] = "RX"

	TITLE_CODES["8989"] = {}
		TITLE_CODES["8989"]["title"] = "TECHNOLOGIST, CYTO, TRAINEE"
		TITLE_CODES["8989"]["program"] = "PSS"
		TITLE_CODES["8989"]["unit"] = "EX"

	TITLE_CODES["3386"] = {}
		TITLE_CODES["3386"]["title"] = "ASO PRO IN RES-AY-1/9-B/ECON/E"
		TITLE_CODES["3386"]["program"] = "ACADEMIC"
		TITLE_CODES["3386"]["unit"] = "A3"

	TITLE_CODES["3387"] = {}
		TITLE_CODES["3387"]["title"] = "AST PROF IN RES-AY-B/ECON/ENG"
		TITLE_CODES["3387"]["program"] = "ACADEMIC"
		TITLE_CODES["3387"]["unit"] = "A3"

	TITLE_CODES["3384"] = {}
		TITLE_CODES["3384"]["title"] = "ASO PROF IN RES-AY-B/ECON/ENG"
		TITLE_CODES["3384"]["program"] = "ACADEMIC"
		TITLE_CODES["3384"]["unit"] = "A3"

	TITLE_CODES["3385"] = {}
		TITLE_CODES["3385"]["title"] = "ASO PROF IN RES-FY-B/ECON/ENG"
		TITLE_CODES["3385"]["program"] = "ACADEMIC"
		TITLE_CODES["3385"]["unit"] = "A3"

	TITLE_CODES["3382"] = {}
		TITLE_CODES["3382"]["title"] = "PROF IN RES-FY-BUS/ECON/ENG"
		TITLE_CODES["3382"]["program"] = "ACADEMIC"
		TITLE_CODES["3382"]["unit"] = "A3"

	TITLE_CODES["3383"] = {}
		TITLE_CODES["3383"]["title"] = "PROF IN RES-AY-1/9-B/ECON/ENG"
		TITLE_CODES["3383"]["program"] = "ACADEMIC"
		TITLE_CODES["3383"]["unit"] = "A3"

	TITLE_CODES["3029"] = {}
		TITLE_CODES["3029"]["title"] = "ACT ASST --IN THE A.E.S.SFT-VM"
		TITLE_CODES["3029"]["program"] = "ACADEMIC"
		TITLE_CODES["3029"]["unit"] = "FX"

	TITLE_CODES["3028"] = {}
		TITLE_CODES["3028"]["title"] = "VST ASST ----- IN THE A.E.S."
		TITLE_CODES["3028"]["program"] = "ACADEMIC"
		TITLE_CODES["3028"]["unit"] = "99"

	TITLE_CODES["3027"] = {}
		TITLE_CODES["3027"]["title"] = "ACT ASST ----- IN THE A.E.S."
		TITLE_CODES["3027"]["program"] = "ACADEMIC"
		TITLE_CODES["3027"]["unit"] = "99"

	TITLE_CODES["7633"] = {}
		TITLE_CODES["7633"]["title"] = "ADMIN SPECIALIST I - SUPVR"
		TITLE_CODES["7633"]["program"] = "PSS"
		TITLE_CODES["7633"]["unit"] = "99"

	TITLE_CODES["7131"] = {}
		TITLE_CODES["7131"]["title"] = "EH&S SPECIALIST SUPERVISOR"
		TITLE_CODES["7131"]["program"] = "PSS"
		TITLE_CODES["7131"]["unit"] = "99"

	TITLE_CODES["3024"] = {}
		TITLE_CODES["3024"]["title"] = "ASST SPECIALIST IN THE A.E.S."
		TITLE_CODES["3024"]["program"] = "ACADEMIC"
		TITLE_CODES["3024"]["unit"] = "FX"

	TITLE_CODES["9093"] = {}
		TITLE_CODES["9093"]["title"] = "TECHNO, POLYSMNOGRAPHY,TRAINEE"
		TITLE_CODES["9093"]["program"] = "PSS"
		TITLE_CODES["9093"]["unit"] = "EX"

	TITLE_CODES["5419"] = {}
		TITLE_CODES["5419"]["title"] = "DIETETIC TECH, REGISTERED"
		TITLE_CODES["5419"]["program"] = "PSS"
		TITLE_CODES["5419"]["unit"] = "EX"

	TITLE_CODES["3021"] = {}
		TITLE_CODES["3021"]["title"] = "ASST ----- IN THE A.E.S.SFT-VM"
		TITLE_CODES["3021"]["program"] = "ACADEMIC"
		TITLE_CODES["3021"]["unit"] = "FX"

	TITLE_CODES["3020"] = {}
		TITLE_CODES["3020"]["title"] = "ASST ----- IN THE A.E.S."
		TITLE_CODES["3020"]["program"] = "ACADEMIC"
		TITLE_CODES["3020"]["unit"] = "FX"

	TITLE_CODES["1403"] = {}
		TITLE_CODES["1403"]["title"] = "INSTRUCTOR-ACAD YR -1/9TH PMT"
		TITLE_CODES["1403"]["program"] = "ACADEMIC"
		TITLE_CODES["1403"]["unit"] = "A3"

	TITLE_CODES["1017"] = {}
		TITLE_CODES["1017"]["title"] = "ACTING/INTERIM ASSOCIATE DEAN"
		TITLE_CODES["1017"]["program"] = "ACADEMIC"
		TITLE_CODES["1017"]["unit"] = "99"

	TITLE_CODES["1010"] = {}
		TITLE_CODES["1010"]["title"] = "ASSOCIATE DEAN"
		TITLE_CODES["1010"]["program"] = "ACADEMIC"
		TITLE_CODES["1010"]["unit"] = "99"

	TITLE_CODES["8040"] = {}
		TITLE_CODES["8040"]["title"] = "TECHNO, NUC MED, SR-SUPVR"
		TITLE_CODES["8040"]["program"] = "PSS"
		TITLE_CODES["8040"]["unit"] = "99"

	TITLE_CODES["4214"] = {}
		TITLE_CODES["4214"]["title"] = "INTERVIEWER, PLACEMENT, ASST"
		TITLE_CODES["4214"]["program"] = "PSS"
		TITLE_CODES["4214"]["unit"] = "99"

	TITLE_CODES["1230"] = {}
		TITLE_CODES["1230"]["title"] = "ASSOCIATE PROFESSOR - 10-MOS"
		TITLE_CODES["1230"]["program"] = "ACADEMIC"
		TITLE_CODES["1230"]["unit"] = "A3"

	TITLE_CODES["4210"] = {}
		TITLE_CODES["4210"]["title"] = "PLACEMENT OFFICER MANAGER"
		TITLE_CODES["4210"]["program"] = "PSS"
		TITLE_CODES["4210"]["unit"] = "99"

	TITLE_CODES["4213"] = {}
		TITLE_CODES["4213"]["title"] = "INTERVIEWER, PLACEMENT"
		TITLE_CODES["4213"]["program"] = "PSS"
		TITLE_CODES["4213"]["unit"] = "99"

	TITLE_CODES["4212"] = {}
		TITLE_CODES["4212"]["title"] = "INTERVIEWER, PLACEMENT, SR"
		TITLE_CODES["4212"]["program"] = "PSS"
		TITLE_CODES["4212"]["unit"] = "99"

	TITLE_CODES["8048"] = {}
		TITLE_CODES["8048"]["title"] = "OPER ENGINEER, HEAVY EQUIPMENT"
		TITLE_CODES["8048"]["program"] = "PSS"
		TITLE_CODES["8048"]["unit"] = "K3"

	TITLE_CODES["8049"] = {}
		TITLE_CODES["8049"]["title"] = "HVY OFF-RD EQUIP MECH, APPREN"
		TITLE_CODES["8049"]["program"] = "PSS"
		TITLE_CODES["8049"]["unit"] = "K3"

	TITLE_CODES["9396"] = {}
		TITLE_CODES["9396"]["title"] = "TECHNICIAN II, GI ENDOSCOPY,PD"
		TITLE_CODES["9396"]["program"] = "PSS"
		TITLE_CODES["9396"]["unit"] = "EX"

	TITLE_CODES["1330"] = {}
		TITLE_CODES["1330"]["title"] = "ASSISTANT PROFESSOR-10-MONTHS"
		TITLE_CODES["1330"]["program"] = "ACADEMIC"
		TITLE_CODES["1330"]["unit"] = "A3"

	TITLE_CODES["9082"] = {}
		TITLE_CODES["9082"]["title"] = "SERVICE PARTNER, LEAD"
		TITLE_CODES["9082"]["program"] = "PSS"
		TITLE_CODES["9082"]["unit"] = "EX"

	TITLE_CODES["4358"] = {}
		TITLE_CODES["4358"]["title"] = "STUDENT AFF OFF II-SUPERVISING"
		TITLE_CODES["4358"]["program"] = "PSS"
		TITLE_CODES["4358"]["unit"] = "99"

	TITLE_CODES["4359"] = {}
		TITLE_CODES["4359"]["title"] = "STUDENT AFFAIRS OFFICER V-SUP"
		TITLE_CODES["4359"]["program"] = "PSS"
		TITLE_CODES["4359"]["unit"] = "99"

	TITLE_CODES["8280"] = {}
		TITLE_CODES["8280"]["title"] = "CEMENT MASON-FLOORER"
		TITLE_CODES["8280"]["program"] = "PSS"
		TITLE_CODES["8280"]["unit"] = "K3"

	TITLE_CODES["8281"] = {}
		TITLE_CODES["8281"]["title"] = "TECHNICIAN, ACCELER, MECH,PRIN"
		TITLE_CODES["8281"]["program"] = "PSS"
		TITLE_CODES["8281"]["unit"] = "TX"

	TITLE_CODES["4354"] = {}
		TITLE_CODES["4354"]["title"] = "STUDENT AFFAIRS OFFICER I"
		TITLE_CODES["4354"]["program"] = "PSS"
		TITLE_CODES["4354"]["unit"] = "99"

	TITLE_CODES["4355"] = {}
		TITLE_CODES["4355"]["title"] = "STUDENT AFF. OFFICER III"
		TITLE_CODES["4355"]["program"] = "PSS"
		TITLE_CODES["4355"]["unit"] = "99"

	TITLE_CODES["4356"] = {}
		TITLE_CODES["4356"]["title"] = "STUD AFF OFF III - SUPERVISOR"
		TITLE_CODES["4356"]["program"] = "PSS"
		TITLE_CODES["4356"]["unit"] = "99"

	TITLE_CODES["4357"] = {}
		TITLE_CODES["4357"]["title"] = "STUDENT AFF OFF IV SUPERVISOR"
		TITLE_CODES["4357"]["program"] = "PSS"
		TITLE_CODES["4357"]["unit"] = "99"

	TITLE_CODES["4350"] = {}
		TITLE_CODES["4350"]["title"] = "STUDENT AFFAIRS OFFICER SUPV"
		TITLE_CODES["4350"]["program"] = "PSS"
		TITLE_CODES["4350"]["unit"] = "99"

	TITLE_CODES["4351"] = {}
		TITLE_CODES["4351"]["title"] = "STUDENT AFF. OFFICER V"
		TITLE_CODES["4351"]["program"] = "PSS"
		TITLE_CODES["4351"]["unit"] = "99"

	TITLE_CODES["4352"] = {}
		TITLE_CODES["4352"]["title"] = "STUDENT AFF. OFFICER IV"
		TITLE_CODES["4352"]["program"] = "PSS"
		TITLE_CODES["4352"]["unit"] = "99"

	TITLE_CODES["4353"] = {}
		TITLE_CODES["4353"]["title"] = "STUDENT AFFAIRS OFFICER II"
		TITLE_CODES["4353"]["program"] = "PSS"
		TITLE_CODES["4353"]["unit"] = "99"

	TITLE_CODES["3261"] = {}
		TITLE_CODES["3261"]["title"] = "ASSOC PROF IN RESIDENCE- FY"
		TITLE_CODES["3261"]["program"] = "ACADEMIC"
		TITLE_CODES["3261"]["unit"] = "A3"

	TITLE_CODES["7704"] = {}
		TITLE_CODES["7704"]["title"] = "WRITER"
		TITLE_CODES["7704"]["program"] = "PSS"
		TITLE_CODES["7704"]["unit"] = "TX"

	TITLE_CODES["7705"] = {}
		TITLE_CODES["7705"]["title"] = "WRITER, ASST"
		TITLE_CODES["7705"]["program"] = "PSS"
		TITLE_CODES["7705"]["unit"] = "TX"

	TITLE_CODES["7702"] = {}
		TITLE_CODES["7702"]["title"] = "WRITER, SR - SUPERVISOR"
		TITLE_CODES["7702"]["program"] = "PSS"
		TITLE_CODES["7702"]["unit"] = "99"

	TITLE_CODES["7703"] = {}
		TITLE_CODES["7703"]["title"] = "WRITER, SR"
		TITLE_CODES["7703"]["program"] = "PSS"
		TITLE_CODES["7703"]["unit"] = "99"

	TITLE_CODES["3260"] = {}
		TITLE_CODES["3260"]["title"] = "ASSOC PROF IN RESIDENCE- AY"
		TITLE_CODES["3260"]["program"] = "ACADEMIC"
		TITLE_CODES["3260"]["unit"] = "A3"

	TITLE_CODES["33"] = {}
		TITLE_CODES["33"]["title"] = "VICE CHAN (FUNCTIONAL AREA)"
		TITLE_CODES["33"]["program"] = "MSP"
		TITLE_CODES["33"]["unit"] = "99"

	TITLE_CODES["32"] = {}
		TITLE_CODES["32"]["title"] = "VICE CHAN (RESTRICTED USE)"
		TITLE_CODES["32"]["program"] = "MSP"
		TITLE_CODES["32"]["unit"] = "99"

	TITLE_CODES["30"] = {}
		TITLE_CODES["30"]["title"] = "CHANCELLOR"
		TITLE_CODES["30"]["program"] = "MSP"
		TITLE_CODES["30"]["unit"] = "99"

	TITLE_CODES["35"] = {}
		TITLE_CODES["35"]["title"] = "SR VICE CHAN (FUNCTIONAL AREA)"
		TITLE_CODES["35"]["program"] = "MSP"
		TITLE_CODES["35"]["unit"] = "99"

	TITLE_CODES["34"] = {}
		TITLE_CODES["34"]["title"] = "SR VICE CHAN (RESTRICTED USE)"
		TITLE_CODES["34"]["program"] = "MSP"
		TITLE_CODES["34"]["unit"] = "99"

	TITLE_CODES["1537"] = {}
		TITLE_CODES["1537"]["title"] = "ASSISTANT PROFESSOR-GENCOMP-A"
		TITLE_CODES["1537"]["program"] = "ACADEMIC"
		TITLE_CODES["1537"]["unit"] = "A3"

	TITLE_CODES["1243"] = {}
		TITLE_CODES["1243"]["title"] = "ASSOC PROF-AY-BUS/ECON/ENG"
		TITLE_CODES["1243"]["program"] = "ACADEMIC"
		TITLE_CODES["1243"]["unit"] = "A3"

	TITLE_CODES["1534"] = {}
		TITLE_CODES["1534"]["title"] = "VIS INSTRUCTOR-GENCOMP-PTC"
		TITLE_CODES["1534"]["program"] = "ACADEMIC"
		TITLE_CODES["1534"]["unit"] = "99"

	TITLE_CODES["1245"] = {}
		TITLE_CODES["1245"]["title"] = "ASSOC PROF-AY-1/9-BUS/ECON/ENG"
		TITLE_CODES["1245"]["program"] = "ACADEMIC"
		TITLE_CODES["1245"]["unit"] = "A3"

	TITLE_CODES["1244"] = {}
		TITLE_CODES["1244"]["title"] = "ASSOC PROF-FY-BUS/ECON/ENG"
		TITLE_CODES["1244"]["program"] = "ACADEMIC"
		TITLE_CODES["1244"]["unit"] = "A3"

	TITLE_CODES["1531"] = {}
		TITLE_CODES["1531"]["title"] = "VIS PROFESSOR-GENCOMP-PTC"
		TITLE_CODES["1531"]["program"] = "ACADEMIC"
		TITLE_CODES["1531"]["unit"] = "99"

	TITLE_CODES["1246"] = {}
		TITLE_CODES["1246"]["title"] = "ASSOC PROF-AY-BUS/ECON/ENG-REC"
		TITLE_CODES["1246"]["program"] = "ACADEMIC"
		TITLE_CODES["1246"]["unit"] = "A3"

	TITLE_CODES["1248"] = {}
		TITLE_CODES["1248"]["title"] = "ASOC PRO AY-1/9-B/ECON/ENG-REC"
		TITLE_CODES["1248"]["program"] = "ACADEMIC"
		TITLE_CODES["1248"]["unit"] = "A3"

	TITLE_CODES["434"] = {}
		TITLE_CODES["434"]["title"] = "COUNSEL"
		TITLE_CODES["434"]["program"] = "MSP"
		TITLE_CODES["434"]["unit"] = "99"

	TITLE_CODES["435"] = {}
		TITLE_CODES["435"]["title"] = "STAFF COUNSEL"
		TITLE_CODES["435"]["program"] = "MSP"
		TITLE_CODES["435"]["unit"] = "99"

	TITLE_CODES["432"] = {}
		TITLE_CODES["432"]["title"] = "PRINCIPAL COUNSEL"
		TITLE_CODES["432"]["program"] = "MSP"
		TITLE_CODES["432"]["unit"] = "99"

	TITLE_CODES["433"] = {}
		TITLE_CODES["433"]["title"] = "SENIOR COUNSEL"
		TITLE_CODES["433"]["program"] = "MSP"
		TITLE_CODES["433"]["unit"] = "99"

	TITLE_CODES["430"] = {}
		TITLE_CODES["430"]["title"] = "CHIEF HEALTH SCIENCE COUNSEL"
		TITLE_CODES["430"]["program"] = "MSP"
		TITLE_CODES["430"]["unit"] = "99"

	TITLE_CODES["431"] = {}
		TITLE_CODES["431"]["title"] = "MANAGING COUNSEL"
		TITLE_CODES["431"]["program"] = "MSP"
		TITLE_CODES["431"]["unit"] = "99"

	TITLE_CODES["2860"] = {}
		TITLE_CODES["2860"]["title"] = "TUTOR - GSHIP"
		TITLE_CODES["2860"]["program"] = "ACADEMIC"
		TITLE_CODES["2860"]["unit"] = "BX"

	TITLE_CODES["9600"] = {}
		TITLE_CODES["9600"]["title"] = "LABORATORY ASST IV--SUPERVISOR"
		TITLE_CODES["9600"]["program"] = "PSS"
		TITLE_CODES["9600"]["unit"] = "99"

	TITLE_CODES["2861"] = {}
		TITLE_CODES["2861"]["title"] = "TUTOR - NON-GSHIP"
		TITLE_CODES["2861"]["program"] = "ACADEMIC"
		TITLE_CODES["2861"]["unit"] = "BX"

	TITLE_CODES["3804"] = {}
		TITLE_CODES["3804"]["title"] = " ---FISCAL YR - RECALLED-VERIP"
		TITLE_CODES["3804"]["program"] = "ACADEMIC"
		TITLE_CODES["3804"]["unit"] = "99"

	TITLE_CODES["5444"] = {}
		TITLE_CODES["5444"]["title"] = "FOOD SERVICE MANAGER"
		TITLE_CODES["5444"]["program"] = "PSS"
		TITLE_CODES["5444"]["unit"] = "99"

	TITLE_CODES["3266"] = {}
		TITLE_CODES["3266"]["title"] = "GRAD STDNT RES- NO REMISSION"
		TITLE_CODES["3266"]["program"] = "ACADEMIC"
		TITLE_CODES["3266"]["unit"] = "99"

	TITLE_CODES["9105"] = {}
		TITLE_CODES["9105"]["title"] = "RADIATION EQUIP SPECIALIST-SUP"
		TITLE_CODES["9105"]["program"] = "PSS"
		TITLE_CODES["9105"]["unit"] = "99"

	TITLE_CODES["2862"] = {}
		TITLE_CODES["2862"]["title"] = "TUTOR-GSHIP/NON-REP"
		TITLE_CODES["2862"]["program"] = "ACADEMIC"
		TITLE_CODES["2862"]["unit"] = "99"

	TITLE_CODES["3803"] = {}
		TITLE_CODES["3803"]["title"] = " ---ACADEMIC YR-RECALLED-VERIP"
		TITLE_CODES["3803"]["program"] = "ACADEMIC"
		TITLE_CODES["3803"]["unit"] = "99"

	TITLE_CODES["3802"] = {}
		TITLE_CODES["3802"]["title"] = "___ RECALL"
		TITLE_CODES["3802"]["program"] = "ACADEMIC"
		TITLE_CODES["3802"]["unit"] = "99"

	TITLE_CODES["5124"] = {}
		TITLE_CODES["5124"]["title"] = "COOK, PER DIEM, MC"
		TITLE_CODES["5124"]["program"] = "PSS"
		TITLE_CODES["5124"]["unit"] = "SX"

	TITLE_CODES["4103"] = {}
		TITLE_CODES["4103"]["title"] = "CHILD DEVELOPMENT CENTER COORD"
		TITLE_CODES["4103"]["program"] = "PSS"
		TITLE_CODES["4103"]["unit"] = "99"

	TITLE_CODES["2863"] = {}
		TITLE_CODES["2863"]["title"] = "TUTOR-NON-GSHIP/NON-REP"
		TITLE_CODES["2863"]["program"] = "ACADEMIC"
		TITLE_CODES["2863"]["unit"] = "99"

	TITLE_CODES["7612"] = {}
		TITLE_CODES["7612"]["title"] = "ACCOUNTANT I, SUPERVISING"
		TITLE_CODES["7612"]["program"] = "PSS"
		TITLE_CODES["7612"]["unit"] = "99"

	TITLE_CODES["5125"] = {}
		TITLE_CODES["5125"]["title"] = "COOK, SENIOR, MC"
		TITLE_CODES["5125"]["program"] = "PSS"
		TITLE_CODES["5125"]["unit"] = "SX"

	TITLE_CODES["7613"] = {}
		TITLE_CODES["7613"]["title"] = "ACCOUNTANT SUPERVISOR"
		TITLE_CODES["7613"]["program"] = "PSS"
		TITLE_CODES["7613"]["unit"] = "99"

	TITLE_CODES["9497"] = {}
		TITLE_CODES["9497"]["title"] = "THERAPIST, OCCUPATIONAL III"
		TITLE_CODES["9497"]["program"] = "PSS"
		TITLE_CODES["9497"]["unit"] = "99"

	TITLE_CODES["9315"] = {}
		TITLE_CODES["9315"]["title"] = "SOCIAL WORKER, CLINICAL, I"
		TITLE_CODES["9315"]["program"] = "PSS"
		TITLE_CODES["9315"]["unit"] = "HX"

	TITLE_CODES["8192"] = {}
		TITLE_CODES["8192"]["title"] = "STEAMFITTER LEADWORKER"
		TITLE_CODES["8192"]["program"] = "PSS"
		TITLE_CODES["8192"]["unit"] = "K3"

	TITLE_CODES["9314"] = {}
		TITLE_CODES["9314"]["title"] = "SOCIAL WORKER, CLINICAL II"
		TITLE_CODES["9314"]["program"] = "PSS"
		TITLE_CODES["9314"]["unit"] = "HX"

	TITLE_CODES["9393"] = {}
		TITLE_CODES["9393"]["title"] = "PSYCHOMETRIST"
		TITLE_CODES["9393"]["program"] = "PSS"
		TITLE_CODES["9393"]["unit"] = "HX"

	TITLE_CODES["9313"] = {}
		TITLE_CODES["9313"]["title"] = "SOCIAL WORKER, CLINICAL III"
		TITLE_CODES["9313"]["program"] = "PSS"
		TITLE_CODES["9313"]["unit"] = "HX"

	TITLE_CODES["9536"] = {}
		TITLE_CODES["9536"]["title"] = "TECHNICIAN, ANIMAL HEALTH II"
		TITLE_CODES["9536"]["program"] = "PSS"
		TITLE_CODES["9536"]["unit"] = "TX"

	TITLE_CODES["3898"] = {}
		TITLE_CODES["3898"]["title"] = "ACADEMIC UPGRADING FUNDS"
		TITLE_CODES["3898"]["program"] = "ACADEMIC"
		TITLE_CODES["3898"]["unit"] = "87"

	TITLE_CODES["9311"] = {}
		TITLE_CODES["9311"]["title"] = "SOCIAL WORKER,CLN,ASSOC CHIEF"
		TITLE_CODES["9311"]["program"] = "PSS"
		TITLE_CODES["9311"]["unit"] = "99"

	TITLE_CODES["7618"] = {}
		TITLE_CODES["7618"]["title"] = "ACCOUNTANT I"
		TITLE_CODES["7618"]["program"] = "PSS"
		TITLE_CODES["7618"]["unit"] = "99"

	TITLE_CODES["8357"] = {}
		TITLE_CODES["8357"]["title"] = "LEAD ALARM ELECTRICIAN"
		TITLE_CODES["8357"]["program"] = "PSS"
		TITLE_CODES["8357"]["unit"] = "K3"

	TITLE_CODES["3897"] = {}
		TITLE_CODES["3897"]["title"] = "FACULTY RECHARGE GROUP"
		TITLE_CODES["3897"]["program"] = "ACADEMIC"
		TITLE_CODES["3897"]["unit"] = "87"

	TITLE_CODES["8956"] = {}
		TITLE_CODES["8956"]["title"] = "SCIENTIST,CLIN LAB,PER DIEM"
		TITLE_CODES["8956"]["program"] = "PSS"
		TITLE_CODES["8956"]["unit"] = "HX"

	TITLE_CODES["9392"] = {}
		TITLE_CODES["9392"]["title"] = "PSYCHOMETRIST, SR"
		TITLE_CODES["9392"]["program"] = "PSS"
		TITLE_CODES["9392"]["unit"] = "HX"

	TITLE_CODES["9165"] = {}
		TITLE_CODES["9165"]["title"] = "OR ASSISTANT I"
		TITLE_CODES["9165"]["program"] = "PSS"
		TITLE_CODES["9165"]["unit"] = "EX"

	TITLE_CODES["7273"] = {}
		TITLE_CODES["7273"]["title"] = "PROGRAMMER VIII - SUPV"
		TITLE_CODES["7273"]["program"] = "PSS"
		TITLE_CODES["7273"]["unit"] = "99"

	TITLE_CODES["8954"] = {}
		TITLE_CODES["8954"]["title"] = "CYTOTECHNOLOGIST, SENIOR"
		TITLE_CODES["8954"]["program"] = "PSS"
		TITLE_CODES["8954"]["unit"] = "HX"

	TITLE_CODES["9296"] = {}
		TITLE_CODES["9296"]["title"] = "CERT PHLEBOTOMY TECHNICIAN-SUP"
		TITLE_CODES["9296"]["program"] = "PSS"
		TITLE_CODES["9296"]["unit"] = "99"

	TITLE_CODES["6100"] = {}
		TITLE_CODES["6100"]["title"] = "ARTIST, SR-SUPVR"
		TITLE_CODES["6100"]["program"] = "PSS"
		TITLE_CODES["6100"]["unit"] = "99"

	TITLE_CODES["7193"] = {}
		TITLE_CODES["7193"]["title"] = "DATA PROC PROD COORDINATOR"
		TITLE_CODES["7193"]["program"] = "PSS"
		TITLE_CODES["7193"]["unit"] = "CX"

	TITLE_CODES["4774"] = {}
		TITLE_CODES["4774"]["title"] = "KEY ENTRY OPERATOR, ASST"
		TITLE_CODES["4774"]["program"] = "PSS"
		TITLE_CODES["4774"]["unit"] = "CX"

	TITLE_CODES["7271"] = {}
		TITLE_CODES["7271"]["title"] = "ANALYST VII"
		TITLE_CODES["7271"]["program"] = "PSS"
		TITLE_CODES["7271"]["unit"] = "99"

	TITLE_CODES["4772"] = {}
		TITLE_CODES["4772"]["title"] = "KEY ENTRY OPERATOR, LEAD"
		TITLE_CODES["4772"]["program"] = "PSS"
		TITLE_CODES["4772"]["unit"] = "CX"

	TITLE_CODES["4773"] = {}
		TITLE_CODES["4773"]["title"] = "KEY ENTRY OPERATOR"
		TITLE_CODES["4773"]["program"] = "PSS"
		TITLE_CODES["4773"]["unit"] = "CX"

	TITLE_CODES["4770"] = {}
		TITLE_CODES["4770"]["title"] = "KEY ENTRY SUPVR II"
		TITLE_CODES["4770"]["program"] = "PSS"
		TITLE_CODES["4770"]["unit"] = "99"

	TITLE_CODES["4771"] = {}
		TITLE_CODES["4771"]["title"] = "KEY ENTRY SUPVR I"
		TITLE_CODES["4771"]["program"] = "PSS"
		TITLE_CODES["4771"]["unit"] = "99"

	TITLE_CODES["7276"] = {}
		TITLE_CODES["7276"]["title"] = "PROGRAMMER/ANALYST II-SUPVR"
		TITLE_CODES["7276"]["program"] = "PSS"
		TITLE_CODES["7276"]["unit"] = "99"

	TITLE_CODES["7191"] = {}
		TITLE_CODES["7191"]["title"] = "DATA PROC PROD COORDINATO,PRIN"
		TITLE_CODES["7191"]["program"] = "PSS"
		TITLE_CODES["7191"]["unit"] = "CX"

	TITLE_CODES["7137"] = {}
		TITLE_CODES["7137"]["title"] = "EH&S SPECIALIST II SUPERVISOR"
		TITLE_CODES["7137"]["program"] = "PSS"
		TITLE_CODES["7137"]["unit"] = "99"

	TITLE_CODES["7277"] = {}
		TITLE_CODES["7277"]["title"] = "PROGRAMMER/ANALYST II"
		TITLE_CODES["7277"]["program"] = "PSS"
		TITLE_CODES["7277"]["unit"] = "99"

	TITLE_CODES["6758"] = {}
		TITLE_CODES["6758"]["title"] = "LIBRARY ASSISTANT V"
		TITLE_CODES["6758"]["program"] = "PSS"
		TITLE_CODES["6758"]["unit"] = "99"

	TITLE_CODES["6759"] = {}
		TITLE_CODES["6759"]["title"] = "LIBRARY ASST IV"
		TITLE_CODES["6759"]["program"] = "PSS"
		TITLE_CODES["6759"]["unit"] = "CX"

	TITLE_CODES["3461"] = {}
		TITLE_CODES["3461"]["title"] = "ASST COOP EXT ADVISOR"
		TITLE_CODES["3461"]["program"] = "ACADEMIC"
		TITLE_CODES["3461"]["unit"] = "FX"

	TITLE_CODES["7275"] = {}
		TITLE_CODES["7275"]["title"] = "PROGRAMMER/ANALYST III"
		TITLE_CODES["7275"]["program"] = "PSS"
		TITLE_CODES["7275"]["unit"] = "99"

	TITLE_CODES["6757"] = {}
		TITLE_CODES["6757"]["title"] = "LIBRARY ASST V - SUPERVISOR"
		TITLE_CODES["6757"]["program"] = "PSS"
		TITLE_CODES["6757"]["unit"] = "99"

	TITLE_CODES["7196"] = {}
		TITLE_CODES["7196"]["title"] = "DATA PROC PROD COORD, SR-SUPVR"
		TITLE_CODES["7196"]["program"] = "PSS"
		TITLE_CODES["7196"]["unit"] = "99"

	TITLE_CODES["7195"] = {}
		TITLE_CODES["7195"]["title"] = "DATA PROC PROD-COORD, PR-SUPVR"
		TITLE_CODES["7195"]["program"] = "PSS"
		TITLE_CODES["7195"]["unit"] = "99"

	TITLE_CODES["5811"] = {}
		TITLE_CODES["5811"]["title"] = "LAUNDRY/LINEN SERVICE MANAGER"
		TITLE_CODES["5811"]["program"] = "PSS"
		TITLE_CODES["5811"]["unit"] = "99"

	TITLE_CODES["7136"] = {}
		TITLE_CODES["7136"]["title"] = "EH&S SPECIALIST III SUPERVISOR"
		TITLE_CODES["7136"]["program"] = "PSS"
		TITLE_CODES["7136"]["unit"] = "99"

	TITLE_CODES["7278"] = {}
		TITLE_CODES["7278"]["title"] = "PROGRAMMER/ANALYST I"
		TITLE_CODES["7278"]["program"] = "PSS"
		TITLE_CODES["7278"]["unit"] = "99"

	TITLE_CODES["5816"] = {}
		TITLE_CODES["5816"]["title"] = "LINEN SERVICE, SUPVR"
		TITLE_CODES["5816"]["program"] = "PSS"
		TITLE_CODES["5816"]["unit"] = "99"

	TITLE_CODES["7170"] = {}
		TITLE_CODES["7170"]["title"] = "TECHNICIAN, DEVELOPMENT, V"
		TITLE_CODES["7170"]["program"] = "PSS"
		TITLE_CODES["7170"]["unit"] = "TX"

	TITLE_CODES["9167"] = {}
		TITLE_CODES["9167"]["title"] = "OR ASSISTANT, PER DIEM"
		TITLE_CODES["9167"]["program"] = "PSS"
		TITLE_CODES["9167"]["unit"] = "EX"

	TITLE_CODES["9995"] = {}
		TITLE_CODES["9995"]["title"] = "UNCLASSIFIED"
		TITLE_CODES["9995"]["program"] = "PSS"
		TITLE_CODES["9995"]["unit"] = "99"

	TITLE_CODES["5080"] = {}
		TITLE_CODES["5080"]["title"] = "STOREKEEPER, ASST, MC"
		TITLE_CODES["5080"]["program"] = "PSS"
		TITLE_CODES["5080"]["unit"] = "SX"

	TITLE_CODES["9720"] = {}
		TITLE_CODES["9720"]["title"] = "SCIENTIST, MUSEUM, SR-SUPVR"
		TITLE_CODES["9720"]["program"] = "PSS"
		TITLE_CODES["9720"]["unit"] = "99"

	TITLE_CODES["7173"] = {}
		TITLE_CODES["7173"]["title"] = "TECHNICIAN, DEVELOPMENT, II"
		TITLE_CODES["7173"]["program"] = "PSS"
		TITLE_CODES["7173"]["unit"] = "TX"

	TITLE_CODES["9533"] = {}
		TITLE_CODES["9533"]["title"] = "VETERINARIAN (LAM), ASST"
		TITLE_CODES["9533"]["program"] = "PSS"
		TITLE_CODES["9533"]["unit"] = "99"

	TITLE_CODES["3639"] = {}
		TITLE_CODES["3639"]["title"] = "ASSOCIATE LAW LIBRARIAN"
		TITLE_CODES["3639"]["program"] = "ACADEMIC"
		TITLE_CODES["3639"]["unit"] = "99"

	TITLE_CODES["3637"] = {}
		TITLE_CODES["3637"]["title"] = "ASSISTANT LAW LIBRARIAN"
		TITLE_CODES["3637"]["program"] = "ACADEMIC"
		TITLE_CODES["3637"]["unit"] = "99"

	TITLE_CODES["3635"] = {}
		TITLE_CODES["3635"]["title"] = "LAW LIBRARIAN"
		TITLE_CODES["3635"]["program"] = "ACADEMIC"
		TITLE_CODES["3635"]["unit"] = "99"

	TITLE_CODES["9272"] = {}
		TITLE_CODES["9272"]["title"] = "TECHNICIAN,PATIENT DIALYSI, I"
		TITLE_CODES["9272"]["program"] = "PSS"
		TITLE_CODES["9272"]["unit"] = "EX"

	TITLE_CODES["5086"] = {}
		TITLE_CODES["5086"]["title"] = "CUSTODIAN, SENIOR, MC"
		TITLE_CODES["5086"]["program"] = "PSS"
		TITLE_CODES["5086"]["unit"] = "SX"

	TITLE_CODES["4610"] = {}
		TITLE_CODES["4610"]["title"] = "CASHIERS OFFICE MANAGER"
		TITLE_CODES["4610"]["program"] = "PSS"
		TITLE_CODES["4610"]["unit"] = "99"

	TITLE_CODES["2709"] = {}
		TITLE_CODES["2709"]["title"] = "RESIDENT PHYSICIAN I/REP"
		TITLE_CODES["2709"]["program"] = "ACADEMIC"
		TITLE_CODES["2709"]["unit"] = "M3"

	TITLE_CODES["9160"] = {}
		TITLE_CODES["9160"]["title"] = "NURSE PRACTITIONER-PER DIEM"
		TITLE_CODES["9160"]["program"] = "PSS"
		TITLE_CODES["9160"]["unit"] = "NX"

	TITLE_CODES["2708"] = {}
		TITLE_CODES["2708"]["title"] = "RESIDENT PHYSICIAN I/NON-REP"
		TITLE_CODES["2708"]["program"] = "ACADEMIC"
		TITLE_CODES["2708"]["unit"] = "99"

	TITLE_CODES["9994"] = {}
		TITLE_CODES["9994"]["title"] = "UNCLASSIFIED A&PS 7"
		TITLE_CODES["9994"]["program"] = "PSS"
		TITLE_CODES["9994"]["unit"] = "99"

	TITLE_CODES["7675"] = {}
		TITLE_CODES["7675"]["title"] = "PROGRAM PROMOTION MANAGER II"
		TITLE_CODES["7675"]["program"] = "PSS"
		TITLE_CODES["7675"]["unit"] = "99"

	TITLE_CODES["6109"] = {}
		TITLE_CODES["6109"]["title"] = "SR PRODUCER DIRECTOR - SUPVR"
		TITLE_CODES["6109"]["program"] = "PSS"
		TITLE_CODES["6109"]["unit"] = "99"

	TITLE_CODES["6108"] = {}
		TITLE_CODES["6108"]["title"] = "PR PRODUCER DIRECTOR - SUPVR"
		TITLE_CODES["6108"]["program"] = "PSS"
		TITLE_CODES["6108"]["unit"] = "99"

	TITLE_CODES["6107"] = {}
		TITLE_CODES["6107"]["title"] = "ART MODEL"
		TITLE_CODES["6107"]["program"] = "PSS"
		TITLE_CODES["6107"]["unit"] = "TX"

	TITLE_CODES["9277"] = {}
		TITLE_CODES["9277"]["title"] = "COUNSELOR, VOCATIONAL REHAB"
		TITLE_CODES["9277"]["program"] = "PSS"
		TITLE_CODES["9277"]["unit"] = "99"

	TITLE_CODES["2222"] = {}
		TITLE_CODES["2222"]["title"] = "SUPERVISOR OF TEACHER ED-FY"
		TITLE_CODES["2222"]["program"] = "ACADEMIC"
		TITLE_CODES["2222"]["unit"] = "IX"

	TITLE_CODES["2223"] = {}
		TITLE_CODES["2223"]["title"] = "SUP OF TEACH.EDU-FY-CONTINUING"
		TITLE_CODES["2223"]["program"] = "ACADEMIC"
		TITLE_CODES["2223"]["unit"] = "IX"

	TITLE_CODES["2220"] = {}
		TITLE_CODES["2220"]["title"] = "SUPERVISOR OF TEACHER ED-AY"
		TITLE_CODES["2220"]["program"] = "ACADEMIC"
		TITLE_CODES["2220"]["unit"] = "IX"

	TITLE_CODES["2221"] = {}
		TITLE_CODES["2221"]["title"] = "SUP OF TEACH.ED-AY-CONTINUING"
		TITLE_CODES["2221"]["program"] = "ACADEMIC"
		TITLE_CODES["2221"]["unit"] = "IX"

	TITLE_CODES["1"] = {}
		TITLE_CODES["1"]["title"] = "PRESIDENT OF THE UNIVERSITY"
		TITLE_CODES["1"]["program"] = "MSP"
		TITLE_CODES["1"]["unit"] = "99"

	TITLE_CODES["8639"] = {}
		TITLE_CODES["8639"]["title"] = "TECHNICIAN,DEV,SUPVR-IV,MED FA"
		TITLE_CODES["8639"]["program"] = "PSS"
		TITLE_CODES["8639"]["unit"] = "99"

	TITLE_CODES["9279"] = {}
		TITLE_CODES["9279"]["title"] = "PHARMACY TECHNICIAN I, P.D."
		TITLE_CODES["9279"]["program"] = "PSS"
		TITLE_CODES["9279"]["unit"] = "EX"

	TITLE_CODES["9604"] = {}
		TITLE_CODES["9604"]["title"] = "LABORATORY ASST III - SUPVR"
		TITLE_CODES["9604"]["program"] = "PSS"
		TITLE_CODES["9604"]["unit"] = "99"

	TITLE_CODES["9161"] = {}
		TITLE_CODES["9161"]["title"] = "OR EQUIPMENT SPECIALIST I"
		TITLE_CODES["9161"]["program"] = "PSS"
		TITLE_CODES["9161"]["unit"] = "EX"

	TITLE_CODES["9119"] = {}
		TITLE_CODES["9119"]["title"] = "NURSE, PER DIEM"
		TITLE_CODES["9119"]["program"] = "PSS"
		TITLE_CODES["9119"]["unit"] = "NX"

	TITLE_CODES["9118"] = {}
		TITLE_CODES["9118"]["title"] = "HOME HEALTH NURSE I"
		TITLE_CODES["9118"]["program"] = "PSS"
		TITLE_CODES["9118"]["unit"] = "NX"

	TITLE_CODES["145"] = {}
		TITLE_CODES["145"]["title"] = "EXEC ASST TO THE CHANCELLOR"
		TITLE_CODES["145"]["program"] = "MSP"
		TITLE_CODES["145"]["unit"] = "99"

	TITLE_CODES["7679"] = {}
		TITLE_CODES["7679"]["title"] = "PUBLICATIONS MANAGER"
		TITLE_CODES["7679"]["program"] = "PSS"
		TITLE_CODES["7679"]["unit"] = "99"

	TITLE_CODES["140"] = {}
		TITLE_CODES["140"]["title"] = "ASST CHAN (FUNCTIONAL AREA)"
		TITLE_CODES["140"]["program"] = "MSP"
		TITLE_CODES["140"]["unit"] = "99"

	TITLE_CODES["9111"] = {}
		TITLE_CODES["9111"]["title"] = "COORDINATOR, TRANSPLANT II"
		TITLE_CODES["9111"]["program"] = "PSS"
		TITLE_CODES["9111"]["unit"] = "NX"

	TITLE_CODES["9110"] = {}
		TITLE_CODES["9110"]["title"] = "COORDINATOR, TRANSPLANT I"
		TITLE_CODES["9110"]["program"] = "PSS"
		TITLE_CODES["9110"]["unit"] = "NX"

	TITLE_CODES["9112"] = {}
		TITLE_CODES["9112"]["title"] = "CHIEF DOSIMETRIST"
		TITLE_CODES["9112"]["program"] = "PSS"
		TITLE_CODES["9112"]["unit"] = "99"

	TITLE_CODES["9007"] = {}
		TITLE_CODES["9007"]["title"] = "DOSIMETRIST, SR"
		TITLE_CODES["9007"]["program"] = "PSS"
		TITLE_CODES["9007"]["unit"] = "EX"

	TITLE_CODES["9114"] = {}
		TITLE_CODES["9114"]["title"] = "HOME HEALTH NURSE, PER DIEM"
		TITLE_CODES["9114"]["program"] = "PSS"
		TITLE_CODES["9114"]["unit"] = "NX"

	TITLE_CODES["8546"] = {}
		TITLE_CODES["8546"]["title"] = "TECHNICIAN, AGRICUL, SR-SUPVR"
		TITLE_CODES["8546"]["program"] = "PSS"
		TITLE_CODES["8546"]["unit"] = "99"

	TITLE_CODES["5068"] = {}
		TITLE_CODES["5068"]["title"] = "STOREKEEPER, SR-SUPVR"
		TITLE_CODES["5068"]["program"] = "PSS"
		TITLE_CODES["5068"]["unit"] = "99"

	TITLE_CODES["7151"] = {}
		TITLE_CODES["7151"]["title"] = "ENGINEER, ASSISTANT - SUPVR"
		TITLE_CODES["7151"]["program"] = "PSS"
		TITLE_CODES["7151"]["unit"] = "99"

	TITLE_CODES["1889"] = {}
		TITLE_CODES["1889"]["title"] = "ASSOC ADJUNCT PROFESSOR-SFT-PC"
		TITLE_CODES["1889"]["program"] = "ACADEMIC"
		TITLE_CODES["1889"]["unit"] = "99"

	TITLE_CODES["1888"] = {}
		TITLE_CODES["1888"]["title"] = "ASST ADJUNCT PROFESSOR-SFT-PC"
		TITLE_CODES["1888"]["program"] = "ACADEMIC"
		TITLE_CODES["1888"]["unit"] = "99"

	TITLE_CODES["1887"] = {}
		TITLE_CODES["1887"]["title"] = "ADJUNCT INSTRUCTOR-SFT-PC"
		TITLE_CODES["1887"]["program"] = "ACADEMIC"
		TITLE_CODES["1887"]["unit"] = "99"

	TITLE_CODES["1886"] = {}
		TITLE_CODES["1886"]["title"] = "PROF IN RESIDENCE-SFT-PC"
		TITLE_CODES["1886"]["program"] = "ACADEMIC"
		TITLE_CODES["1886"]["unit"] = "A3"

	TITLE_CODES["1885"] = {}
		TITLE_CODES["1885"]["title"] = "ASSOC PROF IN RESIDENCE-SFT-PC"
		TITLE_CODES["1885"]["program"] = "ACADEMIC"
		TITLE_CODES["1885"]["unit"] = "A3"

	TITLE_CODES["1884"] = {}
		TITLE_CODES["1884"]["title"] = "ASST PROF IN RESIDENCE-SFT-PC"
		TITLE_CODES["1884"]["program"] = "ACADEMIC"
		TITLE_CODES["1884"]["unit"] = "A3"

	TITLE_CODES["1883"] = {}
		TITLE_CODES["1883"]["title"] = "INSTR IN RESIDENCE-SFT-PC"
		TITLE_CODES["1883"]["program"] = "ACADEMIC"
		TITLE_CODES["1883"]["unit"] = "A3"

	TITLE_CODES["1882"] = {}
		TITLE_CODES["1882"]["title"] = "ACTING PROFESSOR-SFT-PC"
		TITLE_CODES["1882"]["program"] = "ACADEMIC"
		TITLE_CODES["1882"]["unit"] = "A3"

	TITLE_CODES["1881"] = {}
		TITLE_CODES["1881"]["title"] = "PROFESSOR-SFT-PC"
		TITLE_CODES["1881"]["program"] = "ACADEMIC"
		TITLE_CODES["1881"]["unit"] = "A3"

	TITLE_CODES["1880"] = {}
		TITLE_CODES["1880"]["title"] = "ACTING ASSOC PROFESSOR-SFT-PC"
		TITLE_CODES["1880"]["program"] = "ACADEMIC"
		TITLE_CODES["1880"]["unit"] = "A3"

	TITLE_CODES["2120"] = {}
		TITLE_CODES["2120"]["title"] = "ASSOC SUPRVSR OF PHYS ED - AY"
		TITLE_CODES["2120"]["program"] = "ACADEMIC"
		TITLE_CODES["2120"]["unit"] = "99"

	TITLE_CODES["4668"] = {}
		TITLE_CODES["4668"]["title"] = "BILLER, PATIENT I, PER DIEM"
		TITLE_CODES["4668"]["program"] = "PSS"
		TITLE_CODES["4668"]["unit"] = "EX"

	TITLE_CODES["3371"] = {}
		TITLE_CODES["3371"]["title"] = "ASST ADJ PROF-AY-BUS/ECON/ENG"
		TITLE_CODES["3371"]["program"] = "ACADEMIC"
		TITLE_CODES["3371"]["unit"] = "99"

	TITLE_CODES["8131"] = {}
		TITLE_CODES["8131"]["title"] = "GROUNDS SUPVR"
		TITLE_CODES["8131"]["program"] = "PSS"
		TITLE_CODES["8131"]["unit"] = "99"

	TITLE_CODES["4919"] = {}
		TITLE_CODES["4919"]["title"] = "ASSISTANT IV"
		TITLE_CODES["4919"]["program"] = "PSS"
		TITLE_CODES["4919"]["unit"] = "99"

	TITLE_CODES["4664"] = {}
		TITLE_CODES["4664"]["title"] = "BILLER, PATIENT II"
		TITLE_CODES["4664"]["program"] = "PSS"
		TITLE_CODES["4664"]["unit"] = "EX"

	TITLE_CODES["4665"] = {}
		TITLE_CODES["4665"]["title"] = "BILLER, PATIENT I"
		TITLE_CODES["4665"]["program"] = "PSS"
		TITLE_CODES["4665"]["unit"] = "EX"

	TITLE_CODES["2080"] = {}
		TITLE_CODES["2080"]["title"] = "CLIN ASSOCIATE IN ____-ACAD YR"
		TITLE_CODES["2080"]["program"] = "ACADEMIC"
		TITLE_CODES["2080"]["unit"] = "99"

	TITLE_CODES["2081"] = {}
		TITLE_CODES["2081"]["title"] = "CLIN ASSOCIATE IN ____- FY"
		TITLE_CODES["2081"]["program"] = "ACADEMIC"
		TITLE_CODES["2081"]["unit"] = "99"

	TITLE_CODES["4660"] = {}
		TITLE_CODES["4660"]["title"] = "BILLER, PATIENT V"
		TITLE_CODES["4660"]["program"] = "PSS"
		TITLE_CODES["4660"]["unit"] = "99"

	TITLE_CODES["4661"] = {}
		TITLE_CODES["4661"]["title"] = "BILLER, PATIENT IV-SUPV"
		TITLE_CODES["4661"]["program"] = "PSS"
		TITLE_CODES["4661"]["unit"] = "99"

	TITLE_CODES["4662"] = {}
		TITLE_CODES["4662"]["title"] = "BILLER, PATIENT IV"
		TITLE_CODES["4662"]["program"] = "PSS"
		TITLE_CODES["4662"]["unit"] = "EX"

	TITLE_CODES["4663"] = {}
		TITLE_CODES["4663"]["title"] = "BILLER, PATIENT III"
		TITLE_CODES["4663"]["program"] = "PSS"
		TITLE_CODES["4663"]["unit"] = "EX"

	TITLE_CODES["3402"] = {}
		TITLE_CODES["3402"]["title"] = "VST COOP EXT SPECIALIST"
		TITLE_CODES["3402"]["program"] = "ACADEMIC"
		TITLE_CODES["3402"]["unit"] = "99"

	TITLE_CODES["5451"] = {}
		TITLE_CODES["5451"]["title"] = "FOOD SERVICE SUPV, SR"
		TITLE_CODES["5451"]["program"] = "PSS"
		TITLE_CODES["5451"]["unit"] = "99"

	TITLE_CODES["5452"] = {}
		TITLE_CODES["5452"]["title"] = "FOOD SERVICE WORKER, LEAD"
		TITLE_CODES["5452"]["program"] = "PSS"
		TITLE_CODES["5452"]["unit"] = "SX"

	TITLE_CODES["9115"] = {}
		TITLE_CODES["9115"]["title"] = "HOME HEALTH NURSE IV"
		TITLE_CODES["9115"]["program"] = "PSS"
		TITLE_CODES["9115"]["unit"] = "99"

	TITLE_CODES["9204"] = {}
		TITLE_CODES["9204"]["title"] = "PHYSICIAN ASSISTANT, PER DIEM"
		TITLE_CODES["9204"]["program"] = "PSS"
		TITLE_CODES["9204"]["unit"] = "HX"

	TITLE_CODES["2711"] = {}
		TITLE_CODES["2711"]["title"] = "INTERN-PHARMACY/NON-REP"
		TITLE_CODES["2711"]["program"] = "ACADEMIC"
		TITLE_CODES["2711"]["unit"] = "99"

	TITLE_CODES["8491"] = {}
		TITLE_CODES["8491"]["title"] = "AUTO EQUIP OP. SR, PER DIEM"
		TITLE_CODES["8491"]["program"] = "PSS"
		TITLE_CODES["8491"]["unit"] = "SX"

	TITLE_CODES["2714"] = {}
		TITLE_CODES["2714"]["title"] = "INTERN-VET MEDICINE/NON-REP"
		TITLE_CODES["2714"]["program"] = "ACADEMIC"
		TITLE_CODES["2714"]["unit"] = "99"

	TITLE_CODES["9202"] = {}
		TITLE_CODES["9202"]["title"] = "PHYSICIAN ASSISTANT, SENIOR"
		TITLE_CODES["9202"]["program"] = "PSS"
		TITLE_CODES["9202"]["unit"] = "HX"

	TITLE_CODES["9005"] = {}
		TITLE_CODES["9005"]["title"] = "TECHNOLOGIST,NUCL MED, TRAINEE"
		TITLE_CODES["9005"]["program"] = "PSS"
		TITLE_CODES["9005"]["unit"] = "HX"

	TITLE_CODES["6103"] = {}
		TITLE_CODES["6103"]["title"] = "ARTIST"
		TITLE_CODES["6103"]["program"] = "PSS"
		TITLE_CODES["6103"]["unit"] = "TX"

	TITLE_CODES["2651"] = {}
		TITLE_CODES["2651"]["title"] = "TEACHER-LAWR.HALL-CONTINUING"
		TITLE_CODES["2651"]["program"] = "ACADEMIC"
		TITLE_CODES["2651"]["unit"] = "IX"

	TITLE_CODES["2650"] = {}
		TITLE_CODES["2650"]["title"] = "TEACHER-LAWRENCE HALL OF SCI"
		TITLE_CODES["2650"]["program"] = "ACADEMIC"
		TITLE_CODES["2650"]["unit"] = "IX"

	TITLE_CODES["6102"] = {}
		TITLE_CODES["6102"]["title"] = "ARTIST, SR"
		TITLE_CODES["6102"]["program"] = "PSS"
		TITLE_CODES["6102"]["unit"] = "TX"

	TITLE_CODES["8985"] = {}
		TITLE_CODES["8985"]["title"] = "HOSP. LAB. TECH. II, P.D."
		TITLE_CODES["8985"]["program"] = "PSS"
		TITLE_CODES["8985"]["unit"] = "EX"

	TITLE_CODES["8984"] = {}
		TITLE_CODES["8984"]["title"] = "HOSP. LAB. TECH. III, P.D."
		TITLE_CODES["8984"]["program"] = "PSS"
		TITLE_CODES["8984"]["unit"] = "EX"

	TITLE_CODES["5078"] = {}
		TITLE_CODES["5078"]["title"] = "STORES WORKER, MC"
		TITLE_CODES["5078"]["program"] = "PSS"
		TITLE_CODES["5078"]["unit"] = "SX"

	TITLE_CODES["130"] = {}
		TITLE_CODES["130"]["title"] = "SPECIAL ASST TO THE PRESIDENT"
		TITLE_CODES["130"]["program"] = "MSP"
		TITLE_CODES["130"]["unit"] = "99"

	TITLE_CODES["3412"] = {}
		TITLE_CODES["3412"]["title"] = "VST ASSOC COOP EXT SPECIALIST"
		TITLE_CODES["3412"]["program"] = "ACADEMIC"
		TITLE_CODES["3412"]["unit"] = "99"

	TITLE_CODES["6101"] = {}
		TITLE_CODES["6101"]["title"] = "ARTIST, PRIN"
		TITLE_CODES["6101"]["program"] = "PSS"
		TITLE_CODES["6101"]["unit"] = "99"

	TITLE_CODES["7161"] = {}
		TITLE_CODES["7161"]["title"] = "ENGINEERING AID, PRIN"
		TITLE_CODES["7161"]["program"] = "PSS"
		TITLE_CODES["7161"]["unit"] = "TX"

	TITLE_CODES["8982"] = {}
		TITLE_CODES["8982"]["title"] = "ORTHOPTIST, SR"
		TITLE_CODES["8982"]["program"] = "PSS"
		TITLE_CODES["8982"]["unit"] = "HX"

	TITLE_CODES["5072"] = {}
		TITLE_CODES["5072"]["title"] = "ENVIRON SERV WORKER II, PD, MC"
		TITLE_CODES["5072"]["program"] = "PSS"
		TITLE_CODES["5072"]["unit"] = "SX"

	TITLE_CODES["5073"] = {}
		TITLE_CODES["5073"]["title"] = "ENVIRON SERV WORKER I, MC"
		TITLE_CODES["5073"]["program"] = "PSS"
		TITLE_CODES["5073"]["unit"] = "SX"

	TITLE_CODES["139"] = {}
		TITLE_CODES["139"]["title"] = "ASSOCIATE CHANCELLOR (FCT AR)"
		TITLE_CODES["139"]["program"] = "MSP"
		TITLE_CODES["139"]["unit"] = "99"

	TITLE_CODES["5071"] = {}
		TITLE_CODES["5071"]["title"] = "STORES SUPVR"
		TITLE_CODES["5071"]["program"] = "PSS"
		TITLE_CODES["5071"]["unit"] = "99"

	TITLE_CODES["5076"] = {}
		TITLE_CODES["5076"]["title"] = "STOREKEEPER, LEAD, MC"
		TITLE_CODES["5076"]["program"] = "PSS"
		TITLE_CODES["5076"]["unit"] = "SX"

	TITLE_CODES["5077"] = {}
		TITLE_CODES["5077"]["title"] = "STOREKEEPER, SENIOR, MC"
		TITLE_CODES["5077"]["program"] = "PSS"
		TITLE_CODES["5077"]["unit"] = "SX"

	TITLE_CODES["5074"] = {}
		TITLE_CODES["5074"]["title"] = "ENVIRON SERV WORKER II, MC"
		TITLE_CODES["5074"]["program"] = "PSS"
		TITLE_CODES["5074"]["unit"] = "SX"

	TITLE_CODES["9163"] = {}
		TITLE_CODES["9163"]["title"] = "OR EQUIPMENT SUPERVISOR"
		TITLE_CODES["9163"]["program"] = "PSS"
		TITLE_CODES["9163"]["unit"] = "99"

	TITLE_CODES["8021"] = {}
		TITLE_CODES["8021"]["title"] = "PSYCHOLOGIST II-SUPVR"
		TITLE_CODES["8021"]["program"] = "PSS"
		TITLE_CODES["8021"]["unit"] = "99"

	TITLE_CODES["3090"] = {}
		TITLE_CODES["3090"]["title"] = "JR---IN THE AES-ACADEMIC YEAR"
		TITLE_CODES["3090"]["program"] = "ACADEMIC"
		TITLE_CODES["3090"]["unit"] = "FX"

	TITLE_CODES["9133"] = {}
		TITLE_CODES["9133"]["title"] = "NURSE, ADMINISTRATIVE II"
		TITLE_CODES["9133"]["program"] = "PSS"
		TITLE_CODES["9133"]["unit"] = "99"

	TITLE_CODES["9561"] = {}
		TITLE_CODES["9561"]["title"] = "TECHNICIAN, NURSERY, SR"
		TITLE_CODES["9561"]["program"] = "PSS"
		TITLE_CODES["9561"]["unit"] = "SX"

	TITLE_CODES["9562"] = {}
		TITLE_CODES["9562"]["title"] = "TECHNICIAN, NURSERY"
		TITLE_CODES["9562"]["program"] = "PSS"
		TITLE_CODES["9562"]["unit"] = "SX"

	TITLE_CODES["2017"] = {}
		TITLE_CODES["2017"]["title"] = "CLINICAL PROFESSOR-VOLUNTEER"
		TITLE_CODES["2017"]["program"] = "ACADEMIC"
		TITLE_CODES["2017"]["unit"] = "99"

	TITLE_CODES["2016"] = {}
		TITLE_CODES["2016"]["title"] = "HS CLIN PROF RECALLED-FY"
		TITLE_CODES["2016"]["program"] = "ACADEMIC"
		TITLE_CODES["2016"]["unit"] = "99"

	TITLE_CODES["2011"] = {}
		TITLE_CODES["2011"]["title"] = "CLIN PROF-DENTISTRY-50%/+ FY"
		TITLE_CODES["2011"]["program"] = "ACADEMIC"
		TITLE_CODES["2011"]["unit"] = "99"

	TITLE_CODES["2010"] = {}
		TITLE_CODES["2010"]["title"] = "HS CLIN PROFESSOR-FISCAL YR"
		TITLE_CODES["2010"]["program"] = "ACADEMIC"
		TITLE_CODES["2010"]["unit"] = "99"

	TITLE_CODES["2013"] = {}
		TITLE_CODES["2013"]["title"] = "CLIN PROF DENT-FY-PTC GENCO"
		TITLE_CODES["2013"]["program"] = "ACADEMIC"
		TITLE_CODES["2013"]["unit"] = "99"

	TITLE_CODES["9061"] = {}
		TITLE_CODES["9061"]["title"] = "TECHNOLOGIST, EEG"
		TITLE_CODES["9061"]["program"] = "PSS"
		TITLE_CODES["9061"]["unit"] = "EX"

	TITLE_CODES["9060"] = {}
		TITLE_CODES["9060"]["title"] = "TECHNOLOGIST, EEG, SR"
		TITLE_CODES["9060"]["program"] = "PSS"
		TITLE_CODES["9060"]["unit"] = "EX"

	TITLE_CODES["9062"] = {}
		TITLE_CODES["9062"]["title"] = "TECHNOLOGIST, EEG, PR, P.D."
		TITLE_CODES["9062"]["program"] = "PSS"
		TITLE_CODES["9062"]["unit"] = "EX"

	TITLE_CODES["9065"] = {}
		TITLE_CODES["9065"]["title"] = "HISTOTECHNOLOGIST I"
		TITLE_CODES["9065"]["program"] = "PSS"
		TITLE_CODES["9065"]["unit"] = "EX"

	TITLE_CODES["9067"] = {}
		TITLE_CODES["9067"]["title"] = "HISTOTECHNOLOGIST III"
		TITLE_CODES["9067"]["program"] = "PSS"
		TITLE_CODES["9067"]["unit"] = "EX"

	TITLE_CODES["9066"] = {}
		TITLE_CODES["9066"]["title"] = "HISTOTECHNOLOGIST II"
		TITLE_CODES["9066"]["program"] = "PSS"
		TITLE_CODES["9066"]["unit"] = "EX"

	TITLE_CODES["9068"] = {}
		TITLE_CODES["9068"]["title"] = "HISTOTECHNOLOGIST, SUPVR"
		TITLE_CODES["9068"]["program"] = "PSS"
		TITLE_CODES["9068"]["unit"] = "99"

	TITLE_CODES["8149"] = {}
		TITLE_CODES["8149"]["title"] = "FARM MAINTENANCE WORKER"
		TITLE_CODES["8149"]["program"] = "PSS"
		TITLE_CODES["8149"]["unit"] = "SX"

	TITLE_CODES["9322"] = {}
		TITLE_CODES["9322"]["title"] = "COMMUNITY HEALTH PROGRAM MGR"
		TITLE_CODES["9322"]["program"] = "PSS"
		TITLE_CODES["9322"]["unit"] = "99"

	TITLE_CODES["9399"] = {}
		TITLE_CODES["9399"]["title"] = "TECHNICIAN I, GI ENDOSCOPY"
		TITLE_CODES["9399"]["program"] = "PSS"
		TITLE_CODES["9399"]["unit"] = "EX"

	TITLE_CODES["9801"] = {}
		TITLE_CODES["9801"]["title"] = "FIRE CAPTAIN - 56 HRS"
		TITLE_CODES["9801"]["program"] = "PSS"
		TITLE_CODES["9801"]["unit"] = "FF"

	TITLE_CODES["1958"] = {}
		TITLE_CODES["1958"]["title"] = "REGENTS PROFESSOR"
		TITLE_CODES["1958"]["program"] = "ACADEMIC"
		TITLE_CODES["1958"]["unit"] = "99"

	TITLE_CODES["7254"] = {}
		TITLE_CODES["7254"]["title"] = "ANALYST, BUDGET, ASST"
		TITLE_CODES["7254"]["program"] = "PSS"
		TITLE_CODES["7254"]["unit"] = "99"

	TITLE_CODES["7255"] = {}
		TITLE_CODES["7255"]["title"] = "BUDGET ANALYST SUPERVISOR"
		TITLE_CODES["7255"]["program"] = "PSS"
		TITLE_CODES["7255"]["unit"] = "99"

	TITLE_CODES["3249"] = {}
		TITLE_CODES["3249"]["title"] = "____-SENATE-EMERITUS"
		TITLE_CODES["3249"]["program"] = "ACADEMIC"
		TITLE_CODES["3249"]["unit"] = "A3"

	TITLE_CODES["7250"] = {}
		TITLE_CODES["7250"]["title"] = "ANALYST VI-SUPERVISOR"
		TITLE_CODES["7250"]["program"] = "PSS"
		TITLE_CODES["7250"]["unit"] = "99"

	TITLE_CODES["7251"] = {}
		TITLE_CODES["7251"]["title"] = "ANALYST, BUDGET, PRIN I"
		TITLE_CODES["7251"]["program"] = "PSS"
		TITLE_CODES["7251"]["unit"] = "99"

	TITLE_CODES["7252"] = {}
		TITLE_CODES["7252"]["title"] = "ANALYST, BUDGET, SR"
		TITLE_CODES["7252"]["program"] = "PSS"
		TITLE_CODES["7252"]["unit"] = "99"

	TITLE_CODES["3370"] = {}
		TITLE_CODES["3370"]["title"] = "VISITING (-----) - POSTDOC"
		TITLE_CODES["3370"]["program"] = "ACADEMIC"
		TITLE_CODES["3370"]["unit"] = "PX"

	TITLE_CODES["3243"] = {}
		TITLE_CODES["3243"]["title"] = "PGR ---- ACAD YR- STATE FUNDS"
		TITLE_CODES["3243"]["program"] = "ACADEMIC"
		TITLE_CODES["3243"]["unit"] = "PX"

	TITLE_CODES["3240"] = {}
		TITLE_CODES["3240"]["title"] = "POSTGRAD RES ----- - FISCAL YR"
		TITLE_CODES["3240"]["program"] = "ACADEMIC"
		TITLE_CODES["3240"]["unit"] = "PX"

	TITLE_CODES["9131"] = {}
		TITLE_CODES["9131"]["title"] = "ADMINISTRATIVE NURSE"
		TITLE_CODES["9131"]["program"] = "PSS"
		TITLE_CODES["9131"]["unit"] = "99"

	TITLE_CODES["9030"] = {}
		TITLE_CODES["9030"]["title"] = "ADMITTING WORKER, SUPV"
		TITLE_CODES["9030"]["program"] = "PSS"
		TITLE_CODES["9030"]["unit"] = "99"

	TITLE_CODES["3245"] = {}
		TITLE_CODES["3245"]["title"] = "PGR ---- ACAD YR-XMURAL FUNDS"
		TITLE_CODES["3245"]["program"] = "ACADEMIC"
		TITLE_CODES["3245"]["unit"] = "PX"

	TITLE_CODES["9552"] = {}
		TITLE_CODES["9552"]["title"] = "BOTANICAL GAR/ARBORETUM MGR"
		TITLE_CODES["9552"]["program"] = "PSS"
		TITLE_CODES["9552"]["unit"] = "99"

	TITLE_CODES["9134"] = {}
		TITLE_CODES["9134"]["title"] = "NURSE, ADMINISTRATIVE, I"
		TITLE_CODES["9134"]["program"] = "PSS"
		TITLE_CODES["9134"]["unit"] = "NX"

	TITLE_CODES["9031"] = {}
		TITLE_CODES["9031"]["title"] = "ADMITTING WORKER, PRIN"
		TITLE_CODES["9031"]["program"] = "PSS"
		TITLE_CODES["9031"]["unit"] = "EX"

	TITLE_CODES["8970"] = {}
		TITLE_CODES["8970"]["title"] = "TECHNICIAN, HOSP LAB IV-SUPVR"
		TITLE_CODES["8970"]["program"] = "PSS"
		TITLE_CODES["8970"]["unit"] = "99"

	TITLE_CODES["8971"] = {}
		TITLE_CODES["8971"]["title"] = "TECHNICIAN, HOSP LAB,III-SUPVR"
		TITLE_CODES["8971"]["program"] = "PSS"
		TITLE_CODES["8971"]["unit"] = "99"

	TITLE_CODES["8972"] = {}
		TITLE_CODES["8972"]["title"] = "TECHNICIAN, HOSP LAB, II-SUPVR"
		TITLE_CODES["8972"]["program"] = "PSS"
		TITLE_CODES["8972"]["unit"] = "99"

	TITLE_CODES["8973"] = {}
		TITLE_CODES["8973"]["title"] = "TECHNICIAN, HOSP LAB, IV"
		TITLE_CODES["8973"]["program"] = "PSS"
		TITLE_CODES["8973"]["unit"] = "EX"

	TITLE_CODES["8974"] = {}
		TITLE_CODES["8974"]["title"] = "TECHNICIAN, HOSPITAL LAB, III"
		TITLE_CODES["8974"]["program"] = "PSS"
		TITLE_CODES["8974"]["unit"] = "EX"

	TITLE_CODES["8975"] = {}
		TITLE_CODES["8975"]["title"] = "TECHNICIAN, HOSPITAL LAB, II"
		TITLE_CODES["8975"]["program"] = "PSS"
		TITLE_CODES["8975"]["unit"] = "EX"

	TITLE_CODES["8683"] = {}
		TITLE_CODES["8683"]["title"] = "TECHNICIAN, ELEC-MED FAC"
		TITLE_CODES["8683"]["program"] = "PSS"
		TITLE_CODES["8683"]["unit"] = "EX"

	TITLE_CODES["9037"] = {}
		TITLE_CODES["9037"]["title"] = "PERFUSIONIST, PRIN-SUPVR"
		TITLE_CODES["9037"]["program"] = "PSS"
		TITLE_CODES["9037"]["unit"] = "99"

	TITLE_CODES["709"] = {}
		TITLE_CODES["709"]["title"] = "MGR, EMP.ASSISTANCE PROG, II"
		TITLE_CODES["709"]["program"] = "MSP"
		TITLE_CODES["709"]["unit"] = "99"

	TITLE_CODES["9130"] = {}
		TITLE_CODES["9130"]["title"] = "NURSE MANAGER"
		TITLE_CODES["9130"]["program"] = "PSS"
		TITLE_CODES["9130"]["unit"] = "99"

	TITLE_CODES["9035"] = {}
		TITLE_CODES["9035"]["title"] = "ADMITTING WORKER, PRIN-SUPVR"
		TITLE_CODES["9035"]["program"] = "PSS"
		TITLE_CODES["9035"]["unit"] = "99"

	TITLE_CODES["700"] = {}
		TITLE_CODES["700"]["title"] = "MGT AND PROF PROG (UNTITLED)"
		TITLE_CODES["700"]["program"] = "MSP"
		TITLE_CODES["700"]["unit"] = "99"

	TITLE_CODES["701"] = {}
		TITLE_CODES["701"]["title"] = "ASST CHANC (FUNCT AREA) - MAP"
		TITLE_CODES["701"]["program"] = "MSP"
		TITLE_CODES["701"]["unit"] = "99"

	TITLE_CODES["702"] = {}
		TITLE_CODES["702"]["title"] = "PROJECT MGR,DESIGN/CONSTR VI"
		TITLE_CODES["702"]["program"] = "MSP"
		TITLE_CODES["702"]["unit"] = "99"

	TITLE_CODES["7630"] = {}
		TITLE_CODES["7630"]["title"] = "AUDITOR SUPERVISOR"
		TITLE_CODES["7630"]["program"] = "PSS"
		TITLE_CODES["7630"]["unit"] = "99"

	TITLE_CODES["8651"] = {}
		TITLE_CODES["8651"]["title"] = "MECHANICIAN, LAB, PRIN"
		TITLE_CODES["8651"]["program"] = "PSS"
		TITLE_CODES["8651"]["unit"] = "TX"

	TITLE_CODES["88"] = {}
		TITLE_CODES["88"]["title"] = "EXECUTIVE DIRECTOR-EXECUTIVE"
		TITLE_CODES["88"]["program"] = "MSP"
		TITLE_CODES["88"]["unit"] = "99"

	TITLE_CODES["89"] = {}
		TITLE_CODES["89"]["title"] = "COUNSEL OF THE REGENTS"
		TITLE_CODES["89"]["program"] = "MSP"
		TITLE_CODES["89"]["unit"] = "99"

	TITLE_CODES["9010"] = {}
		TITLE_CODES["9010"]["title"] = "TECHNOLOGIST,RAD THPY, CHIEF"
		TITLE_CODES["9010"]["program"] = "PSS"
		TITLE_CODES["9010"]["unit"] = "99"

	TITLE_CODES["9012"] = {}
		TITLE_CODES["9012"]["title"] = "TECHNOLOGIST,RAD THPY, SR"
		TITLE_CODES["9012"]["program"] = "PSS"
		TITLE_CODES["9012"]["unit"] = "EX"

	TITLE_CODES["5338"] = {}
		TITLE_CODES["5338"]["title"] = "PARKING REPRESENTATIVE-SUPVR"
		TITLE_CODES["5338"]["program"] = "PSS"
		TITLE_CODES["5338"]["unit"] = "99"

	TITLE_CODES["82"] = {}
		TITLE_CODES["82"]["title"] = "CHF CMP COUNSEL/ASSOC GEN CNSL"
		TITLE_CODES["82"]["program"] = "MSP"
		TITLE_CODES["82"]["unit"] = "99"

	TITLE_CODES["83"] = {}
		TITLE_CODES["83"]["title"] = "DEPUTY GEN COUNSEL OF THE REG"
		TITLE_CODES["83"]["program"] = "MSP"
		TITLE_CODES["83"]["unit"] = "99"

	TITLE_CODES["80"] = {}
		TITLE_CODES["80"]["title"] = "GENERAL COUNSEL & VP-LEGAL AFF"
		TITLE_CODES["80"]["program"] = "MSP"
		TITLE_CODES["80"]["unit"] = "99"

	TITLE_CODES["7132"] = {}
		TITLE_CODES["7132"]["title"] = "SPECIALIST, E.H.&S. III"
		TITLE_CODES["7132"]["program"] = "PSS"
		TITLE_CODES["7132"]["unit"] = "99"

	TITLE_CODES["7135"] = {}
		TITLE_CODES["7135"]["title"] = "SPECIALIST, E.H.&S. II"
		TITLE_CODES["7135"]["program"] = "PSS"
		TITLE_CODES["7135"]["unit"] = "99"

	TITLE_CODES["7134"] = {}
		TITLE_CODES["7134"]["title"] = "E.H. & S. SPEC., ASSIST."
		TITLE_CODES["7134"]["program"] = "PSS"
		TITLE_CODES["7134"]["unit"] = "99"

	TITLE_CODES["84"] = {}
		TITLE_CODES["84"]["title"] = "MANAGING U COUNSEL OF THE REG"
		TITLE_CODES["84"]["program"] = "MSP"
		TITLE_CODES["84"]["unit"] = "99"

	TITLE_CODES["85"] = {}
		TITLE_CODES["85"]["title"] = "UNIVERSITY COUNSEL OF THE REG"
		TITLE_CODES["85"]["program"] = "MSP"
		TITLE_CODES["85"]["unit"] = "99"

	TITLE_CODES["797"] = {}
		TITLE_CODES["797"]["title"] = "FIRE CHIEF"
		TITLE_CODES["797"]["program"] = "MSP"
		TITLE_CODES["797"]["unit"] = "99"

	TITLE_CODES["796"] = {}
		TITLE_CODES["796"]["title"] = "OCCUPATIONAL THERAPIST V"
		TITLE_CODES["796"]["program"] = "MSP"
		TITLE_CODES["796"]["unit"] = "99"

	TITLE_CODES["795"] = {}
		TITLE_CODES["795"]["title"] = "PHYSICAL THERAPIST V"
		TITLE_CODES["795"]["program"] = "MSP"
		TITLE_CODES["795"]["unit"] = "99"

	TITLE_CODES["794"] = {}
		TITLE_CODES["794"]["title"] = "CHF OF REHABILITATION SERVICES"
		TITLE_CODES["794"]["program"] = "MSP"
		TITLE_CODES["794"]["unit"] = "99"

	TITLE_CODES["793"] = {}
		TITLE_CODES["793"]["title"] = "PSYCHOLOGIST III"
		TITLE_CODES["793"]["program"] = "MSP"
		TITLE_CODES["793"]["unit"] = "99"

	TITLE_CODES["792"] = {}
		TITLE_CODES["792"]["title"] = "CHIEF PSYCHOLOGIST"
		TITLE_CODES["792"]["program"] = "MSP"
		TITLE_CODES["792"]["unit"] = "99"

	TITLE_CODES["791"] = {}
		TITLE_CODES["791"]["title"] = "SUPERVISOR OF SPEECH PATHOLOGY"
		TITLE_CODES["791"]["program"] = "MSP"
		TITLE_CODES["791"]["unit"] = "99"

	TITLE_CODES["790"] = {}
		TITLE_CODES["790"]["title"] = "CHIEF COMMUNITY HEALTH PROGRAM"
		TITLE_CODES["790"]["program"] = "MSP"
		TITLE_CODES["790"]["unit"] = "99"

	TITLE_CODES["5313"] = {}
		TITLE_CODES["5313"]["title"] = "POLICE SERGEANT"
		TITLE_CODES["5313"]["program"] = "PSS"
		TITLE_CODES["5313"]["unit"] = "99"

	TITLE_CODES["5312"] = {}
		TITLE_CODES["5312"]["title"] = "POLICE LIEUTENANT"
		TITLE_CODES["5312"]["program"] = "PSS"
		TITLE_CODES["5312"]["unit"] = "99"

	TITLE_CODES["1719"] = {}
		TITLE_CODES["1719"]["title"] = "ASSOCIATE PROFESSOR-HCOMP"
		TITLE_CODES["1719"]["program"] = "ACADEMIC"
		TITLE_CODES["1719"]["unit"] = "A3"

	TITLE_CODES["1718"] = {}
		TITLE_CODES["1718"]["title"] = "ACT ASST PROFESSOR-MEDCOMP-A"
		TITLE_CODES["1718"]["program"] = "ACADEMIC"
		TITLE_CODES["1718"]["unit"] = "99"

	TITLE_CODES["799"] = {}
		TITLE_CODES["799"]["title"] = "ASSOCIATE TO THE PRESIDENT"
		TITLE_CODES["799"]["program"] = "MSP"
		TITLE_CODES["799"]["unit"] = "99"

	TITLE_CODES["798"] = {}
		TITLE_CODES["798"]["title"] = "ASSOC OF THE PRES/CHANC"
		TITLE_CODES["798"]["program"] = "MSP"
		TITLE_CODES["798"]["unit"] = "99"

	TITLE_CODES["6311"] = {}
		TITLE_CODES["6311"]["title"] = "PUBLIC EVENTS MANAGER, PRIN"
		TITLE_CODES["6311"]["program"] = "PSS"
		TITLE_CODES["6311"]["unit"] = "99"

	TITLE_CODES["1652"] = {}
		TITLE_CODES["1652"]["title"] = "CONTINUING APPT-TEMP AUG"
		TITLE_CODES["1652"]["program"] = "ACADEMIC"
		TITLE_CODES["1652"]["unit"] = "IX"

	TITLE_CODES["1653"] = {}
		TITLE_CODES["1653"]["title"] = "CONTINUING APPT-TEMP AUG-1/9"
		TITLE_CODES["1653"]["program"] = "ACADEMIC"
		TITLE_CODES["1653"]["unit"] = "IX"

	TITLE_CODES["1650"] = {}
		TITLE_CODES["1650"]["title"] = "LECTURER-MISC/PART-TIME"
		TITLE_CODES["1650"]["program"] = "ACADEMIC"
		TITLE_CODES["1650"]["unit"] = "99"

	TITLE_CODES["8525"] = {}
		TITLE_CODES["8525"]["title"] = "FARM MACHINERY ATTENDANT"
		TITLE_CODES["8525"]["program"] = "PSS"
		TITLE_CODES["8525"]["unit"] = "SX"

	TITLE_CODES["9540"] = {}
		TITLE_CODES["9540"]["title"] = "TECH, ANIMAL HEALTH, II - SUPV"
		TITLE_CODES["9540"]["program"] = "PSS"
		TITLE_CODES["9540"]["unit"] = "99"

	TITLE_CODES["1739"] = {}
		TITLE_CODES["1739"]["title"] = "ASSOCIATE PROF-GENCOMP-B"
		TITLE_CODES["1739"]["program"] = "ACADEMIC"
		TITLE_CODES["1739"]["unit"] = "A3"

	TITLE_CODES["9190"] = {}
		TITLE_CODES["9190"]["title"] = "DENTAL HYGIENIST"
		TITLE_CODES["9190"]["program"] = "PSS"
		TITLE_CODES["9190"]["unit"] = "EX"

	TITLE_CODES["8208"] = {}
		TITLE_CODES["8208"]["title"] = "BUILDING MAINTENANCE SUPVR"
		TITLE_CODES["8208"]["program"] = "PSS"
		TITLE_CODES["8208"]["unit"] = "99"

	TITLE_CODES["1738"] = {}
		TITLE_CODES["1738"]["title"] = "ACT ASST PROFESSOR-GENCOMP-B"
		TITLE_CODES["1738"]["program"] = "ACADEMIC"
		TITLE_CODES["1738"]["unit"] = "99"

	TITLE_CODES["9345"] = {}
		TITLE_CODES["9345"]["title"] = "CHILD DEVELOPMENT ASSOC"
		TITLE_CODES["9345"]["program"] = "PSS"
		TITLE_CODES["9345"]["unit"] = "HX"

	TITLE_CODES["1132"] = {}
		TITLE_CODES["1132"]["title"] = "PROFESSOR EMERITUS (W/O SAL)"
		TITLE_CODES["1132"]["program"] = "ACADEMIC"
		TITLE_CODES["1132"]["unit"] = "A3"

	TITLE_CODES["1130"] = {}
		TITLE_CODES["1130"]["title"] = "PROFESSOR - 10-MONTHS"
		TITLE_CODES["1130"]["program"] = "ACADEMIC"
		TITLE_CODES["1130"]["unit"] = "A3"

	TITLE_CODES["8072"] = {}
		TITLE_CODES["8072"]["title"] = "LABORER SUPVR"
		TITLE_CODES["8072"]["program"] = "PSS"
		TITLE_CODES["8072"]["unit"] = "99"

	TITLE_CODES["1984"] = {}
		TITLE_CODES["1984"]["title"] = "ASO RES___-AY-1/9-BUS/ECON/ENG"
		TITLE_CODES["1984"]["program"] = "ACADEMIC"
		TITLE_CODES["1984"]["unit"] = "FX"

	TITLE_CODES["8200"] = {}
		TITLE_CODES["8200"]["title"] = "GLAZIER"
		TITLE_CODES["8200"]["program"] = "PSS"
		TITLE_CODES["8200"]["unit"] = "K3"

	TITLE_CODES["7625"] = {}
		TITLE_CODES["7625"]["title"] = "ACCOUNTANT II - SUPERVISOR"
		TITLE_CODES["7625"]["program"] = "PSS"
		TITLE_CODES["7625"]["unit"] = "99"

	TITLE_CODES["2060"] = {}
		TITLE_CODES["2060"]["title"] = "HS CLINICAL INSTRUCTOR-ACAD YR"
		TITLE_CODES["2060"]["program"] = "ACADEMIC"
		TITLE_CODES["2060"]["unit"] = "99"

	TITLE_CODES["1985"] = {}
		TITLE_CODES["1985"]["title"] = "ASST RES___-AY-BUS/ECON/ENG"
		TITLE_CODES["1985"]["program"] = "ACADEMIC"
		TITLE_CODES["1985"]["unit"] = "FX"

	TITLE_CODES["7621"] = {}
		TITLE_CODES["7621"]["title"] = "AUDITOR IV"
		TITLE_CODES["7621"]["program"] = "PSS"
		TITLE_CODES["7621"]["unit"] = "99"

	TITLE_CODES["7620"] = {}
		TITLE_CODES["7620"]["title"] = "ACCOUNTANT II"
		TITLE_CODES["7620"]["program"] = "PSS"
		TITLE_CODES["7620"]["unit"] = "99"

	TITLE_CODES["7623"] = {}
		TITLE_CODES["7623"]["title"] = "AUDITOR I"
		TITLE_CODES["7623"]["program"] = "PSS"
		TITLE_CODES["7623"]["unit"] = "99"

	TITLE_CODES["7622"] = {}
		TITLE_CODES["7622"]["title"] = "AUDITOR III"
		TITLE_CODES["7622"]["program"] = "PSS"
		TITLE_CODES["7622"]["unit"] = "99"

	TITLE_CODES["1982"] = {}
		TITLE_CODES["1982"]["title"] = "RES___-AY-1/9-BUS/ECON/ENG"
		TITLE_CODES["1982"]["program"] = "ACADEMIC"
		TITLE_CODES["1982"]["unit"] = "FX"

	TITLE_CODES["7192"] = {}
		TITLE_CODES["7192"]["title"] = "DATA PROC PROD COORDINATOR, SR"
		TITLE_CODES["7192"]["program"] = "PSS"
		TITLE_CODES["7192"]["unit"] = "CX"

	TITLE_CODES["7782"] = {}
		TITLE_CODES["7782"]["title"] = "BUYER III - SUPERVISOR"
		TITLE_CODES["7782"]["program"] = "PSS"
		TITLE_CODES["7782"]["unit"] = "99"

	TITLE_CODES["7780"] = {}
		TITLE_CODES["7780"]["title"] = "BUYER I - SUPERVISOR"
		TITLE_CODES["7780"]["program"] = "PSS"
		TITLE_CODES["7780"]["unit"] = "99"

	TITLE_CODES["1983"] = {}
		TITLE_CODES["1983"]["title"] = "ASOC RESEARCH___-AY-B/ECON/ENG"
		TITLE_CODES["1983"]["program"] = "ACADEMIC"
		TITLE_CODES["1983"]["unit"] = "FX"

	TITLE_CODES["3391"] = {}
		TITLE_CODES["3391"]["title"] = "PROJECT______-FY-BUS/ECON/ENG"
		TITLE_CODES["3391"]["program"] = "ACADEMIC"
		TITLE_CODES["3391"]["unit"] = "FX"

	TITLE_CODES["3390"] = {}
		TITLE_CODES["3390"]["title"] = "PROJECT______-FISCAL YEAR"
		TITLE_CODES["3390"]["program"] = "ACADEMIC"
		TITLE_CODES["3390"]["unit"] = "FX"

	TITLE_CODES["1434"] = {}
		TITLE_CODES["1434"]["title"] = "VIS INSTRUCTOR-GENCOMP"
		TITLE_CODES["1434"]["program"] = "ACADEMIC"
		TITLE_CODES["1434"]["unit"] = "99"

	TITLE_CODES["3019"] = {}
		TITLE_CODES["3019"]["title"] = "ACT ASOC---IN THE A.E.S.SFT-VM"
		TITLE_CODES["3019"]["program"] = "ACADEMIC"
		TITLE_CODES["3019"]["unit"] = "FX"

	TITLE_CODES["1432"] = {}
		TITLE_CODES["1432"]["title"] = "VIS ASSOC PROFESSOR-GENCOMP"
		TITLE_CODES["1432"]["program"] = "ACADEMIC"
		TITLE_CODES["1432"]["unit"] = "99"

	TITLE_CODES["1433"] = {}
		TITLE_CODES["1433"]["title"] = "VIS ASST PROFESSOR-GENCOMP"
		TITLE_CODES["1433"]["program"] = "ACADEMIC"
		TITLE_CODES["1433"]["unit"] = "99"

	TITLE_CODES["3397"] = {}
		TITLE_CODES["3397"]["title"] = "VISITING ASSOC PROJECT ____-FY"
		TITLE_CODES["3397"]["program"] = "ACADEMIC"
		TITLE_CODES["3397"]["unit"] = "99"

	TITLE_CODES["1431"] = {}
		TITLE_CODES["1431"]["title"] = "VIS PROFESSOR-GENCOMP"
		TITLE_CODES["1431"]["program"] = "ACADEMIC"
		TITLE_CODES["1431"]["unit"] = "99"

	TITLE_CODES["3012"] = {}
		TITLE_CODES["3012"]["title"] = " --- IN THE AES-BUS/ECON/ENG"
		TITLE_CODES["3012"]["program"] = "ACADEMIC"
		TITLE_CODES["3012"]["unit"] = "FX"

	TITLE_CODES["3013"] = {}
		TITLE_CODES["3013"]["title"] = "ASSOC ---IN THE AES-B/ECON/ENG"
		TITLE_CODES["3013"]["program"] = "ACADEMIC"
		TITLE_CODES["3013"]["unit"] = "FX"

	TITLE_CODES["3010"] = {}
		TITLE_CODES["3010"]["title"] = "ASSOC ----- IN THE A.E.S."
		TITLE_CODES["3010"]["program"] = "ACADEMIC"
		TITLE_CODES["3010"]["unit"] = "FX"

	TITLE_CODES["3011"] = {}
		TITLE_CODES["3011"]["title"] = "ASSOC ---- IN THE A.E.S.SFT-VM"
		TITLE_CODES["3011"]["program"] = "ACADEMIC"
		TITLE_CODES["3011"]["unit"] = "FX"

	TITLE_CODES["3017"] = {}
		TITLE_CODES["3017"]["title"] = "ACT ASSOC ----- IN THE A.E.S."
		TITLE_CODES["3017"]["program"] = "ACADEMIC"
		TITLE_CODES["3017"]["unit"] = "99"

	TITLE_CODES["3014"] = {}
		TITLE_CODES["3014"]["title"] = "ASSOC SPECIALIST IN THE A.E.S."
		TITLE_CODES["3014"]["program"] = "ACADEMIC"
		TITLE_CODES["3014"]["unit"] = "FX"

	TITLE_CODES["3015"] = {}
		TITLE_CODES["3015"]["title"] = "ASST---IN THE AES-BUS/ECON/ENG"
		TITLE_CODES["3015"]["program"] = "ACADEMIC"
		TITLE_CODES["3015"]["unit"] = "FX"

	TITLE_CODES["9187"] = {}
		TITLE_CODES["9187"]["title"] = "DENTIST, EXAMINING"
		TITLE_CODES["9187"]["program"] = "PSS"
		TITLE_CODES["9187"]["unit"] = "99"

	TITLE_CODES["9805"] = {}
		TITLE_CODES["9805"]["title"] = "FIRE FIGHTER"
		TITLE_CODES["9805"]["program"] = "PSS"
		TITLE_CODES["9805"]["unit"] = "FF"

	TITLE_CODES["511"] = {}
		TITLE_CODES["511"]["title"] = "ENTEROSTOMAL THERAPIST"
		TITLE_CODES["511"]["program"] = "MSP"
		TITLE_CODES["511"]["unit"] = "99"

	TITLE_CODES["1000"] = {}
		TITLE_CODES["1000"]["title"] = "DEAN"
		TITLE_CODES["1000"]["program"] = "ACADEMIC"
		TITLE_CODES["1000"]["unit"] = "99"

	TITLE_CODES["8159"] = {}
		TITLE_CODES["8159"]["title"] = "MECHANIC, ELEVATOR, LEAD"
		TITLE_CODES["8159"]["program"] = "PSS"
		TITLE_CODES["8159"]["unit"] = "K3"

	TITLE_CODES["8050"] = {}
		TITLE_CODES["8050"]["title"] = "OPER ENGR-HVY EQUIP, APPREN"
		TITLE_CODES["8050"]["program"] = "PSS"
		TITLE_CODES["8050"]["unit"] = "K3"

	TITLE_CODES["9528"] = {}
		TITLE_CODES["9528"]["title"] = "TECHNICIAN, ANIMAL, PR - SUPVR"
		TITLE_CODES["9528"]["program"] = "PSS"
		TITLE_CODES["9528"]["unit"] = "99"

	TITLE_CODES["450"] = {}
		TITLE_CODES["450"]["title"] = "DEPUTY TO THE SENIOR VP"
		TITLE_CODES["450"]["program"] = "MSP"
		TITLE_CODES["450"]["unit"] = "99"

	TITLE_CODES["3218"] = {}
		TITLE_CODES["3218"]["title"] = "VST ASSOC RES ---- - FISCAL YR"
		TITLE_CODES["3218"]["program"] = "ACADEMIC"
		TITLE_CODES["3218"]["unit"] = "99"

	TITLE_CODES["8059"] = {}
		TITLE_CODES["8059"]["title"] = "ABSTRACTOR, PATIENT REC II, PD"
		TITLE_CODES["8059"]["program"] = "PSS"
		TITLE_CODES["8059"]["unit"] = "EX"

	TITLE_CODES["1343"] = {}
		TITLE_CODES["1343"]["title"] = "ASST PROF-ACAD YR-BUS/ECON/ENG"
		TITLE_CODES["1343"]["program"] = "ACADEMIC"
		TITLE_CODES["1343"]["unit"] = "A3"

	TITLE_CODES["454"] = {}
		TITLE_CODES["454"]["title"] = "EXEC ASSISTANT (FUNCT AREA)"
		TITLE_CODES["454"]["program"] = "MSP"
		TITLE_CODES["454"]["unit"] = "99"

	TITLE_CODES["1345"] = {}
		TITLE_CODES["1345"]["title"] = "ASST PROF-AY-1/9-BUS/ECON/ENG"
		TITLE_CODES["1345"]["program"] = "ACADEMIC"
		TITLE_CODES["1345"]["unit"] = "A3"

	TITLE_CODES["9804"] = {}
		TITLE_CODES["9804"]["title"] = "FIRE SPECIALIST"
		TITLE_CODES["9804"]["program"] = "PSS"
		TITLE_CODES["9804"]["unit"] = "TX"

	TITLE_CODES["8291"] = {}
		TITLE_CODES["8291"]["title"] = "TECHNICIAN, TELEVISION, PRIN"
		TITLE_CODES["8291"]["program"] = "PSS"
		TITLE_CODES["8291"]["unit"] = "TX"

	TITLE_CODES["8290"] = {}
		TITLE_CODES["8290"]["title"] = "TECHNICIAN, TELEVISION, PR-SUP"
		TITLE_CODES["8290"]["program"] = "PSS"
		TITLE_CODES["8290"]["unit"] = "99"

	TITLE_CODES["8118"] = {}
		TITLE_CODES["8118"]["title"] = "SUPERINTENDENT,ARGICULTUR,PRIN"
		TITLE_CODES["8118"]["program"] = "PSS"
		TITLE_CODES["8118"]["unit"] = "99"

	TITLE_CODES["8119"] = {}
		TITLE_CODES["8119"]["title"] = "SUPERINTENDENT,ARGICULTURE, SR"
		TITLE_CODES["8119"]["program"] = "PSS"
		TITLE_CODES["8119"]["unit"] = "99"

	TITLE_CODES["1988"] = {}
		TITLE_CODES["1988"]["title"] = "ASSOC RES --- -FY-BUS/ECON/ENG"
		TITLE_CODES["1988"]["program"] = "ACADEMIC"
		TITLE_CODES["1988"]["unit"] = "FX"

	TITLE_CODES["8297"] = {}
		TITLE_CODES["8297"]["title"] = "TECHNI., ELEC SUPV, SR-MF"
		TITLE_CODES["8297"]["program"] = "PSS"
		TITLE_CODES["8297"]["unit"] = "99"

	TITLE_CODES["4348"] = {}
		TITLE_CODES["4348"]["title"] = "STUDENT AFFAIRS OFF I - SUPERV"
		TITLE_CODES["4348"]["program"] = "PSS"
		TITLE_CODES["4348"]["unit"] = "99"

	TITLE_CODES["8299"] = {}
		TITLE_CODES["8299"]["title"] = "TECHNI., ELEC SUPV, SR"
		TITLE_CODES["8299"]["program"] = "PSS"
		TITLE_CODES["8299"]["unit"] = "99"

	TITLE_CODES["8298"] = {}
		TITLE_CODES["8298"]["title"] = "TECHNICIAN, ELEC, SUPVR-MF"
		TITLE_CODES["8298"]["program"] = "PSS"
		TITLE_CODES["8298"]["unit"] = "99"

	TITLE_CODES["8110"] = {}
		TITLE_CODES["8110"]["title"] = "CARPENTER"
		TITLE_CODES["8110"]["program"] = "PSS"
		TITLE_CODES["8110"]["unit"] = "K3"

	TITLE_CODES["8111"] = {}
		TITLE_CODES["8111"]["title"] = "CARPENTER, APPRENTICE"
		TITLE_CODES["8111"]["program"] = "PSS"
		TITLE_CODES["8111"]["unit"] = "K3"

	TITLE_CODES["8116"] = {}
		TITLE_CODES["8116"]["title"] = "SUPERINTENDENT,PHYSL PLT,ASST"
		TITLE_CODES["8116"]["program"] = "PSS"
		TITLE_CODES["8116"]["unit"] = "99"

	TITLE_CODES["3700"] = {}
		TITLE_CODES["3700"]["title"] = "FACULTY CONSULTANT IN _____"
		TITLE_CODES["3700"]["program"] = "ACADEMIC"
		TITLE_CODES["3700"]["unit"] = "99"

	TITLE_CODES["8114"] = {}
		TITLE_CODES["8114"]["title"] = "SUPERINTENDENT,PHYSICAL PLT,SR"
		TITLE_CODES["8114"]["program"] = "PSS"
		TITLE_CODES["8114"]["unit"] = "99"

	TITLE_CODES["8115"] = {}
		TITLE_CODES["8115"]["title"] = "SUPERINTENDENT,PHYSICAL PLANT"
		TITLE_CODES["8115"]["program"] = "PSS"
		TITLE_CODES["8115"]["unit"] = "99"

	TITLE_CODES["7713"] = {}
		TITLE_CODES["7713"]["title"] = "ESTIMATOR, PRINTING"
		TITLE_CODES["7713"]["program"] = "PSS"
		TITLE_CODES["7713"]["unit"] = "TX"

	TITLE_CODES["5538"] = {}
		TITLE_CODES["5538"]["title"] = "COOK-HOUSEKEEPER"
		TITLE_CODES["5538"]["program"] = "PSS"
		TITLE_CODES["5538"]["unit"] = "SX"

	TITLE_CODES["7247"] = {}
		TITLE_CODES["7247"]["title"] = "ANALYST III-SUPERVISOR"
		TITLE_CODES["7247"]["program"] = "PSS"
		TITLE_CODES["7247"]["unit"] = "99"

	TITLE_CODES["7497"] = {}
		TITLE_CODES["7497"]["title"] = "GIFT SHOP MANAGER"
		TITLE_CODES["7497"]["program"] = "PSS"
		TITLE_CODES["7497"]["unit"] = "99"

	TITLE_CODES["1502"] = {}
		TITLE_CODES["1502"]["title"] = "ASSOCIATE IN __-AY-NON-GSHIP"
		TITLE_CODES["1502"]["program"] = "ACADEMIC"
		TITLE_CODES["1502"]["unit"] = "BX"

	TITLE_CODES["1501"] = {}
		TITLE_CODES["1501"]["title"] = "ASSOCIATE IN __-ACAD YR-GSHIP"
		TITLE_CODES["1501"]["program"] = "ACADEMIC"
		TITLE_CODES["1501"]["unit"] = "BX"

	TITLE_CODES["1506"] = {}
		TITLE_CODES["1506"]["title"] = "ASSOC IN __ -ACAD YR-1/9-GSHIP"
		TITLE_CODES["1506"]["program"] = "ACADEMIC"
		TITLE_CODES["1506"]["unit"] = "BX"

	TITLE_CODES["1507"] = {}
		TITLE_CODES["1507"]["title"] = "ASSOC IN__-AY- 1/9 -NON-GSHIP"
		TITLE_CODES["1507"]["program"] = "ACADEMIC"
		TITLE_CODES["1507"]["unit"] = "BX"

	TITLE_CODES["9095"] = {}
		TITLE_CODES["9095"]["title"] = "REPRESENTATIVE, ACCESS, SR.,PD"
		TITLE_CODES["9095"]["program"] = "PSS"
		TITLE_CODES["9095"]["unit"] = "EX"

	TITLE_CODES["3085"] = {}
		TITLE_CODES["3085"]["title"] = "ACT AST---IN THE AES-AY-1/9"
		TITLE_CODES["3085"]["program"] = "ACADEMIC"
		TITLE_CODES["3085"]["unit"] = "99"

	TITLE_CODES["3084"] = {}
		TITLE_CODES["3084"]["title"] = "ACT AST---IN THE AES-ACAD YR"
		TITLE_CODES["3084"]["program"] = "ACADEMIC"
		TITLE_CODES["3084"]["unit"] = "99"

	TITLE_CODES["3087"] = {}
		TITLE_CODES["3087"]["title"] = "ACT AST--IN AES-B/ECN/EN-AY1/9"
		TITLE_CODES["3087"]["program"] = "ACADEMIC"
		TITLE_CODES["3087"]["unit"] = "99"

	TITLE_CODES["3086"] = {}
		TITLE_CODES["3086"]["title"] = "ACT AST---IN AES-B/ECON/ENG-AY"
		TITLE_CODES["3086"]["program"] = "ACADEMIC"
		TITLE_CODES["3086"]["unit"] = "99"

	TITLE_CODES["3081"] = {}
		TITLE_CODES["3081"]["title"] = "AST---IN THE AES-ACAD YR-1/9TH"
		TITLE_CODES["3081"]["program"] = "ACADEMIC"
		TITLE_CODES["3081"]["unit"] = "FX"

	TITLE_CODES["3080"] = {}
		TITLE_CODES["3080"]["title"] = "AST---IN THE AES-ACADEMIC YEAR"
		TITLE_CODES["3080"]["program"] = "ACADEMIC"
		TITLE_CODES["3080"]["unit"] = "FX"

	TITLE_CODES["3083"] = {}
		TITLE_CODES["3083"]["title"] = "AST---IN AES-B/ECON/ENG-AY-1/9"
		TITLE_CODES["3083"]["program"] = "ACADEMIC"
		TITLE_CODES["3083"]["unit"] = "FX"

	TITLE_CODES["3082"] = {}
		TITLE_CODES["3082"]["title"] = "AST---IN THE AES-B/ECON/ENG-AY"
		TITLE_CODES["3082"]["program"] = "ACADEMIC"
		TITLE_CODES["3082"]["unit"] = "FX"

	TITLE_CODES["8076"] = {}
		TITLE_CODES["8076"]["title"] = "LABORER"
		TITLE_CODES["8076"]["program"] = "PSS"
		TITLE_CODES["8076"]["unit"] = "SX"

	TITLE_CODES["1644"] = {}
		TITLE_CODES["1644"]["title"] = "SENIOR LECTURER - FISCAL YR"
		TITLE_CODES["1644"]["program"] = "ACADEMIC"
		TITLE_CODES["1644"]["unit"] = "IX"

	TITLE_CODES["8475"] = {}
		TITLE_CODES["8475"]["title"] = "ATTENDANT, AUTOMOTIVE"
		TITLE_CODES["8475"]["program"] = "PSS"
		TITLE_CODES["8475"]["unit"] = "SX"

	TITLE_CODES["8474"] = {}
		TITLE_CODES["8474"]["title"] = "TECHNICIAN, AUTOMOTIVE ASSIST"
		TITLE_CODES["8474"]["program"] = "PSS"
		TITLE_CODES["8474"]["unit"] = "SX"

	TITLE_CODES["8477"] = {}
		TITLE_CODES["8477"]["title"] = "TECH., HVY DUTY MECHANIC, ASST"
		TITLE_CODES["8477"]["program"] = "PSS"
		TITLE_CODES["8477"]["unit"] = "SX"

	TITLE_CODES["8476"] = {}
		TITLE_CODES["8476"]["title"] = "TECH., HEAVY DUTY MECH."
		TITLE_CODES["8476"]["program"] = "PSS"
		TITLE_CODES["8476"]["unit"] = "SX"

	TITLE_CODES["8471"] = {}
		TITLE_CODES["8471"]["title"] = "TECHNICIAN, AUTOMOTIVE SUPV"
		TITLE_CODES["8471"]["program"] = "PSS"
		TITLE_CODES["8471"]["unit"] = "99"

	TITLE_CODES["8470"] = {}
		TITLE_CODES["8470"]["title"] = "ATTENDANT, AUTOMOTIVE - SUPVR"
		TITLE_CODES["8470"]["program"] = "PSS"
		TITLE_CODES["8470"]["unit"] = "99"

	TITLE_CODES["8473"] = {}
		TITLE_CODES["8473"]["title"] = "TECHNICIAN, AUTOMOTIVE"
		TITLE_CODES["8473"]["program"] = "PSS"
		TITLE_CODES["8473"]["unit"] = "SX"

	TITLE_CODES["7619"] = {}
		TITLE_CODES["7619"]["title"] = "ACCOUNTANT, ASST"
		TITLE_CODES["7619"]["program"] = "PSS"
		TITLE_CODES["7619"]["unit"] = "99"

	TITLE_CODES["7643"] = {}
		TITLE_CODES["7643"]["title"] = "EMPLOYMENT REPRESENTATIVE, SR"
		TITLE_CODES["7643"]["program"] = "PSS"
		TITLE_CODES["7643"]["unit"] = "99"

	TITLE_CODES["10"] = {}
		TITLE_CODES["10"]["title"] = "PROVOST AND SR VP--ACAD AFF"
		TITLE_CODES["10"]["program"] = "MSP"
		TITLE_CODES["10"]["unit"] = "99"

	TITLE_CODES["12"] = {}
		TITLE_CODES["12"]["title"] = "SR. VICE PRES--DESIGNATE"
		TITLE_CODES["12"]["program"] = "MSP"
		TITLE_CODES["12"]["unit"] = "99"

	TITLE_CODES["15"] = {}
		TITLE_CODES["15"]["title"] = "VICE PRES (FUNCTIONAL AREA)"
		TITLE_CODES["15"]["program"] = "MSP"
		TITLE_CODES["15"]["unit"] = "99"

	TITLE_CODES["14"] = {}
		TITLE_CODES["14"]["title"] = "SR VICE PRES--BUS & FINANCE"
		TITLE_CODES["14"]["program"] = "MSP"
		TITLE_CODES["14"]["unit"] = "99"

	TITLE_CODES["17"] = {}
		TITLE_CODES["17"]["title"] = "VICE PRES--HEALTH AFF"
		TITLE_CODES["17"]["program"] = "MSP"
		TITLE_CODES["17"]["unit"] = "99"

	TITLE_CODES["16"] = {}
		TITLE_CODES["16"]["title"] = "V. PRES-AGRI AND NAT RES."
		TITLE_CODES["16"]["program"] = "MSP"
		TITLE_CODES["16"]["unit"] = "99"

	TITLE_CODES["19"] = {}
		TITLE_CODES["19"]["title"] = "VP--CLINICAL SERVICES DEV."
		TITLE_CODES["19"]["program"] = "MSP"
		TITLE_CODES["19"]["unit"] = "99"

	TITLE_CODES["18"] = {}
		TITLE_CODES["18"]["title"] = "SENIOR VP - UNIVERSITY AFFAIRS"
		TITLE_CODES["18"]["program"] = "MSP"
		TITLE_CODES["18"]["unit"] = "99"

	TITLE_CODES["7774"] = {}
		TITLE_CODES["7774"]["title"] = "BUYER II"
		TITLE_CODES["7774"]["program"] = "PSS"
		TITLE_CODES["7774"]["unit"] = "99"

	TITLE_CODES["9196"] = {}
		TITLE_CODES["9196"]["title"] = "DENTAL ASST, REGISTERED"
		TITLE_CODES["9196"]["program"] = "PSS"
		TITLE_CODES["9196"]["unit"] = "EX"

	TITLE_CODES["9301"] = {}
		TITLE_CODES["9301"]["title"] = "ANGIOGRAPHY TECHNOLOGIST"
		TITLE_CODES["9301"]["program"] = "PSS"
		TITLE_CODES["9301"]["unit"] = "EX"

	TITLE_CODES["9308"] = {}
		TITLE_CODES["9308"]["title"] = "SOCIAL WORKER I"
		TITLE_CODES["9308"]["program"] = "PSS"
		TITLE_CODES["9308"]["unit"] = "HX"

	TITLE_CODES["5292"] = {}
		TITLE_CODES["5292"]["title"] = "SECURITY OFFICER, MED CENTER"
		TITLE_CODES["5292"]["program"] = "PSS"
		TITLE_CODES["5292"]["unit"] = "SX"

	TITLE_CODES["4666"] = {}
		TITLE_CODES["4666"]["title"] = "BILLER, PATIENT III, P.D."
		TITLE_CODES["4666"]["program"] = "PSS"
		TITLE_CODES["4666"]["unit"] = "EX"

	TITLE_CODES["7642"] = {}
		TITLE_CODES["7642"]["title"] = "HR ANALYST VII - SUPERVISOR"
		TITLE_CODES["7642"]["program"] = "PSS"
		TITLE_CODES["7642"]["unit"] = "99"

	TITLE_CODES["9309"] = {}
		TITLE_CODES["9309"]["title"] = "SOCIAL WORKER, PER DIEM, II"
		TITLE_CODES["9309"]["program"] = "PSS"
		TITLE_CODES["9309"]["unit"] = "HX"

	TITLE_CODES["4667"] = {}
		TITLE_CODES["4667"]["title"] = "BILLER PATIENT II, PER DIEM"
		TITLE_CODES["4667"]["program"] = "PSS"
		TITLE_CODES["4667"]["unit"] = "EX"

	TITLE_CODES["4761"] = {}
		TITLE_CODES["4761"]["title"] = "REPROGRAPHICS SUPV, SR"
		TITLE_CODES["4761"]["program"] = "PSS"
		TITLE_CODES["4761"]["unit"] = "99"

	TITLE_CODES["4763"] = {}
		TITLE_CODES["4763"]["title"] = "TECHNICIAN, REPROGRAPHICS,PRIN"
		TITLE_CODES["4763"]["program"] = "PSS"
		TITLE_CODES["4763"]["unit"] = "SX"

	TITLE_CODES["4762"] = {}
		TITLE_CODES["4762"]["title"] = "TECHNICIAN, REPROGRAPHICS,LEAD"
		TITLE_CODES["4762"]["program"] = "PSS"
		TITLE_CODES["4762"]["unit"] = "SX"

	TITLE_CODES["4765"] = {}
		TITLE_CODES["4765"]["title"] = "TECHNICIAN, REPROGRAPHICS"
		TITLE_CODES["4765"]["program"] = "PSS"
		TITLE_CODES["4765"]["unit"] = "SX"

	TITLE_CODES["4764"] = {}
		TITLE_CODES["4764"]["title"] = "TECHNICIAN, REPROGRAPHICS, SR"
		TITLE_CODES["4764"]["program"] = "PSS"
		TITLE_CODES["4764"]["unit"] = "SX"

	TITLE_CODES["4766"] = {}
		TITLE_CODES["4766"]["title"] = "TECHNICIAN, REPROGRAPHICS,ASST"
		TITLE_CODES["4766"]["program"] = "PSS"
		TITLE_CODES["4766"]["unit"] = "SX"

	TITLE_CODES["4768"] = {}
		TITLE_CODES["4768"]["title"] = "REPROGRAPHICS SUPVR"
		TITLE_CODES["4768"]["program"] = "PSS"
		TITLE_CODES["4768"]["unit"] = "99"

	TITLE_CODES["7641"] = {}
		TITLE_CODES["7641"]["title"] = "EMPLOYMENT OFFICER"
		TITLE_CODES["7641"]["program"] = "PSS"
		TITLE_CODES["7641"]["unit"] = "99"

	TITLE_CODES["9449"] = {}
		TITLE_CODES["9449"]["title"] = "REHAB SERVICE ASSOC CHIEF"
		TITLE_CODES["9449"]["program"] = "PSS"
		TITLE_CODES["9449"]["unit"] = "99"

	TITLE_CODES["9307"] = {}
		TITLE_CODES["9307"]["title"] = "SOCIAL WORKER II"
		TITLE_CODES["9307"]["program"] = "PSS"
		TITLE_CODES["9307"]["unit"] = "HX"

	TITLE_CODES["8539"] = {}
		TITLE_CODES["8539"]["title"] = "FARM WORKER"
		TITLE_CODES["8539"]["program"] = "PSS"
		TITLE_CODES["8539"]["unit"] = "SX"

	TITLE_CODES["4000"] = {}
		TITLE_CODES["4000"]["title"] = "STUDENT AID, OUTSIDE AGENCY"
		TITLE_CODES["4000"]["program"] = "PSS"
		TITLE_CODES["4000"]["unit"] = "99"

	TITLE_CODES["4001"] = {}
		TITLE_CODES["4001"]["title"] = "RECREATION SUPVR, PRIN"
		TITLE_CODES["4001"]["program"] = "PSS"
		TITLE_CODES["4001"]["unit"] = "99"

	TITLE_CODES["4002"] = {}
		TITLE_CODES["4002"]["title"] = "RECREATION SUPVR, SR"
		TITLE_CODES["4002"]["program"] = "PSS"
		TITLE_CODES["4002"]["unit"] = "99"

	TITLE_CODES["4003"] = {}
		TITLE_CODES["4003"]["title"] = "RECREATION SUPVR"
		TITLE_CODES["4003"]["program"] = "PSS"
		TITLE_CODES["4003"]["unit"] = "99"

	TITLE_CODES["4004"] = {}
		TITLE_CODES["4004"]["title"] = "RECREATION SUPVR,ASST"
		TITLE_CODES["4004"]["program"] = "PSS"
		TITLE_CODES["4004"]["unit"] = "99"

	TITLE_CODES["4005"] = {}
		TITLE_CODES["4005"]["title"] = "COACH, INTERCOL ATHLETICS,HEAD"
		TITLE_CODES["4005"]["program"] = "PSS"
		TITLE_CODES["4005"]["unit"] = "99"

	TITLE_CODES["4006"] = {}
		TITLE_CODES["4006"]["title"] = "COACH/SPECIALIST"
		TITLE_CODES["4006"]["program"] = "PSS"
		TITLE_CODES["4006"]["unit"] = "99"

	TITLE_CODES["4007"] = {}
		TITLE_CODES["4007"]["title"] = "COACH, INTERCOL ATHLETICS,ASST"
		TITLE_CODES["4007"]["program"] = "PSS"
		TITLE_CODES["4007"]["unit"] = "99"

	TITLE_CODES["9302"] = {}
		TITLE_CODES["9302"]["title"] = "ANGIOGRAPHY TECHNOLOGIST, PD"
		TITLE_CODES["9302"]["program"] = "PSS"
		TITLE_CODES["9302"]["unit"] = "EX"

	TITLE_CODES["9053"] = {}
		TITLE_CODES["9053"]["title"] = "THERAPIST,RESPIRATORY II-SUPVR"
		TITLE_CODES["9053"]["program"] = "PSS"
		TITLE_CODES["9053"]["unit"] = "99"

	TITLE_CODES["9898"] = {}
		TITLE_CODES["9898"]["title"] = "ADMIN STIPEND - NONEXEMPT"
		TITLE_CODES["9898"]["program"] = "PSS"
		TITLE_CODES["9898"]["unit"] = "99"

	TITLE_CODES["8653"] = {}
		TITLE_CODES["8653"]["title"] = "MECHANICIAN, LAB"
		TITLE_CODES["8653"]["program"] = "PSS"
		TITLE_CODES["8653"]["unit"] = "TX"

	TITLE_CODES["5098"] = {}
		TITLE_CODES["5098"]["title"] = "BAKER, MC"
		TITLE_CODES["5098"]["program"] = "PSS"
		TITLE_CODES["5098"]["unit"] = "SX"

	TITLE_CODES["758"] = {}
		TITLE_CODES["758"]["title"] = "SENIOR CHIEF ENGINEER"
		TITLE_CODES["758"]["program"] = "MSP"
		TITLE_CODES["758"]["unit"] = "99"

	TITLE_CODES["9601"] = {}
		TITLE_CODES["9601"]["title"] = "LABORATORY ASST IV"
		TITLE_CODES["9601"]["program"] = "PSS"
		TITLE_CODES["9601"]["unit"] = "TX"

	TITLE_CODES["5099"] = {}
		TITLE_CODES["5099"]["title"] = "CUSTODIAN, SR, PER DIEM"
		TITLE_CODES["5099"]["program"] = "PSS"
		TITLE_CODES["5099"]["unit"] = "SX"

	TITLE_CODES["209"] = {}
		TITLE_CODES["209"]["title"] = "ASSOC. VICE CHAN.(FTL. AREA)"
		TITLE_CODES["209"]["program"] = "MSP"
		TITLE_CODES["209"]["unit"] = "99"

	TITLE_CODES["3620"] = {}
		TITLE_CODES["3620"]["title"] = "ASST LIBRARIAN-CAREER STATUS"
		TITLE_CODES["3620"]["program"] = "ACADEMIC"
		TITLE_CODES["3620"]["unit"] = "LX"

	TITLE_CODES["3623"] = {}
		TITLE_CODES["3623"]["title"] = "VSTG ASST LIBRARIAN-FISCAL YR"
		TITLE_CODES["3623"]["program"] = "ACADEMIC"
		TITLE_CODES["3623"]["unit"] = "99"

	TITLE_CODES["3622"] = {}
		TITLE_CODES["3622"]["title"] = "ASST LIBRARIAN-TEMP STATUS"
		TITLE_CODES["3622"]["program"] = "ACADEMIC"
		TITLE_CODES["3622"]["unit"] = "LX"

	TITLE_CODES["7245"] = {}
		TITLE_CODES["7245"]["title"] = "ANALYST I-SUPERVISOR"
		TITLE_CODES["7245"]["program"] = "PSS"
		TITLE_CODES["7245"]["unit"] = "99"

	TITLE_CODES["7509"] = {}
		TITLE_CODES["7509"]["title"] = "MANAGEMENT SRV OFFICER SUPV"
		TITLE_CODES["7509"]["program"] = "PSS"
		TITLE_CODES["7509"]["unit"] = "99"

	TITLE_CODES["3477"] = {}
		TITLE_CODES["3477"]["title"] = "ASSOC SPECIALIST IN COOP EXT"
		TITLE_CODES["3477"]["program"] = "ACADEMIC"
		TITLE_CODES["3477"]["unit"] = "FX"

	TITLE_CODES["9527"] = {}
		TITLE_CODES["9527"]["title"] = "TECHNICIAN, ANIMAL, SR - SUPVR"
		TITLE_CODES["9527"]["program"] = "PSS"
		TITLE_CODES["9527"]["unit"] = "99"

	TITLE_CODES["7181"] = {}
		TITLE_CODES["7181"]["title"] = "ENGINEER, DEVELOPMENT, SR"
		TITLE_CODES["7181"]["program"] = "PSS"
		TITLE_CODES["7181"]["unit"] = "99"

	TITLE_CODES["8888"] = {}
		TITLE_CODES["8888"]["title"] = "TECHNICIAN, CARDIOVASCULAR PD"
		TITLE_CODES["8888"]["program"] = "PSS"
		TITLE_CODES["8888"]["unit"] = "EX"

	TITLE_CODES["7182"] = {}
		TITLE_CODES["7182"]["title"] = "ENGINEER, DEVELOPMENT, ASSOC"
		TITLE_CODES["7182"]["program"] = "PSS"
		TITLE_CODES["7182"]["unit"] = "99"

	TITLE_CODES["3300"] = {}
		TITLE_CODES["3300"]["title"] = "SPECIALIST"
		TITLE_CODES["3300"]["program"] = "ACADEMIC"
		TITLE_CODES["3300"]["unit"] = "FX"

	TITLE_CODES["8889"] = {}
		TITLE_CODES["8889"]["title"] = "TECHNICIAN, CARDIOVASCULAR"
		TITLE_CODES["8889"]["program"] = "PSS"
		TITLE_CODES["8889"]["unit"] = "EX"

	TITLE_CODES["4714"] = {}
		TITLE_CODES["4714"]["title"] = "ABSTRACTOR, PATIENT REC IV, PD"
		TITLE_CODES["4714"]["program"] = "PSS"
		TITLE_CODES["4714"]["unit"] = "EX"

	TITLE_CODES["4715"] = {}
		TITLE_CODES["4715"]["title"] = "ABSTRACTOR, PATIENT REC III,PD"
		TITLE_CODES["4715"]["program"] = "PSS"
		TITLE_CODES["4715"]["unit"] = "EX"

	TITLE_CODES["4716"] = {}
		TITLE_CODES["4716"]["title"] = "ABSTRACTOR, PATIENT RECORD IV"
		TITLE_CODES["4716"]["program"] = "PSS"
		TITLE_CODES["4716"]["unit"] = "EX"

	TITLE_CODES["4717"] = {}
		TITLE_CODES["4717"]["title"] = "ABSTRACTOR, PATIENT RECORD III"
		TITLE_CODES["4717"]["program"] = "PSS"
		TITLE_CODES["4717"]["unit"] = "EX"

	TITLE_CODES["3071"] = {}
		TITLE_CODES["3071"]["title"] = "ASO---IN THE AES-ACAD YR-1/9TH"
		TITLE_CODES["3071"]["program"] = "ACADEMIC"
		TITLE_CODES["3071"]["unit"] = "FX"

	TITLE_CODES["8642"] = {}
		TITLE_CODES["8642"]["title"] = "TECHNICIAN, DEV, III-MEDFAC"
		TITLE_CODES["8642"]["program"] = "PSS"
		TITLE_CODES["8642"]["unit"] = "EX"

	TITLE_CODES["4718"] = {}
		TITLE_CODES["4718"]["title"] = "ABSTRACTOR, PATIENT RECORD II"
		TITLE_CODES["4718"]["program"] = "PSS"
		TITLE_CODES["4718"]["unit"] = "EX"

	TITLE_CODES["4719"] = {}
		TITLE_CODES["4719"]["title"] = "ABSTRACTOR, PATIENT RECORD I"
		TITLE_CODES["4719"]["program"] = "PSS"
		TITLE_CODES["4719"]["unit"] = "EX"

	TITLE_CODES["7185"] = {}
		TITLE_CODES["7185"]["title"] = "DEVELOPMENT ENGINEER SUPV"
		TITLE_CODES["7185"]["program"] = "PSS"
		TITLE_CODES["7185"]["unit"] = "99"

	TITLE_CODES["7360"] = {}
		TITLE_CODES["7360"]["title"] = "HR ANALYST VII"
		TITLE_CODES["7360"]["program"] = "PSS"
		TITLE_CODES["7360"]["unit"] = "99"

	TITLE_CODES["9607"] = {}
		TITLE_CODES["9607"]["title"] = "MEDICAL LABORATORY TECHNICIAN"
		TITLE_CODES["9607"]["program"] = "PSS"
		TITLE_CODES["9607"]["unit"] = "EX"

	TITLE_CODES["7640"] = {}
		TITLE_CODES["7640"]["title"] = "EMPLOYMENT OFFICER, SR"
		TITLE_CODES["7640"]["program"] = "PSS"
		TITLE_CODES["7640"]["unit"] = "99"

	TITLE_CODES["9520"] = {}
		TITLE_CODES["9520"]["title"] = "SPECTROSCOPIST"
		TITLE_CODES["9520"]["program"] = "PSS"
		TITLE_CODES["9520"]["unit"] = "RX"

	TITLE_CODES["7186"] = {}
		TITLE_CODES["7186"]["title"] = "SR DEV ENGR SUPERVISOR"
		TITLE_CODES["7186"]["program"] = "PSS"
		TITLE_CODES["7186"]["unit"] = "99"

	TITLE_CODES["7361"] = {}
		TITLE_CODES["7361"]["title"] = "HR ANALYST VIII"
		TITLE_CODES["7361"]["program"] = "PSS"
		TITLE_CODES["7361"]["unit"] = "99"

	TITLE_CODES["7647"] = {}
		TITLE_CODES["7647"]["title"] = "HR ANALYST II"
		TITLE_CODES["7647"]["program"] = "PSS"
		TITLE_CODES["7647"]["unit"] = "99"

	TITLE_CODES["7187"] = {}
		TITLE_CODES["7187"]["title"] = "ASSOC DEV ENG - SUPERVISOR"
		TITLE_CODES["7187"]["program"] = "PSS"
		TITLE_CODES["7187"]["unit"] = "99"

	TITLE_CODES["8886"] = {}
		TITLE_CODES["8886"]["title"] = "SPECIALIST, CLINICAL, SUPVR"
		TITLE_CODES["8886"]["program"] = "PSS"
		TITLE_CODES["8886"]["unit"] = "99"

	TITLE_CODES["7646"] = {}
		TITLE_CODES["7646"]["title"] = "ADMIN. SPECIALIST"
		TITLE_CODES["7646"]["program"] = "PSS"
		TITLE_CODES["7646"]["unit"] = "99"

	TITLE_CODES["7363"] = {}
		TITLE_CODES["7363"]["title"] = "ANALYST IX"
		TITLE_CODES["7363"]["program"] = "PSS"
		TITLE_CODES["7363"]["unit"] = "99"

	TITLE_CODES["3710"] = {}
		TITLE_CODES["3710"]["title"] = "ASSOC FACULTY CONSULTANT IN---"
		TITLE_CODES["3710"]["program"] = "ACADEMIC"
		TITLE_CODES["3710"]["unit"] = "99"

	TITLE_CODES["9472"] = {}
		TITLE_CODES["9472"]["title"] = "PATHOLOGIST, SPEECH, SR"
		TITLE_CODES["9472"]["program"] = "PSS"
		TITLE_CODES["9472"]["unit"] = "HX"

	TITLE_CODES["7364"] = {}
		TITLE_CODES["7364"]["title"] = "ANALYST X"
		TITLE_CODES["7364"]["program"] = "PSS"
		TITLE_CODES["7364"]["unit"] = "99"

	TITLE_CODES["3077"] = {}
		TITLE_CODES["3077"]["title"] = "ACT ASO--IN AES-B/EC/EN-AY-1/9"
		TITLE_CODES["3077"]["program"] = "ACADEMIC"
		TITLE_CODES["3077"]["unit"] = "99"

	TITLE_CODES["9474"] = {}
		TITLE_CODES["9474"]["title"] = "AUDIOLOGIST, SR"
		TITLE_CODES["9474"]["program"] = "PSS"
		TITLE_CODES["9474"]["unit"] = "HX"

	TITLE_CODES["3570"] = {}
		TITLE_CODES["3570"]["title"] = "TEACHER-UNIV.EXT.-CONTRACT YR."
		TITLE_CODES["3570"]["program"] = "ACADEMIC"
		TITLE_CODES["3570"]["unit"] = "99"

	TITLE_CODES["9457"] = {}
		TITLE_CODES["9457"]["title"] = "ATHLETIC TRAINER, SUPERVISING"
		TITLE_CODES["9457"]["program"] = "PSS"
		TITLE_CODES["9457"]["unit"] = "99"

	TITLE_CODES["7645"] = {}
		TITLE_CODES["7645"]["title"] = "EMPLOYMENT REPRESENTATIVE,ASST"
		TITLE_CODES["7645"]["program"] = "PSS"
		TITLE_CODES["7645"]["unit"] = "99"

	TITLE_CODES["2090"] = {}
		TITLE_CODES["2090"]["title"] = "CLIN AFFILIATE - VSTG - FOR MD"
		TITLE_CODES["2090"]["program"] = "ACADEMIC"
		TITLE_CODES["2090"]["unit"] = "99"

	TITLE_CODES["8189"] = {}
		TITLE_CODES["8189"]["title"] = "ROOFER"
		TITLE_CODES["8189"]["program"] = "PSS"
		TITLE_CODES["8189"]["unit"] = "K3"

	TITLE_CODES["7248"] = {}
		TITLE_CODES["7248"]["title"] = "ANALYST IV-SUPERVISOR"
		TITLE_CODES["7248"]["program"] = "PSS"
		TITLE_CODES["7248"]["unit"] = "99"

	TITLE_CODES["3650"] = {}
		TITLE_CODES["3650"]["title"] = "CURATOR"
		TITLE_CODES["3650"]["program"] = "ACADEMIC"
		TITLE_CODES["3650"]["unit"] = "FX"

	TITLE_CODES["3651"] = {}
		TITLE_CODES["3651"]["title"] = "ASSOCIATE CURATOR"
		TITLE_CODES["3651"]["program"] = "ACADEMIC"
		TITLE_CODES["3651"]["unit"] = "FX"

	TITLE_CODES["3652"] = {}
		TITLE_CODES["3652"]["title"] = "ASSISTANT CURATOR"
		TITLE_CODES["3652"]["program"] = "ACADEMIC"
		TITLE_CODES["3652"]["unit"] = "FX"

	TITLE_CODES["2521"] = {}
		TITLE_CODES["2521"]["title"] = "TUTOR-NON-STUDENT/NON-REP"
		TITLE_CODES["2521"]["program"] = "ACADEMIC"
		TITLE_CODES["2521"]["unit"] = "99"

	TITLE_CODES["2520"] = {}
		TITLE_CODES["2520"]["title"] = "READER-NON-STUDENT/NON-REP"
		TITLE_CODES["2520"]["program"] = "ACADEMIC"
		TITLE_CODES["2520"]["unit"] = "99"

	TITLE_CODES["4678"] = {}
		TITLE_CODES["4678"]["title"] = "BILLER, HOSPITAL"
		TITLE_CODES["4678"]["program"] = "PSS"
		TITLE_CODES["4678"]["unit"] = "EX"

	TITLE_CODES["4677"] = {}
		TITLE_CODES["4677"]["title"] = "BILLER, HOSPITAL, SR"
		TITLE_CODES["4677"]["program"] = "PSS"
		TITLE_CODES["4677"]["unit"] = "EX"

	TITLE_CODES["9026"] = {}
		TITLE_CODES["9026"]["title"] = "TECHNOLOGIST,RAD,PRIN,PER DIEM"
		TITLE_CODES["9026"]["program"] = "PSS"
		TITLE_CODES["9026"]["unit"] = "EX"

	TITLE_CODES["4674"] = {}
		TITLE_CODES["4674"]["title"] = "CLERK, PER DIEM"
		TITLE_CODES["4674"]["program"] = "PSS"
		TITLE_CODES["4674"]["unit"] = "CX"

	TITLE_CODES["4673"] = {}
		TITLE_CODES["4673"]["title"] = "CLERK"
		TITLE_CODES["4673"]["program"] = "PSS"
		TITLE_CODES["4673"]["unit"] = "CX"

	TITLE_CODES["4672"] = {}
		TITLE_CODES["4672"]["title"] = "CLERK, SR/SECRETARY"
		TITLE_CODES["4672"]["program"] = "PSS"
		TITLE_CODES["4672"]["unit"] = "CX"

	TITLE_CODES["4671"] = {}
		TITLE_CODES["4671"]["title"] = "SR CLERK/SECRETARY, PER DIEM"
		TITLE_CODES["4671"]["program"] = "PSS"
		TITLE_CODES["4671"]["unit"] = "CX"

	TITLE_CODES["9344"] = {}
		TITLE_CODES["9344"]["title"] = "CHILD DEVELOPMENT SUPVR"
		TITLE_CODES["9344"]["program"] = "PSS"
		TITLE_CODES["9344"]["unit"] = "99"

	TITLE_CODES["9366"] = {}
		TITLE_CODES["9366"]["title"] = "FIELD WORK ASST"
		TITLE_CODES["9366"]["program"] = "PSS"
		TITLE_CODES["9366"]["unit"] = "99"

	TITLE_CODES["7644"] = {}
		TITLE_CODES["7644"]["title"] = "EMPLOYMENT REPRESENTATIVE"
		TITLE_CODES["7644"]["program"] = "PSS"
		TITLE_CODES["7644"]["unit"] = "99"

	TITLE_CODES["9117"] = {}
		TITLE_CODES["9117"]["title"] = "HOME HEALTH NURSE II"
		TITLE_CODES["9117"]["program"] = "PSS"
		TITLE_CODES["9117"]["unit"] = "NX"

	TITLE_CODES["8188"] = {}
		TITLE_CODES["8188"]["title"] = "MECHANIC, ELEVATOR"
		TITLE_CODES["8188"]["program"] = "PSS"
		TITLE_CODES["8188"]["unit"] = "K3"

	TITLE_CODES["2245"] = {}
		TITLE_CODES["2245"]["title"] = "COORDINATOR OF FIELD WORK-FY"
		TITLE_CODES["2245"]["program"] = "ACADEMIC"
		TITLE_CODES["2245"]["unit"] = "IX"

	TITLE_CODES["2246"] = {}
		TITLE_CODES["2246"]["title"] = "COORD.OF FLD.WK-FY-CONTINUING"
		TITLE_CODES["2246"]["program"] = "ACADEMIC"
		TITLE_CODES["2246"]["unit"] = "IX"

	TITLE_CODES["2240"] = {}
		TITLE_CODES["2240"]["title"] = "COORDINATOR OF FIELD WORK - AY"
		TITLE_CODES["2240"]["program"] = "ACADEMIC"
		TITLE_CODES["2240"]["unit"] = "IX"

	TITLE_CODES["2241"] = {}
		TITLE_CODES["2241"]["title"] = "COORD.OF FLD.WK-AY-CONTINUING"
		TITLE_CODES["2241"]["program"] = "ACADEMIC"
		TITLE_CODES["2241"]["unit"] = "IX"

	TITLE_CODES["8144"] = {}
		TITLE_CODES["8144"]["title"] = "GROUNDSKEEPER, PER DIEM"
		TITLE_CODES["8144"]["program"] = "PSS"
		TITLE_CODES["8144"]["unit"] = "SX"

	TITLE_CODES["5065"] = {}
		TITLE_CODES["5065"]["title"] = "STOREKEEPER, ASST"
		TITLE_CODES["5065"]["program"] = "PSS"
		TITLE_CODES["5065"]["unit"] = "SX"

	TITLE_CODES["5064"] = {}
		TITLE_CODES["5064"]["title"] = "STOREKEEPER"
		TITLE_CODES["5064"]["program"] = "PSS"
		TITLE_CODES["5064"]["unit"] = "SX"

	TITLE_CODES["9170"] = {}
		TITLE_CODES["9170"]["title"] = "MANAGER, CASE"
		TITLE_CODES["9170"]["program"] = "PSS"
		TITLE_CODES["9170"]["unit"] = "HX"

	TITLE_CODES["5066"] = {}
		TITLE_CODES["5066"]["title"] = "DELIVERY WORKER"
		TITLE_CODES["5066"]["program"] = "PSS"
		TITLE_CODES["5066"]["unit"] = "SX"

	TITLE_CODES["2460"] = {}
		TITLE_CODES["2460"]["title"] = "TEACHER - SPECIAL PROGRAMS"
		TITLE_CODES["2460"]["program"] = "ACADEMIC"
		TITLE_CODES["2460"]["unit"] = "IX"

	TITLE_CODES["2461"] = {}
		TITLE_CODES["2461"]["title"] = "TEACHER-SPEC PROG-CONTINUING"
		TITLE_CODES["2461"]["program"] = "ACADEMIC"
		TITLE_CODES["2461"]["unit"] = "IX"

	TITLE_CODES["5063"] = {}
		TITLE_CODES["5063"]["title"] = "STORES WORKER"
		TITLE_CODES["5063"]["program"] = "PSS"
		TITLE_CODES["5063"]["unit"] = "SX"

	TITLE_CODES["5062"] = {}
		TITLE_CODES["5062"]["title"] = "STOREKEEPER, SR"
		TITLE_CODES["5062"]["program"] = "PSS"
		TITLE_CODES["5062"]["unit"] = "SX"

	TITLE_CODES["9278"] = {}
		TITLE_CODES["9278"]["title"] = "PHARMACY TECHNICIAN II, P.D."
		TITLE_CODES["9278"]["program"] = "PSS"
		TITLE_CODES["9278"]["unit"] = "EX"

	TITLE_CODES["2704"] = {}
		TITLE_CODES["2704"]["title"] = "INTERN-DIETETIC/NON-REP"
		TITLE_CODES["2704"]["program"] = "ACADEMIC"
		TITLE_CODES["2704"]["unit"] = "99"

	TITLE_CODES["5069"] = {}
		TITLE_CODES["5069"]["title"] = "STOREKEEPER-SUPVR"
		TITLE_CODES["5069"]["program"] = "PSS"
		TITLE_CODES["5069"]["unit"] = "99"

	TITLE_CODES["2700"] = {}
		TITLE_CODES["2700"]["title"] = "INTERN-HOSPITAL/NON-REP"
		TITLE_CODES["2700"]["program"] = "ACADEMIC"
		TITLE_CODES["2700"]["unit"] = "99"

	TITLE_CODES["120"] = {}
		TITLE_CODES["120"]["title"] = "(FTL AREA) SUPERINTENDENT-EXEC"
		TITLE_CODES["120"]["program"] = "MSP"
		TITLE_CODES["120"]["unit"] = "99"

	TITLE_CODES["121"] = {}
		TITLE_CODES["121"]["title"] = "CHIEF OF POLICE-EXEC"
		TITLE_CODES["121"]["program"] = "MSP"
		TITLE_CODES["121"]["unit"] = "99"

	TITLE_CODES["122"] = {}
		TITLE_CODES["122"]["title"] = "VICE PROVOST (FUNCT AREA)-EXEC"
		TITLE_CODES["122"]["program"] = "MSP"
		TITLE_CODES["122"]["unit"] = "99"

	TITLE_CODES["123"] = {}
		TITLE_CODES["123"]["title"] = "ASSOC VICE PROVOST (FTL AREA)"
		TITLE_CODES["123"]["program"] = "MSP"
		TITLE_CODES["123"]["unit"] = "99"

	TITLE_CODES["125"] = {}
		TITLE_CODES["125"]["title"] = "ASST TT PRES (FUNCTIONAL AREA)"
		TITLE_CODES["125"]["program"] = "MSP"
		TITLE_CODES["125"]["unit"] = "99"

	TITLE_CODES["9179"] = {}
		TITLE_CODES["9179"]["title"] = "RADIOLOGY ASSISTANT I"
		TITLE_CODES["9179"]["program"] = "PSS"
		TITLE_CODES["9179"]["unit"] = "EX"

	TITLE_CODES["8962"] = {}
		TITLE_CODES["8962"]["title"] = "TECHNICIAN, ELECTROCARDIOG, SR"
		TITLE_CODES["8962"]["program"] = "PSS"
		TITLE_CODES["8962"]["unit"] = "EX"

	TITLE_CODES["9015"] = {}
		TITLE_CODES["9015"]["title"] = "TECHNOLOGIST,RAD THPY,PER DIEM"
		TITLE_CODES["9015"]["program"] = "PSS"
		TITLE_CODES["9015"]["unit"] = "EX"

	TITLE_CODES["9176"] = {}
		TITLE_CODES["9176"]["title"] = "PULMONARY TECHNICIAN, PER DIEM"
		TITLE_CODES["9176"]["program"] = "PSS"
		TITLE_CODES["9176"]["unit"] = "EX"

	TITLE_CODES["9175"] = {}
		TITLE_CODES["9175"]["title"] = "PULMONARY TECHNICIAN III"
		TITLE_CODES["9175"]["program"] = "PSS"
		TITLE_CODES["9175"]["unit"] = "EX"

	TITLE_CODES["7249"] = {}
		TITLE_CODES["7249"]["title"] = "ANALYST V-SUPERVISOR"
		TITLE_CODES["7249"]["program"] = "PSS"
		TITLE_CODES["7249"]["unit"] = "99"

	TITLE_CODES["9173"] = {}
		TITLE_CODES["9173"]["title"] = "PULMONARY TECHNICIAN I"
		TITLE_CODES["9173"]["program"] = "PSS"
		TITLE_CODES["9173"]["unit"] = "EX"

	TITLE_CODES["9172"] = {}
		TITLE_CODES["9172"]["title"] = "HOME HEALTH AIDE, PER DIEM"
		TITLE_CODES["9172"]["program"] = "PSS"
		TITLE_CODES["9172"]["unit"] = "EX"

	TITLE_CODES["9171"] = {}
		TITLE_CODES["9171"]["title"] = "HOME HEALTH AIDE"
		TITLE_CODES["9171"]["program"] = "PSS"
		TITLE_CODES["9171"]["unit"] = "EX"

	TITLE_CODES["5428"] = {}
		TITLE_CODES["5428"]["title"] = "DIETITIAN I"
		TITLE_CODES["5428"]["program"] = "PSS"
		TITLE_CODES["5428"]["unit"] = "HX"

	TITLE_CODES["7287"] = {}
		TITLE_CODES["7287"]["title"] = "PROGRAMMER V"
		TITLE_CODES["7287"]["program"] = "PSS"
		TITLE_CODES["7287"]["unit"] = "99"

	TITLE_CODES["9039"] = {}
		TITLE_CODES["9039"]["title"] = "PERFUSIONIST, SR, PER DIEM"
		TITLE_CODES["9039"]["program"] = "PSS"
		TITLE_CODES["9039"]["unit"] = "EX"

	TITLE_CODES["3379"] = {}
		TITLE_CODES["3379"]["title"] = "ADJ PROF-AY-1/9-BUS/ECON/ENG"
		TITLE_CODES["3379"]["program"] = "ACADEMIC"
		TITLE_CODES["3379"]["unit"] = "99"

	TITLE_CODES["4404"] = {}
		TITLE_CODES["4404"]["title"] = "PSYCHOLOGIST, COUNSELING I"
		TITLE_CODES["4404"]["program"] = "PSS"
		TITLE_CODES["4404"]["unit"] = "99"

	TITLE_CODES["8987"] = {}
		TITLE_CODES["8987"]["title"] = "TECHNOLOGIST CYTOGENETIC II"
		TITLE_CODES["8987"]["program"] = "PSS"
		TITLE_CODES["8987"]["unit"] = "EX"

	TITLE_CODES["4403"] = {}
		TITLE_CODES["4403"]["title"] = "PSYCHOLOGIST, COUNSELING II"
		TITLE_CODES["4403"]["program"] = "PSS"
		TITLE_CODES["4403"]["unit"] = "99"

	TITLE_CODES["6312"] = {}
		TITLE_CODES["6312"]["title"] = "PUBLIC EVENTS MANAGER, SR"
		TITLE_CODES["6312"]["program"] = "PSS"
		TITLE_CODES["6312"]["unit"] = "99"

	TITLE_CODES["5425"] = {}
		TITLE_CODES["5425"]["title"] = "DIETITIAN, SR-SUPVR"
		TITLE_CODES["5425"]["program"] = "PSS"
		TITLE_CODES["5425"]["unit"] = "99"

	TITLE_CODES["6310"] = {}
		TITLE_CODES["6310"]["title"] = "PUBLIC EVENTS MANAGER SUPV"
		TITLE_CODES["6310"]["program"] = "PSS"
		TITLE_CODES["6310"]["unit"] = "99"

	TITLE_CODES["5079"] = {}
		TITLE_CODES["5079"]["title"] = "STOREKEEPER, MC"
		TITLE_CODES["5079"]["program"] = "PSS"
		TITLE_CODES["5079"]["unit"] = "SX"

	TITLE_CODES["6317"] = {}
		TITLE_CODES["6317"]["title"] = "TECHNICIAN, WARDROBE, SR"
		TITLE_CODES["6317"]["program"] = "PSS"
		TITLE_CODES["6317"]["unit"] = "TX"

	TITLE_CODES["6314"] = {}
		TITLE_CODES["6314"]["title"] = "PUBLIC EVENTS MANAGER, ASST"
		TITLE_CODES["6314"]["program"] = "PSS"
		TITLE_CODES["6314"]["unit"] = "TX"

	TITLE_CODES["2140"] = {}
		TITLE_CODES["2140"]["title"] = "ASST SUPRVSR OF PHYS ED - AY"
		TITLE_CODES["2140"]["program"] = "ACADEMIC"
		TITLE_CODES["2140"]["unit"] = "99"

	TITLE_CODES["920"] = {}
		TITLE_CODES["920"]["title"] = "ASSISTANT DIRECTOR"
		TITLE_CODES["920"]["program"] = "ACADEMIC"
		TITLE_CODES["920"]["unit"] = "99"

	TITLE_CODES["2061"] = {}
		TITLE_CODES["2061"]["title"] = "CLIN INSTRUCTOR-DENT-50%/+ AY"
		TITLE_CODES["2061"]["program"] = "ACADEMIC"
		TITLE_CODES["2061"]["unit"] = "99"

	TITLE_CODES["6318"] = {}
		TITLE_CODES["6318"]["title"] = "TECHNICIAN, WARDROBE"
		TITLE_CODES["6318"]["program"] = "PSS"
		TITLE_CODES["6318"]["unit"] = "TX"

	TITLE_CODES["6319"] = {}
		TITLE_CODES["6319"]["title"] = "SR WARDROBE TECH - SUPERVISOR"
		TITLE_CODES["6319"]["program"] = "PSS"
		TITLE_CODES["6319"]["unit"] = "99"

	TITLE_CODES["5427"] = {}
		TITLE_CODES["5427"]["title"] = "DIETITIAN II-SUPVR"
		TITLE_CODES["5427"]["program"] = "PSS"
		TITLE_CODES["5427"]["unit"] = "99"

	TITLE_CODES["927"] = {}
		TITLE_CODES["927"]["title"] = "ACTING ASSISTANT DIRECTOR"
		TITLE_CODES["927"]["program"] = "ACADEMIC"
		TITLE_CODES["927"]["unit"] = "99"

	TITLE_CODES["5426"] = {}
		TITLE_CODES["5426"]["title"] = "DIETITIAN II"
		TITLE_CODES["5426"]["program"] = "PSS"
		TITLE_CODES["5426"]["unit"] = "99"

	TITLE_CODES["9098"] = {}
		TITLE_CODES["9098"]["title"] = "REPRESENTATIVE, ACCESS, SENIOR"
		TITLE_CODES["9098"]["program"] = "PSS"
		TITLE_CODES["9098"]["unit"] = "EX"

	TITLE_CODES["8983"] = {}
		TITLE_CODES["8983"]["title"] = "ORTHOPTIST"
		TITLE_CODES["8983"]["program"] = "PSS"
		TITLE_CODES["8983"]["unit"] = "HX"

	TITLE_CODES["9094"] = {}
		TITLE_CODES["9094"]["title"] = "REPRESENTATIVE, ACCESS, PD"
		TITLE_CODES["9094"]["program"] = "PSS"
		TITLE_CODES["9094"]["unit"] = "EX"

	TITLE_CODES["3373"] = {}
		TITLE_CODES["3373"]["title"] = "AST ADJ PRO-AY-1/9-B/ECON/ENG"
		TITLE_CODES["3373"]["program"] = "ACADEMIC"
		TITLE_CODES["3373"]["unit"] = "99"

	TITLE_CODES["9096"] = {}
		TITLE_CODES["9096"]["title"] = "REP, ACCESS PRIN., PD"
		TITLE_CODES["9096"]["program"] = "PSS"
		TITLE_CODES["9096"]["unit"] = "EX"

	TITLE_CODES["9097"] = {}
		TITLE_CODES["9097"]["title"] = "REPRESENTATIVE, ACCESS"
		TITLE_CODES["9097"]["program"] = "PSS"
		TITLE_CODES["9097"]["unit"] = "EX"

	TITLE_CODES["9090"] = {}
		TITLE_CODES["9090"]["title"] = "TECHNO, POLYSOMNOGRAPHY, PR"
		TITLE_CODES["9090"]["program"] = "PSS"
		TITLE_CODES["9090"]["unit"] = "EX"

	TITLE_CODES["9091"] = {}
		TITLE_CODES["9091"]["title"] = "TECHNO, POLYSOMNOGRAPHY, SR"
		TITLE_CODES["9091"]["program"] = "PSS"
		TITLE_CODES["9091"]["unit"] = "EX"

	TITLE_CODES["9092"] = {}
		TITLE_CODES["9092"]["title"] = "TECHNOLOGIST, POLYSOMNOGRAPHY"
		TITLE_CODES["9092"]["program"] = "PSS"
		TITLE_CODES["9092"]["unit"] = "EX"

	TITLE_CODES["3372"] = {}
		TITLE_CODES["3372"]["title"] = "ASST ADJ PROF-FY-BUS/ECON/ENG"
		TITLE_CODES["3372"]["program"] = "ACADEMIC"
		TITLE_CODES["3372"]["unit"] = "99"

	TITLE_CODES["3276"] = {}
		TITLE_CODES["3276"]["title"] = "GRAD STDNT RES-PARTIAL FEE REM"
		TITLE_CODES["3276"]["program"] = "ACADEMIC"
		TITLE_CODES["3276"]["unit"] = "99"

	TITLE_CODES["9164"] = {}
		TITLE_CODES["9164"]["title"] = "TECH, CENTRAL STERILE - SUPV"
		TITLE_CODES["9164"]["program"] = "PSS"
		TITLE_CODES["9164"]["unit"] = "99"

	TITLE_CODES["3274"] = {}
		TITLE_CODES["3274"]["title"] = "GRAD STDNT ASST RES- GSHIP"
		TITLE_CODES["3274"]["program"] = "ACADEMIC"
		TITLE_CODES["3274"]["unit"] = "99"

	TITLE_CODES["8993"] = {}
		TITLE_CODES["8993"]["title"] = "ASSISTANT, MEDICAL, I"
		TITLE_CODES["8993"]["program"] = "PSS"
		TITLE_CODES["8993"]["unit"] = "EX"

	TITLE_CODES["9017"] = {}
		TITLE_CODES["9017"]["title"] = "TECHNOLOGIST,RAD,PRIN-SUPVR"
		TITLE_CODES["9017"]["program"] = "PSS"
		TITLE_CODES["9017"]["unit"] = "99"

	TITLE_CODES["3273"] = {}
		TITLE_CODES["3273"]["title"] = "GRAD STDNT ASST RES-NON-GSHIP"
		TITLE_CODES["3273"]["program"] = "ACADEMIC"
		TITLE_CODES["3273"]["unit"] = "99"

	TITLE_CODES["3270"] = {}
		TITLE_CODES["3270"]["title"] = "ASST PROF IN RESIDENCE-ACAD YR"
		TITLE_CODES["3270"]["program"] = "ACADEMIC"
		TITLE_CODES["3270"]["unit"] = "A3"

	TITLE_CODES["3271"] = {}
		TITLE_CODES["3271"]["title"] = "ASST PROF IN RESIDENCE - FY"
		TITLE_CODES["3271"]["program"] = "ACADEMIC"
		TITLE_CODES["3271"]["unit"] = "A3"

	TITLE_CODES["9304"] = {}
		TITLE_CODES["9304"]["title"] = "SOCIAL WKR, CLN,ASSC CHF LCNSD"
		TITLE_CODES["9304"]["program"] = "PSS"
		TITLE_CODES["9304"]["unit"] = "99"

	TITLE_CODES["9305"] = {}
		TITLE_CODES["9305"]["title"] = "SOCL WKR, CLN, SUPRVSNG, LCNSD"
		TITLE_CODES["9305"]["program"] = "PSS"
		TITLE_CODES["9305"]["unit"] = "99"

	TITLE_CODES["9306"] = {}
		TITLE_CODES["9306"]["title"] = "SOCIAL, WORKER, CLIN, LICENSED"
		TITLE_CODES["9306"]["program"] = "PSS"
		TITLE_CODES["9306"]["unit"] = "HX"

	TITLE_CODES["1181"] = {}
		TITLE_CODES["1181"]["title"] = "PROFESSOR-LAW SCH SCALE-1/9TH"
		TITLE_CODES["1181"]["program"] = "ACADEMIC"
		TITLE_CODES["1181"]["unit"] = "A3"

	TITLE_CODES["9300"] = {}
		TITLE_CODES["9300"]["title"] = "LEAD ANGIOGRAPHY TECHNOLOGIST"
		TITLE_CODES["9300"]["program"] = "PSS"
		TITLE_CODES["9300"]["unit"] = "EX"

	TITLE_CODES["5070"] = {}
		TITLE_CODES["5070"]["title"] = "STORES SUPVR, SR"
		TITLE_CODES["5070"]["program"] = "PSS"
		TITLE_CODES["5070"]["unit"] = "99"

	TITLE_CODES["3278"] = {}
		TITLE_CODES["3278"]["title"] = "ASST ADJUNCT PROFESSOR-ACAD YR"
		TITLE_CODES["3278"]["program"] = "ACADEMIC"
		TITLE_CODES["3278"]["unit"] = "99"

	TITLE_CODES["3279"] = {}
		TITLE_CODES["3279"]["title"] = "ASST ADJUNCT PROFESSOR - FY"
		TITLE_CODES["3279"]["program"] = "ACADEMIC"
		TITLE_CODES["3279"]["unit"] = "99"

	TITLE_CODES["832"] = {}
		TITLE_CODES["832"]["title"] = "ASSISTANT HEAD OF ____"
		TITLE_CODES["832"]["program"] = "ACADEMIC"
		TITLE_CODES["832"]["unit"] = "99"

	TITLE_CODES["3475"] = {}
		TITLE_CODES["3475"]["title"] = "ASST SPECIALIST IN COOP EXT"
		TITLE_CODES["3475"]["program"] = "ACADEMIC"
		TITLE_CODES["3475"]["unit"] = "FX"

	TITLE_CODES["830"] = {}
		TITLE_CODES["830"]["title"] = "HEAD OF ____"
		TITLE_CODES["830"]["program"] = "ACADEMIC"
		TITLE_CODES["830"]["unit"] = "99"

	TITLE_CODES["831"] = {}
		TITLE_CODES["831"]["title"] = "ASSOCIATE HEAD OF ____"
		TITLE_CODES["831"]["program"] = "ACADEMIC"
		TITLE_CODES["831"]["unit"] = "99"

	TITLE_CODES["7243"] = {}
		TITLE_CODES["7243"]["title"] = "ANALYST, ADMINISTRATIVE"
		TITLE_CODES["7243"]["program"] = "PSS"
		TITLE_CODES["7243"]["unit"] = "99"

	TITLE_CODES["7242"] = {}
		TITLE_CODES["7242"]["title"] = "ANALYST, ADMINISTRATIVE, SR"
		TITLE_CODES["7242"]["program"] = "PSS"
		TITLE_CODES["7242"]["unit"] = "99"

	TITLE_CODES["7241"] = {}
		TITLE_CODES["7241"]["title"] = "ANALYST, ADMINISTRATIVE,PRIN I"
		TITLE_CODES["7241"]["program"] = "PSS"
		TITLE_CODES["7241"]["unit"] = "99"

	TITLE_CODES["7240"] = {}
		TITLE_CODES["7240"]["title"] = "ADMIN ANALYST SUPERVISOR"
		TITLE_CODES["7240"]["program"] = "PSS"
		TITLE_CODES["7240"]["unit"] = "99"

	TITLE_CODES["3575"] = {}
		TITLE_CODES["3575"]["title"] = "SPEAKER - UNIVERSITY EXTENSION"
		TITLE_CODES["3575"]["program"] = "ACADEMIC"
		TITLE_CODES["3575"]["unit"] = "99"

	TITLE_CODES["3574"] = {}
		TITLE_CODES["3574"]["title"] = "TEACHER - UNIV. EXTENSION"
		TITLE_CODES["3574"]["program"] = "ACADEMIC"
		TITLE_CODES["3574"]["unit"] = "99"

	TITLE_CODES["7362"] = {}
		TITLE_CODES["7362"]["title"] = "HR ANALYST VIII - SUPERVISOR"
		TITLE_CODES["7362"]["program"] = "PSS"
		TITLE_CODES["7362"]["unit"] = "99"

	TITLE_CODES["5093"] = {}
		TITLE_CODES["5093"]["title"] = "FOOD SERVICE WORKER, LEAD, MC"
		TITLE_CODES["5093"]["program"] = "PSS"
		TITLE_CODES["5093"]["unit"] = "SX"

	TITLE_CODES["5094"] = {}
		TITLE_CODES["5094"]["title"] = "FOOD SERVICE WORKER, PD, MC"
		TITLE_CODES["5094"]["program"] = "PSS"
		TITLE_CODES["5094"]["unit"] = "SX"

	TITLE_CODES["3479"] = {}
		TITLE_CODES["3479"]["title"] = "SPECIALIST IN COOP EXT"
		TITLE_CODES["3479"]["program"] = "ACADEMIC"
		TITLE_CODES["3479"]["unit"] = "FX"

	TITLE_CODES["5096"] = {}
		TITLE_CODES["5096"]["title"] = "FOOD SERVICE WORKER, PR, PD,MC"
		TITLE_CODES["5096"]["program"] = "PSS"
		TITLE_CODES["5096"]["unit"] = "SX"

	TITLE_CODES["3572"] = {}
		TITLE_CODES["3572"]["title"] = "ASST TEACHER - UNIV EXTENSION"
		TITLE_CODES["3572"]["program"] = "ACADEMIC"
		TITLE_CODES["3572"]["unit"] = "99"

	TITLE_CODES["8969"] = {}
		TITLE_CODES["8969"]["title"] = "TECHNOLOGIST, U/S, PRIN-SUPVR"
		TITLE_CODES["8969"]["program"] = "PSS"
		TITLE_CODES["8969"]["unit"] = "99"

	TITLE_CODES["8968"] = {}
		TITLE_CODES["8968"]["title"] = "TECHNOLOGIST,U/S,SR,PER DIEM"
		TITLE_CODES["8968"]["program"] = "PSS"
		TITLE_CODES["8968"]["unit"] = "EX"

	TITLE_CODES["8543"] = {}
		TITLE_CODES["8543"]["title"] = "LABORER, FARM"
		TITLE_CODES["8543"]["program"] = "PSS"
		TITLE_CODES["8543"]["unit"] = "SX"

	TITLE_CODES["8963"] = {}
		TITLE_CODES["8963"]["title"] = "TECHNICIAN, ELECTROCARDIOGRAPH"
		TITLE_CODES["8963"]["program"] = "PSS"
		TITLE_CODES["8963"]["unit"] = "EX"

	TITLE_CODES["8540"] = {}
		TITLE_CODES["8540"]["title"] = "TECHNICIAN, AGRICULTURAL, PRIN"
		TITLE_CODES["8540"]["program"] = "PSS"
		TITLE_CODES["8540"]["unit"] = "SX"

	TITLE_CODES["8961"] = {}
		TITLE_CODES["8961"]["title"] = "TECHNICIAN,ELECTROCARDI, PRIN"
		TITLE_CODES["8961"]["program"] = "PSS"
		TITLE_CODES["8961"]["unit"] = "99"

	TITLE_CODES["8960"] = {}
		TITLE_CODES["8960"]["title"] = "TECHNICIAN, ELECT., P.D."
		TITLE_CODES["8960"]["program"] = "PSS"
		TITLE_CODES["8960"]["unit"] = "EX"

	TITLE_CODES["8967"] = {}
		TITLE_CODES["8967"]["title"] = "TECHNOLOGIST, ULTRASOUND"
		TITLE_CODES["8967"]["program"] = "PSS"
		TITLE_CODES["8967"]["unit"] = "EX"

	TITLE_CODES["8951"] = {}
		TITLE_CODES["8951"]["title"] = "PHYSICAL THERAPY ASST PD"
		TITLE_CODES["8951"]["program"] = "PSS"
		TITLE_CODES["8951"]["unit"] = "EX"

	TITLE_CODES["8965"] = {}
		TITLE_CODES["8965"]["title"] = "TECHNOLOGIST, ULTRASOUND, PRIN"
		TITLE_CODES["8965"]["program"] = "PSS"
		TITLE_CODES["8965"]["unit"] = "EX"

	TITLE_CODES["1749"] = {}
		TITLE_CODES["1749"]["title"] = "ASOC ADJUNCT PROF-GENCOMP-B"
		TITLE_CODES["1749"]["program"] = "ACADEMIC"
		TITLE_CODES["1749"]["unit"] = "99"

	TITLE_CODES["6307"] = {}
		TITLE_CODES["6307"]["title"] = "PUBLIC EVENTS MGR, SR - SUPERV"
		TITLE_CODES["6307"]["program"] = "PSS"
		TITLE_CODES["6307"]["unit"] = "99"

	TITLE_CODES["5326"] = {}
		TITLE_CODES["5326"]["title"] = "SECURITY GUARD, SR"
		TITLE_CODES["5326"]["program"] = "PSS"
		TITLE_CODES["5326"]["unit"] = "SX"

	TITLE_CODES["5327"] = {}
		TITLE_CODES["5327"]["title"] = "SECURITY GUARD"
		TITLE_CODES["5327"]["program"] = "PSS"
		TITLE_CODES["5327"]["unit"] = "SX"

	TITLE_CODES["5324"] = {}
		TITLE_CODES["5324"]["title"] = "POLICE TRAINEE"
		TITLE_CODES["5324"]["program"] = "PSS"
		TITLE_CODES["5324"]["unit"] = "99"

	TITLE_CODES["5325"] = {}
		TITLE_CODES["5325"]["title"] = "SECURITY GUARD, SR-SUPVR"
		TITLE_CODES["5325"]["program"] = "PSS"
		TITLE_CODES["5325"]["unit"] = "99"

	TITLE_CODES["9003"] = {}
		TITLE_CODES["9003"]["title"] = "TECHNOLOGIST, NUCLEAR MED, SR"
		TITLE_CODES["9003"]["program"] = "PSS"
		TITLE_CODES["9003"]["unit"] = "HX"

	TITLE_CODES["5323"] = {}
		TITLE_CODES["5323"]["title"] = "POLICE OFFICER"
		TITLE_CODES["5323"]["program"] = "PSS"
		TITLE_CODES["5323"]["unit"] = "PA"

	TITLE_CODES["9001"] = {}
		TITLE_CODES["9001"]["title"] = "TECHNOLOGIST,NUCLEAR MED,CHIEF"
		TITLE_CODES["9001"]["program"] = "PSS"
		TITLE_CODES["9001"]["unit"] = "99"

	TITLE_CODES["3310"] = {}
		TITLE_CODES["3310"]["title"] = "ASSOCIATE SPECIALIST"
		TITLE_CODES["3310"]["program"] = "ACADEMIC"
		TITLE_CODES["3310"]["unit"] = "FX"

	TITLE_CODES["1987"] = {}
		TITLE_CODES["1987"]["title"] = "RES ----- -FY-BUS/ECON/ENG"
		TITLE_CODES["1987"]["program"] = "ACADEMIC"
		TITLE_CODES["1987"]["unit"] = "FX"

	TITLE_CODES["9008"] = {}
		TITLE_CODES["9008"]["title"] = "DOSIMETRIST"
		TITLE_CODES["9008"]["program"] = "PSS"
		TITLE_CODES["9008"]["unit"] = "EX"

	TITLE_CODES["784"] = {}
		TITLE_CODES["784"]["title"] = "PHARMACIST SPECIALIST"
		TITLE_CODES["784"]["program"] = "MSP"
		TITLE_CODES["784"]["unit"] = "99"

	TITLE_CODES["785"] = {}
		TITLE_CODES["785"]["title"] = "FIRE CHIEF, ASSISTANT"
		TITLE_CODES["785"]["program"] = "MSP"
		TITLE_CODES["785"]["unit"] = "99"

	TITLE_CODES["786"] = {}
		TITLE_CODES["786"]["title"] = "HEAD COACH-INTERCOLG ATHLETICS"
		TITLE_CODES["786"]["program"] = "MSP"
		TITLE_CODES["786"]["unit"] = "99"

	TITLE_CODES["787"] = {}
		TITLE_CODES["787"]["title"] = "COACH/SPECIALIST"
		TITLE_CODES["787"]["program"] = "MSP"
		TITLE_CODES["787"]["unit"] = "99"

	TITLE_CODES["780"] = {}
		TITLE_CODES["780"]["title"] = "SUPG HOSPITAL RAD PHYSICIST"
		TITLE_CODES["780"]["program"] = "MSP"
		TITLE_CODES["780"]["unit"] = "99"

	TITLE_CODES["781"] = {}
		TITLE_CODES["781"]["title"] = "CHF, PHARMACEUTICAL SERVICES"
		TITLE_CODES["781"]["program"] = "MSP"
		TITLE_CODES["781"]["unit"] = "99"

	TITLE_CODES["782"] = {}
		TITLE_CODES["782"]["title"] = "ASSOC CHF, PHARMACEUTICAL SERV"
		TITLE_CODES["782"]["program"] = "MSP"
		TITLE_CODES["782"]["unit"] = "99"

	TITLE_CODES["783"] = {}
		TITLE_CODES["783"]["title"] = "ASST CHF, PHARMACEUTICAL SERV"
		TITLE_CODES["783"]["program"] = "MSP"
		TITLE_CODES["783"]["unit"] = "99"

	TITLE_CODES["1726"] = {}
		TITLE_CODES["1726"]["title"] = "PROFESSOR IN RESIDENCE-HCOMP"
		TITLE_CODES["1726"]["program"] = "ACADEMIC"
		TITLE_CODES["1726"]["unit"] = "A3"

	TITLE_CODES["1727"] = {}
		TITLE_CODES["1727"]["title"] = "ADJUNCT INSTRUCTOR-HCOMP"
		TITLE_CODES["1727"]["program"] = "ACADEMIC"
		TITLE_CODES["1727"]["unit"] = "99"

	TITLE_CODES["1724"] = {}
		TITLE_CODES["1724"]["title"] = "ASSISTANT PROF IN RES-HCOMP"
		TITLE_CODES["1724"]["program"] = "ACADEMIC"
		TITLE_CODES["1724"]["unit"] = "A3"

	TITLE_CODES["1725"] = {}
		TITLE_CODES["1725"]["title"] = "ASSOCIATE PROF IN RES-HCOMP"
		TITLE_CODES["1725"]["program"] = "ACADEMIC"
		TITLE_CODES["1725"]["unit"] = "A3"

	TITLE_CODES["788"] = {}
		TITLE_CODES["788"]["title"] = "ASST COACH-INTERCOLG ATHLETICS"
		TITLE_CODES["788"]["program"] = "MSP"
		TITLE_CODES["788"]["unit"] = "99"

	TITLE_CODES["789"] = {}
		TITLE_CODES["789"]["title"] = "CHIEF CLINICAL SOCIAL WORKER"
		TITLE_CODES["789"]["program"] = "MSP"
		TITLE_CODES["789"]["unit"] = "99"

	TITLE_CODES["1720"] = {}
		TITLE_CODES["1720"]["title"] = "ACT ASSOC PROFESSOR-MEDCOMP-A"
		TITLE_CODES["1720"]["program"] = "ACADEMIC"
		TITLE_CODES["1720"]["unit"] = "A3"

	TITLE_CODES["1721"] = {}
		TITLE_CODES["1721"]["title"] = "PROFESSOR-HCOMP"
		TITLE_CODES["1721"]["program"] = "ACADEMIC"
		TITLE_CODES["1721"]["unit"] = "A3"

	TITLE_CODES["9004"] = {}
		TITLE_CODES["9004"]["title"] = "TECHNOLOGIST, NUCLEAR MEDICINE"
		TITLE_CODES["9004"]["program"] = "PSS"
		TITLE_CODES["9004"]["unit"] = "HX"

	TITLE_CODES["1742"] = {}
		TITLE_CODES["1742"]["title"] = "ACT PROFESSOR-GENCOMP-B"
		TITLE_CODES["1742"]["program"] = "ACADEMIC"
		TITLE_CODES["1742"]["unit"] = "A3"

	TITLE_CODES["1743"] = {}
		TITLE_CODES["1743"]["title"] = "INSTRUCTOR IN RES-GENCOMP-B"
		TITLE_CODES["1743"]["program"] = "ACADEMIC"
		TITLE_CODES["1743"]["unit"] = "A3"

	TITLE_CODES["8094"] = {}
		TITLE_CODES["8094"]["title"] = "COGEN OPERATOR"
		TITLE_CODES["8094"]["program"] = "PSS"
		TITLE_CODES["8094"]["unit"] = "K3"

	TITLE_CODES["7282"] = {}
		TITLE_CODES["7282"]["title"] = "COMPUTING RESOURCE MANAGER I"
		TITLE_CODES["7282"]["program"] = "PSS"
		TITLE_CODES["7282"]["unit"] = "99"

	TITLE_CODES["8211"] = {}
		TITLE_CODES["8211"]["title"] = "BUILDING MAINTENANCE WRKR,LEAD"
		TITLE_CODES["8211"]["program"] = "PSS"
		TITLE_CODES["8211"]["unit"] = "SX"

	TITLE_CODES["8210"] = {}
		TITLE_CODES["8210"]["title"] = "BUILDING MAINTENANCE SUPVR, SR"
		TITLE_CODES["8210"]["program"] = "PSS"
		TITLE_CODES["8210"]["unit"] = "99"

	TITLE_CODES["8213"] = {}
		TITLE_CODES["8213"]["title"] = "BUILDING MAINTENANCE WORKER"
		TITLE_CODES["8213"]["program"] = "PSS"
		TITLE_CODES["8213"]["unit"] = "SX"

	TITLE_CODES["8212"] = {}
		TITLE_CODES["8212"]["title"] = "BUILDING MAINTENANCE WORKER,SR"
		TITLE_CODES["8212"]["program"] = "PSS"
		TITLE_CODES["8212"]["unit"] = "SX"

	TITLE_CODES["9013"] = {}
		TITLE_CODES["9013"]["title"] = "TECHNOLOGIST,RADIATION THPY"
		TITLE_CODES["9013"]["program"] = "PSS"
		TITLE_CODES["9013"]["unit"] = "EX"

	TITLE_CODES["60"] = {}
		TITLE_CODES["60"]["title"] = "TREASURER OF THE REGENTS"
		TITLE_CODES["60"]["program"] = "MSP"
		TITLE_CODES["60"]["unit"] = "99"

	TITLE_CODES["61"] = {}
		TITLE_CODES["61"]["title"] = "CONSULTANT TO THE TREASURER"
		TITLE_CODES["61"]["program"] = "MSP"
		TITLE_CODES["61"]["unit"] = "99"

	TITLE_CODES["3007"] = {}
		TITLE_CODES["3007"]["title"] = "ACT ----- IN THE A.E.S."
		TITLE_CODES["3007"]["program"] = "ACADEMIC"
		TITLE_CODES["3007"]["unit"] = "99"

	TITLE_CODES["63"] = {}
		TITLE_CODES["63"]["title"] = "ASSO TREASURER OF REGENTS"
		TITLE_CODES["63"]["program"] = "MSP"
		TITLE_CODES["63"]["unit"] = "99"

	TITLE_CODES["64"] = {}
		TITLE_CODES["64"]["title"] = "ASSOC TREAS--REAL ESTATE"
		TITLE_CODES["64"]["program"] = "MSP"
		TITLE_CODES["64"]["unit"] = "99"

	TITLE_CODES["65"] = {}
		TITLE_CODES["65"]["title"] = "ASST TREASURER OF THE REGENTS"
		TITLE_CODES["65"]["program"] = "MSP"
		TITLE_CODES["65"]["unit"] = "99"

	TITLE_CODES["7656"] = {}
		TITLE_CODES["7656"]["title"] = "HR ANALYST V--SUPERVISOR"
		TITLE_CODES["7656"]["program"] = "PSS"
		TITLE_CODES["7656"]["unit"] = "99"

	TITLE_CODES["67"] = {}
		TITLE_CODES["67"]["title"] = "ASST TREASURER--REAL ESTATE"
		TITLE_CODES["67"]["program"] = "MSP"
		TITLE_CODES["67"]["unit"] = "99"

	TITLE_CODES["7658"] = {}
		TITLE_CODES["7658"]["title"] = "HR ANALYST I"
		TITLE_CODES["7658"]["program"] = "PSS"
		TITLE_CODES["7658"]["unit"] = "99"

	TITLE_CODES["69"] = {}
		TITLE_CODES["69"]["title"] = "ASST TREASURER--INVESTMENTS"
		TITLE_CODES["69"]["program"] = "MSP"
		TITLE_CODES["69"]["unit"] = "99"

	TITLE_CODES["3009"] = {}
		TITLE_CODES["3009"]["title"] = "ACT ----- IN THE A.E.S.-SFT-VM"
		TITLE_CODES["3009"]["program"] = "ACADEMIC"
		TITLE_CODES["3009"]["unit"] = "FX"

	TITLE_CODES["3008"] = {}
		TITLE_CODES["3008"]["title"] = "VST ----- IN THE A.E.S."
		TITLE_CODES["3008"]["program"] = "ACADEMIC"
		TITLE_CODES["3008"]["unit"] = "99"

	TITLE_CODES["1421"] = {}
		TITLE_CODES["1421"]["title"] = "VSTG PROF-ACAD YR-BUS/ECON/ENG"
		TITLE_CODES["1421"]["program"] = "ACADEMIC"
		TITLE_CODES["1421"]["unit"] = "99"

	TITLE_CODES["1423"] = {}
		TITLE_CODES["1423"]["title"] = "VSTG PROF-AY-1/9-BUS/ECON/ENGR"
		TITLE_CODES["1423"]["program"] = "ACADEMIC"
		TITLE_CODES["1423"]["unit"] = "99"

	TITLE_CODES["1422"] = {}
		TITLE_CODES["1422"]["title"] = "VSTG PROF-FY-BUS/ECON/ENG"
		TITLE_CODES["1422"]["program"] = "ACADEMIC"
		TITLE_CODES["1422"]["unit"] = "99"

	TITLE_CODES["1425"] = {}
		TITLE_CODES["1425"]["title"] = "VSTG ASO PRO-FY-BUS/ECON/ENGR"
		TITLE_CODES["1425"]["program"] = "ACADEMIC"
		TITLE_CODES["1425"]["unit"] = "99"

	TITLE_CODES["1424"] = {}
		TITLE_CODES["1424"]["title"] = "VSTG ASO PRO-AY-BUS/ECON/ENGR"
		TITLE_CODES["1424"]["program"] = "ACADEMIC"
		TITLE_CODES["1424"]["unit"] = "99"

	TITLE_CODES["1427"] = {}
		TITLE_CODES["1427"]["title"] = "VSTG AST PRO-AY-BUS/ECON/ENGR"
		TITLE_CODES["1427"]["program"] = "ACADEMIC"
		TITLE_CODES["1427"]["unit"] = "99"

	TITLE_CODES["1426"] = {}
		TITLE_CODES["1426"]["title"] = "VSTG ASO PRO-AY-1/9-B/ECON/ENG"
		TITLE_CODES["1426"]["program"] = "ACADEMIC"
		TITLE_CODES["1426"]["unit"] = "99"

	TITLE_CODES["1429"] = {}
		TITLE_CODES["1429"]["title"] = "VSTG AST PRO-AY-1/9-B/ECON/ENG"
		TITLE_CODES["1429"]["program"] = "ACADEMIC"
		TITLE_CODES["1429"]["unit"] = "99"

	TITLE_CODES["1428"] = {}
		TITLE_CODES["1428"]["title"] = "VSTG AST PRO-FY-BUS/ECON/ENG"
		TITLE_CODES["1428"]["program"] = "ACADEMIC"
		TITLE_CODES["1428"]["unit"] = "99"

	TITLE_CODES["5111"] = {}
		TITLE_CODES["5111"]["title"] = "CUSTODIAN SUPV, SR."
		TITLE_CODES["5111"]["program"] = "PSS"
		TITLE_CODES["5111"]["unit"] = "99"

	TITLE_CODES["7154"] = {}
		TITLE_CODES["7154"]["title"] = "ENGINEER, ASST"
		TITLE_CODES["7154"]["program"] = "PSS"
		TITLE_CODES["7154"]["unit"] = "99"

	TITLE_CODES["3360"] = {}
		TITLE_CODES["3360"]["title"] = "ADJUNCT INSTRUCTOR-ACAD YR-1/9"
		TITLE_CODES["3360"]["program"] = "ACADEMIC"
		TITLE_CODES["3360"]["unit"] = "99"

	TITLE_CODES["3361"] = {}
		TITLE_CODES["3361"]["title"] = "ASST ADJUNCT PROF-ACAD YR-1/9"
		TITLE_CODES["3361"]["program"] = "ACADEMIC"
		TITLE_CODES["3361"]["unit"] = "99"

	TITLE_CODES["3362"] = {}
		TITLE_CODES["3362"]["title"] = "ASSOC ADJUNCT PROF-ACAD YR-1/9"
		TITLE_CODES["3362"]["program"] = "ACADEMIC"
		TITLE_CODES["3362"]["unit"] = "99"

	TITLE_CODES["3363"] = {}
		TITLE_CODES["3363"]["title"] = "ADJUNCT PROFESSOR-ACAD YR-1/9"
		TITLE_CODES["3363"]["program"] = "ACADEMIC"
		TITLE_CODES["3363"]["unit"] = "99"

	TITLE_CODES["731"] = {}
		TITLE_CODES["731"]["title"] = "PR ADMINISTRATIVE ANALYST II"
		TITLE_CODES["731"]["program"] = "MSP"
		TITLE_CODES["731"]["unit"] = "99"

	TITLE_CODES["733"] = {}
		TITLE_CODES["733"]["title"] = "PRINCIPAL BUDGET ANALYST II"
		TITLE_CODES["733"]["program"] = "MSP"
		TITLE_CODES["733"]["unit"] = "99"

	TITLE_CODES["732"] = {}
		TITLE_CODES["732"]["title"] = "PROGRAMMER/ANALYST V-SUPVR"
		TITLE_CODES["732"]["program"] = "MSP"
		TITLE_CODES["732"]["unit"] = "99"

	TITLE_CODES["735"] = {}
		TITLE_CODES["735"]["title"] = "PROG/ANALYST V-SUPERVISOR"
		TITLE_CODES["735"]["program"] = "MSP"
		TITLE_CODES["735"]["unit"] = "99"

	TITLE_CODES["734"] = {}
		TITLE_CODES["734"]["title"] = "PROGRAMMER/ANALYST V"
		TITLE_CODES["734"]["program"] = "MSP"
		TITLE_CODES["734"]["unit"] = "99"

	TITLE_CODES["737"] = {}
		TITLE_CODES["737"]["title"] = "PROGRAMMER/ANALYST IV - SUPERV"
		TITLE_CODES["737"]["program"] = "MSP"
		TITLE_CODES["737"]["unit"] = "99"

	TITLE_CODES["509"] = {}
		TITLE_CODES["509"]["title"] = "LABOR RELATIONS ADVOCATE"
		TITLE_CODES["509"]["program"] = "MSP"
		TITLE_CODES["509"]["unit"] = "99"

	TITLE_CODES["506"] = {}
		TITLE_CODES["506"]["title"] = "CAMPUS OMBUDSPERSON"
		TITLE_CODES["506"]["program"] = "MSP"
		TITLE_CODES["506"]["unit"] = "99"

	TITLE_CODES["507"] = {}
		TITLE_CODES["507"]["title"] = "GEOPHYSICAL ANALYST"
		TITLE_CODES["507"]["program"] = "MSP"
		TITLE_CODES["507"]["unit"] = "99"

	TITLE_CODES["504"] = {}
		TITLE_CODES["504"]["title"] = "SPONSORING EDITOR - MAP"
		TITLE_CODES["504"]["program"] = "MSP"
		TITLE_CODES["504"]["unit"] = "99"

	TITLE_CODES["505"] = {}
		TITLE_CODES["505"]["title"] = "MEDICAL APPLICATIONS ANALYST"
		TITLE_CODES["505"]["program"] = "MSP"
		TITLE_CODES["505"]["unit"] = "99"

	TITLE_CODES["502"] = {}
		TITLE_CODES["502"]["title"] = "EXECUTIVE CATERER"
		TITLE_CODES["502"]["program"] = "MSP"
		TITLE_CODES["502"]["unit"] = "99"

	TITLE_CODES["503"] = {}
		TITLE_CODES["503"]["title"] = "VETERINARIAN, SENIOR"
		TITLE_CODES["503"]["program"] = "MSP"
		TITLE_CODES["503"]["unit"] = "99"

	TITLE_CODES["9451"] = {}
		TITLE_CODES["9451"]["title"] = "THERAPIST, MUSIC"
		TITLE_CODES["9451"]["program"] = "PSS"
		TITLE_CODES["9451"]["unit"] = "HX"

	TITLE_CODES["501"] = {}
		TITLE_CODES["501"]["title"] = "ADMINISTRATIVE STATISTICIAN"
		TITLE_CODES["501"]["program"] = "MSP"
		TITLE_CODES["501"]["unit"] = "99"

	TITLE_CODES["8105"] = {}
		TITLE_CODES["8105"]["title"] = "PAINTER, LEAD"
		TITLE_CODES["8105"]["program"] = "PSS"
		TITLE_CODES["8105"]["unit"] = "K3"

	TITLE_CODES["1645"] = {}
		TITLE_CODES["1645"]["title"] = "SR. LECTURER-FY-CONTINUING"
		TITLE_CODES["1645"]["program"] = "ACADEMIC"
		TITLE_CODES["1645"]["unit"] = "IX"

	TITLE_CODES["1210"] = {}
		TITLE_CODES["1210"]["title"] = "ASSOC PROFESSOR - FISCAL YR"
		TITLE_CODES["1210"]["program"] = "ACADEMIC"
		TITLE_CODES["1210"]["unit"] = "A3"

	TITLE_CODES["7288"] = {}
		TITLE_CODES["7288"]["title"] = "PROGRAMMER VI"
		TITLE_CODES["7288"]["program"] = "PSS"
		TITLE_CODES["7288"]["unit"] = "99"

	TITLE_CODES["1216"] = {}
		TITLE_CODES["1216"]["title"] = "ASSOC PROFESSOR-FY-RECALL"
		TITLE_CODES["1216"]["program"] = "ACADEMIC"
		TITLE_CODES["1216"]["unit"] = "A3"

	TITLE_CODES["635"] = {}
		TITLE_CODES["635"]["title"] = "PROGRAMMER ANALYST IV - UCOP"
		TITLE_CODES["635"]["program"] = "MSP"
		TITLE_CODES["635"]["unit"] = "99"

	TITLE_CODES["636"] = {}
		TITLE_CODES["636"]["title"] = "SYSTEMS PROGRAMMER IV"
		TITLE_CODES["636"]["program"] = "MSP"
		TITLE_CODES["636"]["unit"] = "99"

	TITLE_CODES["637"] = {}
		TITLE_CODES["637"]["title"] = "NETWORK ENGINEER II"
		TITLE_CODES["637"]["program"] = "MSP"
		TITLE_CODES["637"]["unit"] = "99"

	TITLE_CODES["638"] = {}
		TITLE_CODES["638"]["title"] = "IT RESOURCE MANAGER II"
		TITLE_CODES["638"]["program"] = "MSP"
		TITLE_CODES["638"]["unit"] = "99"

	TITLE_CODES["639"] = {}
		TITLE_CODES["639"]["title"] = "IT RESOURCE MANAGER III"
		TITLE_CODES["639"]["program"] = "MSP"
		TITLE_CODES["639"]["unit"] = "99"

	TITLE_CODES["1218"] = {}
		TITLE_CODES["1218"]["title"] = "VST ASSOC PROFESSOR-FISCAL YR"
		TITLE_CODES["1218"]["program"] = "ACADEMIC"
		TITLE_CODES["1218"]["unit"] = "99"

	TITLE_CODES["461"] = {}
		TITLE_CODES["461"]["title"] = "SPECIALIST (FUNCTIONAL AREA)"
		TITLE_CODES["461"]["program"] = "MSP"
		TITLE_CODES["461"]["unit"] = "99"

	TITLE_CODES["9162"] = {}
		TITLE_CODES["9162"]["title"] = "OR EQUIPMENT SPECIALIST II"
		TITLE_CODES["9162"]["program"] = "PSS"
		TITLE_CODES["9162"]["unit"] = "EX"

	TITLE_CODES["8074"] = {}
		TITLE_CODES["8074"]["title"] = "LABORER, LEAD, SR"
		TITLE_CODES["8074"]["program"] = "PSS"
		TITLE_CODES["8074"]["unit"] = "SX"

	TITLE_CODES["9223"] = {}
		TITLE_CODES["9223"]["title"] = "COORD, MED OFF SRVC, V - SUPV"
		TITLE_CODES["9223"]["program"] = "PSS"
		TITLE_CODES["9223"]["unit"] = "99"

	TITLE_CODES["5842"] = {}
		TITLE_CODES["5842"]["title"] = "LAUNDRY MACHINE OPERATOR"
		TITLE_CODES["5842"]["program"] = "PSS"
		TITLE_CODES["5842"]["unit"] = "SX"

	TITLE_CODES["9394"] = {}
		TITLE_CODES["9394"]["title"] = "TECHNICIAN, GI ENDOSCOPY - SUP"
		TITLE_CODES["9394"]["program"] = "PSS"
		TITLE_CODES["9394"]["unit"] = "99"

	TITLE_CODES["8268"] = {}
		TITLE_CODES["8268"]["title"] = "MECHANIC, ELEVATOR, APPRENTICE"
		TITLE_CODES["8268"]["program"] = "PSS"
		TITLE_CODES["8268"]["unit"] = "K3"

	TITLE_CODES["8077"] = {}
		TITLE_CODES["8077"]["title"] = "LABORER, PER DIEM"
		TITLE_CODES["8077"]["program"] = "PSS"
		TITLE_CODES["8077"]["unit"] = "SX"

	TITLE_CODES["6950"] = {}
		TITLE_CODES["6950"]["title"] = "ARCHITECT SUPERVISOR"
		TITLE_CODES["6950"]["program"] = "PSS"
		TITLE_CODES["6950"]["unit"] = "99"

	TITLE_CODES["1641"] = {}
		TITLE_CODES["1641"]["title"] = "SR. LECTURER-AY-CONTINUING"
		TITLE_CODES["1641"]["program"] = "ACADEMIC"
		TITLE_CODES["1641"]["unit"] = "IX"

	TITLE_CODES["5654"] = {}
		TITLE_CODES["5654"]["title"] = "FOOD SERVICE WORKER,PRIN-SUPVR"
		TITLE_CODES["5654"]["program"] = "PSS"
		TITLE_CODES["5654"]["unit"] = "99"

	TITLE_CODES["5655"] = {}
		TITLE_CODES["5655"]["title"] = "FOOD SERVICE WORKER, SR-SUPVR"
		TITLE_CODES["5655"]["program"] = "PSS"
		TITLE_CODES["5655"]["unit"] = "99"

	TITLE_CODES["5652"] = {}
		TITLE_CODES["5652"]["title"] = "FOOD SERVICE WORKER"
		TITLE_CODES["5652"]["program"] = "PSS"
		TITLE_CODES["5652"]["unit"] = "SX"

	TITLE_CODES["6955"] = {}
		TITLE_CODES["6955"]["title"] = "ASSOC ARCHITECT - SUPERVISOR"
		TITLE_CODES["6955"]["program"] = "PSS"
		TITLE_CODES["6955"]["unit"] = "99"

	TITLE_CODES["5650"] = {}
		TITLE_CODES["5650"]["title"] = "FOOD SERVICE WORKER, PRIN"
		TITLE_CODES["5650"]["program"] = "PSS"
		TITLE_CODES["5650"]["unit"] = "SX"

	TITLE_CODES["1640"] = {}
		TITLE_CODES["1640"]["title"] = "SR LECTURER - ACADEMIC YEAR"
		TITLE_CODES["1640"]["program"] = "ACADEMIC"
		TITLE_CODES["1640"]["unit"] = "IX"

	TITLE_CODES["5520"] = {}
		TITLE_CODES["5520"]["title"] = "COOK, PER DIEM"
		TITLE_CODES["5520"]["program"] = "PSS"
		TITLE_CODES["5520"]["unit"] = "SX"

	TITLE_CODES["1643"] = {}
		TITLE_CODES["1643"]["title"] = "SR.LECT.-AY-1/9-CONTINUING"
		TITLE_CODES["1643"]["program"] = "ACADEMIC"
		TITLE_CODES["1643"]["unit"] = "IX"

	TITLE_CODES["9452"] = {}
		TITLE_CODES["9452"]["title"] = "ART THERAPIST"
		TITLE_CODES["9452"]["program"] = "PSS"
		TITLE_CODES["9452"]["unit"] = "HX"

	TITLE_CODES["1642"] = {}
		TITLE_CODES["1642"]["title"] = "SENIOR LECTURER-ACAD YR-1/9TH"
		TITLE_CODES["1642"]["program"] = "ACADEMIC"
		TITLE_CODES["1642"]["unit"] = "IX"

	TITLE_CODES["1106"] = {}
		TITLE_CODES["1106"]["title"] = "PROFESSOR-ACAD YR-RECALLED"
		TITLE_CODES["1106"]["program"] = "ACADEMIC"
		TITLE_CODES["1106"]["unit"] = "A3"

	TITLE_CODES["1107"] = {}
		TITLE_CODES["1107"]["title"] = "ACTING PROFESSOR-ACADEMIC YR"
		TITLE_CODES["1107"]["program"] = "ACADEMIC"
		TITLE_CODES["1107"]["unit"] = "A3"

	TITLE_CODES["1104"] = {}
		TITLE_CODES["1104"]["title"] = "UNIVERSITY PROFESSOR"
		TITLE_CODES["1104"]["program"] = "ACADEMIC"
		TITLE_CODES["1104"]["unit"] = "A3"

	TITLE_CODES["1105"] = {}
		TITLE_CODES["1105"]["title"] = "PROFESSOR-FAC EARLY RETIR PGRM"
		TITLE_CODES["1105"]["program"] = "ACADEMIC"
		TITLE_CODES["1105"]["unit"] = "A3"

	TITLE_CODES["1102"] = {}
		TITLE_CODES["1102"]["title"] = "VST PROFESSOR-ACAD YR-1/9 PMT"
		TITLE_CODES["1102"]["program"] = "ACADEMIC"
		TITLE_CODES["1102"]["unit"] = "99"

	TITLE_CODES["1103"] = {}
		TITLE_CODES["1103"]["title"] = "PROFESSOR-ACAD YR-1/9TH PMT"
		TITLE_CODES["1103"]["program"] = "ACADEMIC"
		TITLE_CODES["1103"]["unit"] = "A3"

	TITLE_CODES["1100"] = {}
		TITLE_CODES["1100"]["title"] = "PROFESSOR - ACADEMIC YEAR"
		TITLE_CODES["1100"]["program"] = "ACADEMIC"
		TITLE_CODES["1100"]["unit"] = "A3"

	TITLE_CODES["1101"] = {}
		TITLE_CODES["1101"]["title"] = "ACT PROFESSOR-ACAD YR-1/9TH"
		TITLE_CODES["1101"]["program"] = "ACADEMIC"
		TITLE_CODES["1101"]["unit"] = "A3"

	TITLE_CODES["8668"] = {}
		TITLE_CODES["8668"]["title"] = "MECHANICIAN, LAB, PR - SUPVR"
		TITLE_CODES["8668"]["program"] = "PSS"
		TITLE_CODES["8668"]["unit"] = "99"

	TITLE_CODES["8669"] = {}
		TITLE_CODES["8669"]["title"] = "MECHANICIAN,LAB,PRIN-SUPVR-MF"
		TITLE_CODES["8669"]["program"] = "PSS"
		TITLE_CODES["8669"]["unit"] = "99"

	TITLE_CODES["1458"] = {}
		TITLE_CODES["1458"]["title"] = "AST PROF OF CLIN__-GENCOMP-B"
		TITLE_CODES["1458"]["program"] = "ACADEMIC"
		TITLE_CODES["1458"]["unit"] = "A3"

	TITLE_CODES["1459"] = {}
		TITLE_CODES["1459"]["title"] = "PROF OF CLIN____-MEDCOMP-B"
		TITLE_CODES["1459"]["program"] = "ACADEMIC"
		TITLE_CODES["1459"]["unit"] = "A3"

	TITLE_CODES["1108"] = {}
		TITLE_CODES["1108"]["title"] = "VISITING PROFESSOR-ACADEMIC YR"
		TITLE_CODES["1108"]["program"] = "ACADEMIC"
		TITLE_CODES["1108"]["unit"] = "99"

	TITLE_CODES["1109"] = {}
		TITLE_CODES["1109"]["title"] = "PROFESSOR RECALLED-ACAD YR-1/9"
		TITLE_CODES["1109"]["program"] = "ACADEMIC"
		TITLE_CODES["1109"]["unit"] = "A3"

	TITLE_CODES["8279"] = {}
		TITLE_CODES["8279"]["title"] = "CENT HEAT/COOL PLANT OPERATOR"
		TITLE_CODES["8279"]["program"] = "PSS"
		TITLE_CODES["8279"]["unit"] = "K3"

	TITLE_CODES["9294"] = {}
		TITLE_CODES["9294"]["title"] = "CERT PHLEBOTOMIST TECH III"
		TITLE_CODES["9294"]["program"] = "PSS"
		TITLE_CODES["9294"]["unit"] = "EX"

	TITLE_CODES["1722"] = {}
		TITLE_CODES["1722"]["title"] = "ACT PROFESSOR-MEDCOMP-A"
		TITLE_CODES["1722"]["program"] = "ACADEMIC"
		TITLE_CODES["1722"]["unit"] = "A3"

	TITLE_CODES["8278"] = {}
		TITLE_CODES["8278"]["title"] = "CENTRAL HEAT/COOL PIT OP APPR"
		TITLE_CODES["8278"]["program"] = "PSS"
		TITLE_CODES["8278"]["unit"] = "K3"

	TITLE_CODES["9128"] = {}
		TITLE_CODES["9128"]["title"] = "NURSE, CLINICAL III-SUPVR"
		TITLE_CODES["9128"]["program"] = "PSS"
		TITLE_CODES["9128"]["unit"] = "99"

	TITLE_CODES["1723"] = {}
		TITLE_CODES["1723"]["title"] = "INSTRUCTOR IN RESIDENCE-HCOMP"
		TITLE_CODES["1723"]["program"] = "ACADEMIC"
		TITLE_CODES["1723"]["unit"] = "A3"

	TITLE_CODES["8563"] = {}
		TITLE_CODES["8563"]["title"] = "EQUIPMENT OPERATOR"
		TITLE_CODES["8563"]["program"] = "PSS"
		TITLE_CODES["8563"]["unit"] = "SX"

	TITLE_CODES["3395"] = {}
		TITLE_CODES["3395"]["title"] = "AST PROJECT___-FY-BUS/ECON/ENG"
		TITLE_CODES["3395"]["program"] = "ACADEMIC"
		TITLE_CODES["3395"]["unit"] = "FX"

	TITLE_CODES["9398"] = {}
		TITLE_CODES["9398"]["title"] = "TECHNICIAN I, GI ENDOSCOPY, PD"
		TITLE_CODES["9398"]["program"] = "PSS"
		TITLE_CODES["9398"]["unit"] = "EX"

	TITLE_CODES["7570"] = {}
		TITLE_CODES["7570"]["title"] = "PATENT ADVISOR SUPERVISOR"
		TITLE_CODES["7570"]["program"] = "PSS"
		TITLE_CODES["7570"]["unit"] = "99"

	TITLE_CODES["7573"] = {}
		TITLE_CODES["7573"]["title"] = "PATENT ADVISOR I"
		TITLE_CODES["7573"]["program"] = "PSS"
		TITLE_CODES["7573"]["unit"] = "99"

	TITLE_CODES["7572"] = {}
		TITLE_CODES["7572"]["title"] = "PATENT ADVISOR II"
		TITLE_CODES["7572"]["program"] = "PSS"
		TITLE_CODES["7572"]["unit"] = "99"

	TITLE_CODES["9018"] = {}
		TITLE_CODES["9018"]["title"] = "TECHNOLOGIST,RAD,SR - SUPVR"
		TITLE_CODES["9018"]["program"] = "PSS"
		TITLE_CODES["9018"]["unit"] = "99"

	TITLE_CODES["9395"] = {}
		TITLE_CODES["9395"]["title"] = "TECHNICIAN III, GI ENDOSCOPY"
		TITLE_CODES["9395"]["program"] = "PSS"
		TITLE_CODES["9395"]["unit"] = "EX"

	TITLE_CODES["9129"] = {}
		TITLE_CODES["9129"]["title"] = "NURSE, CLINICAL II-SUPVR"
		TITLE_CODES["9129"]["program"] = "PSS"
		TITLE_CODES["9129"]["unit"] = "99"

	TITLE_CODES["9811"] = {}
		TITLE_CODES["9811"]["title"] = "FIRE CAPTAIN (NON-SAFETY)"
		TITLE_CODES["9811"]["program"] = "PSS"
		TITLE_CODES["9811"]["unit"] = "F3"

	TITLE_CODES["9812"] = {}
		TITLE_CODES["9812"]["title"] = "FIRE SPECIALIST I (NON-SAFETY)"
		TITLE_CODES["9812"]["program"] = "PSS"
		TITLE_CODES["9812"]["unit"] = "F3"

	TITLE_CODES["8272"] = {}
		TITLE_CODES["8272"]["title"] = "ACCELERATOR OPERATOR, SR"
		TITLE_CODES["8272"]["program"] = "PSS"
		TITLE_CODES["8272"]["unit"] = "TX"

	TITLE_CODES["7777"] = {}
		TITLE_CODES["7777"]["title"] = "BUYER SUPERVISOR"
		TITLE_CODES["7777"]["program"] = "PSS"
		TITLE_CODES["7777"]["unit"] = "99"

	TITLE_CODES["7365"] = {}
		TITLE_CODES["7365"]["title"] = "ANALYST IX - SUPERVISOR"
		TITLE_CODES["7365"]["program"] = "PSS"
		TITLE_CODES["7365"]["unit"] = "99"

	TITLE_CODES["7775"] = {}
		TITLE_CODES["7775"]["title"] = "BUYER I"
		TITLE_CODES["7775"]["program"] = "PSS"
		TITLE_CODES["7775"]["unit"] = "99"

	TITLE_CODES["3394"] = {}
		TITLE_CODES["3394"]["title"] = "ASST PROJECT_____-FISCAL YEAR"
		TITLE_CODES["3394"]["program"] = "ACADEMIC"
		TITLE_CODES["3394"]["unit"] = "FX"

	TITLE_CODES["7773"] = {}
		TITLE_CODES["7773"]["title"] = "BUYER IV"
		TITLE_CODES["7773"]["program"] = "PSS"
		TITLE_CODES["7773"]["unit"] = "99"

	TITLE_CODES["7772"] = {}
		TITLE_CODES["7772"]["title"] = "BUYER V"
		TITLE_CODES["7772"]["program"] = "PSS"
		TITLE_CODES["7772"]["unit"] = "99"

	TITLE_CODES["7280"] = {}
		TITLE_CODES["7280"]["title"] = "PROGRAMMER VIII"
		TITLE_CODES["7280"]["program"] = "PSS"
		TITLE_CODES["7280"]["unit"] = "99"

	TITLE_CODES["8270"] = {}
		TITLE_CODES["8270"]["title"] = "ACCELERATOR OPERATIONS SUPVR"
		TITLE_CODES["8270"]["program"] = "PSS"
		TITLE_CODES["8270"]["unit"] = "99"

	TITLE_CODES["9229"] = {}
		TITLE_CODES["9229"]["title"] = "OR SUPPORT ASSISTANT, PER DIEM"
		TITLE_CODES["9229"]["program"] = "PSS"
		TITLE_CODES["9229"]["unit"] = "EX"

	TITLE_CODES["7779"] = {}
		TITLE_CODES["7779"]["title"] = "BUYER IV - SUPERVISOR"
		TITLE_CODES["7779"]["program"] = "PSS"
		TITLE_CODES["7779"]["unit"] = "99"

	TITLE_CODES["7778"] = {}
		TITLE_CODES["7778"]["title"] = "BUYER V - SUPERVISOR"
		TITLE_CODES["7778"]["program"] = "PSS"
		TITLE_CODES["7778"]["unit"] = "99"

	TITLE_CODES["4923"] = {}
		TITLE_CODES["4923"]["title"] = "STUDENT ASSISTANT II, NON UC"
		TITLE_CODES["4923"]["program"] = "PSS"
		TITLE_CODES["4923"]["unit"] = "99"

	TITLE_CODES["9529"] = {}
		TITLE_CODES["9529"]["title"] = "ASSOCIATE VETERINARIAN - SUPVR"
		TITLE_CODES["9529"]["program"] = "PSS"
		TITLE_CODES["9529"]["unit"] = "99"

	TITLE_CODES["7650"] = {}
		TITLE_CODES["7650"]["title"] = "HR ANALYST V"
		TITLE_CODES["7650"]["program"] = "PSS"
		TITLE_CODES["7650"]["unit"] = "99"

	TITLE_CODES["7366"] = {}
		TITLE_CODES["7366"]["title"] = "ANALYST X - SUPERVISOR"
		TITLE_CODES["7366"]["program"] = "PSS"
		TITLE_CODES["7366"]["unit"] = "99"

	TITLE_CODES["8314"] = {}
		TITLE_CODES["8314"]["title"] = "GLASSBLOWER,LABORATORY,TRAINEE"
		TITLE_CODES["8314"]["program"] = "PSS"
		TITLE_CODES["8314"]["unit"] = "TX"

	TITLE_CODES["6732"] = {}
		TITLE_CODES["6732"]["title"] = "BIBLIOGRAPHER II"
		TITLE_CODES["6732"]["program"] = "PSS"
		TITLE_CODES["6732"]["unit"] = "CX"

	TITLE_CODES["4920"] = {}
		TITLE_CODES["4920"]["title"] = "ASSISTANT III"
		TITLE_CODES["4920"]["program"] = "PSS"
		TITLE_CODES["4920"]["unit"] = "99"

	TITLE_CODES["8311"] = {}
		TITLE_CODES["8311"]["title"] = "GLASSBLOWER, LABORATORY, PRIN"
		TITLE_CODES["8311"]["program"] = "PSS"
		TITLE_CODES["8311"]["unit"] = "TX"

	TITLE_CODES["6905"] = {}
		TITLE_CODES["6905"]["title"] = "ARCHITECTURAL ASSOCIATE"
		TITLE_CODES["6905"]["program"] = "PSS"
		TITLE_CODES["6905"]["unit"] = "99"

	TITLE_CODES["8313"] = {}
		TITLE_CODES["8313"]["title"] = "GLASSBLOWER, LABORATORY"
		TITLE_CODES["8313"]["program"] = "PSS"
		TITLE_CODES["8313"]["unit"] = "TX"

	TITLE_CODES["9481"] = {}
		TITLE_CODES["9481"]["title"] = "THERAPIST, PHYSICAL IV"
		TITLE_CODES["9481"]["program"] = "PSS"
		TITLE_CODES["9481"]["unit"] = "99"

	TITLE_CODES["4926"] = {}
		TITLE_CODES["4926"]["title"] = "SPECIAL STUDENT ASSISTANT BYA"
		TITLE_CODES["4926"]["program"] = "PSS"
		TITLE_CODES["4926"]["unit"] = "99"

	TITLE_CODES["8084"] = {}
		TITLE_CODES["8084"]["title"] = "TREE TRIMMER, LEAD"
		TITLE_CODES["8084"]["program"] = "PSS"
		TITLE_CODES["8084"]["unit"] = "SX"

	TITLE_CODES["8026"] = {}
		TITLE_CODES["8026"]["title"] = "THERAPIST, RECREATION II--SUPV"
		TITLE_CODES["8026"]["program"] = "PSS"
		TITLE_CODES["8026"]["unit"] = "99"

	TITLE_CODES["5832"] = {}
		TITLE_CODES["5832"]["title"] = "LINEN SERVICE WORKER, SR"
		TITLE_CODES["5832"]["program"] = "PSS"
		TITLE_CODES["5832"]["unit"] = "SX"

	TITLE_CODES["5833"] = {}
		TITLE_CODES["5833"]["title"] = "LINEN SERVICE WORKER"
		TITLE_CODES["5833"]["program"] = "PSS"
		TITLE_CODES["5833"]["unit"] = "SX"

	TITLE_CODES["8082"] = {}
		TITLE_CODES["8082"]["title"] = "TREE TRIMMER SUPVR"
		TITLE_CODES["8082"]["program"] = "PSS"
		TITLE_CODES["8082"]["unit"] = "99"

	TITLE_CODES["8083"] = {}
		TITLE_CODES["8083"]["title"] = "TREE TRIMMER"
		TITLE_CODES["8083"]["program"] = "PSS"
		TITLE_CODES["8083"]["unit"] = "SX"

	TITLE_CODES["4013"] = {}
		TITLE_CODES["4013"]["title"] = "COACH/SPECIALIST"
		TITLE_CODES["4013"]["program"] = "PSS"
		TITLE_CODES["4013"]["unit"] = "99"

	TITLE_CODES["4012"] = {}
		TITLE_CODES["4012"]["title"] = "COACH INTERCOL ATHLETICS, HEAD"
		TITLE_CODES["4012"]["program"] = "PSS"
		TITLE_CODES["4012"]["unit"] = "99"

	TITLE_CODES["4011"] = {}
		TITLE_CODES["4011"]["title"] = "RECREATION PROGRAM INSTRUCTOR"
		TITLE_CODES["4011"]["program"] = "PSS"
		TITLE_CODES["4011"]["unit"] = "99"

	TITLE_CODES["7651"] = {}
		TITLE_CODES["7651"]["title"] = "HR ANALYST VI"
		TITLE_CODES["7651"]["program"] = "PSS"
		TITLE_CODES["7651"]["unit"] = "99"

	TITLE_CODES["3396"] = {}
		TITLE_CODES["3396"]["title"] = "VISITING PROJECT _____-FY"
		TITLE_CODES["3396"]["program"] = "ACADEMIC"
		TITLE_CODES["3396"]["unit"] = "99"

	TITLE_CODES["357"] = {}
		TITLE_CODES["357"]["title"] = "COORDINATOR OF POLICE SERVICES"
		TITLE_CODES["357"]["program"] = "MSP"
		TITLE_CODES["357"]["unit"] = "99"

	TITLE_CODES["355"] = {}
		TITLE_CODES["355"]["title"] = "ADMIN/COORD/OFFICER(FUNC AREA)"
		TITLE_CODES["355"]["program"] = "MSP"
		TITLE_CODES["355"]["unit"] = "99"

	TITLE_CODES["9813"] = {}
		TITLE_CODES["9813"]["title"] = "FIRE SPECIALIST II(NON-SAFETY)"
		TITLE_CODES["9813"]["program"] = "PSS"
		TITLE_CODES["9813"]["unit"] = "F3"

	TITLE_CODES["6966"] = {}
		TITLE_CODES["6966"]["title"] = "FACILITY REQS ANALYST SUPV"
		TITLE_CODES["6966"]["program"] = "PSS"
		TITLE_CODES["6966"]["unit"] = "99"

	TITLE_CODES["3980"] = {}
		TITLE_CODES["3980"]["title"] = "STATE SALARY DIFF-LPNI/NPI"
		TITLE_CODES["3980"]["program"] = "ACADEMIC"
		TITLE_CODES["3980"]["unit"] = "87"

	TITLE_CODES["3106"] = {}
		TITLE_CODES["3106"]["title"] = "ASTRONOMER RECALLED"
		TITLE_CODES["3106"]["program"] = "ACADEMIC"
		TITLE_CODES["3106"]["unit"] = "FX"

	TITLE_CODES["1032"] = {}
		TITLE_CODES["1032"]["title"] = "ASSOCIATE DIVISIONAL DEAN"
		TITLE_CODES["1032"]["program"] = "ACADEMIC"
		TITLE_CODES["1032"]["unit"] = "99"

	TITLE_CODES["3107"] = {}
		TITLE_CODES["3107"]["title"] = "ACTING ASTRONOMER"
		TITLE_CODES["3107"]["program"] = "ACADEMIC"
		TITLE_CODES["3107"]["unit"] = "99"

	TITLE_CODES["210"] = {}
		TITLE_CODES["210"]["title"] = "ASST VICE CHAN (FUNCTL AREA)"
		TITLE_CODES["210"]["program"] = "MSP"
		TITLE_CODES["210"]["unit"] = "99"

	TITLE_CODES["3100"] = {}
		TITLE_CODES["3100"]["title"] = "ASTRONOMER"
		TITLE_CODES["3100"]["program"] = "ACADEMIC"
		TITLE_CODES["3100"]["unit"] = "FX"

	TITLE_CODES["6121"] = {}
		TITLE_CODES["6121"]["title"] = "ILLUSTRATOR, MEDICAL, PRIN"
		TITLE_CODES["6121"]["program"] = "PSS"
		TITLE_CODES["6121"]["unit"] = "99"

	TITLE_CODES["9802"] = {}
		TITLE_CODES["9802"]["title"] = "FIRE CHIEF, ASST"
		TITLE_CODES["9802"]["program"] = "PSS"
		TITLE_CODES["9802"]["unit"] = "99"

	TITLE_CODES["6123"] = {}
		TITLE_CODES["6123"]["title"] = "ILLUSTRATOR, MEDICAL"
		TITLE_CODES["6123"]["program"] = "PSS"
		TITLE_CODES["6123"]["unit"] = "TX"

	TITLE_CODES["6122"] = {}
		TITLE_CODES["6122"]["title"] = "ILLUSTRATOR, MEDICAL, SR"
		TITLE_CODES["6122"]["program"] = "PSS"
		TITLE_CODES["6122"]["unit"] = "TX"

	TITLE_CODES["9295"] = {}
		TITLE_CODES["9295"]["title"] = "CERT PHLEBOTOMIST TECH II, PD"
		TITLE_CODES["9295"]["program"] = "PSS"
		TITLE_CODES["9295"]["unit"] = "EX"

	TITLE_CODES["1568"] = {}
		TITLE_CODES["1568"]["title"] = "ACT PROFESSOR-FY-GENCOMP"
		TITLE_CODES["1568"]["program"] = "ACADEMIC"
		TITLE_CODES["1568"]["unit"] = "A3"

	TITLE_CODES["1569"] = {}
		TITLE_CODES["1569"]["title"] = "INSTRUCTOR IN RES FY-GENCOMP"
		TITLE_CODES["1569"]["program"] = "ACADEMIC"
		TITLE_CODES["1569"]["unit"] = "A3"

	TITLE_CODES["7653"] = {}
		TITLE_CODES["7653"]["title"] = "HR ANALYST II--SUPERVISOR"
		TITLE_CODES["7653"]["program"] = "PSS"
		TITLE_CODES["7653"]["unit"] = "99"

	TITLE_CODES["8671"] = {}
		TITLE_CODES["8671"]["title"] = "MECHANICIAN, LAB, PRIN-MED FAC"
		TITLE_CODES["8671"]["program"] = "PSS"
		TITLE_CODES["8671"]["unit"] = "EX"

	TITLE_CODES["8092"] = {}
		TITLE_CODES["8092"]["title"] = "SHEETMETAL MECH/MACH APPRENTIC"
		TITLE_CODES["8092"]["program"] = "PSS"
		TITLE_CODES["8092"]["unit"] = "K3"

	TITLE_CODES["6902"] = {}
		TITLE_CODES["6902"]["title"] = "ARCHITECTURAL ASSOC, PRIN"
		TITLE_CODES["6902"]["program"] = "PSS"
		TITLE_CODES["6902"]["unit"] = "99"

	TITLE_CODES["8670"] = {}
		TITLE_CODES["8670"]["title"] = "MECHANICIAN,LAB,SR-SUPVR-MF"
		TITLE_CODES["8670"]["program"] = "PSS"
		TITLE_CODES["8670"]["unit"] = "99"

	TITLE_CODES["3619"] = {}
		TITLE_CODES["3619"]["title"] = "VSTG ASSOC LIBRARIAN-FISCAL YR"
		TITLE_CODES["3619"]["program"] = "ACADEMIC"
		TITLE_CODES["3619"]["unit"] = "99"

	TITLE_CODES["280"] = {}
		TITLE_CODES["280"]["title"] = "MANAGER (FUNCTIONAL AREA)"
		TITLE_CODES["280"]["program"] = "MSP"
		TITLE_CODES["280"]["unit"] = "99"

	TITLE_CODES["283"] = {}
		TITLE_CODES["283"]["title"] = "ASSOC. MGR (FUNCT. AREA)"
		TITLE_CODES["283"]["program"] = "MSP"
		TITLE_CODES["283"]["unit"] = "99"

	TITLE_CODES["285"] = {}
		TITLE_CODES["285"]["title"] = "ASST MGR (FUNCTIONAL AREA)"
		TITLE_CODES["285"]["program"] = "MSP"
		TITLE_CODES["285"]["unit"] = "99"

	TITLE_CODES["8892"] = {}
		TITLE_CODES["8892"]["title"] = "ANESTHESIA TECH - SUPERVISOR"
		TITLE_CODES["8892"]["program"] = "PSS"
		TITLE_CODES["8892"]["unit"] = "99"

	TITLE_CODES["7654"] = {}
		TITLE_CODES["7654"]["title"] = "HR ANALYST III-SUPERVISOR"
		TITLE_CODES["7654"]["program"] = "PSS"
		TITLE_CODES["7654"]["unit"] = "99"

	TITLE_CODES["8674"] = {}
		TITLE_CODES["8674"]["title"] = "MECHANICIAN,LAB,HELPER-MED FAC"
		TITLE_CODES["8674"]["program"] = "PSS"
		TITLE_CODES["8674"]["unit"] = "EX"

	TITLE_CODES["7616"] = {}
		TITLE_CODES["7616"]["title"] = "ACCOUNTANT IV"
		TITLE_CODES["7616"]["program"] = "PSS"
		TITLE_CODES["7616"]["unit"] = "99"

	TITLE_CODES["9201"] = {}
		TITLE_CODES["9201"]["title"] = "DENTAL ASST-SUPVR"
		TITLE_CODES["9201"]["program"] = "PSS"
		TITLE_CODES["9201"]["unit"] = "99"

	TITLE_CODES["5505"] = {}
		TITLE_CODES["5505"]["title"] = "BAKER, ASST"
		TITLE_CODES["5505"]["program"] = "PSS"
		TITLE_CODES["5505"]["unit"] = "SX"

	TITLE_CODES["8650"] = {}
		TITLE_CODES["8650"]["title"] = "SUPERINTENDENT, MECH SHOP"
		TITLE_CODES["8650"]["program"] = "PSS"
		TITLE_CODES["8650"]["unit"] = "99"

	TITLE_CODES["1561"] = {}
		TITLE_CODES["1561"]["title"] = "INSTRUCTOR-FY-GENCOMP"
		TITLE_CODES["1561"]["program"] = "ACADEMIC"
		TITLE_CODES["1561"]["unit"] = "A3"

	TITLE_CODES["2550"] = {}
		TITLE_CODES["2550"]["title"] = "ACT INSTR-GRAD STDNT-GSHIP"
		TITLE_CODES["2550"]["program"] = "ACADEMIC"
		TITLE_CODES["2550"]["unit"] = "BX"

	TITLE_CODES["2551"] = {}
		TITLE_CODES["2551"]["title"] = "ACT INSTR-GRAD STDNT-NON-GSHIP"
		TITLE_CODES["2551"]["program"] = "ACADEMIC"
		TITLE_CODES["2551"]["unit"] = "BX"

	TITLE_CODES["7655"] = {}
		TITLE_CODES["7655"]["title"] = "HR ANALYST IV--SUPERVISOR"
		TITLE_CODES["7655"]["program"] = "PSS"
		TITLE_CODES["7655"]["unit"] = "99"

	TITLE_CODES["3004"] = {}
		TITLE_CODES["3004"]["title"] = "SPECIALIST IN THE A.E.S."
		TITLE_CODES["3004"]["program"] = "ACADEMIC"
		TITLE_CODES["3004"]["unit"] = "FX"

	TITLE_CODES["7253"] = {}
		TITLE_CODES["7253"]["title"] = "ANALYST, BUDGET"
		TITLE_CODES["7253"]["program"] = "PSS"
		TITLE_CODES["7253"]["unit"] = "99"

	TITLE_CODES["7652"] = {}
		TITLE_CODES["7652"]["title"] = "HR ANALYST I--SUPERVISOR"
		TITLE_CODES["7652"]["program"] = "PSS"
		TITLE_CODES["7652"]["unit"] = "99"

	TITLE_CODES["9614"] = {}
		TITLE_CODES["9614"]["title"] = "SRA IV - SUPERVISOR"
		TITLE_CODES["9614"]["program"] = "PSS"
		TITLE_CODES["9614"]["unit"] = "99"

	TITLE_CODES["3006"] = {}
		TITLE_CODES["3006"]["title"] = " ----- IN THE A.E.S. RECALLED"
		TITLE_CODES["3006"]["program"] = "ACADEMIC"
		TITLE_CODES["3006"]["unit"] = "FX"

	TITLE_CODES["2256"] = {}
		TITLE_CODES["2256"]["title"] = "FIELD WORK SUP.-FY-CONTINUING"
		TITLE_CODES["2256"]["program"] = "ACADEMIC"
		TITLE_CODES["2256"]["unit"] = "IX"

	TITLE_CODES["2255"] = {}
		TITLE_CODES["2255"]["title"] = "FIELD WORK SUPERVISOR -FY"
		TITLE_CODES["2255"]["program"] = "ACADEMIC"
		TITLE_CODES["2255"]["unit"] = "IX"

	TITLE_CODES["2251"] = {}
		TITLE_CODES["2251"]["title"] = "FIELD WORK SUP.-AY-CONTINUING"
		TITLE_CODES["2251"]["program"] = "ACADEMIC"
		TITLE_CODES["2251"]["unit"] = "IX"

	TITLE_CODES["2250"] = {}
		TITLE_CODES["2250"]["title"] = "FIELD WORK SUPERVISOR-ACAD YR"
		TITLE_CODES["2250"]["program"] = "ACADEMIC"
		TITLE_CODES["2250"]["unit"] = "IX"

	TITLE_CODES["9263"] = {}
		TITLE_CODES["9263"]["title"] = "MEDICAL REC ADMINISTRATOR"
		TITLE_CODES["9263"]["program"] = "PSS"
		TITLE_CODES["9263"]["unit"] = "EX"

	TITLE_CODES["9262"] = {}
		TITLE_CODES["9262"]["title"] = "MEDICAL REC ADMINISTRATOR,SR"
		TITLE_CODES["9262"]["program"] = "PSS"
		TITLE_CODES["9262"]["unit"] = "99"

	TITLE_CODES["8472"] = {}
		TITLE_CODES["8472"]["title"] = "TECHNICIAN, AUTOMOTIVE LEAD"
		TITLE_CODES["8472"]["program"] = "PSS"
		TITLE_CODES["8472"]["unit"] = "SX"

	TITLE_CODES["9260"] = {}
		TITLE_CODES["9260"]["title"] = "COORDINATOR, HOSP. UNIT SER PD"
		TITLE_CODES["9260"]["program"] = "PSS"
		TITLE_CODES["9260"]["unit"] = "EX"

	TITLE_CODES["9267"] = {}
		TITLE_CODES["9267"]["title"] = "TECHNICIAN,MEDICAL RECORD,ASST"
		TITLE_CODES["9267"]["program"] = "PSS"
		TITLE_CODES["9267"]["unit"] = "EX"

	TITLE_CODES["9266"] = {}
		TITLE_CODES["9266"]["title"] = "TECHNICIAN, MEDICAL RECORD"
		TITLE_CODES["9266"]["program"] = "PSS"
		TITLE_CODES["9266"]["unit"] = "EX"

	TITLE_CODES["9265"] = {}
		TITLE_CODES["9265"]["title"] = "TECH,STERILE PROCESSING I"
		TITLE_CODES["9265"]["program"] = "PSS"
		TITLE_CODES["9265"]["unit"] = "EX"

	TITLE_CODES["9264"] = {}
		TITLE_CODES["9264"]["title"] = "MEDICAL REC ADMINISTRATOR,ASST"
		TITLE_CODES["9264"]["program"] = "PSS"
		TITLE_CODES["9264"]["unit"] = "EX"

	TITLE_CODES["9203"] = {}
		TITLE_CODES["9203"]["title"] = "PHYSICIAN ASST"
		TITLE_CODES["9203"]["program"] = "PSS"
		TITLE_CODES["9203"]["unit"] = "HX"

	TITLE_CODES["7657"] = {}
		TITLE_CODES["7657"]["title"] = "HR ANALYST VI--SUPERVISOR"
		TITLE_CODES["7657"]["program"] = "PSS"
		TITLE_CODES["7657"]["unit"] = "99"

	TITLE_CODES["5503"] = {}
		TITLE_CODES["5503"]["title"] = "BAKER"
		TITLE_CODES["5503"]["program"] = "PSS"
		TITLE_CODES["5503"]["unit"] = "SX"

	TITLE_CODES["9603"] = {}
		TITLE_CODES["9603"]["title"] = "LABORATORY ASST II"
		TITLE_CODES["9603"]["program"] = "PSS"
		TITLE_CODES["9603"]["unit"] = "TX"

	TITLE_CODES["115"] = {}
		TITLE_CODES["115"]["title"] = "CAMPUS COUNSEL-EXEC"
		TITLE_CODES["115"]["program"] = "MSP"
		TITLE_CODES["115"]["unit"] = "99"

	TITLE_CODES["114"] = {}
		TITLE_CODES["114"]["title"] = "EXEC ASST (FUNCTL AREA)-EXEC"
		TITLE_CODES["114"]["program"] = "MSP"
		TITLE_CODES["114"]["unit"] = "99"

	TITLE_CODES["117"] = {}
		TITLE_CODES["117"]["title"] = "CHIEF AUDITOR-EXEC"
		TITLE_CODES["117"]["program"] = "MSP"
		TITLE_CODES["117"]["unit"] = "99"

	TITLE_CODES["116"] = {}
		TITLE_CODES["116"]["title"] = "UNIVERSITY AUDITOR-EXEC"
		TITLE_CODES["116"]["program"] = "MSP"
		TITLE_CODES["116"]["unit"] = "99"

	TITLE_CODES["111"] = {}
		TITLE_CODES["111"]["title"] = "ASSOC DEAN (FUNCTL AREA)-EXEC"
		TITLE_CODES["111"]["program"] = "MSP"
		TITLE_CODES["111"]["unit"] = "99"

	TITLE_CODES["110"] = {}
		TITLE_CODES["110"]["title"] = "ASST DEAN (FUNCTL AREA)-EXEC"
		TITLE_CODES["110"]["program"] = "MSP"
		TITLE_CODES["110"]["unit"] = "99"

	TITLE_CODES["113"] = {}
		TITLE_CODES["113"]["title"] = "SPEC ASST (FUNCTL AREA)-EXEC"
		TITLE_CODES["113"]["program"] = "MSP"
		TITLE_CODES["113"]["unit"] = "99"

	TITLE_CODES["112"] = {}
		TITLE_CODES["112"]["title"] = "STAFF ASST FOR PLANNING-EXEC"
		TITLE_CODES["112"]["program"] = "MSP"
		TITLE_CODES["112"]["unit"] = "99"

	TITLE_CODES["9142"] = {}
		TITLE_CODES["9142"]["title"] = "NURSE, ANESTHETIST, PRIN"
		TITLE_CODES["9142"]["program"] = "PSS"
		TITLE_CODES["9142"]["unit"] = "99"

	TITLE_CODES["9143"] = {}
		TITLE_CODES["9143"]["title"] = "NURSE, ANESTHETIST, SR"
		TITLE_CODES["9143"]["program"] = "PSS"
		TITLE_CODES["9143"]["unit"] = "NX"

	TITLE_CODES["9140"] = {}
		TITLE_CODES["9140"]["title"] = "NURSE, CLINICAL I"
		TITLE_CODES["9140"]["program"] = "PSS"
		TITLE_CODES["9140"]["unit"] = "NX"

	TITLE_CODES["119"] = {}
		TITLE_CODES["119"]["title"] = "ASSOC UNIV LIBRARIAN-EXEC"
		TITLE_CODES["119"]["program"] = "MSP"
		TITLE_CODES["119"]["unit"] = "99"

	TITLE_CODES["118"] = {}
		TITLE_CODES["118"]["title"] = "UNIVERSITY LIBRARIAN-EXEC"
		TITLE_CODES["118"]["program"] = "MSP"
		TITLE_CODES["118"]["unit"] = "99"

	TITLE_CODES["9144"] = {}
		TITLE_CODES["9144"]["title"] = "NURSE, ANESTHETIST"
		TITLE_CODES["9144"]["program"] = "PSS"
		TITLE_CODES["9144"]["unit"] = "NX"

	TITLE_CODES["9145"] = {}
		TITLE_CODES["9145"]["title"] = "NURSE, ANESTHETIST, SR-SUPVR"
		TITLE_CODES["9145"]["program"] = "PSS"
		TITLE_CODES["9145"]["unit"] = "99"

	TITLE_CODES["4802"] = {}
		TITLE_CODES["4802"]["title"] = "COMPUTER RES. SPEC. SUPV, II"
		TITLE_CODES["4802"]["program"] = "PSS"
		TITLE_CODES["4802"]["unit"] = "99"

	TITLE_CODES["4803"] = {}
		TITLE_CODES["4803"]["title"] = "COMPUTER RES. SPEC. SUPV, I"
		TITLE_CODES["4803"]["program"] = "PSS"
		TITLE_CODES["4803"]["unit"] = "99"

	TITLE_CODES["4804"] = {}
		TITLE_CODES["4804"]["title"] = "COMPUTER RESOURCE SPEC. II"
		TITLE_CODES["4804"]["program"] = "PSS"
		TITLE_CODES["4804"]["unit"] = "TX"

	TITLE_CODES["4805"] = {}
		TITLE_CODES["4805"]["title"] = "COMPUTER RESOURCE SPEC. I"
		TITLE_CODES["4805"]["program"] = "PSS"
		TITLE_CODES["4805"]["unit"] = "TX"

	TITLE_CODES["4419"] = {}
		TITLE_CODES["4419"]["title"] = "COUNSELOR, LEARN SKILLS SR-SUP"
		TITLE_CODES["4419"]["program"] = "PSS"
		TITLE_CODES["4419"]["unit"] = "99"

	TITLE_CODES["4418"] = {}
		TITLE_CODES["4418"]["title"] = "LEARNING SKILLS COUNSELOR SUPV"
		TITLE_CODES["4418"]["program"] = "PSS"
		TITLE_CODES["4418"]["unit"] = "99"

	TITLE_CODES["4417"] = {}
		TITLE_CODES["4417"]["title"] = "COUNSELOR, LEARNING SKILL ASST"
		TITLE_CODES["4417"]["program"] = "PSS"
		TITLE_CODES["4417"]["unit"] = "99"

	TITLE_CODES["4416"] = {}
		TITLE_CODES["4416"]["title"] = "COUNSELOR, LEARNING SKILLS"
		TITLE_CODES["4416"]["program"] = "PSS"
		TITLE_CODES["4416"]["unit"] = "99"

	TITLE_CODES["4415"] = {}
		TITLE_CODES["4415"]["title"] = "COUNSELOR, LEARNING SKILLS, SR"
		TITLE_CODES["4415"]["program"] = "PSS"
		TITLE_CODES["4415"]["unit"] = "99"

	TITLE_CODES["4414"] = {}
		TITLE_CODES["4414"]["title"] = "COUNSELOR,LEARNING SKILLS,PRIN"
		TITLE_CODES["4414"]["program"] = "PSS"
		TITLE_CODES["4414"]["unit"] = "99"

	TITLE_CODES["9125"] = {}
		TITLE_CODES["9125"]["title"] = "COORDINATOR, TRANSPLANT III"
		TITLE_CODES["9125"]["program"] = "PSS"
		TITLE_CODES["9125"]["unit"] = "NX"

	TITLE_CODES["4410"] = {}
		TITLE_CODES["4410"]["title"] = "COUNSELING ATTORNEY SUPERVISOR"
		TITLE_CODES["4410"]["program"] = "PSS"
		TITLE_CODES["4410"]["unit"] = "99"

	TITLE_CODES["9970"] = {}
		TITLE_CODES["9970"]["title"] = "____APPRENTICE"
		TITLE_CODES["9970"]["program"] = "PSS"
		TITLE_CODES["9970"]["unit"] = "99"

	TITLE_CODES["9606"] = {}
		TITLE_CODES["9606"]["title"] = "LABORATORY HELPER"
		TITLE_CODES["9606"]["program"] = "PSS"
		TITLE_CODES["9606"]["unit"] = "SX"

	TITLE_CODES["9466"] = {}
		TITLE_CODES["9466"]["title"] = "THERAPIST, RECREATION I"
		TITLE_CODES["9466"]["program"] = "PSS"
		TITLE_CODES["9466"]["unit"] = "HX"

	TITLE_CODES["9048"] = {}
		TITLE_CODES["9048"]["title"] = "THERAPIST, RESPIRATORY, II"
		TITLE_CODES["9048"]["program"] = "PSS"
		TITLE_CODES["9048"]["unit"] = "EX"

	TITLE_CODES["6308"] = {}
		TITLE_CODES["6308"]["title"] = "PUBLIC EVENTS MGR, PR - SUPERV"
		TITLE_CODES["6308"]["program"] = "PSS"
		TITLE_CODES["6308"]["unit"] = "99"

	TITLE_CODES["9463"] = {}
		TITLE_CODES["9463"]["title"] = "CASE MANAGER, PER DIEM"
		TITLE_CODES["9463"]["program"] = "PSS"
		TITLE_CODES["9463"]["unit"] = "HX"

	TITLE_CODES["9462"] = {}
		TITLE_CODES["9462"]["title"] = "CASE MANAGER SUPERVISOR"
		TITLE_CODES["9462"]["program"] = "PSS"
		TITLE_CODES["9462"]["unit"] = "99"

	TITLE_CODES["917"] = {}
		TITLE_CODES["917"]["title"] = "ACTING ASSOCIATE DIRECTOR"
		TITLE_CODES["917"]["program"] = "ACADEMIC"
		TITLE_CODES["917"]["unit"] = "99"

	TITLE_CODES["2070"] = {}
		TITLE_CODES["2070"]["title"] = "HS CLINICAL INSTRUCTOR-FY"
		TITLE_CODES["2070"]["program"] = "ACADEMIC"
		TITLE_CODES["2070"]["unit"] = "99"

	TITLE_CODES["2077"] = {}
		TITLE_CODES["2077"]["title"] = "CLINICAL INSTRUCTOR-VOLUNTEER"
		TITLE_CODES["2077"]["program"] = "ACADEMIC"
		TITLE_CODES["2077"]["unit"] = "99"

	TITLE_CODES["910"] = {}
		TITLE_CODES["910"]["title"] = "ASSOCIATE DIRECTOR"
		TITLE_CODES["910"]["program"] = "ACADEMIC"
		TITLE_CODES["910"]["unit"] = "99"

	TITLE_CODES["4961"] = {}
		TITLE_CODES["4961"]["title"] = "CODER, SR"
		TITLE_CODES["4961"]["program"] = "PSS"
		TITLE_CODES["4961"]["unit"] = "CX"

	TITLE_CODES["3226"] = {}
		TITLE_CODES["3226"]["title"] = "ASSISTANT RESEARCH-----SFT"
		TITLE_CODES["3226"]["program"] = "ACADEMIC"
		TITLE_CODES["3226"]["unit"] = "FX"

	TITLE_CODES["9726"] = {}
		TITLE_CODES["9726"]["title"] = "SCIENTIST, MUSEUM, PR - SUPVR"
		TITLE_CODES["9726"]["program"] = "PSS"
		TITLE_CODES["9726"]["unit"] = "99"

	TITLE_CODES["9724"] = {}
		TITLE_CODES["9724"]["title"] = "SCIENTIST, MUSEUM, ASST"
		TITLE_CODES["9724"]["program"] = "PSS"
		TITLE_CODES["9724"]["unit"] = "RX"

	TITLE_CODES["2600"] = {}
		TITLE_CODES["2600"]["title"] = "MILITARY/AIR SCI&TACTICS ASST"
		TITLE_CODES["2600"]["program"] = "ACADEMIC"
		TITLE_CODES["2600"]["unit"] = "99"

	TITLE_CODES["9723"] = {}
		TITLE_CODES["9723"]["title"] = "SCIENTIST, MUSEUM"
		TITLE_CODES["9723"]["program"] = "PSS"
		TITLE_CODES["9723"]["unit"] = "RX"

	TITLE_CODES["9089"] = {}
		TITLE_CODES["9089"]["title"] = "MAMMOGRAPHY TECHNOLOGIST"
		TITLE_CODES["9089"]["program"] = "PSS"
		TITLE_CODES["9089"]["unit"] = "EX"

	TITLE_CODES["9088"] = {}
		TITLE_CODES["9088"]["title"] = "TECHNOLOGIST, CT, LEAD"
		TITLE_CODES["9088"]["program"] = "PSS"
		TITLE_CODES["9088"]["unit"] = "EX"

	TITLE_CODES["9087"] = {}
		TITLE_CODES["9087"]["title"] = "TECHNOLOGIST, CT, PER DIEM"
		TITLE_CODES["9087"]["program"] = "PSS"
		TITLE_CODES["9087"]["unit"] = "EX"

	TITLE_CODES["9086"] = {}
		TITLE_CODES["9086"]["title"] = "TECHNOLOGIST, CT"
		TITLE_CODES["9086"]["program"] = "PSS"
		TITLE_CODES["9086"]["unit"] = "EX"

	TITLE_CODES["9085"] = {}
		TITLE_CODES["9085"]["title"] = "TECHNOLOGIST, MRI"
		TITLE_CODES["9085"]["program"] = "PSS"
		TITLE_CODES["9085"]["unit"] = "EX"

	TITLE_CODES["9084"] = {}
		TITLE_CODES["9084"]["title"] = "TECHNOLOGIST, MRI, PER DIEM"
		TITLE_CODES["9084"]["program"] = "PSS"
		TITLE_CODES["9084"]["unit"] = "EX"

	TITLE_CODES["9083"] = {}
		TITLE_CODES["9083"]["title"] = "LEAD MRI TECHNOLOGIST"
		TITLE_CODES["9083"]["program"] = "PSS"
		TITLE_CODES["9083"]["unit"] = "EX"

	TITLE_CODES["5430"] = {}
		TITLE_CODES["5430"]["title"] = "DIETETIC ASSISTANT"
		TITLE_CODES["5430"]["program"] = "PSS"
		TITLE_CODES["5430"]["unit"] = "EX"

	TITLE_CODES["9081"] = {}
		TITLE_CODES["9081"]["title"] = "SERVICE PARTNER"
		TITLE_CODES["9081"]["program"] = "PSS"
		TITLE_CODES["9081"]["unit"] = "EX"

	TITLE_CODES["9080"] = {}
		TITLE_CODES["9080"]["title"] = "SERVICE PARTNER, PER DIEM"
		TITLE_CODES["9080"]["program"] = "PSS"
		TITLE_CODES["9080"]["unit"] = "EX"

	TITLE_CODES["1933"] = {}
		TITLE_CODES["1933"]["title"] = "ASSOC RESEARCH--SFT/COM PLAN"
		TITLE_CODES["1933"]["program"] = "ACADEMIC"
		TITLE_CODES["1933"]["unit"] = "FX"

	TITLE_CODES["1932"] = {}
		TITLE_CODES["1932"]["title"] = "ASST RESEARCH---SFT/COMP PLAN"
		TITLE_CODES["1932"]["program"] = "ACADEMIC"
		TITLE_CODES["1932"]["unit"] = "FX"

	TITLE_CODES["3263"] = {}
		TITLE_CODES["3263"]["title"] = "GSR-TUIT & FEE REM-UCSD-GRP F"
		TITLE_CODES["3263"]["program"] = "ACADEMIC"
		TITLE_CODES["3263"]["unit"] = "99"

	TITLE_CODES["3262"] = {}
		TITLE_CODES["3262"]["title"] = "GSR-TUIT & FEE REM-UCSD-GRP E"
		TITLE_CODES["3262"]["program"] = "ACADEMIC"
		TITLE_CODES["3262"]["unit"] = "99"

	TITLE_CODES["8047"] = {}
		TITLE_CODES["8047"]["title"] = "HEAVY OFF-ROAD EQUIP MECHANIC"
		TITLE_CODES["8047"]["program"] = "PSS"
		TITLE_CODES["8047"]["unit"] = "K3"

	TITLE_CODES["3264"] = {}
		TITLE_CODES["3264"]["title"] = "GSR-TUIT & FEE REM-UCSD-GRP G"
		TITLE_CODES["3264"]["program"] = "ACADEMIC"
		TITLE_CODES["3264"]["unit"] = "99"

	TITLE_CODES["1934"] = {}
		TITLE_CODES["1934"]["title"] = "RESEARCH------SFT/COMP PLAN"
		TITLE_CODES["1934"]["program"] = "ACADEMIC"
		TITLE_CODES["1934"]["unit"] = "FX"

	TITLE_CODES["3269"] = {}
		TITLE_CODES["3269"]["title"] = "ASSOC ADJUNCT PROFESSOR - FY"
		TITLE_CODES["3269"]["program"] = "ACADEMIC"
		TITLE_CODES["3269"]["unit"] = "99"

	TITLE_CODES["3268"] = {}
		TITLE_CODES["3268"]["title"] = "ASSOC ADJUNCT PROFESSOR - AY"
		TITLE_CODES["3268"]["program"] = "ACADEMIC"
		TITLE_CODES["3268"]["unit"] = "99"

	TITLE_CODES["5126"] = {}
		TITLE_CODES["5126"]["title"] = "COOK, MC"
		TITLE_CODES["5126"]["program"] = "PSS"
		TITLE_CODES["5126"]["unit"] = "SX"

	TITLE_CODES["1938"] = {}
		TITLE_CODES["1938"]["title"] = "ROTATING RESEARCH PROF-ACAD YR"
		TITLE_CODES["1938"]["program"] = "ACADEMIC"
		TITLE_CODES["1938"]["unit"] = "FX"

	TITLE_CODES["7659"] = {}
		TITLE_CODES["7659"]["title"] = "ADMIN SPECIALIST SUPERVISOR"
		TITLE_CODES["7659"]["program"] = "PSS"
		TITLE_CODES["7659"]["unit"] = "99"

	TITLE_CODES["9312"] = {}
		TITLE_CODES["9312"]["title"] = "SOCIAL WORKER CLIN SUPERVISING"
		TITLE_CODES["9312"]["program"] = "PSS"
		TITLE_CODES["9312"]["unit"] = "99"

	TITLE_CODES["9006"] = {}
		TITLE_CODES["9006"]["title"] = "TECHNOLOGIST,NUC MED,SR,PER DI"
		TITLE_CODES["9006"]["program"] = "PSS"
		TITLE_CODES["9006"]["unit"] = "HX"

	TITLE_CODES["9310"] = {}
		TITLE_CODES["9310"]["title"] = "SOCIAL WORKER, CLN,PD,LICENSED"
		TITLE_CODES["9310"]["program"] = "PSS"
		TITLE_CODES["9310"]["unit"] = "HX"

	TITLE_CODES["7272"] = {}
		TITLE_CODES["7272"]["title"] = "ANALYST VII - SUPERVISOR"
		TITLE_CODES["7272"]["program"] = "PSS"
		TITLE_CODES["7272"]["unit"] = "99"

	TITLE_CODES["3509"] = {}
		TITLE_CODES["3509"]["title"] = "COORD OF PUBLIC PROGRAMS IV"
		TITLE_CODES["3509"]["program"] = "ACADEMIC"
		TITLE_CODES["3509"]["unit"] = "FX"

	TITLE_CODES["845"] = {}
		TITLE_CODES["845"]["title"] = "ACADEMIC COORD III - FISCAL YR"
		TITLE_CODES["845"]["program"] = "ACADEMIC"
		TITLE_CODES["845"]["unit"] = "99"

	TITLE_CODES["844"] = {}
		TITLE_CODES["844"]["title"] = "ACADEMIC COORD III-ACADEMIC YR"
		TITLE_CODES["844"]["program"] = "ACADEMIC"
		TITLE_CODES["844"]["unit"] = "99"

	TITLE_CODES["843"] = {}
		TITLE_CODES["843"]["title"] = "ACADEMIC COORD II - FISCAL YR"
		TITLE_CODES["843"]["program"] = "ACADEMIC"
		TITLE_CODES["843"]["unit"] = "99"

	TITLE_CODES["842"] = {}
		TITLE_CODES["842"]["title"] = "ACADEMIC COORD II-ACADEMIC YR"
		TITLE_CODES["842"]["program"] = "ACADEMIC"
		TITLE_CODES["842"]["unit"] = "99"

	TITLE_CODES["841"] = {}
		TITLE_CODES["841"]["title"] = "ACADEMIC COORD I - FISCAL YR"
		TITLE_CODES["841"]["program"] = "ACADEMIC"
		TITLE_CODES["841"]["unit"] = "99"

	TITLE_CODES["840"] = {}
		TITLE_CODES["840"]["title"] = "ACADEMIC COORD I - ACADEMIC YR"
		TITLE_CODES["840"]["program"] = "ACADEMIC"
		TITLE_CODES["840"]["unit"] = "99"

	TITLE_CODES["8897"] = {}
		TITLE_CODES["8897"]["title"] = "ANESTHESIA TECHNICIAN"
		TITLE_CODES["8897"]["program"] = "PSS"
		TITLE_CODES["8897"]["unit"] = "EX"

	TITLE_CODES["3501"] = {}
		TITLE_CODES["3501"]["title"] = "COORD OF PUBLIC PROGRAMS VIII"
		TITLE_CODES["3501"]["program"] = "ACADEMIC"
		TITLE_CODES["3501"]["unit"] = "FX"

	TITLE_CODES["5081"] = {}
		TITLE_CODES["5081"]["title"] = "CUSTODIAN, SR, PER DIEM, MC"
		TITLE_CODES["5081"]["program"] = "PSS"
		TITLE_CODES["5081"]["unit"] = "SX"

	TITLE_CODES["3503"] = {}
		TITLE_CODES["3503"]["title"] = "COORD OF PUBLIC PROGRAMS VII"
		TITLE_CODES["3503"]["program"] = "ACADEMIC"
		TITLE_CODES["3503"]["unit"] = "FX"

	TITLE_CODES["5087"] = {}
		TITLE_CODES["5087"]["title"] = "CUSTODIAN, MC"
		TITLE_CODES["5087"]["program"] = "PSS"
		TITLE_CODES["5087"]["unit"] = "SX"

	TITLE_CODES["3505"] = {}
		TITLE_CODES["3505"]["title"] = "COORD OF PUBLIC PROGRAMS VI"
		TITLE_CODES["3505"]["program"] = "ACADEMIC"
		TITLE_CODES["3505"]["unit"] = "FX"

	TITLE_CODES["8891"] = {}
		TITLE_CODES["8891"]["title"] = "TECHNICIAN, EMERG TRAUMA SR PD"
		TITLE_CODES["8891"]["program"] = "PSS"
		TITLE_CODES["8891"]["unit"] = "EX"

	TITLE_CODES["3507"] = {}
		TITLE_CODES["3507"]["title"] = "COORD OF PUBLIC PROGRAMS V"
		TITLE_CODES["3507"]["program"] = "ACADEMIC"
		TITLE_CODES["3507"]["unit"] = "FX"

	TITLE_CODES["7157"] = {}
		TITLE_CODES["7157"]["title"] = "SENIOR ENGINEER - SUPERVISOR"
		TITLE_CODES["7157"]["program"] = "PSS"
		TITLE_CODES["7157"]["unit"] = "99"

	TITLE_CODES["9192"] = {}
		TITLE_CODES["9192"]["title"] = "OPTOMETRIST, SR"
		TITLE_CODES["9192"]["program"] = "PSS"
		TITLE_CODES["9192"]["unit"] = "99"

	TITLE_CODES["8976"] = {}
		TITLE_CODES["8976"]["title"] = "TECHNICIAN, HOSPITAL LAB, I"
		TITLE_CODES["8976"]["program"] = "PSS"
		TITLE_CODES["8976"]["unit"] = "EX"

	TITLE_CODES["7156"] = {}
		TITLE_CODES["7156"]["title"] = "ASSOCIATE ENGINEER-SUPERVISOR"
		TITLE_CODES["7156"]["program"] = "PSS"
		TITLE_CODES["7156"]["unit"] = "99"

	TITLE_CODES["9522"] = {}
		TITLE_CODES["9522"]["title"] = "ANIMAL RESOURCES SUPVR"
		TITLE_CODES["9522"]["program"] = "PSS"
		TITLE_CODES["9522"]["unit"] = "99"

	TITLE_CODES["3220"] = {}
		TITLE_CODES["3220"]["title"] = "ASST RES ----- - FISCAL YEAR"
		TITLE_CODES["3220"]["program"] = "ACADEMIC"
		TITLE_CODES["3220"]["unit"] = "FX"

	TITLE_CODES["7155"] = {}
		TITLE_CODES["7155"]["title"] = "ENGINEER, JR"
		TITLE_CODES["7155"]["program"] = "PSS"
		TITLE_CODES["7155"]["unit"] = "99"

	TITLE_CODES["9194"] = {}
		TITLE_CODES["9194"]["title"] = "OPTICIAN"
		TITLE_CODES["9194"]["program"] = "PSS"
		TITLE_CODES["9194"]["unit"] = "EX"

	TITLE_CODES["8544"] = {}
		TITLE_CODES["8544"]["title"] = "FARM WORKER, SEASONAL PER DIEM"
		TITLE_CODES["8544"]["program"] = "PSS"
		TITLE_CODES["8544"]["unit"] = "SX"

	TITLE_CODES["5049"] = {}
		TITLE_CODES["5049"]["title"] = "FOOD SERVICE MANAGER III, MC"
		TITLE_CODES["5049"]["program"] = "PSS"
		TITLE_CODES["5049"]["unit"] = "99"

	TITLE_CODES["7153"] = {}
		TITLE_CODES["7153"]["title"] = "ENGINEER, ASSOC"
		TITLE_CODES["7153"]["program"] = "PSS"
		TITLE_CODES["7153"]["unit"] = "99"

	TITLE_CODES["8900"] = {}
		TITLE_CODES["8900"]["title"] = "ANESTHESIA TECHNICIAN II PD"
		TITLE_CODES["8900"]["program"] = "PSS"
		TITLE_CODES["8900"]["unit"] = "EX"

	TITLE_CODES["7231"] = {}
		TITLE_CODES["7231"]["title"] = "SURVEY SUPVR"
		TITLE_CODES["7231"]["program"] = "PSS"
		TITLE_CODES["7231"]["unit"] = "99"

	TITLE_CODES["7152"] = {}
		TITLE_CODES["7152"]["title"] = "ENGINEER, SR"
		TITLE_CODES["7152"]["program"] = "PSS"
		TITLE_CODES["7152"]["unit"] = "99"

	TITLE_CODES["5331"] = {}
		TITLE_CODES["5331"]["title"] = "PARKING SUPV, SR"
		TITLE_CODES["5331"]["program"] = "PSS"
		TITLE_CODES["5331"]["unit"] = "99"

	TITLE_CODES["5330"] = {}
		TITLE_CODES["5330"]["title"] = "PARKING SUPV, PRIN"
		TITLE_CODES["5330"]["program"] = "PSS"
		TITLE_CODES["5330"]["unit"] = "99"

	TITLE_CODES["5333"] = {}
		TITLE_CODES["5333"]["title"] = "PARKING REPRESENTATIVE, SR"
		TITLE_CODES["5333"]["program"] = "PSS"
		TITLE_CODES["5333"]["unit"] = "SX"

	TITLE_CODES["5332"] = {}
		TITLE_CODES["5332"]["title"] = "PARKING REPRESENTATIVE, LEAD"
		TITLE_CODES["5332"]["program"] = "PSS"
		TITLE_CODES["5332"]["unit"] = "SX"

	TITLE_CODES["5335"] = {}
		TITLE_CODES["5335"]["title"] = "PARKING ASST"
		TITLE_CODES["5335"]["program"] = "PSS"
		TITLE_CODES["5335"]["unit"] = "SX"

	TITLE_CODES["5334"] = {}
		TITLE_CODES["5334"]["title"] = "PARKING REPRESENTATIVE"
		TITLE_CODES["5334"]["program"] = "PSS"
		TITLE_CODES["5334"]["unit"] = "SX"

	TITLE_CODES["5337"] = {}
		TITLE_CODES["5337"]["title"] = "PARKING REPRESENTATIV,SR-SUPVR"
		TITLE_CODES["5337"]["program"] = "PSS"
		TITLE_CODES["5337"]["unit"] = "99"

	TITLE_CODES["8005"] = {}
		TITLE_CODES["8005"]["title"] = "PHYSICIAN ASSISTANT-SUPVR"
		TITLE_CODES["8005"]["program"] = "PSS"
		TITLE_CODES["8005"]["unit"] = "99"

	TITLE_CODES["5339"] = {}
		TITLE_CODES["5339"]["title"] = "PARKING SUPVR"
		TITLE_CODES["5339"]["program"] = "PSS"
		TITLE_CODES["5339"]["unit"] = "99"

	TITLE_CODES["3223"] = {}
		TITLE_CODES["3223"]["title"] = "ASSISTANT RESEARCH ___-ACAD YR"
		TITLE_CODES["3223"]["program"] = "ACADEMIC"
		TITLE_CODES["3223"]["unit"] = "FX"

	TITLE_CODES["7150"] = {}
		TITLE_CODES["7150"]["title"] = "ENGINEER SUPERVISOR"
		TITLE_CODES["7150"]["program"] = "PSS"
		TITLE_CODES["7150"]["unit"] = "99"

	TITLE_CODES["1630"] = {}
		TITLE_CODES["1630"]["title"] = "LECTURER - ACADEMIC YEAR"
		TITLE_CODES["1630"]["program"] = "ACADEMIC"
		TITLE_CODES["1630"]["unit"] = "IX"

	TITLE_CODES["1631"] = {}
		TITLE_CODES["1631"]["title"] = "LECTURER-AY-CONTINUING APPT."
		TITLE_CODES["1631"]["program"] = "ACADEMIC"
		TITLE_CODES["1631"]["unit"] = "IX"

	TITLE_CODES["1632"] = {}
		TITLE_CODES["1632"]["title"] = "LECTURER - ACADEMIC YEAR - 1/9"
		TITLE_CODES["1632"]["program"] = "ACADEMIC"
		TITLE_CODES["1632"]["unit"] = "IX"

	TITLE_CODES["1633"] = {}
		TITLE_CODES["1633"]["title"] = "LECTURER-AY-1/9-CONTINUING"
		TITLE_CODES["1633"]["program"] = "ACADEMIC"
		TITLE_CODES["1633"]["unit"] = "IX"

	TITLE_CODES["1634"] = {}
		TITLE_CODES["1634"]["title"] = "LECTURER - FISCAL YEAR"
		TITLE_CODES["1634"]["program"] = "ACADEMIC"
		TITLE_CODES["1634"]["unit"] = "IX"

	TITLE_CODES["1635"] = {}
		TITLE_CODES["1635"]["title"] = "LECTURER-FY-CONTINUING APPT."
		TITLE_CODES["1635"]["program"] = "ACADEMIC"
		TITLE_CODES["1635"]["unit"] = "IX"

	TITLE_CODES["1981"] = {}
		TITLE_CODES["1981"]["title"] = "RESEARCH____ -AY-BUS/ECON/ENG"
		TITLE_CODES["1981"]["program"] = "ACADEMIC"
		TITLE_CODES["1981"]["unit"] = "FX"

	TITLE_CODES["1731"] = {}
		TITLE_CODES["1731"]["title"] = "HS CLINICAL INSTRUCTOR-HCOMP"
		TITLE_CODES["1731"]["program"] = "ACADEMIC"
		TITLE_CODES["1731"]["unit"] = "99"

	TITLE_CODES["1730"] = {}
		TITLE_CODES["1730"]["title"] = "ADJUNCT PROFESSOR-HCOMP"
		TITLE_CODES["1730"]["program"] = "ACADEMIC"
		TITLE_CODES["1730"]["unit"] = "99"

	TITLE_CODES["1733"] = {}
		TITLE_CODES["1733"]["title"] = "HS ASSOCIATE CLIN PROF-HCOMP"
		TITLE_CODES["1733"]["program"] = "ACADEMIC"
		TITLE_CODES["1733"]["unit"] = "99"

	TITLE_CODES["1732"] = {}
		TITLE_CODES["1732"]["title"] = "HS ASSISTANT CLIN PROF-HCOMP"
		TITLE_CODES["1732"]["program"] = "ACADEMIC"
		TITLE_CODES["1732"]["unit"] = "99"

	TITLE_CODES["1735"] = {}
		TITLE_CODES["1735"]["title"] = "INSTRUCTOR-GENCOMP-B"
		TITLE_CODES["1735"]["program"] = "ACADEMIC"
		TITLE_CODES["1735"]["unit"] = "A3"

	TITLE_CODES["1734"] = {}
		TITLE_CODES["1734"]["title"] = "HS CLINICAL PROFESSOR-HCOMP"
		TITLE_CODES["1734"]["program"] = "ACADEMIC"
		TITLE_CODES["1734"]["unit"] = "99"

	TITLE_CODES["1737"] = {}
		TITLE_CODES["1737"]["title"] = "ASSISTANT PROF-GENCOMP-B"
		TITLE_CODES["1737"]["program"] = "ACADEMIC"
		TITLE_CODES["1737"]["unit"] = "A3"

	TITLE_CODES["1989"] = {}
		TITLE_CODES["1989"]["title"] = "ASST RES ---- -FY-BUS/ECON/ENG"
		TITLE_CODES["1989"]["program"] = "ACADEMIC"
		TITLE_CODES["1989"]["unit"] = "FX"

	TITLE_CODES["9214"] = {}
		TITLE_CODES["9214"]["title"] = "COORDINATOR, MED OFF SRVC, III"
		TITLE_CODES["9214"]["program"] = "PSS"
		TITLE_CODES["9214"]["unit"] = "EX"

	TITLE_CODES["9215"] = {}
		TITLE_CODES["9215"]["title"] = "COORD, MED OFF SRVC,III--SUPVR"
		TITLE_CODES["9215"]["program"] = "PSS"
		TITLE_CODES["9215"]["unit"] = "99"

	TITLE_CODES["9166"] = {}
		TITLE_CODES["9166"]["title"] = "OR ASSISTANT II"
		TITLE_CODES["9166"]["program"] = "PSS"
		TITLE_CODES["9166"]["unit"] = "EX"

	TITLE_CODES["8793"] = {}
		TITLE_CODES["8793"]["title"] = "TECHNICIAN, SURGICAL, PRIN"
		TITLE_CODES["8793"]["program"] = "PSS"
		TITLE_CODES["8793"]["unit"] = "EX"

	TITLE_CODES["753"] = {}
		TITLE_CODES["753"]["title"] = "PRINCIPAL BUYER"
		TITLE_CODES["753"]["program"] = "MSP"
		TITLE_CODES["753"]["unit"] = "99"

	TITLE_CODES["752"] = {}
		TITLE_CODES["752"]["title"] = "MARINE SUPERINTENDENT"
		TITLE_CODES["752"]["program"] = "MSP"
		TITLE_CODES["752"]["unit"] = "99"

	TITLE_CODES["751"] = {}
		TITLE_CODES["751"]["title"] = "PRINCIPAL PERSONNEL ANALYST II"
		TITLE_CODES["751"]["program"] = "MSP"
		TITLE_CODES["751"]["unit"] = "99"

	TITLE_CODES["757"] = {}
		TITLE_CODES["757"]["title"] = "ASST MARINE SUPERINTENDENT"
		TITLE_CODES["757"]["program"] = "MSP"
		TITLE_CODES["757"]["unit"] = "99"

	TITLE_CODES["756"] = {}
		TITLE_CODES["756"]["title"] = "CAPTAIN"
		TITLE_CODES["756"]["program"] = "MSP"
		TITLE_CODES["756"]["unit"] = "99"

	TITLE_CODES["755"] = {}
		TITLE_CODES["755"]["title"] = "ASST PHYSICAL PLANT ADMIN"
		TITLE_CODES["755"]["program"] = "MSP"
		TITLE_CODES["755"]["unit"] = "99"

	TITLE_CODES["754"] = {}
		TITLE_CODES["754"]["title"] = "SENIOR CAPTAIN"
		TITLE_CODES["754"]["program"] = "MSP"
		TITLE_CODES["754"]["unit"] = "99"

	TITLE_CODES["759"] = {}
		TITLE_CODES["759"]["title"] = "CLINICAL LABORATORY MANAGER"
		TITLE_CODES["759"]["program"] = "MSP"
		TITLE_CODES["759"]["unit"] = "99"

	TITLE_CODES["736"] = {}
		TITLE_CODES["736"]["title"] = "PROGRAMMER/ANALYST V"
		TITLE_CODES["736"]["program"] = "MSP"
		TITLE_CODES["736"]["unit"] = "99"

	TITLE_CODES["8998"] = {}
		TITLE_CODES["8998"]["title"] = "CYTOTECHNOLOGIST, PER DIEM"
		TITLE_CODES["8998"]["program"] = "PSS"
		TITLE_CODES["8998"]["unit"] = "HX"

	TITLE_CODES["3070"] = {}
		TITLE_CODES["3070"]["title"] = "ASO---IN THE AES-ACADEMIC YEAR"
		TITLE_CODES["3070"]["program"] = "ACADEMIC"
		TITLE_CODES["3070"]["unit"] = "FX"

	TITLE_CODES["739"] = {}
		TITLE_CODES["739"]["title"] = "PROGRAMMER/ANALYST IV-SUPVR"
		TITLE_CODES["739"]["program"] = "MSP"
		TITLE_CODES["739"]["unit"] = "99"

	TITLE_CODES["3072"] = {}
		TITLE_CODES["3072"]["title"] = "ASO---IN THE AES-B/ECON/ENG-AY"
		TITLE_CODES["3072"]["program"] = "ACADEMIC"
		TITLE_CODES["3072"]["unit"] = "FX"

	TITLE_CODES["3073"] = {}
		TITLE_CODES["3073"]["title"] = "ASO---IN AES-B/ECON/ENG/AY-1/9"
		TITLE_CODES["3073"]["program"] = "ACADEMIC"
		TITLE_CODES["3073"]["unit"] = "FX"

	TITLE_CODES["3074"] = {}
		TITLE_CODES["3074"]["title"] = "ACT ASO---IN THE AES-ACAD YR"
		TITLE_CODES["3074"]["program"] = "ACADEMIC"
		TITLE_CODES["3074"]["unit"] = "99"

	TITLE_CODES["3075"] = {}
		TITLE_CODES["3075"]["title"] = "ACT ASO---IN THE AES-AY-1/9"
		TITLE_CODES["3075"]["program"] = "ACADEMIC"
		TITLE_CODES["3075"]["unit"] = "99"

	TITLE_CODES["3076"] = {}
		TITLE_CODES["3076"]["title"] = "ACT ASO---IN AES-B/ECON/ENG-AY"
		TITLE_CODES["3076"]["program"] = "ACADEMIC"
		TITLE_CODES["3076"]["unit"] = "99"

	TITLE_CODES["738"] = {}
		TITLE_CODES["738"]["title"] = "PROGRAMMER/ANALYST IV"
		TITLE_CODES["738"]["program"] = "MSP"
		TITLE_CODES["738"]["unit"] = "99"

	TITLE_CODES["7649"] = {}
		TITLE_CODES["7649"]["title"] = "HR ANALYST IV"
		TITLE_CODES["7649"]["program"] = "PSS"
		TITLE_CODES["7649"]["unit"] = "99"

	TITLE_CODES["7648"] = {}
		TITLE_CODES["7648"]["title"] = "HR ANALYST III"
		TITLE_CODES["7648"]["program"] = "PSS"
		TITLE_CODES["7648"]["unit"] = "99"

	TITLE_CODES["1030"] = {}
		TITLE_CODES["1030"]["title"] = "DIVISIONAL DEAN"
		TITLE_CODES["1030"]["program"] = "ACADEMIC"
		TITLE_CODES["1030"]["unit"] = "99"

	TITLE_CODES["8541"] = {}
		TITLE_CODES["8541"]["title"] = "TECHNICIAN, AGRICULTURAL, SR"
		TITLE_CODES["8541"]["program"] = "PSS"
		TITLE_CODES["8541"]["unit"] = "SX"

	TITLE_CODES["1027"] = {}
		TITLE_CODES["1027"]["title"] = "ACTING ASSISTANT DEAN"
		TITLE_CODES["1027"]["program"] = "ACADEMIC"
		TITLE_CODES["1027"]["unit"] = "99"

	TITLE_CODES["1020"] = {}
		TITLE_CODES["1020"]["title"] = "ASSISTANT DEAN"
		TITLE_CODES["1020"]["program"] = "ACADEMIC"
		TITLE_CODES["1020"]["unit"] = "99"

	TITLE_CODES["1188"] = {}
		TITLE_CODES["1188"]["title"] = "VST PROFESSOR-LAW SCHOOL SCALE"
		TITLE_CODES["1188"]["program"] = "ACADEMIC"
		TITLE_CODES["1188"]["unit"] = "99"

	TITLE_CODES["3378"] = {}
		TITLE_CODES["3378"]["title"] = "ADJ PROF-FY-BUS/ECON/ENG"
		TITLE_CODES["3378"]["program"] = "ACADEMIC"
		TITLE_CODES["3378"]["unit"] = "99"

	TITLE_CODES["3377"] = {}
		TITLE_CODES["3377"]["title"] = "ADJ PROF-ACAD YR-BUS/ECON/ENG"
		TITLE_CODES["3377"]["program"] = "ACADEMIC"
		TITLE_CODES["3377"]["unit"] = "99"

	TITLE_CODES["3376"] = {}
		TITLE_CODES["3376"]["title"] = "ASO ADJ PRO-AY-1/9-B/ECON/ENG"
		TITLE_CODES["3376"]["program"] = "ACADEMIC"
		TITLE_CODES["3376"]["unit"] = "99"

	TITLE_CODES["3375"] = {}
		TITLE_CODES["3375"]["title"] = "ASSO ADJ PRO-FY-BUS/ECON/ENG"
		TITLE_CODES["3375"]["program"] = "ACADEMIC"
		TITLE_CODES["3375"]["unit"] = "99"

	TITLE_CODES["3374"] = {}
		TITLE_CODES["3374"]["title"] = "ASSO ADJ PROF-AY-BUS/ECON/ENG"
		TITLE_CODES["3374"]["program"] = "ACADEMIC"
		TITLE_CODES["3374"]["unit"] = "99"

	TITLE_CODES["1182"] = {}
		TITLE_CODES["1182"]["title"] = "ACT PROFESSOR-LAW SCHOOL SCALE"
		TITLE_CODES["1182"]["program"] = "ACADEMIC"
		TITLE_CODES["1182"]["unit"] = "A3"

	TITLE_CODES["1183"] = {}
		TITLE_CODES["1183"]["title"] = "ACT PROFESSOR-LAW SCHOOL-1/9"
		TITLE_CODES["1183"]["program"] = "ACADEMIC"
		TITLE_CODES["1183"]["unit"] = "A3"

	TITLE_CODES["1180"] = {}
		TITLE_CODES["1180"]["title"] = "PROFESSOR-LAW SCHOOL SCALE"
		TITLE_CODES["1180"]["program"] = "ACADEMIC"
		TITLE_CODES["1180"]["unit"] = "A3"

	TITLE_CODES["1037"] = {}
		TITLE_CODES["1037"]["title"] = "ACTING DIVISIONAL DEAN"
		TITLE_CODES["1037"]["program"] = "ACADEMIC"
		TITLE_CODES["1037"]["unit"] = "99"

	TITLE_CODES["726"] = {}
		TITLE_CODES["726"]["title"] = "PRINCIPAL PERFUSIONIST"
		TITLE_CODES["726"]["program"] = "MSP"
		TITLE_CODES["726"]["unit"] = "99"

	TITLE_CODES["727"] = {}
		TITLE_CODES["727"]["title"] = "PRINCIPAL ENGINEER"
		TITLE_CODES["727"]["program"] = "MSP"
		TITLE_CODES["727"]["unit"] = "99"

	TITLE_CODES["725"] = {}
		TITLE_CODES["725"]["title"] = "PRINCIPAL E,H,& S SPECIALIST"
		TITLE_CODES["725"]["program"] = "MSP"
		TITLE_CODES["725"]["unit"] = "99"

	TITLE_CODES["1748"] = {}
		TITLE_CODES["1748"]["title"] = "ASST ADJUNCT PROF-GENCOMP-B"
		TITLE_CODES["1748"]["program"] = "ACADEMIC"
		TITLE_CODES["1748"]["unit"] = "99"

	TITLE_CODES["723"] = {}
		TITLE_CODES["723"]["title"] = "PR CONSTRUCTION INSPECTOR"
		TITLE_CODES["723"]["program"] = "MSP"
		TITLE_CODES["723"]["unit"] = "99"

	TITLE_CODES["721"] = {}
		TITLE_CODES["721"]["title"] = "PRINCIPAL PLANNER"
		TITLE_CODES["721"]["program"] = "MSP"
		TITLE_CODES["721"]["unit"] = "99"

	TITLE_CODES["1744"] = {}
		TITLE_CODES["1744"]["title"] = "ASST PROF IN RES-GENCOMP-B"
		TITLE_CODES["1744"]["program"] = "ACADEMIC"
		TITLE_CODES["1744"]["unit"] = "A3"

	TITLE_CODES["1745"] = {}
		TITLE_CODES["1745"]["title"] = "ASSOC PROF IN RES-GENCOMP-B"
		TITLE_CODES["1745"]["program"] = "ACADEMIC"
		TITLE_CODES["1745"]["unit"] = "A3"

	TITLE_CODES["1746"] = {}
		TITLE_CODES["1746"]["title"] = "PROF IN RES-GENCOMP-B"
		TITLE_CODES["1746"]["program"] = "ACADEMIC"
		TITLE_CODES["1746"]["unit"] = "A3"

	TITLE_CODES["1747"] = {}
		TITLE_CODES["1747"]["title"] = "ADJUNCT INSTR-GENCOMP-B"
		TITLE_CODES["1747"]["program"] = "ACADEMIC"
		TITLE_CODES["1747"]["unit"] = "99"

	TITLE_CODES["1740"] = {}
		TITLE_CODES["1740"]["title"] = "ACT ASSOC PROFESSOR-GENCOMP-B"
		TITLE_CODES["1740"]["program"] = "ACADEMIC"
		TITLE_CODES["1740"]["unit"] = "A3"

	TITLE_CODES["1741"] = {}
		TITLE_CODES["1741"]["title"] = "PROFESSOR-GENCOMP-B"
		TITLE_CODES["1741"]["program"] = "ACADEMIC"
		TITLE_CODES["1741"]["unit"] = "A3"

	TITLE_CODES["728"] = {}
		TITLE_CODES["728"]["title"] = "SENIOR DEVELOPMENT ENGINEER"
		TITLE_CODES["728"]["program"] = "MSP"
		TITLE_CODES["728"]["unit"] = "99"

	TITLE_CODES["729"] = {}
		TITLE_CODES["729"]["title"] = "PRINCIPAL DEVELOPMENT ENGINEER"
		TITLE_CODES["729"]["program"] = "MSP"
		TITLE_CODES["729"]["unit"] = "99"

	TITLE_CODES["8170"] = {}
		TITLE_CODES["8170"]["title"] = "MECHANIC, PHYSICAL PLANT,SUPVR"
		TITLE_CODES["8170"]["program"] = "PSS"
		TITLE_CODES["8170"]["unit"] = "99"

	TITLE_CODES["7290"] = {}
		TITLE_CODES["7290"]["title"] = "PROGRAMMER I - SUPV"
		TITLE_CODES["7290"]["program"] = "PSS"
		TITLE_CODES["7290"]["unit"] = "99"

	TITLE_CODES["8172"] = {}
		TITLE_CODES["8172"]["title"] = "MECHANIC, PHYSICAL PLANT, SR"
		TITLE_CODES["8172"]["program"] = "PSS"
		TITLE_CODES["8172"]["unit"] = "K3"

	TITLE_CODES["8173"] = {}
		TITLE_CODES["8173"]["title"] = "MECHANIC, PHYSICAL PLANT, LEAD"
		TITLE_CODES["8173"]["program"] = "PSS"
		TITLE_CODES["8173"]["unit"] = "K3"

	TITLE_CODES["1209"] = {}
		TITLE_CODES["1209"]["title"] = "ASSOC PROF-RECALLED-AY-1/9TH"
		TITLE_CODES["1209"]["program"] = "ACADEMIC"
		TITLE_CODES["1209"]["unit"] = "A3"

	TITLE_CODES["1208"] = {}
		TITLE_CODES["1208"]["title"] = "VST ASSOC PROFESSOR-ACAD YR"
		TITLE_CODES["1208"]["program"] = "ACADEMIC"
		TITLE_CODES["1208"]["unit"] = "99"

	TITLE_CODES["9132"] = {}
		TITLE_CODES["9132"]["title"] = "NURSE, ADMINISTRATIVE III"
		TITLE_CODES["9132"]["program"] = "PSS"
		TITLE_CODES["9132"]["unit"] = "99"

	TITLE_CODES["1205"] = {}
		TITLE_CODES["1205"]["title"] = "ASSOC PROF-FAC EARLY RETIR PGM"
		TITLE_CODES["1205"]["program"] = "ACADEMIC"
		TITLE_CODES["1205"]["unit"] = "A3"

	TITLE_CODES["1207"] = {}
		TITLE_CODES["1207"]["title"] = "ACT ASSOC PROFESSOR-ACAD YR"
		TITLE_CODES["1207"]["program"] = "ACADEMIC"
		TITLE_CODES["1207"]["unit"] = "A3"

	TITLE_CODES["1206"] = {}
		TITLE_CODES["1206"]["title"] = "ASSOC PROFESSOR-AY-RECALLED"
		TITLE_CODES["1206"]["program"] = "ACADEMIC"
		TITLE_CODES["1206"]["unit"] = "A3"

	TITLE_CODES["1201"] = {}
		TITLE_CODES["1201"]["title"] = "ACT ASSOC PROFESSOR-AY-1/9TH"
		TITLE_CODES["1201"]["program"] = "ACADEMIC"
		TITLE_CODES["1201"]["unit"] = "A3"

	TITLE_CODES["1200"] = {}
		TITLE_CODES["1200"]["title"] = "ASSOCIATE PROFESSOR-ACAD YR"
		TITLE_CODES["1200"]["program"] = "ACADEMIC"
		TITLE_CODES["1200"]["unit"] = "A3"

	TITLE_CODES["1203"] = {}
		TITLE_CODES["1203"]["title"] = "ASSOC PROFESSOR-ACAD YR-1/9TH"
		TITLE_CODES["1203"]["program"] = "ACADEMIC"
		TITLE_CODES["1203"]["unit"] = "A3"

	TITLE_CODES["1202"] = {}
		TITLE_CODES["1202"]["title"] = "VST ASSOC PROFESSOR-AY-1/9TH"
		TITLE_CODES["1202"]["program"] = "ACADEMIC"
		TITLE_CODES["1202"]["unit"] = "99"

	TITLE_CODES["5061"] = {}
		TITLE_CODES["5061"]["title"] = "STOREKEEPER, LEAD"
		TITLE_CODES["5061"]["program"] = "PSS"
		TITLE_CODES["5061"]["unit"] = "SX"

	TITLE_CODES["5521"] = {}
		TITLE_CODES["5521"]["title"] = "COOK, PRIN"
		TITLE_CODES["5521"]["program"] = "PSS"
		TITLE_CODES["5521"]["unit"] = "99"

	TITLE_CODES["5522"] = {}
		TITLE_CODES["5522"]["title"] = "COOK, SR"
		TITLE_CODES["5522"]["program"] = "PSS"
		TITLE_CODES["5522"]["unit"] = "SX"

	TITLE_CODES["5523"] = {}
		TITLE_CODES["5523"]["title"] = "COOK"
		TITLE_CODES["5523"]["program"] = "PSS"
		TITLE_CODES["5523"]["unit"] = "SX"

	TITLE_CODES["5524"] = {}
		TITLE_CODES["5524"]["title"] = "COOK, ASST"
		TITLE_CODES["5524"]["program"] = "PSS"
		TITLE_CODES["5524"]["unit"] = "SX"

	TITLE_CODES["8994"] = {}
		TITLE_CODES["8994"]["title"] = "ASSISTANT, MEDICAL, II"
		TITLE_CODES["8994"]["program"] = "PSS"
		TITLE_CODES["8994"]["unit"] = "EX"

	TITLE_CODES["5526"] = {}
		TITLE_CODES["5526"]["title"] = "COOK, SR-SUPVR"
		TITLE_CODES["5526"]["program"] = "PSS"
		TITLE_CODES["5526"]["unit"] = "99"

	TITLE_CODES["7130"] = {}
		TITLE_CODES["7130"]["title"] = "SPECIALIST, EH&S I, SUPERVISOR"
		TITLE_CODES["7130"]["program"] = "PSS"
		TITLE_CODES["7130"]["unit"] = "99"

	TITLE_CODES["9137"] = {}
		TITLE_CODES["9137"]["title"] = "NURSE, CLINICAL IV"
		TITLE_CODES["9137"]["program"] = "PSS"
		TITLE_CODES["9137"]["unit"] = "NX"

	TITLE_CODES["8988"] = {}
		TITLE_CODES["8988"]["title"] = "TECHNOLOGIST, CYTOGENETIC I"
		TITLE_CODES["8988"]["program"] = "PSS"
		TITLE_CODES["8988"]["unit"] = "EX"

	TITLE_CODES["8995"] = {}
		TITLE_CODES["8995"]["title"] = "ASSISTANT, MEDICAL, II--SUPVR"
		TITLE_CODES["8995"]["program"] = "PSS"
		TITLE_CODES["8995"]["unit"] = "99"

	TITLE_CODES["8273"] = {}
		TITLE_CODES["8273"]["title"] = "ACCELERATOR OPERATOR"
		TITLE_CODES["8273"]["program"] = "PSS"
		TITLE_CODES["8273"]["unit"] = "TX"

	TITLE_CODES["7133"] = {}
		TITLE_CODES["7133"]["title"] = "SPECIALIST, E.H.&S. I"
		TITLE_CODES["7133"]["program"] = "PSS"
		TITLE_CODES["7133"]["unit"] = "99"

	TITLE_CODES["8271"] = {}
		TITLE_CODES["8271"]["title"] = "ACCELERATOR OPERATOR, PRIN"
		TITLE_CODES["8271"]["program"] = "PSS"
		TITLE_CODES["8271"]["unit"] = "99"

	TITLE_CODES["1217"] = {}
		TITLE_CODES["1217"]["title"] = "ACT ASSOC PROFESSOR-FISCAL YR"
		TITLE_CODES["1217"]["program"] = "ACADEMIC"
		TITLE_CODES["1217"]["unit"] = "A3"

	TITLE_CODES["4962"] = {}
		TITLE_CODES["4962"]["title"] = "CODER"
		TITLE_CODES["4962"]["program"] = "PSS"
		TITLE_CODES["4962"]["unit"] = "CX"

	TITLE_CODES["3108"] = {}
		TITLE_CODES["3108"]["title"] = "VISITING ASTRONOMER"
		TITLE_CODES["3108"]["program"] = "ACADEMIC"
		TITLE_CODES["3108"]["unit"] = "99"

	TITLE_CODES["8899"] = {}
		TITLE_CODES["8899"]["title"] = "ANESTHESIA TECHNICIAN PER DIEM"
		TITLE_CODES["8899"]["program"] = "PSS"
		TITLE_CODES["8899"]["unit"] = "EX"

	TITLE_CODES["44"] = {}
		TITLE_CODES["44"]["title"] = "DEPUTY ASSOC VICE PRESIDENT"
		TITLE_CODES["44"]["program"] = "MSP"
		TITLE_CODES["44"]["unit"] = "99"

	TITLE_CODES["45"] = {}
		TITLE_CODES["45"]["title"] = "ASST VP (FUNCTIONAL AREA)"
		TITLE_CODES["45"]["program"] = "MSP"
		TITLE_CODES["45"]["unit"] = "99"

	TITLE_CODES["42"] = {}
		TITLE_CODES["42"]["title"] = "PROVOST (FUNCTIONAL AREA)"
		TITLE_CODES["42"]["program"] = "MSP"
		TITLE_CODES["42"]["unit"] = "99"

	TITLE_CODES["43"] = {}
		TITLE_CODES["43"]["title"] = "DEPUTY ASST VICE PRESIDENT"
		TITLE_CODES["43"]["program"] = "MSP"
		TITLE_CODES["43"]["unit"] = "99"

	TITLE_CODES["40"] = {}
		TITLE_CODES["40"]["title"] = "UNIVERSITY PROVOST"
		TITLE_CODES["40"]["program"] = "MSP"
		TITLE_CODES["40"]["unit"] = "99"

	TITLE_CODES["9019"] = {}
		TITLE_CODES["9019"]["title"] = "TECHNOLOGIST,RADIOLOGIC,CHIEF"
		TITLE_CODES["9019"]["program"] = "PSS"
		TITLE_CODES["9019"]["unit"] = "99"

	TITLE_CODES["1111"] = {}
		TITLE_CODES["1111"]["title"] = "____-SENATE-AY-RECALLED-VERIP"
		TITLE_CODES["1111"]["program"] = "ACADEMIC"
		TITLE_CODES["1111"]["unit"] = "A3"

	TITLE_CODES["1110"] = {}
		TITLE_CODES["1110"]["title"] = "PROFESSOR - FISCAL YR"
		TITLE_CODES["1110"]["program"] = "ACADEMIC"
		TITLE_CODES["1110"]["unit"] = "A3"

	TITLE_CODES["1113"] = {}
		TITLE_CODES["1113"]["title"] = " ---MEDCOMP-RECALLED-VERIP"
		TITLE_CODES["1113"]["program"] = "ACADEMIC"
		TITLE_CODES["1113"]["unit"] = "A3"

	TITLE_CODES["1112"] = {}
		TITLE_CODES["1112"]["title"] = " ---SENATE-FY-RECALLED-VERIP"
		TITLE_CODES["1112"]["program"] = "ACADEMIC"
		TITLE_CODES["1112"]["unit"] = "A3"

	TITLE_CODES["9219"] = {}
		TITLE_CODES["9219"]["title"] = "TECH,STERILE PROCESSING III"
		TITLE_CODES["9219"]["program"] = "PSS"
		TITLE_CODES["9219"]["unit"] = "EX"

	TITLE_CODES["1114"] = {}
		TITLE_CODES["1114"]["title"] = " ---GENCOMP-RECALLED-VERIP"
		TITLE_CODES["1114"]["program"] = "ACADEMIC"
		TITLE_CODES["1114"]["unit"] = "A3"

	TITLE_CODES["1117"] = {}
		TITLE_CODES["1117"]["title"] = "ACTING PROFESSOR - FISCAL YR"
		TITLE_CODES["1117"]["program"] = "ACADEMIC"
		TITLE_CODES["1117"]["unit"] = "A3"

	TITLE_CODES["1116"] = {}
		TITLE_CODES["1116"]["title"] = "PROFESSOR-FISCAL YR-RECALLED"
		TITLE_CODES["1116"]["program"] = "ACADEMIC"
		TITLE_CODES["1116"]["unit"] = "A3"

	TITLE_CODES["1560"] = {}
		TITLE_CODES["1560"]["title"] = "ADJUNCT PROF-GENCOMP-A"
		TITLE_CODES["1560"]["program"] = "ACADEMIC"
		TITLE_CODES["1560"]["unit"] = "99"

	TITLE_CODES["1118"] = {}
		TITLE_CODES["1118"]["title"] = "VISITING PROFESSOR - FISCAL YR"
		TITLE_CODES["1118"]["program"] = "ACADEMIC"
		TITLE_CODES["1118"]["unit"] = "99"

	TITLE_CODES["1563"] = {}
		TITLE_CODES["1563"]["title"] = "ASSISTANT PROFESSOR-FY-GENCOMP"
		TITLE_CODES["1563"]["program"] = "ACADEMIC"
		TITLE_CODES["1563"]["unit"] = "A3"

	TITLE_CODES["1564"] = {}
		TITLE_CODES["1564"]["title"] = "ACTING ASST PROFESSOR-HCOMP"
		TITLE_CODES["1564"]["program"] = "ACADEMIC"
		TITLE_CODES["1564"]["unit"] = "A3"

	TITLE_CODES["1565"] = {}
		TITLE_CODES["1565"]["title"] = "ASSOCIATE PROFESSOR-FY-GENCOMP"
		TITLE_CODES["1565"]["program"] = "ACADEMIC"
		TITLE_CODES["1565"]["unit"] = "A3"

	TITLE_CODES["1566"] = {}
		TITLE_CODES["1566"]["title"] = "ACT ASSOC PROFESSOR-FY-GENCOMP"
		TITLE_CODES["1566"]["program"] = "ACADEMIC"
		TITLE_CODES["1566"]["unit"] = "A3"

	TITLE_CODES["1567"] = {}
		TITLE_CODES["1567"]["title"] = "PROFESSOR-FY-GENCOMP"
		TITLE_CODES["1567"]["program"] = "ACADEMIC"
		TITLE_CODES["1567"]["unit"] = "A3"

	TITLE_CODES["9153"] = {}
		TITLE_CODES["9153"]["title"] = "MENTAL HEALTH THERAPIST SUPR"
		TITLE_CODES["9153"]["program"] = "PSS"
		TITLE_CODES["9153"]["unit"] = "HX"

	TITLE_CODES["1713"] = {}
		TITLE_CODES["1713"]["title"] = "VISITING ASSOCIATE PROF-HCOMP"
		TITLE_CODES["1713"]["program"] = "ACADEMIC"
		TITLE_CODES["1713"]["unit"] = "99"

	TITLE_CODES["1712"] = {}
		TITLE_CODES["1712"]["title"] = "VISITING ASSISTANT PROF-HCOMP"
		TITLE_CODES["1712"]["program"] = "ACADEMIC"
		TITLE_CODES["1712"]["unit"] = "99"

	TITLE_CODES["1782"] = {}
		TITLE_CODES["1782"]["title"] = "ACT PROFESSOR-FY-MEDCOMP"
		TITLE_CODES["1782"]["program"] = "ACADEMIC"
		TITLE_CODES["1782"]["unit"] = "A3"

	TITLE_CODES["8109"] = {}
		TITLE_CODES["8109"]["title"] = "CARPENTER, LEAD"
		TITLE_CODES["8109"]["program"] = "PSS"
		TITLE_CODES["8109"]["unit"] = "K3"

	TITLE_CODES["8487"] = {}
		TITLE_CODES["8487"]["title"] = "AUTO EQUIPMENT OPERATOR"
		TITLE_CODES["8487"]["program"] = "PSS"
		TITLE_CODES["8487"]["unit"] = "SX"

	TITLE_CODES["1711"] = {}
		TITLE_CODES["1711"]["title"] = "VISITING INSTRUCTOR-HCOMP"
		TITLE_CODES["1711"]["program"] = "ACADEMIC"
		TITLE_CODES["1711"]["unit"] = "99"

	TITLE_CODES["8004"] = {}
		TITLE_CODES["8004"]["title"] = "CYTOTECHNOLOGIST, SENIOR-SUPVR"
		TITLE_CODES["8004"]["program"] = "PSS"
		TITLE_CODES["8004"]["unit"] = "99"

	TITLE_CODES["1717"] = {}
		TITLE_CODES["1717"]["title"] = "ASSISTANT PROFESSOR-HCOMP"
		TITLE_CODES["1717"]["program"] = "ACADEMIC"
		TITLE_CODES["1717"]["unit"] = "A3"

	TITLE_CODES["8006"] = {}
		TITLE_CODES["8006"]["title"] = "PHYSICIAN ASST, SENIOR-SUPVR"
		TITLE_CODES["8006"]["program"] = "PSS"
		TITLE_CODES["8006"]["unit"] = "99"

	TITLE_CODES["8007"] = {}
		TITLE_CODES["8007"]["title"] = "PHARMACIST, STAFF I-SUPVR"
		TITLE_CODES["8007"]["program"] = "PSS"
		TITLE_CODES["8007"]["unit"] = "99"

	TITLE_CODES["8000"] = {}
		TITLE_CODES["8000"]["title"] = "SCIENTIST, CLIN LAB - SUPVR"
		TITLE_CODES["8000"]["program"] = "PSS"
		TITLE_CODES["8000"]["unit"] = "99"

	TITLE_CODES["8001"] = {}
		TITLE_CODES["8001"]["title"] = "SCIENTIST SPEC,CLIN LAB-SUPVR"
		TITLE_CODES["8001"]["program"] = "PSS"
		TITLE_CODES["8001"]["unit"] = "99"

	TITLE_CODES["8002"] = {}
		TITLE_CODES["8002"]["title"] = "SCIENTIST SPEC,CLIN LAB,SR-SUP"
		TITLE_CODES["8002"]["program"] = "PSS"
		TITLE_CODES["8002"]["unit"] = "99"

	TITLE_CODES["8003"] = {}
		TITLE_CODES["8003"]["title"] = "CYTOTECHNOLOGIST-SUPVR"
		TITLE_CODES["8003"]["program"] = "PSS"
		TITLE_CODES["8003"]["unit"] = "99"

	TITLE_CODES["1715"] = {}
		TITLE_CODES["1715"]["title"] = "INSTRUCTOR-HCOMP"
		TITLE_CODES["1715"]["program"] = "ACADEMIC"
		TITLE_CODES["1715"]["unit"] = "A3"

	TITLE_CODES["9809"] = {}
		TITLE_CODES["9809"]["title"] = "FIRE SPECIALIST I - 40 HRS"
		TITLE_CODES["9809"]["program"] = "PSS"
		TITLE_CODES["9809"]["unit"] = "FF"

	TITLE_CODES["9808"] = {}
		TITLE_CODES["9808"]["title"] = "FIRE CAPT - 40 HRS"
		TITLE_CODES["9808"]["program"] = "PSS"
		TITLE_CODES["9808"]["unit"] = "FF"

	TITLE_CODES["9807"] = {}
		TITLE_CODES["9807"]["title"] = "FIRE SPECIALIST II - 56 HRS"
		TITLE_CODES["9807"]["program"] = "PSS"
		TITLE_CODES["9807"]["unit"] = "FF"

	TITLE_CODES["9806"] = {}
		TITLE_CODES["9806"]["title"] = "FIRE SPECIALIST I - 56 HRS"
		TITLE_CODES["9806"]["program"] = "PSS"
		TITLE_CODES["9806"]["unit"] = "FF"

	TITLE_CODES["9384"] = {}
		TITLE_CODES["9384"]["title"] = "PSYCHOLOGIST I"
		TITLE_CODES["9384"]["program"] = "PSS"
		TITLE_CODES["9384"]["unit"] = "HX"

	TITLE_CODES["1714"] = {}
		TITLE_CODES["1714"]["title"] = "VISITING PROFESSOR-HCOMP"
		TITLE_CODES["1714"]["program"] = "ACADEMIC"
		TITLE_CODES["1714"]["unit"] = "99"

	TITLE_CODES["9803"] = {}
		TITLE_CODES["9803"]["title"] = "FIRE CAPTAIN"
		TITLE_CODES["9803"]["program"] = "PSS"
		TITLE_CODES["9803"]["unit"] = "TX"

	TITLE_CODES["6465"] = {}
		TITLE_CODES["6465"]["title"] = "ARTS & LECTURES MGR SUPERVISOR"
		TITLE_CODES["6465"]["program"] = "PSS"
		TITLE_CODES["6465"]["unit"] = "99"

	TITLE_CODES["6466"] = {}
		TITLE_CODES["6466"]["title"] = "ARTS AND LECTURES MANAGER"
		TITLE_CODES["6466"]["program"] = "PSS"
		TITLE_CODES["6466"]["unit"] = "99"

	TITLE_CODES["4725"] = {}
		TITLE_CODES["4725"]["title"] = "____ASSISTANT IV"
		TITLE_CODES["4725"]["program"] = "PSS"
		TITLE_CODES["4725"]["unit"] = "CX"

	TITLE_CODES["8483"] = {}
		TITLE_CODES["8483"]["title"] = "DRIVER"
		TITLE_CODES["8483"]["program"] = "PSS"
		TITLE_CODES["8483"]["unit"] = "SX"

	TITLE_CODES["477"] = {}
		TITLE_CODES["477"]["title"] = "POLICE LIEUTENANT - MSP"
		TITLE_CODES["477"]["program"] = "MSP"
		TITLE_CODES["477"]["unit"] = "99"

	TITLE_CODES["8486"] = {}
		TITLE_CODES["8486"]["title"] = "AUTO EQUIPMENT OPERATOR, SR"
		TITLE_CODES["8486"]["program"] = "PSS"
		TITLE_CODES["8486"]["unit"] = "SX"

	TITLE_CODES["4724"] = {}
		TITLE_CODES["4724"]["title"] = "_____ASSISTANT I"
		TITLE_CODES["4724"]["program"] = "PSS"
		TITLE_CODES["4724"]["unit"] = "CX"

	TITLE_CODES["7244"] = {}
		TITLE_CODES["7244"]["title"] = "ANALYST, ADMINISTRATIVE, ASST"
		TITLE_CODES["7244"]["program"] = "PSS"
		TITLE_CODES["7244"]["unit"] = "99"

	TITLE_CODES["8489"] = {}
		TITLE_CODES["8489"]["title"] = "AUTO EQUIP OPERATOR,PRIN-SUPVR"
		TITLE_CODES["8489"]["program"] = "PSS"
		TITLE_CODES["8489"]["unit"] = "99"

	TITLE_CODES["478"] = {}
		TITLE_CODES["478"]["title"] = "CHIEF OF POLICE"
		TITLE_CODES["478"]["program"] = "MSP"
		TITLE_CODES["478"]["unit"] = "99"

	TITLE_CODES["479"] = {}
		TITLE_CODES["479"]["title"] = "ASST CHIEF POLICE/POLICE CAPTN"
		TITLE_CODES["479"]["program"] = "MSP"
		TITLE_CODES["479"]["unit"] = "99"

	TITLE_CODES["8266"] = {}
		TITLE_CODES["8266"]["title"] = "LOCKSMITH"
		TITLE_CODES["8266"]["program"] = "PSS"
		TITLE_CODES["8266"]["unit"] = "K3"

	TITLE_CODES["4727"] = {}
		TITLE_CODES["4727"]["title"] = "_____ASSISTANT II-SUPVR"
		TITLE_CODES["4727"]["program"] = "PSS"
		TITLE_CODES["4727"]["unit"] = "99"

	TITLE_CODES["8269"] = {}
		TITLE_CODES["8269"]["title"] = "CABINET MAKER"
		TITLE_CODES["8269"]["program"] = "PSS"
		TITLE_CODES["8269"]["unit"] = "K3"

end
