#delimit;

global ly 2018; /* 最新調査年度 */

/*** 家族表　配偶者関連変数 ***/

gen sp=.;			/* 配偶者の有無 */
gen male_sp=.;		/* 性別 */
gen birthy_sp=.;	/* 生まれ年 */
gen age_sp=.;		/* 年齢 */
gen job_sp=.;		/* 就労 */
gen job_sp_j=.;		/* 就労 (K2014～ / J2009～) */
gen dokyo_sp=.;		/* 同居 */
gen mar_sp=.;		/* 有配偶 */
gen edu_sp=.;		/* 最終学歴 */
gen chng_sp=.;		/* 家族関係の変化 */
gen deth_sp=.;		/* 死別 */
gen time1_sp=.;		/* 対象者の家からかかる時間（時間） */
gen time2_sp=.;		/* 対象者の家からかかる時間（分） */
gen time_sp=.;		/* 対象者の家からかかる時間（合計・分） */
gen nocntct_sp=.;	/* 連絡がつかない */
gen samelive_sp=.;	/* 生計を同じにしている */
gen disab_sp=.;		/* 慢性的な日常活動の制限 */
gen handi_sp=.;		/* 要支援・要介護認定／障害支援区分の認定 */

/****************/
/* 2004～2016年 */
/****************/

foreach y of num 2004/2016{;
	local n4a = 3015; /* 就労（K2014～ / J2009～） */
	foreach n0 of num 13(7)69{;	/* 続柄 */
		local n1 = `n0'+1;		/* 性別 */
		local n2 = `n0'+2;		/* 生まれ年 */
		local n3 = `n0'+3;		/* 生まれ月 */
		local n4 = `n0'+4;		/* 就労 */
		local n5 = `n0'+5;		/* 同居・別居 */
		local n6 = `n0'+6;		/* 未既婚 */

		/* 配偶者の有無 */
		replace sp=1 if v`n0'==1 & v`n1'==1 & year==`y';
		
		/* 性別 */
		replace male_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n1'==1; /* 男性 */
		replace male_sp=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n1'==2; /* 女性 */
		
		/* 年齢 */
		replace birthy_sp=v`n2' if v`n0'==1 & v`n1'==1 & year==`y' & v`n2'<7777;					/* 生まれ年 */
		replace age_sp=`y'-v`n2' if v`n0'==1 & v`n1'==1 & year==`y' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
		replace age_sp=`y'-v`n2'-1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
		
		/* 就労 */
		replace job_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n4'==8;		/* 就労 (K2004～K2013) */
		replace job_sp=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n4'!=8;		/* 非就労 (K2004～K2013) */
		replace job_sp_j=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
		replace job_sp_j=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
		local n4a=`n4a'+3;
		
		/* 同居 */
		replace dokyo_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n5'==1; /* 同居 */
		replace dokyo_sp=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n5'==2; /* 別居 */
		
		/* 有配偶 */
		replace mar_sp=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n6'==1; /* 無配偶 */
		replace mar_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n6'==2; /* 有配偶 */
			
		};
	};
	
/**************/
/* 2017年以降 */
/**************/

foreach y of num 2017/$ly{;

	/* 家族ID 2番～10番 */
	
	local n4a = 3015; /* 就労（K2014～ / J2009～） */
	local n7 = 3697;				/* 最終学歴 */
	local n8 = `n7'+1;				/* 家族関係の変化 */
	local n9 = `n7'+2;				/* 配偶関係・婚姻届を出していない */
	local n10 = `n7'+3;				/* 対象者の家からかかる時間（時間） */
	local n11 = `n7'+4;				/* 対象者の家からかかる時間（分） */
	local n12 = `n7'+5;				/* 連絡がつかない */
	local n13 = `n7'+6;				/* 生計を同じにしている */
	local n14 = `n7'+7;				/* 慢性的な日常活動の制限	 */
	local n15 = `n7'+8;				/* 要支援・要介護認定／障害支援区分の認定	 */
	
	foreach n0 of num 13(7)69{;	/* 続柄 */
		local n1 = `n0'+1;		/* 性別 */
		local n2 = `n0'+2;		/* 生まれ年 */
		local n3 = `n0'+3;		/* 生まれ月 */
		local n4 = `n0'+4;		/* 就労 */
		local n5 = `n0'+5;		/* 同居・別居 */
		local n6 = `n0'+6;		/* 未既婚 */

		/* 配偶者の有無 */
		replace sp=1 if v`n0'==1 & v`n1'==1 & year==`y';
		
		/* 性別 */
		replace male_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n1'==1; /* 男性 */
		replace male_sp=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n1'==2; /* 女性 */
		
		/* 年齢 */
		replace birthy_sp=v`n2' if v`n0'==1 & v`n1'==1 & year==`y' & v`n2'<7777;					/* 生まれ年 */
		replace age_sp=`y'-v`n2' if v`n0'==1 & v`n1'==1 & year==`y' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
		replace age_sp=`y'-v`n2'-1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
		
		/* 就労 */
		replace job_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n4'==8;		/* 就労 (K2004～K2013) */
		replace job_sp=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n4'!=8;		/* 非就労 (K2004～K2013) */
		replace job_sp_j=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
		replace job_sp_j=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
		
		/* 同居 */
		replace dokyo_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n5'==1; /* 同居 */
		replace dokyo_sp=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n5'==2; /* 別居 */
		
		/* 有配偶 */
		replace mar_sp=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n6'==1; /* 無配偶 */
		replace mar_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n6'==2; /* 有配偶 */
		
		/* 最終学歴 */
		replace edu_sp=v`n7' if v`n0'==1 & v`n1'==1 & year==`y'; 

		/* 家族関係の変化 */
		replace chng_sp=v`n8' if v`n0'==1 & v`n1'==1 & year==`y';

		/* 家族関係の変化: 死別 */
		replace deth_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n8'==2;					/* 死別 */
		replace deth_sp=0 if v`n0'==1 & v`n1'==1 & year==`y' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

		/* 配偶関係・婚姻届けを出していない */
		replace mar_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n9'==1; /* 事実婚 */

		/* 対象者の家からかかる時間（時間） */
		replace time1_sp= v`n10' if v`n0'==1 & v`n1'==1 & year==`y' & v`n10'<888;

		/* 対象者の家からかかる時間（分） */
		replace time2_sp= v`n11' if v`n0'==1 & v`n1'==1 & year==`y' & v`n11'<888;

		/* 対象者の家からかかる時間（合計・分） */
		replace time_sp= time1_sp*60+time2_sp	if v`n0'==1 & v`n1'==1 & year==`y' & time1_sp!=. & time2_sp!=.;
		replace time_sp= time1_sp*60				if v`n0'==1 & v`n1'==1 & year==`y' & time1_sp!=. & time2_sp==.;
		replace time_sp= time2_sp					if v`n0'==1 & v`n1'==1 & year==`y' & time1_sp==. & time2_sp!=.;

		/* 連絡がつかない */
		replace nocntct_sp= 1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n12'==1; /* 連絡がつかない */
		replace nocntct_sp= 0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n12'==9; /* 該当しない */

		/* 同一生計 */
		replace samelive_sp= 1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n13' ==1; /* 同一家計 */
		replace samelive_sp= 0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n13' ==9; /* 該当しない */

		/* 慢性的な日常生活の制限 disability*/
		replace disab_sp= 1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n14' ==1; /* 制限あり */
		replace disab_sp= 0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n14' ==9; /* 該当しない */

		/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
		replace handi_sp = 1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n15' ==1; /* 認定あり */
		replace handi_sp = 0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n15' ==9; /* 該当しない */

		local n4a=`n4a'+3;
		local n7 = `n7'+19;		/* 最終学歴 */
		local n8 = `n8'+19;		/* 家族関係の変化 */
		local n9 = `n9'+19;		/* 配偶関係・婚姻届を出していない */
		local n10 = `n10'+19;	/* 対象者の家からかかる時間（時間） */
		local n11 = `n11'+19;	/* 対象者の家からかかる時間（分） */
		local n12 = `n12'+19;	/* 連絡がつかない */
		local n13 = `n13'+19;	/* 生計を同じにしている */
		local n14 = `n14'+19;	/* 慢性的な日常活動の制限	 */
		local n15 = `n15'+19;	/* 要支援・要介護認定／障害支援区分の認定	 */

		};

	/* 家族ID 11番～25番 */
	
	foreach n0 of num 3778(19)4044{;	/* 続柄 */
		local n1 = `n0'+1;		/* 性別 */
		local n2 = `n0'+2;		/* 生まれ年 */
		local n3 = `n0'+3;		/* 生まれ月 */
		local n4a = `n0'+11;	/* 就労 */
		local n5 = `n0'+8;		/* 同居・別居 */
		local n6 = `n0'+6;		/* 未既婚 */

		local n7 = `n0'+4;		/* 最終学歴 */
		local n8 = `n0'+5;		/* 家族関係の変化 */
		local n9 = `n0'+7;		/* 配偶関係・婚姻届を出していない */
		local n10 = `n0'+9;		/* 対象者の家からかかる時間（時間） */
		local n11 = `n0'+10;	/* 対象者の家からかかる時間（分） */
		local n12 = `n0'+15;	/* 連絡がつかない */
		local n13 = `n0'+16;	/* 生計を同じにしている */
		local n14 = `n0'+17;	/* 慢性的な日常活動の制限	 */
		local n15 = `n0'+18;	/* 要支援・要介護認定／障害支援区分の認定	 */

		/* 配偶者の有無 */
		replace sp=1 if v`n0'==1 & v`n1'==1 & year==`y';
		
		/* 性別 */
		replace male_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n1'==1; /* 男性 */
		replace male_sp=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n1'==2; /* 女性 */
		
		/* 年齢 */
		replace birthy_sp=v`n2' if v`n0'==1 & v`n1'==1 & year==`y' & v`n2'<7777;					/* 生まれ年 */
		replace age_sp=`y'-v`n2' if v`n0'==1 & v`n1'==1 & year==`y' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
		replace age_sp=`y'-v`n2'-1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
		
		/* 就労 */
		replace job_sp_j=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
		replace job_sp_j=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
		
		/* 同居 */
		replace dokyo_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n5'==1; /* 同居 */
		replace dokyo_sp=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n5'==2; /* 別居 */
		
		/* 有配偶 */
		replace mar_sp=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n6'==1; /* 無配偶 */
		replace mar_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n6'==2; /* 有配偶 */
		
		/* 最終学歴 */
		replace edu_sp=v`n7' if v`n0'==1 & v`n1'==1 & year==`y'; 

		/* 家族関係の変化 */
		replace chng_sp=v`n8' if v`n0'==1 & v`n1'==1 & year==`y';

		/* 家族関係の変化: 死別 */
		replace deth_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n8'==2;					/* 死別 */
		replace deth_sp=0 if v`n0'==1 & v`n1'==1 & year==`y' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

		/* 配偶関係・婚姻届けを出していない */
		replace mar_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n9'==1; /* 事実婚 */

		/* 対象者の家からかかる時間（時間） */
		replace time1_sp= v`n10' if v`n0'==1 & v`n1'==1 & year==`y' & v`n10'<888;

		/* 対象者の家からかかる時間（分） */
		replace time2_sp= v`n11' if v`n0'==1 & v`n1'==1 & year==`y' & v`n11'<888;

		/* 対象者の家からかかる時間（合計・分） */
		replace time_sp= time1_sp*60+time2_sp	if v`n0'==1 & v`n1'==1 & year==`y' & time1_sp!=. & time2_sp!=.;
		replace time_sp= time1_sp*60				if v`n0'==1 & v`n1'==1 & year==`y' & time1_sp!=. & time2_sp==.;
		replace time_sp= time2_sp					if v`n0'==1 & v`n1'==1 & year==`y' & time1_sp==. & time2_sp!=.;

		/* 連絡がつかない */
		replace nocntct_sp= 1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n12'==1; /* 連絡がつかない */
		replace nocntct_sp= 0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n12'==9; /* 該当しない */

		/* 同一生計 */
		replace samelive_sp= 1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n13' ==1; /* 同一家計 */
		replace samelive_sp= 0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n13' ==9; /* 該当しない */

		/* 慢性的な日常生活の制限 disability*/
		replace disab_sp= 1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n14' ==1; /* 制限あり */
		replace disab_sp= 0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n14' ==9; /* 該当しない */

		/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
		replace handi_sp = 1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n15' ==1; /* 認定あり */
		replace handi_sp = 0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n15' ==9; /* 該当しない */
			
		};

	/* 家族ID 26番～27番（2018年以降のみ） */
	
	foreach n0 of num 4436(20)4456{;	/* 続柄 */
		local n1 = `n0'+1;		/* 性別 */
		local n2 = `n0'+2;		/* 生まれ年 */
		local n3 = `n0'+3;		/* 生まれ月 */
		local n4a = `n0'+12;	/* 就労 */
		local n5 = `n0'+9;		/* 同居・別居 */
		local n6 = `n0'+7;		/* 未既婚 */

		local n7 = `n0'+5;		/* 最終学歴 */
		local n8 = `n0'+6;		/* 家族関係の変化 */
		local n9 = `n0'+8;		/* 配偶関係・婚姻届を出していない */
		local n10 = `n0'+10;	/* 対象者の家からかかる時間（時間） */
		local n11 = `n0'+11;	/* 対象者の家からかかる時間（分） */
		local n12 = `n0'+16;	/* 連絡がつかない */
		local n13 = `n0'+17;	/* 生計を同じにしている */
		local n14 = `n0'+18;	/* 慢性的な日常活動の制限	 */
		local n15 = `n0'+19;	/* 要支援・要介護認定／障害支援区分の認定	 */

		/* 配偶者の有無 */
		replace sp=1 if v`n0'==1 & v`n1'==1 & year==`y';
		
		/* 性別 */
		replace male_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n1'==1; /* 男性 */
		replace male_sp=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n1'==2; /* 女性 */
		
		/* 年齢 */
		replace birthy_sp=v`n2' if v`n0'==1 & v`n1'==1 & year==`y' & v`n2'<7777;					/* 生まれ年 */
		replace age_sp=`y'-v`n2' if v`n0'==1 & v`n1'==1 & year==`y' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
		replace age_sp=`y'-v`n2'-1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
		
		/* 就労 */
		replace job_sp_j=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
		replace job_sp_j=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
		
		/* 同居 */
		replace dokyo_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n5'==1; /* 同居 */
		replace dokyo_sp=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n5'==2; /* 別居 */
		
		/* 有配偶 */
		replace mar_sp=0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n6'==1; /* 無配偶 */
		replace mar_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n6'==2; /* 有配偶 */
		
		/* 最終学歴 */
		replace edu_sp=v`n7' if v`n0'==1 & v`n1'==1 & year==`y'; 

		/* 家族関係の変化 */
		replace chng_sp=v`n8' if v`n0'==1 & v`n1'==1 & year==`y';

		/* 家族関係の変化: 死別 */
		replace deth_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n8'==2;					/* 死別 */
		replace deth_sp=0 if v`n0'==1 & v`n1'==1 & year==`y' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

		/* 配偶関係・婚姻届けを出していない */
		replace mar_sp=1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n9'==1; /* 事実婚 */

		/* 対象者の家からかかる時間（時間） */
		replace time1_sp= v`n10' if v`n0'==1 & v`n1'==1 & year==`y' & v`n10'<888;

		/* 対象者の家からかかる時間（分） */
		replace time2_sp= v`n11' if v`n0'==1 & v`n1'==1 & year==`y' & v`n11'<888;

		/* 対象者の家からかかる時間（合計・分） */
		replace time_sp= time1_sp*60+time2_sp	if v`n0'==1 & v`n1'==1 & year==`y' & time1_sp!=. & time2_sp!=.;
		replace time_sp= time1_sp*60				if v`n0'==1 & v`n1'==1 & year==`y' & time1_sp!=. & time2_sp==.;
		replace time_sp= time2_sp					if v`n0'==1 & v`n1'==1 & year==`y' & time1_sp==. & time2_sp!=.;

		/* 連絡がつかない */
		replace nocntct_sp= 1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n12'==1; /* 連絡がつかない */
		replace nocntct_sp= 0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n12'==9; /* 該当しない */

		/* 同一生計 */
		replace samelive_sp= 1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n13' ==1; /* 同一家計 */
		replace samelive_sp= 0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n13' ==9; /* 該当しない */

		/* 慢性的な日常生活の制限 disability*/
		replace disab_sp= 1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n14' ==1; /* 制限あり */
		replace disab_sp= 0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n14' ==9; /* 該当しない */

		/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
		replace handi_sp = 1 if v`n0'==1 & v`n1'==1 & year==`y' & v`n15' ==1; /* 認定あり */
		replace handi_sp = 0 if v`n0'==1 & v`n1'==1 & year==`y' & v`n15' ==9; /* 該当しない */

		};
	};

/* job_spの統合 */
replace job_sp = job_sp_j if job_sp_j!=.;
drop job_sp_j;

/* 70歳以上は誤記と考え、欠損値とする
foreach k of num 1/10{;
	replace age_sp=. if age_sp>70;

	replace sp=. 		if age_sp>70;
	replace dokyo_sp=.	if age_sp>70;
	replace mar_sp=.	if age_sp>70;
	replace job_sp=.	if age_sp>70;
};
 */
/* 年齢の補完 */
	/* -1は0歳にする */
	replace age_sp=0 if age_sp <0 & age_sp !=.;

label var sp "1:配偶者あり";
label var dokyo_sp "1:配偶者と同居";
label var mar_sp "1:配偶者既婚";
label var job_sp  "1:配偶者就業";
label var age_sp  "配偶者年齢(歳)";

/* 記述統計 */
sum sp male_sp mar_sp dokyo_sp job_sp
age_sp edu_sp chng_sp deth_sp time_sp
nocntct_sp samelive_sp disab_sp handi_sp, separator(0);

/*
チェック用
browse v1 year v13 v15 v20 v22 v27 v29  v34 v36 v41 v43 v48 v50 v55 v57 v62 v64 v69 v71  agesp1 agesp2 agesp3 agesp4 agesp5 agesp6 
browse v1 year agesp1 agesp2 agesp3 agesp4 agesp5 agesp6 dokyo_sp1-dokyo_sp6
*/

/*
keep id v1 year sp_n sp1-sp6 dokyo_sp1-dokyo_sp6 male_sp1-male_sp6 mar_sp1-mar_sp6 
job_sp1-job_sp6 birthy_sp1-birthy_sp6  agesp1-agesp6 
edu_sp1-edu_sp4 deth_sp1-deth_sp4 time_sp1-time_sp4 nocntct_sp1-nocntct_sp4 samelive_sp1-samelive_sp4
disab_sp1-disab_sp4 handi_sp1-handi_sp4
spoh1-spoh5 male_spoh1-male_spoh5 age_spoh1-age_spoh5 tel_spoh1-tel_spoh5
hous_spoh1-hous_spoh5 sp_n spoh_n sp_s
male_spoh1-male_spoh5 age_spoh1-age_spoh5 tel_spoh1-tel_spoh5 hous_spoh1-hous_spoh5
rsn_spoh1-rsn_spoh5;

save sp_data.dta, replace;


log close;
exit;

*/


