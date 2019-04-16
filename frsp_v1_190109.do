#delimit;

global ly 2018; /* 最新調査年度 */

/*** 家族表　配偶者の父親関連変数 ***/

gen frsp=.;			/* 配偶者の父親の有無 */
gen male_frsp=.;		/* 性別 */
gen birthy_frsp=.;	/* 生まれ年 */
gen age_frsp=.;		/* 年齢 */
gen job_frsp=.;		/* 就労 */
gen job_frsp_j=.;		/* 就労 (K2014～ / J2009～) */
gen dokyo_frsp=.;		/* 同居 */
gen mar_frsp=.;		/* 有配偶 */
gen edu_frsp=.;		/* 最終学歴 */
gen chng_frsp=.;		/* 家族関係の変化 */
gen deth_frsp=.;		/* 死別 */
gen time1_frsp=.;		/* 対象者の家からかかる時間（時間） */
gen time2_frsp=.;		/* 対象者の家からかかる時間（分） */
gen time_frsp=.;		/* 対象者の家からかかる時間（合計・分） */
gen nocntct_frsp=.;	/* 連絡がつかない */
gen samelive_frsp=.;	/* 生計を同じにしている */
gen disab_frsp=.;		/* 慢性的な日常活動の制限 */
gen handi_frsp=.;		/* 要支援・要介護認定／障害支援区分の認定 */

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

		/* 配偶者の父親の有無 */
		replace frsp=1 if v`n0'==6 & v`n1'==1 & year==`y';
		
		/* 性別 */
		replace male_frsp=1 if v`n0'==6 & v`n1'==1 & year==`y' & v`n1'==1; /* 男性 */
		replace male_frsp=0 if v`n0'==6 & v`n1'==1 & year==`y' & v`n1'==2; /* 女性 */
		
		/* 年齢 */
		replace birthy_frsp=v`n2' if v`n0'==6 & v`n1'==1 & year==`y' & v`n2'<7777;					/* 生まれ年 */
		replace age_frsp=`y'-v`n2' if v`n0'==6 & v`n1'==1 & year==`y' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
		replace age_frsp=`y'-v`n2'-1 if v`n0'==6 & v`n1'==1 & year==`y' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
		
		/* 就労 */
		replace job_frsp=1 if v`n0'==6 & v`n1'==1 & year==`y' & v`n4'==8;		/* 就労 (K2004～K2013) */
		replace job_frsp=0 if v`n0'==6 & v`n1'==1 & year==`y' & v`n4'!=8;		/* 非就労 (K2004～K2013) */
		replace job_frsp_j=1 if v`n0'==6 & v`n1'==1 & year==`y' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
		replace job_frsp_j=0 if v`n0'==6 & v`n1'==1 & year==`y' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
		local n4a=`n4a'+3;
		
		/* 同居 */
		replace dokyo_frsp=1 if v`n0'==6 & v`n1'==1 & year==`y' & v`n5'==1; /* 同居 */
		replace dokyo_frsp=0 if v`n0'==6 & v`n1'==1 & year==`y' & v`n5'==2; /* 別居 */
		
		/* 有配偶 */
		replace mar_frsp=0 if v`n0'==6 & v`n1'==1 & year==`y' & v`n6'==1; /* 無配偶 */
		replace mar_frsp=1 if v`n0'==6 & v`n1'==1 & year==`y' & v`n6'==2; /* 有配偶 */
			
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

		/* 配偶者の父親の有無 */
		replace frsp=1 if v`n0'==5 & v`n1'==1 & year==`y';
		
		/* 性別 */
		replace male_frsp=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n1'==1; /* 男性 */
		replace male_frsp=0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n1'==2; /* 女性 */
		
		/* 年齢 */
		replace birthy_frsp=v`n2' if v`n0'==5 & v`n1'==1 & year==`y' & v`n2'<7777;					/* 生まれ年 */
		replace age_frsp=`y'-v`n2' if v`n0'==5 & v`n1'==1 & year==`y' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
		replace age_frsp=`y'-v`n2'-1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
		
		/* 就労 */
		replace job_frsp=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n4'==8;		/* 就労 (K2004～K2013) */
		replace job_frsp=0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n4'!=8;		/* 非就労 (K2004～K2013) */
		replace job_frsp_j=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
		replace job_frsp_j=0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
		
		/* 同居 */
		replace dokyo_frsp=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n5'==1; /* 同居 */
		replace dokyo_frsp=0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n5'==2; /* 別居 */
		
		/* 有配偶 */
		replace mar_frsp=0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n6'==1; /* 無配偶 */
		replace mar_frsp=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n6'==2; /* 有配偶 */
		
		/* 最終学歴 */
		replace edu_frsp=v`n7' if v`n0'==5 & v`n1'==1 & year==`y'; 

		/* 家族関係の変化 */
		replace chng_frsp=v`n8' if v`n0'==5 & v`n1'==1 & year==`y';

		/* 家族関係の変化: 死別 */
		replace deth_frsp=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n8'==2;					/* 死別 */
		replace deth_frsp=0 if v`n0'==5 & v`n1'==1 & year==`y' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

		/* 配偶関係・婚姻届けを出していない */
		replace mar_frsp=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n9'==1; /* 事実婚 */

		/* 対象者の家からかかる時間（時間） */
		replace time1_frsp= v`n10' if v`n0'==5 & v`n1'==1 & year==`y' & v`n10'<888;

		/* 対象者の家からかかる時間（分） */
		replace time2_frsp= v`n11' if v`n0'==5 & v`n1'==1 & year==`y' & v`n11'<888;

		/* 対象者の家からかかる時間（合計・分） */
		replace time_frsp= time1_frsp*60+time2_frsp	if v`n0'==5 & v`n1'==1 & year==`y' & time1_frsp!=. & time2_frsp!=.;
		replace time_frsp= time1_frsp*60				if v`n0'==5 & v`n1'==1 & year==`y' & time1_frsp!=. & time2_frsp==.;
		replace time_frsp= time2_frsp					if v`n0'==5 & v`n1'==1 & year==`y' & time1_frsp==. & time2_frsp!=.;

		/* 連絡がつかない */
		replace nocntct_frsp= 1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n12'==1; /* 連絡がつかない */
		replace nocntct_frsp= 0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n12'==9; /* 該当しない */

		/* 同一生計 */
		replace samelive_frsp= 1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n13' ==1; /* 同一家計 */
		replace samelive_frsp= 0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n13' ==9; /* 該当しない */

		/* 慢性的な日常生活の制限 disability*/
		replace disab_frsp= 1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n14' ==1; /* 制限あり */
		replace disab_frsp= 0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n14' ==9; /* 該当しない */

		/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
		replace handi_frsp = 1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n15' ==1; /* 認定あり */
		replace handi_frsp = 0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n15' ==9; /* 該当しない */

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

		/* 配偶者の父親の有無 */
		replace frsp=1 if v`n0'==5 & v`n1'==1 & year==`y';
		
		/* 性別 */
		replace male_frsp=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n1'==1; /* 男性 */
		replace male_frsp=0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n1'==2; /* 女性 */
		
		/* 年齢 */
		replace birthy_frsp=v`n2' if v`n0'==5 & v`n1'==1 & year==`y' & v`n2'<7777;					/* 生まれ年 */
		replace age_frsp=`y'-v`n2' if v`n0'==5 & v`n1'==1 & year==`y' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
		replace age_frsp=`y'-v`n2'-1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
		
		/* 就労 */
		replace job_frsp_j=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
		replace job_frsp_j=0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
		
		/* 同居 */
		replace dokyo_frsp=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n5'==1; /* 同居 */
		replace dokyo_frsp=0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n5'==2; /* 別居 */
		
		/* 有配偶 */
		replace mar_frsp=0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n6'==1; /* 無配偶 */
		replace mar_frsp=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n6'==2; /* 有配偶 */
		
		/* 最終学歴 */
		replace edu_frsp=v`n7' if v`n0'==5 & v`n1'==1 & year==`y'; 

		/* 家族関係の変化 */
		replace chng_frsp=v`n8' if v`n0'==5 & v`n1'==1 & year==`y';

		/* 家族関係の変化: 死別 */
		replace deth_frsp=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n8'==2;					/* 死別 */
		replace deth_frsp=0 if v`n0'==5 & v`n1'==1 & year==`y' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

		/* 配偶関係・婚姻届けを出していない */
		replace mar_frsp=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n9'==1; /* 事実婚 */

		/* 対象者の家からかかる時間（時間） */
		replace time1_frsp= v`n10' if v`n0'==5 & v`n1'==1 & year==`y' & v`n10'<888;

		/* 対象者の家からかかる時間（分） */
		replace time2_frsp= v`n11' if v`n0'==5 & v`n1'==1 & year==`y' & v`n11'<888;

		/* 対象者の家からかかる時間（合計・分） */
		replace time_frsp= time1_frsp*60+time2_frsp	if v`n0'==5 & v`n1'==1 & year==`y' & time1_frsp!=. & time2_frsp!=.;
		replace time_frsp= time1_frsp*60				if v`n0'==5 & v`n1'==1 & year==`y' & time1_frsp!=. & time2_frsp==.;
		replace time_frsp= time2_frsp					if v`n0'==5 & v`n1'==1 & year==`y' & time1_frsp==. & time2_frsp!=.;

		/* 連絡がつかない */
		replace nocntct_frsp= 1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n12'==1; /* 連絡がつかない */
		replace nocntct_frsp= 0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n12'==9; /* 該当しない */

		/* 同一生計 */
		replace samelive_frsp= 1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n13' ==1; /* 同一家計 */
		replace samelive_frsp= 0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n13' ==9; /* 該当しない */

		/* 慢性的な日常生活の制限 disability*/
		replace disab_frsp= 1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n14' ==1; /* 制限あり */
		replace disab_frsp= 0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n14' ==9; /* 該当しない */

		/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
		replace handi_frsp = 1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n15' ==1; /* 認定あり */
		replace handi_frsp = 0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n15' ==9; /* 該当しない */
			
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

		/* 配偶者の父親の有無 */
		replace frsp=1 if v`n0'==5 & v`n1'==1 & year==`y';
		
		/* 性別 */
		replace male_frsp=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n1'==1; /* 男性 */
		replace male_frsp=0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n1'==2; /* 女性 */
		
		/* 年齢 */
		replace birthy_frsp=v`n2' if v`n0'==5 & v`n1'==1 & year==`y' & v`n2'<7777;					/* 生まれ年 */
		replace age_frsp=`y'-v`n2' if v`n0'==5 & v`n1'==1 & year==`y' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
		replace age_frsp=`y'-v`n2'-1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
		
		/* 就労 */
		replace job_frsp_j=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
		replace job_frsp_j=0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
		
		/* 同居 */
		replace dokyo_frsp=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n5'==1; /* 同居 */
		replace dokyo_frsp=0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n5'==2; /* 別居 */
		
		/* 有配偶 */
		replace mar_frsp=0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n6'==1; /* 無配偶 */
		replace mar_frsp=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n6'==2; /* 有配偶 */
		
		/* 最終学歴 */
		replace edu_frsp=v`n7' if v`n0'==5 & v`n1'==1 & year==`y'; 

		/* 家族関係の変化 */
		replace chng_frsp=v`n8' if v`n0'==5 & v`n1'==1 & year==`y';

		/* 家族関係の変化: 死別 */
		replace deth_frsp=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n8'==2;					/* 死別 */
		replace deth_frsp=0 if v`n0'==5 & v`n1'==1 & year==`y' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

		/* 配偶関係・婚姻届けを出していない */
		replace mar_frsp=1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n9'==1; /* 事実婚 */

		/* 対象者の家からかかる時間（時間） */
		replace time1_frsp= v`n10' if v`n0'==5 & v`n1'==1 & year==`y' & v`n10'<888;

		/* 対象者の家からかかる時間（分） */
		replace time2_frsp= v`n11' if v`n0'==5 & v`n1'==1 & year==`y' & v`n11'<888;

		/* 対象者の家からかかる時間（合計・分） */
		replace time_frsp= time1_frsp*60+time2_frsp	if v`n0'==5 & v`n1'==1 & year==`y' & time1_frsp!=. & time2_frsp!=.;
		replace time_frsp= time1_frsp*60				if v`n0'==5 & v`n1'==1 & year==`y' & time1_frsp!=. & time2_frsp==.;
		replace time_frsp= time2_frsp					if v`n0'==5 & v`n1'==1 & year==`y' & time1_frsp==. & time2_frsp!=.;

		/* 連絡がつかない */
		replace nocntct_frsp= 1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n12'==1; /* 連絡がつかない */
		replace nocntct_frsp= 0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n12'==9; /* 該当しない */

		/* 同一生計 */
		replace samelive_frsp= 1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n13' ==1; /* 同一家計 */
		replace samelive_frsp= 0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n13' ==9; /* 該当しない */

		/* 慢性的な日常生活の制限 disability*/
		replace disab_frsp= 1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n14' ==1; /* 制限あり */
		replace disab_frsp= 0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n14' ==9; /* 該当しない */

		/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
		replace handi_frsp = 1 if v`n0'==5 & v`n1'==1 & year==`y' & v`n15' ==1; /* 認定あり */
		replace handi_frsp = 0 if v`n0'==5 & v`n1'==1 & year==`y' & v`n15' ==9; /* 該当しない */

		};
	};

/* job_frspの統合 */
replace job_frsp = job_frsp_j if job_frsp_j!=.;
drop job_frsp_j;

/* 70歳以上は誤記と考え、欠損値とする
foreach k of num 1/10{;
	replace age_frsp=. if age_frsp>70;

	replace frsp=. 		if age_frsp>70;
	replace dokyo_frsp=.	if age_frsp>70;
	replace mar_frsp=.	if age_frsp>70;
	replace job_frsp=.	if age_frsp>70;
};
 */
/* 年齢の補完 */
	/* -1は0歳にする */
	replace age_frsp=0 if age_frsp <0 & age_frsp !=.;

label var frsp "1:配偶者の父親あり";
label var dokyo_frsp "1:配偶者の父親と同居";
label var mar_frsp "1:配偶者の父親既婚";
label var job_frsp  "1:配偶者の父親就業";
label var age_frsp  "配偶者の父親年齢(歳)";

/* 記述統計 */
sum frsp male_frsp mar_frsp dokyo_frsp job_frsp
age_frsp edu_frsp chng_frsp deth_frsp time_frsp
nocntct_frsp samelive_frsp disab_frsp handi_frsp, separator(0);

/*
チェック用
browse v1 year v13 v15 v20 v22 v27 v29  v34 v36 v41 v43 v48 v50 v55 v57 v62 v64 v69 v71  agefrsp1 agefrsp2 agefrsp3 agefrsp4 agefrsp5 agefrsp6 
browse v1 year agefrsp1 agefrsp2 agefrsp3 agefrsp4 agefrsp5 agefrsp6 dokyo_frsp1-dokyo_frsp6
*/

/*
keep id v1 year frsp_n frsp1-frsp6 dokyo_frsp1-dokyo_frsp6 male_frsp1-male_frsp6 mar_frsp1-mar_frsp6 
job_frsp1-job_frsp6 birthy_frsp1-birthy_frsp6  agefrsp1-agefrsp6 
edu_frsp1-edu_frsp4 deth_frsp1-deth_frsp4 time_frsp1-time_frsp4 nocntct_frsp1-nocntct_frsp4 samelive_frsp1-samelive_frsp4
disab_frsp1-disab_frsp4 handi_frsp1-handi_frsp4
frspoh1-frspoh5 male_frspoh1-male_frspoh5 age_frspoh1-age_frspoh5 tel_frspoh1-tel_frspoh5
hous_frspoh1-hous_frspoh5 frsp_n frspoh_n frsp_s
male_frspoh1-male_frspoh5 age_frspoh1-age_frspoh5 tel_frspoh1-tel_frspoh5 hous_frspoh1-hous_frspoh5
rsn_frspoh1-rsn_frspoh5;

save frsp_data.dta, replace;


log close;
exit;

*/


