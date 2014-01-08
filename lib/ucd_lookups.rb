module UcdLookups
  MAJORS = {}
  DEPT_CODES = {}
  TITLE_CODES = {}
  
  #MANUAL_INCLUDES = ['aeguyer','millerlm','djmoglen','mebalvin','mckinney','ssantam','tmheath','rnanakul','olichney','sukkim','jpokorny','bgrunewa','rabronst','kbaynes','szneena','pcmundy','wjarrold','julieluu','steichho','chuff','cmachado','alamsyah','schuang','clare186','ladyd252','aheusser','pkubitz','kshap','bbrelles','blmiss','pjdegenn','cdaniels','jyiwang','anschnei','eaisham','ralatif','cwbishop','fddiaz','jinchen','ajkou','sphan127','ndelie','weidner']
  
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

	DEPT_CODES["040002"] = {}
		DEPT_CODES["040002"]["name"] = "L&S DEANS - U/G ED & ADVISING"
		DEPT_CODES["040002"]["company"] = "040008"
		DEPT_CODES["040002"]["manager"] = "jsmcclai"

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
    TITLE_CODES["4726"]["title"] = "BLANK AST 3 SUPV"
    TITLE_CODES["4726"]["program"] = "PSS"
    TITLE_CODES["4726"]["unit"] = "99"

    TITLE_CODES["4721"] = {}
    TITLE_CODES["4721"]["title"] = "PATIENT RCDS ABSTRACTOR 3 SUPV"
    TITLE_CODES["4721"]["program"] = "PSS"
    TITLE_CODES["4721"]["unit"] = "99"

    TITLE_CODES["7611"] = {}
    TITLE_CODES["7611"]["title"] = "ACCOUNTANT 4 SUPV"
    TITLE_CODES["7611"]["program"] = "PSS"
    TITLE_CODES["7611"]["unit"] = "99"

    TITLE_CODES["8148"] = {}
    TITLE_CODES["8148"]["title"] = "FARM MAINT WORKER SR"
    TITLE_CODES["8148"]["program"] = "PSS"
    TITLE_CODES["8148"]["unit"] = "SX"

    TITLE_CODES["6306"] = {}
    TITLE_CODES["6306"]["title"] = "PUBL INFO REPR SR SUPV"
    TITLE_CODES["6306"]["program"] = "PSS"
    TITLE_CODES["6306"]["unit"] = "99"

    TITLE_CODES["8304"] = {}
    TITLE_CODES["8304"]["title"] = "ELECTR TCHN TRAINEE"
    TITLE_CODES["8304"]["program"] = "PSS"
    TITLE_CODES["8304"]["unit"] = "TX"

    TITLE_CODES["4022"] = {}
    TITLE_CODES["4022"]["title"] = "REFEREE UMPIRE"
    TITLE_CODES["4022"]["program"] = "PSS"
    TITLE_CODES["4022"]["unit"] = "99"

    TITLE_CODES["8302"] = {}
    TITLE_CODES["8302"]["title"] = "ELECTR TCHN SR"
    TITLE_CODES["8302"]["program"] = "PSS"
    TITLE_CODES["8302"]["unit"] = "TX"

    TITLE_CODES["8301"] = {}
    TITLE_CODES["8301"]["title"] = "ELECTR TCHN PRN"
    TITLE_CODES["8301"]["program"] = "PSS"
    TITLE_CODES["8301"]["unit"] = "TX"

    TITLE_CODES["4021"] = {}
    TITLE_CODES["4021"]["title"] = "SPORTS AST"
    TITLE_CODES["4021"]["program"] = "PSS"
    TITLE_CODES["4021"]["unit"] = "SX"

    TITLE_CODES["8267"] = {}
    TITLE_CODES["8267"]["title"] = "LOCKSMITH APPR"
    TITLE_CODES["8267"]["program"] = "PSS"
    TITLE_CODES["8267"]["unit"] = "K3"

    TITLE_CODES["4722"] = {}
    TITLE_CODES["4722"]["title"] = "BLANK AST 3"
    TITLE_CODES["4722"]["program"] = "PSS"
    TITLE_CODES["4722"]["unit"] = "CX"

    TITLE_CODES["6952"] = {}
    TITLE_CODES["6952"]["title"] = "ARCHITECT SR SUPV"
    TITLE_CODES["6952"]["program"] = "PSS"
    TITLE_CODES["6952"]["unit"] = "99"

    TITLE_CODES["9073"] = {}
    TITLE_CODES["9073"]["title"] = "RADLG EQUIP SPEC"
    TITLE_CODES["9073"]["program"] = "PSS"
    TITLE_CODES["9073"]["unit"] = "EX"

    TITLE_CODES["5821"] = {}
    TITLE_CODES["5821"]["title"] = "LINEN SVC HEAD SR"
    TITLE_CODES["5821"]["program"] = "PSS"
    TITLE_CODES["5821"]["unit"] = "SX"

    TITLE_CODES["5822"] = {}
    TITLE_CODES["5822"]["title"] = "LINEN SVC HEAD WORKER"
    TITLE_CODES["5822"]["program"] = "PSS"
    TITLE_CODES["5822"]["unit"] = "SX"

    TITLE_CODES["8093"] = {}
    TITLE_CODES["8093"]["title"] = "COGEN OPR APPR"
    TITLE_CODES["8093"]["program"] = "PSS"
    TITLE_CODES["8093"]["unit"] = "K3"

    TITLE_CODES["5824"] = {}
    TITLE_CODES["5824"]["title"] = "LINEN SVC WORKER HEAD SR SUPV"
    TITLE_CODES["5824"]["program"] = "PSS"
    TITLE_CODES["5824"]["unit"] = "99"

    TITLE_CODES["8090"] = {}
    TITLE_CODES["8090"]["title"] = "IRRIGATION SPEC"
    TITLE_CODES["8090"]["program"] = "PSS"
    TITLE_CODES["8090"]["unit"] = "SX"

    TITLE_CODES["3720"] = {}
    TITLE_CODES["3720"]["title"] = "ASST FACULTY CONSULTANT IN----"
    TITLE_CODES["3720"]["program"] = "ACADEMIC"
    TITLE_CODES["3720"]["unit"] = "99"

    TITLE_CODES["9320"] = {}
    TITLE_CODES["9320"]["title"] = "CMTY HEALTH PRG CHF"
    TITLE_CODES["9320"]["program"] = "PSS"
    TITLE_CODES["9320"]["unit"] = "99"

    TITLE_CODES["8261"] = {}
    TITLE_CODES["8261"]["title"] = "HIGH VOLT ELECTRN APPR"
    TITLE_CODES["8261"]["program"] = "PSS"
    TITLE_CODES["8261"]["unit"] = "K3"

    TITLE_CODES["7512"] = {}
    TITLE_CODES["7512"]["title"] = "MGT SVC OFCR 1"
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
    TITLE_CODES["8885"]["title"] = "CLIN SPEC NEX"
    TITLE_CODES["8885"]["program"] = "PSS"
    TITLE_CODES["8885"]["unit"] = "99"

    TITLE_CODES["3995"] = {}
    TITLE_CODES["3995"]["title"] = "EAP-TEMP FACULTY HOUSING ALLOW"
    TITLE_CODES["3995"]["program"] = "ACADEMIC"
    TITLE_CODES["3995"]["unit"] = "87"

    TITLE_CODES["5651"] = {}
    TITLE_CODES["5651"]["title"] = "FOOD SVC WORKER SR"
    TITLE_CODES["5651"]["program"] = "PSS"
    TITLE_CODES["5651"]["unit"] = "SX"

    TITLE_CODES["3993"] = {}
    TITLE_CODES["3993"]["title"] = "FACULTY RECRUITMENT ALLOW"
    TITLE_CODES["3993"]["program"] = "ACADEMIC"
    TITLE_CODES["3993"]["unit"] = "87"

    TITLE_CODES["3991"] = {}
    TITLE_CODES["3991"]["title"] = "ADDL COMP-VETERANS' ADMIN SRVC"
    TITLE_CODES["3991"]["program"] = "ACADEMIC"
    TITLE_CODES["3991"]["unit"] = "87"

    TITLE_CODES["3990"] = {}
    TITLE_CODES["3990"]["title"] = "ADDL COMP-HGH&OLIVE VIEW MCS"
    TITLE_CODES["3990"]["program"] = "ACADEMIC"
    TITLE_CODES["3990"]["unit"] = "87"

    TITLE_CODES["8184"] = {}
    TITLE_CODES["8184"]["title"] = "HVAC MECH LD"
    TITLE_CODES["8184"]["program"] = "PSS"
    TITLE_CODES["8184"]["unit"] = "K3"

    TITLE_CODES["3005"] = {}
    TITLE_CODES["3005"]["title"] = "_____ IN THE A.E.S.-F.E.R.P."
    TITLE_CODES["3005"]["program"] = "ACADEMIC"
    TITLE_CODES["3005"]["unit"] = "FX"

    TITLE_CODES["6099"] = {}
    TITLE_CODES["6099"]["title"] = "ARTIST PRN SUPV"
    TITLE_CODES["6099"]["program"] = "PSS"
    TITLE_CODES["6099"]["unit"] = "99"

    TITLE_CODES["7624"] = {}
    TITLE_CODES["7624"]["title"] = "AUDITOR 2 EX"
    TITLE_CODES["7624"]["program"] = "PSS"
    TITLE_CODES["7624"]["unit"] = "99"

    TITLE_CODES["9612"] = {}
    TITLE_CODES["9612"]["title"] = "SRA 2"
    TITLE_CODES["9612"]["program"] = "PSS"
    TITLE_CODES["9612"]["unit"] = "RX"

    TITLE_CODES["4732"] = {}
    TITLE_CODES["4732"]["title"] = "HEALTH INFO CODER 4"
    TITLE_CODES["4732"]["program"] = "PSS"
    TITLE_CODES["4732"]["unit"] = "EX"

    TITLE_CODES["4733"] = {}
    TITLE_CODES["4733"]["title"] = "HEALTH INFO CODER 3"
    TITLE_CODES["4733"]["program"] = "PSS"
    TITLE_CODES["4733"]["unit"] = "EX"

    TITLE_CODES["4730"] = {}
    TITLE_CODES["4730"]["title"] = "BLANK AST 2 PD"
    TITLE_CODES["4730"]["program"] = "PSS"
    TITLE_CODES["4730"]["unit"] = "CX"

    TITLE_CODES["4731"] = {}
    TITLE_CODES["4731"]["title"] = "BLANK AST 3 PD"
    TITLE_CODES["4731"]["program"] = "PSS"
    TITLE_CODES["4731"]["unit"] = "CX"

    TITLE_CODES["8307"] = {}
    TITLE_CODES["8307"]["title"] = "MED CTR BLDG MAINT WORKER"
    TITLE_CODES["8307"]["program"] = "PSS"
    TITLE_CODES["8307"]["unit"] = "SX"

    TITLE_CODES["1974"] = {}
    TITLE_CODES["1974"]["title"] = "ACT ASSOC PROF-AY-B/E/E"
    TITLE_CODES["1974"]["program"] = "ACADEMIC"
    TITLE_CODES["1974"]["unit"] = "A3"

    TITLE_CODES["2312"] = {}
    TITLE_CODES["2312"]["title"] = "TEACHG ASST-GSHIP/NON REP"
    TITLE_CODES["2312"]["program"] = "ACADEMIC"
    TITLE_CODES["2312"]["unit"] = "99"

    TITLE_CODES["2313"] = {}
    TITLE_CODES["2313"]["title"] = "TEACHG ASST-NON GSHIP/NON REP"
    TITLE_CODES["2313"]["program"] = "ACADEMIC"
    TITLE_CODES["2313"]["unit"] = "99"

    TITLE_CODES["2310"] = {}
    TITLE_CODES["2310"]["title"] = "TEACHG ASST-GSHIP"
    TITLE_CODES["2310"]["program"] = "ACADEMIC"
    TITLE_CODES["2310"]["unit"] = "BX"

    TITLE_CODES["2311"] = {}
    TITLE_CODES["2311"]["title"] = "TEACHG ASST-NON GSHIP"
    TITLE_CODES["2311"]["program"] = "ACADEMIC"
    TITLE_CODES["2311"]["unit"] = "BX"

    TITLE_CODES["8303"] = {}
    TITLE_CODES["8303"]["title"] = "ELECTR TCHN"
    TITLE_CODES["8303"]["program"] = "PSS"
    TITLE_CODES["8303"]["unit"] = "TX"

    TITLE_CODES["8957"] = {}
    TITLE_CODES["8957"]["title"] = "CLIN LAB SCI APPR"
    TITLE_CODES["8957"]["program"] = "PSS"
    TITLE_CODES["8957"]["unit"] = "HX"

    TITLE_CODES["0199"] = {}
    TITLE_CODES["0199"]["title"] = "EXEC AND SEARLES SPC LEAVE SAL"
    TITLE_CODES["0199"]["program"] = "MSP"
    TITLE_CODES["0199"]["unit"] = "99"

    TITLE_CODES["0198"] = {}
    TITLE_CODES["0198"]["title"] = "EXEC TITLE TEMP SAL SUPP"
    TITLE_CODES["0198"]["program"] = "MSP"
    TITLE_CODES["0198"]["unit"] = "99"

    TITLE_CODES["0195"] = {}
    TITLE_CODES["0195"]["title"] = "EXEC TITLE SUMMER DIFF"
    TITLE_CODES["0195"]["program"] = "MSP"
    TITLE_CODES["0195"]["unit"] = "99"

    TITLE_CODES["0197"] = {}
    TITLE_CODES["0197"]["title"] = "EXEC CONTRIB SPC LEAVE SAL"
    TITLE_CODES["0197"]["program"] = "MSP"
    TITLE_CODES["0197"]["unit"] = "99"

    TITLE_CODES["0196"] = {}
    TITLE_CODES["0196"]["title"] = "EXEC TITLE ADMIN STIPEND"
    TITLE_CODES["0196"]["program"] = "MSP"
    TITLE_CODES["0196"]["unit"] = "99"

    TITLE_CODES["7678"] = {}
    TITLE_CODES["7678"]["title"] = "PUBLICATIONS MGR SR"
    TITLE_CODES["7678"]["program"] = "PSS"
    TITLE_CODES["7678"]["unit"] = "99"

    TITLE_CODES["8263"] = {}
    TITLE_CODES["8263"]["title"] = "UPHOLSTERER"
    TITLE_CODES["8263"]["program"] = "PSS"
    TITLE_CODES["8263"]["unit"] = "TX"

    TITLE_CODES["8880"] = {}
    TITLE_CODES["8880"]["title"] = "CLIN SPEC EX"
    TITLE_CODES["8880"]["program"] = "PSS"
    TITLE_CODES["8880"]["unit"] = "99"

    TITLE_CODES["3234"] = {}
    TITLE_CODES["3234"]["title"] = "ASSOC FLD PROG SUPV"
    TITLE_CODES["3234"]["program"] = "ACADEMIC"
    TITLE_CODES["3234"]["unit"] = "FX"

    TITLE_CODES["6344"] = {}
    TITLE_CODES["6344"]["title"] = "STAGE HELPER"
    TITLE_CODES["6344"]["program"] = "PSS"
    TITLE_CODES["6344"]["unit"] = "TX"

    TITLE_CODES["4659"] = {}
    TITLE_CODES["4659"]["title"] = "PATIENT BILLER SUPV 5"
    TITLE_CODES["4659"]["program"] = "PSS"
    TITLE_CODES["4659"]["unit"] = "99"

    TITLE_CODES["8898"] = {}
    TITLE_CODES["8898"]["title"] = "ANESTHESIA TCHN 2"
    TITLE_CODES["8898"]["program"] = "PSS"
    TITLE_CODES["8898"]["unit"] = "EX"

    TITLE_CODES["1454"] = {}
    TITLE_CODES["1454"]["title"] = "ASSOC PROF OF CLIN-HCOMP"
    TITLE_CODES["1454"]["program"] = "ACADEMIC"
    TITLE_CODES["1454"]["unit"] = "A3"

    TITLE_CODES["1455"] = {}
    TITLE_CODES["1455"]["title"] = "ASST PROF OF CLIN-HCOMP"
    TITLE_CODES["1455"]["program"] = "ACADEMIC"
    TITLE_CODES["1455"]["unit"] = "A3"

    TITLE_CODES["8209"] = {}
    TITLE_CODES["8209"]["title"] = "REFRIGERATION MECH APPR"
    TITLE_CODES["8209"]["program"] = "PSS"
    TITLE_CODES["8209"]["unit"] = "K3"

    TITLE_CODES["1456"] = {}
    TITLE_CODES["1456"]["title"] = "PROF OF CLIN___-GENCOMP-B"
    TITLE_CODES["1456"]["program"] = "ACADEMIC"
    TITLE_CODES["1456"]["unit"] = "A3"

    TITLE_CODES["8881"] = {}
    TITLE_CODES["8881"]["title"] = "CLIN SPEC SUPV EX"
    TITLE_CODES["8881"]["program"] = "PSS"
    TITLE_CODES["8881"]["unit"] = "99"

    TITLE_CODES["1457"] = {}
    TITLE_CODES["1457"]["title"] = "ASO PROF OF CLIN___-GENCOMP-B"
    TITLE_CODES["1457"]["program"] = "ACADEMIC"
    TITLE_CODES["1457"]["unit"] = "A3"

    TITLE_CODES["8207"] = {}
    TITLE_CODES["8207"]["title"] = "CABINET MAKER APPR"
    TITLE_CODES["8207"]["program"] = "PSS"
    TITLE_CODES["8207"]["unit"] = "K3"

    TITLE_CODES["1450"] = {}
    TITLE_CODES["1450"]["title"] = "PROF OF CLIN-FY"
    TITLE_CODES["1450"]["program"] = "ACADEMIC"
    TITLE_CODES["1450"]["unit"] = "A3"

    TITLE_CODES["2260"] = {}
    TITLE_CODES["2260"]["title"] = "FLD WK CONSULT-AY"
    TITLE_CODES["2260"]["program"] = "ACADEMIC"
    TITLE_CODES["2260"]["unit"] = "IX"

    TITLE_CODES["2261"] = {}
    TITLE_CODES["2261"]["title"] = "FLD WK CONSULT-AY-CONTINUING"
    TITLE_CODES["2261"]["program"] = "ACADEMIC"
    TITLE_CODES["2261"]["unit"] = "IX"

    TITLE_CODES["2266"] = {}
    TITLE_CODES["2266"]["title"] = "FLD WK CONSULT-FY-CONTINUING"
    TITLE_CODES["2266"]["program"] = "ACADEMIC"
    TITLE_CODES["2266"]["unit"] = "IX"

    TITLE_CODES["1451"] = {}
    TITLE_CODES["1451"]["title"] = "ASSOC PROF OF CLIN-FY"
    TITLE_CODES["1451"]["program"] = "ACADEMIC"
    TITLE_CODES["1451"]["unit"] = "A3"

    TITLE_CODES["3580"] = {}
    TITLE_CODES["3580"]["title"] = "COURSE AUTHOR-UNEX"
    TITLE_CODES["3580"]["program"] = "ACADEMIC"
    TITLE_CODES["3580"]["unit"] = "99"

    TITLE_CODES["9154"] = {}
    TITLE_CODES["9154"]["title"] = "BIOMED EQUIP TCHN 4"
    TITLE_CODES["9154"]["program"] = "PSS"
    TITLE_CODES["9154"]["unit"] = "EX"

    TITLE_CODES["9157"] = {}
    TITLE_CODES["9157"]["title"] = "BIOMED EQUIP TCHN 1"
    TITLE_CODES["9157"]["program"] = "PSS"
    TITLE_CODES["9157"]["unit"] = "EX"

    TITLE_CODES["9156"] = {}
    TITLE_CODES["9156"]["title"] = "BIOMED EQUIP TCHN 2"
    TITLE_CODES["9156"]["program"] = "PSS"
    TITLE_CODES["9156"]["unit"] = "EX"

    TITLE_CODES["9151"] = {}
    TITLE_CODES["9151"]["title"] = "MENTAL HEALTH THER 1"
    TITLE_CODES["9151"]["program"] = "PSS"
    TITLE_CODES["9151"]["unit"] = "HX"

    TITLE_CODES["1452"] = {}
    TITLE_CODES["1452"]["title"] = "ASST PROF OF CLIN-FY"
    TITLE_CODES["1452"]["program"] = "ACADEMIC"
    TITLE_CODES["1452"]["unit"] = "A3"

    TITLE_CODES["3001"] = {}
    TITLE_CODES["3001"]["title"] = "AGRON AES-SFT-VM"
    TITLE_CODES["3001"]["program"] = "ACADEMIC"
    TITLE_CODES["3001"]["unit"] = "FX"

    TITLE_CODES["9152"] = {}
    TITLE_CODES["9152"]["title"] = "MENTAL HEALTH THER 2"
    TITLE_CODES["9152"]["program"] = "PSS"
    TITLE_CODES["9152"]["unit"] = "HX"

    TITLE_CODES["9256"] = {}
    TITLE_CODES["9256"]["title"] = "HOSP BLANK AST 2 SUPV"
    TITLE_CODES["9256"]["program"] = "PSS"
    TITLE_CODES["9256"]["unit"] = "99"

    TITLE_CODES["9257"] = {}
    TITLE_CODES["9257"]["title"] = "HOSP UNIT SVC CRD 3"
    TITLE_CODES["9257"]["program"] = "PSS"
    TITLE_CODES["9257"]["unit"] = "EX"

    TITLE_CODES["9526"] = {}
    TITLE_CODES["9526"]["title"] = "ANIMAL TCHN AST"
    TITLE_CODES["9526"]["program"] = "PSS"
    TITLE_CODES["9526"]["unit"] = "SX"

    TITLE_CODES["1453"] = {}
    TITLE_CODES["1453"]["title"] = "PROF OF CLIN-HCOMP"
    TITLE_CODES["1453"]["program"] = "ACADEMIC"
    TITLE_CODES["1453"]["unit"] = "A3"

    TITLE_CODES["9252"] = {}
    TITLE_CODES["9252"]["title"] = "HOSP BLANK AST 2"
    TITLE_CODES["9252"]["program"] = "PSS"
    TITLE_CODES["9252"]["unit"] = "EX"

    TITLE_CODES["9253"] = {}
    TITLE_CODES["9253"]["title"] = "HOSP BLANK AST 1"
    TITLE_CODES["9253"]["program"] = "PSS"
    TITLE_CODES["9253"]["unit"] = "EX"

    TITLE_CODES["9250"] = {}
    TITLE_CODES["9250"]["title"] = "PHARMACIST 2 PD"
    TITLE_CODES["9250"]["program"] = "PSS"
    TITLE_CODES["9250"]["unit"] = "HX"

    TITLE_CODES["9251"] = {}
    TITLE_CODES["9251"]["title"] = "HOSP BLANK AST 3"
    TITLE_CODES["9251"]["program"] = "PSS"
    TITLE_CODES["9251"]["unit"] = "EX"

    TITLE_CODES["8075"] = {}
    TITLE_CODES["8075"]["title"] = "LABORER LD"
    TITLE_CODES["8075"]["program"] = "PSS"
    TITLE_CODES["8075"]["unit"] = "SX"

    TITLE_CODES["0108"] = {}
    TITLE_CODES["0108"]["title"] = "EXEC DEAN FUNC AREA"
    TITLE_CODES["0108"]["program"] = "MSP"
    TITLE_CODES["0108"]["unit"] = "99"

    TITLE_CODES["0109"] = {}
    TITLE_CODES["0109"]["title"] = "FUNC AREA EXEC AND DEAN"
    TITLE_CODES["0109"]["program"] = "MSP"
    TITLE_CODES["0109"]["unit"] = "99"

    TITLE_CODES["0102"] = {}
    TITLE_CODES["0102"]["title"] = "EXEC OFCR FUNC AREA"
    TITLE_CODES["0102"]["program"] = "MSP"
    TITLE_CODES["0102"]["unit"] = "99"

    TITLE_CODES["0103"] = {}
    TITLE_CODES["0103"]["title"] = "FUNC AREA EXEC AND OFCR"
    TITLE_CODES["0103"]["program"] = "MSP"
    TITLE_CODES["0103"]["unit"] = "99"

    TITLE_CODES["0100"] = {}
    TITLE_CODES["0100"]["title"] = "MGT PRG UNTTL"
    TITLE_CODES["0100"]["program"] = "MSP"
    TITLE_CODES["0100"]["unit"] = "99"

    TITLE_CODES["0101"] = {}
    TITLE_CODES["0101"]["title"] = "FUNC AREA EXEC MGR"
    TITLE_CODES["0101"]["program"] = "MSP"
    TITLE_CODES["0101"]["unit"] = "99"

    TITLE_CODES["0106"] = {}
    TITLE_CODES["0106"]["title"] = "EXEC CRD FUNC AREA"
    TITLE_CODES["0106"]["program"] = "MSP"
    TITLE_CODES["0106"]["unit"] = "99"

    TITLE_CODES["0107"] = {}
    TITLE_CODES["0107"]["title"] = "FUNC AREA EXEC CRD"
    TITLE_CODES["0107"]["program"] = "MSP"
    TITLE_CODES["0107"]["unit"] = "99"

    TITLE_CODES["0104"] = {}
    TITLE_CODES["0104"]["title"] = "EXEC ADM FUNC AREA"
    TITLE_CODES["0104"]["program"] = "MSP"
    TITLE_CODES["0104"]["unit"] = "99"

    TITLE_CODES["0105"] = {}
    TITLE_CODES["0105"]["title"] = "FUNC AREA EXEC ADM"
    TITLE_CODES["0105"]["program"] = "MSP"
    TITLE_CODES["0105"]["unit"] = "99"

    TITLE_CODES["4813"] = {}
    TITLE_CODES["4813"]["title"] = "COMPUTER OPR"
    TITLE_CODES["4813"]["program"] = "PSS"
    TITLE_CODES["4813"]["unit"] = "TX"

    TITLE_CODES["4620"] = {}
    TITLE_CODES["4620"]["title"] = "COLLECTIONS MGR"
    TITLE_CODES["4620"]["program"] = "PSS"
    TITLE_CODES["4620"]["unit"] = "99"

    TITLE_CODES["0900"] = {}
    TITLE_CODES["0900"]["title"] = "DIRECTOR"
    TITLE_CODES["0900"]["program"] = "ACADEMIC"
    TITLE_CODES["0900"]["unit"] = "99"

    TITLE_CODES["4810"] = {}
    TITLE_CODES["4810"]["title"] = "COMPUTER OPS SUPV SR"
    TITLE_CODES["4810"]["program"] = "PSS"
    TITLE_CODES["4810"]["unit"] = "99"

    TITLE_CODES["3000"] = {}
    TITLE_CODES["3000"]["title"] = "AGRON AES"
    TITLE_CODES["3000"]["program"] = "ACADEMIC"
    TITLE_CODES["3000"]["unit"] = "FX"

    TITLE_CODES["0907"] = {}
    TITLE_CODES["0907"]["title"] = "ACT/INTERIM DIRECTOR"
    TITLE_CODES["0907"]["program"] = "ACADEMIC"
    TITLE_CODES["0907"]["unit"] = "99"

    TITLE_CODES["2040"] = {}
    TITLE_CODES["2040"]["title"] = "HS ASST CLIN PROF-AY"
    TITLE_CODES["2040"]["program"] = "ACADEMIC"
    TITLE_CODES["2040"]["unit"] = "99"

    TITLE_CODES["2041"] = {}
    TITLE_CODES["2041"]["title"] = "ASST CLIN PROF-DENT-50%/+ AY"
    TITLE_CODES["2041"]["program"] = "ACADEMIC"
    TITLE_CODES["2041"]["unit"] = "99"

    TITLE_CODES["4422"] = {}
    TITLE_CODES["4422"]["title"] = "CNSLR 1"
    TITLE_CODES["4422"]["program"] = "PSS"
    TITLE_CODES["4422"]["unit"] = "99"

    TITLE_CODES["1511"] = {}
    TITLE_CODES["1511"]["title"] = "ASSOC IN __- FY-GSHIP"
    TITLE_CODES["1511"]["program"] = "ACADEMIC"
    TITLE_CODES["1511"]["unit"] = "BX"

    TITLE_CODES["4420"] = {}
    TITLE_CODES["4420"]["title"] = "CNSLR SUPV"
    TITLE_CODES["4420"]["program"] = "PSS"
    TITLE_CODES["4420"]["unit"] = "99"

    TITLE_CODES["4421"] = {}
    TITLE_CODES["4421"]["title"] = "CNSLR 2"
    TITLE_CODES["4421"]["program"] = "PSS"
    TITLE_CODES["4421"]["unit"] = "99"

    TITLE_CODES["9499"] = {}
    TITLE_CODES["9499"]["title"] = "OCCUPATIONAL THER 1"
    TITLE_CODES["9499"]["program"] = "PSS"
    TITLE_CODES["9499"]["unit"] = "HX"

    TITLE_CODES["9285"] = {}
    TITLE_CODES["9285"]["title"] = "GENETIC CNSLR 3"
    TITLE_CODES["9285"]["program"] = "PSS"
    TITLE_CODES["9285"]["unit"] = "HX"

    TITLE_CODES["9238"] = {}
    TITLE_CODES["9238"]["title"] = "PHARMACIST SUPV"
    TITLE_CODES["9238"]["program"] = "PSS"
    TITLE_CODES["9238"]["unit"] = "99"

    TITLE_CODES["9284"] = {}
    TITLE_CODES["9284"]["title"] = "GENETIC CNSLR 3 SUPV"
    TITLE_CODES["9284"]["program"] = "PSS"
    TITLE_CODES["9284"]["unit"] = "99"

    TITLE_CODES["4952"] = {}
    TITLE_CODES["4952"]["title"] = "WORD PROCESSING SPEC SR"
    TITLE_CODES["4952"]["program"] = "PSS"
    TITLE_CODES["4952"]["unit"] = "CX"

    TITLE_CODES["4953"] = {}
    TITLE_CODES["4953"]["title"] = "WORD PROCESSING SPEC"
    TITLE_CODES["4953"]["program"] = "PSS"
    TITLE_CODES["4953"]["unit"] = "CX"

    TITLE_CODES["4950"] = {}
    TITLE_CODES["4950"]["title"] = "WORD PROCESSING SUPV"
    TITLE_CODES["4950"]["program"] = "PSS"
    TITLE_CODES["4950"]["unit"] = "99"

    TITLE_CODES["1512"] = {}
    TITLE_CODES["1512"]["title"] = "ASSOC IN __-FY-NON-GSHIP"
    TITLE_CODES["1512"]["program"] = "ACADEMIC"
    TITLE_CODES["1512"]["unit"] = "BX"

    TITLE_CODES["2160"] = {}
    TITLE_CODES["2160"]["title"] = "JR SUPRVSR OF PHYS ED-ACAD YR"
    TITLE_CODES["2160"]["program"] = "ACADEMIC"
    TITLE_CODES["2160"]["unit"] = "99"

    TITLE_CODES["9286"] = {}
    TITLE_CODES["9286"]["title"] = "GENETIC CNSLR 2 SUPV"
    TITLE_CODES["9286"]["program"] = "PSS"
    TITLE_CODES["9286"]["unit"] = "99"

    TITLE_CODES["9341"] = {}
    TITLE_CODES["9341"]["title"] = "SOCIAL WORK ASC"
    TITLE_CODES["9341"]["program"] = "PSS"
    TITLE_CODES["9341"]["unit"] = "HX"

    TITLE_CODES["9281"] = {}
    TITLE_CODES["9281"]["title"] = "PHARMACY TCHN 3"
    TITLE_CODES["9281"]["program"] = "PSS"
    TITLE_CODES["9281"]["unit"] = "EX"

    TITLE_CODES["9342"] = {}
    TITLE_CODES["9342"]["title"] = "SOCIAL WORK ASC AST"
    TITLE_CODES["9342"]["program"] = "PSS"
    TITLE_CODES["9342"]["unit"] = "HX"

    TITLE_CODES["8919"] = {}
    TITLE_CODES["8919"]["title"] = "EMERGENCY TRAUMA TCHN SR"
    TITLE_CODES["8919"]["program"] = "PSS"
    TITLE_CODES["8919"]["unit"] = "EX"

    TITLE_CODES["9328"] = {}
    TITLE_CODES["9328"]["title"] = "CLIN RSCH CRD SUPV"
    TITLE_CODES["9328"]["program"] = "PSS"
    TITLE_CODES["9328"]["unit"] = "99"

    TITLE_CODES["5116"] = {}
    TITLE_CODES["5116"]["title"] = "CUSTODIAN SR"
    TITLE_CODES["5116"]["program"] = "PSS"
    TITLE_CODES["5116"]["unit"] = "SX"

    TITLE_CODES["3298"] = {}
    TITLE_CODES["3298"]["title"] = "RES ASSOC(WOS)"
    TITLE_CODES["3298"]["program"] = "ACADEMIC"
    TITLE_CODES["3298"]["unit"] = "99"

    TITLE_CODES["1908"] = {}
    TITLE_CODES["1908"]["title"] = "ASST ADJ PROF-SFT-VM"
    TITLE_CODES["1908"]["program"] = "ACADEMIC"
    TITLE_CODES["1908"]["unit"] = "99"

    TITLE_CODES["1909"] = {}
    TITLE_CODES["1909"]["title"] = "ASSOC ADJ PROF-SFT-VM"
    TITLE_CODES["1909"]["program"] = "ACADEMIC"
    TITLE_CODES["1909"]["unit"] = "99"

    TITLE_CODES["1906"] = {}
    TITLE_CODES["1906"]["title"] = "PROF IN RES-SFT-VM"
    TITLE_CODES["1906"]["program"] = "ACADEMIC"
    TITLE_CODES["1906"]["unit"] = "A3"

    TITLE_CODES["1907"] = {}
    TITLE_CODES["1907"]["title"] = "ADJUNCT INSTRUCTOR-SFT-VM"
    TITLE_CODES["1907"]["program"] = "ACADEMIC"
    TITLE_CODES["1907"]["unit"] = "99"

    TITLE_CODES["1904"] = {}
    TITLE_CODES["1904"]["title"] = "ASST PROF IN RES-SFT-VM"
    TITLE_CODES["1904"]["program"] = "ACADEMIC"
    TITLE_CODES["1904"]["unit"] = "A3"

    TITLE_CODES["1905"] = {}
    TITLE_CODES["1905"]["title"] = "ASSOC PROF IN RES-SFT-VM"
    TITLE_CODES["1905"]["program"] = "ACADEMIC"
    TITLE_CODES["1905"]["unit"] = "A3"

    TITLE_CODES["1902"] = {}
    TITLE_CODES["1902"]["title"] = "ACT PROF-SFT-VM"
    TITLE_CODES["1902"]["program"] = "ACADEMIC"
    TITLE_CODES["1902"]["unit"] = "A3"

    TITLE_CODES["1903"] = {}
    TITLE_CODES["1903"]["title"] = "INSTR IN RESIDENCE-SFT-VM"
    TITLE_CODES["1903"]["program"] = "ACADEMIC"
    TITLE_CODES["1903"]["unit"] = "A3"

    TITLE_CODES["1900"] = {}
    TITLE_CODES["1900"]["title"] = "ACT ASSOC PROF-SFT-VM"
    TITLE_CODES["1900"]["program"] = "ACADEMIC"
    TITLE_CODES["1900"]["unit"] = "A3"

    TITLE_CODES["1901"] = {}
    TITLE_CODES["1901"]["title"] = "PROF-SFT-VM"
    TITLE_CODES["1901"]["program"] = "ACADEMIC"
    TITLE_CODES["1901"]["unit"] = "A3"

    TITLE_CODES["8941"] = {}
    TITLE_CODES["8941"]["title"] = "ECHOCARDIOGRAPHIC TCHN PRN"
    TITLE_CODES["8941"]["program"] = "PSS"
    TITLE_CODES["8941"]["unit"] = "EX"

    TITLE_CODES["8940"] = {}
    TITLE_CODES["8940"]["title"] = "CLIN LAB SCI"
    TITLE_CODES["8940"]["program"] = "PSS"
    TITLE_CODES["8940"]["unit"] = "HX"

    TITLE_CODES["8943"] = {}
    TITLE_CODES["8943"]["title"] = "ECHOCARDIOGRAPHIC TCHN"
    TITLE_CODES["8943"]["program"] = "PSS"
    TITLE_CODES["8943"]["unit"] = "EX"

    TITLE_CODES["3451"] = {}
    TITLE_CODES["3451"]["title"] = "ASSOC COOP EXT ADVISOR"
    TITLE_CODES["3451"]["program"] = "ACADEMIC"
    TITLE_CODES["3451"]["unit"] = "FX"

    TITLE_CODES["8945"] = {}
    TITLE_CODES["8945"]["title"] = "PHYS THER AST 2"
    TITLE_CODES["8945"]["program"] = "PSS"
    TITLE_CODES["8945"]["unit"] = "EX"

    TITLE_CODES["5113"] = {}
    TITLE_CODES["5113"]["title"] = "CUSTODIAN LD"
    TITLE_CODES["5113"]["program"] = "PSS"
    TITLE_CODES["5113"]["unit"] = "SX"

    TITLE_CODES["8947"] = {}
    TITLE_CODES["8947"]["title"] = "OCCUPATIONAL THER CERT AST 3"
    TITLE_CODES["8947"]["program"] = "PSS"
    TITLE_CODES["8947"]["unit"] = "EX"

    TITLE_CODES["8946"] = {}
    TITLE_CODES["8946"]["title"] = "PHYS THER AST 1"
    TITLE_CODES["8946"]["program"] = "PSS"
    TITLE_CODES["8946"]["unit"] = "EX"

    TITLE_CODES["3513"] = {}
    TITLE_CODES["3513"]["title"] = "COORD PUBLIC PROG II"
    TITLE_CODES["3513"]["program"] = "ACADEMIC"
    TITLE_CODES["3513"]["unit"] = "FX"

    TITLE_CODES["7264"] = {}
    TITLE_CODES["7264"]["title"] = "PUBL ADMST ANL AST"
    TITLE_CODES["7264"]["program"] = "PSS"
    TITLE_CODES["7264"]["unit"] = "99"

    TITLE_CODES["3511"] = {}
    TITLE_CODES["3511"]["title"] = "COORD PUBLIC PROG III"
    TITLE_CODES["3511"]["program"] = "ACADEMIC"
    TITLE_CODES["3511"]["unit"] = "FX"

    TITLE_CODES["9347"] = {}
    TITLE_CODES["9347"]["title"] = "MED RCDS ADM PRN SUPV"
    TITLE_CODES["9347"]["program"] = "PSS"
    TITLE_CODES["9347"]["unit"] = "99"

    TITLE_CODES["7261"] = {}
    TITLE_CODES["7261"]["title"] = "PUBL ADMST ANL PRN"
    TITLE_CODES["7261"]["program"] = "PSS"
    TITLE_CODES["7261"]["unit"] = "99"

    TITLE_CODES["7260"] = {}
    TITLE_CODES["7260"]["title"] = "PUBL ADMST ANL SUPV"
    TITLE_CODES["7260"]["program"] = "PSS"
    TITLE_CODES["7260"]["unit"] = "99"

    TITLE_CODES["3515"] = {}
    TITLE_CODES["3515"]["title"] = "COORD PUBLIC PROG I"
    TITLE_CODES["3515"]["program"] = "ACADEMIC"
    TITLE_CODES["3515"]["unit"] = "FX"

    TITLE_CODES["7262"] = {}
    TITLE_CODES["7262"]["title"] = "PUBL ADMST ANL SR"
    TITLE_CODES["7262"]["program"] = "PSS"
    TITLE_CODES["7262"]["unit"] = "99"

    TITLE_CODES["9348"] = {}
    TITLE_CODES["9348"]["title"] = "MED RCDS ADM SR SUPV"
    TITLE_CODES["9348"]["program"] = "PSS"
    TITLE_CODES["9348"]["unit"] = "99"

    TITLE_CODES["6203"] = {}
    TITLE_CODES["6203"]["title"] = "PROJECTIONIST"
    TITLE_CODES["6203"]["program"] = "PSS"
    TITLE_CODES["6203"]["unit"] = "TX"

    TITLE_CODES["8300"] = {}
    TITLE_CODES["8300"]["title"] = "ELECTR TCHN SUPV"
    TITLE_CODES["8300"]["program"] = "PSS"
    TITLE_CODES["8300"]["unit"] = "99"

    TITLE_CODES["7781"] = {}
    TITLE_CODES["7781"]["title"] = "BUYER 2 SUPV"
    TITLE_CODES["7781"]["program"] = "PSS"
    TITLE_CODES["7781"]["unit"] = "99"

    TITLE_CODES["1785"] = {}
    TITLE_CODES["1785"]["title"] = "ASSOC PROF IN RES-FY-MEDCOMP"
    TITLE_CODES["1785"]["program"] = "ACADEMIC"
    TITLE_CODES["1785"]["unit"] = "A3"

    TITLE_CODES["9041"] = {}
    TITLE_CODES["9041"]["title"] = "PROSTHETIST ORTHOTIST SR"
    TITLE_CODES["9041"]["program"] = "PSS"
    TITLE_CODES["9041"]["unit"] = "EX"

    TITLE_CODES["8044"] = {}
    TITLE_CODES["8044"]["title"] = "OPTOMETRIST SR SUPV"
    TITLE_CODES["8044"]["program"] = "PSS"
    TITLE_CODES["8044"]["unit"] = "99"

    TITLE_CODES["7511"] = {}
    TITLE_CODES["7511"]["title"] = "MGT SVC OFCR 2"
    TITLE_CODES["7511"]["program"] = "PSS"
    TITLE_CODES["7511"]["unit"] = "99"

    TITLE_CODES["9329"] = {}
    TITLE_CODES["9329"]["title"] = "CLIN RSCH CRD SR SUPV"
    TITLE_CODES["9329"]["program"] = "PSS"
    TITLE_CODES["9329"]["unit"] = "99"

    TITLE_CODES["5119"] = {}
    TITLE_CODES["5119"]["title"] = "CUSTODIAN AST SUPV"
    TITLE_CODES["5119"]["program"] = "PSS"
    TITLE_CODES["5119"]["unit"] = "99"

    TITLE_CODES["7510"] = {}
    TITLE_CODES["7510"]["title"] = "MGT SVC OFCR 3"
    TITLE_CODES["7510"]["program"] = "PSS"
    TITLE_CODES["7510"]["unit"] = "99"

    TITLE_CODES["7162"] = {}
    TITLE_CODES["7162"]["title"] = "ENGR AID SR"
    TITLE_CODES["7162"]["program"] = "PSS"
    TITLE_CODES["7162"]["unit"] = "TX"

    TITLE_CODES["3018"] = {}
    TITLE_CODES["3018"]["title"] = "VST ASSOC ----- IN THE A.E.S."
    TITLE_CODES["3018"]["program"] = "ACADEMIC"
    TITLE_CODES["3018"]["unit"] = "99"

    TITLE_CODES["5424"] = {}
    TITLE_CODES["5424"]["title"] = "DIETITIAN SR"
    TITLE_CODES["5424"]["program"] = "PSS"
    TITLE_CODES["5424"]["unit"] = "99"

    TITLE_CODES["0099"] = {}
    TITLE_CODES["0099"]["title"] = "EXEC MGR FUNC AREA"
    TITLE_CODES["0099"]["program"] = "MSP"
    TITLE_CODES["0099"]["unit"] = "99"

    TITLE_CODES["0098"] = {}
    TITLE_CODES["0098"]["title"] = "FUNC AREA EXEC AND DIR"
    TITLE_CODES["0098"]["program"] = "MSP"
    TITLE_CODES["0098"]["unit"] = "99"

    TITLE_CODES["3392"] = {}
    TITLE_CODES["3392"]["title"] = "ASSOC PROJ SCIENTIST-FY"
    TITLE_CODES["3392"]["program"] = "ACADEMIC"
    TITLE_CODES["3392"]["unit"] = "FX"

    TITLE_CODES["9028"] = {}
    TITLE_CODES["9028"]["title"] = "PERFUSIONIST"
    TITLE_CODES["9028"]["program"] = "PSS"
    TITLE_CODES["9028"]["unit"] = "EX"

    TITLE_CODES["8015"] = {}
    TITLE_CODES["8015"]["title"] = "CMTY HEALTH PRG REPR SUPV"
    TITLE_CODES["8015"]["program"] = "PSS"
    TITLE_CODES["8015"]["unit"] = "99"

    TITLE_CODES["8904"] = {}
    TITLE_CODES["8904"]["title"] = "HOSP AST SR"
    TITLE_CODES["8904"]["program"] = "PSS"
    TITLE_CODES["8904"]["unit"] = "EX"

    TITLE_CODES["0091"] = {}
    TITLE_CODES["0091"]["title"] = "EXEC AST VC FUNC AREA"
    TITLE_CODES["0091"]["program"] = "MSP"
    TITLE_CODES["0091"]["unit"] = "99"

    TITLE_CODES["0090"] = {}
    TITLE_CODES["0090"]["title"] = "EXEC ASC VC FUNC AREA"
    TITLE_CODES["0090"]["program"] = "MSP"
    TITLE_CODES["0090"]["unit"] = "99"

    TITLE_CODES["0093"] = {}
    TITLE_CODES["0093"]["title"] = "EXEC DIR FUNC AREA"
    TITLE_CODES["0093"]["program"] = "MSP"
    TITLE_CODES["0093"]["unit"] = "99"

    TITLE_CODES["0092"] = {}
    TITLE_CODES["0092"]["title"] = "EXEC AST VC SAFETY"
    TITLE_CODES["0092"]["program"] = "MSP"
    TITLE_CODES["0092"]["unit"] = "99"

    TITLE_CODES["0095"] = {}
    TITLE_CODES["0095"]["title"] = "EXEC ASC DIR FUNC AREA"
    TITLE_CODES["0095"]["program"] = "MSP"
    TITLE_CODES["0095"]["unit"] = "99"

    TITLE_CODES["0094"] = {}
    TITLE_CODES["0094"]["title"] = "EXEC DEPUTY DIR FUNC AREA"
    TITLE_CODES["0094"]["program"] = "MSP"
    TITLE_CODES["0094"]["unit"] = "99"

    TITLE_CODES["0097"] = {}
    TITLE_CODES["0097"]["title"] = "FUNC AREA EXEC DIR"
    TITLE_CODES["0097"]["program"] = "MSP"
    TITLE_CODES["0097"]["unit"] = "99"

    TITLE_CODES["0096"] = {}
    TITLE_CODES["0096"]["title"] = "EXEC AST DIR FUNC AREA"
    TITLE_CODES["0096"]["program"] = "MSP"
    TITLE_CODES["0096"]["unit"] = "99"

    TITLE_CODES["1623"] = {}
    TITLE_CODES["1623"]["title"] = "SENIOR LECTURER SOE-GENCOMP-B"
    TITLE_CODES["1623"]["program"] = "ACADEMIC"
    TITLE_CODES["1623"]["unit"] = "A3"

    TITLE_CODES["1622"] = {}
    TITLE_CODES["1622"]["title"] = "LECTURER SOE-GENCOMP-B"
    TITLE_CODES["1622"]["program"] = "ACADEMIC"
    TITLE_CODES["1622"]["unit"] = "A3"

    TITLE_CODES["1621"] = {}
    TITLE_CODES["1621"]["title"] = "SR LECT SOE-EMERITUS (WOS)"
    TITLE_CODES["1621"]["program"] = "ACADEMIC"
    TITLE_CODES["1621"]["unit"] = "A3"

    TITLE_CODES["1620"] = {}
    TITLE_CODES["1620"]["title"] = "LECT SOE-EMERITUS(WOS)"
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
    TITLE_CODES["3208"]["title"] = "VIS RES"
    TITLE_CODES["3208"]["program"] = "ACADEMIC"
    TITLE_CODES["3208"]["unit"] = "99"

    TITLE_CODES["8935"] = {}
    TITLE_CODES["8935"]["title"] = "ECHOCARDIOGRAPHIC TCHN SR PD"
    TITLE_CODES["8935"]["program"] = "PSS"
    TITLE_CODES["8935"]["unit"] = "EX"

    TITLE_CODES["8936"] = {}
    TITLE_CODES["8936"]["title"] = "CLIN LAB SCI SPEC SUPV SR"
    TITLE_CODES["8936"]["program"] = "PSS"
    TITLE_CODES["8936"]["unit"] = "99"

    TITLE_CODES["8937"] = {}
    TITLE_CODES["8937"]["title"] = "CLIN LAB SCI SUPV"
    TITLE_CODES["8937"]["program"] = "PSS"
    TITLE_CODES["8937"]["unit"] = "99"

    TITLE_CODES["8930"] = {}
    TITLE_CODES["8930"]["title"] = "SURGICAL TCHN SR"
    TITLE_CODES["8930"]["program"] = "PSS"
    TITLE_CODES["8930"]["unit"] = "EX"

    TITLE_CODES["8931"] = {}
    TITLE_CODES["8931"]["title"] = "SURGICAL TCHN"
    TITLE_CODES["8931"]["program"] = "PSS"
    TITLE_CODES["8931"]["unit"] = "EX"

    TITLE_CODES["8932"] = {}
    TITLE_CODES["8932"]["title"] = "SURGICAL TCHN PD"
    TITLE_CODES["8932"]["program"] = "PSS"
    TITLE_CODES["8932"]["unit"] = "EX"

    TITLE_CODES["3398"] = {}
    TITLE_CODES["3398"]["title"] = "VIS ASST PROJ SCIENTIST"
    TITLE_CODES["3398"]["program"] = "ACADEMIC"
    TITLE_CODES["3398"]["unit"] = "99"

    TITLE_CODES["8938"] = {}
    TITLE_CODES["8938"]["title"] = "CLIN LAB SCI SPEC SR"
    TITLE_CODES["8938"]["program"] = "PSS"
    TITLE_CODES["8938"]["unit"] = "HX"

    TITLE_CODES["8939"] = {}
    TITLE_CODES["8939"]["title"] = "CLIN LAB SCI SPEC"
    TITLE_CODES["8939"]["program"] = "PSS"
    TITLE_CODES["8939"]["unit"] = "HX"

    TITLE_CODES["9183"] = {}
    TITLE_CODES["9183"]["title"] = "OPERATING ROOM EQUIP SPEC 3 PD"
    TITLE_CODES["9183"]["program"] = "PSS"
    TITLE_CODES["9183"]["unit"] = "EX"

    TITLE_CODES["0740"] = {}
    TITLE_CODES["0740"]["title"] = "COMPUTING RESC MGR 3"
    TITLE_CODES["0740"]["program"] = "MSP"
    TITLE_CODES["0740"]["unit"] = "99"

    TITLE_CODES["0741"] = {}
    TITLE_CODES["0741"]["title"] = "COMPUTING RESC MGR 2"
    TITLE_CODES["0741"]["program"] = "MSP"
    TITLE_CODES["0741"]["unit"] = "99"

    TITLE_CODES["0742"] = {}
    TITLE_CODES["0742"]["title"] = "PROGR ANL 4"
    TITLE_CODES["0742"]["program"] = "MSP"
    TITLE_CODES["0742"]["unit"] = "99"

    TITLE_CODES["0743"] = {}
    TITLE_CODES["0743"]["title"] = "MGT SVC OFCR 4"
    TITLE_CODES["0743"]["program"] = "MSP"
    TITLE_CODES["0743"]["unit"] = "99"

    TITLE_CODES["0744"] = {}
    TITLE_CODES["0744"]["title"] = "COMPUTER RESC MGR 3"
    TITLE_CODES["0744"]["program"] = "MSP"
    TITLE_CODES["0744"]["unit"] = "99"

    TITLE_CODES["0745"] = {}
    TITLE_CODES["0745"]["title"] = "PATENT ADVISOR 3"
    TITLE_CODES["0745"]["program"] = "MSP"
    TITLE_CODES["0745"]["unit"] = "99"

    TITLE_CODES["0746"] = {}
    TITLE_CODES["0746"]["title"] = "COMPUTER RESC MGR 2"
    TITLE_CODES["0746"]["program"] = "MSP"
    TITLE_CODES["0746"]["unit"] = "99"

    TITLE_CODES["0747"] = {}
    TITLE_CODES["0747"]["title"] = "ACCOUNTANT PRN"
    TITLE_CODES["0747"]["program"] = "MSP"
    TITLE_CODES["0747"]["unit"] = "99"

    TITLE_CODES["0748"] = {}
    TITLE_CODES["0748"]["title"] = "COMPUTER NETWORK TCHNO 4"
    TITLE_CODES["0748"]["program"] = "MSP"
    TITLE_CODES["0748"]["unit"] = "99"

    TITLE_CODES["0749"] = {}
    TITLE_CODES["0749"]["title"] = "AUDITOR PRN"
    TITLE_CODES["0749"]["program"] = "MSP"
    TITLE_CODES["0749"]["unit"] = "99"

    TITLE_CODES["9181"] = {}
    TITLE_CODES["9181"]["title"] = "RADLG AST PD"
    TITLE_CODES["9181"]["program"] = "PSS"
    TITLE_CODES["9181"]["unit"] = "EX"

    TITLE_CODES["7141"] = {}
    TITLE_CODES["7141"]["title"] = "EHS TCHN PRN"
    TITLE_CODES["7141"]["program"] = "PSS"
    TITLE_CODES["7141"]["unit"] = "TX"

    TITLE_CODES["3063"] = {}
    TITLE_CODES["3063"]["title"] = " --IN THE AES-B/ECON/ENG-AY-1/9"
    TITLE_CODES["3063"]["program"] = "ACADEMIC"
    TITLE_CODES["3063"]["unit"] = "FX"

    TITLE_CODES["3062"] = {}
    TITLE_CODES["3062"]["title"] = "AGRON AES-B/E/E-AY"
    TITLE_CODES["3062"]["program"] = "ACADEMIC"
    TITLE_CODES["3062"]["unit"] = "FX"

    TITLE_CODES["3061"] = {}
    TITLE_CODES["3061"]["title"] = " --- IN THE AES-ACAD YR - 1/9TH"
    TITLE_CODES["3061"]["program"] = "ACADEMIC"
    TITLE_CODES["3061"]["unit"] = "FX"

    TITLE_CODES["3060"] = {}
    TITLE_CODES["3060"]["title"] = "AGRON AES-AY"
    TITLE_CODES["3060"]["program"] = "ACADEMIC"
    TITLE_CODES["3060"]["unit"] = "FX"

    TITLE_CODES["3067"] = {}
    TITLE_CODES["3067"]["title"] = "ACT---IN AES-B/ECON/ENG-AY-1/9"
    TITLE_CODES["3067"]["program"] = "ACADEMIC"
    TITLE_CODES["3067"]["unit"] = "99"

    TITLE_CODES["3066"] = {}
    TITLE_CODES["3066"]["title"] = "ACT AGRON AES-B/E/E-AY"
    TITLE_CODES["3066"]["program"] = "ACADEMIC"
    TITLE_CODES["3066"]["unit"] = "99"

    TITLE_CODES["3065"] = {}
    TITLE_CODES["3065"]["title"] = "ACT --- IN THE AES-ACAD YR-1/9"
    TITLE_CODES["3065"]["program"] = "ACADEMIC"
    TITLE_CODES["3065"]["unit"] = "99"

    TITLE_CODES["3064"] = {}
    TITLE_CODES["3064"]["title"] = "ACT AGRON AES-AY"
    TITLE_CODES["3064"]["program"] = "ACADEMIC"
    TITLE_CODES["3064"]["unit"] = "99"

    TITLE_CODES["7676"] = {}
    TITLE_CODES["7676"]["title"] = "PRG PROMOTION MGR 1"
    TITLE_CODES["7676"]["program"] = "PSS"
    TITLE_CODES["7676"]["unit"] = "99"

    TITLE_CODES["7677"] = {}
    TITLE_CODES["7677"]["title"] = "PUBLICATIONS MGR SUPV"
    TITLE_CODES["7677"]["program"] = "PSS"
    TITLE_CODES["7677"]["unit"] = "99"

    TITLE_CODES["7143"] = {}
    TITLE_CODES["7143"]["title"] = "EHS TCHN"
    TITLE_CODES["7143"]["program"] = "PSS"
    TITLE_CODES["7143"]["unit"] = "TX"

    TITLE_CODES["7672"] = {}
    TITLE_CODES["7672"]["title"] = "PUBL INFO REPR"
    TITLE_CODES["7672"]["program"] = "PSS"
    TITLE_CODES["7672"]["unit"] = "99"

    TITLE_CODES["7673"] = {}
    TITLE_CODES["7673"]["title"] = "PRG PROMOTION MGR SUPV"
    TITLE_CODES["7673"]["program"] = "PSS"
    TITLE_CODES["7673"]["unit"] = "99"

    TITLE_CODES["7670"] = {}
    TITLE_CODES["7670"]["title"] = "PUBL INFO REPR SUPV"
    TITLE_CODES["7670"]["program"] = "PSS"
    TITLE_CODES["7670"]["unit"] = "99"

    TITLE_CODES["7671"] = {}
    TITLE_CODES["7671"]["title"] = "PUBL INFO REPR SR"
    TITLE_CODES["7671"]["program"] = "PSS"
    TITLE_CODES["7671"]["unit"] = "99"

    TITLE_CODES["1051"] = {}
    TITLE_CODES["1051"]["title"] = "ASST COLLEGE PROVOST"
    TITLE_CODES["1051"]["program"] = "ACADEMIC"
    TITLE_CODES["1051"]["unit"] = "99"

    TITLE_CODES["1052"] = {}
    TITLE_CODES["1052"]["title"] = "ASSOC COLLEGE PROVOST"
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
    TITLE_CODES["1059"]["title"] = "CHAIR-SEN ASMBLY&ACADEMIC CNCL"
    TITLE_CODES["1059"]["program"] = "ACADEMIC"
    TITLE_CODES["1059"]["unit"] = "99"

    TITLE_CODES["3340"] = {}
    TITLE_CODES["3340"]["title"] = "SUPERINTENDENT OF STATION"
    TITLE_CODES["3340"]["program"] = "ACADEMIC"
    TITLE_CODES["3340"]["unit"] = "99"

    TITLE_CODES["5454"] = {}
    TITLE_CODES["5454"]["title"] = "FOOD SVC SUPV"
    TITLE_CODES["5454"]["program"] = "PSS"
    TITLE_CODES["5454"]["unit"] = "99"

    TITLE_CODES["5455"] = {}
    TITLE_CODES["5455"]["title"] = "FOOD SVC WORKER PD"
    TITLE_CODES["5455"]["program"] = "PSS"
    TITLE_CODES["5455"]["unit"] = "SX"

    TITLE_CODES["5456"] = {}
    TITLE_CODES["5456"]["title"] = "FOOD SVC WORKER SR PD"
    TITLE_CODES["5456"]["program"] = "PSS"
    TITLE_CODES["5456"]["unit"] = "SX"

    TITLE_CODES["5457"] = {}
    TITLE_CODES["5457"]["title"] = "FOOD SVC WORKER PRN PD"
    TITLE_CODES["5457"]["program"] = "PSS"
    TITLE_CODES["5457"]["unit"] = "SX"

    TITLE_CODES["1793"] = {}
    TITLE_CODES["1793"]["title"] = "HS ASSOC CLIN PROF-GENCOMP-B"
    TITLE_CODES["1793"]["program"] = "ACADEMIC"
    TITLE_CODES["1793"]["unit"] = "99"

    TITLE_CODES["9221"] = {}
    TITLE_CODES["9221"]["title"] = "STERILE PROCESSING TCHN 2 PD"
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
    TITLE_CODES["9220"]["title"] = "STERILE PROCESSING TCHN 1 PD"
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
    TITLE_CODES["6976"]["title"] = "DESIGN CONST PROJECT MGR 3"
    TITLE_CODES["6976"]["program"] = "PSS"
    TITLE_CODES["6976"]["unit"] = "99"

    TITLE_CODES["6977"] = {}
    TITLE_CODES["6977"]["title"] = "DESIGN CONST PROJECT MGR 4"
    TITLE_CODES["6977"]["program"] = "PSS"
    TITLE_CODES["6977"]["unit"] = "99"

    TITLE_CODES["6974"] = {}
    TITLE_CODES["6974"]["title"] = "DESIGN CONST PROJECT MGR 1"
    TITLE_CODES["6974"]["program"] = "PSS"
    TITLE_CODES["6974"]["unit"] = "99"

    TITLE_CODES["2852"] = {}
    TITLE_CODES["2852"]["title"] = "SPECIAL READER-UCLA-GSHIP"
    TITLE_CODES["2852"]["program"] = "ACADEMIC"
    TITLE_CODES["2852"]["unit"] = "BX"

    TITLE_CODES["6970"] = {}
    TITLE_CODES["6970"]["title"] = "PLANNER SUPV"
    TITLE_CODES["6970"]["program"] = "PSS"
    TITLE_CODES["6970"]["unit"] = "99"

    TITLE_CODES["5420"] = {}
    TITLE_CODES["5420"]["title"] = "REG DIETETIC TCHN SUPV"
    TITLE_CODES["5420"]["program"] = "PSS"
    TITLE_CODES["5420"]["unit"] = "99"

    TITLE_CODES["2855"] = {}
    TITLE_CODES["2855"]["title"] = "READER-NON GSHIP/NON REP"
    TITLE_CODES["2855"]["program"] = "ACADEMIC"
    TITLE_CODES["2855"]["unit"] = "99"

    TITLE_CODES["7142"] = {}
    TITLE_CODES["7142"]["title"] = "EHS TCHN SR"
    TITLE_CODES["7142"]["program"] = "PSS"
    TITLE_CODES["7142"]["unit"] = "TX"

    TITLE_CODES["6978"] = {}
    TITLE_CODES["6978"]["title"] = "DESIGN CONST PROJECT MGR 5"
    TITLE_CODES["6978"]["program"] = "PSS"
    TITLE_CODES["6978"]["unit"] = "99"

    TITLE_CODES["2854"] = {}
    TITLE_CODES["2854"]["title"] = "READER-GSHIP/NON REP"
    TITLE_CODES["2854"]["program"] = "ACADEMIC"
    TITLE_CODES["2854"]["unit"] = "99"

    TITLE_CODES["1007"] = {}
    TITLE_CODES["1007"]["title"] = "ACT/INTERIM DEAN"
    TITLE_CODES["1007"]["program"] = "ACADEMIC"
    TITLE_CODES["1007"]["unit"] = "99"

    TITLE_CODES["8248"] = {}
    TITLE_CODES["8248"]["title"] = "PHYS PLT OPR"
    TITLE_CODES["8248"]["program"] = "PSS"
    TITLE_CODES["8248"]["unit"] = "SX"

    TITLE_CODES["8249"] = {}
    TITLE_CODES["8249"]["title"] = "GLAZIER APPR"
    TITLE_CODES["8249"]["program"] = "PSS"
    TITLE_CODES["8249"]["unit"] = "K3"

    TITLE_CODES["8680"] = {}
    TITLE_CODES["8680"]["title"] = "MED CTR ELECTR TCHN PRN SUPV"
    TITLE_CODES["8680"]["program"] = "PSS"
    TITLE_CODES["8680"]["unit"] = "99"

    TITLE_CODES["7632"] = {}
    TITLE_CODES["7632"]["title"] = "AUDITOR 3 SUPV"
    TITLE_CODES["7632"]["program"] = "PSS"
    TITLE_CODES["7632"]["unit"] = "99"

    TITLE_CODES["1794"] = {}
    TITLE_CODES["1794"]["title"] = "HS CLIN PROF-GENCOMP-B"
    TITLE_CODES["1794"]["program"] = "ACADEMIC"
    TITLE_CODES["1794"]["unit"] = "99"

    TITLE_CODES["8246"] = {}
    TITLE_CODES["8246"]["title"] = "SHEETMETAL MECH"
    TITLE_CODES["8246"]["program"] = "PSS"
    TITLE_CODES["8246"]["unit"] = "K3"

    TITLE_CODES["8247"] = {}
    TITLE_CODES["8247"]["title"] = "PHYS PLT OPR SUPV"
    TITLE_CODES["8247"]["program"] = "PSS"
    TITLE_CODES["8247"]["unit"] = "99"

    TITLE_CODES["8244"] = {}
    TITLE_CODES["8244"]["title"] = "WATER AND WASTEWATER OPR APPR"
    TITLE_CODES["8244"]["program"] = "PSS"
    TITLE_CODES["8244"]["unit"] = "K3"

    TITLE_CODES["8245"] = {}
    TITLE_CODES["8245"]["title"] = "WATER AND WASTEWATER OPR"
    TITLE_CODES["8245"]["program"] = "PSS"
    TITLE_CODES["8245"]["unit"] = "K3"

    TITLE_CODES["5423"] = {}
    TITLE_CODES["5423"]["title"] = "DIETITIAN PRN SUPV"
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
    TITLE_CODES["7171"]["title"] = "DEV TCHN 4"
    TITLE_CODES["7171"]["program"] = "PSS"
    TITLE_CODES["7171"]["unit"] = "TX"

    TITLE_CODES["3110"] = {}
    TITLE_CODES["3110"]["title"] = "ASSOC ASTRONOMER"
    TITLE_CODES["3110"]["program"] = "ACADEMIC"
    TITLE_CODES["3110"]["unit"] = "FX"

    TITLE_CODES["7188"] = {}
    TITLE_CODES["7188"]["title"] = "DEV ENGR AST SUPV"
    TITLE_CODES["7188"]["program"] = "PSS"
    TITLE_CODES["7188"]["unit"] = "99"

    TITLE_CODES["1470"] = {}
    TITLE_CODES["1470"]["title"] = "AST PROF OF CLIN___-FY-GENCOMP"
    TITLE_CODES["1470"]["program"] = "ACADEMIC"
    TITLE_CODES["1470"]["unit"] = "A3"

    TITLE_CODES["1986"] = {}
    TITLE_CODES["1986"]["title"] = "ASST RES-AY-1/9-B/E/E"
    TITLE_CODES["1986"]["program"] = "ACADEMIC"
    TITLE_CODES["1986"]["unit"] = "FX"

    TITLE_CODES["8681"] = {}
    TITLE_CODES["8681"]["title"] = "MED CTR ELECTR TCHN PRN"
    TITLE_CODES["8681"]["program"] = "PSS"
    TITLE_CODES["8681"]["unit"] = "EX"

    TITLE_CODES["8649"] = {}
    TITLE_CODES["8649"]["title"] = "MECH SHOP SUPT SR"
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
    TITLE_CODES["7184"]["title"] = "DEV ENGR JR"
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
    TITLE_CODES["8918"]["title"] = "VOC NURSE PD"
    TITLE_CODES["8918"]["program"] = "PSS"
    TITLE_CODES["8918"]["unit"] = "EX"

    TITLE_CODES["1306"] = {}
    TITLE_CODES["1306"]["title"] = "ASST PROFESSOR-ACAD YR-RECALL"
    TITLE_CODES["1306"]["program"] = "ACADEMIC"
    TITLE_CODES["1306"]["unit"] = "A3"

    TITLE_CODES["1307"] = {}
    TITLE_CODES["1307"]["title"] = "ACT ASST PROF-AY"
    TITLE_CODES["1307"]["program"] = "ACADEMIC"
    TITLE_CODES["1307"]["unit"] = "99"

    TITLE_CODES["1300"] = {}
    TITLE_CODES["1300"]["title"] = "ASST PROF-AY"
    TITLE_CODES["1300"]["program"] = "ACADEMIC"
    TITLE_CODES["1300"]["unit"] = "A3"

    TITLE_CODES["1301"] = {}
    TITLE_CODES["1301"]["title"] = "ACT ASST PROF-AY-1/9"
    TITLE_CODES["1301"]["program"] = "ACADEMIC"
    TITLE_CODES["1301"]["unit"] = "99"

    TITLE_CODES["1302"] = {}
    TITLE_CODES["1302"]["title"] = "VST ASST PROFESSOR-ACAD YR-1/9"
    TITLE_CODES["1302"]["program"] = "ACADEMIC"
    TITLE_CODES["1302"]["unit"] = "99"

    TITLE_CODES["1303"] = {}
    TITLE_CODES["1303"]["title"] = "ASST PROF-AY-1/9"
    TITLE_CODES["1303"]["program"] = "ACADEMIC"
    TITLE_CODES["1303"]["unit"] = "A3"

    TITLE_CODES["9810"] = {}
    TITLE_CODES["9810"]["title"] = "FIRE SPEC 2 40 HRS"
    TITLE_CODES["9810"]["program"] = "PSS"
    TITLE_CODES["9810"]["unit"] = "FF"

    TITLE_CODES["1308"] = {}
    TITLE_CODES["1308"]["title"] = "VIS ASST PROF"
    TITLE_CODES["1308"]["program"] = "ACADEMIC"
    TITLE_CODES["1308"]["unit"] = "99"

    TITLE_CODES["0498"] = {}
    TITLE_CODES["0498"]["title"] = "TEMP SALARY SUPPL WITH MGT TTL"
    TITLE_CODES["0498"]["program"] = "MSP"
    TITLE_CODES["0498"]["unit"] = "87"

    TITLE_CODES["8019"] = {}
    TITLE_CODES["8019"]["title"] = "PSYCHOMETRIST SR SUPV"
    TITLE_CODES["8019"]["program"] = "PSS"
    TITLE_CODES["8019"]["unit"] = "99"

    TITLE_CODES["8018"] = {}
    TITLE_CODES["8018"]["title"] = "COUNSELING PSYCHOLOGIST 2 SUPV"
    TITLE_CODES["8018"]["program"] = "PSS"
    TITLE_CODES["8018"]["unit"] = "99"

    TITLE_CODES["8545"] = {}
    TITLE_CODES["8545"]["title"] = "AGRICULTURAL TCHN PRN SUPV"
    TITLE_CODES["8545"]["program"] = "PSS"
    TITLE_CODES["8545"]["unit"] = "99"

    TITLE_CODES["8016"] = {}
    TITLE_CODES["8016"]["title"] = "CMTY HEALTH PRG REPR SR SUPV"
    TITLE_CODES["8016"]["program"] = "PSS"
    TITLE_CODES["8016"]["unit"] = "99"

    TITLE_CODES["0496"] = {}
    TITLE_CODES["0496"]["title"] = "ADMIN STIPEND WITH MGT TTL"
    TITLE_CODES["0496"]["program"] = "MSP"
    TITLE_CODES["0496"]["unit"] = "87"

    TITLE_CODES["6329"] = {}
    TITLE_CODES["6329"]["title"] = "SCENE TCHN SR SUPV"
    TITLE_CODES["6329"]["program"] = "PSS"
    TITLE_CODES["6329"]["unit"] = "99"

    TITLE_CODES["0490"] = {}
    TITLE_CODES["0490"]["title"] = "REGISTRAR"
    TITLE_CODES["0490"]["program"] = "MSP"
    TITLE_CODES["0490"]["unit"] = "99"

    TITLE_CODES["8012"] = {}
    TITLE_CODES["8012"]["title"] = "SOCIAL WORK ASC SUPV"
    TITLE_CODES["8012"]["program"] = "PSS"
    TITLE_CODES["8012"]["unit"] = "99"

    TITLE_CODES["0492"] = {}
    TITLE_CODES["0492"]["title"] = "EHS OFCR ADM"
    TITLE_CODES["0492"]["program"] = "MSP"
    TITLE_CODES["0492"]["unit"] = "99"

    TITLE_CODES["8542"] = {}
    TITLE_CODES["8542"]["title"] = "AGRICULTURAL TCHN"
    TITLE_CODES["8542"]["program"] = "PSS"
    TITLE_CODES["8542"]["unit"] = "SX"

    TITLE_CODES["8171"] = {}
    TITLE_CODES["8171"]["title"] = "PHYS PLT MECH AST SUPV"
    TITLE_CODES["8171"]["program"] = "PSS"
    TITLE_CODES["8171"]["unit"] = "99"

    TITLE_CODES["6222"] = {}
    TITLE_CODES["6222"]["title"] = "PHOTOGRAPHER SR"
    TITLE_CODES["6222"]["program"] = "PSS"
    TITLE_CODES["6222"]["unit"] = "TX"

    TITLE_CODES["8673"] = {}
    TITLE_CODES["8673"]["title"] = "MED CTR LAB MECHN"
    TITLE_CODES["8673"]["program"] = "PSS"
    TITLE_CODES["8673"]["unit"] = "EX"

    TITLE_CODES["0020"] = {}
    TITLE_CODES["0020"]["title"] = "AST PRESIDENT FUNC AREA"
    TITLE_CODES["0020"]["program"] = "MSP"
    TITLE_CODES["0020"]["unit"] = "99"

    TITLE_CODES["0021"] = {}
    TITLE_CODES["0021"]["title"] = "ASC VP SYSWIDE CONTROLLER"
    TITLE_CODES["0021"]["program"] = "MSP"
    TITLE_CODES["0021"]["unit"] = "99"

    TITLE_CODES["7776"] = {}
    TITLE_CODES["7776"]["title"] = "BUYER 3"
    TITLE_CODES["7776"]["program"] = "PSS"
    TITLE_CODES["7776"]["unit"] = "99"

    TITLE_CODES["9538"] = {}
    TITLE_CODES["9538"]["title"] = "ANIMAL HEALTH TCHN 4 SUPV"
    TITLE_CODES["9538"]["program"] = "PSS"
    TITLE_CODES["9538"]["unit"] = "99"

    TITLE_CODES["7694"] = {}
    TITLE_CODES["7694"]["title"] = "PUBL CRD SR"
    TITLE_CODES["7694"]["program"] = "PSS"
    TITLE_CODES["7694"]["unit"] = "99"

    TITLE_CODES["7695"] = {}
    TITLE_CODES["7695"]["title"] = "PUBL CRD"
    TITLE_CODES["7695"]["program"] = "PSS"
    TITLE_CODES["7695"]["unit"] = "99"

    TITLE_CODES["7696"] = {}
    TITLE_CODES["7696"]["title"] = "PUBLICATIONS CRD SR SUPV"
    TITLE_CODES["7696"]["program"] = "PSS"
    TITLE_CODES["7696"]["unit"] = "99"

    TITLE_CODES["6221"] = {}
    TITLE_CODES["6221"]["title"] = "PHOTOGRAPHER PRN"
    TITLE_CODES["6221"]["program"] = "PSS"
    TITLE_CODES["6221"]["unit"] = "TX"

    TITLE_CODES["7692"] = {}
    TITLE_CODES["7692"]["title"] = "PUBL CRD SUPV"
    TITLE_CODES["7692"]["program"] = "PSS"
    TITLE_CODES["7692"]["unit"] = "99"

    TITLE_CODES["7693"] = {}
    TITLE_CODES["7693"]["title"] = "PUBL CRD PRN"
    TITLE_CODES["7693"]["program"] = "PSS"
    TITLE_CODES["7693"]["unit"] = "99"

    TITLE_CODES["9321"] = {}
    TITLE_CODES["9321"]["title"] = "CMTY HEALTH PRG CHF AST"
    TITLE_CODES["9321"]["program"] = "PSS"
    TITLE_CODES["9321"]["unit"] = "99"

    TITLE_CODES["6226"] = {}
    TITLE_CODES["6226"]["title"] = "PHOTOGRAPHIC TCHN SR"
    TITLE_CODES["6226"]["program"] = "PSS"
    TITLE_CODES["6226"]["unit"] = "TX"

    TITLE_CODES["7698"] = {}
    TITLE_CODES["7698"]["title"] = "ADMIN SPEC 1"
    TITLE_CODES["7698"]["program"] = "PSS"
    TITLE_CODES["7698"]["unit"] = "99"

    TITLE_CODES["9535"] = {}
    TITLE_CODES["9535"]["title"] = "ANIMAL HEALTH TCHN 3"
    TITLE_CODES["9535"]["program"] = "PSS"
    TITLE_CODES["9535"]["unit"] = "TX"

    TITLE_CODES["8672"] = {}
    TITLE_CODES["8672"]["title"] = "MED CTR LAB MECHN SR"
    TITLE_CODES["8672"]["program"] = "PSS"
    TITLE_CODES["8672"]["unit"] = "EX"

    TITLE_CODES["7172"] = {}
    TITLE_CODES["7172"]["title"] = "DEV TCHN 3"
    TITLE_CODES["7172"]["program"] = "PSS"
    TITLE_CODES["7172"]["unit"] = "TX"

    TITLE_CODES["1701"] = {}
    TITLE_CODES["1701"]["title"] = "RECALL HCOMP"
    TITLE_CODES["1701"]["program"] = "ACADEMIC"
    TITLE_CODES["1701"]["unit"] = "A3"

    TITLE_CODES["1344"] = {}
    TITLE_CODES["1344"]["title"] = "ASST PROF-FY-B/E/E"
    TITLE_CODES["1344"]["program"] = "ACADEMIC"
    TITLE_CODES["1344"]["unit"] = "A3"

    TITLE_CODES["8081"] = {}
    TITLE_CODES["8081"]["title"] = "VENTILATION MECH LD"
    TITLE_CODES["8081"]["program"] = "PSS"
    TITLE_CODES["8081"]["unit"] = "K3"

    TITLE_CODES["8684"] = {}
    TITLE_CODES["8684"]["title"] = "MED CTR ELECTR TCHN TRAINEE"
    TITLE_CODES["8684"]["program"] = "PSS"
    TITLE_CODES["8684"]["unit"] = "EX"

    TITLE_CODES["9532"] = {}
    TITLE_CODES["9532"]["title"] = "VETERINARIAN LAM ASC"
    TITLE_CODES["9532"]["program"] = "PSS"
    TITLE_CODES["9532"]["unit"] = "99"

    TITLE_CODES["4031"] = {}
    TITLE_CODES["4031"]["title"] = "LIFEGUARD"
    TITLE_CODES["4031"]["program"] = "PSS"
    TITLE_CODES["4031"]["unit"] = "TX"

    TITLE_CODES["8265"] = {}
    TITLE_CODES["8265"]["title"] = "LOCKSMITH LD"
    TITLE_CODES["8265"]["program"] = "PSS"
    TITLE_CODES["8265"]["unit"] = "K3"

    TITLE_CODES["9531"] = {}
    TITLE_CODES["9531"]["title"] = "VETERINARIAN LAM SR"
    TITLE_CODES["9531"]["program"] = "PSS"
    TITLE_CODES["9531"]["unit"] = "99"

    TITLE_CODES["9326"] = {}
    TITLE_CODES["9326"]["title"] = "CMTY HEALTH PRG REPR AST"
    TITLE_CODES["9326"]["program"] = "PSS"
    TITLE_CODES["9326"]["unit"] = "99"

    TITLE_CODES["9246"] = {}
    TITLE_CODES["9246"]["title"] = "PHARMACIST SR"
    TITLE_CODES["9246"]["program"] = "PSS"
    TITLE_CODES["9246"]["unit"] = "HX"

    TITLE_CODES["9218"] = {}
    TITLE_CODES["9218"]["title"] = "STERILE PROCESSING TCHN 2"
    TITLE_CODES["9218"]["program"] = "PSS"
    TITLE_CODES["9218"]["unit"] = "EX"

    TITLE_CODES["4131"] = {}
    TITLE_CODES["4131"]["title"] = "RSDT LANGUAGE HOUSE ADVISOR"
    TITLE_CODES["4131"]["program"] = "PSS"
    TITLE_CODES["4131"]["unit"] = "99"

    TITLE_CODES["8293"] = {}
    TITLE_CODES["8293"]["title"] = "TELEVISION TCHN"
    TITLE_CODES["8293"]["program"] = "PSS"
    TITLE_CODES["8293"]["unit"] = "TX"

    TITLE_CODES["1708"] = {}
    TITLE_CODES["1708"]["title"] = "RESEARCH PROFESSOR-VERIP"
    TITLE_CODES["1708"]["program"] = "ACADEMIC"
    TITLE_CODES["1708"]["unit"] = "A3"

    TITLE_CODES["8292"] = {}
    TITLE_CODES["8292"]["title"] = "TELEVISION TCHN SR"
    TITLE_CODES["8292"]["program"] = "PSS"
    TITLE_CODES["8292"]["unit"] = "TX"

    TITLE_CODES["8174"] = {}
    TITLE_CODES["8174"]["title"] = "PHYS PLT MECH"
    TITLE_CODES["8174"]["program"] = "PSS"
    TITLE_CODES["8174"]["unit"] = "K3"

    TITLE_CODES["5060"] = {}
    TITLE_CODES["5060"]["title"] = "STOREKEEPER SR LD"
    TITLE_CODES["5060"]["program"] = "PSS"
    TITLE_CODES["5060"]["unit"] = "SX"

    TITLE_CODES["9058"] = {}
    TITLE_CODES["9058"]["title"] = "EEG TCHNO SUPV"
    TITLE_CODES["9058"]["program"] = "PSS"
    TITLE_CODES["9058"]["unit"] = "99"

    TITLE_CODES["9615"] = {}
    TITLE_CODES["9615"]["title"] = "SRA 3 SUPV"
    TITLE_CODES["9615"]["program"] = "PSS"
    TITLE_CODES["9615"]["unit"] = "99"

    TITLE_CODES["6653"] = {}
    TITLE_CODES["6653"]["title"] = "LINGUISTIC INTERPRETER"
    TITLE_CODES["6653"]["program"] = "PSS"
    TITLE_CODES["6653"]["unit"] = "TX"

    TITLE_CODES["6313"] = {}
    TITLE_CODES["6313"]["title"] = "PUBL EVENTS MGR"
    TITLE_CODES["6313"]["program"] = "PSS"
    TITLE_CODES["6313"]["unit"] = "99"

    TITLE_CODES["3205"] = {}
    TITLE_CODES["3205"]["title"] = "RES-AY-1/9"
    TITLE_CODES["3205"]["program"] = "ACADEMIC"
    TITLE_CODES["3205"]["unit"] = "FX"

    TITLE_CODES["6652"] = {}
    TITLE_CODES["6652"]["title"] = "LINGUISTIC INTERPRETER SR"
    TITLE_CODES["6652"]["program"] = "PSS"
    TITLE_CODES["6652"]["unit"] = "TX"

    TITLE_CODES["9350"] = {}
    TITLE_CODES["9350"]["title"] = "CMTY HEALTH PRG SUPV"
    TITLE_CODES["9350"]["program"] = "PSS"
    TITLE_CODES["9350"]["unit"] = "99"

    TITLE_CODES["8511"] = {}
    TITLE_CODES["8511"]["title"] = "TRANSIT MAINT MGR"
    TITLE_CODES["8511"]["program"] = "PSS"
    TITLE_CODES["8511"]["unit"] = "99"

    TITLE_CODES["9324"] = {}
    TITLE_CODES["9324"]["title"] = "CMTY HEALTH PRG REPR SR"
    TITLE_CODES["9324"]["program"] = "PSS"
    TITLE_CODES["9324"]["unit"] = "99"

    TITLE_CODES["6650"] = {}
    TITLE_CODES["6650"]["title"] = "LANGUAGE AST"
    TITLE_CODES["6650"]["program"] = "PSS"
    TITLE_CODES["6650"]["unit"] = "TX"

    TITLE_CODES["4729"] = {}
    TITLE_CODES["4729"]["title"] = "BLANK AST 1 PD"
    TITLE_CODES["4729"]["program"] = "PSS"
    TITLE_CODES["4729"]["unit"] = "CX"

    TITLE_CODES["4728"] = {}
    TITLE_CODES["4728"]["title"] = "BLANK AST 1 SUPV"
    TITLE_CODES["4728"]["program"] = "PSS"
    TITLE_CODES["4728"]["unit"] = "99"

    TITLE_CODES["2301"] = {}
    TITLE_CODES["2301"]["title"] = "TEACHG FELLOW-NON GSHIP"
    TITLE_CODES["2301"]["program"] = "ACADEMIC"
    TITLE_CODES["2301"]["unit"] = "BX"

    TITLE_CODES["2300"] = {}
    TITLE_CODES["2300"]["title"] = "TEACHG FELLOW-GSHIP"
    TITLE_CODES["2300"]["program"] = "ACADEMIC"
    TITLE_CODES["2300"]["unit"] = "BX"

    TITLE_CODES["2303"] = {}
    TITLE_CODES["2303"]["title"] = "TEACHG FELLOW-NON GSHIP/NONREP"
    TITLE_CODES["2303"]["program"] = "ACADEMIC"
    TITLE_CODES["2303"]["unit"] = "99"

    TITLE_CODES["2302"] = {}
    TITLE_CODES["2302"]["title"] = "TEACHG FELLOW-GSHIP/NON REP"
    TITLE_CODES["2302"]["program"] = "ACADEMIC"
    TITLE_CODES["2302"]["unit"] = "99"

    TITLE_CODES["2305"] = {}
    TITLE_CODES["2305"]["title"] = "COMM TEACHG FELLOW-GSHIP"
    TITLE_CODES["2305"]["program"] = "ACADEMIC"
    TITLE_CODES["2305"]["unit"] = "BX"

    TITLE_CODES["4720"] = {}
    TITLE_CODES["4720"]["title"] = "PATIENT RCDS ABSTRACTOR 4 SUPV"
    TITLE_CODES["4720"]["program"] = "PSS"
    TITLE_CODES["4720"]["unit"] = "99"

    TITLE_CODES["4723"] = {}
    TITLE_CODES["4723"]["title"] = "BLANK AST 2"
    TITLE_CODES["4723"]["program"] = "PSS"
    TITLE_CODES["4723"]["unit"] = "CX"

    TITLE_CODES["2306"] = {}
    TITLE_CODES["2306"]["title"] = "COMM TEACHG FELLOW-NON GSHIP"
    TITLE_CODES["2306"]["program"] = "ACADEMIC"
    TITLE_CODES["2306"]["unit"] = "BX"

    TITLE_CODES["9325"] = {}
    TITLE_CODES["9325"]["title"] = "CMTY HEALTH PRG REPR"
    TITLE_CODES["9325"]["program"] = "PSS"
    TITLE_CODES["9325"]["unit"] = "99"

    TITLE_CODES["9717"] = {}
    TITLE_CODES["9717"]["title"] = "DIVING OFCR"
    TITLE_CODES["9717"]["program"] = "PSS"
    TITLE_CODES["9717"]["unit"] = "TX"

    TITLE_CODES["1878"] = {}
    TITLE_CODES["1878"]["title"] = "ACTING ASST PROFESSOR-SFT-PC"
    TITLE_CODES["1878"]["program"] = "ACADEMIC"
    TITLE_CODES["1878"]["unit"] = "99"

    TITLE_CODES["5841"] = {}
    TITLE_CODES["5841"]["title"] = "LAUNDRY MACHINE OPR SR"
    TITLE_CODES["5841"]["program"] = "PSS"
    TITLE_CODES["5841"]["unit"] = "SX"

    TITLE_CODES["8485"] = {}
    TITLE_CODES["8485"]["title"] = "AUTO EQUIP OPR PRN"
    TITLE_CODES["8485"]["program"] = "PSS"
    TITLE_CODES["8485"]["unit"] = "SX"

    TITLE_CODES["2288"] = {}
    TITLE_CODES["2288"]["title"] = "REMD TUT I-GSHIP"
    TITLE_CODES["2288"]["program"] = "ACADEMIC"
    TITLE_CODES["2288"]["unit"] = "BX"

    TITLE_CODES["2289"] = {}
    TITLE_CODES["2289"]["title"] = "REMD TUT II-GSHIP"
    TITLE_CODES["2289"]["program"] = "ACADEMIC"
    TITLE_CODES["2289"]["unit"] = "BX"

    TITLE_CODES["9121"] = {}
    TITLE_CODES["9121"]["title"] = "ANESTHETIST NURSE SR PD"
    TITLE_CODES["9121"]["program"] = "PSS"
    TITLE_CODES["9121"]["unit"] = "NX"

    TITLE_CODES["8490"] = {}
    TITLE_CODES["8490"]["title"] = "AUTO EQUIP OPR PD"
    TITLE_CODES["8490"]["program"] = "PSS"
    TITLE_CODES["8490"]["unit"] = "SX"

    TITLE_CODES["2280"] = {}
    TITLE_CODES["2280"]["title"] = "REMD TUT I-NON GSHIP"
    TITLE_CODES["2280"]["program"] = "ACADEMIC"
    TITLE_CODES["2280"]["unit"] = "BX"

    TITLE_CODES["2284"] = {}
    TITLE_CODES["2284"]["title"] = "CHILD DEV DEMO LECT-CONTINUING"
    TITLE_CODES["2284"]["program"] = "ACADEMIC"
    TITLE_CODES["2284"]["unit"] = "IX"

    TITLE_CODES["2285"] = {}
    TITLE_CODES["2285"]["title"] = "CHILD DEV DEMO LECT"
    TITLE_CODES["2285"]["program"] = "ACADEMIC"
    TITLE_CODES["2285"]["unit"] = "IX"

    TITLE_CODES["2286"] = {}
    TITLE_CODES["2286"]["title"] = "NURSERY SCHOOL ASST-GSHIP"
    TITLE_CODES["2286"]["program"] = "ACADEMIC"
    TITLE_CODES["2286"]["unit"] = "BX"

    TITLE_CODES["2287"] = {}
    TITLE_CODES["2287"]["title"] = "NURSERY SCHOOL ASST-NON GSHIP"
    TITLE_CODES["2287"]["program"] = "ACADEMIC"
    TITLE_CODES["2287"]["unit"] = "BX"

    TITLE_CODES["0245"] = {}
    TITLE_CODES["0245"]["title"] = "DIR"
    TITLE_CODES["0245"]["program"] = "MSP"
    TITLE_CODES["0245"]["unit"] = "99"

    TITLE_CODES["4621"] = {}
    TITLE_CODES["4621"]["title"] = "COLLECTIONS REPR SR"
    TITLE_CODES["4621"]["program"] = "PSS"
    TITLE_CODES["4621"]["unit"] = "CX"

    TITLE_CODES["4622"] = {}
    TITLE_CODES["4622"]["title"] = "COLLECTIONS REPR"
    TITLE_CODES["4622"]["program"] = "PSS"
    TITLE_CODES["4622"]["unit"] = "CX"

    TITLE_CODES["7712"] = {}
    TITLE_CODES["7712"]["title"] = "PRINTING EST SR"
    TITLE_CODES["7712"]["program"] = "PSS"
    TITLE_CODES["7712"]["unit"] = "TX"

    TITLE_CODES["4624"] = {}
    TITLE_CODES["4624"]["title"] = "COLLECTIONS REPR SR SUPV"
    TITLE_CODES["4624"]["program"] = "PSS"
    TITLE_CODES["4624"]["unit"] = "99"

    TITLE_CODES["4625"] = {}
    TITLE_CODES["4625"]["title"] = "COLLECTIONS REPR SUPV"
    TITLE_CODES["4625"]["program"] = "PSS"
    TITLE_CODES["4625"]["unit"] = "99"

    TITLE_CODES["9602"] = {}
    TITLE_CODES["9602"]["title"] = "LAB AST 3"
    TITLE_CODES["9602"]["program"] = "PSS"
    TITLE_CODES["9602"]["unit"] = "TX"

    TITLE_CODES["2271"] = {}
    TITLE_CODES["2271"]["title"] = "REMD TUT I-GSHIP/NON REP"
    TITLE_CODES["2271"]["program"] = "ACADEMIC"
    TITLE_CODES["2271"]["unit"] = "99"

    TITLE_CODES["2270"] = {}
    TITLE_CODES["2270"]["title"] = "REMD TUT I-NON GSHIP/NON REP"
    TITLE_CODES["2270"]["program"] = "ACADEMIC"
    TITLE_CODES["2270"]["unit"] = "99"

    TITLE_CODES["2273"] = {}
    TITLE_CODES["2273"]["title"] = "REMD TUT II-GSHIP/NON REP"
    TITLE_CODES["2273"]["program"] = "ACADEMIC"
    TITLE_CODES["2273"]["unit"] = "99"

    TITLE_CODES["2272"] = {}
    TITLE_CODES["2272"]["title"] = "REMD TUT II NON-GSHIP/NON REP"
    TITLE_CODES["2272"]["program"] = "ACADEMIC"
    TITLE_CODES["2272"]["unit"] = "99"

    TITLE_CODES["6284"] = {}
    TITLE_CODES["6284"]["title"] = "HOUSE MGR AST"
    TITLE_CODES["6284"]["program"] = "PSS"
    TITLE_CODES["6284"]["unit"] = "99"

    TITLE_CODES["6733"] = {}
    TITLE_CODES["6733"]["title"] = "BIBLIOGRAPHER 1"
    TITLE_CODES["6733"]["program"] = "PSS"
    TITLE_CODES["6733"]["unit"] = "CX"

    TITLE_CODES["8667"] = {}
    TITLE_CODES["8667"]["title"] = "LAB MECHN SR SUPV"
    TITLE_CODES["8667"]["program"] = "PSS"
    TITLE_CODES["8667"]["unit"] = "99"

    TITLE_CODES["9120"] = {}
    TITLE_CODES["9120"]["title"] = "PERMITEE INTERIM NURSE"
    TITLE_CODES["9120"]["program"] = "PSS"
    TITLE_CODES["9120"]["unit"] = "99"

    TITLE_CODES["4329"] = {}
    TITLE_CODES["4329"]["title"] = "STDT ACTIVITIES APPT OFFICIAL"
    TITLE_CODES["4329"]["program"] = "PSS"
    TITLE_CODES["4329"]["unit"] = "99"

    TITLE_CODES["9122"] = {}
    TITLE_CODES["9122"]["title"] = "ANESTHETIST NURSE PD"
    TITLE_CODES["9122"]["program"] = "PSS"
    TITLE_CODES["9122"]["unit"] = "NX"

    TITLE_CODES["9469"] = {}
    TITLE_CODES["9469"]["title"] = "SPEECH PATHOLOGIST SR PD"
    TITLE_CODES["9469"]["program"] = "PSS"
    TITLE_CODES["9469"]["unit"] = "HX"

    TITLE_CODES["9124"] = {}
    TITLE_CODES["9124"]["title"] = "ADMIN NURSE SUPV 1"
    TITLE_CODES["9124"]["program"] = "PSS"
    TITLE_CODES["9124"]["unit"] = "99"

    TITLE_CODES["8312"] = {}
    TITLE_CODES["8312"]["title"] = "LAB GLASSBLOWER SR"
    TITLE_CODES["8312"]["program"] = "PSS"
    TITLE_CODES["8312"]["unit"] = "TX"

    TITLE_CODES["9539"] = {}
    TITLE_CODES["9539"]["title"] = "ANIMAL HEALTH TCHN 3 SUPV"
    TITLE_CODES["9539"]["program"] = "PSS"
    TITLE_CODES["9539"]["unit"] = "99"

    TITLE_CODES["9127"] = {}
    TITLE_CODES["9127"]["title"] = "CLIN NURSE SUPV 4"
    TITLE_CODES["9127"]["program"] = "PSS"
    TITLE_CODES["9127"]["unit"] = "99"

    TITLE_CODES["8952"] = {}
    TITLE_CODES["8952"]["title"] = "OCCUPATIONAL THER CERT AST PD"
    TITLE_CODES["8952"]["program"] = "PSS"
    TITLE_CODES["8952"]["unit"] = "EX"

    TITLE_CODES["4949"] = {}
    TITLE_CODES["4949"]["title"] = "WORD PROCESSING SPEC PRN SUPV"
    TITLE_CODES["4949"]["program"] = "PSS"
    TITLE_CODES["4949"]["unit"] = "99"

    TITLE_CODES["9243"] = {}
    TITLE_CODES["9243"]["title"] = "HOSP AST 3 PD"
    TITLE_CODES["9243"]["program"] = "PSS"
    TITLE_CODES["9243"]["unit"] = "EX"

    TITLE_CODES["9534"] = {}
    TITLE_CODES["9534"]["title"] = "ANIMAL HEALTH TCHN 4 NEX"
    TITLE_CODES["9534"]["program"] = "PSS"
    TITLE_CODES["9534"]["unit"] = "TX"

    TITLE_CODES["9245"] = {}
    TITLE_CODES["9245"]["title"] = "HOSP AST 1 PD"
    TITLE_CODES["9245"]["program"] = "PSS"
    TITLE_CODES["9245"]["unit"] = "EX"

    TITLE_CODES["9244"] = {}
    TITLE_CODES["9244"]["title"] = "HOSP AST 2 PD"
    TITLE_CODES["9244"]["program"] = "PSS"
    TITLE_CODES["9244"]["unit"] = "EX"

    TITLE_CODES["9247"] = {}
    TITLE_CODES["9247"]["title"] = "STAFF PHARMACIST 2"
    TITLE_CODES["9247"]["program"] = "PSS"
    TITLE_CODES["9247"]["unit"] = "HX"

    TITLE_CODES["6281"] = {}
    TITLE_CODES["6281"]["title"] = "HOUSE MGR SUPV"
    TITLE_CODES["6281"]["program"] = "PSS"
    TITLE_CODES["6281"]["unit"] = "99"

    TITLE_CODES["1877"] = {}
    TITLE_CODES["1877"]["title"] = "ASSISTANT PROFESSOR-SFT-PC"
    TITLE_CODES["1877"]["program"] = "ACADEMIC"
    TITLE_CODES["1877"]["unit"] = "A3"

    TITLE_CODES["9632"] = {}
    TITLE_CODES["9632"]["title"] = "MUSEUM PREPARATOR PRN"
    TITLE_CODES["9632"]["program"] = "PSS"
    TITLE_CODES["9632"]["unit"] = "TX"

    TITLE_CODES["1875"] = {}
    TITLE_CODES["1875"]["title"] = "INSTRUCTOR-SFT-PC"
    TITLE_CODES["1875"]["program"] = "ACADEMIC"
    TITLE_CODES["1875"]["unit"] = "A3"

    TITLE_CODES["9212"] = {}
    TITLE_CODES["9212"]["title"] = "MED OFC SVC CRD 1"
    TITLE_CODES["9212"]["program"] = "PSS"
    TITLE_CODES["9212"]["unit"] = "EX"

    TITLE_CODES["0179"] = {}
    TITLE_CODES["0179"]["title"] = "SPC AST TO SVP"
    TITLE_CODES["0179"]["program"] = "MSP"
    TITLE_CODES["0179"]["unit"] = "99"

    TITLE_CODES["9042"] = {}
    TITLE_CODES["9042"]["title"] = "PROSTHETIST ORTHOTIST"
    TITLE_CODES["9042"]["program"] = "PSS"
    TITLE_CODES["9042"]["unit"] = "EX"

    TITLE_CODES["0175"] = {}
    TITLE_CODES["0175"]["title"] = "CSO MED CTR"
    TITLE_CODES["0175"]["program"] = "MSP"
    TITLE_CODES["0175"]["unit"] = "99"

    TITLE_CODES["0174"] = {}
    TITLE_CODES["0174"]["title"] = "CMO MED CTR"
    TITLE_CODES["0174"]["program"] = "MSP"
    TITLE_CODES["0174"]["unit"] = "99"

    TITLE_CODES["0173"] = {}
    TITLE_CODES["0173"]["title"] = "CIO MED CTR"
    TITLE_CODES["0173"]["program"] = "MSP"
    TITLE_CODES["0173"]["unit"] = "99"

    TITLE_CODES["0172"] = {}
    TITLE_CODES["0172"]["title"] = "COO MED CTR"
    TITLE_CODES["0172"]["program"] = "MSP"
    TITLE_CODES["0172"]["unit"] = "99"

    TITLE_CODES["0171"] = {}
    TITLE_CODES["0171"]["title"] = "ASC VP"
    TITLE_CODES["0171"]["program"] = "MSP"
    TITLE_CODES["0171"]["unit"] = "99"

    TITLE_CODES["1879"] = {}
    TITLE_CODES["1879"]["title"] = "ASSOCIATE PROFESSOR-SFT-PC"
    TITLE_CODES["1879"]["program"] = "ACADEMIC"
    TITLE_CODES["1879"]["unit"] = "A3"

    TITLE_CODES["2051"] = {}
    TITLE_CODES["2051"]["title"] = "ASST CLIN PROF-DENT-50%/+ FY"
    TITLE_CODES["2051"]["program"] = "ACADEMIC"
    TITLE_CODES["2051"]["unit"] = "99"

    TITLE_CODES["2050"] = {}
    TITLE_CODES["2050"]["title"] = "HS ASST CLIN PROF-FY"
    TITLE_CODES["2050"]["program"] = "ACADEMIC"
    TITLE_CODES["2050"]["unit"] = "99"

    TITLE_CODES["3200"] = {}
    TITLE_CODES["3200"]["title"] = "RES-FY"
    TITLE_CODES["3200"]["program"] = "ACADEMIC"
    TITLE_CODES["3200"]["unit"] = "FX"

    TITLE_CODES["2057"] = {}
    TITLE_CODES["2057"]["title"] = "ASST CLIN PROF-VOL"
    TITLE_CODES["2057"]["program"] = "ACADEMIC"
    TITLE_CODES["2057"]["unit"] = "99"

    TITLE_CODES["4826"] = {}
    TITLE_CODES["4826"]["title"] = "MAIL PROCESSOR SR SUPV"
    TITLE_CODES["4826"]["program"] = "PSS"
    TITLE_CODES["4826"]["unit"] = "99"

    TITLE_CODES["8942"] = {}
    TITLE_CODES["8942"]["title"] = "ECHOCARDIOGRAPHIC TCHN SR"
    TITLE_CODES["8942"]["program"] = "PSS"
    TITLE_CODES["8942"]["unit"] = "EX"

    TITLE_CODES["4824"] = {}
    TITLE_CODES["4824"]["title"] = "MAIL PROCESSOR AST"
    TITLE_CODES["4824"]["program"] = "PSS"
    TITLE_CODES["4824"]["unit"] = "SX"

    TITLE_CODES["4825"] = {}
    TITLE_CODES["4825"]["title"] = "MAIL PROCESSOR PRN"
    TITLE_CODES["4825"]["program"] = "PSS"
    TITLE_CODES["4825"]["unit"] = "SX"

    TITLE_CODES["4822"] = {}
    TITLE_CODES["4822"]["title"] = "MAIL PROCESSOR SR"
    TITLE_CODES["4822"]["program"] = "PSS"
    TITLE_CODES["4822"]["unit"] = "SX"

    TITLE_CODES["4823"] = {}
    TITLE_CODES["4823"]["title"] = "MAIL PROCESSOR"
    TITLE_CODES["4823"]["program"] = "PSS"
    TITLE_CODES["4823"]["unit"] = "SX"

    TITLE_CODES["6282"] = {}
    TITLE_CODES["6282"]["title"] = "HOUSE MGR 2"
    TITLE_CODES["6282"]["program"] = "PSS"
    TITLE_CODES["6282"]["unit"] = "99"

    TITLE_CODES["4821"] = {}
    TITLE_CODES["4821"]["title"] = "MAIL SVC SUPV"
    TITLE_CODES["4821"]["program"] = "PSS"
    TITLE_CODES["4821"]["unit"] = "99"

    TITLE_CODES["0180"] = {}
    TITLE_CODES["0180"]["title"] = "SPC AST TO VP"
    TITLE_CODES["0180"]["program"] = "MSP"
    TITLE_CODES["0180"]["unit"] = "99"

    TITLE_CODES["0181"] = {}
    TITLE_CODES["0181"]["title"] = "SPC AST TO VP FUNC AREA"
    TITLE_CODES["0181"]["program"] = "MSP"
    TITLE_CODES["0181"]["unit"] = "99"

    TITLE_CODES["8220"] = {}
    TITLE_CODES["8220"]["title"] = "ROOFER LD"
    TITLE_CODES["8220"]["program"] = "PSS"
    TITLE_CODES["8220"]["unit"] = "K3"

    TITLE_CODES["9044"] = {}
    TITLE_CODES["9044"]["title"] = "PROSTHETIST ORTHOTIST AST"
    TITLE_CODES["9044"]["program"] = "PSS"
    TITLE_CODES["9044"]["unit"] = "EX"

    TITLE_CODES["9335"] = {}
    TITLE_CODES["9335"]["title"] = "CLIN RSCH CRD"
    TITLE_CODES["9335"]["program"] = "PSS"
    TITLE_CODES["9335"]["unit"] = "RX"

    TITLE_CODES["9334"] = {}
    TITLE_CODES["9334"]["title"] = "CLIN RSCH CRD SR"
    TITLE_CODES["9334"]["program"] = "PSS"
    TITLE_CODES["9334"]["unit"] = "RX"

    TITLE_CODES["9336"] = {}
    TITLE_CODES["9336"]["title"] = "CLIN RSCH CRD AST"
    TITLE_CODES["9336"]["program"] = "PSS"
    TITLE_CODES["9336"]["unit"] = "RX"

    TITLE_CODES["9331"] = {}
    TITLE_CODES["9331"]["title"] = "CMTY SVC CASE MGR AST"
    TITLE_CODES["9331"]["program"] = "PSS"
    TITLE_CODES["9331"]["unit"] = "HX"

    TITLE_CODES["9330"] = {}
    TITLE_CODES["9330"]["title"] = "CMTY SVC CASE MGR"
    TITLE_CODES["9330"]["program"] = "PSS"
    TITLE_CODES["9330"]["unit"] = "HX"

    TITLE_CODES["9333"] = {}
    TITLE_CODES["9333"]["title"] = "CLIN RSCH SUPV"
    TITLE_CODES["9333"]["program"] = "PSS"
    TITLE_CODES["9333"]["unit"] = "99"

    TITLE_CODES["9293"] = {}
    TITLE_CODES["9293"]["title"] = "PHLEBOTOMIST CERT TCHN 2"
    TITLE_CODES["9293"]["program"] = "PSS"
    TITLE_CODES["9293"]["unit"] = "EX"

    TITLE_CODES["9613"] = {}
    TITLE_CODES["9613"]["title"] = "SRA 1"
    TITLE_CODES["9613"]["program"] = "PSS"
    TITLE_CODES["9613"]["unit"] = "RX"

    TITLE_CODES["8086"] = {}
    TITLE_CODES["8086"]["title"] = "PEST CNTRL OPR"
    TITLE_CODES["8086"]["program"] = "PSS"
    TITLE_CODES["8086"]["unit"] = "SX"

    TITLE_CODES["7353"] = {}
    TITLE_CODES["7353"]["title"] = "ANL 8"
    TITLE_CODES["7353"]["program"] = "PSS"
    TITLE_CODES["7353"]["unit"] = "99"

    TITLE_CODES["3522"] = {}
    TITLE_CODES["3522"]["title"] = "CONTINUING EDUCATOR III"
    TITLE_CODES["3522"]["program"] = "ACADEMIC"
    TITLE_CODES["3522"]["unit"] = "FX"

    TITLE_CODES["7354"] = {}
    TITLE_CODES["7354"]["title"] = "ANL 8 SUPV"
    TITLE_CODES["7354"]["program"] = "PSS"
    TITLE_CODES["7354"]["unit"] = "99"

    TITLE_CODES["3289"] = {}
    TITLE_CODES["3289"]["title"] = "ADJ INSTR-FY"
    TITLE_CODES["3289"]["program"] = "ACADEMIC"
    TITLE_CODES["3289"]["unit"] = "99"

    TITLE_CODES["3288"] = {}
    TITLE_CODES["3288"]["title"] = "ADJ INSTR-AY"
    TITLE_CODES["3288"]["program"] = "ACADEMIC"
    TITLE_CODES["3288"]["unit"] = "99"

    TITLE_CODES["3287"] = {}
    TITLE_CODES["3287"]["title"] = "GSR-TUIT & FEE REM-UCSD-GRP D"
    TITLE_CODES["3287"]["program"] = "ACADEMIC"
    TITLE_CODES["3287"]["unit"] = "99"

    TITLE_CODES["1910"] = {}
    TITLE_CODES["1910"]["title"] = "ADJ PROF-SFT-VM"
    TITLE_CODES["1910"]["program"] = "ACADEMIC"
    TITLE_CODES["1910"]["unit"] = "99"

    TITLE_CODES["3285"] = {}
    TITLE_CODES["3285"]["title"] = "GSR-TUIT & FEE REM-UCSD-GRP B"
    TITLE_CODES["3285"]["program"] = "ACADEMIC"
    TITLE_CODES["3285"]["unit"] = "99"

    TITLE_CODES["3284"] = {}
    TITLE_CODES["3284"]["title"] = "GSR-TUIT & FEE REM"
    TITLE_CODES["3284"]["program"] = "ACADEMIC"
    TITLE_CODES["3284"]["unit"] = "99"

    TITLE_CODES["3283"] = {}
    TITLE_CODES["3283"]["title"] = "GSR-FULL TUIT&PARTIAL FEE REM"
    TITLE_CODES["3283"]["program"] = "ACADEMIC"
    TITLE_CODES["3283"]["unit"] = "99"

    TITLE_CODES["3282"] = {}
    TITLE_CODES["3282"]["title"] = "GSR-FULL FEE REM"
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
    TITLE_CODES["1728"]["title"] = "ASST ADJ PROF-HCOMP"
    TITLE_CODES["1728"]["program"] = "ACADEMIC"
    TITLE_CODES["1728"]["unit"] = "99"

    TITLE_CODES["8944"] = {}
    TITLE_CODES["8944"]["title"] = "PHYS THER AST 3"
    TITLE_CODES["8944"]["program"] = "PSS"
    TITLE_CODES["8944"]["unit"] = "EX"

    TITLE_CODES["7210"] = {}
    TITLE_CODES["7210"]["title"] = "STATISTICIAN SUPV"
    TITLE_CODES["7210"]["program"] = "PSS"
    TITLE_CODES["7210"]["unit"] = "99"

    TITLE_CODES["7211"] = {}
    TITLE_CODES["7211"]["title"] = "STATISTICIAN PRN"
    TITLE_CODES["7211"]["program"] = "PSS"
    TITLE_CODES["7211"]["unit"] = "99"

    TITLE_CODES["7212"] = {}
    TITLE_CODES["7212"]["title"] = "STATISTICIAN SR"
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
    TITLE_CODES["3225"]["title"] = "ASST RES-AY-1/9"
    TITLE_CODES["3225"]["program"] = "ACADEMIC"
    TITLE_CODES["3225"]["unit"] = "FX"

    TITLE_CODES["6215"] = {}
    TITLE_CODES["6215"]["title"] = "PRODUCER DIR AST"
    TITLE_CODES["6215"]["program"] = "PSS"
    TITLE_CODES["6215"]["unit"] = "TX"

    TITLE_CODES["6214"] = {}
    TITLE_CODES["6214"]["title"] = "PRODUCER DIR"
    TITLE_CODES["6214"]["program"] = "PSS"
    TITLE_CODES["6214"]["unit"] = "TX"

    TITLE_CODES["2020"] = {}
    TITLE_CODES["2020"]["title"] = "HS ASSOC CLIN PROF-AY"
    TITLE_CODES["2020"]["program"] = "ACADEMIC"
    TITLE_CODES["2020"]["unit"] = "99"

    TITLE_CODES["2021"] = {}
    TITLE_CODES["2021"]["title"] = "ASSO CLIN PROF-DENT-50%/+ AY"
    TITLE_CODES["2021"]["program"] = "ACADEMIC"
    TITLE_CODES["2021"]["unit"] = "99"

    TITLE_CODES["6211"] = {}
    TITLE_CODES["6211"]["title"] = "MGN PRODUCER DIR"
    TITLE_CODES["6211"]["program"] = "PSS"
    TITLE_CODES["6211"]["unit"] = "99"

    TITLE_CODES["1976"] = {}
    TITLE_CODES["1976"]["title"] = "ACT ASSOC PROF-AY-1/9-B/E/E"
    TITLE_CODES["1976"]["program"] = "ACADEMIC"
    TITLE_CODES["1976"]["unit"] = "A3"

    TITLE_CODES["9027"] = {}
    TITLE_CODES["9027"]["title"] = "PERFUSIONIST SR"
    TITLE_CODES["9027"]["program"] = "PSS"
    TITLE_CODES["9027"]["unit"] = "EX"

    TITLE_CODES["1975"] = {}
    TITLE_CODES["1975"]["title"] = "ACT ASSOC PROF-FY-B/E/E"
    TITLE_CODES["1975"]["program"] = "ACADEMIC"
    TITLE_CODES["1975"]["unit"] = "A3"

    TITLE_CODES["6219"] = {}
    TITLE_CODES["6219"]["title"] = "PHOTOGRAPHER PRN SUPV"
    TITLE_CODES["6219"]["program"] = "PSS"
    TITLE_CODES["6219"]["unit"] = "99"

    TITLE_CODES["1729"] = {}
    TITLE_CODES["1729"]["title"] = "ASSOC ADJ PROF-HCOMP"
    TITLE_CODES["1729"]["program"] = "ACADEMIC"
    TITLE_CODES["1729"]["unit"] = "99"

    TITLE_CODES["0880"] = {}
    TITLE_CODES["0880"]["title"] = "OMBUDSMAN-ACAD"
    TITLE_CODES["0880"]["program"] = "ACADEMIC"
    TITLE_CODES["0880"]["unit"] = "99"

    TITLE_CODES["8652"] = {}
    TITLE_CODES["8652"]["title"] = "LAB MECHN SR"
    TITLE_CODES["8652"]["program"] = "PSS"
    TITLE_CODES["8652"]["unit"] = "TX"

    TITLE_CODES["1973"] = {}
    TITLE_CODES["1973"]["title"] = "ACT PROF-AY-1/9-B/E/E"
    TITLE_CODES["1973"]["program"] = "ACADEMIC"
    TITLE_CODES["1973"]["unit"] = "A3"

    TITLE_CODES["9622"] = {}
    TITLE_CODES["9622"]["title"] = "SCANNER 2"
    TITLE_CODES["9622"]["program"] = "PSS"
    TITLE_CODES["9622"]["unit"] = "TX"

    TITLE_CODES["1972"] = {}
    TITLE_CODES["1972"]["title"] = "ACT PROF-FY-B/E/E"
    TITLE_CODES["1972"]["program"] = "ACADEMIC"
    TITLE_CODES["1972"]["unit"] = "A3"

    TITLE_CODES["5216"] = {}
    TITLE_CODES["5216"]["title"] = "PUBL SAFETY DISPATCHER"
    TITLE_CODES["5216"]["program"] = "PSS"
    TITLE_CODES["5216"]["unit"] = "CX"

    TITLE_CODES["9059"] = {}
    TITLE_CODES["9059"]["title"] = "EEG TCHNO PRN"
    TITLE_CODES["9059"]["program"] = "PSS"
    TITLE_CODES["9059"]["unit"] = "EX"

    TITLE_CODES["5215"] = {}
    TITLE_CODES["5215"]["title"] = "PUBL SAFETY DISPATCHER AST"
    TITLE_CODES["5215"]["program"] = "PSS"
    TITLE_CODES["5215"]["unit"] = "CX"

    TITLE_CODES["5212"] = {}
    TITLE_CODES["5212"]["title"] = "FIRE FIGHTER STDT RSDT"
    TITLE_CODES["5212"]["program"] = "PSS"
    TITLE_CODES["5212"]["unit"] = "99"

    TITLE_CODES["1971"] = {}
    TITLE_CODES["1971"]["title"] = "ACT PROF-AY-B/E/E"
    TITLE_CODES["1971"]["program"] = "ACADEMIC"
    TITLE_CODES["1971"]["unit"] = "A3"

    TITLE_CODES["9148"] = {}
    TITLE_CODES["9148"]["title"] = "NURSE PRACTITIONER 1"
    TITLE_CODES["9148"]["program"] = "PSS"
    TITLE_CODES["9148"]["unit"] = "NX"

    TITLE_CODES["5211"] = {}
    TITLE_CODES["5211"]["title"] = "FIRE FIGHTER STDT RSDT SR"
    TITLE_CODES["5211"]["program"] = "PSS"
    TITLE_CODES["5211"]["unit"] = "99"

    TITLE_CODES["9050"] = {}
    TITLE_CODES["9050"]["title"] = "RESP THER 1"
    TITLE_CODES["9050"]["program"] = "PSS"
    TITLE_CODES["9050"]["unit"] = "EX"

    TITLE_CODES["9051"] = {}
    TITLE_CODES["9051"]["title"] = "REG RESP THER PD"
    TITLE_CODES["9051"]["program"] = "PSS"
    TITLE_CODES["9051"]["unit"] = "EX"

    TITLE_CODES["9052"] = {}
    TITLE_CODES["9052"]["title"] = "RESP THER PD"
    TITLE_CODES["9052"]["program"] = "PSS"
    TITLE_CODES["9052"]["unit"] = "EX"

    TITLE_CODES["4014"] = {}
    TITLE_CODES["4014"]["title"] = "INTERCOL ATH COACH AST NEX"
    TITLE_CODES["4014"]["program"] = "PSS"
    TITLE_CODES["4014"]["unit"] = "99"

    TITLE_CODES["5218"] = {}
    TITLE_CODES["5218"]["title"] = "PUBL SAFETY DISPATCHER SUPV"
    TITLE_CODES["5218"]["program"] = "PSS"
    TITLE_CODES["5218"]["unit"] = "99"

    TITLE_CODES["3230"] = {}
    TITLE_CODES["3230"]["title"] = "FLD PROG SUPV"
    TITLE_CODES["3230"]["program"] = "ACADEMIC"
    TITLE_CODES["3230"]["unit"] = "FX"

    TITLE_CODES["3128"] = {}
    TITLE_CODES["3128"]["title"] = "VISITING ASST ASTRONOMER"
    TITLE_CODES["3128"]["program"] = "ACADEMIC"
    TITLE_CODES["3128"]["unit"] = "99"

    TITLE_CODES["1968"] = {}
    TITLE_CODES["1968"]["title"] = "REGENTS' LECT"
    TITLE_CODES["1968"]["program"] = "ACADEMIC"
    TITLE_CODES["1968"]["unit"] = "99"

    TITLE_CODES["1969"] = {}
    TITLE_CODES["1969"]["title"] = "HHMI INVESTIGATOR"
    TITLE_CODES["1969"]["program"] = "ACADEMIC"
    TITLE_CODES["1969"]["unit"] = "99"

    TITLE_CODES["1618"] = {}
    TITLE_CODES["1618"]["title"] = "LECT SOE-HCOMP"
    TITLE_CODES["1618"]["program"] = "ACADEMIC"
    TITLE_CODES["1618"]["unit"] = "A3"

    TITLE_CODES["1619"] = {}
    TITLE_CODES["1619"]["title"] = "SR LECT SOE-HCOMP"
    TITLE_CODES["1619"]["program"] = "ACADEMIC"
    TITLE_CODES["1619"]["unit"] = "A3"

    TITLE_CODES["1617"] = {}
    TITLE_CODES["1617"]["title"] = "LECT SOE-FY"
    TITLE_CODES["1617"]["program"] = "ACADEMIC"
    TITLE_CODES["1617"]["unit"] = "A3"

    TITLE_CODES["3238"] = {}
    TITLE_CODES["3238"]["title"] = "FACULTY FELLOW RES-AY-1/9"
    TITLE_CODES["3238"]["program"] = "ACADEMIC"
    TITLE_CODES["3238"]["unit"] = "FX"

    TITLE_CODES["1615"] = {}
    TITLE_CODES["1615"]["title"] = "LECT PSOE-FY-PART TIME"
    TITLE_CODES["1615"]["program"] = "ACADEMIC"
    TITLE_CODES["1615"]["unit"] = "IX"

    TITLE_CODES["9621"] = {}
    TITLE_CODES["9621"]["title"] = "SCANNER 1 SUPV"
    TITLE_CODES["9621"]["program"] = "PSS"
    TITLE_CODES["9621"]["unit"] = "99"

    TITLE_CODES["1613"] = {}
    TITLE_CODES["1613"]["title"] = "SR LECT SOE-FY"
    TITLE_CODES["1613"]["program"] = "ACADEMIC"
    TITLE_CODES["1613"]["unit"] = "A3"

    TITLE_CODES["1610"] = {}
    TITLE_CODES["1610"]["title"] = "SR LECT PSOE-FY-PART TIME"
    TITLE_CODES["1610"]["program"] = "ACADEMIC"
    TITLE_CODES["1610"]["unit"] = "IX"

    TITLE_CODES["8927"] = {}
    TITLE_CODES["8927"]["title"] = "ORTHOPEDIC TCHN PRN"
    TITLE_CODES["8927"]["program"] = "PSS"
    TITLE_CODES["8927"]["unit"] = "EX"

    TITLE_CODES["8926"] = {}
    TITLE_CODES["8926"]["title"] = "PSYCHIATRIC TCHN"
    TITLE_CODES["8926"]["program"] = "PSS"
    TITLE_CODES["8926"]["unit"] = "EX"

    TITLE_CODES["8925"] = {}
    TITLE_CODES["8925"]["title"] = "PSYCHIATRIC TCHN SR"
    TITLE_CODES["8925"]["program"] = "PSS"
    TITLE_CODES["8925"]["unit"] = "EX"

    TITLE_CODES["8924"] = {}
    TITLE_CODES["8924"]["title"] = "PSYCHIATRIC TCHN PD"
    TITLE_CODES["8924"]["program"] = "PSS"
    TITLE_CODES["8924"]["unit"] = "EX"

    TITLE_CODES["9149"] = {}
    TITLE_CODES["9149"]["title"] = "NURSE PRACTITIONER SUPV 3"
    TITLE_CODES["9149"]["program"] = "PSS"
    TITLE_CODES["9149"]["unit"] = "99"

    TITLE_CODES["8920"] = {}
    TITLE_CODES["8920"]["title"] = "EMERGENCY TRAUMA TCHN"
    TITLE_CODES["8920"]["program"] = "PSS"
    TITLE_CODES["8920"]["unit"] = "EX"

    TITLE_CODES["8841"] = {}
    TITLE_CODES["8841"]["title"] = "LIBRARY BOOKBINDER PROD LD"
    TITLE_CODES["8841"]["program"] = "PSS"
    TITLE_CODES["8841"]["unit"] = "99"

    TITLE_CODES["8842"] = {}
    TITLE_CODES["8842"]["title"] = "LIBRARY BOOKBINDER PRN"
    TITLE_CODES["8842"]["program"] = "PSS"
    TITLE_CODES["8842"]["unit"] = "GS"

    TITLE_CODES["8843"] = {}
    TITLE_CODES["8843"]["title"] = "LIBRARY BOOKBINDER SR"
    TITLE_CODES["8843"]["program"] = "PSS"
    TITLE_CODES["8843"]["unit"] = "GS"

    TITLE_CODES["8844"] = {}
    TITLE_CODES["8844"]["title"] = "LIBRARY BOOKBINDER"
    TITLE_CODES["8844"]["program"] = "PSS"
    TITLE_CODES["8844"]["unit"] = "GS"

    TITLE_CODES["8845"] = {}
    TITLE_CODES["8845"]["title"] = "LIBRARY BOOKBINDER AST"
    TITLE_CODES["8845"]["program"] = "PSS"
    TITLE_CODES["8845"]["unit"] = "GS"

    TITLE_CODES["8846"] = {}
    TITLE_CODES["8846"]["title"] = "LIBRARY BOOKBINDER SR SUPV"
    TITLE_CODES["8846"]["program"] = "PSS"
    TITLE_CODES["8846"]["unit"] = "99"

    TITLE_CODES["8917"] = {}
    TITLE_CODES["8917"]["title"] = "VOC NURSE"
    TITLE_CODES["8917"]["program"] = "PSS"
    TITLE_CODES["8917"]["unit"] = "EX"

    TITLE_CODES["0775"] = {}
    TITLE_CODES["0775"]["title"] = "DENTIST DIPLOMATE ASC"
    TITLE_CODES["0775"]["program"] = "MSP"
    TITLE_CODES["0775"]["unit"] = "99"

    TITLE_CODES["0774"] = {}
    TITLE_CODES["0774"]["title"] = "DENTIST SR"
    TITLE_CODES["0774"]["program"] = "MSP"
    TITLE_CODES["0774"]["unit"] = "99"

    TITLE_CODES["0777"] = {}
    TITLE_CODES["0777"]["title"] = "DENTIST AST"
    TITLE_CODES["0777"]["program"] = "MSP"
    TITLE_CODES["0777"]["unit"] = "99"

    TITLE_CODES["0776"] = {}
    TITLE_CODES["0776"]["title"] = "DENTIST ASC"
    TITLE_CODES["0776"]["program"] = "MSP"
    TITLE_CODES["0776"]["unit"] = "99"

    TITLE_CODES["0771"] = {}
    TITLE_CODES["0771"]["title"] = "ASC PHYSCN"
    TITLE_CODES["0771"]["program"] = "MSP"
    TITLE_CODES["0771"]["unit"] = "99"

    TITLE_CODES["0770"] = {}
    TITLE_CODES["0770"]["title"] = "ASC PHYSCN DIPLOMATE"
    TITLE_CODES["0770"]["program"] = "MSP"
    TITLE_CODES["0770"]["unit"] = "99"

    TITLE_CODES["0773"] = {}
    TITLE_CODES["0773"]["title"] = "DENTIST DIPLOMATE SR"
    TITLE_CODES["0773"]["program"] = "MSP"
    TITLE_CODES["0773"]["unit"] = "99"

    TITLE_CODES["0772"] = {}
    TITLE_CODES["0772"]["title"] = "AST PHYSCN"
    TITLE_CODES["0772"]["program"] = "MSP"
    TITLE_CODES["0772"]["unit"] = "99"

    TITLE_CODES["0779"] = {}
    TITLE_CODES["0779"]["title"] = "STAFF PHYSCN"
    TITLE_CODES["0779"]["program"] = "MSP"
    TITLE_CODES["0779"]["unit"] = "99"

    TITLE_CODES["0778"] = {}
    TITLE_CODES["0778"]["title"] = "CONSULTING PHYSCN SHS"
    TITLE_CODES["0778"]["program"] = "MSP"
    TITLE_CODES["0778"]["unit"] = "99"

    TITLE_CODES["9338"] = {}
    TITLE_CODES["9338"]["title"] = "VOLUNTEER SVC CRD 1"
    TITLE_CODES["9338"]["program"] = "PSS"
    TITLE_CODES["9338"]["unit"] = "EX"

    TITLE_CODES["7100"] = {}
    TITLE_CODES["7100"]["title"] = "DRAFTING TCHN PRN SUPV"
    TITLE_CODES["7100"]["program"] = "PSS"
    TITLE_CODES["7100"]["unit"] = "99"

    TITLE_CODES["7101"] = {}
    TITLE_CODES["7101"]["title"] = "DRAFTING TCHN PRN"
    TITLE_CODES["7101"]["program"] = "PSS"
    TITLE_CODES["7101"]["unit"] = "TX"

    TITLE_CODES["7102"] = {}
    TITLE_CODES["7102"]["title"] = "DRAFTING TCHN SR"
    TITLE_CODES["7102"]["program"] = "PSS"
    TITLE_CODES["7102"]["unit"] = "TX"

    TITLE_CODES["7103"] = {}
    TITLE_CODES["7103"]["title"] = "DRAFTING TCHN"
    TITLE_CODES["7103"]["program"] = "PSS"
    TITLE_CODES["7103"]["unit"] = "TX"

    TITLE_CODES["3351"] = {}
    TITLE_CODES["3351"]["title"] = "ASST PROF IN RES-AY-1/9"
    TITLE_CODES["3351"]["program"] = "ACADEMIC"
    TITLE_CODES["3351"]["unit"] = "A3"

    TITLE_CODES["3350"] = {}
    TITLE_CODES["3350"]["title"] = "INSTR IN RSDNC-ACAD YR-1/9TH"
    TITLE_CODES["3350"]["program"] = "ACADEMIC"
    TITLE_CODES["3350"]["unit"] = "A3"

    TITLE_CODES["0071"] = {}
    TITLE_CODES["0071"]["title"] = "FINANCIAL OFCR"
    TITLE_CODES["0071"]["program"] = "MSP"
    TITLE_CODES["0071"]["unit"] = "99"

    TITLE_CODES["0070"] = {}
    TITLE_CODES["0070"]["title"] = "AST TREASURER FUNC AREA"
    TITLE_CODES["0070"]["program"] = "MSP"
    TITLE_CODES["0070"]["unit"] = "99"

    TITLE_CODES["7661"] = {}
    TITLE_CODES["7661"]["title"] = "PERSONNEL ANL PRN"
    TITLE_CODES["7661"]["program"] = "PSS"
    TITLE_CODES["7661"]["unit"] = "99"

    TITLE_CODES["7660"] = {}
    TITLE_CODES["7660"]["title"] = "PERSONNEL ANL SUPV EX"
    TITLE_CODES["7660"]["program"] = "PSS"
    TITLE_CODES["7660"]["unit"] = "99"

    TITLE_CODES["7663"] = {}
    TITLE_CODES["7663"]["title"] = "PERSONNEL ANL"
    TITLE_CODES["7663"]["program"] = "PSS"
    TITLE_CODES["7663"]["unit"] = "99"

    TITLE_CODES["7662"] = {}
    TITLE_CODES["7662"]["title"] = "PERSONNEL ANL SR"
    TITLE_CODES["7662"]["program"] = "PSS"
    TITLE_CODES["7662"]["unit"] = "99"

    TITLE_CODES["9104"] = {}
    TITLE_CODES["9104"]["title"] = "RESP THER 3 SUPV"
    TITLE_CODES["9104"]["program"] = "PSS"
    TITLE_CODES["9104"]["unit"] = "99"

    TITLE_CODES["7664"] = {}
    TITLE_CODES["7664"]["title"] = "PERSONNEL ANL AST"
    TITLE_CODES["7664"]["program"] = "PSS"
    TITLE_CODES["7664"]["unit"] = "99"

    TITLE_CODES["3050"] = {}
    TITLE_CODES["3050"]["title"] = "ASSOC IN ------- IN THE A.E.S."
    TITLE_CODES["3050"]["program"] = "ACADEMIC"
    TITLE_CODES["3050"]["unit"] = "FX"

    TITLE_CODES["7666"] = {}
    TITLE_CODES["7666"]["title"] = "PARALEGAL SPEC SR"
    TITLE_CODES["7666"]["program"] = "PSS"
    TITLE_CODES["7666"]["unit"] = "99"

    TITLE_CODES["1040"] = {}
    TITLE_CODES["1040"]["title"] = "DEAN-EXTENDED LEARNING"
    TITLE_CODES["1040"]["program"] = "ACADEMIC"
    TITLE_CODES["1040"]["unit"] = "99"

    TITLE_CODES["1047"] = {}
    TITLE_CODES["1047"]["title"] = "ACT/INTERIM COLLEGE PROVOST"
    TITLE_CODES["1047"]["program"] = "ACADEMIC"
    TITLE_CODES["1047"]["unit"] = "99"

    TITLE_CODES["1045"] = {}
    TITLE_CODES["1045"]["title"] = "FACULTY ASST TO VICE CHANC"
    TITLE_CODES["1045"]["program"] = "ACADEMIC"
    TITLE_CODES["1045"]["unit"] = "99"

    TITLE_CODES["1044"] = {}
    TITLE_CODES["1044"]["title"] = "FACULTY ASST TO CHANC"
    TITLE_CODES["1044"]["program"] = "ACADEMIC"
    TITLE_CODES["1044"]["unit"] = "99"

    TITLE_CODES["5443"] = {}
    TITLE_CODES["5443"]["title"] = "FOOD SVC MGR SR"
    TITLE_CODES["5443"]["program"] = "PSS"
    TITLE_CODES["5443"]["unit"] = "99"

    TITLE_CODES["5442"] = {}
    TITLE_CODES["5442"]["title"] = "FOOD SVC MGR PRN"
    TITLE_CODES["5442"]["program"] = "PSS"
    TITLE_CODES["5442"]["unit"] = "99"

    TITLE_CODES["3381"] = {}
    TITLE_CODES["3381"]["title"] = "PROF IN RES-AY-B/E/E"
    TITLE_CODES["3381"]["program"] = "ACADEMIC"
    TITLE_CODES["3381"]["unit"] = "A3"

    TITLE_CODES["5447"] = {}
    TITLE_CODES["5447"]["title"] = "FOOD SVC MGR AST SUPV"
    TITLE_CODES["5447"]["program"] = "PSS"
    TITLE_CODES["5447"]["unit"] = "99"

    TITLE_CODES["5445"] = {}
    TITLE_CODES["5445"]["title"] = "FOOD SVC MGR AST"
    TITLE_CODES["5445"]["program"] = "PSS"
    TITLE_CODES["5445"]["unit"] = "SX"

    TITLE_CODES["3981"] = {}
    TITLE_CODES["3981"]["title"] = "STATE SAL DIFF-XMURAL-LPNI/NPI"
    TITLE_CODES["3981"]["program"] = "ACADEMIC"
    TITLE_CODES["3981"]["unit"] = "87"

    TITLE_CODES["1681"] = {}
    TITLE_CODES["1681"]["title"] = "LECT PSOE-AY-1/9-100%"
    TITLE_CODES["1681"]["program"] = "ACADEMIC"
    TITLE_CODES["1681"]["unit"] = "A3"

    TITLE_CODES["1680"] = {}
    TITLE_CODES["1680"]["title"] = "LECT PSOE-AY-100%"
    TITLE_CODES["1680"]["program"] = "ACADEMIC"
    TITLE_CODES["1680"]["unit"] = "A3"

    TITLE_CODES["1683"] = {}
    TITLE_CODES["1683"]["title"] = "SR LECT PSOE-AY-100%"
    TITLE_CODES["1683"]["program"] = "ACADEMIC"
    TITLE_CODES["1683"]["unit"] = "A3"

    TITLE_CODES["1682"] = {}
    TITLE_CODES["1682"]["title"] = "LECT PSOE-FY-100%"
    TITLE_CODES["1682"]["program"] = "ACADEMIC"
    TITLE_CODES["1682"]["unit"] = "A3"

    TITLE_CODES["1685"] = {}
    TITLE_CODES["1685"]["title"] = "SR LECT PSOE-FY-100%"
    TITLE_CODES["1685"]["program"] = "ACADEMIC"
    TITLE_CODES["1685"]["unit"] = "A3"

    TITLE_CODES["1684"] = {}
    TITLE_CODES["1684"]["title"] = "SR LECT PSOE-AY-1/9-100%"
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
    TITLE_CODES["6961"]["title"] = "EDUC FAC PLANNER SR SUPV"
    TITLE_CODES["6961"]["program"] = "PSS"
    TITLE_CODES["6961"]["unit"] = "99"

    TITLE_CODES["1143"] = {}
    TITLE_CODES["1143"]["title"] = "PROF-AY-B/E/E"
    TITLE_CODES["1143"]["program"] = "ACADEMIC"
    TITLE_CODES["1143"]["unit"] = "A3"

    TITLE_CODES["6963"] = {}
    TITLE_CODES["6963"]["title"] = "EDUC FAC PLANNER"
    TITLE_CODES["6963"]["program"] = "PSS"
    TITLE_CODES["6963"]["unit"] = "99"

    TITLE_CODES["6962"] = {}
    TITLE_CODES["6962"]["title"] = "EDUC FAC PLANNER SR"
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
    TITLE_CODES["1144"]["title"] = "PROF-FY-B/E/E"
    TITLE_CODES["1144"]["program"] = "ACADEMIC"
    TITLE_CODES["1144"]["unit"] = "A3"

    TITLE_CODES["1145"] = {}
    TITLE_CODES["1145"]["title"] = "PROF-AY-1/9-B/E/E"
    TITLE_CODES["1145"]["program"] = "ACADEMIC"
    TITLE_CODES["1145"]["unit"] = "A3"

    TITLE_CODES["6969"] = {}
    TITLE_CODES["6969"]["title"] = "PLANNER AST"
    TITLE_CODES["6969"]["program"] = "PSS"
    TITLE_CODES["6969"]["unit"] = "99"

    TITLE_CODES["6968"] = {}
    TITLE_CODES["6968"]["title"] = "PLANNER ASC"
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
    TITLE_CODES["8259"]["title"] = "PLUMBER APPR"
    TITLE_CODES["8259"]["program"] = "PSS"
    TITLE_CODES["8259"]["unit"] = "K3"

    TITLE_CODES["8153"] = {}
    TITLE_CODES["8153"]["title"] = "GARDENER GROUNDSKEEPER"
    TITLE_CODES["8153"]["program"] = "PSS"
    TITLE_CODES["8153"]["unit"] = "SX"

    TITLE_CODES["8150"] = {}
    TITLE_CODES["8150"]["title"] = "INSP PLANNER EST SR"
    TITLE_CODES["8150"]["program"] = "PSS"
    TITLE_CODES["8150"]["unit"] = "K3"

    TITLE_CODES["8151"] = {}
    TITLE_CODES["8151"]["title"] = "INSP PLANNER EST"
    TITLE_CODES["8151"]["program"] = "PSS"
    TITLE_CODES["8151"]["unit"] = "K3"

    TITLE_CODES["9623"] = {}
    TITLE_CODES["9623"]["title"] = "SCANNER 1"
    TITLE_CODES["9623"]["program"] = "PSS"
    TITLE_CODES["9623"]["unit"] = "TX"

    TITLE_CODES["3388"] = {}
    TITLE_CODES["3388"]["title"] = "ASST PROF IN RES-FY-B/E/E"
    TITLE_CODES["3388"]["program"] = "ACADEMIC"
    TITLE_CODES["3388"]["unit"] = "A3"

    TITLE_CODES["3286"] = {}
    TITLE_CODES["3286"]["title"] = "GSR-TUIT & FEE REM-UCSD-GRP C"
    TITLE_CODES["3286"]["program"] = "ACADEMIC"
    TITLE_CODES["3286"]["unit"] = "99"

    TITLE_CODES["3389"] = {}
    TITLE_CODES["3389"]["title"] = "ASST PROF IN RES-AY-1/9-B/E/E"
    TITLE_CODES["3389"]["program"] = "ACADEMIC"
    TITLE_CODES["3389"]["unit"] = "A3"

    TITLE_CODES["5502"] = {}
    TITLE_CODES["5502"]["title"] = "BAKER SR"
    TITLE_CODES["5502"]["program"] = "PSS"
    TITLE_CODES["5502"]["unit"] = "SX"

    TITLE_CODES["5100"] = {}
    TITLE_CODES["5100"]["title"] = "CUSTODIAN PD"
    TITLE_CODES["5100"]["program"] = "PSS"
    TITLE_CODES["5100"]["unit"] = "SX"

    TITLE_CODES["5501"] = {}
    TITLE_CODES["5501"]["title"] = "BAKER PRN"
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
    TITLE_CODES["1542"]["title"] = "ACT PROF-HCOMP"
    TITLE_CODES["1542"]["program"] = "ACADEMIC"
    TITLE_CODES["1542"]["unit"] = "A3"

    TITLE_CODES["1543"] = {}
    TITLE_CODES["1543"]["title"] = "INSTRUCTOR IN RES-GENCOMP-A"
    TITLE_CODES["1543"]["program"] = "ACADEMIC"
    TITLE_CODES["1543"]["unit"] = "A3"

    TITLE_CODES["1540"] = {}
    TITLE_CODES["1540"]["title"] = "ACT ASSOC PROF-HCOMP"
    TITLE_CODES["1540"]["program"] = "ACADEMIC"
    TITLE_CODES["1540"]["unit"] = "A3"

    TITLE_CODES["1541"] = {}
    TITLE_CODES["1541"]["title"] = "PROFESSOR-GENCOMP-A"
    TITLE_CODES["1541"]["program"] = "ACADEMIC"
    TITLE_CODES["1541"]["unit"] = "A3"

    TITLE_CODES["7614"] = {}
    TITLE_CODES["7614"]["title"] = "ACCOUNTANT 3 SUPV"
    TITLE_CODES["7614"]["program"] = "PSS"
    TITLE_CODES["7614"]["unit"] = "99"

    TITLE_CODES["7615"] = {}
    TITLE_CODES["7615"]["title"] = "ACCOUNTANT 5"
    TITLE_CODES["7615"]["program"] = "PSS"
    TITLE_CODES["7615"]["unit"] = "99"

    TITLE_CODES["3120"] = {}
    TITLE_CODES["3120"]["title"] = "ASSISTANT ASTRONOMER"
    TITLE_CODES["3120"]["program"] = "ACADEMIC"
    TITLE_CODES["3120"]["unit"] = "FX"

    TITLE_CODES["7617"] = {}
    TITLE_CODES["7617"]["title"] = "ACCOUNTANT 3"
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
    TITLE_CODES["1317"]["title"] = "ACT ASST PROF-FY"
    TITLE_CODES["1317"]["program"] = "ACADEMIC"
    TITLE_CODES["1317"]["unit"] = "99"

    TITLE_CODES["1783"] = {}
    TITLE_CODES["1783"]["title"] = "INSTRUCTOR IN RES-FY-MEDCOMP"
    TITLE_CODES["1783"]["program"] = "ACADEMIC"
    TITLE_CODES["1783"]["unit"] = "A3"

    TITLE_CODES["9222"] = {}
    TITLE_CODES["9222"]["title"] = "CTRL STERILE TCHN 3 PD"
    TITLE_CODES["9222"]["program"] = "PSS"
    TITLE_CODES["9222"]["unit"] = "EX"

    TITLE_CODES["1310"] = {}
    TITLE_CODES["1310"]["title"] = "ASST PROF-FY"
    TITLE_CODES["1310"]["program"] = "ACADEMIC"
    TITLE_CODES["1310"]["unit"] = "A3"

    TITLE_CODES["9610"] = {}
    TITLE_CODES["9610"]["title"] = "SRA 4"
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
    TITLE_CODES["6447"]["title"] = "PRG REPR 3 SUPV"
    TITLE_CODES["6447"]["program"] = "PSS"
    TITLE_CODES["6447"]["unit"] = "99"

    TITLE_CODES["8028"] = {}
    TITLE_CODES["8028"]["title"] = "SPEECH PATHOLOGIST SR SUPV"
    TITLE_CODES["8028"]["program"] = "PSS"
    TITLE_CODES["8028"]["unit"] = "99"

    TITLE_CODES["6910"] = {}
    TITLE_CODES["6910"]["title"] = "CUSTOMER SVC REPR SUPV"
    TITLE_CODES["6910"]["program"] = "PSS"
    TITLE_CODES["6910"]["unit"] = "99"

    TITLE_CODES["1786"] = {}
    TITLE_CODES["1786"]["title"] = "PROF IN RES-FY-MEDCOMP"
    TITLE_CODES["1786"]["program"] = "ACADEMIC"
    TITLE_CODES["1786"]["unit"] = "A3"

    TITLE_CODES["8022"] = {}
    TITLE_CODES["8022"]["title"] = "REHAB SVC ASC CHF SUPV"
    TITLE_CODES["8022"]["program"] = "PSS"
    TITLE_CODES["8022"]["unit"] = "99"

    TITLE_CODES["8023"] = {}
    TITLE_CODES["8023"]["title"] = "ATH TRAINER SUPV"
    TITLE_CODES["8023"]["program"] = "PSS"
    TITLE_CODES["8023"]["unit"] = "99"

    TITLE_CODES["8020"] = {}
    TITLE_CODES["8020"]["title"] = "PSYCHOLOGIST 1 SUPV"
    TITLE_CODES["8020"]["program"] = "PSS"
    TITLE_CODES["8020"]["unit"] = "99"

    TITLE_CODES["1787"] = {}
    TITLE_CODES["1787"]["title"] = "ADJUNCT INSTRUCTOR-FY-MEDCOMP"
    TITLE_CODES["1787"]["program"] = "ACADEMIC"
    TITLE_CODES["1787"]["unit"] = "99"

    TITLE_CODES["7183"] = {}
    TITLE_CODES["7183"]["title"] = "DEV ENGR AST"
    TITLE_CODES["7183"]["program"] = "PSS"
    TITLE_CODES["7183"]["unit"] = "99"

    TITLE_CODES["8027"] = {}
    TITLE_CODES["8027"]["title"] = "SPEECH PATHOLOGIST SUPV"
    TITLE_CODES["8027"]["program"] = "PSS"
    TITLE_CODES["8027"]["unit"] = "99"

    TITLE_CODES["6448"] = {}
    TITLE_CODES["6448"]["title"] = "PRG REPR 2 SUPV"
    TITLE_CODES["6448"]["program"] = "PSS"
    TITLE_CODES["6448"]["unit"] = "99"

    TITLE_CODES["8025"] = {}
    TITLE_CODES["8025"]["title"] = "RECREATION THER 1 SUPV"
    TITLE_CODES["8025"]["program"] = "PSS"
    TITLE_CODES["8025"]["unit"] = "99"

    TITLE_CODES["7113"] = {}
    TITLE_CODES["7113"]["title"] = "TELEVISION ENGR"
    TITLE_CODES["7113"]["program"] = "PSS"
    TITLE_CODES["7113"]["unit"] = "TX"

    TITLE_CODES["1400"] = {}
    TITLE_CODES["1400"]["title"] = "INSTRUCTOR-ACADEMIC YEAR"
    TITLE_CODES["1400"]["program"] = "ACADEMIC"
    TITLE_CODES["1400"]["unit"] = "A3"

    TITLE_CODES["5421"] = {}
    TITLE_CODES["5421"]["title"] = "DIETITIAN PD"
    TITLE_CODES["5421"]["program"] = "PSS"
    TITLE_CODES["5421"]["unit"] = "HX"

    TITLE_CODES["9316"] = {}
    TITLE_CODES["9316"]["title"] = "CLIN SOCIAL WORKER 2 PD"
    TITLE_CODES["9316"]["program"] = "PSS"
    TITLE_CODES["9316"]["unit"] = "HX"

    TITLE_CODES["7686"] = {}
    TITLE_CODES["7686"]["title"] = "EDITOR SR SUPV"
    TITLE_CODES["7686"]["program"] = "PSS"
    TITLE_CODES["7686"]["unit"] = "99"

    TITLE_CODES["7685"] = {}
    TITLE_CODES["7685"]["title"] = "EDITOR AST"
    TITLE_CODES["7685"]["program"] = "PSS"
    TITLE_CODES["7685"]["unit"] = "TX"

    TITLE_CODES["7684"] = {}
    TITLE_CODES["7684"]["title"] = "EDITOR"
    TITLE_CODES["7684"]["program"] = "PSS"
    TITLE_CODES["7684"]["unit"] = "TX"

    TITLE_CODES["7683"] = {}
    TITLE_CODES["7683"]["title"] = "EDITOR SR"
    TITLE_CODES["7683"]["program"] = "PSS"
    TITLE_CODES["7683"]["unit"] = "99"

    TITLE_CODES["7682"] = {}
    TITLE_CODES["7682"]["title"] = "EDITOR PRN"
    TITLE_CODES["7682"]["program"] = "PSS"
    TITLE_CODES["7682"]["unit"] = "99"

    TITLE_CODES["7681"] = {}
    TITLE_CODES["7681"]["title"] = "EDITOR SUPV"
    TITLE_CODES["7681"]["program"] = "PSS"
    TITLE_CODES["7681"]["unit"] = "99"

    TITLE_CODES["7680"] = {}
    TITLE_CODES["7680"]["title"] = "EDITOR PRN SUPV"
    TITLE_CODES["7680"]["program"] = "PSS"
    TITLE_CODES["7680"]["unit"] = "99"

    TITLE_CODES["9236"] = {}
    TITLE_CODES["9236"]["title"] = "PHARMACIST GRAD INTERN"
    TITLE_CODES["9236"]["program"] = "PSS"
    TITLE_CODES["9236"]["unit"] = "99"

    TITLE_CODES["2265"] = {}
    TITLE_CODES["2265"]["title"] = "FLD WK CONSULT-FY"
    TITLE_CODES["2265"]["program"] = "ACADEMIC"
    TITLE_CODES["2265"]["unit"] = "IX"

    TITLE_CODES["9155"] = {}
    TITLE_CODES["9155"]["title"] = "BIOMED EQUIP TCHN 3"
    TITLE_CODES["9155"]["program"] = "PSS"
    TITLE_CODES["9155"]["unit"] = "EX"

    TITLE_CODES["8041"] = {}
    TITLE_CODES["8041"]["title"] = "NUC MED TCHNO ASC CHF SUPV"
    TITLE_CODES["8041"]["program"] = "PSS"
    TITLE_CODES["8041"]["unit"] = "99"

    TITLE_CODES["7214"] = {}
    TITLE_CODES["7214"]["title"] = "STATISTICIAN AST"
    TITLE_CODES["7214"]["program"] = "PSS"
    TITLE_CODES["7214"]["unit"] = "99"

    TITLE_CODES["8329"] = {}
    TITLE_CODES["8329"]["title"] = "OPS MECH LD"
    TITLE_CODES["8329"]["program"] = "PSS"
    TITLE_CODES["8329"]["unit"] = "K3"

    TITLE_CODES["4211"] = {}
    TITLE_CODES["4211"]["title"] = "PLACEMENT INTERVIEWER PRN"
    TITLE_CODES["4211"]["program"] = "PSS"
    TITLE_CODES["4211"]["unit"] = "99"

    TITLE_CODES["6283"] = {}
    TITLE_CODES["6283"]["title"] = "HOUSE MGR 1"
    TITLE_CODES["6283"]["program"] = "PSS"
    TITLE_CODES["6283"]["unit"] = "99"

    TITLE_CODES["9288"] = {}
    TITLE_CODES["9288"]["title"] = "COUNSELOR"
    TITLE_CODES["9288"]["program"] = "PSS"
    TITLE_CODES["9288"]["unit"] = "HX"

    TITLE_CODES["9150"] = {}
    TITLE_CODES["9150"]["title"] = "NURSE PRACTITIONER SUPV 2"
    TITLE_CODES["9150"]["program"] = "PSS"
    TITLE_CODES["9150"]["unit"] = "99"

    TITLE_CODES["8046"] = {}
    TITLE_CODES["8046"]["title"] = "HOSP RAD PHYSICIST SUPV"
    TITLE_CODES["8046"]["program"] = "PSS"
    TITLE_CODES["8046"]["unit"] = "99"

    TITLE_CODES["4122"] = {}
    TITLE_CODES["4122"]["title"] = "RSDT ADVISOR"
    TITLE_CODES["4122"]["program"] = "PSS"
    TITLE_CODES["4122"]["unit"] = "99"

    TITLE_CODES["4121"] = {}
    TITLE_CODES["4121"]["title"] = "RSDT DIR 1"
    TITLE_CODES["4121"]["program"] = "PSS"
    TITLE_CODES["4121"]["unit"] = "99"

    TITLE_CODES["4120"] = {}
    TITLE_CODES["4120"]["title"] = "RSDT ADVISOR SUPV"
    TITLE_CODES["4120"]["program"] = "PSS"
    TITLE_CODES["4120"]["unit"] = "99"

    TITLE_CODES["8107"] = {}
    TITLE_CODES["8107"]["title"] = "PAINTER APPR"
    TITLE_CODES["8107"]["program"] = "PSS"
    TITLE_CODES["8107"]["unit"] = "K3"

    TITLE_CODES["4126"] = {}
    TITLE_CODES["4126"]["title"] = "RSDT AST"
    TITLE_CODES["4126"]["program"] = "PSS"
    TITLE_CODES["4126"]["unit"] = "99"

    TITLE_CODES["4125"] = {}
    TITLE_CODES["4125"]["title"] = "RSDT HEAD"
    TITLE_CODES["4125"]["program"] = "PSS"
    TITLE_CODES["4125"]["unit"] = "99"

    TITLE_CODES["4124"] = {}
    TITLE_CODES["4124"]["title"] = "RSDT AST SUPV"
    TITLE_CODES["4124"]["program"] = "PSS"
    TITLE_CODES["4124"]["unit"] = "99"

    TITLE_CODES["9524"] = {}
    TITLE_CODES["9524"]["title"] = "ANIMAL TCHN SR"
    TITLE_CODES["9524"]["program"] = "PSS"
    TITLE_CODES["9524"]["unit"] = "TX"

    TITLE_CODES["7539"] = {}
    TITLE_CODES["7539"]["title"] = "AST TO BLANK 2 SUPV"
    TITLE_CODES["7539"]["program"] = "PSS"
    TITLE_CODES["7539"]["unit"] = "99"

    TITLE_CODES["7538"] = {}
    TITLE_CODES["7538"]["title"] = "AST TO BLANK 1 SUPV"
    TITLE_CODES["7538"]["program"] = "PSS"
    TITLE_CODES["7538"]["unit"] = "99"

    TITLE_CODES["9525"] = {}
    TITLE_CODES["9525"]["title"] = "ANIMAL TCHN"
    TITLE_CODES["9525"]["program"] = "PSS"
    TITLE_CODES["9525"]["unit"] = "TX"

    TITLE_CODES["0366"] = {}
    TITLE_CODES["0366"]["title"] = "ADM CRD OFCR AST"
    TITLE_CODES["0366"]["program"] = "MSP"
    TITLE_CODES["0366"]["unit"] = "99"

    TITLE_CODES["6213"] = {}
    TITLE_CODES["6213"]["title"] = "PRODUCER DIR SR"
    TITLE_CODES["6213"]["program"] = "PSS"
    TITLE_CODES["6213"]["unit"] = "TX"

    TITLE_CODES["6270"] = {}
    TITLE_CODES["6270"]["title"] = "USHER SUPV"
    TITLE_CODES["6270"]["program"] = "PSS"
    TITLE_CODES["6270"]["unit"] = "99"

    TITLE_CODES["0363"] = {}
    TITLE_CODES["0363"]["title"] = "ADM CRD OFCR ASC"
    TITLE_CODES["0363"]["program"] = "MSP"
    TITLE_CODES["0363"]["unit"] = "99"

    TITLE_CODES["6212"] = {}
    TITLE_CODES["6212"]["title"] = "PRODUCER DIR PRN"
    TITLE_CODES["6212"]["program"] = "PSS"
    TITLE_CODES["6212"]["unit"] = "99"

    TITLE_CODES["9255"] = {}
    TITLE_CODES["9255"]["title"] = "HOSP BLANK AST 3 SUPV"
    TITLE_CODES["9255"]["program"] = "PSS"
    TITLE_CODES["9255"]["unit"] = "99"

    TITLE_CODES["7246"] = {}
    TITLE_CODES["7246"]["title"] = "ANL 2 SUPV"
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
    TITLE_CODES["9521"]["title"] = "ANIMAL RESC MGR"
    TITLE_CODES["9521"]["program"] = "PSS"
    TITLE_CODES["9521"]["unit"] = "99"

    TITLE_CODES["0380"] = {}
    TITLE_CODES["0380"]["title"] = "DEAN"
    TITLE_CODES["0380"]["program"] = "MSP"
    TITLE_CODES["0380"]["unit"] = "99"

    TITLE_CODES["6677"] = {}
    TITLE_CODES["6677"]["title"] = "READER FOR THE BLIND"
    TITLE_CODES["6677"]["program"] = "PSS"
    TITLE_CODES["6677"]["unit"] = "TX"

    TITLE_CODES["0384"] = {}
    TITLE_CODES["0384"]["title"] = "DEAN AST"
    TITLE_CODES["0384"]["program"] = "MSP"
    TITLE_CODES["0384"]["unit"] = "99"

    TITLE_CODES["0385"] = {}
    TITLE_CODES["0385"]["title"] = "DEAN ASC"
    TITLE_CODES["0385"]["program"] = "MSP"
    TITLE_CODES["0385"]["unit"] = "99"

    TITLE_CODES["0386"] = {}
    TITLE_CODES["0386"]["title"] = "VICE PROVOST"
    TITLE_CODES["0386"]["program"] = "MSP"
    TITLE_CODES["0386"]["unit"] = "99"

    TITLE_CODES["0388"] = {}
    TITLE_CODES["0388"]["title"] = "PROVOST AST"
    TITLE_CODES["0388"]["program"] = "MSP"
    TITLE_CODES["0388"]["unit"] = "99"

    TITLE_CODES["9523"] = {}
    TITLE_CODES["9523"]["title"] = "ANIMAL TCHN PRN"
    TITLE_CODES["9523"]["program"] = "PSS"
    TITLE_CODES["9523"]["unit"] = "TX"

    TITLE_CODES["3215"] = {}
    TITLE_CODES["3215"]["title"] = "ASSOC RES-AY-1/9"
    TITLE_CODES["3215"]["program"] = "ACADEMIC"
    TITLE_CODES["3215"]["unit"] = "FX"

    TITLE_CODES["9611"] = {}
    TITLE_CODES["9611"]["title"] = "SRA 3"
    TITLE_CODES["9611"]["program"] = "PSS"
    TITLE_CODES["9611"]["unit"] = "RX"

    TITLE_CODES["9147"] = {}
    TITLE_CODES["9147"]["title"] = "NURSE PRACTITIONER 2"
    TITLE_CODES["9147"]["program"] = "PSS"
    TITLE_CODES["9147"]["unit"] = "NX"

    TITLE_CODES["7639"] = {}
    TITLE_CODES["7639"]["title"] = "EMPLOYMENT OFCR REPR SUPV"
    TITLE_CODES["7639"]["program"] = "PSS"
    TITLE_CODES["7639"]["unit"] = "99"

    TITLE_CODES["6776"] = {}
    TITLE_CODES["6776"]["title"] = "LIBRARY BOOKMENDER SR SUPV"
    TITLE_CODES["6776"]["program"] = "PSS"
    TITLE_CODES["6776"]["unit"] = "99"

    TITLE_CODES["6772"] = {}
    TITLE_CODES["6772"]["title"] = "LIBRARY BOOKMENDER SR"
    TITLE_CODES["6772"]["program"] = "PSS"
    TITLE_CODES["6772"]["unit"] = "SX"

    TITLE_CODES["6773"] = {}
    TITLE_CODES["6773"]["title"] = "LIBRARY BOOKMENDER"
    TITLE_CODES["6773"]["program"] = "PSS"
    TITLE_CODES["6773"]["unit"] = "SX"

    TITLE_CODES["6330"] = {}
    TITLE_CODES["6330"]["title"] = "THEATER PROD SUPV SR"
    TITLE_CODES["6330"]["program"] = "PSS"
    TITLE_CODES["6330"]["unit"] = "99"

    TITLE_CODES["3216"] = {}
    TITLE_CODES["3216"]["title"] = "ASSOC RES-SFT"
    TITLE_CODES["3216"]["program"] = "ACADEMIC"
    TITLE_CODES["3216"]["unit"] = "FX"

    TITLE_CODES["3610"] = {}
    TITLE_CODES["3610"]["title"] = "ASST UNIV LIBRARIAN"
    TITLE_CODES["3610"]["program"] = "ACADEMIC"
    TITLE_CODES["3610"]["unit"] = "99"

    TITLE_CODES["3612"] = {}
    TITLE_CODES["3612"]["title"] = "LIBRARIAN-CAREER STATUS"
    TITLE_CODES["3612"]["program"] = "ACADEMIC"
    TITLE_CODES["3612"]["unit"] = "LX"

    TITLE_CODES["3613"] = {}
    TITLE_CODES["3613"]["title"] = "LIBRARIAN-POTNTL CAREER STATUS"
    TITLE_CODES["3613"]["program"] = "ACADEMIC"
    TITLE_CODES["3613"]["unit"] = "LX"

    TITLE_CODES["3614"] = {}
    TITLE_CODES["3614"]["title"] = "LIBRARIAN-TEMP STATUS"
    TITLE_CODES["3614"]["program"] = "ACADEMIC"
    TITLE_CODES["3614"]["unit"] = "LX"

    TITLE_CODES["3615"] = {}
    TITLE_CODES["3615"]["title"] = "VIS LIBRARIAN"
    TITLE_CODES["3615"]["program"] = "ACADEMIC"
    TITLE_CODES["3615"]["unit"] = "99"

    TITLE_CODES["3616"] = {}
    TITLE_CODES["3616"]["title"] = "ASSOC LIBRARIAN -CAREER STATUS"
    TITLE_CODES["3616"]["program"] = "ACADEMIC"
    TITLE_CODES["3616"]["unit"] = "LX"

    TITLE_CODES["3617"] = {}
    TITLE_CODES["3617"]["title"] = "ASSOC LIBRARIAN-POTNTL CAREER"
    TITLE_CODES["3617"]["program"] = "ACADEMIC"
    TITLE_CODES["3617"]["unit"] = "LX"

    TITLE_CODES["3618"] = {}
    TITLE_CODES["3618"]["title"] = "ASSOC LIBRARIAN-TEMP STATUS"
    TITLE_CODES["3618"]["program"] = "ACADEMIC"
    TITLE_CODES["3618"]["unit"] = "LX"

    TITLE_CODES["1779"] = {}
    TITLE_CODES["1779"]["title"] = "ASSOCIATE PROFESSOR-FY-MEDCOMP"
    TITLE_CODES["1779"]["program"] = "ACADEMIC"
    TITLE_CODES["1779"]["unit"] = "A3"

    TITLE_CODES["2290"] = {}
    TITLE_CODES["2290"]["title"] = "REMD TUT II-NON GSHIP"
    TITLE_CODES["2290"]["program"] = "ACADEMIC"
    TITLE_CODES["2290"]["unit"] = "BX"

    TITLE_CODES["9241"] = {}
    TITLE_CODES["9241"]["title"] = "HOSP RAD PHYSICIST AST"
    TITLE_CODES["9241"]["program"] = "PSS"
    TITLE_CODES["9241"]["unit"] = "HX"

    TITLE_CODES["9237"] = {}
    TITLE_CODES["9237"]["title"] = "PHLEBOTOMIST PD"
    TITLE_CODES["9237"]["program"] = "PSS"
    TITLE_CODES["9237"]["unit"] = "EX"

    TITLE_CODES["9483"] = {}
    TITLE_CODES["9483"]["title"] = "PHYS THER 2 NEX"
    TITLE_CODES["9483"]["program"] = "PSS"
    TITLE_CODES["9483"]["unit"] = "99"

    TITLE_CODES["5131"] = {}
    TITLE_CODES["5131"]["title"] = "MED CTR FOOD SVC WORKER"
    TITLE_CODES["5131"]["program"] = "PSS"
    TITLE_CODES["5131"]["unit"] = "SX"

    TITLE_CODES["0259"] = {}
    TITLE_CODES["0259"]["title"] = "DIR AST"
    TITLE_CODES["0259"]["program"] = "MSP"
    TITLE_CODES["0259"]["unit"] = "99"

    TITLE_CODES["7054"] = {}
    TITLE_CODES["7054"]["title"] = "LANDSCAPE ARCHITECT AST"
    TITLE_CODES["7054"]["program"] = "PSS"
    TITLE_CODES["7054"]["unit"] = "99"

    TITLE_CODES["9482"] = {}
    TITLE_CODES["9482"]["title"] = "PHYS THER 3"
    TITLE_CODES["9482"]["program"] = "PSS"
    TITLE_CODES["9482"]["unit"] = "99"

    TITLE_CODES["0250"] = {}
    TITLE_CODES["0250"]["title"] = "DEPUTY DIR"
    TITLE_CODES["0250"]["program"] = "MSP"
    TITLE_CODES["0250"]["unit"] = "99"

    TITLE_CODES["0256"] = {}
    TITLE_CODES["0256"]["title"] = "DIR ASC"
    TITLE_CODES["0256"]["program"] = "MSP"
    TITLE_CODES["0256"]["unit"] = "99"

    TITLE_CODES["8125"] = {}
    TITLE_CODES["8125"]["title"] = "SHEETMETAL WORKER LD"
    TITLE_CODES["8125"]["program"] = "PSS"
    TITLE_CODES["8125"]["unit"] = "K3"

    TITLE_CODES["9480"] = {}
    TITLE_CODES["9480"]["title"] = "DIVISION ADM"
    TITLE_CODES["9480"]["program"] = "PSS"
    TITLE_CODES["9480"]["unit"] = "99"

    TITLE_CODES["9240"] = {}
    TITLE_CODES["9240"]["title"] = "HOSP RAD PHYSICIST EX"
    TITLE_CODES["9240"]["program"] = "PSS"
    TITLE_CODES["9240"]["unit"] = "HX"

    TITLE_CODES["5130"] = {}
    TITLE_CODES["5130"]["title"] = "MED CTR FOOD SVC WORKER SR"
    TITLE_CODES["5130"]["program"] = "PSS"
    TITLE_CODES["5130"]["unit"] = "SX"

    TITLE_CODES["9485"] = {}
    TITLE_CODES["9485"]["title"] = "PHYS THER PD"
    TITLE_CODES["9485"]["program"] = "PSS"
    TITLE_CODES["9485"]["unit"] = "99"

    TITLE_CODES["8139"] = {}
    TITLE_CODES["8139"]["title"] = "ELECTRN APPR"
    TITLE_CODES["8139"]["program"] = "PSS"
    TITLE_CODES["8139"]["unit"] = "K3"

    TITLE_CODES["3210"] = {}
    TITLE_CODES["3210"]["title"] = "ASSOC RES-FY"
    TITLE_CODES["3210"]["program"] = "ACADEMIC"
    TITLE_CODES["3210"]["unit"] = "FX"

    TITLE_CODES["6680"] = {}
    TITLE_CODES["6680"]["title"] = "DEAF TRANSLATOR INTERPRETER"
    TITLE_CODES["6680"]["program"] = "PSS"
    TITLE_CODES["6680"]["unit"] = "TX"

    TITLE_CODES["9484"] = {}
    TITLE_CODES["9484"]["title"] = "PHYS THER 1"
    TITLE_CODES["9484"]["program"] = "PSS"
    TITLE_CODES["9484"]["unit"] = "99"

    TITLE_CODES["2428"] = {}
    TITLE_CODES["2428"]["title"] = "SUBSTITUTE TEACHER-CONTINUING"
    TITLE_CODES["2428"]["program"] = "ACADEMIC"
    TITLE_CODES["2428"]["unit"] = "IX"

    TITLE_CODES["7291"] = {}
    TITLE_CODES["7291"]["title"] = "PROGR 2 SUPV"
    TITLE_CODES["7291"]["program"] = "PSS"
    TITLE_CODES["7291"]["unit"] = "99"

    TITLE_CODES["7292"] = {}
    TITLE_CODES["7292"]["title"] = "PROGR 3 SUPV"
    TITLE_CODES["7292"]["program"] = "PSS"
    TITLE_CODES["7292"]["unit"] = "99"

    TITLE_CODES["7293"] = {}
    TITLE_CODES["7293"]["title"] = "PROGR 4 SUPV"
    TITLE_CODES["7293"]["program"] = "PSS"
    TITLE_CODES["7293"]["unit"] = "99"

    TITLE_CODES["7294"] = {}
    TITLE_CODES["7294"]["title"] = "PROGR 5 SUPV"
    TITLE_CODES["7294"]["program"] = "PSS"
    TITLE_CODES["7294"]["unit"] = "99"

    TITLE_CODES["7295"] = {}
    TITLE_CODES["7295"]["title"] = "PROGR 6 SUPV"
    TITLE_CODES["7295"]["program"] = "PSS"
    TITLE_CODES["7295"]["unit"] = "99"

    TITLE_CODES["7296"] = {}
    TITLE_CODES["7296"]["title"] = "PROGR 7 SUPV"
    TITLE_CODES["7296"]["program"] = "PSS"
    TITLE_CODES["7296"]["unit"] = "99"

    TITLE_CODES["4812"] = {}
    TITLE_CODES["4812"]["title"] = "COMPUTER OPR SR"
    TITLE_CODES["4812"]["program"] = "PSS"
    TITLE_CODES["4812"]["unit"] = "TX"

    TITLE_CODES["9139"] = {}
    TITLE_CODES["9139"]["title"] = "CLIN NURSE 2"
    TITLE_CODES["9139"]["program"] = "PSS"
    TITLE_CODES["9139"]["unit"] = "NX"

    TITLE_CODES["9138"] = {}
    TITLE_CODES["9138"]["title"] = "CLIN NURSE 3"
    TITLE_CODES["9138"]["program"] = "PSS"
    TITLE_CODES["9138"]["unit"] = "NX"

    TITLE_CODES["4811"] = {}
    TITLE_CODES["4811"]["title"] = "COMPUTER OPS SUPV"
    TITLE_CODES["4811"]["program"] = "PSS"
    TITLE_CODES["4811"]["unit"] = "99"

    TITLE_CODES["2427"] = {}
    TITLE_CODES["2427"]["title"] = "SUBSTITUTE TEACHER"
    TITLE_CODES["2427"]["program"] = "ACADEMIC"
    TITLE_CODES["2427"]["unit"] = "IX"

    TITLE_CODES["9036"] = {}
    TITLE_CODES["9036"]["title"] = "PERFUSIONIST PRN"
    TITLE_CODES["9036"]["program"] = "PSS"
    TITLE_CODES["9036"]["unit"] = "EX"

    TITLE_CODES["0168"] = {}
    TITLE_CODES["0168"]["title"] = "EXEC ACTG PROVOST SAC"
    TITLE_CODES["0168"]["program"] = "MSP"
    TITLE_CODES["0168"]["unit"] = "99"

    TITLE_CODES["0169"] = {}
    TITLE_CODES["0169"]["title"] = "CHF AMBUL AND MGD CARE OFCR"
    TITLE_CODES["0169"]["program"] = "MSP"
    TITLE_CODES["0169"]["unit"] = "99"

    TITLE_CODES["0164"] = {}
    TITLE_CODES["0164"]["title"] = "CEO MED CTR"
    TITLE_CODES["0164"]["program"] = "MSP"
    TITLE_CODES["0164"]["unit"] = "99"

    TITLE_CODES["0165"] = {}
    TITLE_CODES["0165"]["title"] = "CFO MED CTR"
    TITLE_CODES["0165"]["program"] = "MSP"
    TITLE_CODES["0165"]["unit"] = "99"

    TITLE_CODES["0166"] = {}
    TITLE_CODES["0166"]["title"] = "CHF NURSE OFCR"
    TITLE_CODES["0166"]["program"] = "MSP"
    TITLE_CODES["0166"]["unit"] = "99"

    TITLE_CODES["0167"] = {}
    TITLE_CODES["0167"]["title"] = "EXEC PROVOST SAC"
    TITLE_CODES["0167"]["program"] = "MSP"
    TITLE_CODES["0167"]["unit"] = "99"

    TITLE_CODES["0160"] = {}
    TITLE_CODES["0160"]["title"] = "EXEC DEAN SAC"
    TITLE_CODES["0160"]["program"] = "MSP"
    TITLE_CODES["0160"]["unit"] = "99"

    TITLE_CODES["0161"] = {}
    TITLE_CODES["0161"]["title"] = "EXEC DIR MED CTR"
    TITLE_CODES["0161"]["program"] = "MSP"
    TITLE_CODES["0161"]["unit"] = "99"

    TITLE_CODES["0162"] = {}
    TITLE_CODES["0162"]["title"] = "CAO MED CTR"
    TITLE_CODES["0162"]["program"] = "MSP"
    TITLE_CODES["0162"]["unit"] = "99"

    TITLE_CODES["0163"] = {}
    TITLE_CODES["0163"]["title"] = "EXEC ACTG DEAN SAC"
    TITLE_CODES["0163"]["program"] = "MSP"
    TITLE_CODES["0163"]["unit"] = "99"

    TITLE_CODES["4687"] = {}
    TITLE_CODES["4687"]["title"] = "HOSP MED TRANSCRIBER SR"
    TITLE_CODES["4687"]["program"] = "PSS"
    TITLE_CODES["4687"]["unit"] = "EX"

    TITLE_CODES["4685"] = {}
    TITLE_CODES["4685"]["title"] = "HOSP MED TRANSCRIBER SR PD"
    TITLE_CODES["4685"]["program"] = "PSS"
    TITLE_CODES["4685"]["unit"] = "EX"

    TITLE_CODES["9228"] = {}
    TITLE_CODES["9228"]["title"] = "OPERATING ROOM SUPP AST"
    TITLE_CODES["9228"]["program"] = "PSS"
    TITLE_CODES["9228"]["unit"] = "EX"

    TITLE_CODES["7701"] = {}
    TITLE_CODES["7701"]["title"] = "WRITER SUPV"
    TITLE_CODES["7701"]["program"] = "PSS"
    TITLE_CODES["7701"]["unit"] = "99"

    TITLE_CODES["4688"] = {}
    TITLE_CODES["4688"]["title"] = "HOSP MED TRANSCRIBER"
    TITLE_CODES["4688"]["program"] = "PSS"
    TITLE_CODES["4688"]["unit"] = "EX"

    TITLE_CODES["4689"] = {}
    TITLE_CODES["4689"]["title"] = "HOSP MED TRANSCRIBER SR SUPV"
    TITLE_CODES["4689"]["program"] = "PSS"
    TITLE_CODES["4689"]["unit"] = "99"

    TITLE_CODES["9352"] = {}
    TITLE_CODES["9352"]["title"] = "CHILD LIFE SPEC 2"
    TITLE_CODES["9352"]["program"] = "PSS"
    TITLE_CODES["9352"]["unit"] = "HX"

    TITLE_CODES["6191"] = {}
    TITLE_CODES["6191"]["title"] = "MUSICIAN PRN"
    TITLE_CODES["6191"]["program"] = "PSS"
    TITLE_CODES["6191"]["unit"] = "99"

    TITLE_CODES["6192"] = {}
    TITLE_CODES["6192"]["title"] = "MUSICIAN SR"
    TITLE_CODES["6192"]["program"] = "PSS"
    TITLE_CODES["6192"]["unit"] = "99"

    TITLE_CODES["4423"] = {}
    TITLE_CODES["4423"]["title"] = "LRNG SKLS CNSLR PRN SUPV"
    TITLE_CODES["4423"]["program"] = "PSS"
    TITLE_CODES["4423"]["unit"] = "99"

    TITLE_CODES["2100"] = {}
    TITLE_CODES["2100"]["title"] = "SUPV PE-AY"
    TITLE_CODES["2100"]["program"] = "ACADEMIC"
    TITLE_CODES["2100"]["unit"] = "99"

    TITLE_CODES["2510"] = {}
    TITLE_CODES["2510"]["title"] = "TUT-NON STDNT"
    TITLE_CODES["2510"]["program"] = "ACADEMIC"
    TITLE_CODES["2510"]["unit"] = "BX"

    TITLE_CODES["2106"] = {}
    TITLE_CODES["2106"]["title"] = "SUPRVSR OF PHYS ED-RECALLED-AY"
    TITLE_CODES["2106"]["program"] = "ACADEMIC"
    TITLE_CODES["2106"]["unit"] = "99"

    TITLE_CODES["9616"] = {}
    TITLE_CODES["9616"]["title"] = "SRA 2 SUPV"
    TITLE_CODES["9616"]["program"] = "PSS"
    TITLE_CODES["9616"]["unit"] = "99"

    TITLE_CODES["2735"] = {}
    TITLE_CODES["2735"]["title"] = "STIPEND-OTH POST-MD TRAIN"
    TITLE_CODES["2735"]["program"] = "ACADEMIC"
    TITLE_CODES["2735"]["unit"] = "87"

    TITLE_CODES["5117"] = {}
    TITLE_CODES["5117"]["title"] = "CUSTODIAN"
    TITLE_CODES["5117"]["program"] = "PSS"
    TITLE_CODES["5117"]["unit"] = "SX"

    TITLE_CODES["2737"] = {}
    TITLE_CODES["2737"]["title"] = "OTH POST DDS/NON REP"
    TITLE_CODES["2737"]["program"] = "ACADEMIC"
    TITLE_CODES["2737"]["unit"] = "99"

    TITLE_CODES["2730"] = {}
    TITLE_CODES["2730"]["title"] = "RESID-VET MED/NON REP"
    TITLE_CODES["2730"]["program"] = "ACADEMIC"
    TITLE_CODES["2730"]["unit"] = "99"

    TITLE_CODES["5110"] = {}
    TITLE_CODES["5110"]["title"] = "CUSTODIAN PRN SUPV"
    TITLE_CODES["5110"]["program"] = "PSS"
    TITLE_CODES["5110"]["unit"] = "99"

    TITLE_CODES["2732"] = {}
    TITLE_CODES["2732"]["title"] = "OTH POST-MD TRAIN 2-8/NON REP"
    TITLE_CODES["2732"]["program"] = "ACADEMIC"
    TITLE_CODES["2732"]["unit"] = "99"

    TITLE_CODES["5112"] = {}
    TITLE_CODES["5112"]["title"] = "CUSTODIAN SUPV"
    TITLE_CODES["5112"]["program"] = "PSS"
    TITLE_CODES["5112"]["unit"] = "99"

    TITLE_CODES["5296"] = {}
    TITLE_CODES["5296"]["title"] = "MED CTR SECURITY OFCR SR SUPV"
    TITLE_CODES["5296"]["program"] = "PSS"
    TITLE_CODES["5296"]["unit"] = "99"

    TITLE_CODES["9349"] = {}
    TITLE_CODES["9349"]["title"] = "CMTY HEALTH PRG MGR SUPV"
    TITLE_CODES["9349"]["program"] = "PSS"
    TITLE_CODES["9349"]["unit"] = "99"

    TITLE_CODES["5294"] = {}
    TITLE_CODES["5294"]["title"] = "MED CTR SECURITY OFCR SR"
    TITLE_CODES["5294"]["program"] = "PSS"
    TITLE_CODES["5294"]["unit"] = "SX"

    TITLE_CODES["2738"] = {}
    TITLE_CODES["2738"]["title"] = "CHIEF RESID PHYS-REP"
    TITLE_CODES["2738"]["program"] = "ACADEMIC"
    TITLE_CODES["2738"]["unit"] = "M3"

    TITLE_CODES["8222"] = {}
    TITLE_CODES["8222"]["title"] = "HVAC CNTRL TCHN"
    TITLE_CODES["8222"]["program"] = "PSS"
    TITLE_CODES["8222"]["unit"] = "K3"

    TITLE_CODES["9618"] = {}
    TITLE_CODES["9618"]["title"] = "MARINE TCHN 2 NEX"
    TITLE_CODES["9618"]["program"] = "PSS"
    TITLE_CODES["9618"]["unit"] = "RX"

    TITLE_CODES["9619"] = {}
    TITLE_CODES["9619"]["title"] = "MARINE TCHN 3 NEX"
    TITLE_CODES["9619"]["program"] = "PSS"
    TITLE_CODES["9619"]["unit"] = "RX"

    TITLE_CODES["3213"] = {}
    TITLE_CODES["3213"]["title"] = "ASSOC RES-AY"
    TITLE_CODES["3213"]["program"] = "ACADEMIC"
    TITLE_CODES["3213"]["unit"] = "FX"

    TITLE_CODES["5058"] = {}
    TITLE_CODES["5058"]["title"] = "STOREKEEPER PD"
    TITLE_CODES["5058"]["program"] = "PSS"
    TITLE_CODES["5058"]["unit"] = "SX"

    TITLE_CODES["5059"] = {}
    TITLE_CODES["5059"]["title"] = "STORES WORKER PD"
    TITLE_CODES["5059"]["program"] = "PSS"
    TITLE_CODES["5059"]["unit"] = "SX"

    TITLE_CODES["9180"] = {}
    TITLE_CODES["9180"]["title"] = "RADLG AST 2"
    TITLE_CODES["9180"]["program"] = "PSS"
    TITLE_CODES["9180"]["unit"] = "EX"

    TITLE_CODES["8955"] = {}
    TITLE_CODES["8955"]["title"] = "CYTO TCHNO"
    TITLE_CODES["8955"]["program"] = "PSS"
    TITLE_CODES["8955"]["unit"] = "HX"

    TITLE_CODES["5054"] = {}
    TITLE_CODES["5054"]["title"] = "MED CTR ENVIR SVC MGR 2"
    TITLE_CODES["5054"]["program"] = "PSS"
    TITLE_CODES["5054"]["unit"] = "99"

    TITLE_CODES["5055"] = {}
    TITLE_CODES["5055"]["title"] = "MED CTR ENVIR SVC MGR 1"
    TITLE_CODES["5055"]["program"] = "PSS"
    TITLE_CODES["5055"]["unit"] = "99"

    TITLE_CODES["5056"] = {}
    TITLE_CODES["5056"]["title"] = "MED CTR FOOD SVC SUPV 2"
    TITLE_CODES["5056"]["program"] = "PSS"
    TITLE_CODES["5056"]["unit"] = "99"

    TITLE_CODES["5057"] = {}
    TITLE_CODES["5057"]["title"] = "STOREKEEPER SR PD"
    TITLE_CODES["5057"]["program"] = "PSS"
    TITLE_CODES["5057"]["unit"] = "SX"

    TITLE_CODES["5050"] = {}
    TITLE_CODES["5050"]["title"] = "MED CTR FOOD SVC MGR 2"
    TITLE_CODES["5050"]["program"] = "PSS"
    TITLE_CODES["5050"]["unit"] = "99"

    TITLE_CODES["5051"] = {}
    TITLE_CODES["5051"]["title"] = "MED CTR FOOD SVC MGR 1"
    TITLE_CODES["5051"]["program"] = "PSS"
    TITLE_CODES["5051"]["unit"] = "99"

    TITLE_CODES["5052"] = {}
    TITLE_CODES["5052"]["title"] = "MED CTR ENVIR SVC SUPV 2"
    TITLE_CODES["5052"]["program"] = "PSS"
    TITLE_CODES["5052"]["unit"] = "99"

    TITLE_CODES["5053"] = {}
    TITLE_CODES["5053"]["title"] = "MED CTR ENVIR SVC SUPV 1"
    TITLE_CODES["5053"]["program"] = "PSS"
    TITLE_CODES["5053"]["unit"] = "99"

    TITLE_CODES["1814"] = {}
    TITLE_CODES["1814"]["title"] = "HS CLIN PROF-GENCOMP-A"
    TITLE_CODES["1814"]["program"] = "ACADEMIC"
    TITLE_CODES["1814"]["unit"] = "99"

    TITLE_CODES["7209"] = {}
    TITLE_CODES["7209"]["title"] = "STATISTICIAN PRN SUPV"
    TITLE_CODES["7209"]["program"] = "PSS"
    TITLE_CODES["7209"]["unit"] = "99"

    TITLE_CODES["7208"] = {}
    TITLE_CODES["7208"]["title"] = "STATISTICIAN SR SUPV"
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

    TITLE_CODES["0877"] = {}
    TITLE_CODES["0877"]["title"] = "ACT ACADEMIC COORD"
    TITLE_CODES["0877"]["program"] = "ACADEMIC"
    TITLE_CODES["0877"]["unit"] = "99"

    TITLE_CODES["1535"] = {}
    TITLE_CODES["1535"]["title"] = "INSTRUCTOR-GENCOMP-A"
    TITLE_CODES["1535"]["program"] = "ACADEMIC"
    TITLE_CODES["1535"]["unit"] = "A3"

    TITLE_CODES["2037"] = {}
    TITLE_CODES["2037"]["title"] = "ASSOC CLIN PROF-VOL"
    TITLE_CODES["2037"]["program"] = "ACADEMIC"
    TITLE_CODES["2037"]["unit"] = "99"

    TITLE_CODES["6223"] = {}
    TITLE_CODES["6223"]["title"] = "PHOTOGRAPHER"
    TITLE_CODES["6223"]["program"] = "PSS"
    TITLE_CODES["6223"]["unit"] = "TX"

    TITLE_CODES["6220"] = {}
    TITLE_CODES["6220"]["title"] = "PHOTOGRAPHER SR SUPV"
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
    TITLE_CODES["6227"]["title"] = "PHOTOGRAPHIC TCHN"
    TITLE_CODES["6227"]["program"] = "PSS"
    TITLE_CODES["6227"]["unit"] = "TX"

    TITLE_CODES["2031"] = {}
    TITLE_CODES["2031"]["title"] = "ASSO CLIN PROF-DENT-50%/+ FY"
    TITLE_CODES["2031"]["program"] = "ACADEMIC"
    TITLE_CODES["2031"]["unit"] = "99"

    TITLE_CODES["2030"] = {}
    TITLE_CODES["2030"]["title"] = "HS ASSOC CLIN PROF-FY"
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
    TITLE_CODES["8634"]["title"] = "OFC MACHINE TCHN 1"
    TITLE_CODES["8634"]["program"] = "PSS"
    TITLE_CODES["8634"]["unit"] = "99"

    TITLE_CODES["8254"] = {}
    TITLE_CODES["8254"]["title"] = "REFRIGERATION MECH LD"
    TITLE_CODES["8254"]["program"] = "PSS"
    TITLE_CODES["8254"]["unit"] = "K3"

    TITLE_CODES["3094"] = {}
    TITLE_CODES["3094"]["title"] = "ACT JR---IN THE AES-ACAD YR"
    TITLE_CODES["3094"]["program"] = "ACADEMIC"
    TITLE_CODES["3094"]["unit"] = "99"

    TITLE_CODES["8633"] = {}
    TITLE_CODES["8633"]["title"] = "OFC MACHINE TCHN 2"
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
    TITLE_CODES["9551"]["title"] = "BOTANICAL GARDEN ARBOR MGR SR"
    TITLE_CODES["9551"]["program"] = "PSS"
    TITLE_CODES["9551"]["unit"] = "99"

    TITLE_CODES["9049"] = {}
    TITLE_CODES["9049"]["title"] = "REG RESP THER 1"
    TITLE_CODES["9049"]["program"] = "PSS"
    TITLE_CODES["9049"]["unit"] = "EX"

    TITLE_CODES["8953"] = {}
    TITLE_CODES["8953"]["title"] = "CYTO TCHNO SUPV"
    TITLE_CODES["8953"]["program"] = "PSS"
    TITLE_CODES["8953"]["unit"] = "99"

    TITLE_CODES["8643"] = {}
    TITLE_CODES["8643"]["title"] = "MED CTR DEV TCHN 2"
    TITLE_CODES["8643"]["program"] = "PSS"
    TITLE_CODES["8643"]["unit"] = "EX"

    TITLE_CODES["7631"] = {}
    TITLE_CODES["7631"]["title"] = "AUDITOR 4 SUPV"
    TITLE_CODES["7631"]["program"] = "PSS"
    TITLE_CODES["7631"]["unit"] = "99"

    TITLE_CODES["9383"] = {}
    TITLE_CODES["9383"]["title"] = "PSYCHOLOGIST 2"
    TITLE_CODES["9383"]["program"] = "PSS"
    TITLE_CODES["9383"]["unit"] = "HX"

    TITLE_CODES["3236"] = {}
    TITLE_CODES["3236"]["title"] = "ASST FIELD PROGRAM SUPERVISOR"
    TITLE_CODES["3236"]["program"] = "ACADEMIC"
    TITLE_CODES["3236"]["unit"] = "FX"

    TITLE_CODES["8226"] = {}
    TITLE_CODES["8226"]["title"] = "VENTILATION MECH"
    TITLE_CODES["8226"]["program"] = "PSS"
    TITLE_CODES["8226"]["unit"] = "K3"

    TITLE_CODES["8146"] = {}
    TITLE_CODES["8146"]["title"] = "FARM MAINT WORKER SR SUPV"
    TITLE_CODES["8146"]["program"] = "PSS"
    TITLE_CODES["8146"]["unit"] = "99"

    TITLE_CODES["9047"] = {}
    TITLE_CODES["9047"]["title"] = "RESP THER 3"
    TITLE_CODES["9047"]["program"] = "PSS"
    TITLE_CODES["9047"]["unit"] = "99"

    TITLE_CODES["9046"] = {}
    TITLE_CODES["9046"]["title"] = "RESP THER 4"
    TITLE_CODES["9046"]["program"] = "PSS"
    TITLE_CODES["9046"]["unit"] = "99"

    TITLE_CODES["3237"] = {}
    TITLE_CODES["3237"]["title"] = "FACULTY FELLOW RES-AY"
    TITLE_CODES["3237"]["program"] = "ACADEMIC"
    TITLE_CODES["3237"]["unit"] = "FX"

    TITLE_CODES["1608"] = {}
    TITLE_CODES["1608"]["title"] = "LECT SOE-AY-1/9"
    TITLE_CODES["1608"]["program"] = "ACADEMIC"
    TITLE_CODES["1608"]["unit"] = "A3"

    TITLE_CODES["4951"] = {}
    TITLE_CODES["4951"]["title"] = "WORD PROCESSING SPEC PRN"
    TITLE_CODES["4951"]["program"] = "PSS"
    TITLE_CODES["4951"]["unit"] = "CX"

    TITLE_CODES["3540"] = {}
    TITLE_CODES["3540"]["title"] = "PROG COORD"
    TITLE_CODES["3540"]["program"] = "ACADEMIC"
    TITLE_CODES["3540"]["unit"] = "FX"

    TITLE_CODES["3228"] = {}
    TITLE_CODES["3228"]["title"] = "VIS ASST RES"
    TITLE_CODES["3228"]["program"] = "ACADEMIC"
    TITLE_CODES["3228"]["unit"] = "99"

    TITLE_CODES["1979"] = {}
    TITLE_CODES["1979"]["title"] = "ACT ASST PROF-AY-1/9-B/E/E"
    TITLE_CODES["1979"]["program"] = "ACADEMIC"
    TITLE_CODES["1979"]["unit"] = "99"

    TITLE_CODES["1978"] = {}
    TITLE_CODES["1978"]["title"] = "ACT ASST PROF-FY-B/E/E"
    TITLE_CODES["1978"]["program"] = "ACADEMIC"
    TITLE_CODES["1978"]["unit"] = "99"

    TITLE_CODES["1977"] = {}
    TITLE_CODES["1977"]["title"] = "ACT ASST PROF-AY-B/E/E"
    TITLE_CODES["1977"]["program"] = "ACADEMIC"
    TITLE_CODES["1977"]["unit"] = "99"

    TITLE_CODES["1600"] = {}
    TITLE_CODES["1600"]["title"] = "SR LECT PSOE-AY-PART TIME"
    TITLE_CODES["1600"]["program"] = "ACADEMIC"
    TITLE_CODES["1600"]["unit"] = "IX"

    TITLE_CODES["1603"] = {}
    TITLE_CODES["1603"]["title"] = "SR LECT SOE-AY"
    TITLE_CODES["1603"]["program"] = "ACADEMIC"
    TITLE_CODES["1603"]["unit"] = "A3"

    TITLE_CODES["1602"] = {}
    TITLE_CODES["1602"]["title"] = "SR LECT PSOE-AY-1/9-PART TIME"
    TITLE_CODES["1602"]["program"] = "ACADEMIC"
    TITLE_CODES["1602"]["unit"] = "IX"

    TITLE_CODES["1605"] = {}
    TITLE_CODES["1605"]["title"] = "LECT PSOE-AY-PART TIME"
    TITLE_CODES["1605"]["program"] = "ACADEMIC"
    TITLE_CODES["1605"]["unit"] = "IX"

    TITLE_CODES["1604"] = {}
    TITLE_CODES["1604"]["title"] = "SR LECT SOE-AY-1/9"
    TITLE_CODES["1604"]["program"] = "ACADEMIC"
    TITLE_CODES["1604"]["unit"] = "A3"

    TITLE_CODES["1607"] = {}
    TITLE_CODES["1607"]["title"] = "LECT SOE-AY"
    TITLE_CODES["1607"]["program"] = "ACADEMIC"
    TITLE_CODES["1607"]["unit"] = "A3"

    TITLE_CODES["1606"] = {}
    TITLE_CODES["1606"]["title"] = "LECT PSOE-AY-1/9-PART TIME"
    TITLE_CODES["1606"]["program"] = "ACADEMIC"
    TITLE_CODES["1606"]["unit"] = "IX"

    TITLE_CODES["8912"] = {}
    TITLE_CODES["8912"]["title"] = "PATIENT ESCORT"
    TITLE_CODES["8912"]["program"] = "PSS"
    TITLE_CODES["8912"]["unit"] = "EX"

    TITLE_CODES["8913"] = {}
    TITLE_CODES["8913"]["title"] = "MENTAL HEALTH PRACTITIONER SR"
    TITLE_CODES["8913"]["program"] = "PSS"
    TITLE_CODES["8913"]["unit"] = "EX"

    TITLE_CODES["8911"] = {}
    TITLE_CODES["8911"]["title"] = "PATIENT ESCORT SR"
    TITLE_CODES["8911"]["program"] = "PSS"
    TITLE_CODES["8911"]["unit"] = "EX"

    TITLE_CODES["8916"] = {}
    TITLE_CODES["8916"]["title"] = "VOC NURSE SR"
    TITLE_CODES["8916"]["program"] = "PSS"
    TITLE_CODES["8916"]["unit"] = "EX"

    TITLE_CODES["1539"] = {}
    TITLE_CODES["1539"]["title"] = "ASSOCIATE PROFESSOR-GENCOMP-A"
    TITLE_CODES["1539"]["program"] = "ACADEMIC"
    TITLE_CODES["1539"]["unit"] = "A3"

    TITLE_CODES["8914"] = {}
    TITLE_CODES["8914"]["title"] = "MENTAL HEALTH PRACTITIONER"
    TITLE_CODES["8914"]["program"] = "PSS"
    TITLE_CODES["8914"]["unit"] = "EX"

    TITLE_CODES["8915"] = {}
    TITLE_CODES["8915"]["title"] = "VOC NURSE SR SUPV"
    TITLE_CODES["8915"]["program"] = "PSS"
    TITLE_CODES["8915"]["unit"] = "99"

    TITLE_CODES["0803"] = {}
    TITLE_CODES["0803"]["title"] = "ASSOC VICE CHANC"
    TITLE_CODES["0803"]["program"] = "ACADEMIC"
    TITLE_CODES["0803"]["unit"] = "99"

    TITLE_CODES["0802"] = {}
    TITLE_CODES["0802"]["title"] = "ASST VICE CHANC"
    TITLE_CODES["0802"]["program"] = "ACADEMIC"
    TITLE_CODES["0802"]["unit"] = "99"

    TITLE_CODES["0801"] = {}
    TITLE_CODES["0801"]["title"] = "ACADEMIC ASST TO CHANC"
    TITLE_CODES["0801"]["program"] = "ACADEMIC"
    TITLE_CODES["0801"]["unit"] = "99"

    TITLE_CODES["0800"] = {}
    TITLE_CODES["0800"]["title"] = "ACADEMIC ASST TO VICE CHANC"
    TITLE_CODES["0800"]["program"] = "ACADEMIC"
    TITLE_CODES["0800"]["unit"] = "99"

    TITLE_CODES["0806"] = {}
    TITLE_CODES["0806"]["title"] = "PROG DIR--SCRIPPS INS OF OCGPY"
    TITLE_CODES["0806"]["program"] = "ACADEMIC"
    TITLE_CODES["0806"]["unit"] = "99"

    TITLE_CODES["0804"] = {}
    TITLE_CODES["0804"]["title"] = "ACT/INTERIM ASSOC VICE CHANC"
    TITLE_CODES["0804"]["program"] = "ACADEMIC"
    TITLE_CODES["0804"]["unit"] = "99"

    TITLE_CODES["1788"] = {}
    TITLE_CODES["1788"]["title"] = "ASST ADJUNCT PROF-FY-MEDCOMP"
    TITLE_CODES["1788"]["program"] = "ACADEMIC"
    TITLE_CODES["1788"]["unit"] = "99"

    TITLE_CODES["1789"] = {}
    TITLE_CODES["1789"]["title"] = "ASSOC ADJUNCT PROF-FY-MEDCOMP"
    TITLE_CODES["1789"]["program"] = "ACADEMIC"
    TITLE_CODES["1789"]["unit"] = "99"

    TITLE_CODES["0768"] = {}
    TITLE_CODES["0768"]["title"] = "PHYSCN DIPLOMATE SR"
    TITLE_CODES["0768"]["program"] = "MSP"
    TITLE_CODES["0768"]["unit"] = "99"

    TITLE_CODES["0769"] = {}
    TITLE_CODES["0769"]["title"] = "PHYSCN SR"
    TITLE_CODES["0769"]["program"] = "MSP"
    TITLE_CODES["0769"]["unit"] = "99"

    TITLE_CODES["0762"] = {}
    TITLE_CODES["0762"]["title"] = "ANESTHESIA NURSE PRN"
    TITLE_CODES["0762"]["program"] = "MSP"
    TITLE_CODES["0762"]["unit"] = "99"

    TITLE_CODES["0763"] = {}
    TITLE_CODES["0763"]["title"] = "ADMIN NURSE 5"
    TITLE_CODES["0763"]["program"] = "MSP"
    TITLE_CODES["0763"]["unit"] = "99"

    TITLE_CODES["0760"] = {}
    TITLE_CODES["0760"]["title"] = "ENGR CHF"
    TITLE_CODES["0760"]["program"] = "MSP"
    TITLE_CODES["0760"]["unit"] = "99"

    TITLE_CODES["0761"] = {}
    TITLE_CODES["0761"]["title"] = "RESP THER 5"
    TITLE_CODES["0761"]["program"] = "MSP"
    TITLE_CODES["0761"]["unit"] = "99"

    TITLE_CODES["0766"] = {}
    TITLE_CODES["0766"]["title"] = "CLIN NURSE 5"
    TITLE_CODES["0766"]["program"] = "MSP"
    TITLE_CODES["0766"]["unit"] = "99"

    TITLE_CODES["0767"] = {}
    TITLE_CODES["0767"]["title"] = "MED SVC DIR"
    TITLE_CODES["0767"]["program"] = "MSP"
    TITLE_CODES["0767"]["unit"] = "99"

    TITLE_CODES["0764"] = {}
    TITLE_CODES["0764"]["title"] = "ADMIN NURSE 4"
    TITLE_CODES["0764"]["program"] = "MSP"
    TITLE_CODES["0764"]["unit"] = "99"

    TITLE_CODES["0765"] = {}
    TITLE_CODES["0765"]["title"] = "PHARMACIST SUPV"
    TITLE_CODES["0765"]["program"] = "MSP"
    TITLE_CODES["0765"]["unit"] = "99"

    TITLE_CODES["3320"] = {}
    TITLE_CODES["3320"]["title"] = "ASST SPECIALIST"
    TITLE_CODES["3320"]["program"] = "ACADEMIC"
    TITLE_CODES["3320"]["unit"] = "FX"

    TITLE_CODES["7112"] = {}
    TITLE_CODES["7112"]["title"] = "TELEVISION ENGR SR"
    TITLE_CODES["7112"]["program"] = "PSS"
    TITLE_CODES["7112"]["unit"] = "99"

    TITLE_CODES["7110"] = {}
    TITLE_CODES["7110"]["title"] = "TELEVISION ENGR SUPV SR"
    TITLE_CODES["7110"]["program"] = "PSS"
    TITLE_CODES["7110"]["unit"] = "99"

    TITLE_CODES["8654"] = {}
    TITLE_CODES["8654"]["title"] = "LAB MECHN HELPER"
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
    TITLE_CODES["3045"]["title"] = "ACT ASSOC AGRON AES-B/E/E"
    TITLE_CODES["3045"]["program"] = "ACADEMIC"
    TITLE_CODES["3045"]["unit"] = "99"

    TITLE_CODES["3044"] = {}
    TITLE_CODES["3044"]["title"] = "ACT AGRON AES-B/E/E"
    TITLE_CODES["3044"]["program"] = "ACADEMIC"
    TITLE_CODES["3044"]["unit"] = "99"

    TITLE_CODES["3046"] = {}
    TITLE_CODES["3046"]["title"] = "ACT ASST AGRON AES-B/E/E"
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
    TITLE_CODES["7052"]["title"] = "LANDSCAPE ARCHITECT SR"
    TITLE_CODES["7052"]["program"] = "PSS"
    TITLE_CODES["7052"]["unit"] = "99"

    TITLE_CODES["1077"] = {}
    TITLE_CODES["1077"]["title"] = "ACT/INTERIM VICE PROVOST"
    TITLE_CODES["1077"]["program"] = "ACADEMIC"
    TITLE_CODES["1077"]["unit"] = "99"

    TITLE_CODES["7050"] = {}
    TITLE_CODES["7050"]["title"] = "LANDSCAPE ARCHITECT SUPV"
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
    TITLE_CODES["1070"]["title"] = "DIRECTOR-EAP STUDY CENTER"
    TITLE_CODES["1070"]["program"] = "ACADEMIC"
    TITLE_CODES["1070"]["unit"] = "99"

    TITLE_CODES["7634"] = {}
    TITLE_CODES["7634"]["title"] = "ADMIN SPEC 2 SUPV"
    TITLE_CODES["7634"]["program"] = "PSS"
    TITLE_CODES["7634"]["unit"] = "99"

    TITLE_CODES["9287"] = {}
    TITLE_CODES["9287"]["title"] = "GENETIC CNSLR 2"
    TITLE_CODES["9287"]["program"] = "PSS"
    TITLE_CODES["9287"]["unit"] = "HX"

    TITLE_CODES["9633"] = {}
    TITLE_CODES["9633"]["title"] = "MUSEUM PREPARATOR SR"
    TITLE_CODES["9633"]["program"] = "PSS"
    TITLE_CODES["9633"]["unit"] = "TX"

    TITLE_CODES["1675"] = {}
    TITLE_CODES["1675"]["title"] = "LECT/SR LECT(WOS)"
    TITLE_CODES["1675"]["program"] = "ACADEMIC"
    TITLE_CODES["1675"]["unit"] = "99"

    TITLE_CODES["1676"] = {}
    TITLE_CODES["1676"]["title"] = "LECTURER/SR. LECTURER-WOS-FY"
    TITLE_CODES["1676"]["program"] = "ACADEMIC"
    TITLE_CODES["1676"]["unit"] = "99"

    TITLE_CODES["1094"] = {}
    TITLE_CODES["1094"]["title"] = "DEPARTMENT VICE CHAIR"
    TITLE_CODES["1094"]["program"] = "ACADEMIC"
    TITLE_CODES["1094"]["unit"] = "99"

    TITLE_CODES["1095"] = {}
    TITLE_CODES["1095"]["title"] = "ACT/INTERIM DEPARTMENT CHAIR"
    TITLE_CODES["1095"]["program"] = "ACADEMIC"
    TITLE_CODES["1095"]["unit"] = "99"

    TITLE_CODES["1096"] = {}
    TITLE_CODES["1096"]["title"] = "DEPARTMENT CHAIR"
    TITLE_CODES["1096"]["program"] = "ACADEMIC"
    TITLE_CODES["1096"]["unit"] = "99"

    TITLE_CODES["8224"] = {}
    TITLE_CODES["8224"]["title"] = "ROOFER APPR"
    TITLE_CODES["8224"]["program"] = "PSS"
    TITLE_CODES["8224"]["unit"] = "K3"

    TITLE_CODES["8225"] = {}
    TITLE_CODES["8225"]["title"] = "VENTILATION MECH APPR"
    TITLE_CODES["8225"]["program"] = "PSS"
    TITLE_CODES["8225"]["unit"] = "K3"

    TITLE_CODES["1092"] = {}
    TITLE_CODES["1092"]["title"] = "STIPEND-RESID"
    TITLE_CODES["1092"]["program"] = "ACADEMIC"
    TITLE_CODES["1092"]["unit"] = "87"

    TITLE_CODES["8227"] = {}
    TITLE_CODES["8227"]["title"] = "REFRIGERATION MECH"
    TITLE_CODES["8227"]["program"] = "PSS"
    TITLE_CODES["8227"]["unit"] = "K3"

    TITLE_CODES["9617"] = {}
    TITLE_CODES["9617"]["title"] = "SRA 2 NEX"
    TITLE_CODES["9617"]["program"] = "PSS"
    TITLE_CODES["9617"]["unit"] = "RX"

    TITLE_CODES["3393"] = {}
    TITLE_CODES["3393"]["title"] = "ASSOC PROJ SCIENTIST-FY-B/E/E"
    TITLE_CODES["3393"]["program"] = "ACADEMIC"
    TITLE_CODES["3393"]["unit"] = "FX"

    TITLE_CODES["8142"] = {}
    TITLE_CODES["8142"]["title"] = "MACHINIST WORKER LD"
    TITLE_CODES["8142"]["program"] = "PSS"
    TITLE_CODES["8142"]["unit"] = "K3"

    TITLE_CODES["1098"] = {}
    TITLE_CODES["1098"]["title"] = "SUMMER DIFFERENTIAL"
    TITLE_CODES["1098"]["program"] = "ACADEMIC"
    TITLE_CODES["1098"]["unit"] = "87"

    TITLE_CODES["1099"] = {}
    TITLE_CODES["1099"]["title"] = "ADMIN STIPEND"
    TITLE_CODES["1099"]["program"] = "ACADEMIC"
    TITLE_CODES["1099"]["unit"] = "87"

    TITLE_CODES["3800"] = {}
    TITLE_CODES["3800"]["title"] = "NON-SENATE ACAD EMERITUS(WOS)"
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
    TITLE_CODES["9954"]["title"] = "PSYCHOLOGY INTERN"
    TITLE_CODES["9954"]["program"] = "PSS"
    TITLE_CODES["9954"]["unit"] = "99"

    TITLE_CODES["9021"] = {}
    TITLE_CODES["9021"]["title"] = "RADLG TCHNO PRN"
    TITLE_CODES["9021"]["program"] = "PSS"
    TITLE_CODES["9021"]["unit"] = "EX"

    TITLE_CODES["3039"] = {}
    TITLE_CODES["3039"]["title"] = "ACT JR --- IN THE A.E.S.SFT-VM"
    TITLE_CODES["3039"]["program"] = "ACADEMIC"
    TITLE_CODES["3039"]["unit"] = "FX"

    TITLE_CODES["1550"] = {}
    TITLE_CODES["1550"]["title"] = "LECT IN SUMMER SESSION"
    TITLE_CODES["1550"]["program"] = "ACADEMIC"
    TITLE_CODES["1550"]["unit"] = "IX"

    TITLE_CODES["0058"] = {}
    TITLE_CODES["0058"]["title"] = "AST SECR OF THE REGENTS"
    TITLE_CODES["0058"]["program"] = "MSP"
    TITLE_CODES["0058"]["unit"] = "99"

    TITLE_CODES["0055"] = {}
    TITLE_CODES["0055"]["title"] = "SECR OF THE REGENTS"
    TITLE_CODES["0055"]["program"] = "MSP"
    TITLE_CODES["0055"]["unit"] = "99"

    TITLE_CODES["0057"] = {}
    TITLE_CODES["0057"]["title"] = "ASC SECR OF THE REGENTS"
    TITLE_CODES["0057"]["program"] = "MSP"
    TITLE_CODES["0057"]["unit"] = "99"

    TITLE_CODES["3037"] = {}
    TITLE_CODES["3037"]["title"] = "ACT JR ----- IN THE A.E.S."
    TITLE_CODES["3037"]["program"] = "ACADEMIC"
    TITLE_CODES["3037"]["unit"] = "99"

    TITLE_CODES["3030"] = {}
    TITLE_CODES["3030"]["title"] = "JR ----- IN THE A.E.S."
    TITLE_CODES["3030"]["program"] = "ACADEMIC"
    TITLE_CODES["3030"]["unit"] = "FX"

    TITLE_CODES["0050"] = {}
    TITLE_CODES["0050"]["title"] = "ASC VP ACAD AFFAIRS"
    TITLE_CODES["0050"]["program"] = "MSP"
    TITLE_CODES["0050"]["unit"] = "99"

    TITLE_CODES["9899"] = {}
    TITLE_CODES["9899"]["title"] = "ADMIN STIPEND EX"
    TITLE_CODES["9899"]["program"] = "PSS"
    TITLE_CODES["9899"]["unit"] = "99"

    TITLE_CODES["3034"] = {}
    TITLE_CODES["3034"]["title"] = "JR SPECIALIST IN THE A.E.S."
    TITLE_CODES["3034"]["program"] = "ACADEMIC"
    TITLE_CODES["3034"]["unit"] = "FX"

    TITLE_CODES["5129"] = {}
    TITLE_CODES["5129"]["title"] = "MED CTR FOOD SVC WORKER PRN"
    TITLE_CODES["5129"]["program"] = "PSS"
    TITLE_CODES["5129"]["unit"] = "SX"

    TITLE_CODES["4102"] = {}
    TITLE_CODES["4102"]["title"] = "CHILD DEV CTR MGR"
    TITLE_CODES["4102"]["program"] = "PSS"
    TITLE_CODES["4102"]["unit"] = "99"

    TITLE_CODES["8929"] = {}
    TITLE_CODES["8929"]["title"] = "ORTHOPEDIC TCHN"
    TITLE_CODES["8929"]["program"] = "PSS"
    TITLE_CODES["8929"]["unit"] = "EX"

    TITLE_CODES["9020"] = {}
    TITLE_CODES["9020"]["title"] = "RADLG TCHNO CHF ASC"
    TITLE_CODES["9020"]["program"] = "PSS"
    TITLE_CODES["9020"]["unit"] = "99"

    TITLE_CODES["1410"] = {}
    TITLE_CODES["1410"]["title"] = "INSTRUCTOR - FISCAL YEAR"
    TITLE_CODES["1410"]["program"] = "ACADEMIC"
    TITLE_CODES["1410"]["unit"] = "A3"

    TITLE_CODES["8928"] = {}
    TITLE_CODES["8928"]["title"] = "ORTHOPEDIC TCHN SR"
    TITLE_CODES["8928"]["program"] = "PSS"
    TITLE_CODES["8928"]["unit"] = "EX"

    TITLE_CODES["8035"] = {}
    TITLE_CODES["8035"]["title"] = "PHYS THER 4 SUPV"
    TITLE_CODES["8035"]["program"] = "PSS"
    TITLE_CODES["8035"]["unit"] = "99"

    TITLE_CODES["8034"] = {}
    TITLE_CODES["8034"]["title"] = "PHYS THER 3 SUPV"
    TITLE_CODES["8034"]["program"] = "PSS"
    TITLE_CODES["8034"]["unit"] = "99"

    TITLE_CODES["8031"] = {}
    TITLE_CODES["8031"]["title"] = "AUDIOLOGIST SR SUPV"
    TITLE_CODES["8031"]["program"] = "PSS"
    TITLE_CODES["8031"]["unit"] = "99"

    TITLE_CODES["8039"] = {}
    TITLE_CODES["8039"]["title"] = "OCCUPATIONAL THER 4 SUPV"
    TITLE_CODES["8039"]["program"] = "PSS"
    TITLE_CODES["8039"]["unit"] = "99"

    TITLE_CODES["8038"] = {}
    TITLE_CODES["8038"]["title"] = "OCCUPATIONAL THER 3 SUPV"
    TITLE_CODES["8038"]["program"] = "PSS"
    TITLE_CODES["8038"]["unit"] = "99"

    TITLE_CODES["3031"] = {}
    TITLE_CODES["3031"]["title"] = "JR ----- IN THE A.E.S.- SFT-VM"
    TITLE_CODES["3031"]["program"] = "ACADEMIC"
    TITLE_CODES["3031"]["unit"] = "FX"

    TITLE_CODES["6451"] = {}
    TITLE_CODES["6451"]["title"] = "PRG REPR 1 SUPV"
    TITLE_CODES["6451"]["program"] = "PSS"
    TITLE_CODES["6451"]["unit"] = "99"

    TITLE_CODES["3294"] = {}
    TITLE_CODES["3294"]["title"] = "ASST RES PROF-MILLER INST- AY"
    TITLE_CODES["3294"]["program"] = "ACADEMIC"
    TITLE_CODES["3294"]["unit"] = "99"

    TITLE_CODES["6453"] = {}
    TITLE_CODES["6453"]["title"] = "PRG REPR 2"
    TITLE_CODES["6453"]["program"] = "PSS"
    TITLE_CODES["6453"]["unit"] = "99"

    TITLE_CODES["6452"] = {}
    TITLE_CODES["6452"]["title"] = "PRG REPR 3"
    TITLE_CODES["6452"]["program"] = "PSS"
    TITLE_CODES["6452"]["unit"] = "99"

    TITLE_CODES["8138"] = {}
    TITLE_CODES["8138"]["title"] = "ELECTRN"
    TITLE_CODES["8138"]["program"] = "PSS"
    TITLE_CODES["8138"]["unit"] = "K3"

    TITLE_CODES["6454"] = {}
    TITLE_CODES["6454"]["title"] = "PRG REPR 1"
    TITLE_CODES["6454"]["program"] = "PSS"
    TITLE_CODES["6454"]["unit"] = "99"

    TITLE_CODES["6901"] = {}
    TITLE_CODES["6901"]["title"] = "ARCHITECTURAL ASC SUPV NEX"
    TITLE_CODES["6901"]["program"] = "PSS"
    TITLE_CODES["6901"]["unit"] = "99"

    TITLE_CODES["3295"] = {}
    TITLE_CODES["3295"]["title"] = "ASST RES PROF-MILLER INST- FY"
    TITLE_CODES["3295"]["program"] = "ACADEMIC"
    TITLE_CODES["3295"]["unit"] = "99"

    TITLE_CODES["8134"] = {}
    TITLE_CODES["8134"]["title"] = "GROUNDS EQUIP OPR"
    TITLE_CODES["8134"]["program"] = "PSS"
    TITLE_CODES["8134"]["unit"] = "SX"

    TITLE_CODES["8522"] = {}
    TITLE_CODES["8522"]["title"] = "FARM MACH MECH SR"
    TITLE_CODES["8522"]["program"] = "PSS"
    TITLE_CODES["8522"]["unit"] = "SX"

    TITLE_CODES["8521"] = {}
    TITLE_CODES["8521"]["title"] = "FARM MACH MECH SR SUPV"
    TITLE_CODES["8521"]["program"] = "PSS"
    TITLE_CODES["8521"]["unit"] = "99"

    TITLE_CODES["8137"] = {}
    TITLE_CODES["8137"]["title"] = "ELECTRN LD"
    TITLE_CODES["8137"]["program"] = "PSS"
    TITLE_CODES["8137"]["unit"] = "K3"

    TITLE_CODES["8130"] = {}
    TITLE_CODES["8130"]["title"] = "GROUNDS SR SUPV EX"
    TITLE_CODES["8130"]["program"] = "PSS"
    TITLE_CODES["8130"]["unit"] = "99"

    TITLE_CODES["3296"] = {}
    TITLE_CODES["3296"]["title"] = "RES FELLOW (WOS)"
    TITLE_CODES["3296"]["program"] = "ACADEMIC"
    TITLE_CODES["3296"]["unit"] = "99"

    TITLE_CODES["8132"] = {}
    TITLE_CODES["8132"]["title"] = "GROUNDSKEEPER LD"
    TITLE_CODES["8132"]["program"] = "PSS"
    TITLE_CODES["8132"]["unit"] = "SX"

    TITLE_CODES["8133"] = {}
    TITLE_CODES["8133"]["title"] = "GROUNDSKEEPER"
    TITLE_CODES["8133"]["program"] = "PSS"
    TITLE_CODES["8133"]["unit"] = "SX"

    TITLE_CODES["3297"] = {}
    TITLE_CODES["3297"]["title"] = "CHI GREEN SCHOLAR-UCSD"
    TITLE_CODES["3297"]["program"] = "ACADEMIC"
    TITLE_CODES["3297"]["unit"] = "99"

    TITLE_CODES["9248"] = {}
    TITLE_CODES["9248"]["title"] = "STAFF PHARMACIST 1"
    TITLE_CODES["9248"]["program"] = "PSS"
    TITLE_CODES["9248"]["unit"] = "HX"

    TITLE_CODES["3290"] = {}
    TITLE_CODES["3290"]["title"] = "RES PROF-MILLER INST-AY"
    TITLE_CODES["3290"]["program"] = "ACADEMIC"
    TITLE_CODES["3290"]["unit"] = "99"

    TITLE_CODES["9721"] = {}
    TITLE_CODES["9721"]["title"] = "MUSEUM SCI PRN"
    TITLE_CODES["9721"]["program"] = "PSS"
    TITLE_CODES["9721"]["unit"] = "99"

    TITLE_CODES["3291"] = {}
    TITLE_CODES["3291"]["title"] = "RES PROF-MILLER INST-FY"
    TITLE_CODES["3291"]["program"] = "ACADEMIC"
    TITLE_CODES["3291"]["unit"] = "99"

    TITLE_CODES["3621"] = {}
    TITLE_CODES["3621"]["title"] = "ASST LIBRARIAN-POTNTL CAREER"
    TITLE_CODES["3621"]["program"] = "ACADEMIC"
    TITLE_CODES["3621"]["unit"] = "LX"

    TITLE_CODES["9022"] = {}
    TITLE_CODES["9022"]["title"] = "RADLG TCHNO SR"
    TITLE_CODES["9022"]["program"] = "PSS"
    TITLE_CODES["9022"]["unit"] = "EX"

    TITLE_CODES["3292"] = {}
    TITLE_CODES["3292"]["title"] = "ASSOC RES PROF-MILLER INST-AY"
    TITLE_CODES["3292"]["program"] = "ACADEMIC"
    TITLE_CODES["3292"]["unit"] = "99"

    TITLE_CODES["9177"] = {}
    TITLE_CODES["9177"]["title"] = "EXAMING PHYSCN"
    TITLE_CODES["9177"]["program"] = "PSS"
    TITLE_CODES["9177"]["unit"] = "99"

    TITLE_CODES["3293"] = {}
    TITLE_CODES["3293"]["title"] = "ASSOC RES PROF-MILLER INST-FY"
    TITLE_CODES["3293"]["program"] = "ACADEMIC"
    TITLE_CODES["3293"]["unit"] = "99"

    TITLE_CODES["0425"] = {}
    TITLE_CODES["0425"]["title"] = "EXEC AST OR SPC AST"
    TITLE_CODES["0425"]["program"] = "MSP"
    TITLE_CODES["0425"]["unit"] = "99"

    TITLE_CODES["0426"] = {}
    TITLE_CODES["0426"]["title"] = "CAMPUS COUNSEL"
    TITLE_CODES["0426"]["program"] = "MSP"
    TITLE_CODES["0426"]["unit"] = "99"

    TITLE_CODES["8966"] = {}
    TITLE_CODES["8966"]["title"] = "ULTRASOUND TCHNO SR"
    TITLE_CODES["8966"]["program"] = "PSS"
    TITLE_CODES["8966"]["unit"] = "EX"

    TITLE_CODES["9282"] = {}
    TITLE_CODES["9282"]["title"] = "PHARMACY TCHN 2"
    TITLE_CODES["9282"]["program"] = "PSS"
    TITLE_CODES["9282"]["unit"] = "EX"

    TITLE_CODES["9605"] = {}
    TITLE_CODES["9605"]["title"] = "LAB AST 1"
    TITLE_CODES["9605"]["program"] = "PSS"
    TITLE_CODES["9605"]["unit"] = "TX"

    TITLE_CODES["7163"] = {}
    TITLE_CODES["7163"]["title"] = "ENGR AID"
    TITLE_CODES["7163"]["program"] = "PSS"
    TITLE_CODES["7163"]["unit"] = "TX"

    TITLE_CODES["4115"] = {}
    TITLE_CODES["4115"]["title"] = "PLACEMENT INTERVIEWER SUPV"
    TITLE_CODES["4115"]["program"] = "PSS"
    TITLE_CODES["4115"]["unit"] = "99"

    TITLE_CODES["8453"] = {}
    TITLE_CODES["8453"]["title"] = "AIRPORT SVC WORKER"
    TITLE_CODES["8453"]["program"] = "PSS"
    TITLE_CODES["8453"]["unit"] = "SX"

    TITLE_CODES["8452"] = {}
    TITLE_CODES["8452"]["title"] = "AIRPORT SVC SUPV"
    TITLE_CODES["8452"]["program"] = "PSS"
    TITLE_CODES["8452"]["unit"] = "99"

    TITLE_CODES["9500"] = {}
    TITLE_CODES["9500"]["title"] = "OCCUPATIONAL THER PD"
    TITLE_CODES["9500"]["program"] = "PSS"
    TITLE_CODES["9500"]["unit"] = "HX"

    TITLE_CODES["4119"] = {}
    TITLE_CODES["4119"]["title"] = "RSDT ADVISOR SR SUPV"
    TITLE_CODES["4119"]["program"] = "PSS"
    TITLE_CODES["4119"]["unit"] = "99"

    TITLE_CODES["7668"] = {}
    TITLE_CODES["7668"]["title"] = "PARALEGAL SPEC SUPV"
    TITLE_CODES["7668"]["program"] = "PSS"
    TITLE_CODES["7668"]["unit"] = "99"

    TITLE_CODES["8949"] = {}
    TITLE_CODES["8949"]["title"] = "OCCUPATIONAL THER CERT AST 1"
    TITLE_CODES["8949"]["program"] = "PSS"
    TITLE_CODES["8949"]["unit"] = "EX"

    TITLE_CODES["7425"] = {}
    TITLE_CODES["7425"]["title"] = "RSDNC HALLS MGR AST"
    TITLE_CODES["7425"]["program"] = "PSS"
    TITLE_CODES["7425"]["unit"] = "99"

    TITLE_CODES["7424"] = {}
    TITLE_CODES["7424"]["title"] = "RSDNC HALLS MGR"
    TITLE_CODES["7424"]["program"] = "PSS"
    TITLE_CODES["7424"]["unit"] = "99"

    TITLE_CODES["8632"] = {}
    TITLE_CODES["8632"]["title"] = "OFC MACHINE TCHN 3"
    TITLE_CODES["8632"]["program"] = "PSS"
    TITLE_CODES["8632"]["unit"] = "99"

    TITLE_CODES["8948"] = {}
    TITLE_CODES["8948"]["title"] = "OCCUPATIONAL THER CERT AST 2"
    TITLE_CODES["8948"]["program"] = "PSS"
    TITLE_CODES["8948"]["unit"] = "EX"

    TITLE_CODES["7540"] = {}
    TITLE_CODES["7540"]["title"] = "AST TO DEAN DIR CHAIR 2"
    TITLE_CODES["7540"]["program"] = "PSS"
    TITLE_CODES["7540"]["unit"] = "99"

    TITLE_CODES["7541"] = {}
    TITLE_CODES["7541"]["title"] = "AST TO DEAN DIR CHAIR 1"
    TITLE_CODES["7541"]["program"] = "PSS"
    TITLE_CODES["7541"]["unit"] = "99"

    TITLE_CODES["9224"] = {}
    TITLE_CODES["9224"]["title"] = "MED OFC SVC CRD 3 PD"
    TITLE_CODES["9224"]["program"] = "PSS"
    TITLE_CODES["9224"]["unit"] = "EX"

    TITLE_CODES["8641"] = {}
    TITLE_CODES["8641"]["title"] = "MED CTR DEV TCHN 4"
    TITLE_CODES["8641"]["program"] = "PSS"
    TITLE_CODES["8641"]["unit"] = "EX"

    TITLE_CODES["3353"] = {}
    TITLE_CODES["3353"]["title"] = "PROF IN RES-AY-1/9"
    TITLE_CODES["3353"]["program"] = "ACADEMIC"
    TITLE_CODES["3353"]["unit"] = "A3"

    TITLE_CODES["3352"] = {}
    TITLE_CODES["3352"]["title"] = "ASSOC PROF IN RES-AY-1/9"
    TITLE_CODES["3352"]["program"] = "ACADEMIC"
    TITLE_CODES["3352"]["unit"] = "A3"

    TITLE_CODES["9261"] = {}
    TITLE_CODES["9261"]["title"] = "MED RCDS ADM PRN"
    TITLE_CODES["9261"]["program"] = "PSS"
    TITLE_CODES["9261"]["unit"] = "99"

    TITLE_CODES["9174"] = {}
    TITLE_CODES["9174"]["title"] = "PULMONARY TCHN 2"
    TITLE_CODES["9174"]["program"] = "PSS"
    TITLE_CODES["9174"]["unit"] = "EX"

    TITLE_CODES["7263"] = {}
    TITLE_CODES["7263"]["title"] = "PUBL ADMST ANL"
    TITLE_CODES["7263"]["program"] = "PSS"
    TITLE_CODES["7263"]["unit"] = "99"

    TITLE_CODES["9116"] = {}
    TITLE_CODES["9116"]["title"] = "HOME HEALTH NURSE 3"
    TITLE_CODES["9116"]["program"] = "PSS"
    TITLE_CODES["9116"]["unit"] = "NX"

    TITLE_CODES["9473"] = {}
    TITLE_CODES["9473"]["title"] = "SPEECH PATHOLOGIST"
    TITLE_CODES["9473"]["program"] = "PSS"
    TITLE_CODES["9473"]["unit"] = "HX"

    TITLE_CODES["6767"] = {}
    TITLE_CODES["6767"]["title"] = "LIBRARY AST 2 SUPV"
    TITLE_CODES["6767"]["program"] = "PSS"
    TITLE_CODES["6767"]["unit"] = "99"

    TITLE_CODES["6766"] = {}
    TITLE_CODES["6766"]["title"] = "LIBRARY AST 3 SUPV"
    TITLE_CODES["6766"]["program"] = "PSS"
    TITLE_CODES["6766"]["unit"] = "99"

    TITLE_CODES["6765"] = {}
    TITLE_CODES["6765"]["title"] = "LIBRARY AST 4 SUPV"
    TITLE_CODES["6765"]["program"] = "PSS"
    TITLE_CODES["6765"]["unit"] = "99"

    TITLE_CODES["8258"] = {}
    TITLE_CODES["8258"]["title"] = "PLUMBER"
    TITLE_CODES["8258"]["program"] = "PSS"
    TITLE_CODES["8258"]["unit"] = "K3"

    TITLE_CODES["6762"] = {}
    TITLE_CODES["6762"]["title"] = "LIBRARY AST 1"
    TITLE_CODES["6762"]["program"] = "PSS"
    TITLE_CODES["6762"]["unit"] = "CX"

    TITLE_CODES["6761"] = {}
    TITLE_CODES["6761"]["title"] = "LIBRARY AST 2"
    TITLE_CODES["6761"]["program"] = "PSS"
    TITLE_CODES["6761"]["unit"] = "CX"

    TITLE_CODES["6760"] = {}
    TITLE_CODES["6760"]["title"] = "LIBRARY AST 3"
    TITLE_CODES["6760"]["program"] = "PSS"
    TITLE_CODES["6760"]["unit"] = "CX"

    TITLE_CODES["7667"] = {}
    TITLE_CODES["7667"]["title"] = "PARALEGAL SPEC"
    TITLE_CODES["7667"]["program"] = "PSS"
    TITLE_CODES["7667"]["unit"] = "99"

    TITLE_CODES["9537"] = {}
    TITLE_CODES["9537"]["title"] = "ANIMAL HEALTH TCHN 1"
    TITLE_CODES["9537"]["program"] = "PSS"
    TITLE_CODES["9537"]["unit"] = "TX"

    TITLE_CODES["5864"] = {}
    TITLE_CODES["5864"]["title"] = "DRAPERY MAKER"
    TITLE_CODES["5864"]["program"] = "PSS"
    TITLE_CODES["5864"]["unit"] = "SX"

    TITLE_CODES["9269"] = {}
    TITLE_CODES["9269"]["title"] = "MED RCDS ADM SUPV"
    TITLE_CODES["9269"]["program"] = "PSS"
    TITLE_CODES["9269"]["unit"] = "99"

    TITLE_CODES["9258"] = {}
    TITLE_CODES["9258"]["title"] = "HOSP UNIT SVC CRD 2"
    TITLE_CODES["9258"]["program"] = "PSS"
    TITLE_CODES["9258"]["unit"] = "EX"

    TITLE_CODES["3600"] = {}
    TITLE_CODES["3600"]["title"] = "ASSOC UNIV LIBRARIAN"
    TITLE_CODES["3600"]["program"] = "ACADEMIC"
    TITLE_CODES["3600"]["unit"] = "99"

    TITLE_CODES["6954"] = {}
    TITLE_CODES["6954"]["title"] = "ARCHITECTURAL ASC EX"
    TITLE_CODES["6954"]["program"] = "PSS"
    TITLE_CODES["6954"]["unit"] = "99"

    TITLE_CODES["9353"] = {}
    TITLE_CODES["9353"]["title"] = "CHILD LIFE SPEC 1"
    TITLE_CODES["9353"]["program"] = "PSS"
    TITLE_CODES["9353"]["unit"] = "HX"

    TITLE_CODES["9259"] = {}
    TITLE_CODES["9259"]["title"] = "HOSP UNIT SVC CRD 1"
    TITLE_CODES["9259"]["program"] = "PSS"
    TITLE_CODES["9259"]["unit"] = "EX"

    TITLE_CODES["9498"] = {}
    TITLE_CODES["9498"]["title"] = "OCCUPATIONAL THER 2"
    TITLE_CODES["9498"]["program"] = "PSS"
    TITLE_CODES["9498"]["unit"] = "HX"

    TITLE_CODES["9032"] = {}
    TITLE_CODES["9032"]["title"] = "ADMITTING WORKER SR"
    TITLE_CODES["9032"]["program"] = "PSS"
    TITLE_CODES["9032"]["unit"] = "EX"

    TITLE_CODES["8682"] = {}
    TITLE_CODES["8682"]["title"] = "MED CTR ELECTR TCHN SR"
    TITLE_CODES["8682"]["program"] = "PSS"
    TITLE_CODES["8682"]["unit"] = "EX"

    TITLE_CODES["2211"] = {}
    TITLE_CODES["2211"]["title"] = "DEMO TEACHER-CONTINUING"
    TITLE_CODES["2211"]["program"] = "ACADEMIC"
    TITLE_CODES["2211"]["unit"] = "IX"

    TITLE_CODES["2210"] = {}
    TITLE_CODES["2210"]["title"] = "DEMO TEACHER"
    TITLE_CODES["2210"]["program"] = "ACADEMIC"
    TITLE_CODES["2210"]["unit"] = "IX"

    TITLE_CODES["6119"] = {}
    TITLE_CODES["6119"]["title"] = "AV AND PHOTO SVC SUPV"
    TITLE_CODES["6119"]["program"] = "PSS"
    TITLE_CODES["6119"]["unit"] = "99"

    TITLE_CODES["6450"] = {}
    TITLE_CODES["6450"]["title"] = "PRG REPR SUPV"
    TITLE_CODES["6450"]["program"] = "PSS"
    TITLE_CODES["6450"]["unit"] = "99"

    TITLE_CODES["6114"] = {}
    TITLE_CODES["6114"]["title"] = "ILLUSTRATOR AST"
    TITLE_CODES["6114"]["program"] = "PSS"
    TITLE_CODES["6114"]["unit"] = "TX"

    TITLE_CODES["7274"] = {}
    TITLE_CODES["7274"]["title"] = "PROGR ANL 3 SUPV"
    TITLE_CODES["7274"]["program"] = "PSS"
    TITLE_CODES["7274"]["unit"] = "99"

    TITLE_CODES["6110"] = {}
    TITLE_CODES["6110"]["title"] = "ILLUSTRATOR PRN SUPV"
    TITLE_CODES["6110"]["program"] = "PSS"
    TITLE_CODES["6110"]["unit"] = "99"

    TITLE_CODES["6111"] = {}
    TITLE_CODES["6111"]["title"] = "ILLUSTRATOR PRN"
    TITLE_CODES["6111"]["program"] = "PSS"
    TITLE_CODES["6111"]["unit"] = "TX"

    TITLE_CODES["6112"] = {}
    TITLE_CODES["6112"]["title"] = "ILLUSTRATOR SR"
    TITLE_CODES["6112"]["program"] = "PSS"
    TITLE_CODES["6112"]["unit"] = "TX"

    TITLE_CODES["6113"] = {}
    TITLE_CODES["6113"]["title"] = "ILLUSTRATOR"
    TITLE_CODES["6113"]["program"] = "PSS"
    TITLE_CODES["6113"]["unit"] = "TX"

    TITLE_CODES["6904"] = {}
    TITLE_CODES["6904"]["title"] = "ARCHITECTURAL ASC SR"
    TITLE_CODES["6904"]["program"] = "PSS"
    TITLE_CODES["6904"]["unit"] = "99"

    TITLE_CODES["6693"] = {}
    TITLE_CODES["6693"]["title"] = "TRANSLATOR NONTECHNICAL"
    TITLE_CODES["6693"]["program"] = "PSS"
    TITLE_CODES["6693"]["unit"] = "TX"

    TITLE_CODES["9033"] = {}
    TITLE_CODES["9033"]["title"] = "ADMITTING WORKER"
    TITLE_CODES["9033"]["program"] = "PSS"
    TITLE_CODES["9033"]["unit"] = "EX"

    TITLE_CODES["6695"] = {}
    TITLE_CODES["6695"]["title"] = "TRANSLATOR PD"
    TITLE_CODES["6695"]["program"] = "PSS"
    TITLE_CODES["6695"]["unit"] = "TX"

    TITLE_CODES["6694"] = {}
    TITLE_CODES["6694"]["title"] = "TRANSLATOR TCHL"
    TITLE_CODES["6694"]["program"] = "PSS"
    TITLE_CODES["6694"]["unit"] = "TX"

    TITLE_CODES["9099"] = {}
    TITLE_CODES["9099"]["title"] = "ACCESS REPR PRN"
    TITLE_CODES["9099"]["program"] = "PSS"
    TITLE_CODES["9099"]["unit"] = "EX"

    TITLE_CODES["0150"] = {}
    TITLE_CODES["0150"]["title"] = "AST TO CHAN FUNC AREA"
    TITLE_CODES["0150"]["program"] = "MSP"
    TITLE_CODES["0150"]["unit"] = "99"

    TITLE_CODES["7281"] = {}
    TITLE_CODES["7281"]["title"] = "PROGR 1"
    TITLE_CODES["7281"]["program"] = "PSS"
    TITLE_CODES["7281"]["unit"] = "99"

    TITLE_CODES["5440"] = {}
    TITLE_CODES["5440"]["title"] = "EXEC CHEF"
    TITLE_CODES["5440"]["program"] = "PSS"
    TITLE_CODES["5440"]["unit"] = "99"

    TITLE_CODES["0155"] = {}
    TITLE_CODES["0155"]["title"] = "SPC AST TO CHAN FUNC AREA"
    TITLE_CODES["0155"]["program"] = "MSP"
    TITLE_CODES["0155"]["unit"] = "99"

    TITLE_CODES["7286"] = {}
    TITLE_CODES["7286"]["title"] = "PROGR 4"
    TITLE_CODES["7286"]["program"] = "PSS"
    TITLE_CODES["7286"]["unit"] = "99"

    TITLE_CODES["7285"] = {}
    TITLE_CODES["7285"]["title"] = "PROGR 3"
    TITLE_CODES["7285"]["program"] = "PSS"
    TITLE_CODES["7285"]["unit"] = "99"

    TITLE_CODES["7284"] = {}
    TITLE_CODES["7284"]["title"] = "PROGR 2"
    TITLE_CODES["7284"]["program"] = "PSS"
    TITLE_CODES["7284"]["unit"] = "99"

    TITLE_CODES["9106"] = {}
    TITLE_CODES["9106"]["title"] = "ULTRASOUND TCHNO PD"
    TITLE_CODES["9106"]["program"] = "PSS"
    TITLE_CODES["9106"]["unit"] = "EX"

    TITLE_CODES["7289"] = {}
    TITLE_CODES["7289"]["title"] = "PROGR 7"
    TITLE_CODES["7289"]["program"] = "PSS"
    TITLE_CODES["7289"]["unit"] = "99"

    TITLE_CODES["6900"] = {}
    TITLE_CODES["6900"]["title"] = "ARCHITECTURAL ASC PRN SUPV"
    TITLE_CODES["6900"]["program"] = "PSS"
    TITLE_CODES["6900"]["unit"] = "99"

    TITLE_CODES["9103"] = {}
    TITLE_CODES["9103"]["title"] = "RESP THER 4 SUPV"
    TITLE_CODES["9103"]["program"] = "PSS"
    TITLE_CODES["9103"]["unit"] = "99"

    TITLE_CODES["9100"] = {}
    TITLE_CODES["9100"]["title"] = "ACCESS REPR PRN SUPV"
    TITLE_CODES["9100"]["program"] = "PSS"
    TITLE_CODES["9100"]["unit"] = "99"

    TITLE_CODES["9101"] = {}
    TITLE_CODES["9101"]["title"] = "ACCESS SUPV"
    TITLE_CODES["9101"]["program"] = "PSS"
    TITLE_CODES["9101"]["unit"] = "99"

    TITLE_CODES["8986"] = {}
    TITLE_CODES["8986"]["title"] = "CYTOGENETIC TCHNO SUPV"
    TITLE_CODES["8986"]["program"] = "PSS"
    TITLE_CODES["8986"]["unit"] = "99"

    TITLE_CODES["8523"] = {}
    TITLE_CODES["8523"]["title"] = "FARM MACH MECH"
    TITLE_CODES["8523"]["program"] = "PSS"
    TITLE_CODES["8523"]["unit"] = "SX"

    TITLE_CODES["1898"] = {}
    TITLE_CODES["1898"]["title"] = "ACT ASST PROF-SFT-VM"
    TITLE_CODES["1898"]["program"] = "ACADEMIC"
    TITLE_CODES["1898"]["unit"] = "99"

    TITLE_CODES["1899"] = {}
    TITLE_CODES["1899"]["title"] = "ASSOC PROF-SFT-VM"
    TITLE_CODES["1899"]["program"] = "ACADEMIC"
    TITLE_CODES["1899"]["unit"] = "A3"

    TITLE_CODES["9239"] = {}
    TITLE_CODES["9239"]["title"] = "PHLEBOTOMIST"
    TITLE_CODES["9239"]["program"] = "PSS"
    TITLE_CODES["9239"]["unit"] = "EX"

    TITLE_CODES["1895"] = {}
    TITLE_CODES["1895"]["title"] = "INSTR-SFT-VM"
    TITLE_CODES["1895"]["program"] = "ACADEMIC"
    TITLE_CODES["1895"]["unit"] = "A3"

    TITLE_CODES["6953"] = {}
    TITLE_CODES["6953"]["title"] = "ARCHITECT SR"
    TITLE_CODES["6953"]["program"] = "PSS"
    TITLE_CODES["6953"]["unit"] = "99"

    TITLE_CODES["1897"] = {}
    TITLE_CODES["1897"]["title"] = "ASST PROF-SFT-VM"
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
    TITLE_CODES["4691"]["title"] = "GRAPHIC COMPOSITOR SR"
    TITLE_CODES["4691"]["program"] = "PSS"
    TITLE_CODES["4691"]["unit"] = "CX"

    TITLE_CODES["4922"] = {}
    TITLE_CODES["4922"]["title"] = "STDT 1"
    TITLE_CODES["4922"]["program"] = "PSS"
    TITLE_CODES["4922"]["unit"] = "99"

    TITLE_CODES["4921"] = {}
    TITLE_CODES["4921"]["title"] = "STDT 2"
    TITLE_CODES["4921"]["program"] = "PSS"
    TITLE_CODES["4921"]["unit"] = "99"

    TITLE_CODES["4692"] = {}
    TITLE_CODES["4692"]["title"] = "GRAPHIC COMPOSITOR"
    TITLE_CODES["4692"]["program"] = "PSS"
    TITLE_CODES["4692"]["unit"] = "CX"

    TITLE_CODES["4694"] = {}
    TITLE_CODES["4694"]["title"] = "GRAPHIC COMPOSITOR SR SUPV"
    TITLE_CODES["4694"]["program"] = "PSS"
    TITLE_CODES["4694"]["unit"] = "99"

    TITLE_CODES["4925"] = {}
    TITLE_CODES["4925"]["title"] = "STDT 4 NON UC"
    TITLE_CODES["4925"]["program"] = "PSS"
    TITLE_CODES["4925"]["unit"] = "99"

    TITLE_CODES["4924"] = {}
    TITLE_CODES["4924"]["title"] = "STDT 3 NON UC"
    TITLE_CODES["4924"]["program"] = "PSS"
    TITLE_CODES["4924"]["unit"] = "99"

    TITLE_CODES["9146"] = {}
    TITLE_CODES["9146"]["title"] = "NURSE PRACTITIONER 3"
    TITLE_CODES["9146"]["program"] = "PSS"
    TITLE_CODES["9146"]["unit"] = "NX"

    TITLE_CODES["1768"] = {}
    TITLE_CODES["1768"]["title"] = "ASST ADJUNCT PROF-MEDCOMP-B"
    TITLE_CODES["1768"]["program"] = "ACADEMIC"
    TITLE_CODES["1768"]["unit"] = "99"

    TITLE_CODES["8981"] = {}
    TITLE_CODES["8981"]["title"] = "HOSP LAB TCHN 4 PD"
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
    TITLE_CODES["5095"]["title"] = "MED CTR FOOD SVC WORKER SR PD"
    TITLE_CODES["5095"]["program"] = "PSS"
    TITLE_CODES["5095"]["unit"] = "SX"

    TITLE_CODES["2851"] = {}
    TITLE_CODES["2851"]["title"] = "READER-NON GSHIP"
    TITLE_CODES["2851"]["program"] = "ACADEMIC"
    TITLE_CODES["2851"]["unit"] = "BX"

    TITLE_CODES["8524"] = {}
    TITLE_CODES["8524"]["title"] = "FARM MACH MECH AST"
    TITLE_CODES["8524"]["program"] = "PSS"
    TITLE_CODES["8524"]["unit"] = "SX"

    TITLE_CODES["2500"] = {}
    TITLE_CODES["2500"]["title"] = "READER-NON STDNT"
    TITLE_CODES["2500"]["program"] = "ACADEMIC"
    TITLE_CODES["2500"]["unit"] = "BX"

    TITLE_CODES["2727"] = {}
    TITLE_CODES["2727"]["title"] = "POST DDS I-VI/NON REP"
    TITLE_CODES["2727"]["program"] = "ACADEMIC"
    TITLE_CODES["2727"]["unit"] = "99"

    TITLE_CODES["2726"] = {}
    TITLE_CODES["2726"]["title"] = "RESID PHYS/SUBSPEC 4-8/NON REP"
    TITLE_CODES["2726"]["program"] = "ACADEMIC"
    TITLE_CODES["2726"]["unit"] = "99"

    TITLE_CODES["2725"] = {}
    TITLE_CODES["2725"]["title"] = "CHIEF RESID PHYS-NON REP"
    TITLE_CODES["2725"]["program"] = "ACADEMIC"
    TITLE_CODES["2725"]["unit"] = "99"

    TITLE_CODES["2724"] = {}
    TITLE_CODES["2724"]["title"] = "RESID PHYS II-VIII/NON REP"
    TITLE_CODES["2724"]["program"] = "ACADEMIC"
    TITLE_CODES["2724"]["unit"] = "99"

    TITLE_CODES["2723"] = {}
    TITLE_CODES["2723"]["title"] = "RESID PHYS II-VIII/REP"
    TITLE_CODES["2723"]["program"] = "ACADEMIC"
    TITLE_CODES["2723"]["unit"] = "M3"

    TITLE_CODES["9356"] = {}
    TITLE_CODES["9356"]["title"] = "MED INTERPRETER 2"
    TITLE_CODES["9356"]["program"] = "PSS"
    TITLE_CODES["9356"]["unit"] = "HX"

    TITLE_CODES["9355"] = {}
    TITLE_CODES["9355"]["title"] = "MED INTERPRETER 1"
    TITLE_CODES["9355"]["program"] = "PSS"
    TITLE_CODES["9355"]["unit"] = "HX"

    TITLE_CODES["9354"] = {}
    TITLE_CODES["9354"]["title"] = "CHILD LIFE MGR"
    TITLE_CODES["9354"]["program"] = "PSS"
    TITLE_CODES["9354"]["unit"] = "99"

    TITLE_CODES["9609"] = {}
    TITLE_CODES["9609"]["title"] = "SRA 5"
    TITLE_CODES["9609"]["program"] = "PSS"
    TITLE_CODES["9609"]["unit"] = "99"

    TITLE_CODES["9397"] = {}
    TITLE_CODES["9397"]["title"] = "GI ENDOSCOPY TCHN 2"
    TITLE_CODES["9397"]["program"] = "PSS"
    TITLE_CODES["9397"]["unit"] = "EX"

    TITLE_CODES["8980"] = {}
    TITLE_CODES["8980"]["title"] = "HOSP LAB TCHN 1 PD"
    TITLE_CODES["8980"]["program"] = "PSS"
    TITLE_CODES["8980"]["unit"] = "EX"

    TITLE_CODES["2729"] = {}
    TITLE_CODES["2729"]["title"] = "PGY II PHARMACY RESID/NON REP"
    TITLE_CODES["2729"]["program"] = "ACADEMIC"
    TITLE_CODES["2729"]["unit"] = "99"

    TITLE_CODES["2728"] = {}
    TITLE_CODES["2728"]["title"] = "PGY I PHARMACY RESID/NON REP"
    TITLE_CODES["2728"]["program"] = "ACADEMIC"
    TITLE_CODES["2728"]["unit"] = "99"

    TITLE_CODES["7236"] = {}
    TITLE_CODES["7236"]["title"] = "ANL 3"
    TITLE_CODES["7236"]["program"] = "PSS"
    TITLE_CODES["7236"]["unit"] = "99"

    TITLE_CODES["7237"] = {}
    TITLE_CODES["7237"]["title"] = "ANL 4"
    TITLE_CODES["7237"]["program"] = "PSS"
    TITLE_CODES["7237"]["unit"] = "99"

    TITLE_CODES["7234"] = {}
    TITLE_CODES["7234"]["title"] = "ANL 1"
    TITLE_CODES["7234"]["program"] = "PSS"
    TITLE_CODES["7234"]["unit"] = "99"

    TITLE_CODES["7235"] = {}
    TITLE_CODES["7235"]["title"] = "ANL 2"
    TITLE_CODES["7235"]["program"] = "PSS"
    TITLE_CODES["7235"]["unit"] = "99"

    TITLE_CODES["7232"] = {}
    TITLE_CODES["7232"]["title"] = "SURVEY WORKER SR"
    TITLE_CODES["7232"]["program"] = "PSS"
    TITLE_CODES["7232"]["unit"] = "CX"

    TITLE_CODES["7233"] = {}
    TITLE_CODES["7233"]["title"] = "SURVEY WORKER"
    TITLE_CODES["7233"]["program"] = "PSS"
    TITLE_CODES["7233"]["unit"] = "CX"

    TITLE_CODES["2850"] = {}
    TITLE_CODES["2850"]["title"] = "READER-GSHIP"
    TITLE_CODES["2850"]["program"] = "ACADEMIC"
    TITLE_CODES["2850"]["unit"] = "BX"

    TITLE_CODES["5048"] = {}
    TITLE_CODES["5048"]["title"] = "MED CTR FOOD SVC SUPV 1"
    TITLE_CODES["5048"]["program"] = "PSS"
    TITLE_CODES["5048"]["unit"] = "99"

    TITLE_CODES["9199"] = {}
    TITLE_CODES["9199"]["title"] = "DENTAL AST"
    TITLE_CODES["9199"]["program"] = "PSS"
    TITLE_CODES["9199"]["unit"] = "EX"

    TITLE_CODES["9213"] = {}
    TITLE_CODES["9213"]["title"] = "MED OFC SVC CRD 2"
    TITLE_CODES["9213"]["program"] = "PSS"
    TITLE_CODES["9213"]["unit"] = "EX"

    TITLE_CODES["9210"] = {}
    TITLE_CODES["9210"]["title"] = "MED OFC SVC CRD 1 PD"
    TITLE_CODES["9210"]["program"] = "PSS"
    TITLE_CODES["9210"]["unit"] = "EX"

    TITLE_CODES["9211"] = {}
    TITLE_CODES["9211"]["title"] = "MED OFC SVC CRD 2 PD"
    TITLE_CODES["9211"]["program"] = "PSS"
    TITLE_CODES["9211"]["unit"] = "EX"

    TITLE_CODES["9216"] = {}
    TITLE_CODES["9216"]["title"] = "MED OFC SVC CRD 4"
    TITLE_CODES["9216"]["program"] = "PSS"
    TITLE_CODES["9216"]["unit"] = "EX"

    TITLE_CODES["9217"] = {}
    TITLE_CODES["9217"]["title"] = "MED OFC SVC CRD 4 SUPV"
    TITLE_CODES["9217"]["program"] = "PSS"
    TITLE_CODES["9217"]["unit"] = "99"

    TITLE_CODES["7238"] = {}
    TITLE_CODES["7238"]["title"] = "ANL 5"
    TITLE_CODES["7238"]["program"] = "PSS"
    TITLE_CODES["7238"]["unit"] = "99"

    TITLE_CODES["7239"] = {}
    TITLE_CODES["7239"]["title"] = "ANL 6"
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
    TITLE_CODES["8992"]["title"] = "MED AST PD"
    TITLE_CODES["8992"]["program"] = "PSS"
    TITLE_CODES["8992"]["unit"] = "EX"

    TITLE_CODES["3422"] = {}
    TITLE_CODES["3422"]["title"] = "VST ASST COOP EXT SPECIALIST"
    TITLE_CODES["3422"]["program"] = "ACADEMIC"
    TITLE_CODES["3422"]["unit"] = "99"

    TITLE_CODES["8990"] = {}
    TITLE_CODES["8990"]["title"] = "RADLG TCHNO SR PD"
    TITLE_CODES["8990"]["program"] = "PSS"
    TITLE_CODES["8990"]["unit"] = "EX"

    TITLE_CODES["8991"] = {}
    TITLE_CODES["8991"]["title"] = "MED AST 2 PD"
    TITLE_CODES["8991"]["program"] = "PSS"
    TITLE_CODES["8991"]["unit"] = "EX"

    TITLE_CODES["8997"] = {}
    TITLE_CODES["8997"]["title"] = "CYTO TCHNO SR PD"
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
    TITLE_CODES["6334"]["title"] = "SCENE TCHN AST"
    TITLE_CODES["6334"]["program"] = "PSS"
    TITLE_CODES["6334"]["unit"] = "TX"

    TITLE_CODES["2003"] = {}
    TITLE_CODES["2003"]["title"] = "CLIN PROF DENT-AY-PTC GENCO"
    TITLE_CODES["2003"]["program"] = "ACADEMIC"
    TITLE_CODES["2003"]["unit"] = "99"

    TITLE_CODES["2000"] = {}
    TITLE_CODES["2000"]["title"] = "HS CLIN PROF-AY"
    TITLE_CODES["2000"]["program"] = "ACADEMIC"
    TITLE_CODES["2000"]["unit"] = "99"

    TITLE_CODES["2001"] = {}
    TITLE_CODES["2001"]["title"] = "CLIN PROF-DENTISTRY-50%/+ AY"
    TITLE_CODES["2001"]["program"] = "ACADEMIC"
    TITLE_CODES["2001"]["unit"] = "99"

    TITLE_CODES["2853"] = {}
    TITLE_CODES["2853"]["title"] = "SPECIAL READER-UCLA-NON GSHIP"
    TITLE_CODES["2853"]["program"] = "ACADEMIC"
    TITLE_CODES["2853"]["unit"] = "BX"

    TITLE_CODES["6331"] = {}
    TITLE_CODES["6331"]["title"] = "THEATER PROD SUPV"
    TITLE_CODES["6331"]["program"] = "PSS"
    TITLE_CODES["6331"]["unit"] = "99"

    TITLE_CODES["6332"] = {}
    TITLE_CODES["6332"]["title"] = "SCENE TCHN SR"
    TITLE_CODES["6332"]["program"] = "PSS"
    TITLE_CODES["6332"]["unit"] = "TX"

    TITLE_CODES["6333"] = {}
    TITLE_CODES["6333"]["title"] = "SCENE TCHN"
    TITLE_CODES["6333"]["program"] = "PSS"
    TITLE_CODES["6333"]["unit"] = "TX"

    TITLE_CODES["9458"] = {}
    TITLE_CODES["9458"]["title"] = "ATH TRAINER"
    TITLE_CODES["9458"]["program"] = "PSS"
    TITLE_CODES["9458"]["unit"] = "99"

    TITLE_CODES["6975"] = {}
    TITLE_CODES["6975"]["title"] = "DESIGN CONST PROJECT MGR 2"
    TITLE_CODES["6975"]["program"] = "PSS"
    TITLE_CODES["6975"]["unit"] = "99"

    TITLE_CODES["9076"] = {}
    TITLE_CODES["9076"]["title"] = "RADLG TCHNO CHF SUPV"
    TITLE_CODES["9076"]["program"] = "PSS"
    TITLE_CODES["9076"]["unit"] = "99"

    TITLE_CODES["9077"] = {}
    TITLE_CODES["9077"]["title"] = "RADLG TCHNO ASC SUPV"
    TITLE_CODES["9077"]["program"] = "PSS"
    TITLE_CODES["9077"]["unit"] = "99"

    TITLE_CODES["9075"] = {}
    TITLE_CODES["9075"]["title"] = "RAD THER TCHNO CHF SUPV"
    TITLE_CODES["9075"]["program"] = "PSS"
    TITLE_CODES["9075"]["unit"] = "99"

    TITLE_CODES["9072"] = {}
    TITLE_CODES["9072"]["title"] = "RADLG EQUIP SPEC SR"
    TITLE_CODES["9072"]["program"] = "PSS"
    TITLE_CODES["9072"]["unit"] = "EX"

    TITLE_CODES["7053"] = {}
    TITLE_CODES["7053"]["title"] = "LANDSCAPE ARCHITECT ASC"
    TITLE_CODES["7053"]["program"] = "PSS"
    TITLE_CODES["7053"]["unit"] = "99"

    TITLE_CODES["6960"] = {}
    TITLE_CODES["6960"]["title"] = "EDUC FAC PLANNER SUPV"
    TITLE_CODES["6960"]["program"] = "PSS"
    TITLE_CODES["6960"]["unit"] = "99"

    TITLE_CODES["8257"] = {}
    TITLE_CODES["8257"]["title"] = "PLUMBER LD"
    TITLE_CODES["8257"]["program"] = "PSS"
    TITLE_CODES["8257"]["unit"] = "K3"

    TITLE_CODES["9078"] = {}
    TITLE_CODES["9078"]["title"] = "MAMMOGRAPHY TCHNO PD"
    TITLE_CODES["9078"]["program"] = "PSS"
    TITLE_CODES["9078"]["unit"] = "EX"

    TITLE_CODES["9025"] = {}
    TITLE_CODES["9025"]["title"] = "RADLG TCHNO PD"
    TITLE_CODES["9025"]["program"] = "PSS"
    TITLE_CODES["9025"]["unit"] = "EX"

    TITLE_CODES["9034"] = {}
    TITLE_CODES["9034"]["title"] = "ADMITTING WORKER PD"
    TITLE_CODES["9034"]["program"] = "PSS"
    TITLE_CODES["9034"]["unit"] = "EX"

    TITLE_CODES["9024"] = {}
    TITLE_CODES["9024"]["title"] = "RADLG TCHNO TRAINEE"
    TITLE_CODES["9024"]["program"] = "PSS"
    TITLE_CODES["9024"]["unit"] = "EX"

    TITLE_CODES["6965"] = {}
    TITLE_CODES["6965"]["title"] = "FAC REQUIREMENTS ANL"
    TITLE_CODES["6965"]["program"] = "PSS"
    TITLE_CODES["6965"]["unit"] = "99"

    TITLE_CODES["9999"] = {}
    TITLE_CODES["9999"]["title"] = "UNCLASSIFIED"
    TITLE_CODES["9999"]["program"] = "PSS"
    TITLE_CODES["9999"]["unit"] = "99"

    TITLE_CODES["7003"] = {}
    TITLE_CODES["7003"]["title"] = "CONST INSP ASC"
    TITLE_CODES["7003"]["program"] = "PSS"
    TITLE_CODES["7003"]["unit"] = "TX"

    TITLE_CODES["8306"] = {}
    TITLE_CODES["8306"]["title"] = "MED CTR BLDG MAINT WORKER SR"
    TITLE_CODES["8306"]["program"] = "PSS"
    TITLE_CODES["8306"]["unit"] = "SX"

    TITLE_CODES["6964"] = {}
    TITLE_CODES["6964"]["title"] = "FAC REQUIREMENTS ANL SR"
    TITLE_CODES["6964"]["program"] = "PSS"
    TITLE_CODES["6964"]["unit"] = "99"

    TITLE_CODES["3258"] = {}
    TITLE_CODES["3258"]["title"] = "ADJ PROF-AY"
    TITLE_CODES["3258"]["program"] = "ACADEMIC"
    TITLE_CODES["3258"]["unit"] = "99"

    TITLE_CODES["3259"] = {}
    TITLE_CODES["3259"]["title"] = "ADJ PROF-FY"
    TITLE_CODES["3259"]["program"] = "ACADEMIC"
    TITLE_CODES["3259"]["unit"] = "99"

    TITLE_CODES["1948"] = {}
    TITLE_CODES["1948"]["title"] = "ROTATING RESEARCH PROF - FY"
    TITLE_CODES["1948"]["program"] = "ACADEMIC"
    TITLE_CODES["1948"]["unit"] = "FX"

    TITLE_CODES["7002"] = {}
    TITLE_CODES["7002"]["title"] = "CONST INSP SR"
    TITLE_CODES["7002"]["program"] = "PSS"
    TITLE_CODES["7002"]["unit"] = "TX"

    TITLE_CODES["9289"] = {}
    TITLE_CODES["9289"]["title"] = "GENETIC CNSLR PD"
    TITLE_CODES["9289"]["program"] = "PSS"
    TITLE_CODES["9289"]["unit"] = "HX"

    TITLE_CODES["6967"] = {}
    TITLE_CODES["6967"]["title"] = "PLANNER SR"
    TITLE_CODES["6967"]["program"] = "PSS"
    TITLE_CODES["6967"]["unit"] = "99"

    TITLE_CODES["3250"] = {}
    TITLE_CODES["3250"]["title"] = "PROF IN RES-AY"
    TITLE_CODES["3250"]["program"] = "ACADEMIC"
    TITLE_CODES["3250"]["unit"] = "A3"

    TITLE_CODES["3251"] = {}
    TITLE_CODES["3251"]["title"] = "PROF IN RES-FY"
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
    TITLE_CODES["9280"]["title"] = "PHARMACY TCHN SUPV"
    TITLE_CODES["9280"]["program"] = "PSS"
    TITLE_CODES["9280"]["unit"] = "99"

    TITLE_CODES["9283"] = {}
    TITLE_CODES["9283"]["title"] = "PHARMACY TCHN 1"
    TITLE_CODES["9283"]["program"] = "PSS"
    TITLE_CODES["9283"]["unit"] = "EX"

    TITLE_CODES["7004"] = {}
    TITLE_CODES["7004"]["title"] = "CONST INSP AST"
    TITLE_CODES["7004"]["program"] = "PSS"
    TITLE_CODES["7004"]["unit"] = "TX"

    TITLE_CODES["8156"] = {}
    TITLE_CODES["8156"]["title"] = "MATERIAL CRD"
    TITLE_CODES["8156"]["program"] = "PSS"
    TITLE_CODES["8156"]["unit"] = "K3"

    TITLE_CODES["9023"] = {}
    TITLE_CODES["9023"]["title"] = "RADLG TCHNO"
    TITLE_CODES["9023"]["program"] = "PSS"
    TITLE_CODES["9023"]["unit"] = "EX"

    TITLE_CODES["8157"] = {}
    TITLE_CODES["8157"]["title"] = "CEMENT MASON FLOORER APPR"
    TITLE_CODES["8157"]["program"] = "PSS"
    TITLE_CODES["8157"]["unit"] = "K3"

    TITLE_CODES["0810"] = {}
    TITLE_CODES["0810"]["title"] = "GRADUATE ADVISOR"
    TITLE_CODES["0810"]["program"] = "ACADEMIC"
    TITLE_CODES["0810"]["unit"] = "99"

    TITLE_CODES["0811"] = {}
    TITLE_CODES["0811"]["title"] = "ACADEMIC PROGRAMS ADVISOR"
    TITLE_CODES["0811"]["program"] = "ACADEMIC"
    TITLE_CODES["0811"]["unit"] = "99"

    TITLE_CODES["0812"] = {}
    TITLE_CODES["0812"]["title"] = "FACULTY ADVISOR"
    TITLE_CODES["0812"]["program"] = "ACADEMIC"
    TITLE_CODES["0812"]["unit"] = "99"

    TITLE_CODES["8906"] = {}
    TITLE_CODES["8906"]["title"] = "HOSP AST PD"
    TITLE_CODES["8906"]["program"] = "PSS"
    TITLE_CODES["8906"]["unit"] = "EX"

    TITLE_CODES["9357"] = {}
    TITLE_CODES["9357"]["title"] = "MED INTERPRETER PD"
    TITLE_CODES["9357"]["program"] = "PSS"
    TITLE_CODES["9357"]["unit"] = "HX"

    TITLE_CODES["8154"] = {}
    TITLE_CODES["8154"]["title"] = "HIGH VOLT ELECTRN"
    TITLE_CODES["8154"]["program"] = "PSS"
    TITLE_CODES["8154"]["unit"] = "K3"

    TITLE_CODES["8903"] = {}
    TITLE_CODES["8903"]["title"] = "PATIENT ESCORT PD"
    TITLE_CODES["8903"]["program"] = "PSS"
    TITLE_CODES["8903"]["unit"] = "EX"

    TITLE_CODES["9471"] = {}
    TITLE_CODES["9471"]["title"] = "SPEECH PATHOLOGIST PD"
    TITLE_CODES["9471"]["program"] = "PSS"
    TITLE_CODES["9471"]["unit"] = "HX"

    TITLE_CODES["0719"] = {}
    TITLE_CODES["0719"]["title"] = "EDUC FAC PLANNER PRN"
    TITLE_CODES["0719"]["program"] = "MSP"
    TITLE_CODES["0719"]["unit"] = "99"

    TITLE_CODES["3206"] = {}
    TITLE_CODES["3206"]["title"] = "RES-SFT"
    TITLE_CODES["3206"]["program"] = "ACADEMIC"
    TITLE_CODES["3206"]["unit"] = "FX"

    TITLE_CODES["0717"] = {}
    TITLE_CODES["0717"]["title"] = "ARCHITECT PRN"
    TITLE_CODES["0717"]["program"] = "MSP"
    TITLE_CODES["0717"]["unit"] = "99"

    TITLE_CODES["1792"] = {}
    TITLE_CODES["1792"]["title"] = "HS ASST CLIN PROF-GENCOMP-B"
    TITLE_CODES["1792"]["program"] = "ACADEMIC"
    TITLE_CODES["1792"]["unit"] = "99"

    TITLE_CODES["0715"] = {}
    TITLE_CODES["0715"]["title"] = "DIETITIAN CHF"
    TITLE_CODES["0715"]["program"] = "MSP"
    TITLE_CODES["0715"]["unit"] = "99"

    TITLE_CODES["1790"] = {}
    TITLE_CODES["1790"]["title"] = "ADJUNCT PROF-FY-MEDCOMP"
    TITLE_CODES["1790"]["program"] = "ACADEMIC"
    TITLE_CODES["1790"]["unit"] = "99"

    TITLE_CODES["0713"] = {}
    TITLE_CODES["0713"]["title"] = "CLIN LIC SOCIAL WORKER CHF"
    TITLE_CODES["0713"]["program"] = "MSP"
    TITLE_CODES["0713"]["unit"] = "99"

    TITLE_CODES["0712"] = {}
    TITLE_CODES["0712"]["title"] = "COUNSELING PSYCHOLOGIST 3"
    TITLE_CODES["0712"]["program"] = "MSP"
    TITLE_CODES["0712"]["unit"] = "99"

    TITLE_CODES["0711"] = {}
    TITLE_CODES["0711"]["title"] = "COUNSELING CTR MGR 1"
    TITLE_CODES["0711"]["program"] = "MSP"
    TITLE_CODES["0711"]["unit"] = "99"

    TITLE_CODES["0710"] = {}
    TITLE_CODES["0710"]["title"] = "COUNSELING CTR MGR 2"
    TITLE_CODES["0710"]["program"] = "MSP"
    TITLE_CODES["0710"]["unit"] = "99"

    TITLE_CODES["3330"] = {}
    TITLE_CODES["3330"]["title"] = "JR SPECIALIST"
    TITLE_CODES["3330"]["program"] = "ACADEMIC"
    TITLE_CODES["3330"]["unit"] = "FX"

    TITLE_CODES["3203"] = {}
    TITLE_CODES["3203"]["title"] = "RES-AY"
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
    TITLE_CODES["1069"]["title"] = "ASSOC VICE PROVOST"
    TITLE_CODES["1069"]["program"] = "ACADEMIC"
    TITLE_CODES["1069"]["unit"] = "99"

    TITLE_CODES["1068"] = {}
    TITLE_CODES["1068"]["title"] = "VICE PROVOST"
    TITLE_CODES["1068"]["program"] = "ACADEMIC"
    TITLE_CODES["1068"]["unit"] = "99"

    TITLE_CODES["1702"] = {}
    TITLE_CODES["1702"]["title"] = "RECALL FACULTY"
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
    TITLE_CODES["1060"]["title"] = "COLLEGE PROVOST"
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
    TITLE_CODES["9323"]["title"] = "CMTY HEALTH PRG SUPV"
    TITLE_CODES["9323"]["program"] = "PSS"
    TITLE_CODES["9323"]["unit"] = "99"

    TITLE_CODES["9108"] = {}
    TITLE_CODES["9108"]["title"] = "MAMMOGRAPHY TCHNO LD"
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
    TITLE_CODES["8232"]["title"] = "HVAC CNTRL TCHN APPR"
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
    TITLE_CODES["9496"]["title"] = "OCCUPATIONAL THER 4"
    TITLE_CODES["9496"]["program"] = "PSS"
    TITLE_CODES["9496"]["unit"] = "99"

    TITLE_CODES["9109"] = {}
    TITLE_CODES["9109"]["title"] = "ULTRASOUND TCHNO PRN LD"
    TITLE_CODES["9109"]["program"] = "PSS"
    TITLE_CODES["9109"]["unit"] = "EX"

    TITLE_CODES["9722"] = {}
    TITLE_CODES["9722"]["title"] = "MUSEUM SCI SR"
    TITLE_CODES["9722"]["program"] = "PSS"
    TITLE_CODES["9722"]["unit"] = "RX"

    TITLE_CODES["8989"] = {}
    TITLE_CODES["8989"]["title"] = "CYTOGENETIC TCHNO TRAINEE"
    TITLE_CODES["8989"]["program"] = "PSS"
    TITLE_CODES["8989"]["unit"] = "EX"

    TITLE_CODES["3386"] = {}
    TITLE_CODES["3386"]["title"] = "ASSOC PROF IN RES-AY-1/9-B/E/E"
    TITLE_CODES["3386"]["program"] = "ACADEMIC"
    TITLE_CODES["3386"]["unit"] = "A3"

    TITLE_CODES["3387"] = {}
    TITLE_CODES["3387"]["title"] = "ASST PROF IN RES-AY-B/E/E"
    TITLE_CODES["3387"]["program"] = "ACADEMIC"
    TITLE_CODES["3387"]["unit"] = "A3"

    TITLE_CODES["3384"] = {}
    TITLE_CODES["3384"]["title"] = "ASSOC PROF IN RES-AY-B/E/E"
    TITLE_CODES["3384"]["program"] = "ACADEMIC"
    TITLE_CODES["3384"]["unit"] = "A3"

    TITLE_CODES["3385"] = {}
    TITLE_CODES["3385"]["title"] = "ASSOC PROF IN RES-FY-B/E/E"
    TITLE_CODES["3385"]["program"] = "ACADEMIC"
    TITLE_CODES["3385"]["unit"] = "A3"

    TITLE_CODES["3382"] = {}
    TITLE_CODES["3382"]["title"] = "PROF IN RES-FY-B/E/E"
    TITLE_CODES["3382"]["program"] = "ACADEMIC"
    TITLE_CODES["3382"]["unit"] = "A3"

    TITLE_CODES["3383"] = {}
    TITLE_CODES["3383"]["title"] = "PROF IN RES-AY-1/9-B/E/E"
    TITLE_CODES["3383"]["program"] = "ACADEMIC"
    TITLE_CODES["3383"]["unit"] = "A3"

    TITLE_CODES["3029"] = {}
    TITLE_CODES["3029"]["title"] = "ACT ASST AGRON AES-SFT-VM"
    TITLE_CODES["3029"]["program"] = "ACADEMIC"
    TITLE_CODES["3029"]["unit"] = "FX"

    TITLE_CODES["3028"] = {}
    TITLE_CODES["3028"]["title"] = "VST ASST ----- IN THE A.E.S."
    TITLE_CODES["3028"]["program"] = "ACADEMIC"
    TITLE_CODES["3028"]["unit"] = "99"

    TITLE_CODES["3027"] = {}
    TITLE_CODES["3027"]["title"] = "ACT ASST AGRON AES"
    TITLE_CODES["3027"]["program"] = "ACADEMIC"
    TITLE_CODES["3027"]["unit"] = "99"

    TITLE_CODES["7633"] = {}
    TITLE_CODES["7633"]["title"] = "ADMIN SPEC 1 SUPV"
    TITLE_CODES["7633"]["program"] = "PSS"
    TITLE_CODES["7633"]["unit"] = "99"

    TITLE_CODES["7131"] = {}
    TITLE_CODES["7131"]["title"] = "EHS SPEC SUPV"
    TITLE_CODES["7131"]["program"] = "PSS"
    TITLE_CODES["7131"]["unit"] = "99"

    TITLE_CODES["3024"] = {}
    TITLE_CODES["3024"]["title"] = "ASST SPECIALIST AES"
    TITLE_CODES["3024"]["program"] = "ACADEMIC"
    TITLE_CODES["3024"]["unit"] = "FX"

    TITLE_CODES["9093"] = {}
    TITLE_CODES["9093"]["title"] = "POLYSOMNOGRAPHY TCHNO TRAINEE"
    TITLE_CODES["9093"]["program"] = "PSS"
    TITLE_CODES["9093"]["unit"] = "EX"

    TITLE_CODES["5419"] = {}
    TITLE_CODES["5419"]["title"] = "REG DIETETIC TCHN"
    TITLE_CODES["5419"]["program"] = "PSS"
    TITLE_CODES["5419"]["unit"] = "EX"

    TITLE_CODES["3021"] = {}
    TITLE_CODES["3021"]["title"] = "ASST AGRON AES-SFT-VM"
    TITLE_CODES["3021"]["program"] = "ACADEMIC"
    TITLE_CODES["3021"]["unit"] = "FX"

    TITLE_CODES["3020"] = {}
    TITLE_CODES["3020"]["title"] = "ASST AGRON AES"
    TITLE_CODES["3020"]["program"] = "ACADEMIC"
    TITLE_CODES["3020"]["unit"] = "FX"

    TITLE_CODES["1403"] = {}
    TITLE_CODES["1403"]["title"] = "INSTR-AY-1/9"
    TITLE_CODES["1403"]["program"] = "ACADEMIC"
    TITLE_CODES["1403"]["unit"] = "A3"

    TITLE_CODES["1017"] = {}
    TITLE_CODES["1017"]["title"] = "ACT/INTERIM ASSOC DEAN"
    TITLE_CODES["1017"]["program"] = "ACADEMIC"
    TITLE_CODES["1017"]["unit"] = "99"

    TITLE_CODES["1010"] = {}
    TITLE_CODES["1010"]["title"] = "ASSOC DEAN"
    TITLE_CODES["1010"]["program"] = "ACADEMIC"
    TITLE_CODES["1010"]["unit"] = "99"

    TITLE_CODES["8040"] = {}
    TITLE_CODES["8040"]["title"] = "NUC MED TCHNO SR SUPV"
    TITLE_CODES["8040"]["program"] = "PSS"
    TITLE_CODES["8040"]["unit"] = "99"

    TITLE_CODES["4214"] = {}
    TITLE_CODES["4214"]["title"] = "PLACEMENT INTERVIEWER AST"
    TITLE_CODES["4214"]["program"] = "PSS"
    TITLE_CODES["4214"]["unit"] = "99"

    TITLE_CODES["1230"] = {}
    TITLE_CODES["1230"]["title"] = "ASSOC PROF-10 MONTHS"
    TITLE_CODES["1230"]["program"] = "ACADEMIC"
    TITLE_CODES["1230"]["unit"] = "A3"

    TITLE_CODES["4210"] = {}
    TITLE_CODES["4210"]["title"] = "PLACEMENT OFCR MGR"
    TITLE_CODES["4210"]["program"] = "PSS"
    TITLE_CODES["4210"]["unit"] = "99"

    TITLE_CODES["4213"] = {}
    TITLE_CODES["4213"]["title"] = "PLACEMENT INTERVIEWER"
    TITLE_CODES["4213"]["program"] = "PSS"
    TITLE_CODES["4213"]["unit"] = "99"

    TITLE_CODES["4212"] = {}
    TITLE_CODES["4212"]["title"] = "PLACEMENT INTERVIEWER SR"
    TITLE_CODES["4212"]["program"] = "PSS"
    TITLE_CODES["4212"]["unit"] = "99"

    TITLE_CODES["8048"] = {}
    TITLE_CODES["8048"]["title"] = "HVY EQUIP OPERATING ENGR"
    TITLE_CODES["8048"]["program"] = "PSS"
    TITLE_CODES["8048"]["unit"] = "K3"

    TITLE_CODES["8049"] = {}
    TITLE_CODES["8049"]["title"] = "HVY OFFROAD EQUIP MECH APPR"
    TITLE_CODES["8049"]["program"] = "PSS"
    TITLE_CODES["8049"]["unit"] = "K3"

    TITLE_CODES["9396"] = {}
    TITLE_CODES["9396"]["title"] = "GI ENDOSCOPY TCHN 2 PD"
    TITLE_CODES["9396"]["program"] = "PSS"
    TITLE_CODES["9396"]["unit"] = "EX"

    TITLE_CODES["1330"] = {}
    TITLE_CODES["1330"]["title"] = "ASST PROF-10-MONTHS"
    TITLE_CODES["1330"]["program"] = "ACADEMIC"
    TITLE_CODES["1330"]["unit"] = "A3"

    TITLE_CODES["9082"] = {}
    TITLE_CODES["9082"]["title"] = "SVC PARTNER LD"
    TITLE_CODES["9082"]["program"] = "PSS"
    TITLE_CODES["9082"]["unit"] = "EX"

    TITLE_CODES["4358"] = {}
    TITLE_CODES["4358"]["title"] = "STDT AFFAIRS OFCR 2 SUPV"
    TITLE_CODES["4358"]["program"] = "PSS"
    TITLE_CODES["4358"]["unit"] = "99"

    TITLE_CODES["4359"] = {}
    TITLE_CODES["4359"]["title"] = "STDT AFFAIRS OFCR 5 SUPV"
    TITLE_CODES["4359"]["program"] = "PSS"
    TITLE_CODES["4359"]["unit"] = "99"

    TITLE_CODES["8280"] = {}
    TITLE_CODES["8280"]["title"] = "CEMENT MASON FLOORER"
    TITLE_CODES["8280"]["program"] = "PSS"
    TITLE_CODES["8280"]["unit"] = "K3"

    TITLE_CODES["8281"] = {}
    TITLE_CODES["8281"]["title"] = "ACCELERATOR MECH TCHN PRN"
    TITLE_CODES["8281"]["program"] = "PSS"
    TITLE_CODES["8281"]["unit"] = "TX"

    TITLE_CODES["4354"] = {}
    TITLE_CODES["4354"]["title"] = "STDT AFFAIRS OFCR 1"
    TITLE_CODES["4354"]["program"] = "PSS"
    TITLE_CODES["4354"]["unit"] = "99"

    TITLE_CODES["4355"] = {}
    TITLE_CODES["4355"]["title"] = "STDT AFFAIRS OFCR 3"
    TITLE_CODES["4355"]["program"] = "PSS"
    TITLE_CODES["4355"]["unit"] = "99"

    TITLE_CODES["4356"] = {}
    TITLE_CODES["4356"]["title"] = "STDT AFFAIRS OFCR 3 SUPV"
    TITLE_CODES["4356"]["program"] = "PSS"
    TITLE_CODES["4356"]["unit"] = "99"

    TITLE_CODES["4357"] = {}
    TITLE_CODES["4357"]["title"] = "STDT AFFAIRS OFCR 4 SUPV"
    TITLE_CODES["4357"]["program"] = "PSS"
    TITLE_CODES["4357"]["unit"] = "99"

    TITLE_CODES["4350"] = {}
    TITLE_CODES["4350"]["title"] = "STDT AFFAIRS OFCR SUPV EX"
    TITLE_CODES["4350"]["program"] = "PSS"
    TITLE_CODES["4350"]["unit"] = "99"

    TITLE_CODES["4351"] = {}
    TITLE_CODES["4351"]["title"] = "STDT AFFAIRS OFCR 5"
    TITLE_CODES["4351"]["program"] = "PSS"
    TITLE_CODES["4351"]["unit"] = "99"

    TITLE_CODES["4352"] = {}
    TITLE_CODES["4352"]["title"] = "STDT AFFAIRS OFCR 4"
    TITLE_CODES["4352"]["program"] = "PSS"
    TITLE_CODES["4352"]["unit"] = "99"

    TITLE_CODES["4353"] = {}
    TITLE_CODES["4353"]["title"] = "STDT AFFAIRS OFCR 2"
    TITLE_CODES["4353"]["program"] = "PSS"
    TITLE_CODES["4353"]["unit"] = "99"

    TITLE_CODES["3261"] = {}
    TITLE_CODES["3261"]["title"] = "ASSOC PROF IN RES-FY"
    TITLE_CODES["3261"]["program"] = "ACADEMIC"
    TITLE_CODES["3261"]["unit"] = "A3"

    TITLE_CODES["7704"] = {}
    TITLE_CODES["7704"]["title"] = "WRITER"
    TITLE_CODES["7704"]["program"] = "PSS"
    TITLE_CODES["7704"]["unit"] = "TX"

    TITLE_CODES["7705"] = {}
    TITLE_CODES["7705"]["title"] = "WRITER AST"
    TITLE_CODES["7705"]["program"] = "PSS"
    TITLE_CODES["7705"]["unit"] = "TX"

    TITLE_CODES["7702"] = {}
    TITLE_CODES["7702"]["title"] = "WRITER SR SUPV"
    TITLE_CODES["7702"]["program"] = "PSS"
    TITLE_CODES["7702"]["unit"] = "99"

    TITLE_CODES["7703"] = {}
    TITLE_CODES["7703"]["title"] = "WRITER SR"
    TITLE_CODES["7703"]["program"] = "PSS"
    TITLE_CODES["7703"]["unit"] = "99"

    TITLE_CODES["3260"] = {}
    TITLE_CODES["3260"]["title"] = "ASSOC PROF IN RES-AY"
    TITLE_CODES["3260"]["program"] = "ACADEMIC"
    TITLE_CODES["3260"]["unit"] = "A3"

    TITLE_CODES["0033"] = {}
    TITLE_CODES["0033"]["title"] = "VC FUNC AREA"
    TITLE_CODES["0033"]["program"] = "MSP"
    TITLE_CODES["0033"]["unit"] = "99"

    TITLE_CODES["0032"] = {}
    TITLE_CODES["0032"]["title"] = "VC RESTRICTED USE"
    TITLE_CODES["0032"]["program"] = "MSP"
    TITLE_CODES["0032"]["unit"] = "99"

    TITLE_CODES["0030"] = {}
    TITLE_CODES["0030"]["title"] = "CHAN"
    TITLE_CODES["0030"]["program"] = "MSP"
    TITLE_CODES["0030"]["unit"] = "99"

    TITLE_CODES["0035"] = {}
    TITLE_CODES["0035"]["title"] = "SR VC FUNC AREA"
    TITLE_CODES["0035"]["program"] = "MSP"
    TITLE_CODES["0035"]["unit"] = "99"

    TITLE_CODES["0034"] = {}
    TITLE_CODES["0034"]["title"] = "SR VC RESTRICTED USE"
    TITLE_CODES["0034"]["program"] = "MSP"
    TITLE_CODES["0034"]["unit"] = "99"

    TITLE_CODES["1537"] = {}
    TITLE_CODES["1537"]["title"] = "ASSISTANT PROFESSOR-GENCOMP-A"
    TITLE_CODES["1537"]["program"] = "ACADEMIC"
    TITLE_CODES["1537"]["unit"] = "A3"

    TITLE_CODES["1243"] = {}
    TITLE_CODES["1243"]["title"] = "ASSOC PROF-AY-B/E/E"
    TITLE_CODES["1243"]["program"] = "ACADEMIC"
    TITLE_CODES["1243"]["unit"] = "A3"

    TITLE_CODES["1534"] = {}
    TITLE_CODES["1534"]["title"] = "VIS INSTRUCTOR-GENCOMP-PTC"
    TITLE_CODES["1534"]["program"] = "ACADEMIC"
    TITLE_CODES["1534"]["unit"] = "99"

    TITLE_CODES["1245"] = {}
    TITLE_CODES["1245"]["title"] = "ASSOC PROF-AY-1/9-B/E/E"
    TITLE_CODES["1245"]["program"] = "ACADEMIC"
    TITLE_CODES["1245"]["unit"] = "A3"

    TITLE_CODES["1244"] = {}
    TITLE_CODES["1244"]["title"] = "ASSOC PROF-FY-B/E/E"
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

    TITLE_CODES["0434"] = {}
    TITLE_CODES["0434"]["title"] = "COUNSEL"
    TITLE_CODES["0434"]["program"] = "MSP"
    TITLE_CODES["0434"]["unit"] = "99"

    TITLE_CODES["0435"] = {}
    TITLE_CODES["0435"]["title"] = ""
    TITLE_CODES["0435"]["program"] = "MSP"
    TITLE_CODES["0435"]["unit"] = "99"

    TITLE_CODES["0432"] = {}
    TITLE_CODES["0432"]["title"] = "COUNSEL PRN"
    TITLE_CODES["0432"]["program"] = "MSP"
    TITLE_CODES["0432"]["unit"] = "99"

    TITLE_CODES["0433"] = {}
    TITLE_CODES["0433"]["title"] = "COUNSEL SR"
    TITLE_CODES["0433"]["program"] = "MSP"
    TITLE_CODES["0433"]["unit"] = "99"

    TITLE_CODES["0430"] = {}
    TITLE_CODES["0430"]["title"] = "HS COUNSEL CHF"
    TITLE_CODES["0430"]["program"] = "MSP"
    TITLE_CODES["0430"]["unit"] = "99"

    TITLE_CODES["0431"] = {}
    TITLE_CODES["0431"]["title"] = "MGN COUNSEL"
    TITLE_CODES["0431"]["program"] = "MSP"
    TITLE_CODES["0431"]["unit"] = "99"

    TITLE_CODES["2860"] = {}
    TITLE_CODES["2860"]["title"] = "TUT-GSHIP"
    TITLE_CODES["2860"]["program"] = "ACADEMIC"
    TITLE_CODES["2860"]["unit"] = "BX"

    TITLE_CODES["9600"] = {}
    TITLE_CODES["9600"]["title"] = "LAB AST 4 SUPV"
    TITLE_CODES["9600"]["program"] = "PSS"
    TITLE_CODES["9600"]["unit"] = "99"

    TITLE_CODES["2861"] = {}
    TITLE_CODES["2861"]["title"] = "TUT-NON GSHIP"
    TITLE_CODES["2861"]["program"] = "ACADEMIC"
    TITLE_CODES["2861"]["unit"] = "BX"

    TITLE_CODES["3804"] = {}
    TITLE_CODES["3804"]["title"] = " ---FISCAL YR - RECALLED-VERIP"
    TITLE_CODES["3804"]["program"] = "ACADEMIC"
    TITLE_CODES["3804"]["unit"] = "99"

    TITLE_CODES["5444"] = {}
    TITLE_CODES["5444"]["title"] = "FOOD SVC MGR"
    TITLE_CODES["5444"]["program"] = "PSS"
    TITLE_CODES["5444"]["unit"] = "99"

    TITLE_CODES["3266"] = {}
    TITLE_CODES["3266"]["title"] = "GSR-NO REM"
    TITLE_CODES["3266"]["program"] = "ACADEMIC"
    TITLE_CODES["3266"]["unit"] = "99"

    TITLE_CODES["9105"] = {}
    TITLE_CODES["9105"]["title"] = "RAD EQUIP SPEC SUPV"
    TITLE_CODES["9105"]["program"] = "PSS"
    TITLE_CODES["9105"]["unit"] = "99"

    TITLE_CODES["2862"] = {}
    TITLE_CODES["2862"]["title"] = "TUT-GSHIP/NON REP"
    TITLE_CODES["2862"]["program"] = "ACADEMIC"
    TITLE_CODES["2862"]["unit"] = "99"

    TITLE_CODES["3803"] = {}
    TITLE_CODES["3803"]["title"] = " ---ACADEMIC YR-RECALLED-VERIP"
    TITLE_CODES["3803"]["program"] = "ACADEMIC"
    TITLE_CODES["3803"]["unit"] = "99"

    TITLE_CODES["3802"] = {}
    TITLE_CODES["3802"]["title"] = "RECALL NON-FACULTY ACAD"
    TITLE_CODES["3802"]["program"] = "ACADEMIC"
    TITLE_CODES["3802"]["unit"] = "99"

    TITLE_CODES["5124"] = {}
    TITLE_CODES["5124"]["title"] = "MED CTR COOK PD"
    TITLE_CODES["5124"]["program"] = "PSS"
    TITLE_CODES["5124"]["unit"] = "SX"

    TITLE_CODES["4103"] = {}
    TITLE_CODES["4103"]["title"] = "CHILD DEV CTR CRD"
    TITLE_CODES["4103"]["program"] = "PSS"
    TITLE_CODES["4103"]["unit"] = "99"

    TITLE_CODES["2863"] = {}
    TITLE_CODES["2863"]["title"] = "TUT-NON GSHIP/NON REP"
    TITLE_CODES["2863"]["program"] = "ACADEMIC"
    TITLE_CODES["2863"]["unit"] = "99"

    TITLE_CODES["7612"] = {}
    TITLE_CODES["7612"]["title"] = "ACCOUNTANT 1 SUPV"
    TITLE_CODES["7612"]["program"] = "PSS"
    TITLE_CODES["7612"]["unit"] = "99"

    TITLE_CODES["5125"] = {}
    TITLE_CODES["5125"]["title"] = "MED CTR COOK SR"
    TITLE_CODES["5125"]["program"] = "PSS"
    TITLE_CODES["5125"]["unit"] = "SX"

    TITLE_CODES["7613"] = {}
    TITLE_CODES["7613"]["title"] = "ACCOUNTANT SUPV"
    TITLE_CODES["7613"]["program"] = "PSS"
    TITLE_CODES["7613"]["unit"] = "99"

    TITLE_CODES["9497"] = {}
    TITLE_CODES["9497"]["title"] = "OCCUPATIONAL THER 3"
    TITLE_CODES["9497"]["program"] = "PSS"
    TITLE_CODES["9497"]["unit"] = "99"

    TITLE_CODES["9315"] = {}
    TITLE_CODES["9315"]["title"] = "CLIN SOCIAL WORKER 1"
    TITLE_CODES["9315"]["program"] = "PSS"
    TITLE_CODES["9315"]["unit"] = "HX"

    TITLE_CODES["8192"] = {}
    TITLE_CODES["8192"]["title"] = "STEAMFITTER WORKER LD"
    TITLE_CODES["8192"]["program"] = "PSS"
    TITLE_CODES["8192"]["unit"] = "K3"

    TITLE_CODES["9314"] = {}
    TITLE_CODES["9314"]["title"] = "CLIN SOCIAL WORKER 2"
    TITLE_CODES["9314"]["program"] = "PSS"
    TITLE_CODES["9314"]["unit"] = "HX"

    TITLE_CODES["9393"] = {}
    TITLE_CODES["9393"]["title"] = "PSYCHOMETRIST"
    TITLE_CODES["9393"]["program"] = "PSS"
    TITLE_CODES["9393"]["unit"] = "HX"

    TITLE_CODES["9313"] = {}
    TITLE_CODES["9313"]["title"] = "CLIN SOCIAL WORKER 3"
    TITLE_CODES["9313"]["program"] = "PSS"
    TITLE_CODES["9313"]["unit"] = "HX"

    TITLE_CODES["9536"] = {}
    TITLE_CODES["9536"]["title"] = "ANIMAL HEALTH TCHN 2"
    TITLE_CODES["9536"]["program"] = "PSS"
    TITLE_CODES["9536"]["unit"] = "TX"

    TITLE_CODES["3898"] = {}
    TITLE_CODES["3898"]["title"] = "ACADEMIC UPGRADING FUNDS"
    TITLE_CODES["3898"]["program"] = "ACADEMIC"
    TITLE_CODES["3898"]["unit"] = "87"

    TITLE_CODES["9311"] = {}
    TITLE_CODES["9311"]["title"] = "CLIN SOCIAL WORKER CHF ASC"
    TITLE_CODES["9311"]["program"] = "PSS"
    TITLE_CODES["9311"]["unit"] = "99"

    TITLE_CODES["7618"] = {}
    TITLE_CODES["7618"]["title"] = "ACCOUNTANT 1"
    TITLE_CODES["7618"]["program"] = "PSS"
    TITLE_CODES["7618"]["unit"] = "99"

    TITLE_CODES["8357"] = {}
    TITLE_CODES["8357"]["title"] = "ALARM ELECTRN LD"
    TITLE_CODES["8357"]["program"] = "PSS"
    TITLE_CODES["8357"]["unit"] = "K3"

    TITLE_CODES["3897"] = {}
    TITLE_CODES["3897"]["title"] = "FACULTY RECHARGE GROUP"
    TITLE_CODES["3897"]["program"] = "ACADEMIC"
    TITLE_CODES["3897"]["unit"] = "87"

    TITLE_CODES["8956"] = {}
    TITLE_CODES["8956"]["title"] = "CLIN LAB SCI PD"
    TITLE_CODES["8956"]["program"] = "PSS"
    TITLE_CODES["8956"]["unit"] = "HX"

    TITLE_CODES["9392"] = {}
    TITLE_CODES["9392"]["title"] = "PSYCHOMETRIST SR"
    TITLE_CODES["9392"]["program"] = "PSS"
    TITLE_CODES["9392"]["unit"] = "HX"

    TITLE_CODES["9165"] = {}
    TITLE_CODES["9165"]["title"] = "OPERATING ROOM AST 1"
    TITLE_CODES["9165"]["program"] = "PSS"
    TITLE_CODES["9165"]["unit"] = "EX"

    TITLE_CODES["7273"] = {}
    TITLE_CODES["7273"]["title"] = "PROGR 8 SUPV"
    TITLE_CODES["7273"]["program"] = "PSS"
    TITLE_CODES["7273"]["unit"] = "99"

    TITLE_CODES["8954"] = {}
    TITLE_CODES["8954"]["title"] = "CYTO TCHNO SR"
    TITLE_CODES["8954"]["program"] = "PSS"
    TITLE_CODES["8954"]["unit"] = "HX"

    TITLE_CODES["9296"] = {}
    TITLE_CODES["9296"]["title"] = "PHLEBOTOMIST CERT TCHN SUPV"
    TITLE_CODES["9296"]["program"] = "PSS"
    TITLE_CODES["9296"]["unit"] = "99"

    TITLE_CODES["6100"] = {}
    TITLE_CODES["6100"]["title"] = "ARTIST SR SUPV"
    TITLE_CODES["6100"]["program"] = "PSS"
    TITLE_CODES["6100"]["unit"] = "99"

    TITLE_CODES["7193"] = {}
    TITLE_CODES["7193"]["title"] = "DATA PROC PROD CRD"
    TITLE_CODES["7193"]["program"] = "PSS"
    TITLE_CODES["7193"]["unit"] = "CX"

    TITLE_CODES["4774"] = {}
    TITLE_CODES["4774"]["title"] = "KEY ENTRY OPR AST"
    TITLE_CODES["4774"]["program"] = "PSS"
    TITLE_CODES["4774"]["unit"] = "CX"

    TITLE_CODES["7271"] = {}
    TITLE_CODES["7271"]["title"] = "ANL 7"
    TITLE_CODES["7271"]["program"] = "PSS"
    TITLE_CODES["7271"]["unit"] = "99"

    TITLE_CODES["4772"] = {}
    TITLE_CODES["4772"]["title"] = "KEY ENTRY OPR LD"
    TITLE_CODES["4772"]["program"] = "PSS"
    TITLE_CODES["4772"]["unit"] = "CX"

    TITLE_CODES["4773"] = {}
    TITLE_CODES["4773"]["title"] = "KEY ENTRY OPR"
    TITLE_CODES["4773"]["program"] = "PSS"
    TITLE_CODES["4773"]["unit"] = "CX"

    TITLE_CODES["4770"] = {}
    TITLE_CODES["4770"]["title"] = "KEY ENTRY SUPV 2"
    TITLE_CODES["4770"]["program"] = "PSS"
    TITLE_CODES["4770"]["unit"] = "99"

    TITLE_CODES["4771"] = {}
    TITLE_CODES["4771"]["title"] = "KEY ENTRY SUPV 1"
    TITLE_CODES["4771"]["program"] = "PSS"
    TITLE_CODES["4771"]["unit"] = "99"

    TITLE_CODES["7276"] = {}
    TITLE_CODES["7276"]["title"] = "PROGR ANL 2 SUPV"
    TITLE_CODES["7276"]["program"] = "PSS"
    TITLE_CODES["7276"]["unit"] = "99"

    TITLE_CODES["7191"] = {}
    TITLE_CODES["7191"]["title"] = "DATA PROC PROD CRD PRN"
    TITLE_CODES["7191"]["program"] = "PSS"
    TITLE_CODES["7191"]["unit"] = "CX"

    TITLE_CODES["7137"] = {}
    TITLE_CODES["7137"]["title"] = "EHS SPEC 2 SUPV"
    TITLE_CODES["7137"]["program"] = "PSS"
    TITLE_CODES["7137"]["unit"] = "99"

    TITLE_CODES["7277"] = {}
    TITLE_CODES["7277"]["title"] = "PROGR ANL 2"
    TITLE_CODES["7277"]["program"] = "PSS"
    TITLE_CODES["7277"]["unit"] = "99"

    TITLE_CODES["6758"] = {}
    TITLE_CODES["6758"]["title"] = "LIBRARY AST 5"
    TITLE_CODES["6758"]["program"] = "PSS"
    TITLE_CODES["6758"]["unit"] = "99"

    TITLE_CODES["6759"] = {}
    TITLE_CODES["6759"]["title"] = "LIBRARY AST 4"
    TITLE_CODES["6759"]["program"] = "PSS"
    TITLE_CODES["6759"]["unit"] = "CX"

    TITLE_CODES["3461"] = {}
    TITLE_CODES["3461"]["title"] = "ASST COOP EXT ADVISOR"
    TITLE_CODES["3461"]["program"] = "ACADEMIC"
    TITLE_CODES["3461"]["unit"] = "FX"

    TITLE_CODES["7275"] = {}
    TITLE_CODES["7275"]["title"] = "PROGR ANL 3"
    TITLE_CODES["7275"]["program"] = "PSS"
    TITLE_CODES["7275"]["unit"] = "99"

    TITLE_CODES["6757"] = {}
    TITLE_CODES["6757"]["title"] = "LIBRARY AST 5 SUPV"
    TITLE_CODES["6757"]["program"] = "PSS"
    TITLE_CODES["6757"]["unit"] = "99"

    TITLE_CODES["7196"] = {}
    TITLE_CODES["7196"]["title"] = "DATA PROC PROD CRD SR SUPV"
    TITLE_CODES["7196"]["program"] = "PSS"
    TITLE_CODES["7196"]["unit"] = "99"

    TITLE_CODES["7195"] = {}
    TITLE_CODES["7195"]["title"] = "DATA PROC PROD CRD PRN SUPV"
    TITLE_CODES["7195"]["program"] = "PSS"
    TITLE_CODES["7195"]["unit"] = "99"

    TITLE_CODES["5811"] = {}
    TITLE_CODES["5811"]["title"] = "LAUNDRY LINEN SVC MGR"
    TITLE_CODES["5811"]["program"] = "PSS"
    TITLE_CODES["5811"]["unit"] = "99"

    TITLE_CODES["7136"] = {}
    TITLE_CODES["7136"]["title"] = "EHS SPEC 3 SUPV"
    TITLE_CODES["7136"]["program"] = "PSS"
    TITLE_CODES["7136"]["unit"] = "99"

    TITLE_CODES["7278"] = {}
    TITLE_CODES["7278"]["title"] = "PROGR ANL 1"
    TITLE_CODES["7278"]["program"] = "PSS"
    TITLE_CODES["7278"]["unit"] = "99"

    TITLE_CODES["5816"] = {}
    TITLE_CODES["5816"]["title"] = "LINEN SVC SUPV"
    TITLE_CODES["5816"]["program"] = "PSS"
    TITLE_CODES["5816"]["unit"] = "99"

    TITLE_CODES["7170"] = {}
    TITLE_CODES["7170"]["title"] = "DEV TCHN 5"
    TITLE_CODES["7170"]["program"] = "PSS"
    TITLE_CODES["7170"]["unit"] = "TX"

    TITLE_CODES["9167"] = {}
    TITLE_CODES["9167"]["title"] = "OPERATING ROOM AST PD"
    TITLE_CODES["9167"]["program"] = "PSS"
    TITLE_CODES["9167"]["unit"] = "EX"

    TITLE_CODES["9995"] = {}
    TITLE_CODES["9995"]["title"] = "UNCLASSIFIED"
    TITLE_CODES["9995"]["program"] = "PSS"
    TITLE_CODES["9995"]["unit"] = "99"

    TITLE_CODES["5080"] = {}
    TITLE_CODES["5080"]["title"] = "MED CTR STOREKEEPER AST"
    TITLE_CODES["5080"]["program"] = "PSS"
    TITLE_CODES["5080"]["unit"] = "SX"

    TITLE_CODES["9720"] = {}
    TITLE_CODES["9720"]["title"] = "MUSEUM SCI SR SUPV"
    TITLE_CODES["9720"]["program"] = "PSS"
    TITLE_CODES["9720"]["unit"] = "99"

    TITLE_CODES["7173"] = {}
    TITLE_CODES["7173"]["title"] = "DEV TCHN 2"
    TITLE_CODES["7173"]["program"] = "PSS"
    TITLE_CODES["7173"]["unit"] = "TX"

    TITLE_CODES["9533"] = {}
    TITLE_CODES["9533"]["title"] = "VETERINARIAN LAM AST"
    TITLE_CODES["9533"]["program"] = "PSS"
    TITLE_CODES["9533"]["unit"] = "99"

    TITLE_CODES["3639"] = {}
    TITLE_CODES["3639"]["title"] = "ASSOC LAW LIBRARIAN"
    TITLE_CODES["3639"]["program"] = "ACADEMIC"
    TITLE_CODES["3639"]["unit"] = "99"

    TITLE_CODES["3637"] = {}
    TITLE_CODES["3637"]["title"] = "ASST LAW LIBRARIAN"
    TITLE_CODES["3637"]["program"] = "ACADEMIC"
    TITLE_CODES["3637"]["unit"] = "99"

    TITLE_CODES["3635"] = {}
    TITLE_CODES["3635"]["title"] = "LAW LIBRARIAN"
    TITLE_CODES["3635"]["program"] = "ACADEMIC"
    TITLE_CODES["3635"]["unit"] = "99"

    TITLE_CODES["9272"] = {}
    TITLE_CODES["9272"]["title"] = "PATIENT CARE DIALYSIS TCHN 1"
    TITLE_CODES["9272"]["program"] = "PSS"
    TITLE_CODES["9272"]["unit"] = "EX"

    TITLE_CODES["5086"] = {}
    TITLE_CODES["5086"]["title"] = "MED CTR CUSTODIAN SR"
    TITLE_CODES["5086"]["program"] = "PSS"
    TITLE_CODES["5086"]["unit"] = "SX"

    TITLE_CODES["4610"] = {}
    TITLE_CODES["4610"]["title"] = "CASHIER OFC MGR"
    TITLE_CODES["4610"]["program"] = "PSS"
    TITLE_CODES["4610"]["unit"] = "99"

    TITLE_CODES["2709"] = {}
    TITLE_CODES["2709"]["title"] = "RESID PHYS I/REP"
    TITLE_CODES["2709"]["program"] = "ACADEMIC"
    TITLE_CODES["2709"]["unit"] = "M3"

    TITLE_CODES["9160"] = {}
    TITLE_CODES["9160"]["title"] = "NURSE PRACTITIONER PD"
    TITLE_CODES["9160"]["program"] = "PSS"
    TITLE_CODES["9160"]["unit"] = "NX"

    TITLE_CODES["2708"] = {}
    TITLE_CODES["2708"]["title"] = "RESID PHYS I/NON REP"
    TITLE_CODES["2708"]["program"] = "ACADEMIC"
    TITLE_CODES["2708"]["unit"] = "99"

    TITLE_CODES["9994"] = {}
    TITLE_CODES["9994"]["title"] = "UNCLASSIFIED A&PS 7"
    TITLE_CODES["9994"]["program"] = "PSS"
    TITLE_CODES["9994"]["unit"] = "99"

    TITLE_CODES["7675"] = {}
    TITLE_CODES["7675"]["title"] = "PRG PROMOTION MGR 2"
    TITLE_CODES["7675"]["program"] = "PSS"
    TITLE_CODES["7675"]["unit"] = "99"

    TITLE_CODES["6109"] = {}
    TITLE_CODES["6109"]["title"] = "PRODUCER DIR SR SUPV"
    TITLE_CODES["6109"]["program"] = "PSS"
    TITLE_CODES["6109"]["unit"] = "99"

    TITLE_CODES["6108"] = {}
    TITLE_CODES["6108"]["title"] = "PRODUCER DIR PRN SUPV"
    TITLE_CODES["6108"]["program"] = "PSS"
    TITLE_CODES["6108"]["unit"] = "99"

    TITLE_CODES["6107"] = {}
    TITLE_CODES["6107"]["title"] = "ART MODEL"
    TITLE_CODES["6107"]["program"] = "PSS"
    TITLE_CODES["6107"]["unit"] = "TX"

    TITLE_CODES["9277"] = {}
    TITLE_CODES["9277"]["title"] = "VOC REHAB CNSLR"
    TITLE_CODES["9277"]["program"] = "PSS"
    TITLE_CODES["9277"]["unit"] = "99"

    TITLE_CODES["2222"] = {}
    TITLE_CODES["2222"]["title"] = "SUPV TEACHER ED-FY"
    TITLE_CODES["2222"]["program"] = "ACADEMIC"
    TITLE_CODES["2222"]["unit"] = "IX"

    TITLE_CODES["2223"] = {}
    TITLE_CODES["2223"]["title"] = "SUPV TEACHER ED-FY-CONTINUING"
    TITLE_CODES["2223"]["program"] = "ACADEMIC"
    TITLE_CODES["2223"]["unit"] = "IX"

    TITLE_CODES["2220"] = {}
    TITLE_CODES["2220"]["title"] = "SUPV TEACHER ED-AY"
    TITLE_CODES["2220"]["program"] = "ACADEMIC"
    TITLE_CODES["2220"]["unit"] = "IX"

    TITLE_CODES["2221"] = {}
    TITLE_CODES["2221"]["title"] = "SUPV TEACHER ED-AY-CONTINUING"
    TITLE_CODES["2221"]["program"] = "ACADEMIC"
    TITLE_CODES["2221"]["unit"] = "IX"

    TITLE_CODES["0001"] = {}
    TITLE_CODES["0001"]["title"] = "PRESIDENT OF THE UNIV"
    TITLE_CODES["0001"]["program"] = "MSP"
    TITLE_CODES["0001"]["unit"] = "99"

    TITLE_CODES["8639"] = {}
    TITLE_CODES["8639"]["title"] = "MED CTR DEV TCHN 4 SUPV"
    TITLE_CODES["8639"]["program"] = "PSS"
    TITLE_CODES["8639"]["unit"] = "99"

    TITLE_CODES["9279"] = {}
    TITLE_CODES["9279"]["title"] = "PHARMACY TCHN 1 PD"
    TITLE_CODES["9279"]["program"] = "PSS"
    TITLE_CODES["9279"]["unit"] = "EX"

    TITLE_CODES["9604"] = {}
    TITLE_CODES["9604"]["title"] = "LAB AST 3 SUPV"
    TITLE_CODES["9604"]["program"] = "PSS"
    TITLE_CODES["9604"]["unit"] = "99"

    TITLE_CODES["9161"] = {}
    TITLE_CODES["9161"]["title"] = "OPERATING ROOM EQUIP SPEC 1"
    TITLE_CODES["9161"]["program"] = "PSS"
    TITLE_CODES["9161"]["unit"] = "EX"

    TITLE_CODES["9119"] = {}
    TITLE_CODES["9119"]["title"] = "NURSE PD"
    TITLE_CODES["9119"]["program"] = "PSS"
    TITLE_CODES["9119"]["unit"] = "NX"

    TITLE_CODES["9118"] = {}
    TITLE_CODES["9118"]["title"] = "HOME HEALTH NURSE 1"
    TITLE_CODES["9118"]["program"] = "PSS"
    TITLE_CODES["9118"]["unit"] = "NX"

    TITLE_CODES["0145"] = {}
    TITLE_CODES["0145"]["title"] = "EXEC AST TO CHAN"
    TITLE_CODES["0145"]["program"] = "MSP"
    TITLE_CODES["0145"]["unit"] = "99"

    TITLE_CODES["7679"] = {}
    TITLE_CODES["7679"]["title"] = "PUBLICATIONS MGR"
    TITLE_CODES["7679"]["program"] = "PSS"
    TITLE_CODES["7679"]["unit"] = "99"

    TITLE_CODES["0140"] = {}
    TITLE_CODES["0140"]["title"] = "AST CHAN FUNC AREA"
    TITLE_CODES["0140"]["program"] = "MSP"
    TITLE_CODES["0140"]["unit"] = "99"

    TITLE_CODES["9111"] = {}
    TITLE_CODES["9111"]["title"] = "TRANSPLANT CRD 2"
    TITLE_CODES["9111"]["program"] = "PSS"
    TITLE_CODES["9111"]["unit"] = "NX"

    TITLE_CODES["9110"] = {}
    TITLE_CODES["9110"]["title"] = "TRANSPLANT CRD 1"
    TITLE_CODES["9110"]["program"] = "PSS"
    TITLE_CODES["9110"]["unit"] = "NX"

    TITLE_CODES["9112"] = {}
    TITLE_CODES["9112"]["title"] = "DOSIMETRY CHF"
    TITLE_CODES["9112"]["program"] = "PSS"
    TITLE_CODES["9112"]["unit"] = "99"

    TITLE_CODES["9007"] = {}
    TITLE_CODES["9007"]["title"] = "DOSIMETRIST SR"
    TITLE_CODES["9007"]["program"] = "PSS"
    TITLE_CODES["9007"]["unit"] = "EX"

    TITLE_CODES["9114"] = {}
    TITLE_CODES["9114"]["title"] = "HOME HEALTH NURSE PD"
    TITLE_CODES["9114"]["program"] = "PSS"
    TITLE_CODES["9114"]["unit"] = "NX"

    TITLE_CODES["8546"] = {}
    TITLE_CODES["8546"]["title"] = "AGRICULTURAL TCHN SR SUPV"
    TITLE_CODES["8546"]["program"] = "PSS"
    TITLE_CODES["8546"]["unit"] = "99"

    TITLE_CODES["5068"] = {}
    TITLE_CODES["5068"]["title"] = "STOREKEEPER SR SUPV"
    TITLE_CODES["5068"]["program"] = "PSS"
    TITLE_CODES["5068"]["unit"] = "99"

    TITLE_CODES["7151"] = {}
    TITLE_CODES["7151"]["title"] = "ENGR AST SUPV"
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
    TITLE_CODES["2120"]["title"] = "ASSOC SUPV PE-AY"
    TITLE_CODES["2120"]["program"] = "ACADEMIC"
    TITLE_CODES["2120"]["unit"] = "99"

    TITLE_CODES["4668"] = {}
    TITLE_CODES["4668"]["title"] = "PATIENT BILLER 1 PD"
    TITLE_CODES["4668"]["program"] = "PSS"
    TITLE_CODES["4668"]["unit"] = "EX"

    TITLE_CODES["3371"] = {}
    TITLE_CODES["3371"]["title"] = "ASST ADJ PROF-AY-B/E/E"
    TITLE_CODES["3371"]["program"] = "ACADEMIC"
    TITLE_CODES["3371"]["unit"] = "99"

    TITLE_CODES["8131"] = {}
    TITLE_CODES["8131"]["title"] = "GROUNDS SUPV"
    TITLE_CODES["8131"]["program"] = "PSS"
    TITLE_CODES["8131"]["unit"] = "99"

    TITLE_CODES["4919"] = {}
    TITLE_CODES["4919"]["title"] = "STDT 4"
    TITLE_CODES["4919"]["program"] = "PSS"
    TITLE_CODES["4919"]["unit"] = "99"

    TITLE_CODES["4664"] = {}
    TITLE_CODES["4664"]["title"] = "PATIENT BILLER 2"
    TITLE_CODES["4664"]["program"] = "PSS"
    TITLE_CODES["4664"]["unit"] = "EX"

    TITLE_CODES["4665"] = {}
    TITLE_CODES["4665"]["title"] = "PATIENT BILLER 1"
    TITLE_CODES["4665"]["program"] = "PSS"
    TITLE_CODES["4665"]["unit"] = "EX"

    TITLE_CODES["2080"] = {}
    TITLE_CODES["2080"]["title"] = "CLIN ASSOCIATE IN ____-ACAD YR"
    TITLE_CODES["2080"]["program"] = "ACADEMIC"
    TITLE_CODES["2080"]["unit"] = "99"

    TITLE_CODES["2081"] = {}
    TITLE_CODES["2081"]["title"] = "CLIN ASSOCIATE-FY"
    TITLE_CODES["2081"]["program"] = "ACADEMIC"
    TITLE_CODES["2081"]["unit"] = "99"

    TITLE_CODES["4660"] = {}
    TITLE_CODES["4660"]["title"] = "PATIENT BILLER 5"
    TITLE_CODES["4660"]["program"] = "PSS"
    TITLE_CODES["4660"]["unit"] = "99"

    TITLE_CODES["4661"] = {}
    TITLE_CODES["4661"]["title"] = "PATIENT BILLER SUPV 4"
    TITLE_CODES["4661"]["program"] = "PSS"
    TITLE_CODES["4661"]["unit"] = "99"

    TITLE_CODES["4662"] = {}
    TITLE_CODES["4662"]["title"] = "PATIENT BILLER 4"
    TITLE_CODES["4662"]["program"] = "PSS"
    TITLE_CODES["4662"]["unit"] = "EX"

    TITLE_CODES["4663"] = {}
    TITLE_CODES["4663"]["title"] = "PATIENT BILLER 3"
    TITLE_CODES["4663"]["program"] = "PSS"
    TITLE_CODES["4663"]["unit"] = "EX"

    TITLE_CODES["3402"] = {}
    TITLE_CODES["3402"]["title"] = "VST COOP EXT SPECIALIST"
    TITLE_CODES["3402"]["program"] = "ACADEMIC"
    TITLE_CODES["3402"]["unit"] = "99"

    TITLE_CODES["5451"] = {}
    TITLE_CODES["5451"]["title"] = "FOOD SVC SUPV SR"
    TITLE_CODES["5451"]["program"] = "PSS"
    TITLE_CODES["5451"]["unit"] = "99"

    TITLE_CODES["5452"] = {}
    TITLE_CODES["5452"]["title"] = "FOOD SVC WORKER LD"
    TITLE_CODES["5452"]["program"] = "PSS"
    TITLE_CODES["5452"]["unit"] = "SX"

    TITLE_CODES["9115"] = {}
    TITLE_CODES["9115"]["title"] = "HOME HEALTH NURSE 4"
    TITLE_CODES["9115"]["program"] = "PSS"
    TITLE_CODES["9115"]["unit"] = "99"

    TITLE_CODES["9204"] = {}
    TITLE_CODES["9204"]["title"] = "PHYSCN AST PD"
    TITLE_CODES["9204"]["program"] = "PSS"
    TITLE_CODES["9204"]["unit"] = "HX"

    TITLE_CODES["2711"] = {}
    TITLE_CODES["2711"]["title"] = "INTERN-PHARMACY/NON-REP"
    TITLE_CODES["2711"]["program"] = "ACADEMIC"
    TITLE_CODES["2711"]["unit"] = "99"

    TITLE_CODES["8491"] = {}
    TITLE_CODES["8491"]["title"] = "AUTO EQUIP OPR SR PD"
    TITLE_CODES["8491"]["program"] = "PSS"
    TITLE_CODES["8491"]["unit"] = "SX"

    TITLE_CODES["2714"] = {}
    TITLE_CODES["2714"]["title"] = "INTERN-VET MED/NON REP"
    TITLE_CODES["2714"]["program"] = "ACADEMIC"
    TITLE_CODES["2714"]["unit"] = "99"

    TITLE_CODES["9202"] = {}
    TITLE_CODES["9202"]["title"] = "PHYSCN AST SR"
    TITLE_CODES["9202"]["program"] = "PSS"
    TITLE_CODES["9202"]["unit"] = "HX"

    TITLE_CODES["9005"] = {}
    TITLE_CODES["9005"]["title"] = "NUC MED TCHNO TRAINEE"
    TITLE_CODES["9005"]["program"] = "PSS"
    TITLE_CODES["9005"]["unit"] = "HX"

    TITLE_CODES["6103"] = {}
    TITLE_CODES["6103"]["title"] = "ARTIST"
    TITLE_CODES["6103"]["program"] = "PSS"
    TITLE_CODES["6103"]["unit"] = "TX"

    TITLE_CODES["2651"] = {}
    TITLE_CODES["2651"]["title"] = "TEACHER-LHS-CONTINUING"
    TITLE_CODES["2651"]["program"] = "ACADEMIC"
    TITLE_CODES["2651"]["unit"] = "IX"

    TITLE_CODES["2650"] = {}
    TITLE_CODES["2650"]["title"] = "TEACHER-LHS"
    TITLE_CODES["2650"]["program"] = "ACADEMIC"
    TITLE_CODES["2650"]["unit"] = "IX"

    TITLE_CODES["6102"] = {}
    TITLE_CODES["6102"]["title"] = "ARTIST SR"
    TITLE_CODES["6102"]["program"] = "PSS"
    TITLE_CODES["6102"]["unit"] = "TX"

    TITLE_CODES["8985"] = {}
    TITLE_CODES["8985"]["title"] = "HOSP LAB TCHN 2 PD"
    TITLE_CODES["8985"]["program"] = "PSS"
    TITLE_CODES["8985"]["unit"] = "EX"

    TITLE_CODES["8984"] = {}
    TITLE_CODES["8984"]["title"] = "HOSP LAB TCHN 3 PD"
    TITLE_CODES["8984"]["program"] = "PSS"
    TITLE_CODES["8984"]["unit"] = "EX"

    TITLE_CODES["5078"] = {}
    TITLE_CODES["5078"]["title"] = "MED CTR STORES WORKER"
    TITLE_CODES["5078"]["program"] = "PSS"
    TITLE_CODES["5078"]["unit"] = "SX"

    TITLE_CODES["0130"] = {}
    TITLE_CODES["0130"]["title"] = "SPC AST TO PRESIDENT"
    TITLE_CODES["0130"]["program"] = "MSP"
    TITLE_CODES["0130"]["unit"] = "99"

    TITLE_CODES["3412"] = {}
    TITLE_CODES["3412"]["title"] = "VST ASSOC COOP EXT SPECIALIST"
    TITLE_CODES["3412"]["program"] = "ACADEMIC"
    TITLE_CODES["3412"]["unit"] = "99"

    TITLE_CODES["6101"] = {}
    TITLE_CODES["6101"]["title"] = "ARTIST PRN"
    TITLE_CODES["6101"]["program"] = "PSS"
    TITLE_CODES["6101"]["unit"] = "99"

    TITLE_CODES["7161"] = {}
    TITLE_CODES["7161"]["title"] = "ENGR AID PRN"
    TITLE_CODES["7161"]["program"] = "PSS"
    TITLE_CODES["7161"]["unit"] = "TX"

    TITLE_CODES["8982"] = {}
    TITLE_CODES["8982"]["title"] = "ORTHOPTIST SR"
    TITLE_CODES["8982"]["program"] = "PSS"
    TITLE_CODES["8982"]["unit"] = "HX"

    TITLE_CODES["5072"] = {}
    TITLE_CODES["5072"]["title"] = "MED CTR ENVIR SVC WORKER 2 PD"
    TITLE_CODES["5072"]["program"] = "PSS"
    TITLE_CODES["5072"]["unit"] = "SX"

    TITLE_CODES["5073"] = {}
    TITLE_CODES["5073"]["title"] = "MED CTR ENVIR SVC WORKER 1"
    TITLE_CODES["5073"]["program"] = "PSS"
    TITLE_CODES["5073"]["unit"] = "SX"

    TITLE_CODES["0139"] = {}
    TITLE_CODES["0139"]["title"] = "ASC TO CHAN"
    TITLE_CODES["0139"]["program"] = "MSP"
    TITLE_CODES["0139"]["unit"] = "99"

    TITLE_CODES["5071"] = {}
    TITLE_CODES["5071"]["title"] = "STORES SUPV"
    TITLE_CODES["5071"]["program"] = "PSS"
    TITLE_CODES["5071"]["unit"] = "99"

    TITLE_CODES["5076"] = {}
    TITLE_CODES["5076"]["title"] = "MED CTR STOREKEEPER LD"
    TITLE_CODES["5076"]["program"] = "PSS"
    TITLE_CODES["5076"]["unit"] = "SX"

    TITLE_CODES["5077"] = {}
    TITLE_CODES["5077"]["title"] = "MED CTR STOREKEEPER SR"
    TITLE_CODES["5077"]["program"] = "PSS"
    TITLE_CODES["5077"]["unit"] = "SX"

    TITLE_CODES["5074"] = {}
    TITLE_CODES["5074"]["title"] = "MED CTR ENVIR SVC WORKER 2"
    TITLE_CODES["5074"]["program"] = "PSS"
    TITLE_CODES["5074"]["unit"] = "SX"

    TITLE_CODES["9163"] = {}
    TITLE_CODES["9163"]["title"] = "OPERATING ROOM EQUIP SUPV"
    TITLE_CODES["9163"]["program"] = "PSS"
    TITLE_CODES["9163"]["unit"] = "99"

    TITLE_CODES["8021"] = {}
    TITLE_CODES["8021"]["title"] = "PSYCHOLOGIST 2 SUPV"
    TITLE_CODES["8021"]["program"] = "PSS"
    TITLE_CODES["8021"]["unit"] = "99"

    TITLE_CODES["3090"] = {}
    TITLE_CODES["3090"]["title"] = "JR---IN THE AES-ACADEMIC YEAR"
    TITLE_CODES["3090"]["program"] = "ACADEMIC"
    TITLE_CODES["3090"]["unit"] = "FX"

    TITLE_CODES["9133"] = {}
    TITLE_CODES["9133"]["title"] = "ADMIN NURSE 2"
    TITLE_CODES["9133"]["program"] = "PSS"
    TITLE_CODES["9133"]["unit"] = "99"

    TITLE_CODES["9561"] = {}
    TITLE_CODES["9561"]["title"] = "NURSERY TCHN SR"
    TITLE_CODES["9561"]["program"] = "PSS"
    TITLE_CODES["9561"]["unit"] = "SX"

    TITLE_CODES["9562"] = {}
    TITLE_CODES["9562"]["title"] = "NURSERY TCHN"
    TITLE_CODES["9562"]["program"] = "PSS"
    TITLE_CODES["9562"]["unit"] = "SX"

    TITLE_CODES["2017"] = {}
    TITLE_CODES["2017"]["title"] = "CLIN PROF-VOL"
    TITLE_CODES["2017"]["program"] = "ACADEMIC"
    TITLE_CODES["2017"]["unit"] = "99"

    TITLE_CODES["2016"] = {}
    TITLE_CODES["2016"]["title"] = "HS CLIN PROF RECALLED-FY"
    TITLE_CODES["2016"]["program"] = "ACADEMIC"
    TITLE_CODES["2016"]["unit"] = "99"

    TITLE_CODES["2011"] = {}
    TITLE_CODES["2011"]["title"] = "CLIN PROF-DENT-50%/+-FY"
    TITLE_CODES["2011"]["program"] = "ACADEMIC"
    TITLE_CODES["2011"]["unit"] = "99"

    TITLE_CODES["2010"] = {}
    TITLE_CODES["2010"]["title"] = "HS CLIN PROF-FY"
    TITLE_CODES["2010"]["program"] = "ACADEMIC"
    TITLE_CODES["2010"]["unit"] = "99"

    TITLE_CODES["2013"] = {}
    TITLE_CODES["2013"]["title"] = "CLIN PROF DENT-FY-PTC GENCO"
    TITLE_CODES["2013"]["program"] = "ACADEMIC"
    TITLE_CODES["2013"]["unit"] = "99"

    TITLE_CODES["9061"] = {}
    TITLE_CODES["9061"]["title"] = "EEG TCHNO"
    TITLE_CODES["9061"]["program"] = "PSS"
    TITLE_CODES["9061"]["unit"] = "EX"

    TITLE_CODES["9060"] = {}
    TITLE_CODES["9060"]["title"] = "EEG TCHNO SR"
    TITLE_CODES["9060"]["program"] = "PSS"
    TITLE_CODES["9060"]["unit"] = "EX"

    TITLE_CODES["9062"] = {}
    TITLE_CODES["9062"]["title"] = "EEG TCHNO PRN PD"
    TITLE_CODES["9062"]["program"] = "PSS"
    TITLE_CODES["9062"]["unit"] = "EX"

    TITLE_CODES["9065"] = {}
    TITLE_CODES["9065"]["title"] = "HISTO TCHNO 1"
    TITLE_CODES["9065"]["program"] = "PSS"
    TITLE_CODES["9065"]["unit"] = "EX"

    TITLE_CODES["9067"] = {}
    TITLE_CODES["9067"]["title"] = "HISTO TCHNO 3"
    TITLE_CODES["9067"]["program"] = "PSS"
    TITLE_CODES["9067"]["unit"] = "EX"

    TITLE_CODES["9066"] = {}
    TITLE_CODES["9066"]["title"] = "HISTO TCHNO 2"
    TITLE_CODES["9066"]["program"] = "PSS"
    TITLE_CODES["9066"]["unit"] = "EX"

    TITLE_CODES["9068"] = {}
    TITLE_CODES["9068"]["title"] = "HISTO TCHNO SUPV"
    TITLE_CODES["9068"]["program"] = "PSS"
    TITLE_CODES["9068"]["unit"] = "99"

    TITLE_CODES["8149"] = {}
    TITLE_CODES["8149"]["title"] = "FARM MAINT WORKER"
    TITLE_CODES["8149"]["program"] = "PSS"
    TITLE_CODES["8149"]["unit"] = "SX"

    TITLE_CODES["9322"] = {}
    TITLE_CODES["9322"]["title"] = "CMTY HEALTH PRG MGR"
    TITLE_CODES["9322"]["program"] = "PSS"
    TITLE_CODES["9322"]["unit"] = "99"

    TITLE_CODES["9399"] = {}
    TITLE_CODES["9399"]["title"] = "GI ENDOSCOPY TCHN 1"
    TITLE_CODES["9399"]["program"] = "PSS"
    TITLE_CODES["9399"]["unit"] = "EX"

    TITLE_CODES["9801"] = {}
    TITLE_CODES["9801"]["title"] = "FIRE CAPTAIN 56 HRS"
    TITLE_CODES["9801"]["program"] = "PSS"
    TITLE_CODES["9801"]["unit"] = "FF"

    TITLE_CODES["1958"] = {}
    TITLE_CODES["1958"]["title"] = "REGENTS' PROF"
    TITLE_CODES["1958"]["program"] = "ACADEMIC"
    TITLE_CODES["1958"]["unit"] = "99"

    TITLE_CODES["7254"] = {}
    TITLE_CODES["7254"]["title"] = "BUDGET ANL AST"
    TITLE_CODES["7254"]["program"] = "PSS"
    TITLE_CODES["7254"]["unit"] = "99"

    TITLE_CODES["7255"] = {}
    TITLE_CODES["7255"]["title"] = "BUDGET ANL SUPV EX"
    TITLE_CODES["7255"]["program"] = "PSS"
    TITLE_CODES["7255"]["unit"] = "99"

    TITLE_CODES["3249"] = {}
    TITLE_CODES["3249"]["title"] = "SENATE EMERITUS (WOS)"
    TITLE_CODES["3249"]["program"] = "ACADEMIC"
    TITLE_CODES["3249"]["unit"] = "A3"

    TITLE_CODES["7250"] = {}
    TITLE_CODES["7250"]["title"] = "ANL 6 SUPV"
    TITLE_CODES["7250"]["program"] = "PSS"
    TITLE_CODES["7250"]["unit"] = "99"

    TITLE_CODES["7251"] = {}
    TITLE_CODES["7251"]["title"] = "BUDGET ANL PRN 1"
    TITLE_CODES["7251"]["program"] = "PSS"
    TITLE_CODES["7251"]["unit"] = "99"

    TITLE_CODES["7252"] = {}
    TITLE_CODES["7252"]["title"] = "BUDGET ANL SR"
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
    TITLE_CODES["9131"]["title"] = "ADMIN NURSE"
    TITLE_CODES["9131"]["program"] = "PSS"
    TITLE_CODES["9131"]["unit"] = "99"

    TITLE_CODES["9030"] = {}
    TITLE_CODES["9030"]["title"] = "ADMITTING WORKER SUPV"
    TITLE_CODES["9030"]["program"] = "PSS"
    TITLE_CODES["9030"]["unit"] = "99"

    TITLE_CODES["3245"] = {}
    TITLE_CODES["3245"]["title"] = "PGR ---- ACAD YR-XMURAL FUNDS"
    TITLE_CODES["3245"]["program"] = "ACADEMIC"
    TITLE_CODES["3245"]["unit"] = "PX"

    TITLE_CODES["9552"] = {}
    TITLE_CODES["9552"]["title"] = "BOTANICAL GARDEN ARBOR MGR"
    TITLE_CODES["9552"]["program"] = "PSS"
    TITLE_CODES["9552"]["unit"] = "99"

    TITLE_CODES["9134"] = {}
    TITLE_CODES["9134"]["title"] = "ADMIN NURSE 1"
    TITLE_CODES["9134"]["program"] = "PSS"
    TITLE_CODES["9134"]["unit"] = "NX"

    TITLE_CODES["9031"] = {}
    TITLE_CODES["9031"]["title"] = "ADMITTING WORKER PRN"
    TITLE_CODES["9031"]["program"] = "PSS"
    TITLE_CODES["9031"]["unit"] = "EX"

    TITLE_CODES["8970"] = {}
    TITLE_CODES["8970"]["title"] = "HOSP LAB TCHN 4 SUPV"
    TITLE_CODES["8970"]["program"] = "PSS"
    TITLE_CODES["8970"]["unit"] = "99"

    TITLE_CODES["8971"] = {}
    TITLE_CODES["8971"]["title"] = "HOSP LAB TCHN 3 SUPV"
    TITLE_CODES["8971"]["program"] = "PSS"
    TITLE_CODES["8971"]["unit"] = "99"

    TITLE_CODES["8972"] = {}
    TITLE_CODES["8972"]["title"] = "HOSP LAB TCHN 2 SUPV"
    TITLE_CODES["8972"]["program"] = "PSS"
    TITLE_CODES["8972"]["unit"] = "99"

    TITLE_CODES["8973"] = {}
    TITLE_CODES["8973"]["title"] = "HOSP LAB TCHN 4"
    TITLE_CODES["8973"]["program"] = "PSS"
    TITLE_CODES["8973"]["unit"] = "EX"

    TITLE_CODES["8974"] = {}
    TITLE_CODES["8974"]["title"] = "HOSP LAB TCHN 3"
    TITLE_CODES["8974"]["program"] = "PSS"
    TITLE_CODES["8974"]["unit"] = "EX"

    TITLE_CODES["8975"] = {}
    TITLE_CODES["8975"]["title"] = "HOSP LAB TCHN 2"
    TITLE_CODES["8975"]["program"] = "PSS"
    TITLE_CODES["8975"]["unit"] = "EX"

    TITLE_CODES["8683"] = {}
    TITLE_CODES["8683"]["title"] = "MED CTR ELECTR TCHN"
    TITLE_CODES["8683"]["program"] = "PSS"
    TITLE_CODES["8683"]["unit"] = "EX"

    TITLE_CODES["9037"] = {}
    TITLE_CODES["9037"]["title"] = "PERFUSIONIST PRN SUPV"
    TITLE_CODES["9037"]["program"] = "PSS"
    TITLE_CODES["9037"]["unit"] = "99"

    TITLE_CODES["0709"] = {}
    TITLE_CODES["0709"]["title"] = "EAP MGR 2"
    TITLE_CODES["0709"]["program"] = "MSP"
    TITLE_CODES["0709"]["unit"] = "99"

    TITLE_CODES["9130"] = {}
    TITLE_CODES["9130"]["title"] = "NURSE MGR"
    TITLE_CODES["9130"]["program"] = "PSS"
    TITLE_CODES["9130"]["unit"] = "99"

    TITLE_CODES["9035"] = {}
    TITLE_CODES["9035"]["title"] = "ADMITTING WORKER PRN SUPV"
    TITLE_CODES["9035"]["program"] = "PSS"
    TITLE_CODES["9035"]["unit"] = "99"

    TITLE_CODES["0700"] = {}
    TITLE_CODES["0700"]["title"] = "MGT AND PROFL PRG UNTTL"
    TITLE_CODES["0700"]["program"] = "MSP"
    TITLE_CODES["0700"]["unit"] = "99"

    TITLE_CODES["0701"] = {}
    TITLE_CODES["0701"]["title"] = "CHAN MAP AST"
    TITLE_CODES["0701"]["program"] = "MSP"
    TITLE_CODES["0701"]["unit"] = "99"

    TITLE_CODES["0702"] = {}
    TITLE_CODES["0702"]["title"] = "DESIGN CONST PROJECT MGR 6"
    TITLE_CODES["0702"]["program"] = "MSP"
    TITLE_CODES["0702"]["unit"] = "99"

    TITLE_CODES["7630"] = {}
    TITLE_CODES["7630"]["title"] = "AUDITOR SUPV"
    TITLE_CODES["7630"]["program"] = "PSS"
    TITLE_CODES["7630"]["unit"] = "99"

    TITLE_CODES["8651"] = {}
    TITLE_CODES["8651"]["title"] = "LAB MECHN PRN"
    TITLE_CODES["8651"]["program"] = "PSS"
    TITLE_CODES["8651"]["unit"] = "TX"

    TITLE_CODES["0088"] = {}
    TITLE_CODES["0088"]["title"] = "EXEC DIR EXEC"
    TITLE_CODES["0088"]["program"] = "MSP"
    TITLE_CODES["0088"]["unit"] = "99"

    TITLE_CODES["0089"] = {}
    TITLE_CODES["0089"]["title"] = "COUNSEL OF THE REGENTS"
    TITLE_CODES["0089"]["program"] = "MSP"
    TITLE_CODES["0089"]["unit"] = "99"

    TITLE_CODES["9010"] = {}
    TITLE_CODES["9010"]["title"] = "RAD THER TCHNO CHF"
    TITLE_CODES["9010"]["program"] = "PSS"
    TITLE_CODES["9010"]["unit"] = "99"

    TITLE_CODES["9012"] = {}
    TITLE_CODES["9012"]["title"] = "RAD THER TCHNO SR"
    TITLE_CODES["9012"]["program"] = "PSS"
    TITLE_CODES["9012"]["unit"] = "EX"

    TITLE_CODES["5338"] = {}
    TITLE_CODES["5338"]["title"] = "PARKING REPR SUPV"
    TITLE_CODES["5338"]["program"] = "PSS"
    TITLE_CODES["5338"]["unit"] = "99"

    TITLE_CODES["0082"] = {}
    TITLE_CODES["0082"]["title"] = "CHF CAMPUS COUNSEL"
    TITLE_CODES["0082"]["program"] = "MSP"
    TITLE_CODES["0082"]["unit"] = "99"

    TITLE_CODES["0083"] = {}
    TITLE_CODES["0083"]["title"] = "DEPUTY GEN COUNSEL OF REGENTS"
    TITLE_CODES["0083"]["program"] = "MSP"
    TITLE_CODES["0083"]["unit"] = "99"

    TITLE_CODES["0080"] = {}
    TITLE_CODES["0080"]["title"] = "GEN COUNSEL VP LEGAL AFFAIRS"
    TITLE_CODES["0080"]["program"] = "MSP"
    TITLE_CODES["0080"]["unit"] = "99"

    TITLE_CODES["7132"] = {}
    TITLE_CODES["7132"]["title"] = "EHS SPEC 3"
    TITLE_CODES["7132"]["program"] = "PSS"
    TITLE_CODES["7132"]["unit"] = "99"

    TITLE_CODES["7135"] = {}
    TITLE_CODES["7135"]["title"] = "EHS SPEC 2 EX"
    TITLE_CODES["7135"]["program"] = "PSS"
    TITLE_CODES["7135"]["unit"] = "99"

    TITLE_CODES["7134"] = {}
    TITLE_CODES["7134"]["title"] = "EHS SPEC AST"
    TITLE_CODES["7134"]["program"] = "PSS"
    TITLE_CODES["7134"]["unit"] = "99"

    TITLE_CODES["0084"] = {}
    TITLE_CODES["0084"]["title"] = "MGN UNIV COUNSEL OF REGENTS"
    TITLE_CODES["0084"]["program"] = "MSP"
    TITLE_CODES["0084"]["unit"] = "99"

    TITLE_CODES["0085"] = {}
    TITLE_CODES["0085"]["title"] = "UNIV COUNSEL OF THE REGENTS"
    TITLE_CODES["0085"]["program"] = "MSP"
    TITLE_CODES["0085"]["unit"] = "99"

    TITLE_CODES["0797"] = {}
    TITLE_CODES["0797"]["title"] = "FIRE CHF"
    TITLE_CODES["0797"]["program"] = "MSP"
    TITLE_CODES["0797"]["unit"] = "99"

    TITLE_CODES["0796"] = {}
    TITLE_CODES["0796"]["title"] = "OCCUPATIONAL THER 5"
    TITLE_CODES["0796"]["program"] = "MSP"
    TITLE_CODES["0796"]["unit"] = "99"

    TITLE_CODES["0795"] = {}
    TITLE_CODES["0795"]["title"] = "PHYS THER 5"
    TITLE_CODES["0795"]["program"] = "MSP"
    TITLE_CODES["0795"]["unit"] = "99"

    TITLE_CODES["0794"] = {}
    TITLE_CODES["0794"]["title"] = "REHAB SVC CHF"
    TITLE_CODES["0794"]["program"] = "MSP"
    TITLE_CODES["0794"]["unit"] = "99"

    TITLE_CODES["0793"] = {}
    TITLE_CODES["0793"]["title"] = "PSYCHOLOGIST 3"
    TITLE_CODES["0793"]["program"] = "MSP"
    TITLE_CODES["0793"]["unit"] = "99"

    TITLE_CODES["0792"] = {}
    TITLE_CODES["0792"]["title"] = "PSYCHOLOGIST CHF"
    TITLE_CODES["0792"]["program"] = "MSP"
    TITLE_CODES["0792"]["unit"] = "99"

    TITLE_CODES["0791"] = {}
    TITLE_CODES["0791"]["title"] = "SPEECH PATHOLOGY SUPV"
    TITLE_CODES["0791"]["program"] = "MSP"
    TITLE_CODES["0791"]["unit"] = "99"

    TITLE_CODES["0790"] = {}
    TITLE_CODES["0790"]["title"] = "CMTY HEALTH PRG CHF"
    TITLE_CODES["0790"]["program"] = "MSP"
    TITLE_CODES["0790"]["unit"] = "99"

    TITLE_CODES["5313"] = {}
    TITLE_CODES["5313"]["title"] = "POLICE SERGEANT"
    TITLE_CODES["5313"]["program"] = "PSS"
    TITLE_CODES["5313"]["unit"] = "99"

    TITLE_CODES["5312"] = {}
    TITLE_CODES["5312"]["title"] = "POLICE LIEUTENANT"
    TITLE_CODES["5312"]["program"] = "PSS"
    TITLE_CODES["5312"]["unit"] = "99"

    TITLE_CODES["1719"] = {}
    TITLE_CODES["1719"]["title"] = "ASSOC PROF-HCOMP"
    TITLE_CODES["1719"]["program"] = "ACADEMIC"
    TITLE_CODES["1719"]["unit"] = "A3"

    TITLE_CODES["1718"] = {}
    TITLE_CODES["1718"]["title"] = "ACT ASST PROFESSOR-MEDCOMP-A"
    TITLE_CODES["1718"]["program"] = "ACADEMIC"
    TITLE_CODES["1718"]["unit"] = "99"

    TITLE_CODES["0799"] = {}
    TITLE_CODES["0799"]["title"] = "ASC TO PRES"
    TITLE_CODES["0799"]["program"] = "MSP"
    TITLE_CODES["0799"]["unit"] = "99"

    TITLE_CODES["0798"] = {}
    TITLE_CODES["0798"]["title"] = "ASC OF PRES OR CHAN"
    TITLE_CODES["0798"]["program"] = "MSP"
    TITLE_CODES["0798"]["unit"] = "99"

    TITLE_CODES["6311"] = {}
    TITLE_CODES["6311"]["title"] = "PUBL EVENTS MGR PRN"
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
    TITLE_CODES["1650"]["title"] = "LECT-MISCELLANEOUS/PART TIME"
    TITLE_CODES["1650"]["program"] = "ACADEMIC"
    TITLE_CODES["1650"]["unit"] = "99"

    TITLE_CODES["8525"] = {}
    TITLE_CODES["8525"]["title"] = "FARM MACH ATTENDANT"
    TITLE_CODES["8525"]["program"] = "PSS"
    TITLE_CODES["8525"]["unit"] = "SX"

    TITLE_CODES["9540"] = {}
    TITLE_CODES["9540"]["title"] = "ANIMAL HEALTH TCHN 2 SUPV"
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
    TITLE_CODES["8208"]["title"] = "BLDG MAINT SUPV"
    TITLE_CODES["8208"]["program"] = "PSS"
    TITLE_CODES["8208"]["unit"] = "99"

    TITLE_CODES["1738"] = {}
    TITLE_CODES["1738"]["title"] = "ACT ASST PROFESSOR-GENCOMP-B"
    TITLE_CODES["1738"]["program"] = "ACADEMIC"
    TITLE_CODES["1738"]["unit"] = "99"

    TITLE_CODES["9345"] = {}
    TITLE_CODES["9345"]["title"] = "CHILD DEV ASC"
    TITLE_CODES["9345"]["program"] = "PSS"
    TITLE_CODES["9345"]["unit"] = "HX"

    TITLE_CODES["1132"] = {}
    TITLE_CODES["1132"]["title"] = "PROF EMERITUS(WOS)"
    TITLE_CODES["1132"]["program"] = "ACADEMIC"
    TITLE_CODES["1132"]["unit"] = "A3"

    TITLE_CODES["1130"] = {}
    TITLE_CODES["1130"]["title"] = "PROF-10 MONTHS"
    TITLE_CODES["1130"]["program"] = "ACADEMIC"
    TITLE_CODES["1130"]["unit"] = "A3"

    TITLE_CODES["8072"] = {}
    TITLE_CODES["8072"]["title"] = "LABORER SUPV"
    TITLE_CODES["8072"]["program"] = "PSS"
    TITLE_CODES["8072"]["unit"] = "99"

    TITLE_CODES["1984"] = {}
    TITLE_CODES["1984"]["title"] = "ASSOC RES-AY-1/9-B/E/E"
    TITLE_CODES["1984"]["program"] = "ACADEMIC"
    TITLE_CODES["1984"]["unit"] = "FX"

    TITLE_CODES["8200"] = {}
    TITLE_CODES["8200"]["title"] = "GLAZIER"
    TITLE_CODES["8200"]["program"] = "PSS"
    TITLE_CODES["8200"]["unit"] = "K3"

    TITLE_CODES["7625"] = {}
    TITLE_CODES["7625"]["title"] = "ACCOUNTANT 2 SUPV"
    TITLE_CODES["7625"]["program"] = "PSS"
    TITLE_CODES["7625"]["unit"] = "99"

    TITLE_CODES["2060"] = {}
    TITLE_CODES["2060"]["title"] = "HS CLIN INSTR-AY"
    TITLE_CODES["2060"]["program"] = "ACADEMIC"
    TITLE_CODES["2060"]["unit"] = "99"

    TITLE_CODES["1985"] = {}
    TITLE_CODES["1985"]["title"] = "ASST RES-AY-B/E/E"
    TITLE_CODES["1985"]["program"] = "ACADEMIC"
    TITLE_CODES["1985"]["unit"] = "FX"

    TITLE_CODES["7621"] = {}
    TITLE_CODES["7621"]["title"] = "AUDITOR 4"
    TITLE_CODES["7621"]["program"] = "PSS"
    TITLE_CODES["7621"]["unit"] = "99"

    TITLE_CODES["7620"] = {}
    TITLE_CODES["7620"]["title"] = "ACCOUNTANT 2"
    TITLE_CODES["7620"]["program"] = "PSS"
    TITLE_CODES["7620"]["unit"] = "99"

    TITLE_CODES["7623"] = {}
    TITLE_CODES["7623"]["title"] = "AUDITOR 1"
    TITLE_CODES["7623"]["program"] = "PSS"
    TITLE_CODES["7623"]["unit"] = "99"

    TITLE_CODES["7622"] = {}
    TITLE_CODES["7622"]["title"] = "AUDITOR 3"
    TITLE_CODES["7622"]["program"] = "PSS"
    TITLE_CODES["7622"]["unit"] = "99"

    TITLE_CODES["1982"] = {}
    TITLE_CODES["1982"]["title"] = "RES-AY-1/9-B/E/E"
    TITLE_CODES["1982"]["program"] = "ACADEMIC"
    TITLE_CODES["1982"]["unit"] = "FX"

    TITLE_CODES["7192"] = {}
    TITLE_CODES["7192"]["title"] = "DATA PROC PROD CRD SR"
    TITLE_CODES["7192"]["program"] = "PSS"
    TITLE_CODES["7192"]["unit"] = "CX"

    TITLE_CODES["7782"] = {}
    TITLE_CODES["7782"]["title"] = "BUYER 3 SUPV"
    TITLE_CODES["7782"]["program"] = "PSS"
    TITLE_CODES["7782"]["unit"] = "99"

    TITLE_CODES["7780"] = {}
    TITLE_CODES["7780"]["title"] = "BUYER 1 SUPV"
    TITLE_CODES["7780"]["program"] = "PSS"
    TITLE_CODES["7780"]["unit"] = "99"

    TITLE_CODES["1983"] = {}
    TITLE_CODES["1983"]["title"] = "ASSOC RES-AY-B/E/E"
    TITLE_CODES["1983"]["program"] = "ACADEMIC"
    TITLE_CODES["1983"]["unit"] = "FX"

    TITLE_CODES["3391"] = {}
    TITLE_CODES["3391"]["title"] = "PROJ SCIENTIST-FY-B/E/E"
    TITLE_CODES["3391"]["program"] = "ACADEMIC"
    TITLE_CODES["3391"]["unit"] = "FX"

    TITLE_CODES["3390"] = {}
    TITLE_CODES["3390"]["title"] = "PROJ SCIENTIST-FY"
    TITLE_CODES["3390"]["program"] = "ACADEMIC"
    TITLE_CODES["3390"]["unit"] = "FX"

    TITLE_CODES["1434"] = {}
    TITLE_CODES["1434"]["title"] = "VIS INSTRUCTOR-GENCOMP"
    TITLE_CODES["1434"]["program"] = "ACADEMIC"
    TITLE_CODES["1434"]["unit"] = "99"

    TITLE_CODES["3019"] = {}
    TITLE_CODES["3019"]["title"] = "ACT ASSOC AGRON AES-SFT-VM"
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
    TITLE_CODES["3397"]["title"] = "VIS ASSOC PROJ SCIENTIST"
    TITLE_CODES["3397"]["program"] = "ACADEMIC"
    TITLE_CODES["3397"]["unit"] = "99"

    TITLE_CODES["1431"] = {}
    TITLE_CODES["1431"]["title"] = "VIS PROFESSOR-GENCOMP"
    TITLE_CODES["1431"]["program"] = "ACADEMIC"
    TITLE_CODES["1431"]["unit"] = "99"

    TITLE_CODES["3012"] = {}
    TITLE_CODES["3012"]["title"] = "AGRON AES-B/E/E"
    TITLE_CODES["3012"]["program"] = "ACADEMIC"
    TITLE_CODES["3012"]["unit"] = "FX"

    TITLE_CODES["3013"] = {}
    TITLE_CODES["3013"]["title"] = "ASSOC AGRON AES-B/E/E"
    TITLE_CODES["3013"]["program"] = "ACADEMIC"
    TITLE_CODES["3013"]["unit"] = "FX"

    TITLE_CODES["3010"] = {}
    TITLE_CODES["3010"]["title"] = "ASSOC AGRON AES"
    TITLE_CODES["3010"]["program"] = "ACADEMIC"
    TITLE_CODES["3010"]["unit"] = "FX"

    TITLE_CODES["3011"] = {}
    TITLE_CODES["3011"]["title"] = "ASSOC AGRON AES-SFT-VM"
    TITLE_CODES["3011"]["program"] = "ACADEMIC"
    TITLE_CODES["3011"]["unit"] = "FX"

    TITLE_CODES["3017"] = {}
    TITLE_CODES["3017"]["title"] = "ACT ASSOC AGRON AES"
    TITLE_CODES["3017"]["program"] = "ACADEMIC"
    TITLE_CODES["3017"]["unit"] = "99"

    TITLE_CODES["3014"] = {}
    TITLE_CODES["3014"]["title"] = "ASSOC SPECIALIST AES"
    TITLE_CODES["3014"]["program"] = "ACADEMIC"
    TITLE_CODES["3014"]["unit"] = "FX"

    TITLE_CODES["3015"] = {}
    TITLE_CODES["3015"]["title"] = "ASST AGRON AES-B/E/E"
    TITLE_CODES["3015"]["program"] = "ACADEMIC"
    TITLE_CODES["3015"]["unit"] = "FX"

    TITLE_CODES["9187"] = {}
    TITLE_CODES["9187"]["title"] = "EXAMING DENTIST"
    TITLE_CODES["9187"]["program"] = "PSS"
    TITLE_CODES["9187"]["unit"] = "99"

    TITLE_CODES["9805"] = {}
    TITLE_CODES["9805"]["title"] = "FIRE FIGHTER"
    TITLE_CODES["9805"]["program"] = "PSS"
    TITLE_CODES["9805"]["unit"] = "FF"

    TITLE_CODES["0511"] = {}
    TITLE_CODES["0511"]["title"] = "ENTEROSTOMAL THERAPIST"
    TITLE_CODES["0511"]["program"] = "MSP"
    TITLE_CODES["0511"]["unit"] = "99"

    TITLE_CODES["1000"] = {}
    TITLE_CODES["1000"]["title"] = "DEAN"
    TITLE_CODES["1000"]["program"] = "ACADEMIC"
    TITLE_CODES["1000"]["unit"] = "99"

    TITLE_CODES["8159"] = {}
    TITLE_CODES["8159"]["title"] = "ELEVATOR MECH LD"
    TITLE_CODES["8159"]["program"] = "PSS"
    TITLE_CODES["8159"]["unit"] = "K3"

    TITLE_CODES["8050"] = {}
    TITLE_CODES["8050"]["title"] = "HVY EQUIP OPERATING ENGR APPR"
    TITLE_CODES["8050"]["program"] = "PSS"
    TITLE_CODES["8050"]["unit"] = "K3"

    TITLE_CODES["9528"] = {}
    TITLE_CODES["9528"]["title"] = "ANIMAL TCHN PRN SUPV"
    TITLE_CODES["9528"]["program"] = "PSS"
    TITLE_CODES["9528"]["unit"] = "99"

    TITLE_CODES["0450"] = {}
    TITLE_CODES["0450"]["title"] = "DEPUTY TO SVP"
    TITLE_CODES["0450"]["program"] = "MSP"
    TITLE_CODES["0450"]["unit"] = "99"

    TITLE_CODES["3218"] = {}
    TITLE_CODES["3218"]["title"] = "VIS ASSOC RES"
    TITLE_CODES["3218"]["program"] = "ACADEMIC"
    TITLE_CODES["3218"]["unit"] = "99"

    TITLE_CODES["8059"] = {}
    TITLE_CODES["8059"]["title"] = "PATIENT RCDS ABSTRACTOR 2 PD"
    TITLE_CODES["8059"]["program"] = "PSS"
    TITLE_CODES["8059"]["unit"] = "EX"

    TITLE_CODES["1343"] = {}
    TITLE_CODES["1343"]["title"] = "ASST PROF-AY-B/E/E"
    TITLE_CODES["1343"]["program"] = "ACADEMIC"
    TITLE_CODES["1343"]["unit"] = "A3"

    TITLE_CODES["0454"] = {}
    TITLE_CODES["0454"]["title"] = "EXEC AST"
    TITLE_CODES["0454"]["program"] = "MSP"
    TITLE_CODES["0454"]["unit"] = "99"

    TITLE_CODES["1345"] = {}
    TITLE_CODES["1345"]["title"] = "ASST PROF-AY-1/9-B/E/E"
    TITLE_CODES["1345"]["program"] = "ACADEMIC"
    TITLE_CODES["1345"]["unit"] = "A3"

    TITLE_CODES["9804"] = {}
    TITLE_CODES["9804"]["title"] = "FIRE SPEC"
    TITLE_CODES["9804"]["program"] = "PSS"
    TITLE_CODES["9804"]["unit"] = "TX"

    TITLE_CODES["8291"] = {}
    TITLE_CODES["8291"]["title"] = "TELEVISION TCHN PRN"
    TITLE_CODES["8291"]["program"] = "PSS"
    TITLE_CODES["8291"]["unit"] = "TX"

    TITLE_CODES["8290"] = {}
    TITLE_CODES["8290"]["title"] = "TELEVISION TCHN PRN SUPV"
    TITLE_CODES["8290"]["program"] = "PSS"
    TITLE_CODES["8290"]["unit"] = "99"

    TITLE_CODES["8118"] = {}
    TITLE_CODES["8118"]["title"] = "AGRICULTURE SUPT PRN"
    TITLE_CODES["8118"]["program"] = "PSS"
    TITLE_CODES["8118"]["unit"] = "99"

    TITLE_CODES["8119"] = {}
    TITLE_CODES["8119"]["title"] = "AGRICULTURE SUPT SR"
    TITLE_CODES["8119"]["program"] = "PSS"
    TITLE_CODES["8119"]["unit"] = "99"

    TITLE_CODES["1988"] = {}
    TITLE_CODES["1988"]["title"] = "ASSOC RES-FY-B/E/E"
    TITLE_CODES["1988"]["program"] = "ACADEMIC"
    TITLE_CODES["1988"]["unit"] = "FX"

    TITLE_CODES["8297"] = {}
    TITLE_CODES["8297"]["title"] = "MED CTR ELECTR TCHN SUPV SR"
    TITLE_CODES["8297"]["program"] = "PSS"
    TITLE_CODES["8297"]["unit"] = "99"

    TITLE_CODES["4348"] = {}
    TITLE_CODES["4348"]["title"] = "STDT AFFAIRS OFCR 1 SUPV"
    TITLE_CODES["4348"]["program"] = "PSS"
    TITLE_CODES["4348"]["unit"] = "99"

    TITLE_CODES["8299"] = {}
    TITLE_CODES["8299"]["title"] = "ELECTR TCHN SR SUPV"
    TITLE_CODES["8299"]["program"] = "PSS"
    TITLE_CODES["8299"]["unit"] = "99"

    TITLE_CODES["8298"] = {}
    TITLE_CODES["8298"]["title"] = "MED CTR ELECTR TCHN SUPV"
    TITLE_CODES["8298"]["program"] = "PSS"
    TITLE_CODES["8298"]["unit"] = "99"

    TITLE_CODES["8110"] = {}
    TITLE_CODES["8110"]["title"] = "CARPENTER"
    TITLE_CODES["8110"]["program"] = "PSS"
    TITLE_CODES["8110"]["unit"] = "K3"

    TITLE_CODES["8111"] = {}
    TITLE_CODES["8111"]["title"] = "CARPENTER APPR"
    TITLE_CODES["8111"]["program"] = "PSS"
    TITLE_CODES["8111"]["unit"] = "K3"

    TITLE_CODES["8116"] = {}
    TITLE_CODES["8116"]["title"] = "PHYS PLT SUPT AST"
    TITLE_CODES["8116"]["program"] = "PSS"
    TITLE_CODES["8116"]["unit"] = "99"

    TITLE_CODES["3700"] = {}
    TITLE_CODES["3700"]["title"] = "FACULTY CONSULTANT"
    TITLE_CODES["3700"]["program"] = "ACADEMIC"
    TITLE_CODES["3700"]["unit"] = "99"

    TITLE_CODES["8114"] = {}
    TITLE_CODES["8114"]["title"] = "PHYS PLT SUPT SR"
    TITLE_CODES["8114"]["program"] = "PSS"
    TITLE_CODES["8114"]["unit"] = "99"

    TITLE_CODES["8115"] = {}
    TITLE_CODES["8115"]["title"] = "PHYS PLT SUPT"
    TITLE_CODES["8115"]["program"] = "PSS"
    TITLE_CODES["8115"]["unit"] = "99"

    TITLE_CODES["7713"] = {}
    TITLE_CODES["7713"]["title"] = "PRINTING EST"
    TITLE_CODES["7713"]["program"] = "PSS"
    TITLE_CODES["7713"]["unit"] = "TX"

    TITLE_CODES["5538"] = {}
    TITLE_CODES["5538"]["title"] = "COOK HOUSEKEEPER"
    TITLE_CODES["5538"]["program"] = "PSS"
    TITLE_CODES["5538"]["unit"] = "SX"

    TITLE_CODES["7247"] = {}
    TITLE_CODES["7247"]["title"] = "ANL 3 SUPV"
    TITLE_CODES["7247"]["program"] = "PSS"
    TITLE_CODES["7247"]["unit"] = "99"

    TITLE_CODES["7497"] = {}
    TITLE_CODES["7497"]["title"] = "GIFT SHOP MGR"
    TITLE_CODES["7497"]["program"] = "PSS"
    TITLE_CODES["7497"]["unit"] = "99"

    TITLE_CODES["1502"] = {}
    TITLE_CODES["1502"]["title"] = "ASSOC IN __-AY-NON-GSHIP"
    TITLE_CODES["1502"]["program"] = "ACADEMIC"
    TITLE_CODES["1502"]["unit"] = "BX"

    TITLE_CODES["1501"] = {}
    TITLE_CODES["1501"]["title"] = "ASSOC IN ____-AY-GSHIP"
    TITLE_CODES["1501"]["program"] = "ACADEMIC"
    TITLE_CODES["1501"]["unit"] = "BX"

    TITLE_CODES["1506"] = {}
    TITLE_CODES["1506"]["title"] = "ASSOC IN __ -AY-1/9-GSHIP"
    TITLE_CODES["1506"]["program"] = "ACADEMIC"
    TITLE_CODES["1506"]["unit"] = "BX"

    TITLE_CODES["1507"] = {}
    TITLE_CODES["1507"]["title"] = "ASSOC IN__-AY- 1/9 -NON-GSHIP"
    TITLE_CODES["1507"]["program"] = "ACADEMIC"
    TITLE_CODES["1507"]["unit"] = "BX"

    TITLE_CODES["9095"] = {}
    TITLE_CODES["9095"]["title"] = "ACCESS REPR SR PD"
    TITLE_CODES["9095"]["program"] = "PSS"
    TITLE_CODES["9095"]["unit"] = "EX"

    TITLE_CODES["3085"] = {}
    TITLE_CODES["3085"]["title"] = "ACT AST---IN THE AES-AY-1/9"
    TITLE_CODES["3085"]["program"] = "ACADEMIC"
    TITLE_CODES["3085"]["unit"] = "99"

    TITLE_CODES["3084"] = {}
    TITLE_CODES["3084"]["title"] = "ACT ASST AGRON AES-AY"
    TITLE_CODES["3084"]["program"] = "ACADEMIC"
    TITLE_CODES["3084"]["unit"] = "99"

    TITLE_CODES["3087"] = {}
    TITLE_CODES["3087"]["title"] = "ACT AST--IN AES-B/ECN/EN-AY1/9"
    TITLE_CODES["3087"]["program"] = "ACADEMIC"
    TITLE_CODES["3087"]["unit"] = "99"

    TITLE_CODES["3086"] = {}
    TITLE_CODES["3086"]["title"] = "ACT ASST AGRON AES-B/E/E/-AY"
    TITLE_CODES["3086"]["program"] = "ACADEMIC"
    TITLE_CODES["3086"]["unit"] = "99"

    TITLE_CODES["3081"] = {}
    TITLE_CODES["3081"]["title"] = "AST---IN THE AES-ACAD YR-1/9TH"
    TITLE_CODES["3081"]["program"] = "ACADEMIC"
    TITLE_CODES["3081"]["unit"] = "FX"

    TITLE_CODES["3080"] = {}
    TITLE_CODES["3080"]["title"] = "ASST AGRON AES-AY"
    TITLE_CODES["3080"]["program"] = "ACADEMIC"
    TITLE_CODES["3080"]["unit"] = "FX"

    TITLE_CODES["3083"] = {}
    TITLE_CODES["3083"]["title"] = "AST---IN AES-B/ECON/ENG-AY-1/9"
    TITLE_CODES["3083"]["program"] = "ACADEMIC"
    TITLE_CODES["3083"]["unit"] = "FX"

    TITLE_CODES["3082"] = {}
    TITLE_CODES["3082"]["title"] = "ASST AGRON AES-AY-B/E/E"
    TITLE_CODES["3082"]["program"] = "ACADEMIC"
    TITLE_CODES["3082"]["unit"] = "FX"

    TITLE_CODES["8076"] = {}
    TITLE_CODES["8076"]["title"] = "LABORER"
    TITLE_CODES["8076"]["program"] = "PSS"
    TITLE_CODES["8076"]["unit"] = "SX"

    TITLE_CODES["1644"] = {}
    TITLE_CODES["1644"]["title"] = "SR LECT-FY"
    TITLE_CODES["1644"]["program"] = "ACADEMIC"
    TITLE_CODES["1644"]["unit"] = "IX"

    TITLE_CODES["8475"] = {}
    TITLE_CODES["8475"]["title"] = "AUTO ATTENDANT"
    TITLE_CODES["8475"]["program"] = "PSS"
    TITLE_CODES["8475"]["unit"] = "SX"

    TITLE_CODES["8474"] = {}
    TITLE_CODES["8474"]["title"] = "AUTO TCHN AST"
    TITLE_CODES["8474"]["program"] = "PSS"
    TITLE_CODES["8474"]["unit"] = "SX"

    TITLE_CODES["8477"] = {}
    TITLE_CODES["8477"]["title"] = "HVY DUTY EQUIP TCHN AST"
    TITLE_CODES["8477"]["program"] = "PSS"
    TITLE_CODES["8477"]["unit"] = "SX"

    TITLE_CODES["8476"] = {}
    TITLE_CODES["8476"]["title"] = "HVY DUTY EQUIP TCHN"
    TITLE_CODES["8476"]["program"] = "PSS"
    TITLE_CODES["8476"]["unit"] = "SX"

    TITLE_CODES["8471"] = {}
    TITLE_CODES["8471"]["title"] = "AUTO TCHN SUPV"
    TITLE_CODES["8471"]["program"] = "PSS"
    TITLE_CODES["8471"]["unit"] = "99"

    TITLE_CODES["8470"] = {}
    TITLE_CODES["8470"]["title"] = "AUTO ATTENDANT SUPV"
    TITLE_CODES["8470"]["program"] = "PSS"
    TITLE_CODES["8470"]["unit"] = "99"

    TITLE_CODES["8473"] = {}
    TITLE_CODES["8473"]["title"] = "AUTO TCHN"
    TITLE_CODES["8473"]["program"] = "PSS"
    TITLE_CODES["8473"]["unit"] = "SX"

    TITLE_CODES["7619"] = {}
    TITLE_CODES["7619"]["title"] = "ACCOUNTANT AST"
    TITLE_CODES["7619"]["program"] = "PSS"
    TITLE_CODES["7619"]["unit"] = "99"

    TITLE_CODES["7643"] = {}
    TITLE_CODES["7643"]["title"] = "EMPLOYMENT REPR SR"
    TITLE_CODES["7643"]["program"] = "PSS"
    TITLE_CODES["7643"]["unit"] = "99"

    TITLE_CODES["0010"] = {}
    TITLE_CODES["0010"]["title"] = "PROVOST EXEC VP ACAD AFFAIRS"
    TITLE_CODES["0010"]["program"] = "MSP"
    TITLE_CODES["0010"]["unit"] = "99"

    TITLE_CODES["0012"] = {}
    TITLE_CODES["0012"]["title"] = "SVP DESIGNATE"
    TITLE_CODES["0012"]["program"] = "MSP"
    TITLE_CODES["0012"]["unit"] = "99"

    TITLE_CODES["0015"] = {}
    TITLE_CODES["0015"]["title"] = "VP FUNC AREA"
    TITLE_CODES["0015"]["program"] = "MSP"
    TITLE_CODES["0015"]["unit"] = "99"

    TITLE_CODES["0014"] = {}
    TITLE_CODES["0014"]["title"] = "SVP BUS AND FIN"
    TITLE_CODES["0014"]["program"] = "MSP"
    TITLE_CODES["0014"]["unit"] = "99"

    TITLE_CODES["0017"] = {}
    TITLE_CODES["0017"]["title"] = "VP HEALTH AFFAIRS"
    TITLE_CODES["0017"]["program"] = "MSP"
    TITLE_CODES["0017"]["unit"] = "99"

    TITLE_CODES["0016"] = {}
    TITLE_CODES["0016"]["title"] = "VP ANR"
    TITLE_CODES["0016"]["program"] = "MSP"
    TITLE_CODES["0016"]["unit"] = "99"

    TITLE_CODES["0019"] = {}
    TITLE_CODES["0019"]["title"] = "VP CLIN SVC DEV"
    TITLE_CODES["0019"]["program"] = "MSP"
    TITLE_CODES["0019"]["unit"] = "99"

    TITLE_CODES["0018"] = {}
    TITLE_CODES["0018"]["title"] = "SVP UNIV AFFAIRS"
    TITLE_CODES["0018"]["program"] = "MSP"
    TITLE_CODES["0018"]["unit"] = "99"

    TITLE_CODES["7774"] = {}
    TITLE_CODES["7774"]["title"] = "BUYER 2"
    TITLE_CODES["7774"]["program"] = "PSS"
    TITLE_CODES["7774"]["unit"] = "99"

    TITLE_CODES["9196"] = {}
    TITLE_CODES["9196"]["title"] = "REG DENTAL AST"
    TITLE_CODES["9196"]["program"] = "PSS"
    TITLE_CODES["9196"]["unit"] = "EX"

    TITLE_CODES["9301"] = {}
    TITLE_CODES["9301"]["title"] = "ANGIOGRAPHY TCHNO"
    TITLE_CODES["9301"]["program"] = "PSS"
    TITLE_CODES["9301"]["unit"] = "EX"

    TITLE_CODES["9308"] = {}
    TITLE_CODES["9308"]["title"] = "SOCIAL WORKER 1"
    TITLE_CODES["9308"]["program"] = "PSS"
    TITLE_CODES["9308"]["unit"] = "HX"

    TITLE_CODES["5292"] = {}
    TITLE_CODES["5292"]["title"] = "MED CTR SECURITY OFCR"
    TITLE_CODES["5292"]["program"] = "PSS"
    TITLE_CODES["5292"]["unit"] = "SX"

    TITLE_CODES["4666"] = {}
    TITLE_CODES["4666"]["title"] = "PATIENT BILLER 3 PD"
    TITLE_CODES["4666"]["program"] = "PSS"
    TITLE_CODES["4666"]["unit"] = "EX"

    TITLE_CODES["7642"] = {}
    TITLE_CODES["7642"]["title"] = "HR ANL 7 SUPV"
    TITLE_CODES["7642"]["program"] = "PSS"
    TITLE_CODES["7642"]["unit"] = "99"

    TITLE_CODES["9309"] = {}
    TITLE_CODES["9309"]["title"] = "SOCIAL WORKER 2 PD"
    TITLE_CODES["9309"]["program"] = "PSS"
    TITLE_CODES["9309"]["unit"] = "HX"

    TITLE_CODES["4667"] = {}
    TITLE_CODES["4667"]["title"] = "PATIENT BILLER 2 PD"
    TITLE_CODES["4667"]["program"] = "PSS"
    TITLE_CODES["4667"]["unit"] = "EX"

    TITLE_CODES["4761"] = {}
    TITLE_CODES["4761"]["title"] = "REPROGRAPHICS SUPV SR EX"
    TITLE_CODES["4761"]["program"] = "PSS"
    TITLE_CODES["4761"]["unit"] = "99"

    TITLE_CODES["4763"] = {}
    TITLE_CODES["4763"]["title"] = "REPROGRAPHICS TCHN PRN"
    TITLE_CODES["4763"]["program"] = "PSS"
    TITLE_CODES["4763"]["unit"] = "SX"

    TITLE_CODES["4762"] = {}
    TITLE_CODES["4762"]["title"] = "REPROGRAPHICS TCHN LD"
    TITLE_CODES["4762"]["program"] = "PSS"
    TITLE_CODES["4762"]["unit"] = "SX"

    TITLE_CODES["4765"] = {}
    TITLE_CODES["4765"]["title"] = "REPROGRAPHICS TCHN"
    TITLE_CODES["4765"]["program"] = "PSS"
    TITLE_CODES["4765"]["unit"] = "SX"

    TITLE_CODES["4764"] = {}
    TITLE_CODES["4764"]["title"] = "REPROGRAPHICS TCHN SR"
    TITLE_CODES["4764"]["program"] = "PSS"
    TITLE_CODES["4764"]["unit"] = "SX"

    TITLE_CODES["4766"] = {}
    TITLE_CODES["4766"]["title"] = "REPROGRAPHICS TCHN AST"
    TITLE_CODES["4766"]["program"] = "PSS"
    TITLE_CODES["4766"]["unit"] = "SX"

    TITLE_CODES["4768"] = {}
    TITLE_CODES["4768"]["title"] = "REPROGRAPHICS SUPV"
    TITLE_CODES["4768"]["program"] = "PSS"
    TITLE_CODES["4768"]["unit"] = "99"

    TITLE_CODES["7641"] = {}
    TITLE_CODES["7641"]["title"] = "EMPLOYMENT OFCR"
    TITLE_CODES["7641"]["program"] = "PSS"
    TITLE_CODES["7641"]["unit"] = "99"

    TITLE_CODES["9449"] = {}
    TITLE_CODES["9449"]["title"] = "REHAB SVC CHF ASC"
    TITLE_CODES["9449"]["program"] = "PSS"
    TITLE_CODES["9449"]["unit"] = "99"

    TITLE_CODES["9307"] = {}
    TITLE_CODES["9307"]["title"] = "SOCIAL WORKER 2"
    TITLE_CODES["9307"]["program"] = "PSS"
    TITLE_CODES["9307"]["unit"] = "HX"

    TITLE_CODES["8539"] = {}
    TITLE_CODES["8539"]["title"] = "FARM WORKER"
    TITLE_CODES["8539"]["program"] = "PSS"
    TITLE_CODES["8539"]["unit"] = "SX"

    TITLE_CODES["4000"] = {}
    TITLE_CODES["4000"]["title"] = "STDT AID OUTSIDE AGENCY"
    TITLE_CODES["4000"]["program"] = "PSS"
    TITLE_CODES["4000"]["unit"] = "99"

    TITLE_CODES["4001"] = {}
    TITLE_CODES["4001"]["title"] = "RECREATION SUPV PRN"
    TITLE_CODES["4001"]["program"] = "PSS"
    TITLE_CODES["4001"]["unit"] = "99"

    TITLE_CODES["4002"] = {}
    TITLE_CODES["4002"]["title"] = "RECREATION SUPV SR"
    TITLE_CODES["4002"]["program"] = "PSS"
    TITLE_CODES["4002"]["unit"] = "99"

    TITLE_CODES["4003"] = {}
    TITLE_CODES["4003"]["title"] = "RECREATION SUPV"
    TITLE_CODES["4003"]["program"] = "PSS"
    TITLE_CODES["4003"]["unit"] = "99"

    TITLE_CODES["4004"] = {}
    TITLE_CODES["4004"]["title"] = "RECREATION SUPV AST"
    TITLE_CODES["4004"]["program"] = "PSS"
    TITLE_CODES["4004"]["unit"] = "99"

    TITLE_CODES["4005"] = {}
    TITLE_CODES["4005"]["title"] = "INTERCOL ATH HEAD COACH EX"
    TITLE_CODES["4005"]["program"] = "PSS"
    TITLE_CODES["4005"]["unit"] = "99"

    TITLE_CODES["4006"] = {}
    TITLE_CODES["4006"]["title"] = "COACH SPEC"
    TITLE_CODES["4006"]["program"] = "PSS"
    TITLE_CODES["4006"]["unit"] = "99"

    TITLE_CODES["4007"] = {}
    TITLE_CODES["4007"]["title"] = "INTERCOL ATH COACH AST EX"
    TITLE_CODES["4007"]["program"] = "PSS"
    TITLE_CODES["4007"]["unit"] = "99"

    TITLE_CODES["9302"] = {}
    TITLE_CODES["9302"]["title"] = "ANGIOGRAPHY TCHNO PD"
    TITLE_CODES["9302"]["program"] = "PSS"
    TITLE_CODES["9302"]["unit"] = "EX"

    TITLE_CODES["9053"] = {}
    TITLE_CODES["9053"]["title"] = "RESP THER 2 SUPV"
    TITLE_CODES["9053"]["program"] = "PSS"
    TITLE_CODES["9053"]["unit"] = "99"

    TITLE_CODES["9898"] = {}
    TITLE_CODES["9898"]["title"] = "ADMIN STIPEND NEX"
    TITLE_CODES["9898"]["program"] = "PSS"
    TITLE_CODES["9898"]["unit"] = "99"

    TITLE_CODES["8653"] = {}
    TITLE_CODES["8653"]["title"] = "LAB MECHN"
    TITLE_CODES["8653"]["program"] = "PSS"
    TITLE_CODES["8653"]["unit"] = "TX"

    TITLE_CODES["5098"] = {}
    TITLE_CODES["5098"]["title"] = "MED CTR BAKER"
    TITLE_CODES["5098"]["program"] = "PSS"
    TITLE_CODES["5098"]["unit"] = "SX"

    TITLE_CODES["0758"] = {}
    TITLE_CODES["0758"]["title"] = "ENGR CHF SR"
    TITLE_CODES["0758"]["program"] = "MSP"
    TITLE_CODES["0758"]["unit"] = "99"

    TITLE_CODES["9601"] = {}
    TITLE_CODES["9601"]["title"] = "LAB AST 4"
    TITLE_CODES["9601"]["program"] = "PSS"
    TITLE_CODES["9601"]["unit"] = "TX"

    TITLE_CODES["5099"] = {}
    TITLE_CODES["5099"]["title"] = "CUSTODIAN SR PD"
    TITLE_CODES["5099"]["program"] = "PSS"
    TITLE_CODES["5099"]["unit"] = "SX"

    TITLE_CODES["0209"] = {}
    TITLE_CODES["0209"]["title"] = "VICE CHAN ASC"
    TITLE_CODES["0209"]["program"] = "MSP"
    TITLE_CODES["0209"]["unit"] = "99"

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
    TITLE_CODES["7245"]["title"] = "ANL 1 SUPV"
    TITLE_CODES["7245"]["program"] = "PSS"
    TITLE_CODES["7245"]["unit"] = "99"

    TITLE_CODES["7509"] = {}
    TITLE_CODES["7509"]["title"] = "MGT SVC OFCR SUPV"
    TITLE_CODES["7509"]["program"] = "PSS"
    TITLE_CODES["7509"]["unit"] = "99"

    TITLE_CODES["3477"] = {}
    TITLE_CODES["3477"]["title"] = "ASSOC SPECIALIST COOP EXT"
    TITLE_CODES["3477"]["program"] = "ACADEMIC"
    TITLE_CODES["3477"]["unit"] = "FX"

    TITLE_CODES["9527"] = {}
    TITLE_CODES["9527"]["title"] = "ANIMAL TCHN SR SUPV"
    TITLE_CODES["9527"]["program"] = "PSS"
    TITLE_CODES["9527"]["unit"] = "99"

    TITLE_CODES["7181"] = {}
    TITLE_CODES["7181"]["title"] = "DEV ENGR SR"
    TITLE_CODES["7181"]["program"] = "PSS"
    TITLE_CODES["7181"]["unit"] = "99"

    TITLE_CODES["8888"] = {}
    TITLE_CODES["8888"]["title"] = "CARDIOVASCULAR TCHN PD"
    TITLE_CODES["8888"]["program"] = "PSS"
    TITLE_CODES["8888"]["unit"] = "EX"

    TITLE_CODES["7182"] = {}
    TITLE_CODES["7182"]["title"] = "DEV ENGR ASC"
    TITLE_CODES["7182"]["program"] = "PSS"
    TITLE_CODES["7182"]["unit"] = "99"

    TITLE_CODES["3300"] = {}
    TITLE_CODES["3300"]["title"] = "SPECIALIST"
    TITLE_CODES["3300"]["program"] = "ACADEMIC"
    TITLE_CODES["3300"]["unit"] = "FX"

    TITLE_CODES["8889"] = {}
    TITLE_CODES["8889"]["title"] = "CARDIOVASCULAR TCHN"
    TITLE_CODES["8889"]["program"] = "PSS"
    TITLE_CODES["8889"]["unit"] = "EX"

    TITLE_CODES["4714"] = {}
    TITLE_CODES["4714"]["title"] = "PATIENT RCDS ABSTRACTOR 4 PD"
    TITLE_CODES["4714"]["program"] = "PSS"
    TITLE_CODES["4714"]["unit"] = "EX"

    TITLE_CODES["4715"] = {}
    TITLE_CODES["4715"]["title"] = "PATIENT RCDS ABSTRACTOR 3 PD"
    TITLE_CODES["4715"]["program"] = "PSS"
    TITLE_CODES["4715"]["unit"] = "EX"

    TITLE_CODES["4716"] = {}
    TITLE_CODES["4716"]["title"] = "PATIENT RCDS ABSTRACTOR 4"
    TITLE_CODES["4716"]["program"] = "PSS"
    TITLE_CODES["4716"]["unit"] = "EX"

    TITLE_CODES["4717"] = {}
    TITLE_CODES["4717"]["title"] = "PATIENT RCDS ABSTRACTOR 3"
    TITLE_CODES["4717"]["program"] = "PSS"
    TITLE_CODES["4717"]["unit"] = "EX"

    TITLE_CODES["3071"] = {}
    TITLE_CODES["3071"]["title"] = "ASO---IN THE AES-ACAD YR-1/9TH"
    TITLE_CODES["3071"]["program"] = "ACADEMIC"
    TITLE_CODES["3071"]["unit"] = "FX"

    TITLE_CODES["8642"] = {}
    TITLE_CODES["8642"]["title"] = "MED CTR DEV TCHN 3"
    TITLE_CODES["8642"]["program"] = "PSS"
    TITLE_CODES["8642"]["unit"] = "EX"

    TITLE_CODES["4718"] = {}
    TITLE_CODES["4718"]["title"] = "PATIENT RCDS ABSTRACTOR 2"
    TITLE_CODES["4718"]["program"] = "PSS"
    TITLE_CODES["4718"]["unit"] = "EX"

    TITLE_CODES["4719"] = {}
    TITLE_CODES["4719"]["title"] = "PATIENT RCDS ABSTRACTOR 1"
    TITLE_CODES["4719"]["program"] = "PSS"
    TITLE_CODES["4719"]["unit"] = "EX"

    TITLE_CODES["7185"] = {}
    TITLE_CODES["7185"]["title"] = "DEV ENGR SUPV"
    TITLE_CODES["7185"]["program"] = "PSS"
    TITLE_CODES["7185"]["unit"] = "99"

    TITLE_CODES["7360"] = {}
    TITLE_CODES["7360"]["title"] = "HR ANL 7"
    TITLE_CODES["7360"]["program"] = "PSS"
    TITLE_CODES["7360"]["unit"] = "99"

    TITLE_CODES["9607"] = {}
    TITLE_CODES["9607"]["title"] = "MED LAB TCHN"
    TITLE_CODES["9607"]["program"] = "PSS"
    TITLE_CODES["9607"]["unit"] = "EX"

    TITLE_CODES["7640"] = {}
    TITLE_CODES["7640"]["title"] = "EMPLOYMENT OFCR SR"
    TITLE_CODES["7640"]["program"] = "PSS"
    TITLE_CODES["7640"]["unit"] = "99"

    TITLE_CODES["9520"] = {}
    TITLE_CODES["9520"]["title"] = "SPECTROSCOPIST"
    TITLE_CODES["9520"]["program"] = "PSS"
    TITLE_CODES["9520"]["unit"] = "RX"

    TITLE_CODES["7186"] = {}
    TITLE_CODES["7186"]["title"] = "DEV ENGR SR SUPV"
    TITLE_CODES["7186"]["program"] = "PSS"
    TITLE_CODES["7186"]["unit"] = "99"

    TITLE_CODES["7361"] = {}
    TITLE_CODES["7361"]["title"] = "HR ANL 8"
    TITLE_CODES["7361"]["program"] = "PSS"
    TITLE_CODES["7361"]["unit"] = "99"

    TITLE_CODES["7647"] = {}
    TITLE_CODES["7647"]["title"] = "HR ANL 2"
    TITLE_CODES["7647"]["program"] = "PSS"
    TITLE_CODES["7647"]["unit"] = "99"

    TITLE_CODES["7187"] = {}
    TITLE_CODES["7187"]["title"] = "DEV ENGR ASC SUPV"
    TITLE_CODES["7187"]["program"] = "PSS"
    TITLE_CODES["7187"]["unit"] = "99"

    TITLE_CODES["8886"] = {}
    TITLE_CODES["8886"]["title"] = "CLIN SPEC SUPV NEX"
    TITLE_CODES["8886"]["program"] = "PSS"
    TITLE_CODES["8886"]["unit"] = "99"

    TITLE_CODES["7646"] = {}
    TITLE_CODES["7646"]["title"] = "ADMIN SPEC"
    TITLE_CODES["7646"]["program"] = "PSS"
    TITLE_CODES["7646"]["unit"] = "99"

    TITLE_CODES["7363"] = {}
    TITLE_CODES["7363"]["title"] = "ANL 9"
    TITLE_CODES["7363"]["program"] = "PSS"
    TITLE_CODES["7363"]["unit"] = "99"

    TITLE_CODES["3710"] = {}
    TITLE_CODES["3710"]["title"] = "ASSOC FACULTY CONSULTANT IN---"
    TITLE_CODES["3710"]["program"] = "ACADEMIC"
    TITLE_CODES["3710"]["unit"] = "99"

    TITLE_CODES["9472"] = {}
    TITLE_CODES["9472"]["title"] = "SPEECH PATHOLOGIST SR"
    TITLE_CODES["9472"]["program"] = "PSS"
    TITLE_CODES["9472"]["unit"] = "HX"

    TITLE_CODES["7364"] = {}
    TITLE_CODES["7364"]["title"] = "ANL 10"
    TITLE_CODES["7364"]["program"] = "PSS"
    TITLE_CODES["7364"]["unit"] = "99"

    TITLE_CODES["3077"] = {}
    TITLE_CODES["3077"]["title"] = "ACT ASO--IN AES-B/EC/EN-AY-1/9"
    TITLE_CODES["3077"]["program"] = "ACADEMIC"
    TITLE_CODES["3077"]["unit"] = "99"

    TITLE_CODES["9474"] = {}
    TITLE_CODES["9474"]["title"] = "AUDIOLOGIST SR"
    TITLE_CODES["9474"]["program"] = "PSS"
    TITLE_CODES["9474"]["unit"] = "HX"

    TITLE_CODES["3570"] = {}
    TITLE_CODES["3570"]["title"] = "TEACHER-UNEX-CONTRACT YR"
    TITLE_CODES["3570"]["program"] = "ACADEMIC"
    TITLE_CODES["3570"]["unit"] = "99"

    TITLE_CODES["9457"] = {}
    TITLE_CODES["9457"]["title"] = "ATH TRAINER SUPV"
    TITLE_CODES["9457"]["program"] = "PSS"
    TITLE_CODES["9457"]["unit"] = "99"

    TITLE_CODES["7645"] = {}
    TITLE_CODES["7645"]["title"] = "EMPLOYMENT REPR AST"
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
    TITLE_CODES["7248"]["title"] = "ANL 4 SUPV"
    TITLE_CODES["7248"]["program"] = "PSS"
    TITLE_CODES["7248"]["unit"] = "99"

    TITLE_CODES["3650"] = {}
    TITLE_CODES["3650"]["title"] = "CURATOR"
    TITLE_CODES["3650"]["program"] = "ACADEMIC"
    TITLE_CODES["3650"]["unit"] = "FX"

    TITLE_CODES["3651"] = {}
    TITLE_CODES["3651"]["title"] = "ASSOC CURATOR"
    TITLE_CODES["3651"]["program"] = "ACADEMIC"
    TITLE_CODES["3651"]["unit"] = "FX"

    TITLE_CODES["3652"] = {}
    TITLE_CODES["3652"]["title"] = "ASST CURATOR"
    TITLE_CODES["3652"]["program"] = "ACADEMIC"
    TITLE_CODES["3652"]["unit"] = "FX"

    TITLE_CODES["2521"] = {}
    TITLE_CODES["2521"]["title"] = "TUT-NON STDNT/NON REP"
    TITLE_CODES["2521"]["program"] = "ACADEMIC"
    TITLE_CODES["2521"]["unit"] = "99"

    TITLE_CODES["2520"] = {}
    TITLE_CODES["2520"]["title"] = "READER-NON STDNT/NON REP"
    TITLE_CODES["2520"]["program"] = "ACADEMIC"
    TITLE_CODES["2520"]["unit"] = "99"

    TITLE_CODES["4678"] = {}
    TITLE_CODES["4678"]["title"] = "HOSP BILLER"
    TITLE_CODES["4678"]["program"] = "PSS"
    TITLE_CODES["4678"]["unit"] = "EX"

    TITLE_CODES["4677"] = {}
    TITLE_CODES["4677"]["title"] = "HOSP BILLER SR"
    TITLE_CODES["4677"]["program"] = "PSS"
    TITLE_CODES["4677"]["unit"] = "EX"

    TITLE_CODES["9026"] = {}
    TITLE_CODES["9026"]["title"] = "RADLG TCHNO PRN PD"
    TITLE_CODES["9026"]["program"] = "PSS"
    TITLE_CODES["9026"]["unit"] = "EX"

    TITLE_CODES["4674"] = {}
    TITLE_CODES["4674"]["title"] = "CLERK PD"
    TITLE_CODES["4674"]["program"] = "PSS"
    TITLE_CODES["4674"]["unit"] = "CX"

    TITLE_CODES["4673"] = {}
    TITLE_CODES["4673"]["title"] = "CLERK"
    TITLE_CODES["4673"]["program"] = "PSS"
    TITLE_CODES["4673"]["unit"] = "CX"

    TITLE_CODES["4672"] = {}
    TITLE_CODES["4672"]["title"] = "CLERK SR OR SECR"
    TITLE_CODES["4672"]["program"] = "PSS"
    TITLE_CODES["4672"]["unit"] = "CX"

    TITLE_CODES["4671"] = {}
    TITLE_CODES["4671"]["title"] = "CLERK SR SECR PD"
    TITLE_CODES["4671"]["program"] = "PSS"
    TITLE_CODES["4671"]["unit"] = "CX"

    TITLE_CODES["9344"] = {}
    TITLE_CODES["9344"]["title"] = "CHILD DEV SUPV"
    TITLE_CODES["9344"]["program"] = "PSS"
    TITLE_CODES["9344"]["unit"] = "99"

    TITLE_CODES["9366"] = {}
    TITLE_CODES["9366"]["title"] = "FIELD WORK AST"
    TITLE_CODES["9366"]["program"] = "PSS"
    TITLE_CODES["9366"]["unit"] = "99"

    TITLE_CODES["7644"] = {}
    TITLE_CODES["7644"]["title"] = "EMPLOYMENT REPR"
    TITLE_CODES["7644"]["program"] = "PSS"
    TITLE_CODES["7644"]["unit"] = "99"

    TITLE_CODES["9117"] = {}
    TITLE_CODES["9117"]["title"] = "HOME HEALTH NURSE 2"
    TITLE_CODES["9117"]["program"] = "PSS"
    TITLE_CODES["9117"]["unit"] = "NX"

    TITLE_CODES["8188"] = {}
    TITLE_CODES["8188"]["title"] = "ELEVATOR MECH"
    TITLE_CODES["8188"]["program"] = "PSS"
    TITLE_CODES["8188"]["unit"] = "K3"

    TITLE_CODES["2245"] = {}
    TITLE_CODES["2245"]["title"] = "COORD FLD WK-FY"
    TITLE_CODES["2245"]["program"] = "ACADEMIC"
    TITLE_CODES["2245"]["unit"] = "IX"

    TITLE_CODES["2246"] = {}
    TITLE_CODES["2246"]["title"] = "COORD FLD WK-FY-CONTINUING"
    TITLE_CODES["2246"]["program"] = "ACADEMIC"
    TITLE_CODES["2246"]["unit"] = "IX"

    TITLE_CODES["2240"] = {}
    TITLE_CODES["2240"]["title"] = "COORD FLD WK-AY"
    TITLE_CODES["2240"]["program"] = "ACADEMIC"
    TITLE_CODES["2240"]["unit"] = "IX"

    TITLE_CODES["2241"] = {}
    TITLE_CODES["2241"]["title"] = "COORD FLD WK-AY-CONTINUING"
    TITLE_CODES["2241"]["program"] = "ACADEMIC"
    TITLE_CODES["2241"]["unit"] = "IX"

    TITLE_CODES["8144"] = {}
    TITLE_CODES["8144"]["title"] = "GROUNDSKEEPER PD"
    TITLE_CODES["8144"]["program"] = "PSS"
    TITLE_CODES["8144"]["unit"] = "SX"

    TITLE_CODES["5065"] = {}
    TITLE_CODES["5065"]["title"] = "STOREKEEPER AST"
    TITLE_CODES["5065"]["program"] = "PSS"
    TITLE_CODES["5065"]["unit"] = "SX"

    TITLE_CODES["5064"] = {}
    TITLE_CODES["5064"]["title"] = "STOREKEEPER"
    TITLE_CODES["5064"]["program"] = "PSS"
    TITLE_CODES["5064"]["unit"] = "SX"

    TITLE_CODES["9170"] = {}
    TITLE_CODES["9170"]["title"] = "CASE MGR"
    TITLE_CODES["9170"]["program"] = "PSS"
    TITLE_CODES["9170"]["unit"] = "HX"

    TITLE_CODES["5066"] = {}
    TITLE_CODES["5066"]["title"] = "DELIVERY WORKER"
    TITLE_CODES["5066"]["program"] = "PSS"
    TITLE_CODES["5066"]["unit"] = "SX"

    TITLE_CODES["2460"] = {}
    TITLE_CODES["2460"]["title"] = "TEACHER-SPEC PROG"
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
    TITLE_CODES["5062"]["title"] = "STOREKEEPER SR"
    TITLE_CODES["5062"]["program"] = "PSS"
    TITLE_CODES["5062"]["unit"] = "SX"

    TITLE_CODES["9278"] = {}
    TITLE_CODES["9278"]["title"] = "PHARMACY TCHN 2 PD"
    TITLE_CODES["9278"]["program"] = "PSS"
    TITLE_CODES["9278"]["unit"] = "EX"

    TITLE_CODES["2704"] = {}
    TITLE_CODES["2704"]["title"] = "INTERN-DIETETIC/NON REP"
    TITLE_CODES["2704"]["program"] = "ACADEMIC"
    TITLE_CODES["2704"]["unit"] = "99"

    TITLE_CODES["5069"] = {}
    TITLE_CODES["5069"]["title"] = "STOREKEEPER SUPV"
    TITLE_CODES["5069"]["program"] = "PSS"
    TITLE_CODES["5069"]["unit"] = "99"

    TITLE_CODES["2700"] = {}
    TITLE_CODES["2700"]["title"] = "INTERN-HOSPITAL/NON-REP"
    TITLE_CODES["2700"]["program"] = "ACADEMIC"
    TITLE_CODES["2700"]["unit"] = "99"

    TITLE_CODES["0120"] = {}
    TITLE_CODES["0120"]["title"] = "EXEC SUPT FUNC AREA"
    TITLE_CODES["0120"]["program"] = "MSP"
    TITLE_CODES["0120"]["unit"] = "99"

    TITLE_CODES["0121"] = {}
    TITLE_CODES["0121"]["title"] = "EXEC CHF OF POLICE"
    TITLE_CODES["0121"]["program"] = "MSP"
    TITLE_CODES["0121"]["unit"] = "99"

    TITLE_CODES["0122"] = {}
    TITLE_CODES["0122"]["title"] = "EXEC VICE PROVOST FUNC AREA"
    TITLE_CODES["0122"]["program"] = "MSP"
    TITLE_CODES["0122"]["unit"] = "99"

    TITLE_CODES["0123"] = {}
    TITLE_CODES["0123"]["title"] = "ASC VICE PROVOST FUNC AREA"
    TITLE_CODES["0123"]["program"] = "MSP"
    TITLE_CODES["0123"]["unit"] = "99"

    TITLE_CODES["0125"] = {}
    TITLE_CODES["0125"]["title"] = "AST TO PRESIDENT FUNC AREA"
    TITLE_CODES["0125"]["program"] = "MSP"
    TITLE_CODES["0125"]["unit"] = "99"

    TITLE_CODES["9179"] = {}
    TITLE_CODES["9179"]["title"] = "RADLG AST 1"
    TITLE_CODES["9179"]["program"] = "PSS"
    TITLE_CODES["9179"]["unit"] = "EX"

    TITLE_CODES["8962"] = {}
    TITLE_CODES["8962"]["title"] = "ELECTROCARDIOGRAPH TCHN SR"
    TITLE_CODES["8962"]["program"] = "PSS"
    TITLE_CODES["8962"]["unit"] = "EX"

    TITLE_CODES["9015"] = {}
    TITLE_CODES["9015"]["title"] = "RAD THER TCHNO PD"
    TITLE_CODES["9015"]["program"] = "PSS"
    TITLE_CODES["9015"]["unit"] = "EX"

    TITLE_CODES["9176"] = {}
    TITLE_CODES["9176"]["title"] = "PULMONARY TCHN PD"
    TITLE_CODES["9176"]["program"] = "PSS"
    TITLE_CODES["9176"]["unit"] = "EX"

    TITLE_CODES["9175"] = {}
    TITLE_CODES["9175"]["title"] = "PULMONARY TCHN 3"
    TITLE_CODES["9175"]["program"] = "PSS"
    TITLE_CODES["9175"]["unit"] = "EX"

    TITLE_CODES["7249"] = {}
    TITLE_CODES["7249"]["title"] = "ANL 5 SUPV"
    TITLE_CODES["7249"]["program"] = "PSS"
    TITLE_CODES["7249"]["unit"] = "99"

    TITLE_CODES["9173"] = {}
    TITLE_CODES["9173"]["title"] = "PULMONARY TCHN 1"
    TITLE_CODES["9173"]["program"] = "PSS"
    TITLE_CODES["9173"]["unit"] = "EX"

    TITLE_CODES["9172"] = {}
    TITLE_CODES["9172"]["title"] = "HOME HEALTH AIDE PD"
    TITLE_CODES["9172"]["program"] = "PSS"
    TITLE_CODES["9172"]["unit"] = "EX"

    TITLE_CODES["9171"] = {}
    TITLE_CODES["9171"]["title"] = "HOME HEALTH AIDE"
    TITLE_CODES["9171"]["program"] = "PSS"
    TITLE_CODES["9171"]["unit"] = "EX"

    TITLE_CODES["5428"] = {}
    TITLE_CODES["5428"]["title"] = "DIETITIAN 1"
    TITLE_CODES["5428"]["program"] = "PSS"
    TITLE_CODES["5428"]["unit"] = "HX"

    TITLE_CODES["7287"] = {}
    TITLE_CODES["7287"]["title"] = "PROGR 5"
    TITLE_CODES["7287"]["program"] = "PSS"
    TITLE_CODES["7287"]["unit"] = "99"

    TITLE_CODES["9039"] = {}
    TITLE_CODES["9039"]["title"] = "PERFUSIONIST SR PD"
    TITLE_CODES["9039"]["program"] = "PSS"
    TITLE_CODES["9039"]["unit"] = "EX"

    TITLE_CODES["3379"] = {}
    TITLE_CODES["3379"]["title"] = "ADJ PROF-AY-1/9-B/E/E"
    TITLE_CODES["3379"]["program"] = "ACADEMIC"
    TITLE_CODES["3379"]["unit"] = "99"

    TITLE_CODES["4404"] = {}
    TITLE_CODES["4404"]["title"] = "COUNSELING PSYCHOLOGIST 1 EX"
    TITLE_CODES["4404"]["program"] = "PSS"
    TITLE_CODES["4404"]["unit"] = "99"

    TITLE_CODES["8987"] = {}
    TITLE_CODES["8987"]["title"] = "CYTOGENETIC TCHNO 2"
    TITLE_CODES["8987"]["program"] = "PSS"
    TITLE_CODES["8987"]["unit"] = "EX"

    TITLE_CODES["4403"] = {}
    TITLE_CODES["4403"]["title"] = "COUNSELING PSYCHOLOGIST 2"
    TITLE_CODES["4403"]["program"] = "PSS"
    TITLE_CODES["4403"]["unit"] = "99"

    TITLE_CODES["6312"] = {}
    TITLE_CODES["6312"]["title"] = "PUBL EVENTS MGR SR"
    TITLE_CODES["6312"]["program"] = "PSS"
    TITLE_CODES["6312"]["unit"] = "99"

    TITLE_CODES["5425"] = {}
    TITLE_CODES["5425"]["title"] = "DIETITIAN SR SUPV"
    TITLE_CODES["5425"]["program"] = "PSS"
    TITLE_CODES["5425"]["unit"] = "99"

    TITLE_CODES["6310"] = {}
    TITLE_CODES["6310"]["title"] = "PUBL EVENTS MGR SUPV EX"
    TITLE_CODES["6310"]["program"] = "PSS"
    TITLE_CODES["6310"]["unit"] = "99"

    TITLE_CODES["5079"] = {}
    TITLE_CODES["5079"]["title"] = "MED CTR STOREKEEPER"
    TITLE_CODES["5079"]["program"] = "PSS"
    TITLE_CODES["5079"]["unit"] = "SX"

    TITLE_CODES["6317"] = {}
    TITLE_CODES["6317"]["title"] = "WARDROBE TCHN SR"
    TITLE_CODES["6317"]["program"] = "PSS"
    TITLE_CODES["6317"]["unit"] = "TX"

    TITLE_CODES["6314"] = {}
    TITLE_CODES["6314"]["title"] = "PUBL EVENTS MGR AST"
    TITLE_CODES["6314"]["program"] = "PSS"
    TITLE_CODES["6314"]["unit"] = "TX"

    TITLE_CODES["2140"] = {}
    TITLE_CODES["2140"]["title"] = "ASST SUPRVSR OF PHYS ED - AY"
    TITLE_CODES["2140"]["program"] = "ACADEMIC"
    TITLE_CODES["2140"]["unit"] = "99"

    TITLE_CODES["0920"] = {}
    TITLE_CODES["0920"]["title"] = "ASST DIRECTOR"
    TITLE_CODES["0920"]["program"] = "ACADEMIC"
    TITLE_CODES["0920"]["unit"] = "99"

    TITLE_CODES["2061"] = {}
    TITLE_CODES["2061"]["title"] = "CLIN INSTRUCTOR-DENT-50%/+ AY"
    TITLE_CODES["2061"]["program"] = "ACADEMIC"
    TITLE_CODES["2061"]["unit"] = "99"

    TITLE_CODES["6318"] = {}
    TITLE_CODES["6318"]["title"] = "WARDROBE TCHN"
    TITLE_CODES["6318"]["program"] = "PSS"
    TITLE_CODES["6318"]["unit"] = "TX"

    TITLE_CODES["6319"] = {}
    TITLE_CODES["6319"]["title"] = "WARDROBE TCHN SR SUPV"
    TITLE_CODES["6319"]["program"] = "PSS"
    TITLE_CODES["6319"]["unit"] = "99"

    TITLE_CODES["5427"] = {}
    TITLE_CODES["5427"]["title"] = "DIETITIAN 2 SUPV"
    TITLE_CODES["5427"]["program"] = "PSS"
    TITLE_CODES["5427"]["unit"] = "99"

    TITLE_CODES["0927"] = {}
    TITLE_CODES["0927"]["title"] = "ACT/INTERIM ASST DIRECTOR"
    TITLE_CODES["0927"]["program"] = "ACADEMIC"
    TITLE_CODES["0927"]["unit"] = "99"

    TITLE_CODES["5426"] = {}
    TITLE_CODES["5426"]["title"] = "DIETITIAN 2"
    TITLE_CODES["5426"]["program"] = "PSS"
    TITLE_CODES["5426"]["unit"] = "99"

    TITLE_CODES["9098"] = {}
    TITLE_CODES["9098"]["title"] = "ACCESS REPR SR"
    TITLE_CODES["9098"]["program"] = "PSS"
    TITLE_CODES["9098"]["unit"] = "EX"

    TITLE_CODES["8983"] = {}
    TITLE_CODES["8983"]["title"] = "ORTHOPTIST"
    TITLE_CODES["8983"]["program"] = "PSS"
    TITLE_CODES["8983"]["unit"] = "HX"

    TITLE_CODES["9094"] = {}
    TITLE_CODES["9094"]["title"] = "ACCESS REPR PD"
    TITLE_CODES["9094"]["program"] = "PSS"
    TITLE_CODES["9094"]["unit"] = "EX"

    TITLE_CODES["3373"] = {}
    TITLE_CODES["3373"]["title"] = "ASST ADJ PROF-AY-1/9-B/E/E"
    TITLE_CODES["3373"]["program"] = "ACADEMIC"
    TITLE_CODES["3373"]["unit"] = "99"

    TITLE_CODES["9096"] = {}
    TITLE_CODES["9096"]["title"] = "ACCESS REPR PRN PD"
    TITLE_CODES["9096"]["program"] = "PSS"
    TITLE_CODES["9096"]["unit"] = "EX"

    TITLE_CODES["9097"] = {}
    TITLE_CODES["9097"]["title"] = "ACCESS REPR"
    TITLE_CODES["9097"]["program"] = "PSS"
    TITLE_CODES["9097"]["unit"] = "EX"

    TITLE_CODES["9090"] = {}
    TITLE_CODES["9090"]["title"] = "POLYSOMNOGRAPHY TCHNO PRN"
    TITLE_CODES["9090"]["program"] = "PSS"
    TITLE_CODES["9090"]["unit"] = "EX"

    TITLE_CODES["9091"] = {}
    TITLE_CODES["9091"]["title"] = "POLYSOMNOGRAPHY TCHNO SR"
    TITLE_CODES["9091"]["program"] = "PSS"
    TITLE_CODES["9091"]["unit"] = "EX"

    TITLE_CODES["9092"] = {}
    TITLE_CODES["9092"]["title"] = "POLYSOMNOGRAPHY TCHNO"
    TITLE_CODES["9092"]["program"] = "PSS"
    TITLE_CODES["9092"]["unit"] = "EX"

    TITLE_CODES["3372"] = {}
    TITLE_CODES["3372"]["title"] = "ASST ADJ PROF-FY-B/E/E"
    TITLE_CODES["3372"]["program"] = "ACADEMIC"
    TITLE_CODES["3372"]["unit"] = "99"

    TITLE_CODES["3276"] = {}
    TITLE_CODES["3276"]["title"] = "GSR-PARTIAL FEE REM"
    TITLE_CODES["3276"]["program"] = "ACADEMIC"
    TITLE_CODES["3276"]["unit"] = "99"

    TITLE_CODES["9164"] = {}
    TITLE_CODES["9164"]["title"] = "CTRL STERILE TCHN SUPV"
    TITLE_CODES["9164"]["program"] = "PSS"
    TITLE_CODES["9164"]["unit"] = "99"

    TITLE_CODES["3274"] = {}
    TITLE_CODES["3274"]["title"] = "GSAR-GSHIP"
    TITLE_CODES["3274"]["program"] = "ACADEMIC"
    TITLE_CODES["3274"]["unit"] = "99"

    TITLE_CODES["8993"] = {}
    TITLE_CODES["8993"]["title"] = "MED AST 1"
    TITLE_CODES["8993"]["program"] = "PSS"
    TITLE_CODES["8993"]["unit"] = "EX"

    TITLE_CODES["9017"] = {}
    TITLE_CODES["9017"]["title"] = "RADLG TCHNO PRN SUPV"
    TITLE_CODES["9017"]["program"] = "PSS"
    TITLE_CODES["9017"]["unit"] = "99"

    TITLE_CODES["3273"] = {}
    TITLE_CODES["3273"]["title"] = "GSAR-NON GSHIP"
    TITLE_CODES["3273"]["program"] = "ACADEMIC"
    TITLE_CODES["3273"]["unit"] = "99"

    TITLE_CODES["3270"] = {}
    TITLE_CODES["3270"]["title"] = "ASST PROF IN RES-AY"
    TITLE_CODES["3270"]["program"] = "ACADEMIC"
    TITLE_CODES["3270"]["unit"] = "A3"

    TITLE_CODES["3271"] = {}
    TITLE_CODES["3271"]["title"] = "ASST PROF IN RES-FY"
    TITLE_CODES["3271"]["program"] = "ACADEMIC"
    TITLE_CODES["3271"]["unit"] = "A3"

    TITLE_CODES["9304"] = {}
    TITLE_CODES["9304"]["title"] = "CLIN LIC SOCIAL WORKER CHF ASC"
    TITLE_CODES["9304"]["program"] = "PSS"
    TITLE_CODES["9304"]["unit"] = "99"

    TITLE_CODES["9305"] = {}
    TITLE_CODES["9305"]["title"] = "CLIN LIC SOCIAL WORKER SUPV"
    TITLE_CODES["9305"]["program"] = "PSS"
    TITLE_CODES["9305"]["unit"] = "99"

    TITLE_CODES["9306"] = {}
    TITLE_CODES["9306"]["title"] = "CLIN LIC SOCIAL WORKER"
    TITLE_CODES["9306"]["program"] = "PSS"
    TITLE_CODES["9306"]["unit"] = "HX"

    TITLE_CODES["1181"] = {}
    TITLE_CODES["1181"]["title"] = "PROF-AY-1/9-LAW"
    TITLE_CODES["1181"]["program"] = "ACADEMIC"
    TITLE_CODES["1181"]["unit"] = "A3"

    TITLE_CODES["9300"] = {}
    TITLE_CODES["9300"]["title"] = "ANGIOGRAPHY TCHNO LD"
    TITLE_CODES["9300"]["program"] = "PSS"
    TITLE_CODES["9300"]["unit"] = "EX"

    TITLE_CODES["5070"] = {}
    TITLE_CODES["5070"]["title"] = "STORES SUPV SR"
    TITLE_CODES["5070"]["program"] = "PSS"
    TITLE_CODES["5070"]["unit"] = "99"

    TITLE_CODES["3278"] = {}
    TITLE_CODES["3278"]["title"] = "ASST ADJ PROF-AY"
    TITLE_CODES["3278"]["program"] = "ACADEMIC"
    TITLE_CODES["3278"]["unit"] = "99"

    TITLE_CODES["3279"] = {}
    TITLE_CODES["3279"]["title"] = "ASST ADJ PROF-FY"
    TITLE_CODES["3279"]["program"] = "ACADEMIC"
    TITLE_CODES["3279"]["unit"] = "99"

    TITLE_CODES["0832"] = {}
    TITLE_CODES["0832"]["title"] = "ASSISTANT HEAD OF ____"
    TITLE_CODES["0832"]["program"] = "ACADEMIC"
    TITLE_CODES["0832"]["unit"] = "99"

    TITLE_CODES["3475"] = {}
    TITLE_CODES["3475"]["title"] = "ASST SPECIALIST COOP EXT"
    TITLE_CODES["3475"]["program"] = "ACADEMIC"
    TITLE_CODES["3475"]["unit"] = "FX"

    TITLE_CODES["0830"] = {}
    TITLE_CODES["0830"]["title"] = "HEAD OF ____"
    TITLE_CODES["0830"]["program"] = "ACADEMIC"
    TITLE_CODES["0830"]["unit"] = "99"

    TITLE_CODES["0831"] = {}
    TITLE_CODES["0831"]["title"] = "ASSOCIATE HEAD OF ____"
    TITLE_CODES["0831"]["program"] = "ACADEMIC"
    TITLE_CODES["0831"]["unit"] = "99"

    TITLE_CODES["7243"] = {}
    TITLE_CODES["7243"]["title"] = "ADMIN ANL"
    TITLE_CODES["7243"]["program"] = "PSS"
    TITLE_CODES["7243"]["unit"] = "99"

    TITLE_CODES["7242"] = {}
    TITLE_CODES["7242"]["title"] = "ADMIN ANL SR"
    TITLE_CODES["7242"]["program"] = "PSS"
    TITLE_CODES["7242"]["unit"] = "99"

    TITLE_CODES["7241"] = {}
    TITLE_CODES["7241"]["title"] = "ADMIN ANL PRN 1"
    TITLE_CODES["7241"]["program"] = "PSS"
    TITLE_CODES["7241"]["unit"] = "99"

    TITLE_CODES["7240"] = {}
    TITLE_CODES["7240"]["title"] = "ADMIN ANL SUPV EX"
    TITLE_CODES["7240"]["program"] = "PSS"
    TITLE_CODES["7240"]["unit"] = "99"

    TITLE_CODES["3575"] = {}
    TITLE_CODES["3575"]["title"] = "SPEAKER-UNEX"
    TITLE_CODES["3575"]["program"] = "ACADEMIC"
    TITLE_CODES["3575"]["unit"] = "99"

    TITLE_CODES["3574"] = {}
    TITLE_CODES["3574"]["title"] = "TEACHER-UNEX"
    TITLE_CODES["3574"]["program"] = "ACADEMIC"
    TITLE_CODES["3574"]["unit"] = "99"

    TITLE_CODES["7362"] = {}
    TITLE_CODES["7362"]["title"] = "HR ANL 8 SUPV"
    TITLE_CODES["7362"]["program"] = "PSS"
    TITLE_CODES["7362"]["unit"] = "99"

    TITLE_CODES["5093"] = {}
    TITLE_CODES["5093"]["title"] = "MED CTR FOOD SVC WORKER LD"
    TITLE_CODES["5093"]["program"] = "PSS"
    TITLE_CODES["5093"]["unit"] = "SX"

    TITLE_CODES["5094"] = {}
    TITLE_CODES["5094"]["title"] = "MED CTR FOOD SVC WORKER PD"
    TITLE_CODES["5094"]["program"] = "PSS"
    TITLE_CODES["5094"]["unit"] = "SX"

    TITLE_CODES["3479"] = {}
    TITLE_CODES["3479"]["title"] = "SPECIALIST COOP EXT"
    TITLE_CODES["3479"]["program"] = "ACADEMIC"
    TITLE_CODES["3479"]["unit"] = "FX"

    TITLE_CODES["5096"] = {}
    TITLE_CODES["5096"]["title"] = "MED CTR FOOD SVC WORKER PRN PD"
    TITLE_CODES["5096"]["program"] = "PSS"
    TITLE_CODES["5096"]["unit"] = "SX"

    TITLE_CODES["3572"] = {}
    TITLE_CODES["3572"]["title"] = "ASST TEACHER-UNEX"
    TITLE_CODES["3572"]["program"] = "ACADEMIC"
    TITLE_CODES["3572"]["unit"] = "99"

    TITLE_CODES["8969"] = {}
    TITLE_CODES["8969"]["title"] = "ULTRASOUND TCHNO PRN SUPV"
    TITLE_CODES["8969"]["program"] = "PSS"
    TITLE_CODES["8969"]["unit"] = "99"

    TITLE_CODES["8968"] = {}
    TITLE_CODES["8968"]["title"] = "ULTRASOUND TCHNO SR PD"
    TITLE_CODES["8968"]["program"] = "PSS"
    TITLE_CODES["8968"]["unit"] = "EX"

    TITLE_CODES["8543"] = {}
    TITLE_CODES["8543"]["title"] = "FARM LABORER"
    TITLE_CODES["8543"]["program"] = "PSS"
    TITLE_CODES["8543"]["unit"] = "SX"

    TITLE_CODES["8963"] = {}
    TITLE_CODES["8963"]["title"] = "ELECTROCARDIOGRAPH TCHN"
    TITLE_CODES["8963"]["program"] = "PSS"
    TITLE_CODES["8963"]["unit"] = "EX"

    TITLE_CODES["8540"] = {}
    TITLE_CODES["8540"]["title"] = "AGRICULTURAL TCHN PRN"
    TITLE_CODES["8540"]["program"] = "PSS"
    TITLE_CODES["8540"]["unit"] = "SX"

    TITLE_CODES["8961"] = {}
    TITLE_CODES["8961"]["title"] = "ELECTROCARDIOGRAPH TCHN PRN"
    TITLE_CODES["8961"]["program"] = "PSS"
    TITLE_CODES["8961"]["unit"] = "99"

    TITLE_CODES["8960"] = {}
    TITLE_CODES["8960"]["title"] = "ELECTROCARDIOGRAPH TCHN PD"
    TITLE_CODES["8960"]["program"] = "PSS"
    TITLE_CODES["8960"]["unit"] = "EX"

    TITLE_CODES["8967"] = {}
    TITLE_CODES["8967"]["title"] = "ULTRASOUND TCHNO"
    TITLE_CODES["8967"]["program"] = "PSS"
    TITLE_CODES["8967"]["unit"] = "EX"

    TITLE_CODES["8951"] = {}
    TITLE_CODES["8951"]["title"] = "PHYS THER AST PD"
    TITLE_CODES["8951"]["program"] = "PSS"
    TITLE_CODES["8951"]["unit"] = "EX"

    TITLE_CODES["8965"] = {}
    TITLE_CODES["8965"]["title"] = "ULTRASOUND TCHNO PRN"
    TITLE_CODES["8965"]["program"] = "PSS"
    TITLE_CODES["8965"]["unit"] = "EX"

    TITLE_CODES["1749"] = {}
    TITLE_CODES["1749"]["title"] = "ASOC ADJUNCT PROF-GENCOMP-B"
    TITLE_CODES["1749"]["program"] = "ACADEMIC"
    TITLE_CODES["1749"]["unit"] = "99"

    TITLE_CODES["6307"] = {}
    TITLE_CODES["6307"]["title"] = "PUBL EVENTS MGR SR SUPV"
    TITLE_CODES["6307"]["program"] = "PSS"
    TITLE_CODES["6307"]["unit"] = "99"

    TITLE_CODES["5326"] = {}
    TITLE_CODES["5326"]["title"] = "SECURITY GUARD SR"
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
    TITLE_CODES["5325"]["title"] = "SECURITY GUARD SR SUPV"
    TITLE_CODES["5325"]["program"] = "PSS"
    TITLE_CODES["5325"]["unit"] = "99"

    TITLE_CODES["9003"] = {}
    TITLE_CODES["9003"]["title"] = "NUC MED TCHNO SR"
    TITLE_CODES["9003"]["program"] = "PSS"
    TITLE_CODES["9003"]["unit"] = "HX"

    TITLE_CODES["5323"] = {}
    TITLE_CODES["5323"]["title"] = "POLICE OFCR"
    TITLE_CODES["5323"]["program"] = "PSS"
    TITLE_CODES["5323"]["unit"] = "PA"

    TITLE_CODES["9001"] = {}
    TITLE_CODES["9001"]["title"] = "NUC MED TCHNO CHF"
    TITLE_CODES["9001"]["program"] = "PSS"
    TITLE_CODES["9001"]["unit"] = "99"

    TITLE_CODES["3310"] = {}
    TITLE_CODES["3310"]["title"] = "ASSOC SPECIALIST"
    TITLE_CODES["3310"]["program"] = "ACADEMIC"
    TITLE_CODES["3310"]["unit"] = "FX"

    TITLE_CODES["1987"] = {}
    TITLE_CODES["1987"]["title"] = "RES-FY-B/E/E"
    TITLE_CODES["1987"]["program"] = "ACADEMIC"
    TITLE_CODES["1987"]["unit"] = "FX"

    TITLE_CODES["9008"] = {}
    TITLE_CODES["9008"]["title"] = "DOSIMETRIST"
    TITLE_CODES["9008"]["program"] = "PSS"
    TITLE_CODES["9008"]["unit"] = "EX"

    TITLE_CODES["0784"] = {}
    TITLE_CODES["0784"]["title"] = "PHARMACIST SPEC"
    TITLE_CODES["0784"]["program"] = "MSP"
    TITLE_CODES["0784"]["unit"] = "99"

    TITLE_CODES["0785"] = {}
    TITLE_CODES["0785"]["title"] = "FIRE CHF AST"
    TITLE_CODES["0785"]["program"] = "MSP"
    TITLE_CODES["0785"]["unit"] = "99"

    TITLE_CODES["0786"] = {}
    TITLE_CODES["0786"]["title"] = "INTERCOL ATH HEAD COACH EX"
    TITLE_CODES["0786"]["program"] = "MSP"
    TITLE_CODES["0786"]["unit"] = "99"

    TITLE_CODES["0787"] = {}
    TITLE_CODES["0787"]["title"] = "COACH SPEC"
    TITLE_CODES["0787"]["program"] = "MSP"
    TITLE_CODES["0787"]["unit"] = "99"

    TITLE_CODES["0780"] = {}
    TITLE_CODES["0780"]["title"] = "HOSP RAD PHYSICIST SUPV"
    TITLE_CODES["0780"]["program"] = "MSP"
    TITLE_CODES["0780"]["unit"] = "99"

    TITLE_CODES["0781"] = {}
    TITLE_CODES["0781"]["title"] = "PHARMACEUTICAL SVC CHF"
    TITLE_CODES["0781"]["program"] = "MSP"
    TITLE_CODES["0781"]["unit"] = "99"

    TITLE_CODES["0782"] = {}
    TITLE_CODES["0782"]["title"] = "PHARMACEUTICAL SVC CHF ASC"
    TITLE_CODES["0782"]["program"] = "MSP"
    TITLE_CODES["0782"]["unit"] = "99"

    TITLE_CODES["0783"] = {}
    TITLE_CODES["0783"]["title"] = "PHARMACEUTICAL SVC CHF AST"
    TITLE_CODES["0783"]["program"] = "MSP"
    TITLE_CODES["0783"]["unit"] = "99"

    TITLE_CODES["1726"] = {}
    TITLE_CODES["1726"]["title"] = "PROF IN RES-HCOMP"
    TITLE_CODES["1726"]["program"] = "ACADEMIC"
    TITLE_CODES["1726"]["unit"] = "A3"

    TITLE_CODES["1727"] = {}
    TITLE_CODES["1727"]["title"] = "ADJ INSTR-HCOMP"
    TITLE_CODES["1727"]["program"] = "ACADEMIC"
    TITLE_CODES["1727"]["unit"] = "99"

    TITLE_CODES["1724"] = {}
    TITLE_CODES["1724"]["title"] = "ASST PROF IN RES-HCOMP"
    TITLE_CODES["1724"]["program"] = "ACADEMIC"
    TITLE_CODES["1724"]["unit"] = "A3"

    TITLE_CODES["1725"] = {}
    TITLE_CODES["1725"]["title"] = "ASSOC PROF IN RES-HCOMP"
    TITLE_CODES["1725"]["program"] = "ACADEMIC"
    TITLE_CODES["1725"]["unit"] = "A3"

    TITLE_CODES["0788"] = {}
    TITLE_CODES["0788"]["title"] = "INTERCOL ATH COACH AST EX"
    TITLE_CODES["0788"]["program"] = "MSP"
    TITLE_CODES["0788"]["unit"] = "99"

    TITLE_CODES["0789"] = {}
    TITLE_CODES["0789"]["title"] = "CLIN SOCIAL WORKER CHF"
    TITLE_CODES["0789"]["program"] = "MSP"
    TITLE_CODES["0789"]["unit"] = "99"

    TITLE_CODES["1720"] = {}
    TITLE_CODES["1720"]["title"] = "ACT ASSOC PROFESSOR-MEDCOMP-A"
    TITLE_CODES["1720"]["program"] = "ACADEMIC"
    TITLE_CODES["1720"]["unit"] = "A3"

    TITLE_CODES["1721"] = {}
    TITLE_CODES["1721"]["title"] = "PROF-HCOMP"
    TITLE_CODES["1721"]["program"] = "ACADEMIC"
    TITLE_CODES["1721"]["unit"] = "A3"

    TITLE_CODES["9004"] = {}
    TITLE_CODES["9004"]["title"] = "NUC MED TCHNO"
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
    TITLE_CODES["8094"]["title"] = "COGEN OPR"
    TITLE_CODES["8094"]["program"] = "PSS"
    TITLE_CODES["8094"]["unit"] = "K3"

    TITLE_CODES["7282"] = {}
    TITLE_CODES["7282"]["title"] = "COMPUTING RESC MGR 1"
    TITLE_CODES["7282"]["program"] = "PSS"
    TITLE_CODES["7282"]["unit"] = "99"

    TITLE_CODES["8211"] = {}
    TITLE_CODES["8211"]["title"] = "BLDG MAINT WORKER LD"
    TITLE_CODES["8211"]["program"] = "PSS"
    TITLE_CODES["8211"]["unit"] = "SX"

    TITLE_CODES["8210"] = {}
    TITLE_CODES["8210"]["title"] = "BLDG MAINT SUPV SR"
    TITLE_CODES["8210"]["program"] = "PSS"
    TITLE_CODES["8210"]["unit"] = "99"

    TITLE_CODES["8213"] = {}
    TITLE_CODES["8213"]["title"] = "BLDG MAINT WORKER"
    TITLE_CODES["8213"]["program"] = "PSS"
    TITLE_CODES["8213"]["unit"] = "SX"

    TITLE_CODES["8212"] = {}
    TITLE_CODES["8212"]["title"] = "BLDG MAINT WORKER SR"
    TITLE_CODES["8212"]["program"] = "PSS"
    TITLE_CODES["8212"]["unit"] = "SX"

    TITLE_CODES["9013"] = {}
    TITLE_CODES["9013"]["title"] = "RAD THER TCHNO"
    TITLE_CODES["9013"]["program"] = "PSS"
    TITLE_CODES["9013"]["unit"] = "EX"

    TITLE_CODES["0060"] = {}
    TITLE_CODES["0060"]["title"] = "TREASURER OF THE REGENTS"
    TITLE_CODES["0060"]["program"] = "MSP"
    TITLE_CODES["0060"]["unit"] = "99"

    TITLE_CODES["0061"] = {}
    TITLE_CODES["0061"]["title"] = "CNSLT TO THE TREASURER"
    TITLE_CODES["0061"]["program"] = "MSP"
    TITLE_CODES["0061"]["unit"] = "99"

    TITLE_CODES["3007"] = {}
    TITLE_CODES["3007"]["title"] = "ACT AGRON AES"
    TITLE_CODES["3007"]["program"] = "ACADEMIC"
    TITLE_CODES["3007"]["unit"] = "99"

    TITLE_CODES["0063"] = {}
    TITLE_CODES["0063"]["title"] = "ASC TREASURER OF THE REGENTS"
    TITLE_CODES["0063"]["program"] = "MSP"
    TITLE_CODES["0063"]["unit"] = "99"

    TITLE_CODES["0064"] = {}
    TITLE_CODES["0064"]["title"] = "ASC TREASURER REAL ESTATE"
    TITLE_CODES["0064"]["program"] = "MSP"
    TITLE_CODES["0064"]["unit"] = "99"

    TITLE_CODES["0065"] = {}
    TITLE_CODES["0065"]["title"] = "AST TREASURER OF THE REGENTS"
    TITLE_CODES["0065"]["program"] = "MSP"
    TITLE_CODES["0065"]["unit"] = "99"

    TITLE_CODES["7656"] = {}
    TITLE_CODES["7656"]["title"] = "HR ANL 5 SUPV"
    TITLE_CODES["7656"]["program"] = "PSS"
    TITLE_CODES["7656"]["unit"] = "99"

    TITLE_CODES["0067"] = {}
    TITLE_CODES["0067"]["title"] = "AST TREASURER REAL ESTATE"
    TITLE_CODES["0067"]["program"] = "MSP"
    TITLE_CODES["0067"]["unit"] = "99"

    TITLE_CODES["7658"] = {}
    TITLE_CODES["7658"]["title"] = "HR ANL 1"
    TITLE_CODES["7658"]["program"] = "PSS"
    TITLE_CODES["7658"]["unit"] = "99"

    TITLE_CODES["0069"] = {}
    TITLE_CODES["0069"]["title"] = "AST TREASURER INV"
    TITLE_CODES["0069"]["program"] = "MSP"
    TITLE_CODES["0069"]["unit"] = "99"

    TITLE_CODES["3009"] = {}
    TITLE_CODES["3009"]["title"] = "ACT AGRON AES-SFT-VM"
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
    TITLE_CODES["5111"]["title"] = "CUSTODIAN SR SUPV"
    TITLE_CODES["5111"]["program"] = "PSS"
    TITLE_CODES["5111"]["unit"] = "99"

    TITLE_CODES["7154"] = {}
    TITLE_CODES["7154"]["title"] = "ENGR AST"
    TITLE_CODES["7154"]["program"] = "PSS"
    TITLE_CODES["7154"]["unit"] = "99"

    TITLE_CODES["3360"] = {}
    TITLE_CODES["3360"]["title"] = "ADJUNCT INSTRUCTOR-ACAD YR-1/9"
    TITLE_CODES["3360"]["program"] = "ACADEMIC"
    TITLE_CODES["3360"]["unit"] = "99"

    TITLE_CODES["3361"] = {}
    TITLE_CODES["3361"]["title"] = "ASST ADJ PROF-AY-1/9"
    TITLE_CODES["3361"]["program"] = "ACADEMIC"
    TITLE_CODES["3361"]["unit"] = "99"

    TITLE_CODES["3362"] = {}
    TITLE_CODES["3362"]["title"] = "ASSOC ADJ PROF-AY-1/9"
    TITLE_CODES["3362"]["program"] = "ACADEMIC"
    TITLE_CODES["3362"]["unit"] = "99"

    TITLE_CODES["3363"] = {}
    TITLE_CODES["3363"]["title"] = "ADJ PROF-AY-1/9"
    TITLE_CODES["3363"]["program"] = "ACADEMIC"
    TITLE_CODES["3363"]["unit"] = "99"

    TITLE_CODES["0731"] = {}
    TITLE_CODES["0731"]["title"] = "ADMIN ANL PRN 2"
    TITLE_CODES["0731"]["program"] = "MSP"
    TITLE_CODES["0731"]["unit"] = "99"

    TITLE_CODES["0733"] = {}
    TITLE_CODES["0733"]["title"] = "BUDGET ANL PRN 2"
    TITLE_CODES["0733"]["program"] = "MSP"
    TITLE_CODES["0733"]["unit"] = "99"

    TITLE_CODES["0732"] = {}
    TITLE_CODES["0732"]["title"] = "PROGR ANL 5 SUPV"
    TITLE_CODES["0732"]["program"] = "MSP"
    TITLE_CODES["0732"]["unit"] = "99"

    TITLE_CODES["0735"] = {}
    TITLE_CODES["0735"]["title"] = "PROGR ANL 5 SUPV"
    TITLE_CODES["0735"]["program"] = "MSP"
    TITLE_CODES["0735"]["unit"] = "99"

    TITLE_CODES["0734"] = {}
    TITLE_CODES["0734"]["title"] = "PROGR ANL 5"
    TITLE_CODES["0734"]["program"] = "MSP"
    TITLE_CODES["0734"]["unit"] = "99"

    TITLE_CODES["0737"] = {}
    TITLE_CODES["0737"]["title"] = "PROGR ANL 4 SUPV"
    TITLE_CODES["0737"]["program"] = "MSP"
    TITLE_CODES["0737"]["unit"] = "99"

    TITLE_CODES["0509"] = {}
    TITLE_CODES["0509"]["title"] = "LABOR REL ADVOCATE"
    TITLE_CODES["0509"]["program"] = "MSP"
    TITLE_CODES["0509"]["unit"] = "99"

    TITLE_CODES["0506"] = {}
    TITLE_CODES["0506"]["title"] = "CAMPUS OMBUDSPERSON"
    TITLE_CODES["0506"]["program"] = "MSP"
    TITLE_CODES["0506"]["unit"] = "99"

    TITLE_CODES["0507"] = {}
    TITLE_CODES["0507"]["title"] = "GEOPHYSICAL ANL"
    TITLE_CODES["0507"]["program"] = "MSP"
    TITLE_CODES["0507"]["unit"] = "99"

    TITLE_CODES["0504"] = {}
    TITLE_CODES["0504"]["title"] = "SPONSORING EDITOR MAP"
    TITLE_CODES["0504"]["program"] = "MSP"
    TITLE_CODES["0504"]["unit"] = "99"

    TITLE_CODES["0505"] = {}
    TITLE_CODES["0505"]["title"] = "MED APPLICATIONS ANL"
    TITLE_CODES["0505"]["program"] = "MSP"
    TITLE_CODES["0505"]["unit"] = "99"

    TITLE_CODES["0502"] = {}
    TITLE_CODES["0502"]["title"] = "EXECUTIVE CHEF 5"
    TITLE_CODES["0502"]["program"] = "MSP"
    TITLE_CODES["0502"]["unit"] = "99"

    TITLE_CODES["0503"] = {}
    TITLE_CODES["0503"]["title"] = "VETERINARIAN SR"
    TITLE_CODES["0503"]["program"] = "MSP"
    TITLE_CODES["0503"]["unit"] = "99"

    TITLE_CODES["9451"] = {}
    TITLE_CODES["9451"]["title"] = "MUSIC THER"
    TITLE_CODES["9451"]["program"] = "PSS"
    TITLE_CODES["9451"]["unit"] = "HX"

    TITLE_CODES["0501"] = {}
    TITLE_CODES["0501"]["title"] = "ADMIN STATISTICIAN"
    TITLE_CODES["0501"]["program"] = "MSP"
    TITLE_CODES["0501"]["unit"] = "99"

    TITLE_CODES["8105"] = {}
    TITLE_CODES["8105"]["title"] = "PAINTER LD"
    TITLE_CODES["8105"]["program"] = "PSS"
    TITLE_CODES["8105"]["unit"] = "K3"

    TITLE_CODES["1645"] = {}
    TITLE_CODES["1645"]["title"] = "SR LECT-FY-CONTINUING"
    TITLE_CODES["1645"]["program"] = "ACADEMIC"
    TITLE_CODES["1645"]["unit"] = "IX"

    TITLE_CODES["1210"] = {}
    TITLE_CODES["1210"]["title"] = "ASSOC PROF-FY"
    TITLE_CODES["1210"]["program"] = "ACADEMIC"
    TITLE_CODES["1210"]["unit"] = "A3"

    TITLE_CODES["7288"] = {}
    TITLE_CODES["7288"]["title"] = "PROGR 6"
    TITLE_CODES["7288"]["program"] = "PSS"
    TITLE_CODES["7288"]["unit"] = "99"

    TITLE_CODES["1216"] = {}
    TITLE_CODES["1216"]["title"] = "ASSOC PROFESSOR-FY-RECALL"
    TITLE_CODES["1216"]["program"] = "ACADEMIC"
    TITLE_CODES["1216"]["unit"] = "A3"

    TITLE_CODES["0635"] = {}
    TITLE_CODES["0635"]["title"] = "PROGR ANL 4 UCOP"
    TITLE_CODES["0635"]["program"] = "MSP"
    TITLE_CODES["0635"]["unit"] = "99"

    TITLE_CODES["0636"] = {}
    TITLE_CODES["0636"]["title"] = "SYS PROGR 4"
    TITLE_CODES["0636"]["program"] = "MSP"
    TITLE_CODES["0636"]["unit"] = "99"

    TITLE_CODES["0637"] = {}
    TITLE_CODES["0637"]["title"] = "NETWORK ENGR 2"
    TITLE_CODES["0637"]["program"] = "MSP"
    TITLE_CODES["0637"]["unit"] = "99"

    TITLE_CODES["0638"] = {}
    TITLE_CODES["0638"]["title"] = "IT RESOURCE MGR 2"
    TITLE_CODES["0638"]["program"] = "MSP"
    TITLE_CODES["0638"]["unit"] = "99"

    TITLE_CODES["0639"] = {}
    TITLE_CODES["0639"]["title"] = "IT RESOURCE MGR 3"
    TITLE_CODES["0639"]["program"] = "MSP"
    TITLE_CODES["0639"]["unit"] = "99"

    TITLE_CODES["1218"] = {}
    TITLE_CODES["1218"]["title"] = "VST ASSOC PROFESSOR-FISCAL YR"
    TITLE_CODES["1218"]["program"] = "ACADEMIC"
    TITLE_CODES["1218"]["unit"] = "99"

    TITLE_CODES["0461"] = {}
    TITLE_CODES["0461"]["title"] = "SPEC"
    TITLE_CODES["0461"]["program"] = "MSP"
    TITLE_CODES["0461"]["unit"] = "99"

    TITLE_CODES["9162"] = {}
    TITLE_CODES["9162"]["title"] = "OPERATING ROOM EQUIP SPEC 2"
    TITLE_CODES["9162"]["program"] = "PSS"
    TITLE_CODES["9162"]["unit"] = "EX"

    TITLE_CODES["8074"] = {}
    TITLE_CODES["8074"]["title"] = "LABORER SR LD"
    TITLE_CODES["8074"]["program"] = "PSS"
    TITLE_CODES["8074"]["unit"] = "SX"

    TITLE_CODES["9223"] = {}
    TITLE_CODES["9223"]["title"] = "MED OFC SVC CRD 5 SUPV"
    TITLE_CODES["9223"]["program"] = "PSS"
    TITLE_CODES["9223"]["unit"] = "99"

    TITLE_CODES["5842"] = {}
    TITLE_CODES["5842"]["title"] = "LAUNDRY MACHINE OPR"
    TITLE_CODES["5842"]["program"] = "PSS"
    TITLE_CODES["5842"]["unit"] = "SX"

    TITLE_CODES["9394"] = {}
    TITLE_CODES["9394"]["title"] = "GI ENDOSCOPY TCHN SUPV"
    TITLE_CODES["9394"]["program"] = "PSS"
    TITLE_CODES["9394"]["unit"] = "99"

    TITLE_CODES["8268"] = {}
    TITLE_CODES["8268"]["title"] = "ELEVATOR MECH APPR"
    TITLE_CODES["8268"]["program"] = "PSS"
    TITLE_CODES["8268"]["unit"] = "K3"

    TITLE_CODES["8077"] = {}
    TITLE_CODES["8077"]["title"] = "LABORER PD"
    TITLE_CODES["8077"]["program"] = "PSS"
    TITLE_CODES["8077"]["unit"] = "SX"

    TITLE_CODES["6950"] = {}
    TITLE_CODES["6950"]["title"] = "ARCHITECT SUPV"
    TITLE_CODES["6950"]["program"] = "PSS"
    TITLE_CODES["6950"]["unit"] = "99"

    TITLE_CODES["1641"] = {}
    TITLE_CODES["1641"]["title"] = "SR LECT-AY-CONTINUING"
    TITLE_CODES["1641"]["program"] = "ACADEMIC"
    TITLE_CODES["1641"]["unit"] = "IX"

    TITLE_CODES["5654"] = {}
    TITLE_CODES["5654"]["title"] = "FOOD SVC WORKER PRN SUPV"
    TITLE_CODES["5654"]["program"] = "PSS"
    TITLE_CODES["5654"]["unit"] = "99"

    TITLE_CODES["5655"] = {}
    TITLE_CODES["5655"]["title"] = "FOOD SVC WORKER SR SUPV"
    TITLE_CODES["5655"]["program"] = "PSS"
    TITLE_CODES["5655"]["unit"] = "99"

    TITLE_CODES["5652"] = {}
    TITLE_CODES["5652"]["title"] = "FOOD SVC WORKER"
    TITLE_CODES["5652"]["program"] = "PSS"
    TITLE_CODES["5652"]["unit"] = "SX"

    TITLE_CODES["6955"] = {}
    TITLE_CODES["6955"]["title"] = "ARCHITECTURAL ASC SUPV EX"
    TITLE_CODES["6955"]["program"] = "PSS"
    TITLE_CODES["6955"]["unit"] = "99"

    TITLE_CODES["5650"] = {}
    TITLE_CODES["5650"]["title"] = "FOOD SVC WORKER PRN"
    TITLE_CODES["5650"]["program"] = "PSS"
    TITLE_CODES["5650"]["unit"] = "SX"

    TITLE_CODES["1640"] = {}
    TITLE_CODES["1640"]["title"] = "SR LECT-AY"
    TITLE_CODES["1640"]["program"] = "ACADEMIC"
    TITLE_CODES["1640"]["unit"] = "IX"

    TITLE_CODES["5520"] = {}
    TITLE_CODES["5520"]["title"] = "COOK PD"
    TITLE_CODES["5520"]["program"] = "PSS"
    TITLE_CODES["5520"]["unit"] = "SX"

    TITLE_CODES["1643"] = {}
    TITLE_CODES["1643"]["title"] = "SR LECT-AY-1/9-CONTINUING"
    TITLE_CODES["1643"]["program"] = "ACADEMIC"
    TITLE_CODES["1643"]["unit"] = "IX"

    TITLE_CODES["9452"] = {}
    TITLE_CODES["9452"]["title"] = "ART THERAPIST"
    TITLE_CODES["9452"]["program"] = "PSS"
    TITLE_CODES["9452"]["unit"] = "HX"

    TITLE_CODES["1642"] = {}
    TITLE_CODES["1642"]["title"] = "SR LECT-AY-1/9"
    TITLE_CODES["1642"]["program"] = "ACADEMIC"
    TITLE_CODES["1642"]["unit"] = "IX"

    TITLE_CODES["1106"] = {}
    TITLE_CODES["1106"]["title"] = "PROFESSOR-ACAD YR-RECALLED"
    TITLE_CODES["1106"]["program"] = "ACADEMIC"
    TITLE_CODES["1106"]["unit"] = "A3"

    TITLE_CODES["1107"] = {}
    TITLE_CODES["1107"]["title"] = "ACT PROF-AY"
    TITLE_CODES["1107"]["program"] = "ACADEMIC"
    TITLE_CODES["1107"]["unit"] = "A3"

    TITLE_CODES["1104"] = {}
    TITLE_CODES["1104"]["title"] = "UNIV PROF"
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
    TITLE_CODES["1103"]["title"] = "PROF-AY-1/9"
    TITLE_CODES["1103"]["program"] = "ACADEMIC"
    TITLE_CODES["1103"]["unit"] = "A3"

    TITLE_CODES["1100"] = {}
    TITLE_CODES["1100"]["title"] = "PROF-AY"
    TITLE_CODES["1100"]["program"] = "ACADEMIC"
    TITLE_CODES["1100"]["unit"] = "A3"

    TITLE_CODES["1101"] = {}
    TITLE_CODES["1101"]["title"] = "ACT PROF-AY-1/9"
    TITLE_CODES["1101"]["program"] = "ACADEMIC"
    TITLE_CODES["1101"]["unit"] = "A3"

    TITLE_CODES["8668"] = {}
    TITLE_CODES["8668"]["title"] = "LAB MECHN PRN SUPV"
    TITLE_CODES["8668"]["program"] = "PSS"
    TITLE_CODES["8668"]["unit"] = "99"

    TITLE_CODES["8669"] = {}
    TITLE_CODES["8669"]["title"] = "MED CTR LAB MECHN PRN SUPV"
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
    TITLE_CODES["1108"]["title"] = "VIS PROF"
    TITLE_CODES["1108"]["program"] = "ACADEMIC"
    TITLE_CODES["1108"]["unit"] = "99"

    TITLE_CODES["1109"] = {}
    TITLE_CODES["1109"]["title"] = "PROFESSOR RECALLED-ACAD YR-1/9"
    TITLE_CODES["1109"]["program"] = "ACADEMIC"
    TITLE_CODES["1109"]["unit"] = "A3"

    TITLE_CODES["8279"] = {}
    TITLE_CODES["8279"]["title"] = "CTRL HEAT COOLING PLT OPR"
    TITLE_CODES["8279"]["program"] = "PSS"
    TITLE_CODES["8279"]["unit"] = "K3"

    TITLE_CODES["9294"] = {}
    TITLE_CODES["9294"]["title"] = "PHLEBOTOMIST CERT TCHN 3"
    TITLE_CODES["9294"]["program"] = "PSS"
    TITLE_CODES["9294"]["unit"] = "EX"

    TITLE_CODES["1722"] = {}
    TITLE_CODES["1722"]["title"] = "ACT PROFESSOR-MEDCOMP-A"
    TITLE_CODES["1722"]["program"] = "ACADEMIC"
    TITLE_CODES["1722"]["unit"] = "A3"

    TITLE_CODES["8278"] = {}
    TITLE_CODES["8278"]["title"] = "CTRL HEAT COOLING PLT OPR APPR"
    TITLE_CODES["8278"]["program"] = "PSS"
    TITLE_CODES["8278"]["unit"] = "K3"

    TITLE_CODES["9128"] = {}
    TITLE_CODES["9128"]["title"] = "CLIN NURSE SUPV 3"
    TITLE_CODES["9128"]["program"] = "PSS"
    TITLE_CODES["9128"]["unit"] = "99"

    TITLE_CODES["1723"] = {}
    TITLE_CODES["1723"]["title"] = "INSTR IN RES-HCOMP"
    TITLE_CODES["1723"]["program"] = "ACADEMIC"
    TITLE_CODES["1723"]["unit"] = "A3"

    TITLE_CODES["8563"] = {}
    TITLE_CODES["8563"]["title"] = "EQUIP OPR"
    TITLE_CODES["8563"]["program"] = "PSS"
    TITLE_CODES["8563"]["unit"] = "SX"

    TITLE_CODES["3395"] = {}
    TITLE_CODES["3395"]["title"] = "ASST PROJ SCIENTIST-FY-B/E/E"
    TITLE_CODES["3395"]["program"] = "ACADEMIC"
    TITLE_CODES["3395"]["unit"] = "FX"

    TITLE_CODES["9398"] = {}
    TITLE_CODES["9398"]["title"] = "GI ENDOSCOPY TCHN 1 PD"
    TITLE_CODES["9398"]["program"] = "PSS"
    TITLE_CODES["9398"]["unit"] = "EX"

    TITLE_CODES["7570"] = {}
    TITLE_CODES["7570"]["title"] = "PATENT ADVISOR SUPV"
    TITLE_CODES["7570"]["program"] = "PSS"
    TITLE_CODES["7570"]["unit"] = "99"

    TITLE_CODES["7573"] = {}
    TITLE_CODES["7573"]["title"] = "PATENT ADVISOR 1"
    TITLE_CODES["7573"]["program"] = "PSS"
    TITLE_CODES["7573"]["unit"] = "99"

    TITLE_CODES["7572"] = {}
    TITLE_CODES["7572"]["title"] = "PATENT ADVISOR 2"
    TITLE_CODES["7572"]["program"] = "PSS"
    TITLE_CODES["7572"]["unit"] = "99"

    TITLE_CODES["9018"] = {}
    TITLE_CODES["9018"]["title"] = "RADLG TCHNO SR SUPV"
    TITLE_CODES["9018"]["program"] = "PSS"
    TITLE_CODES["9018"]["unit"] = "99"

    TITLE_CODES["9395"] = {}
    TITLE_CODES["9395"]["title"] = "GI ENDOSCOPY TCHN 3"
    TITLE_CODES["9395"]["program"] = "PSS"
    TITLE_CODES["9395"]["unit"] = "EX"

    TITLE_CODES["9129"] = {}
    TITLE_CODES["9129"]["title"] = "CLIN NURSE SUPV 2"
    TITLE_CODES["9129"]["program"] = "PSS"
    TITLE_CODES["9129"]["unit"] = "99"

    TITLE_CODES["9811"] = {}
    TITLE_CODES["9811"]["title"] = "FIRE CAPTAIN NON SAFETY"
    TITLE_CODES["9811"]["program"] = "PSS"
    TITLE_CODES["9811"]["unit"] = "F3"

    TITLE_CODES["9812"] = {}
    TITLE_CODES["9812"]["title"] = "FIRE SPEC 1 NON SAFETY"
    TITLE_CODES["9812"]["program"] = "PSS"
    TITLE_CODES["9812"]["unit"] = "F3"

    TITLE_CODES["8272"] = {}
    TITLE_CODES["8272"]["title"] = "ACCELERATOR OPR SR"
    TITLE_CODES["8272"]["program"] = "PSS"
    TITLE_CODES["8272"]["unit"] = "TX"

    TITLE_CODES["7777"] = {}
    TITLE_CODES["7777"]["title"] = "BUYER SUPV"
    TITLE_CODES["7777"]["program"] = "PSS"
    TITLE_CODES["7777"]["unit"] = "99"

    TITLE_CODES["7365"] = {}
    TITLE_CODES["7365"]["title"] = "ANL 9 SUPV"
    TITLE_CODES["7365"]["program"] = "PSS"
    TITLE_CODES["7365"]["unit"] = "99"

    TITLE_CODES["7775"] = {}
    TITLE_CODES["7775"]["title"] = "BUYER 1"
    TITLE_CODES["7775"]["program"] = "PSS"
    TITLE_CODES["7775"]["unit"] = "99"

    TITLE_CODES["3394"] = {}
    TITLE_CODES["3394"]["title"] = "ASST PROJ SCIENTIST-FY"
    TITLE_CODES["3394"]["program"] = "ACADEMIC"
    TITLE_CODES["3394"]["unit"] = "FX"

    TITLE_CODES["7773"] = {}
    TITLE_CODES["7773"]["title"] = "BUYER 4"
    TITLE_CODES["7773"]["program"] = "PSS"
    TITLE_CODES["7773"]["unit"] = "99"

    TITLE_CODES["7772"] = {}
    TITLE_CODES["7772"]["title"] = "BUYER 5"
    TITLE_CODES["7772"]["program"] = "PSS"
    TITLE_CODES["7772"]["unit"] = "99"

    TITLE_CODES["7280"] = {}
    TITLE_CODES["7280"]["title"] = "PROGR 8"
    TITLE_CODES["7280"]["program"] = "PSS"
    TITLE_CODES["7280"]["unit"] = "99"

    TITLE_CODES["8270"] = {}
    TITLE_CODES["8270"]["title"] = "ACCELERATOR OPS SUPV"
    TITLE_CODES["8270"]["program"] = "PSS"
    TITLE_CODES["8270"]["unit"] = "99"

    TITLE_CODES["9229"] = {}
    TITLE_CODES["9229"]["title"] = "OPERATING ROOM SUPP AST PD"
    TITLE_CODES["9229"]["program"] = "PSS"
    TITLE_CODES["9229"]["unit"] = "EX"

    TITLE_CODES["7779"] = {}
    TITLE_CODES["7779"]["title"] = "BUYER 4 SUPV"
    TITLE_CODES["7779"]["program"] = "PSS"
    TITLE_CODES["7779"]["unit"] = "99"

    TITLE_CODES["7778"] = {}
    TITLE_CODES["7778"]["title"] = "BUYER 5 SUPV"
    TITLE_CODES["7778"]["program"] = "PSS"
    TITLE_CODES["7778"]["unit"] = "99"

    TITLE_CODES["4923"] = {}
    TITLE_CODES["4923"]["title"] = "STDT 2 NON UC"
    TITLE_CODES["4923"]["program"] = "PSS"
    TITLE_CODES["4923"]["unit"] = "99"

    TITLE_CODES["9529"] = {}
    TITLE_CODES["9529"]["title"] = "VETERINARIAN ASC SUPV"
    TITLE_CODES["9529"]["program"] = "PSS"
    TITLE_CODES["9529"]["unit"] = "99"

    TITLE_CODES["7650"] = {}
    TITLE_CODES["7650"]["title"] = "HR ANL 5"
    TITLE_CODES["7650"]["program"] = "PSS"
    TITLE_CODES["7650"]["unit"] = "99"

    TITLE_CODES["7366"] = {}
    TITLE_CODES["7366"]["title"] = "ANL 10 SUPV"
    TITLE_CODES["7366"]["program"] = "PSS"
    TITLE_CODES["7366"]["unit"] = "99"

    TITLE_CODES["8314"] = {}
    TITLE_CODES["8314"]["title"] = "LAB GLASSBLOWER TRAINEE"
    TITLE_CODES["8314"]["program"] = "PSS"
    TITLE_CODES["8314"]["unit"] = "TX"

    TITLE_CODES["6732"] = {}
    TITLE_CODES["6732"]["title"] = "BIBLIOGRAPHER 2"
    TITLE_CODES["6732"]["program"] = "PSS"
    TITLE_CODES["6732"]["unit"] = "CX"

    TITLE_CODES["4920"] = {}
    TITLE_CODES["4920"]["title"] = "STDT 3"
    TITLE_CODES["4920"]["program"] = "PSS"
    TITLE_CODES["4920"]["unit"] = "99"

    TITLE_CODES["8311"] = {}
    TITLE_CODES["8311"]["title"] = "LAB GLASSBLOWER PRN"
    TITLE_CODES["8311"]["program"] = "PSS"
    TITLE_CODES["8311"]["unit"] = "TX"

    TITLE_CODES["6905"] = {}
    TITLE_CODES["6905"]["title"] = "ARCHITECTURAL ASC NEX"
    TITLE_CODES["6905"]["program"] = "PSS"
    TITLE_CODES["6905"]["unit"] = "99"

    TITLE_CODES["8313"] = {}
    TITLE_CODES["8313"]["title"] = "LAB GLASSBLOWER"
    TITLE_CODES["8313"]["program"] = "PSS"
    TITLE_CODES["8313"]["unit"] = "TX"

    TITLE_CODES["9481"] = {}
    TITLE_CODES["9481"]["title"] = "PHYS THER 4"
    TITLE_CODES["9481"]["program"] = "PSS"
    TITLE_CODES["9481"]["unit"] = "99"

    TITLE_CODES["4926"] = {}
    TITLE_CODES["4926"]["title"] = "SPC STDT BYA"
    TITLE_CODES["4926"]["program"] = "PSS"
    TITLE_CODES["4926"]["unit"] = "99"

    TITLE_CODES["8084"] = {}
    TITLE_CODES["8084"]["title"] = "TREE TRIMMER LD"
    TITLE_CODES["8084"]["program"] = "PSS"
    TITLE_CODES["8084"]["unit"] = "SX"

    TITLE_CODES["8026"] = {}
    TITLE_CODES["8026"]["title"] = "RECREATION THER 2 SUPV"
    TITLE_CODES["8026"]["program"] = "PSS"
    TITLE_CODES["8026"]["unit"] = "99"

    TITLE_CODES["5832"] = {}
    TITLE_CODES["5832"]["title"] = "LINEN SVC WORKER SR"
    TITLE_CODES["5832"]["program"] = "PSS"
    TITLE_CODES["5832"]["unit"] = "SX"

    TITLE_CODES["5833"] = {}
    TITLE_CODES["5833"]["title"] = "LINEN SVC WORKER"
    TITLE_CODES["5833"]["program"] = "PSS"
    TITLE_CODES["5833"]["unit"] = "SX"

    TITLE_CODES["8082"] = {}
    TITLE_CODES["8082"]["title"] = "TREE TRIMMER SUPV"
    TITLE_CODES["8082"]["program"] = "PSS"
    TITLE_CODES["8082"]["unit"] = "99"

    TITLE_CODES["8083"] = {}
    TITLE_CODES["8083"]["title"] = "TREE TRIMMER"
    TITLE_CODES["8083"]["program"] = "PSS"
    TITLE_CODES["8083"]["unit"] = "SX"

    TITLE_CODES["4013"] = {}
    TITLE_CODES["4013"]["title"] = "COACH SPEC"
    TITLE_CODES["4013"]["program"] = "PSS"
    TITLE_CODES["4013"]["unit"] = "99"

    TITLE_CODES["4012"] = {}
    TITLE_CODES["4012"]["title"] = "INTERCOL ATH HEAD COACH NEX"
    TITLE_CODES["4012"]["program"] = "PSS"
    TITLE_CODES["4012"]["unit"] = "99"

    TITLE_CODES["4011"] = {}
    TITLE_CODES["4011"]["title"] = "RECREATION PRG INSTR"
    TITLE_CODES["4011"]["program"] = "PSS"
    TITLE_CODES["4011"]["unit"] = "99"

    TITLE_CODES["7651"] = {}
    TITLE_CODES["7651"]["title"] = "HR ANL 6"
    TITLE_CODES["7651"]["program"] = "PSS"
    TITLE_CODES["7651"]["unit"] = "99"

    TITLE_CODES["3396"] = {}
    TITLE_CODES["3396"]["title"] = "VIS PROJ SCIENTIST"
    TITLE_CODES["3396"]["program"] = "ACADEMIC"
    TITLE_CODES["3396"]["unit"] = "99"

    TITLE_CODES["0357"] = {}
    TITLE_CODES["0357"]["title"] = "POLICE SVC CRD"
    TITLE_CODES["0357"]["program"] = "MSP"
    TITLE_CODES["0357"]["unit"] = "99"

    TITLE_CODES["0355"] = {}
    TITLE_CODES["0355"]["title"] = "ADM CRD OFCR"
    TITLE_CODES["0355"]["program"] = "MSP"
    TITLE_CODES["0355"]["unit"] = "99"

    TITLE_CODES["9813"] = {}
    TITLE_CODES["9813"]["title"] = "FIRE SPEC 2 NON SAFETY"
    TITLE_CODES["9813"]["program"] = "PSS"
    TITLE_CODES["9813"]["unit"] = "F3"

    TITLE_CODES["6966"] = {}
    TITLE_CODES["6966"]["title"] = "FAC REQUIREMENTS ANL SUPV"
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
    TITLE_CODES["1032"]["title"] = "ASSOC DIVISIONAL DEAN"
    TITLE_CODES["1032"]["program"] = "ACADEMIC"
    TITLE_CODES["1032"]["unit"] = "99"

    TITLE_CODES["3107"] = {}
    TITLE_CODES["3107"]["title"] = "ACTING ASTRONOMER"
    TITLE_CODES["3107"]["program"] = "ACADEMIC"
    TITLE_CODES["3107"]["unit"] = "99"

    TITLE_CODES["0210"] = {}
    TITLE_CODES["0210"]["title"] = "VICE CHAN AST"
    TITLE_CODES["0210"]["program"] = "MSP"
    TITLE_CODES["0210"]["unit"] = "99"

    TITLE_CODES["3100"] = {}
    TITLE_CODES["3100"]["title"] = "ASTRONOMER"
    TITLE_CODES["3100"]["program"] = "ACADEMIC"
    TITLE_CODES["3100"]["unit"] = "FX"

    TITLE_CODES["6121"] = {}
    TITLE_CODES["6121"]["title"] = "MED ILLUSTRATOR PRN"
    TITLE_CODES["6121"]["program"] = "PSS"
    TITLE_CODES["6121"]["unit"] = "99"

    TITLE_CODES["9802"] = {}
    TITLE_CODES["9802"]["title"] = "FIRE CHF AST"
    TITLE_CODES["9802"]["program"] = "PSS"
    TITLE_CODES["9802"]["unit"] = "99"

    TITLE_CODES["6123"] = {}
    TITLE_CODES["6123"]["title"] = "MED ILLUSTRATOR"
    TITLE_CODES["6123"]["program"] = "PSS"
    TITLE_CODES["6123"]["unit"] = "TX"

    TITLE_CODES["6122"] = {}
    TITLE_CODES["6122"]["title"] = "MED ILLUSTRATOR SR"
    TITLE_CODES["6122"]["program"] = "PSS"
    TITLE_CODES["6122"]["unit"] = "TX"

    TITLE_CODES["9295"] = {}
    TITLE_CODES["9295"]["title"] = "PHLEBOTOMIST CERT TCHN 2 PD"
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
    TITLE_CODES["7653"]["title"] = "HR ANL 2 SUPV"
    TITLE_CODES["7653"]["program"] = "PSS"
    TITLE_CODES["7653"]["unit"] = "99"

    TITLE_CODES["8671"] = {}
    TITLE_CODES["8671"]["title"] = "MED CTR LAB MECHN PRN"
    TITLE_CODES["8671"]["program"] = "PSS"
    TITLE_CODES["8671"]["unit"] = "EX"

    TITLE_CODES["8092"] = {}
    TITLE_CODES["8092"]["title"] = "SHEETMETAL MECH APPR"
    TITLE_CODES["8092"]["program"] = "PSS"
    TITLE_CODES["8092"]["unit"] = "K3"

    TITLE_CODES["6902"] = {}
    TITLE_CODES["6902"]["title"] = "ARCHITECTURAL ASC PRN"
    TITLE_CODES["6902"]["program"] = "PSS"
    TITLE_CODES["6902"]["unit"] = "99"

    TITLE_CODES["8670"] = {}
    TITLE_CODES["8670"]["title"] = "MED CTR LAB MECHN SR SUPV"
    TITLE_CODES["8670"]["program"] = "PSS"
    TITLE_CODES["8670"]["unit"] = "99"

    TITLE_CODES["3619"] = {}
    TITLE_CODES["3619"]["title"] = "VSTG ASSOC LIBRARIAN-FISCAL YR"
    TITLE_CODES["3619"]["program"] = "ACADEMIC"
    TITLE_CODES["3619"]["unit"] = "99"

    TITLE_CODES["0280"] = {}
    TITLE_CODES["0280"]["title"] = "MGR"
    TITLE_CODES["0280"]["program"] = "MSP"
    TITLE_CODES["0280"]["unit"] = "99"

    TITLE_CODES["0283"] = {}
    TITLE_CODES["0283"]["title"] = "MGR ASC"
    TITLE_CODES["0283"]["program"] = "MSP"
    TITLE_CODES["0283"]["unit"] = "99"

    TITLE_CODES["0285"] = {}
    TITLE_CODES["0285"]["title"] = "MGR AST"
    TITLE_CODES["0285"]["program"] = "MSP"
    TITLE_CODES["0285"]["unit"] = "99"

    TITLE_CODES["8892"] = {}
    TITLE_CODES["8892"]["title"] = "ANESTHESIA TCHN SUPV"
    TITLE_CODES["8892"]["program"] = "PSS"
    TITLE_CODES["8892"]["unit"] = "99"

    TITLE_CODES["7654"] = {}
    TITLE_CODES["7654"]["title"] = "HR ANL 3 SUPV"
    TITLE_CODES["7654"]["program"] = "PSS"
    TITLE_CODES["7654"]["unit"] = "99"

    TITLE_CODES["8674"] = {}
    TITLE_CODES["8674"]["title"] = "MED CTR LAB MECHN HELPER"
    TITLE_CODES["8674"]["program"] = "PSS"
    TITLE_CODES["8674"]["unit"] = "EX"

    TITLE_CODES["7616"] = {}
    TITLE_CODES["7616"]["title"] = "ACCOUNTANT 4"
    TITLE_CODES["7616"]["program"] = "PSS"
    TITLE_CODES["7616"]["unit"] = "99"

    TITLE_CODES["9201"] = {}
    TITLE_CODES["9201"]["title"] = "DENTAL AST SUPV"
    TITLE_CODES["9201"]["program"] = "PSS"
    TITLE_CODES["9201"]["unit"] = "99"

    TITLE_CODES["5505"] = {}
    TITLE_CODES["5505"]["title"] = "BAKER AST"
    TITLE_CODES["5505"]["program"] = "PSS"
    TITLE_CODES["5505"]["unit"] = "SX"

    TITLE_CODES["8650"] = {}
    TITLE_CODES["8650"]["title"] = "MECH SHOP SUPT"
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
    TITLE_CODES["7655"]["title"] = "HR ANL 4 SUPV"
    TITLE_CODES["7655"]["program"] = "PSS"
    TITLE_CODES["7655"]["unit"] = "99"

    TITLE_CODES["3004"] = {}
    TITLE_CODES["3004"]["title"] = "SPECIALIST AES"
    TITLE_CODES["3004"]["program"] = "ACADEMIC"
    TITLE_CODES["3004"]["unit"] = "FX"

    TITLE_CODES["7253"] = {}
    TITLE_CODES["7253"]["title"] = "BUDGET ANL"
    TITLE_CODES["7253"]["program"] = "PSS"
    TITLE_CODES["7253"]["unit"] = "99"

    TITLE_CODES["7652"] = {}
    TITLE_CODES["7652"]["title"] = "HR ANL 1 SUPV"
    TITLE_CODES["7652"]["program"] = "PSS"
    TITLE_CODES["7652"]["unit"] = "99"

    TITLE_CODES["9614"] = {}
    TITLE_CODES["9614"]["title"] = "SRA 4 SUPV"
    TITLE_CODES["9614"]["program"] = "PSS"
    TITLE_CODES["9614"]["unit"] = "99"

    TITLE_CODES["3006"] = {}
    TITLE_CODES["3006"]["title"] = " ----- IN THE A.E.S. RECALLED"
    TITLE_CODES["3006"]["program"] = "ACADEMIC"
    TITLE_CODES["3006"]["unit"] = "FX"

    TITLE_CODES["2256"] = {}
    TITLE_CODES["2256"]["title"] = "FLD WK SUPV-FY-CONTINUING"
    TITLE_CODES["2256"]["program"] = "ACADEMIC"
    TITLE_CODES["2256"]["unit"] = "IX"

    TITLE_CODES["2255"] = {}
    TITLE_CODES["2255"]["title"] = "FLD WK SUPV-FY"
    TITLE_CODES["2255"]["program"] = "ACADEMIC"
    TITLE_CODES["2255"]["unit"] = "IX"

    TITLE_CODES["2251"] = {}
    TITLE_CODES["2251"]["title"] = "FLD WK SUPV-AY-CONTINUING"
    TITLE_CODES["2251"]["program"] = "ACADEMIC"
    TITLE_CODES["2251"]["unit"] = "IX"

    TITLE_CODES["2250"] = {}
    TITLE_CODES["2250"]["title"] = "FLD WK SUPV-AY"
    TITLE_CODES["2250"]["program"] = "ACADEMIC"
    TITLE_CODES["2250"]["unit"] = "IX"

    TITLE_CODES["9263"] = {}
    TITLE_CODES["9263"]["title"] = "MED RCDS ADM"
    TITLE_CODES["9263"]["program"] = "PSS"
    TITLE_CODES["9263"]["unit"] = "EX"

    TITLE_CODES["9262"] = {}
    TITLE_CODES["9262"]["title"] = "MED RCDS ADM SR"
    TITLE_CODES["9262"]["program"] = "PSS"
    TITLE_CODES["9262"]["unit"] = "99"

    TITLE_CODES["8472"] = {}
    TITLE_CODES["8472"]["title"] = "AUTO TCHN LD"
    TITLE_CODES["8472"]["program"] = "PSS"
    TITLE_CODES["8472"]["unit"] = "SX"

    TITLE_CODES["9260"] = {}
    TITLE_CODES["9260"]["title"] = "HOSP UNIT SVC CRD PD"
    TITLE_CODES["9260"]["program"] = "PSS"
    TITLE_CODES["9260"]["unit"] = "EX"

    TITLE_CODES["9267"] = {}
    TITLE_CODES["9267"]["title"] = "MED RCDS TCHN AST"
    TITLE_CODES["9267"]["program"] = "PSS"
    TITLE_CODES["9267"]["unit"] = "EX"

    TITLE_CODES["9266"] = {}
    TITLE_CODES["9266"]["title"] = "MED RCDS TCHN"
    TITLE_CODES["9266"]["program"] = "PSS"
    TITLE_CODES["9266"]["unit"] = "EX"

    TITLE_CODES["9265"] = {}
    TITLE_CODES["9265"]["title"] = "STERILE PROCESSING TCHN 1"
    TITLE_CODES["9265"]["program"] = "PSS"
    TITLE_CODES["9265"]["unit"] = "EX"

    TITLE_CODES["9264"] = {}
    TITLE_CODES["9264"]["title"] = "MED RCDS ADM AST"
    TITLE_CODES["9264"]["program"] = "PSS"
    TITLE_CODES["9264"]["unit"] = "EX"

    TITLE_CODES["9203"] = {}
    TITLE_CODES["9203"]["title"] = "PHYSCN AST"
    TITLE_CODES["9203"]["program"] = "PSS"
    TITLE_CODES["9203"]["unit"] = "HX"

    TITLE_CODES["7657"] = {}
    TITLE_CODES["7657"]["title"] = "HR ANL 6 SUPV"
    TITLE_CODES["7657"]["program"] = "PSS"
    TITLE_CODES["7657"]["unit"] = "99"

    TITLE_CODES["5503"] = {}
    TITLE_CODES["5503"]["title"] = "BAKER"
    TITLE_CODES["5503"]["program"] = "PSS"
    TITLE_CODES["5503"]["unit"] = "SX"

    TITLE_CODES["9603"] = {}
    TITLE_CODES["9603"]["title"] = "LAB AST 2"
    TITLE_CODES["9603"]["program"] = "PSS"
    TITLE_CODES["9603"]["unit"] = "TX"

    TITLE_CODES["0115"] = {}
    TITLE_CODES["0115"]["title"] = "EXEC CAMPUS COUNSEL"
    TITLE_CODES["0115"]["program"] = "MSP"
    TITLE_CODES["0115"]["unit"] = "99"

    TITLE_CODES["0114"] = {}
    TITLE_CODES["0114"]["title"] = "EXEC AST EXEC FUNC AREA"
    TITLE_CODES["0114"]["program"] = "MSP"
    TITLE_CODES["0114"]["unit"] = "99"

    TITLE_CODES["0117"] = {}
    TITLE_CODES["0117"]["title"] = "EXEC CHF AUDITOR"
    TITLE_CODES["0117"]["program"] = "MSP"
    TITLE_CODES["0117"]["unit"] = "99"

    TITLE_CODES["0116"] = {}
    TITLE_CODES["0116"]["title"] = "SVP CCAO"
    TITLE_CODES["0116"]["program"] = "MSP"
    TITLE_CODES["0116"]["unit"] = "99"

    TITLE_CODES["0111"] = {}
    TITLE_CODES["0111"]["title"] = "EXEC ASC DEAN FUNC AREA"
    TITLE_CODES["0111"]["program"] = "MSP"
    TITLE_CODES["0111"]["unit"] = "99"

    TITLE_CODES["0110"] = {}
    TITLE_CODES["0110"]["title"] = "EXEC AST DEAN FUNC AREA"
    TITLE_CODES["0110"]["program"] = "MSP"
    TITLE_CODES["0110"]["unit"] = "99"

    TITLE_CODES["0113"] = {}
    TITLE_CODES["0113"]["title"] = "EXEC SPC AST FUNC AREA"
    TITLE_CODES["0113"]["program"] = "MSP"
    TITLE_CODES["0113"]["unit"] = "99"

    TITLE_CODES["0112"] = {}
    TITLE_CODES["0112"]["title"] = "EXEC STAFF AST FOR PLANNING"
    TITLE_CODES["0112"]["program"] = "MSP"
    TITLE_CODES["0112"]["unit"] = "99"

    TITLE_CODES["9142"] = {}
    TITLE_CODES["9142"]["title"] = "ANESTHETIST NURSE PRN"
    TITLE_CODES["9142"]["program"] = "PSS"
    TITLE_CODES["9142"]["unit"] = "99"

    TITLE_CODES["9143"] = {}
    TITLE_CODES["9143"]["title"] = "ANESTHETIST NURSE SR"
    TITLE_CODES["9143"]["program"] = "PSS"
    TITLE_CODES["9143"]["unit"] = "NX"

    TITLE_CODES["9140"] = {}
    TITLE_CODES["9140"]["title"] = "CLIN NURSE 1"
    TITLE_CODES["9140"]["program"] = "PSS"
    TITLE_CODES["9140"]["unit"] = "NX"

    TITLE_CODES["0119"] = {}
    TITLE_CODES["0119"]["title"] = "EXEC ASC UNIV LIBRARIAN"
    TITLE_CODES["0119"]["program"] = "MSP"
    TITLE_CODES["0119"]["unit"] = "99"

    TITLE_CODES["0118"] = {}
    TITLE_CODES["0118"]["title"] = "UNIV LIBRARIAN"
    TITLE_CODES["0118"]["program"] = "MSP"
    TITLE_CODES["0118"]["unit"] = "99"

    TITLE_CODES["9144"] = {}
    TITLE_CODES["9144"]["title"] = "ANESTHETIST NURSE"
    TITLE_CODES["9144"]["program"] = "PSS"
    TITLE_CODES["9144"]["unit"] = "NX"

    TITLE_CODES["9145"] = {}
    TITLE_CODES["9145"]["title"] = "ANESTHETIST NURSE SR SUPV"
    TITLE_CODES["9145"]["program"] = "PSS"
    TITLE_CODES["9145"]["unit"] = "99"

    TITLE_CODES["4802"] = {}
    TITLE_CODES["4802"]["title"] = "COMPUTER RESC SPEC 2 SUPV"
    TITLE_CODES["4802"]["program"] = "PSS"
    TITLE_CODES["4802"]["unit"] = "99"

    TITLE_CODES["4803"] = {}
    TITLE_CODES["4803"]["title"] = "COMPUTER RESC SPEC 1 SUPV"
    TITLE_CODES["4803"]["program"] = "PSS"
    TITLE_CODES["4803"]["unit"] = "99"

    TITLE_CODES["4804"] = {}
    TITLE_CODES["4804"]["title"] = "COMPUTER RESC SPEC 2"
    TITLE_CODES["4804"]["program"] = "PSS"
    TITLE_CODES["4804"]["unit"] = "TX"

    TITLE_CODES["4805"] = {}
    TITLE_CODES["4805"]["title"] = "COMPUTER RESC SPEC 1"
    TITLE_CODES["4805"]["program"] = "PSS"
    TITLE_CODES["4805"]["unit"] = "TX"

    TITLE_CODES["4419"] = {}
    TITLE_CODES["4419"]["title"] = "LRNG SKLS CNSLR SR SUPV EX"
    TITLE_CODES["4419"]["program"] = "PSS"
    TITLE_CODES["4419"]["unit"] = "99"

    TITLE_CODES["4418"] = {}
    TITLE_CODES["4418"]["title"] = "LRNG SKLS CNSLR SUPV"
    TITLE_CODES["4418"]["program"] = "PSS"
    TITLE_CODES["4418"]["unit"] = "99"

    TITLE_CODES["4417"] = {}
    TITLE_CODES["4417"]["title"] = "LRNG SKLS CNSLR AST"
    TITLE_CODES["4417"]["program"] = "PSS"
    TITLE_CODES["4417"]["unit"] = "99"

    TITLE_CODES["4416"] = {}
    TITLE_CODES["4416"]["title"] = "LRNG SKLS CNSLR"
    TITLE_CODES["4416"]["program"] = "PSS"
    TITLE_CODES["4416"]["unit"] = "99"

    TITLE_CODES["4415"] = {}
    TITLE_CODES["4415"]["title"] = "LRNG SKLS CNSLR SR"
    TITLE_CODES["4415"]["program"] = "PSS"
    TITLE_CODES["4415"]["unit"] = "99"

    TITLE_CODES["4414"] = {}
    TITLE_CODES["4414"]["title"] = "LRNG SKLS CNSLR PRN"
    TITLE_CODES["4414"]["program"] = "PSS"
    TITLE_CODES["4414"]["unit"] = "99"

    TITLE_CODES["9125"] = {}
    TITLE_CODES["9125"]["title"] = "TRANSPLANT CRD 3"
    TITLE_CODES["9125"]["program"] = "PSS"
    TITLE_CODES["9125"]["unit"] = "NX"

    TITLE_CODES["4410"] = {}
    TITLE_CODES["4410"]["title"] = "COUNSELING ATTORNEY SUPV"
    TITLE_CODES["4410"]["program"] = "PSS"
    TITLE_CODES["4410"]["unit"] = "99"

    TITLE_CODES["9970"] = {}
    TITLE_CODES["9970"]["title"] = "BLANK APPR"
    TITLE_CODES["9970"]["program"] = "PSS"
    TITLE_CODES["9970"]["unit"] = "99"

    TITLE_CODES["9606"] = {}
    TITLE_CODES["9606"]["title"] = "LAB HELPER"
    TITLE_CODES["9606"]["program"] = "PSS"
    TITLE_CODES["9606"]["unit"] = "SX"

    TITLE_CODES["9466"] = {}
    TITLE_CODES["9466"]["title"] = "RECREATION THER 1"
    TITLE_CODES["9466"]["program"] = "PSS"
    TITLE_CODES["9466"]["unit"] = "HX"

    TITLE_CODES["9048"] = {}
    TITLE_CODES["9048"]["title"] = "RESP THER 2"
    TITLE_CODES["9048"]["program"] = "PSS"
    TITLE_CODES["9048"]["unit"] = "EX"

    TITLE_CODES["6308"] = {}
    TITLE_CODES["6308"]["title"] = "PUBL EVENTS MGR PRN SUPV"
    TITLE_CODES["6308"]["program"] = "PSS"
    TITLE_CODES["6308"]["unit"] = "99"

    TITLE_CODES["9463"] = {}
    TITLE_CODES["9463"]["title"] = "CASE MGR PD"
    TITLE_CODES["9463"]["program"] = "PSS"
    TITLE_CODES["9463"]["unit"] = "HX"

    TITLE_CODES["9462"] = {}
    TITLE_CODES["9462"]["title"] = "CASE MGR SUPV"
    TITLE_CODES["9462"]["program"] = "PSS"
    TITLE_CODES["9462"]["unit"] = "99"

    TITLE_CODES["0917"] = {}
    TITLE_CODES["0917"]["title"] = "ACT/INTERIM ASSOC DIRECTOR"
    TITLE_CODES["0917"]["program"] = "ACADEMIC"
    TITLE_CODES["0917"]["unit"] = "99"

    TITLE_CODES["2070"] = {}
    TITLE_CODES["2070"]["title"] = "HS CLIN INSTR-FY"
    TITLE_CODES["2070"]["program"] = "ACADEMIC"
    TITLE_CODES["2070"]["unit"] = "99"

    TITLE_CODES["2077"] = {}
    TITLE_CODES["2077"]["title"] = "CLIN INSTR-VOL"
    TITLE_CODES["2077"]["program"] = "ACADEMIC"
    TITLE_CODES["2077"]["unit"] = "99"

    TITLE_CODES["0910"] = {}
    TITLE_CODES["0910"]["title"] = "ASSOC DIRECTOR"
    TITLE_CODES["0910"]["program"] = "ACADEMIC"
    TITLE_CODES["0910"]["unit"] = "99"

    TITLE_CODES["4961"] = {}
    TITLE_CODES["4961"]["title"] = "CODER SR"
    TITLE_CODES["4961"]["program"] = "PSS"
    TITLE_CODES["4961"]["unit"] = "CX"

    TITLE_CODES["3226"] = {}
    TITLE_CODES["3226"]["title"] = "ASST RES-SFT"
    TITLE_CODES["3226"]["program"] = "ACADEMIC"
    TITLE_CODES["3226"]["unit"] = "FX"

    TITLE_CODES["9726"] = {}
    TITLE_CODES["9726"]["title"] = "MUSEUM SCI PRN SUPV"
    TITLE_CODES["9726"]["program"] = "PSS"
    TITLE_CODES["9726"]["unit"] = "99"

    TITLE_CODES["9724"] = {}
    TITLE_CODES["9724"]["title"] = "MUSEUM SCI AST"
    TITLE_CODES["9724"]["program"] = "PSS"
    TITLE_CODES["9724"]["unit"] = "RX"

    TITLE_CODES["2600"] = {}
    TITLE_CODES["2600"]["title"] = "MILITARY/AIR SCI&TACTICS ASST"
    TITLE_CODES["2600"]["program"] = "ACADEMIC"
    TITLE_CODES["2600"]["unit"] = "99"

    TITLE_CODES["9723"] = {}
    TITLE_CODES["9723"]["title"] = "MUSEUM SCI"
    TITLE_CODES["9723"]["program"] = "PSS"
    TITLE_CODES["9723"]["unit"] = "RX"

    TITLE_CODES["9089"] = {}
    TITLE_CODES["9089"]["title"] = "MAMMOGRAPHY TCHNO"
    TITLE_CODES["9089"]["program"] = "PSS"
    TITLE_CODES["9089"]["unit"] = "EX"

    TITLE_CODES["9088"] = {}
    TITLE_CODES["9088"]["title"] = "CT TCHNO LD"
    TITLE_CODES["9088"]["program"] = "PSS"
    TITLE_CODES["9088"]["unit"] = "EX"

    TITLE_CODES["9087"] = {}
    TITLE_CODES["9087"]["title"] = "CT TCHNO PD"
    TITLE_CODES["9087"]["program"] = "PSS"
    TITLE_CODES["9087"]["unit"] = "EX"

    TITLE_CODES["9086"] = {}
    TITLE_CODES["9086"]["title"] = "CT TCHNO"
    TITLE_CODES["9086"]["program"] = "PSS"
    TITLE_CODES["9086"]["unit"] = "EX"

    TITLE_CODES["9085"] = {}
    TITLE_CODES["9085"]["title"] = "MRI TCHNO"
    TITLE_CODES["9085"]["program"] = "PSS"
    TITLE_CODES["9085"]["unit"] = "EX"

    TITLE_CODES["9084"] = {}
    TITLE_CODES["9084"]["title"] = "MRI TCHNO PD"
    TITLE_CODES["9084"]["program"] = "PSS"
    TITLE_CODES["9084"]["unit"] = "EX"

    TITLE_CODES["9083"] = {}
    TITLE_CODES["9083"]["title"] = "MRI TCHNO LD"
    TITLE_CODES["9083"]["program"] = "PSS"
    TITLE_CODES["9083"]["unit"] = "EX"

    TITLE_CODES["5430"] = {}
    TITLE_CODES["5430"]["title"] = "DIETETIC AST"
    TITLE_CODES["5430"]["program"] = "PSS"
    TITLE_CODES["5430"]["unit"] = "EX"

    TITLE_CODES["9081"] = {}
    TITLE_CODES["9081"]["title"] = "SVC PARTNER"
    TITLE_CODES["9081"]["program"] = "PSS"
    TITLE_CODES["9081"]["unit"] = "EX"

    TITLE_CODES["9080"] = {}
    TITLE_CODES["9080"]["title"] = "SVC PARTNER PD"
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
    TITLE_CODES["8047"]["title"] = "HVY OFFROAD EQUIP MECH"
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
    TITLE_CODES["3269"]["title"] = "ASSOC ADJ PROF-FY"
    TITLE_CODES["3269"]["program"] = "ACADEMIC"
    TITLE_CODES["3269"]["unit"] = "99"

    TITLE_CODES["3268"] = {}
    TITLE_CODES["3268"]["title"] = "ASSOC ADJ PROF-AY"
    TITLE_CODES["3268"]["program"] = "ACADEMIC"
    TITLE_CODES["3268"]["unit"] = "99"

    TITLE_CODES["5126"] = {}
    TITLE_CODES["5126"]["title"] = "MED CTR COOK"
    TITLE_CODES["5126"]["program"] = "PSS"
    TITLE_CODES["5126"]["unit"] = "SX"

    TITLE_CODES["1938"] = {}
    TITLE_CODES["1938"]["title"] = "ROTATING RESEARCH PROF-ACAD YR"
    TITLE_CODES["1938"]["program"] = "ACADEMIC"
    TITLE_CODES["1938"]["unit"] = "FX"

    TITLE_CODES["7659"] = {}
    TITLE_CODES["7659"]["title"] = "ADMIN SPEC SUPV"
    TITLE_CODES["7659"]["program"] = "PSS"
    TITLE_CODES["7659"]["unit"] = "99"

    TITLE_CODES["9312"] = {}
    TITLE_CODES["9312"]["title"] = "CLIN SOCIAL WORKER SUPV"
    TITLE_CODES["9312"]["program"] = "PSS"
    TITLE_CODES["9312"]["unit"] = "99"

    TITLE_CODES["9006"] = {}
    TITLE_CODES["9006"]["title"] = "NUC MED TCHNO SR PD"
    TITLE_CODES["9006"]["program"] = "PSS"
    TITLE_CODES["9006"]["unit"] = "HX"

    TITLE_CODES["9310"] = {}
    TITLE_CODES["9310"]["title"] = "CLIN LIC SOCIAL WORKER PD"
    TITLE_CODES["9310"]["program"] = "PSS"
    TITLE_CODES["9310"]["unit"] = "HX"

    TITLE_CODES["7272"] = {}
    TITLE_CODES["7272"]["title"] = "ANL 7 SUPV"
    TITLE_CODES["7272"]["program"] = "PSS"
    TITLE_CODES["7272"]["unit"] = "99"

    TITLE_CODES["3509"] = {}
    TITLE_CODES["3509"]["title"] = "COORD PUBLIC PROG IV"
    TITLE_CODES["3509"]["program"] = "ACADEMIC"
    TITLE_CODES["3509"]["unit"] = "FX"

    TITLE_CODES["0845"] = {}
    TITLE_CODES["0845"]["title"] = "ACADEMIC COORD III-FY"
    TITLE_CODES["0845"]["program"] = "ACADEMIC"
    TITLE_CODES["0845"]["unit"] = "99"

    TITLE_CODES["0844"] = {}
    TITLE_CODES["0844"]["title"] = "ACADEMIC COORD III-AY"
    TITLE_CODES["0844"]["program"] = "ACADEMIC"
    TITLE_CODES["0844"]["unit"] = "99"

    TITLE_CODES["0843"] = {}
    TITLE_CODES["0843"]["title"] = "ACADEMIC COORD II-FY"
    TITLE_CODES["0843"]["program"] = "ACADEMIC"
    TITLE_CODES["0843"]["unit"] = "99"

    TITLE_CODES["0842"] = {}
    TITLE_CODES["0842"]["title"] = "ACADEMIC COORD II-AY"
    TITLE_CODES["0842"]["program"] = "ACADEMIC"
    TITLE_CODES["0842"]["unit"] = "99"

    TITLE_CODES["0841"] = {}
    TITLE_CODES["0841"]["title"] = "ACADEMIC COORD I-FY"
    TITLE_CODES["0841"]["program"] = "ACADEMIC"
    TITLE_CODES["0841"]["unit"] = "99"

    TITLE_CODES["0840"] = {}
    TITLE_CODES["0840"]["title"] = "ACADEMIC COORD I-AY"
    TITLE_CODES["0840"]["program"] = "ACADEMIC"
    TITLE_CODES["0840"]["unit"] = "99"

    TITLE_CODES["8897"] = {}
    TITLE_CODES["8897"]["title"] = "ANESTHESIA TCHN"
    TITLE_CODES["8897"]["program"] = "PSS"
    TITLE_CODES["8897"]["unit"] = "EX"

    TITLE_CODES["3501"] = {}
    TITLE_CODES["3501"]["title"] = "COORD PUBLIC PROG VIII"
    TITLE_CODES["3501"]["program"] = "ACADEMIC"
    TITLE_CODES["3501"]["unit"] = "FX"

    TITLE_CODES["5081"] = {}
    TITLE_CODES["5081"]["title"] = "MED CTR CUSTODIAN SR PD"
    TITLE_CODES["5081"]["program"] = "PSS"
    TITLE_CODES["5081"]["unit"] = "SX"

    TITLE_CODES["3503"] = {}
    TITLE_CODES["3503"]["title"] = "COORD PUBLIC PROG VII"
    TITLE_CODES["3503"]["program"] = "ACADEMIC"
    TITLE_CODES["3503"]["unit"] = "FX"

    TITLE_CODES["5087"] = {}
    TITLE_CODES["5087"]["title"] = "MED CTR CUSTODIAN"
    TITLE_CODES["5087"]["program"] = "PSS"
    TITLE_CODES["5087"]["unit"] = "SX"

    TITLE_CODES["3505"] = {}
    TITLE_CODES["3505"]["title"] = "COORD PUBLIC PROG VI"
    TITLE_CODES["3505"]["program"] = "ACADEMIC"
    TITLE_CODES["3505"]["unit"] = "FX"

    TITLE_CODES["8891"] = {}
    TITLE_CODES["8891"]["title"] = "EMERGENCY TRAUMA TCHN SR PD"
    TITLE_CODES["8891"]["program"] = "PSS"
    TITLE_CODES["8891"]["unit"] = "EX"

    TITLE_CODES["3507"] = {}
    TITLE_CODES["3507"]["title"] = "COORD PUBLIC PROG V"
    TITLE_CODES["3507"]["program"] = "ACADEMIC"
    TITLE_CODES["3507"]["unit"] = "FX"

    TITLE_CODES["7157"] = {}
    TITLE_CODES["7157"]["title"] = "ENGR SR SUPV"
    TITLE_CODES["7157"]["program"] = "PSS"
    TITLE_CODES["7157"]["unit"] = "99"

    TITLE_CODES["9192"] = {}
    TITLE_CODES["9192"]["title"] = "OPTOMETRIST SR"
    TITLE_CODES["9192"]["program"] = "PSS"
    TITLE_CODES["9192"]["unit"] = "99"

    TITLE_CODES["8976"] = {}
    TITLE_CODES["8976"]["title"] = "HOSP LAB TCHN 1"
    TITLE_CODES["8976"]["program"] = "PSS"
    TITLE_CODES["8976"]["unit"] = "EX"

    TITLE_CODES["7156"] = {}
    TITLE_CODES["7156"]["title"] = "ENGR ASC SUPV"
    TITLE_CODES["7156"]["program"] = "PSS"
    TITLE_CODES["7156"]["unit"] = "99"

    TITLE_CODES["9522"] = {}
    TITLE_CODES["9522"]["title"] = "ANIMAL RESC SUPV"
    TITLE_CODES["9522"]["program"] = "PSS"
    TITLE_CODES["9522"]["unit"] = "99"

    TITLE_CODES["3220"] = {}
    TITLE_CODES["3220"]["title"] = "ASST RES-FY"
    TITLE_CODES["3220"]["program"] = "ACADEMIC"
    TITLE_CODES["3220"]["unit"] = "FX"

    TITLE_CODES["7155"] = {}
    TITLE_CODES["7155"]["title"] = "ENGR JR"
    TITLE_CODES["7155"]["program"] = "PSS"
    TITLE_CODES["7155"]["unit"] = "99"

    TITLE_CODES["9194"] = {}
    TITLE_CODES["9194"]["title"] = "OPTICIAN"
    TITLE_CODES["9194"]["program"] = "PSS"
    TITLE_CODES["9194"]["unit"] = "EX"

    TITLE_CODES["8544"] = {}
    TITLE_CODES["8544"]["title"] = "FARM SEASONAL WORKER PD"
    TITLE_CODES["8544"]["program"] = "PSS"
    TITLE_CODES["8544"]["unit"] = "SX"

    TITLE_CODES["5049"] = {}
    TITLE_CODES["5049"]["title"] = "MED CTR FOOD SVC MGR 3"
    TITLE_CODES["5049"]["program"] = "PSS"
    TITLE_CODES["5049"]["unit"] = "99"

    TITLE_CODES["7153"] = {}
    TITLE_CODES["7153"]["title"] = "ENGR ASC"
    TITLE_CODES["7153"]["program"] = "PSS"
    TITLE_CODES["7153"]["unit"] = "99"

    TITLE_CODES["8900"] = {}
    TITLE_CODES["8900"]["title"] = "ANESTHESIA TCHN 2 PD"
    TITLE_CODES["8900"]["program"] = "PSS"
    TITLE_CODES["8900"]["unit"] = "EX"

    TITLE_CODES["7231"] = {}
    TITLE_CODES["7231"]["title"] = "SURVEY SUPV"
    TITLE_CODES["7231"]["program"] = "PSS"
    TITLE_CODES["7231"]["unit"] = "99"

    TITLE_CODES["7152"] = {}
    TITLE_CODES["7152"]["title"] = "ENGR SR"
    TITLE_CODES["7152"]["program"] = "PSS"
    TITLE_CODES["7152"]["unit"] = "99"

    TITLE_CODES["5331"] = {}
    TITLE_CODES["5331"]["title"] = "PARKING SUPV SR"
    TITLE_CODES["5331"]["program"] = "PSS"
    TITLE_CODES["5331"]["unit"] = "99"

    TITLE_CODES["5330"] = {}
    TITLE_CODES["5330"]["title"] = "PARKING SUPV PRN"
    TITLE_CODES["5330"]["program"] = "PSS"
    TITLE_CODES["5330"]["unit"] = "99"

    TITLE_CODES["5333"] = {}
    TITLE_CODES["5333"]["title"] = "PARKING REPR SR"
    TITLE_CODES["5333"]["program"] = "PSS"
    TITLE_CODES["5333"]["unit"] = "SX"

    TITLE_CODES["5332"] = {}
    TITLE_CODES["5332"]["title"] = "PARKING REPR LD"
    TITLE_CODES["5332"]["program"] = "PSS"
    TITLE_CODES["5332"]["unit"] = "SX"

    TITLE_CODES["5335"] = {}
    TITLE_CODES["5335"]["title"] = "PARKING AST"
    TITLE_CODES["5335"]["program"] = "PSS"
    TITLE_CODES["5335"]["unit"] = "SX"

    TITLE_CODES["5334"] = {}
    TITLE_CODES["5334"]["title"] = "PARKING REPR"
    TITLE_CODES["5334"]["program"] = "PSS"
    TITLE_CODES["5334"]["unit"] = "SX"

    TITLE_CODES["5337"] = {}
    TITLE_CODES["5337"]["title"] = "PARKING REPR SR SUPV"
    TITLE_CODES["5337"]["program"] = "PSS"
    TITLE_CODES["5337"]["unit"] = "99"

    TITLE_CODES["8005"] = {}
    TITLE_CODES["8005"]["title"] = "PHYSCN AST SUPV"
    TITLE_CODES["8005"]["program"] = "PSS"
    TITLE_CODES["8005"]["unit"] = "99"

    TITLE_CODES["5339"] = {}
    TITLE_CODES["5339"]["title"] = "PARKING SUPV"
    TITLE_CODES["5339"]["program"] = "PSS"
    TITLE_CODES["5339"]["unit"] = "99"

    TITLE_CODES["3223"] = {}
    TITLE_CODES["3223"]["title"] = "ASST RES-AY"
    TITLE_CODES["3223"]["program"] = "ACADEMIC"
    TITLE_CODES["3223"]["unit"] = "FX"

    TITLE_CODES["7150"] = {}
    TITLE_CODES["7150"]["title"] = "ENGR SUPV"
    TITLE_CODES["7150"]["program"] = "PSS"
    TITLE_CODES["7150"]["unit"] = "99"

    TITLE_CODES["1630"] = {}
    TITLE_CODES["1630"]["title"] = "LECT-AY"
    TITLE_CODES["1630"]["program"] = "ACADEMIC"
    TITLE_CODES["1630"]["unit"] = "IX"

    TITLE_CODES["1631"] = {}
    TITLE_CODES["1631"]["title"] = "LECT-AY-CONTINUING"
    TITLE_CODES["1631"]["program"] = "ACADEMIC"
    TITLE_CODES["1631"]["unit"] = "IX"

    TITLE_CODES["1632"] = {}
    TITLE_CODES["1632"]["title"] = "LECT-AY-1/9"
    TITLE_CODES["1632"]["program"] = "ACADEMIC"
    TITLE_CODES["1632"]["unit"] = "IX"

    TITLE_CODES["1633"] = {}
    TITLE_CODES["1633"]["title"] = "LECT-AY-1/9-CONTINUING"
    TITLE_CODES["1633"]["program"] = "ACADEMIC"
    TITLE_CODES["1633"]["unit"] = "IX"

    TITLE_CODES["1634"] = {}
    TITLE_CODES["1634"]["title"] = "LECT-FY"
    TITLE_CODES["1634"]["program"] = "ACADEMIC"
    TITLE_CODES["1634"]["unit"] = "IX"

    TITLE_CODES["1635"] = {}
    TITLE_CODES["1635"]["title"] = "LECT-FY-CONTINUING"
    TITLE_CODES["1635"]["program"] = "ACADEMIC"
    TITLE_CODES["1635"]["unit"] = "IX"

    TITLE_CODES["1981"] = {}
    TITLE_CODES["1981"]["title"] = "RES-AY-B/E/E"
    TITLE_CODES["1981"]["program"] = "ACADEMIC"
    TITLE_CODES["1981"]["unit"] = "FX"

    TITLE_CODES["1731"] = {}
    TITLE_CODES["1731"]["title"] = "HS CLIN INSTR-HCOMP"
    TITLE_CODES["1731"]["program"] = "ACADEMIC"
    TITLE_CODES["1731"]["unit"] = "99"

    TITLE_CODES["1730"] = {}
    TITLE_CODES["1730"]["title"] = "ADJ PROF-HCOMP"
    TITLE_CODES["1730"]["program"] = "ACADEMIC"
    TITLE_CODES["1730"]["unit"] = "99"

    TITLE_CODES["1733"] = {}
    TITLE_CODES["1733"]["title"] = "HS ASSOC CLIN PROF-HCOMP"
    TITLE_CODES["1733"]["program"] = "ACADEMIC"
    TITLE_CODES["1733"]["unit"] = "99"

    TITLE_CODES["1732"] = {}
    TITLE_CODES["1732"]["title"] = "HS ASST CLIN PROF-HCOMP"
    TITLE_CODES["1732"]["program"] = "ACADEMIC"
    TITLE_CODES["1732"]["unit"] = "99"

    TITLE_CODES["1735"] = {}
    TITLE_CODES["1735"]["title"] = "INSTRUCTOR-GENCOMP-B"
    TITLE_CODES["1735"]["program"] = "ACADEMIC"
    TITLE_CODES["1735"]["unit"] = "A3"

    TITLE_CODES["1734"] = {}
    TITLE_CODES["1734"]["title"] = "HS CLIN PROF-HCOMP"
    TITLE_CODES["1734"]["program"] = "ACADEMIC"
    TITLE_CODES["1734"]["unit"] = "99"

    TITLE_CODES["1737"] = {}
    TITLE_CODES["1737"]["title"] = "ASSISTANT PROF-GENCOMP-B"
    TITLE_CODES["1737"]["program"] = "ACADEMIC"
    TITLE_CODES["1737"]["unit"] = "A3"

    TITLE_CODES["1989"] = {}
    TITLE_CODES["1989"]["title"] = "ASST RES-FY-B/E/E"
    TITLE_CODES["1989"]["program"] = "ACADEMIC"
    TITLE_CODES["1989"]["unit"] = "FX"

    TITLE_CODES["9214"] = {}
    TITLE_CODES["9214"]["title"] = "MED OFC SVC CRD 3"
    TITLE_CODES["9214"]["program"] = "PSS"
    TITLE_CODES["9214"]["unit"] = "EX"

    TITLE_CODES["9215"] = {}
    TITLE_CODES["9215"]["title"] = "MED OFC SVC CRD 3 SUPV"
    TITLE_CODES["9215"]["program"] = "PSS"
    TITLE_CODES["9215"]["unit"] = "99"

    TITLE_CODES["9166"] = {}
    TITLE_CODES["9166"]["title"] = "OPERATING ROOM AST 2"
    TITLE_CODES["9166"]["program"] = "PSS"
    TITLE_CODES["9166"]["unit"] = "EX"

    TITLE_CODES["8793"] = {}
    TITLE_CODES["8793"]["title"] = "SURGICAL TCHN PRN"
    TITLE_CODES["8793"]["program"] = "PSS"
    TITLE_CODES["8793"]["unit"] = "EX"

    TITLE_CODES["0753"] = {}
    TITLE_CODES["0753"]["title"] = "BUYER PRN"
    TITLE_CODES["0753"]["program"] = "MSP"
    TITLE_CODES["0753"]["unit"] = "99"

    TITLE_CODES["0752"] = {}
    TITLE_CODES["0752"]["title"] = "MARINE SUPT"
    TITLE_CODES["0752"]["program"] = "MSP"
    TITLE_CODES["0752"]["unit"] = "99"

    TITLE_CODES["0751"] = {}
    TITLE_CODES["0751"]["title"] = "PERSONNEL ANL PRN 2"
    TITLE_CODES["0751"]["program"] = "MSP"
    TITLE_CODES["0751"]["unit"] = "99"

    TITLE_CODES["0757"] = {}
    TITLE_CODES["0757"]["title"] = "MARINE SUPT AST"
    TITLE_CODES["0757"]["program"] = "MSP"
    TITLE_CODES["0757"]["unit"] = "99"

    TITLE_CODES["0756"] = {}
    TITLE_CODES["0756"]["title"] = "SEA CAPTAIN"
    TITLE_CODES["0756"]["program"] = "MSP"
    TITLE_CODES["0756"]["unit"] = "99"

    TITLE_CODES["0755"] = {}
    TITLE_CODES["0755"]["title"] = "PHYS PLT ADM AST"
    TITLE_CODES["0755"]["program"] = "MSP"
    TITLE_CODES["0755"]["unit"] = "99"

    TITLE_CODES["0754"] = {}
    TITLE_CODES["0754"]["title"] = "SEA CAPTAIN SR"
    TITLE_CODES["0754"]["program"] = "MSP"
    TITLE_CODES["0754"]["unit"] = "99"

    TITLE_CODES["0759"] = {}
    TITLE_CODES["0759"]["title"] = "CLIN LAB MGR"
    TITLE_CODES["0759"]["program"] = "MSP"
    TITLE_CODES["0759"]["unit"] = "99"

    TITLE_CODES["0736"] = {}
    TITLE_CODES["0736"]["title"] = "PROGR ANL 5"
    TITLE_CODES["0736"]["program"] = "MSP"
    TITLE_CODES["0736"]["unit"] = "99"

    TITLE_CODES["8998"] = {}
    TITLE_CODES["8998"]["title"] = "CYTO TCHNO PD"
    TITLE_CODES["8998"]["program"] = "PSS"
    TITLE_CODES["8998"]["unit"] = "HX"

    TITLE_CODES["3070"] = {}
    TITLE_CODES["3070"]["title"] = "ASSOC AGRON AES-AY"
    TITLE_CODES["3070"]["program"] = "ACADEMIC"
    TITLE_CODES["3070"]["unit"] = "FX"

    TITLE_CODES["0739"] = {}
    TITLE_CODES["0739"]["title"] = "PROGR ANL 4 SUPV"
    TITLE_CODES["0739"]["program"] = "MSP"
    TITLE_CODES["0739"]["unit"] = "99"

    TITLE_CODES["3072"] = {}
    TITLE_CODES["3072"]["title"] = "ASSOC AGRON AES-AY-B/E/E"
    TITLE_CODES["3072"]["program"] = "ACADEMIC"
    TITLE_CODES["3072"]["unit"] = "FX"

    TITLE_CODES["3073"] = {}
    TITLE_CODES["3073"]["title"] = "ASO---IN AES-B/ECON/ENG/AY-1/9"
    TITLE_CODES["3073"]["program"] = "ACADEMIC"
    TITLE_CODES["3073"]["unit"] = "FX"

    TITLE_CODES["3074"] = {}
    TITLE_CODES["3074"]["title"] = "ACT ASSOC AGRON AES-AY"
    TITLE_CODES["3074"]["program"] = "ACADEMIC"
    TITLE_CODES["3074"]["unit"] = "99"

    TITLE_CODES["3075"] = {}
    TITLE_CODES["3075"]["title"] = "ACT ASO---IN THE AES-AY-1/9"
    TITLE_CODES["3075"]["program"] = "ACADEMIC"
    TITLE_CODES["3075"]["unit"] = "99"

    TITLE_CODES["3076"] = {}
    TITLE_CODES["3076"]["title"] = "ACT ASSOC AGRON AES-B/E/E-AY"
    TITLE_CODES["3076"]["program"] = "ACADEMIC"
    TITLE_CODES["3076"]["unit"] = "99"

    TITLE_CODES["0738"] = {}
    TITLE_CODES["0738"]["title"] = "PROGR ANL 4"
    TITLE_CODES["0738"]["program"] = "MSP"
    TITLE_CODES["0738"]["unit"] = "99"

    TITLE_CODES["7649"] = {}
    TITLE_CODES["7649"]["title"] = "HR ANL 4"
    TITLE_CODES["7649"]["program"] = "PSS"
    TITLE_CODES["7649"]["unit"] = "99"

    TITLE_CODES["7648"] = {}
    TITLE_CODES["7648"]["title"] = "HR ANL 3"
    TITLE_CODES["7648"]["program"] = "PSS"
    TITLE_CODES["7648"]["unit"] = "99"

    TITLE_CODES["1030"] = {}
    TITLE_CODES["1030"]["title"] = "DIVISIONAL DEAN"
    TITLE_CODES["1030"]["program"] = "ACADEMIC"
    TITLE_CODES["1030"]["unit"] = "99"

    TITLE_CODES["8541"] = {}
    TITLE_CODES["8541"]["title"] = "AGRICULTURAL TCHN SR"
    TITLE_CODES["8541"]["program"] = "PSS"
    TITLE_CODES["8541"]["unit"] = "SX"

    TITLE_CODES["1027"] = {}
    TITLE_CODES["1027"]["title"] = "ACT/INTERIM ASSISTANT DEAN"
    TITLE_CODES["1027"]["program"] = "ACADEMIC"
    TITLE_CODES["1027"]["unit"] = "99"

    TITLE_CODES["1020"] = {}
    TITLE_CODES["1020"]["title"] = "ASST DEAN"
    TITLE_CODES["1020"]["program"] = "ACADEMIC"
    TITLE_CODES["1020"]["unit"] = "99"

    TITLE_CODES["1188"] = {}
    TITLE_CODES["1188"]["title"] = "VST PROFESSOR-LAW SCHOOL SCALE"
    TITLE_CODES["1188"]["program"] = "ACADEMIC"
    TITLE_CODES["1188"]["unit"] = "99"

    TITLE_CODES["3378"] = {}
    TITLE_CODES["3378"]["title"] = "ADJ PROF-FY-B/E/E"
    TITLE_CODES["3378"]["program"] = "ACADEMIC"
    TITLE_CODES["3378"]["unit"] = "99"

    TITLE_CODES["3377"] = {}
    TITLE_CODES["3377"]["title"] = "ADJ PROF-AY-B/E/E"
    TITLE_CODES["3377"]["program"] = "ACADEMIC"
    TITLE_CODES["3377"]["unit"] = "99"

    TITLE_CODES["3376"] = {}
    TITLE_CODES["3376"]["title"] = "ASSOC ADJ PROF-AY-1/9-B/E/E"
    TITLE_CODES["3376"]["program"] = "ACADEMIC"
    TITLE_CODES["3376"]["unit"] = "99"

    TITLE_CODES["3375"] = {}
    TITLE_CODES["3375"]["title"] = "ASSOC ADJ PROF-FY-B/E/E"
    TITLE_CODES["3375"]["program"] = "ACADEMIC"
    TITLE_CODES["3375"]["unit"] = "99"

    TITLE_CODES["3374"] = {}
    TITLE_CODES["3374"]["title"] = "ASSOC ADJ PROF-AY-B/E/E"
    TITLE_CODES["3374"]["program"] = "ACADEMIC"
    TITLE_CODES["3374"]["unit"] = "99"

    TITLE_CODES["1182"] = {}
    TITLE_CODES["1182"]["title"] = "ACT PROF-AY-LAW"
    TITLE_CODES["1182"]["program"] = "ACADEMIC"
    TITLE_CODES["1182"]["unit"] = "A3"

    TITLE_CODES["1183"] = {}
    TITLE_CODES["1183"]["title"] = "ACT PROF-AY-1/9-LAW"
    TITLE_CODES["1183"]["program"] = "ACADEMIC"
    TITLE_CODES["1183"]["unit"] = "A3"

    TITLE_CODES["1180"] = {}
    TITLE_CODES["1180"]["title"] = "PROF-AY-LAW"
    TITLE_CODES["1180"]["program"] = "ACADEMIC"
    TITLE_CODES["1180"]["unit"] = "A3"

    TITLE_CODES["1037"] = {}
    TITLE_CODES["1037"]["title"] = "ACT/INTERIM DIVISIONAL DEAN"
    TITLE_CODES["1037"]["program"] = "ACADEMIC"
    TITLE_CODES["1037"]["unit"] = "99"

    TITLE_CODES["0726"] = {}
    TITLE_CODES["0726"]["title"] = "PERFUSIONIST PRN"
    TITLE_CODES["0726"]["program"] = "MSP"
    TITLE_CODES["0726"]["unit"] = "99"

    TITLE_CODES["0727"] = {}
    TITLE_CODES["0727"]["title"] = "ENGR PRN"
    TITLE_CODES["0727"]["program"] = "MSP"
    TITLE_CODES["0727"]["unit"] = "99"

    TITLE_CODES["0725"] = {}
    TITLE_CODES["0725"]["title"] = "EHS SPEC PRN"
    TITLE_CODES["0725"]["program"] = "MSP"
    TITLE_CODES["0725"]["unit"] = "99"

    TITLE_CODES["1748"] = {}
    TITLE_CODES["1748"]["title"] = "ASST ADJUNCT PROF-GENCOMP-B"
    TITLE_CODES["1748"]["program"] = "ACADEMIC"
    TITLE_CODES["1748"]["unit"] = "99"

    TITLE_CODES["0723"] = {}
    TITLE_CODES["0723"]["title"] = "CONST INSP PRN"
    TITLE_CODES["0723"]["program"] = "MSP"
    TITLE_CODES["0723"]["unit"] = "99"

    TITLE_CODES["0721"] = {}
    TITLE_CODES["0721"]["title"] = "PLANNER PRN"
    TITLE_CODES["0721"]["program"] = "MSP"
    TITLE_CODES["0721"]["unit"] = "99"

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

    TITLE_CODES["0728"] = {}
    TITLE_CODES["0728"]["title"] = "DEV ENGR SR"
    TITLE_CODES["0728"]["program"] = "MSP"
    TITLE_CODES["0728"]["unit"] = "99"

    TITLE_CODES["0729"] = {}
    TITLE_CODES["0729"]["title"] = "DEV ENGR PRN"
    TITLE_CODES["0729"]["program"] = "MSP"
    TITLE_CODES["0729"]["unit"] = "99"

    TITLE_CODES["8170"] = {}
    TITLE_CODES["8170"]["title"] = "PHYS PLT MECH SUPV"
    TITLE_CODES["8170"]["program"] = "PSS"
    TITLE_CODES["8170"]["unit"] = "99"

    TITLE_CODES["7290"] = {}
    TITLE_CODES["7290"]["title"] = "PROGR 1 SUPV"
    TITLE_CODES["7290"]["program"] = "PSS"
    TITLE_CODES["7290"]["unit"] = "99"

    TITLE_CODES["8172"] = {}
    TITLE_CODES["8172"]["title"] = "PHYS PLT MECH SR"
    TITLE_CODES["8172"]["program"] = "PSS"
    TITLE_CODES["8172"]["unit"] = "K3"

    TITLE_CODES["8173"] = {}
    TITLE_CODES["8173"]["title"] = "PHYS PLT MECH LD"
    TITLE_CODES["8173"]["program"] = "PSS"
    TITLE_CODES["8173"]["unit"] = "K3"

    TITLE_CODES["1209"] = {}
    TITLE_CODES["1209"]["title"] = "ASSOC PROF-RECALLED-AY-1/9TH"
    TITLE_CODES["1209"]["program"] = "ACADEMIC"
    TITLE_CODES["1209"]["unit"] = "A3"

    TITLE_CODES["1208"] = {}
    TITLE_CODES["1208"]["title"] = "VIS ASSOC PROF"
    TITLE_CODES["1208"]["program"] = "ACADEMIC"
    TITLE_CODES["1208"]["unit"] = "99"

    TITLE_CODES["9132"] = {}
    TITLE_CODES["9132"]["title"] = "ADMIN NURSE 3"
    TITLE_CODES["9132"]["program"] = "PSS"
    TITLE_CODES["9132"]["unit"] = "99"

    TITLE_CODES["1205"] = {}
    TITLE_CODES["1205"]["title"] = "ASSOC PROF-FAC EARLY RETIR PGM"
    TITLE_CODES["1205"]["program"] = "ACADEMIC"
    TITLE_CODES["1205"]["unit"] = "A3"

    TITLE_CODES["1207"] = {}
    TITLE_CODES["1207"]["title"] = "ACT ASSOC PROF-AY"
    TITLE_CODES["1207"]["program"] = "ACADEMIC"
    TITLE_CODES["1207"]["unit"] = "A3"

    TITLE_CODES["1206"] = {}
    TITLE_CODES["1206"]["title"] = "ASSOC PROFESSOR-AY-RECALLED"
    TITLE_CODES["1206"]["program"] = "ACADEMIC"
    TITLE_CODES["1206"]["unit"] = "A3"

    TITLE_CODES["1201"] = {}
    TITLE_CODES["1201"]["title"] = "ACT ASSOC PROF-AY-1/9"
    TITLE_CODES["1201"]["program"] = "ACADEMIC"
    TITLE_CODES["1201"]["unit"] = "A3"

    TITLE_CODES["1200"] = {}
    TITLE_CODES["1200"]["title"] = "ASSOC PROF-AY"
    TITLE_CODES["1200"]["program"] = "ACADEMIC"
    TITLE_CODES["1200"]["unit"] = "A3"

    TITLE_CODES["1203"] = {}
    TITLE_CODES["1203"]["title"] = "ASSOC PROF-AY-1/9"
    TITLE_CODES["1203"]["program"] = "ACADEMIC"
    TITLE_CODES["1203"]["unit"] = "A3"

    TITLE_CODES["1202"] = {}
    TITLE_CODES["1202"]["title"] = "VST ASSOC PROFESSOR-AY-1/9TH"
    TITLE_CODES["1202"]["program"] = "ACADEMIC"
    TITLE_CODES["1202"]["unit"] = "99"

    TITLE_CODES["5061"] = {}
    TITLE_CODES["5061"]["title"] = "STOREKEEPER LD"
    TITLE_CODES["5061"]["program"] = "PSS"
    TITLE_CODES["5061"]["unit"] = "SX"

    TITLE_CODES["5521"] = {}
    TITLE_CODES["5521"]["title"] = "COOK PRN"
    TITLE_CODES["5521"]["program"] = "PSS"
    TITLE_CODES["5521"]["unit"] = "99"

    TITLE_CODES["5522"] = {}
    TITLE_CODES["5522"]["title"] = "COOK SR"
    TITLE_CODES["5522"]["program"] = "PSS"
    TITLE_CODES["5522"]["unit"] = "SX"

    TITLE_CODES["5523"] = {}
    TITLE_CODES["5523"]["title"] = "COOK"
    TITLE_CODES["5523"]["program"] = "PSS"
    TITLE_CODES["5523"]["unit"] = "SX"

    TITLE_CODES["5524"] = {}
    TITLE_CODES["5524"]["title"] = "COOK AST"
    TITLE_CODES["5524"]["program"] = "PSS"
    TITLE_CODES["5524"]["unit"] = "SX"

    TITLE_CODES["8994"] = {}
    TITLE_CODES["8994"]["title"] = "MED AST 2"
    TITLE_CODES["8994"]["program"] = "PSS"
    TITLE_CODES["8994"]["unit"] = "EX"

    TITLE_CODES["5526"] = {}
    TITLE_CODES["5526"]["title"] = "COOK SR SUPV"
    TITLE_CODES["5526"]["program"] = "PSS"
    TITLE_CODES["5526"]["unit"] = "99"

    TITLE_CODES["7130"] = {}
    TITLE_CODES["7130"]["title"] = "EHS SPEC 1 SUPV"
    TITLE_CODES["7130"]["program"] = "PSS"
    TITLE_CODES["7130"]["unit"] = "99"

    TITLE_CODES["9137"] = {}
    TITLE_CODES["9137"]["title"] = "CLIN NURSE 4"
    TITLE_CODES["9137"]["program"] = "PSS"
    TITLE_CODES["9137"]["unit"] = "NX"

    TITLE_CODES["8988"] = {}
    TITLE_CODES["8988"]["title"] = "CYTOGENETIC TCHNO 1"
    TITLE_CODES["8988"]["program"] = "PSS"
    TITLE_CODES["8988"]["unit"] = "EX"

    TITLE_CODES["8995"] = {}
    TITLE_CODES["8995"]["title"] = "MED AST 2 SUPV"
    TITLE_CODES["8995"]["program"] = "PSS"
    TITLE_CODES["8995"]["unit"] = "99"

    TITLE_CODES["8273"] = {}
    TITLE_CODES["8273"]["title"] = "ACCELERATOR OPR"
    TITLE_CODES["8273"]["program"] = "PSS"
    TITLE_CODES["8273"]["unit"] = "TX"

    TITLE_CODES["7133"] = {}
    TITLE_CODES["7133"]["title"] = "EHS SPEC 1 EX"
    TITLE_CODES["7133"]["program"] = "PSS"
    TITLE_CODES["7133"]["unit"] = "99"

    TITLE_CODES["8271"] = {}
    TITLE_CODES["8271"]["title"] = "ACCELERATOR OPR PRN"
    TITLE_CODES["8271"]["program"] = "PSS"
    TITLE_CODES["8271"]["unit"] = "99"

    TITLE_CODES["1217"] = {}
    TITLE_CODES["1217"]["title"] = "ACT ASSOC PROF-FY"
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
    TITLE_CODES["8899"]["title"] = "ANESTHESIA TCHN PD"
    TITLE_CODES["8899"]["program"] = "PSS"
    TITLE_CODES["8899"]["unit"] = "EX"

    TITLE_CODES["0044"] = {}
    TITLE_CODES["0044"]["title"] = "DEPUTY ASC VP"
    TITLE_CODES["0044"]["program"] = "MSP"
    TITLE_CODES["0044"]["unit"] = "99"

    TITLE_CODES["0045"] = {}
    TITLE_CODES["0045"]["title"] = "AST VP FUNC AREA"
    TITLE_CODES["0045"]["program"] = "MSP"
    TITLE_CODES["0045"]["unit"] = "99"

    TITLE_CODES["0042"] = {}
    TITLE_CODES["0042"]["title"] = "PROVOST FUNC AREA"
    TITLE_CODES["0042"]["program"] = "MSP"
    TITLE_CODES["0042"]["unit"] = "99"

    TITLE_CODES["0043"] = {}
    TITLE_CODES["0043"]["title"] = "DEPUTY AST VP"
    TITLE_CODES["0043"]["program"] = "MSP"
    TITLE_CODES["0043"]["unit"] = "99"

    TITLE_CODES["0040"] = {}
    TITLE_CODES["0040"]["title"] = "UNIV PROVOST"
    TITLE_CODES["0040"]["program"] = "MSP"
    TITLE_CODES["0040"]["unit"] = "99"

    TITLE_CODES["9019"] = {}
    TITLE_CODES["9019"]["title"] = "RADLG TCHNO CHF"
    TITLE_CODES["9019"]["program"] = "PSS"
    TITLE_CODES["9019"]["unit"] = "99"

    TITLE_CODES["1111"] = {}
    TITLE_CODES["1111"]["title"] = "____-SENATE-AY-RECALLED-VERIP"
    TITLE_CODES["1111"]["program"] = "ACADEMIC"
    TITLE_CODES["1111"]["unit"] = "A3"

    TITLE_CODES["1110"] = {}
    TITLE_CODES["1110"]["title"] = "PROF-FY"
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
    TITLE_CODES["9219"]["title"] = "STERILE PROCESSING TCHN 3"
    TITLE_CODES["9219"]["program"] = "PSS"
    TITLE_CODES["9219"]["unit"] = "EX"

    TITLE_CODES["1114"] = {}
    TITLE_CODES["1114"]["title"] = " ---GENCOMP-RECALLED-VERIP"
    TITLE_CODES["1114"]["program"] = "ACADEMIC"
    TITLE_CODES["1114"]["unit"] = "A3"

    TITLE_CODES["1117"] = {}
    TITLE_CODES["1117"]["title"] = "ACT PROF-FY"
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
    TITLE_CODES["1564"]["title"] = "ACT ASST PROF-HCOMP"
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
    TITLE_CODES["9153"]["title"] = "MENTAL HEALTH THER SUPV"
    TITLE_CODES["9153"]["program"] = "PSS"
    TITLE_CODES["9153"]["unit"] = "HX"

    TITLE_CODES["1713"] = {}
    TITLE_CODES["1713"]["title"] = "VIS ASSOC PROF-HCOMP"
    TITLE_CODES["1713"]["program"] = "ACADEMIC"
    TITLE_CODES["1713"]["unit"] = "99"

    TITLE_CODES["1712"] = {}
    TITLE_CODES["1712"]["title"] = "VIS ASST PROF-HCOMP"
    TITLE_CODES["1712"]["program"] = "ACADEMIC"
    TITLE_CODES["1712"]["unit"] = "99"

    TITLE_CODES["1782"] = {}
    TITLE_CODES["1782"]["title"] = "ACT PROFESSOR-FY-MEDCOMP"
    TITLE_CODES["1782"]["program"] = "ACADEMIC"
    TITLE_CODES["1782"]["unit"] = "A3"

    TITLE_CODES["8109"] = {}
    TITLE_CODES["8109"]["title"] = "CARPENTER LD"
    TITLE_CODES["8109"]["program"] = "PSS"
    TITLE_CODES["8109"]["unit"] = "K3"

    TITLE_CODES["8487"] = {}
    TITLE_CODES["8487"]["title"] = "AUTO EQUIP OPR"
    TITLE_CODES["8487"]["program"] = "PSS"
    TITLE_CODES["8487"]["unit"] = "SX"

    TITLE_CODES["1711"] = {}
    TITLE_CODES["1711"]["title"] = "VISITING INSTRUCTOR-HCOMP"
    TITLE_CODES["1711"]["program"] = "ACADEMIC"
    TITLE_CODES["1711"]["unit"] = "99"

    TITLE_CODES["8004"] = {}
    TITLE_CODES["8004"]["title"] = "CYTO TCHNO SR SUPV"
    TITLE_CODES["8004"]["program"] = "PSS"
    TITLE_CODES["8004"]["unit"] = "99"

    TITLE_CODES["1717"] = {}
    TITLE_CODES["1717"]["title"] = "ASST PROF-HCOMP"
    TITLE_CODES["1717"]["program"] = "ACADEMIC"
    TITLE_CODES["1717"]["unit"] = "A3"

    TITLE_CODES["8006"] = {}
    TITLE_CODES["8006"]["title"] = "PHYSCN AST SR SUPV"
    TITLE_CODES["8006"]["program"] = "PSS"
    TITLE_CODES["8006"]["unit"] = "99"

    TITLE_CODES["8007"] = {}
    TITLE_CODES["8007"]["title"] = "STAFF PHARMACIST 1 SUPV"
    TITLE_CODES["8007"]["program"] = "PSS"
    TITLE_CODES["8007"]["unit"] = "99"

    TITLE_CODES["8000"] = {}
    TITLE_CODES["8000"]["title"] = "CLIN LAB SCI SUPV"
    TITLE_CODES["8000"]["program"] = "PSS"
    TITLE_CODES["8000"]["unit"] = "99"

    TITLE_CODES["8001"] = {}
    TITLE_CODES["8001"]["title"] = "CLIN LAB SCI SPEC SUPV"
    TITLE_CODES["8001"]["program"] = "PSS"
    TITLE_CODES["8001"]["unit"] = "99"

    TITLE_CODES["8002"] = {}
    TITLE_CODES["8002"]["title"] = "CLIN LAB SCI SPEC SR SUPV"
    TITLE_CODES["8002"]["program"] = "PSS"
    TITLE_CODES["8002"]["unit"] = "99"

    TITLE_CODES["8003"] = {}
    TITLE_CODES["8003"]["title"] = "CYTO TCHNO SUPV"
    TITLE_CODES["8003"]["program"] = "PSS"
    TITLE_CODES["8003"]["unit"] = "99"

    TITLE_CODES["1715"] = {}
    TITLE_CODES["1715"]["title"] = "INSTR-HCOMP"
    TITLE_CODES["1715"]["program"] = "ACADEMIC"
    TITLE_CODES["1715"]["unit"] = "A3"

    TITLE_CODES["9809"] = {}
    TITLE_CODES["9809"]["title"] = "FIRE SPEC 1 40 HRS"
    TITLE_CODES["9809"]["program"] = "PSS"
    TITLE_CODES["9809"]["unit"] = "FF"

    TITLE_CODES["9808"] = {}
    TITLE_CODES["9808"]["title"] = "FIRE CAPTAIN 40 HRS"
    TITLE_CODES["9808"]["program"] = "PSS"
    TITLE_CODES["9808"]["unit"] = "FF"

    TITLE_CODES["9807"] = {}
    TITLE_CODES["9807"]["title"] = "FIRE SPEC 2 56 HRS"
    TITLE_CODES["9807"]["program"] = "PSS"
    TITLE_CODES["9807"]["unit"] = "FF"

    TITLE_CODES["9806"] = {}
    TITLE_CODES["9806"]["title"] = "FIRE SPEC 1 56 HRS"
    TITLE_CODES["9806"]["program"] = "PSS"
    TITLE_CODES["9806"]["unit"] = "FF"

    TITLE_CODES["9384"] = {}
    TITLE_CODES["9384"]["title"] = "PSYCHOLOGIST 1"
    TITLE_CODES["9384"]["program"] = "PSS"
    TITLE_CODES["9384"]["unit"] = "HX"

    TITLE_CODES["1714"] = {}
    TITLE_CODES["1714"]["title"] = "VIS PROF-HCOMP"
    TITLE_CODES["1714"]["program"] = "ACADEMIC"
    TITLE_CODES["1714"]["unit"] = "99"

    TITLE_CODES["9803"] = {}
    TITLE_CODES["9803"]["title"] = "FIRE CAPTAIN"
    TITLE_CODES["9803"]["program"] = "PSS"
    TITLE_CODES["9803"]["unit"] = "TX"

    TITLE_CODES["6465"] = {}
    TITLE_CODES["6465"]["title"] = "ARTS AND LECTURES SUPV"
    TITLE_CODES["6465"]["program"] = "PSS"
    TITLE_CODES["6465"]["unit"] = "99"

    TITLE_CODES["6466"] = {}
    TITLE_CODES["6466"]["title"] = "ARTS AND LECTURES MGR"
    TITLE_CODES["6466"]["program"] = "PSS"
    TITLE_CODES["6466"]["unit"] = "99"

    TITLE_CODES["4725"] = {}
    TITLE_CODES["4725"]["title"] = "BLANK AST 4"
    TITLE_CODES["4725"]["program"] = "PSS"
    TITLE_CODES["4725"]["unit"] = "CX"

    TITLE_CODES["8483"] = {}
    TITLE_CODES["8483"]["title"] = "DRIVER"
    TITLE_CODES["8483"]["program"] = "PSS"
    TITLE_CODES["8483"]["unit"] = "SX"

    TITLE_CODES["0477"] = {}
    TITLE_CODES["0477"]["title"] = "POLICE LIEUTENANT MSP"
    TITLE_CODES["0477"]["program"] = "MSP"
    TITLE_CODES["0477"]["unit"] = "99"

    TITLE_CODES["8486"] = {}
    TITLE_CODES["8486"]["title"] = "AUTO EQUIP OPR SR"
    TITLE_CODES["8486"]["program"] = "PSS"
    TITLE_CODES["8486"]["unit"] = "SX"

    TITLE_CODES["4724"] = {}
    TITLE_CODES["4724"]["title"] = "BLANK AST 1"
    TITLE_CODES["4724"]["program"] = "PSS"
    TITLE_CODES["4724"]["unit"] = "CX"

    TITLE_CODES["7244"] = {}
    TITLE_CODES["7244"]["title"] = "ADMIN ANL AST"
    TITLE_CODES["7244"]["program"] = "PSS"
    TITLE_CODES["7244"]["unit"] = "99"

    TITLE_CODES["8489"] = {}
    TITLE_CODES["8489"]["title"] = "AUTO EQUIP OPR PRN SUPV"
    TITLE_CODES["8489"]["program"] = "PSS"
    TITLE_CODES["8489"]["unit"] = "99"

    TITLE_CODES["0478"] = {}
    TITLE_CODES["0478"]["title"] = "POLICE CHF"
    TITLE_CODES["0478"]["program"] = "MSP"
    TITLE_CODES["0478"]["unit"] = "99"

    TITLE_CODES["0479"] = {}
    TITLE_CODES["0479"]["title"] = "POLICE CHF AST OR CAPTAIN"
    TITLE_CODES["0479"]["program"] = "MSP"
    TITLE_CODES["0479"]["unit"] = "99"

    TITLE_CODES["8266"] = {}
    TITLE_CODES["8266"]["title"] = "LOCKSMITH"
    TITLE_CODES["8266"]["program"] = "PSS"
    TITLE_CODES["8266"]["unit"] = "K3"

    TITLE_CODES["4727"] = {}
    TITLE_CODES["4727"]["title"] = "BLANK AST 2 SUPV"
    TITLE_CODES["4727"]["program"] = "PSS"
    TITLE_CODES["4727"]["unit"] = "99"

    TITLE_CODES["8269"] = {}
    TITLE_CODES["8269"]["title"] = "CABINET MAKER"
    TITLE_CODES["8269"]["program"] = "PSS"
    TITLE_CODES["8269"]["unit"] = "K3"

end
