module UcdLookups
  MAJORS = {}
  DEPT_CODES = {}
  TITLE_CODES = {}

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
      'UCDHS: PEDS CHILD DEVELOPMENT' => 'CENTER FOR MIND AND BRAIN',
      'UCDHS: PSYCHIATRY AND BEHAVIORAL SCIENCES, DEPT OF' => 'CENTER FOR MIND AND BRAIN',
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

	DEPT_CODES["040000"] = {}
		DEPT_CODES["040000"]["name"] = "L&S DEANS OFC - ADMIN"
		DEPT_CODES["040000"]["company"] = "040003"
		DEPT_CODES["040000"]["manager"] = "irblake"

	DEPT_CODES["040001"] = {}
		DEPT_CODES["040001"]["name"] = "L&S DEANS - DEVELOPMENT"
		DEPT_CODES["040001"]["company"] = "040003"
		DEPT_CODES["040001"]["manager"] = "cmattiso"

	DEPT_CODES["040002"] = {}
		DEPT_CODES["040002"]["name"] = "L&S DEANS - U/G ED & ADVISING"
		DEPT_CODES["040002"]["company"] = "040008"
		DEPT_CODES["040002"]["manager"] = "bfloyd"

	DEPT_CODES["040003"] = {}
		DEPT_CODES["040003"]["name"] = "L&S DEANS - HACS"
		DEPT_CODES["040003"]["company"] = "040003"
		DEPT_CODES["040003"]["manager"] = "irblake"

	DEPT_CODES["040007"] = {}
		DEPT_CODES["040007"]["name"] = "L&S DEANS - MATH/PAHYS SCIENCES"
		DEPT_CODES["040007"]["company"] = "040007"
		DEPT_CODES["040007"]["manager"] = "buzzy"

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

	DEPT_CODES["040117"] = {}
		DEPT_CODES["040117"]["name"] = "CENTER FOR POVERTY RESEARCH"
		DEPT_CODES["040117"]["company"] = "040111"
		DEPT_CODES["040117"]["manager"] = "gsanchez"

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
		DEPT_CODES["040114"]["manager"] = "murrayj"

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

	DEPT_CODES["040116"] = {}
		DEPT_CODES["040116"]["name"] = "Institute for Social Sciences"
		DEPT_CODES["040116"]["company"] = "040111"
		DEPT_CODES["040116"]["manager"] = "keminer"

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

	DEPT_CODES["061826"] = {}
		DEPT_CODES["061826"]["name"] = "NEAT"
		DEPT_CODES["061826"]["company"] = "040007"
		DEPT_CODES["061826"]["manager"] = "raim"

end
