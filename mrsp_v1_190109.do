#delimit;

global ly 2018; /* 最新調査年度 */

/*** 家族表　配偶者の母親関連変数 ***/

gen mrsp=.;			/* 配偶者の母親の有無 */
gen male_mrsp=.;		/* 性別 */
gen birthy_mrsp=.;	/* 生まれ年 */
gen age_mrsp=.;		/* 年齢 */
gen job_mrsp=.;		/* 就労 */
gen job_mrsp_j=.;		/* 就労 (K2014～ / J2009～) */
gen dokyo_mrsp=.;		/* 同居 */
gen mar_mrsp=.;		/* 有配偶 */
gen edu_mrsp=.;		/* 最終学歴 */
gen chng_mrsp=.;		/* 家族関係の変化 */
gen deth_mrsp=.;		/* 死別 */
gen time1_mrsp=.;		/* 対象者の家からかかる時間（時間） */
gen time2_mrsp=.;		/* 対象者の家からかかる時間（分） */
gen time_mrsp=.;		/* 対象者の家からかかる時間（合計・分） */
gen nocntct_mrsp=.;	/* 連絡がつかない */
gen samelive_mrsp=.;	/* 生計を同じにしている */
gen disab_mrsp=.;		/* 慢性的な日常活動の制限 */
gen handi_mrsp=.;		/* 要支援・要介護認定／障害支援区分の認定 */

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

		/* 配偶者の母親の有無 */
		replace mrsp=1 if v`n0'==6 & v`n1'==2 & year==`y';
		
		/* 性別 */
		replace male_mrsp=1 if v`n0'==6 & v`n1'==2 & year==`y' & v`n1'==2; /* 男性 */
		replace male_mrsp=0 if v`n0'==6 & v`n1'==2 & year==`y' & v`n1'==2; /* 女性 */
		
		/* 年齢 */
		replace birthy_mrsp=v`n2' if v`n0'==6 & v`n1'==2 & year==`y' & v`n2'<7777;					/* 生まれ年 */
		replace age_mrsp=`y'-v`n2' if v`n0'==6 & v`n1'==2 & year==`y' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
		replace age_mrsp=`y'-v`n2'-1 if v`n0'==6 & v`n1'==2 & year==`y' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
		
		/* 就労 */
		replace job_mrsp=1 if v`n0'==6 & v`n1'==2 & year==`y' & v`n4'==8;		/* 就労 (K2004～K2013) */
		replace job_mrsp=0 if v`n0'==6 & v`n1'==2 & year==`y' & v`n4'!=8;		/* 非就労 (K2004～K2013) */
		replace job_mrsp_j=1 if v`n0'==6 & v`n1'==2 & year==`y' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
		replace job_mrsp_j=0 if v`n0'==6 & v`n1'==2 & year==`y' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
		local n4a=`n4a'+3;
		
		/* 同居 */
		replace dokyo_mrsp=1 if v`n0'==6 & v`n1'==2 & year==`y' & v`n5'==1; /* 同居 */
		replace dokyo_mrsp=0 if v`n0'==6 & v`n1'==2 & year==`y' & v`n5'==2; /* 別居 */
		
		/* 有配偶 */
		replace mar_mrsp=0 if v`n0'==6 & v`n1'==2 & year==`y' & v`n6'==1; /* 無配偶 */
		replace mar_mrsp=1 if v`n0'==6 & v`n1'==2 & year==`y' & v`n6'==2; /* 有配偶 */
			
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

		/* 配偶者の母親の有無 */
		replace mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y';
		
		/* 性別 */
		replace male_mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n1'==2; /* 男性 */
		replace male_mrsp=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n1'==2; /* 女性 */
		
		/* 年齢 */
		replace birthy_mrsp=v`n2' if v`n0'==5 & v`n1'==2 & year==`y' & v`n2'<7777;					/* 生まれ年 */
		replace age_mrsp=`y'-v`n2' if v`n0'==5 & v`n1'==2 & year==`y' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
		replace age_mrsp=`y'-v`n2'-1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
		
		/* 就労 */
		replace job_mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n4'==8;		/* 就労 (K2004～K2013) */
		replace job_mrsp=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n4'!=8;		/* 非就労 (K2004～K2013) */
		replace job_mrsp_j=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
		replace job_mrsp_j=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
		
		/* 同居 */
		replace dokyo_mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n5'==1; /* 同居 */
		replace dokyo_mrsp=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n5'==2; /* 別居 */
		
		/* 有配偶 */
		replace mar_mrsp=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n6'==1; /* 無配偶 */
		replace mar_mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n6'==2; /* 有配偶 */
		
		/* 最終学歴 */
		replace edu_mrsp=v`n7' if v`n0'==5 & v`n1'==2 & year==`y'; 

		/* 家族関係の変化 */
		replace chng_mrsp=v`n8' if v`n0'==5 & v`n1'==2 & year==`y';

		/* 家族関係の変化: 死別 */
		replace deth_mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n8'==2;					/* 死別 */
		replace deth_mrsp=0 if v`n0'==5 & v`n1'==2 & year==`y' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

		/* 配偶関係・婚姻届けを出していない */
		replace mar_mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n9'==1; /* 事実婚 */

		/* 対象者の家からかかる時間（時間） */
		replace time1_mrsp= v`n10' if v`n0'==5 & v`n1'==2 & year==`y' & v`n10'<888;

		/* 対象者の家からかかる時間（分） */
		replace time2_mrsp= v`n11' if v`n0'==5 & v`n1'==2 & year==`y' & v`n11'<888;

		/* 対象者の家からかかる時間（合計・分） */
		replace time_mrsp= time1_mrsp*60+time2_mrsp	if v`n0'==5 & v`n1'==2 & year==`y' & time1_mrsp!=. & time2_mrsp!=.;
		replace time_mrsp= time1_mrsp*60				if v`n0'==5 & v`n1'==2 & year==`y' & time1_mrsp!=. & time2_mrsp==.;
		replace time_mrsp= time2_mrsp					if v`n0'==5 & v`n1'==2 & year==`y' & time1_mrsp==. & time2_mrsp!=.;

		/* 連絡がつかない */
		replace nocntct_mrsp= 1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n12'==1; /* 連絡がつかない */
		replace nocntct_mrsp= 0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n12'==9; /* 該当しない */

		/* 同一生計 */
		replace samelive_mrsp= 1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n13' ==1; /* 同一家計 */
		replace samelive_mrsp= 0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n13' ==9; /* 該当しない */

		/* 慢性的な日常生活の制限 disability*/
		replace disab_mrsp= 1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n14' ==1; /* 制限あり */
		replace disab_mrsp= 0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n14' ==9; /* 該当しない */

		/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
		replace handi_mrsp = 1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n15' ==1; /* 認定あり */
		replace handi_mrsp = 0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n15' ==9; /* 該当しない */

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

		/* 配偶者の母親の有無 */
		replace mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y';
		
		/* 性別 */
		replace male_mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n1'==2; /* 男性 */
		replace male_mrsp=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n1'==2; /* 女性 */
		
		/* 年齢 */
		replace birthy_mrsp=v`n2' if v`n0'==5 & v`n1'==2 & year==`y' & v`n2'<7777;					/* 生まれ年 */
		replace age_mrsp=`y'-v`n2' if v`n0'==5 & v`n1'==2 & year==`y' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
		replace age_mrsp=`y'-v`n2'-1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
		
		/* 就労 */
		replace job_mrsp_j=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
		replace job_mrsp_j=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
		
		/* 同居 */
		replace dokyo_mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n5'==1; /* 同居 */
		replace dokyo_mrsp=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n5'==2; /* 別居 */
		
		/* 有配偶 */
		replace mar_mrsp=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n6'==1; /* 無配偶 */
		replace mar_mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n6'==2; /* 有配偶 */
		
		/* 最終学歴 */
		replace edu_mrsp=v`n7' if v`n0'==5 & v`n1'==2 & year==`y'; 

		/* 家族関係の変化 */
		replace chng_mrsp=v`n8' if v`n0'==5 & v`n1'==2 & year==`y';

		/* 家族関係の変化: 死別 */
		replace deth_mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n8'==2;					/* 死別 */
		replace deth_mrsp=0 if v`n0'==5 & v`n1'==2 & year==`y' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

		/* 配偶関係・婚姻届けを出していない */
		replace mar_mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n9'==1; /* 事実婚 */

		/* 対象者の家からかかる時間（時間） */
		replace time1_mrsp= v`n10' if v`n0'==5 & v`n1'==2 & year==`y' & v`n10'<888;

		/* 対象者の家からかかる時間（分） */
		replace time2_mrsp= v`n11' if v`n0'==5 & v`n1'==2 & year==`y' & v`n11'<888;

		/* 対象者の家からかかる時間（合計・分） */
		replace time_mrsp= time1_mrsp*60+time2_mrsp	if v`n0'==5 & v`n1'==2 & year==`y' & time1_mrsp!=. & time2_mrsp!=.;
		replace time_mrsp= time1_mrsp*60				if v`n0'==5 & v`n1'==2 & year==`y' & time1_mrsp!=. & time2_mrsp==.;
		replace time_mrsp= time2_mrsp					if v`n0'==5 & v`n1'==2 & year==`y' & time1_mrsp==. & time2_mrsp!=.;

		/* 連絡がつかない */
		replace nocntct_mrsp= 1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n12'==1; /* 連絡がつかない */
		replace nocntct_mrsp= 0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n12'==9; /* 該当しない */

		/* 同一生計 */
		replace samelive_mrsp= 1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n13' ==1; /* 同一家計 */
		replace samelive_mrsp= 0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n13' ==9; /* 該当しない */

		/* 慢性的な日常生活の制限 disability*/
		replace disab_mrsp= 1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n14' ==1; /* 制限あり */
		replace disab_mrsp= 0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n14' ==9; /* 該当しない */

		/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
		replace handi_mrsp = 1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n15' ==1; /* 認定あり */
		replace handi_mrsp = 0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n15' ==9; /* 該当しない */
			
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

		/* 配偶者の母親の有無 */
		replace mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y';
		
		/* 性別 */
		replace male_mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n1'==2; /* 男性 */
		replace male_mrsp=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n1'==2; /* 女性 */
		
		/* 年齢 */
		replace birthy_mrsp=v`n2' if v`n0'==5 & v`n1'==2 & year==`y' & v`n2'<7777;					/* 生まれ年 */
		replace age_mrsp=`y'-v`n2' if v`n0'==5 & v`n1'==2 & year==`y' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
		replace age_mrsp=`y'-v`n2'-1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
		
		/* 就労 */
		replace job_mrsp_j=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
		replace job_mrsp_j=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
		
		/* 同居 */
		replace dokyo_mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n5'==1; /* 同居 */
		replace dokyo_mrsp=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n5'==2; /* 別居 */
		
		/* 有配偶 */
		replace mar_mrsp=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n6'==1; /* 無配偶 */
		replace mar_mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n6'==2; /* 有配偶 */
		
		/* 最終学歴 */
		replace edu_mrsp=v`n7' if v`n0'==5 & v`n1'==2 & year==`y'; 

		/* 家族関係の変化 */
		replace chng_mrsp=v`n8' if v`n0'==5 & v`n1'==2 & year==`y';

		/* 家族関係の変化: 死別 */
		replace deth_mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n8'==2;					/* 死別 */
		replace deth_mrsp=0 if v`n0'==5 & v`n1'==2 & year==`y' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

		/* 配偶関係・婚姻届けを出していない */
		replace mar_mrsp=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n9'==1; /* 事実婚 */

		/* 対象者の家からかかる時間（時間） */
		replace time1_mrsp= v`n10' if v`n0'==5 & v`n1'==2 & year==`y' & v`n10'<888;

		/* 対象者の家からかかる時間（分） */
		replace time2_mrsp= v`n11' if v`n0'==5 & v`n1'==2 & year==`y' & v`n11'<888;

		/* 対象者の家からかかる時間（合計・分） */
		replace time_mrsp= time1_mrsp*60+time2_mrsp	if v`n0'==5 & v`n1'==2 & year==`y' & time1_mrsp!=. & time2_mrsp!=.;
		replace time_mrsp= time1_mrsp*60				if v`n0'==5 & v`n1'==2 & year==`y' & time1_mrsp!=. & time2_mrsp==.;
		replace time_mrsp= time2_mrsp					if v`n0'==5 & v`n1'==2 & year==`y' & time1_mrsp==. & time2_mrsp!=.;

		/* 連絡がつかない */
		replace nocntct_mrsp= 1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n12'==1; /* 連絡がつかない */
		replace nocntct_mrsp= 0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n12'==9; /* 該当しない */

		/* 同一生計 */
		replace samelive_mrsp= 1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n13' ==1; /* 同一家計 */
		replace samelive_mrsp= 0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n13' ==9; /* 該当しない */

		/* 慢性的な日常生活の制限 disability*/
		replace disab_mrsp= 1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n14' ==1; /* 制限あり */
		replace disab_mrsp= 0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n14' ==9; /* 該当しない */

		/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
		replace handi_mrsp = 1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n15' ==1; /* 認定あり */
		replace handi_mrsp = 0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n15' ==9; /* 該当しない */

		};
	};

/* job_mrspの統合 */
replace job_mrsp = job_mrsp_j if job_mrsp_j!=.;
drop job_mrsp_j;

/* 70歳以上は誤記と考え、欠損値とする
foreach k of num 1/10{;
	replace age_mrsp=. if age_mrsp>70;

	replace mrsp=. 		if age_mrsp>70;
	replace dokyo_mrsp=.	if age_mrsp>70;
	replace mar_mrsp=.	if age_mrsp>70;
	replace job_mrsp=.	if age_mrsp>70;
};
 */
/* 年齢の補完 */
	/* -1は0歳にする */
	replace age_mrsp=0 if age_mrsp <0 & age_mrsp !=.;

label var mrsp "1:配偶者の母親あり";
label var dokyo_mrsp "1:配偶者の母親と同居";
label var mar_mrsp "1:配偶者の母親既婚";
label var job_mrsp  "1:配偶者の母親就業";
label var age_mrsp  "配偶者の母親年齢(歳)";

/* 記述統計 */
sum mrsp male_mrsp mar_mrsp dokyo_mrsp job_mrsp
age_mrsp edu_mrsp chng_mrsp deth_mrsp time_mrsp
nocntct_mrsp samelive_mrsp disab_mrsp handi_mrsp, separator(0);

/*
チェック用
browse v1 year v13 v15 v20 v22 v27 v29  v34 v36 v41 v43 v48 v50 v55 v57 v62 v64 v69 v71  agemrsp1 agemrsp2 agemrsp3 agemrsp4 agemrsp5 agemrsp6 
browse v1 year agemrsp1 agemrsp2 agemrsp3 agemrsp4 agemrsp5 agemrsp6 dokyo_mrsp1-dokyo_mrsp6
*/

/*
keep id v1 year mrsp_n mrsp1-mrsp6 dokyo_mrsp1-dokyo_mrsp6 male_mrsp1-male_mrsp6 mar_mrsp1-mar_mrsp6 
job_mrsp1-job_mrsp6 birthy_mrsp1-birthy_mrsp6  agemrsp1-agemrsp6 
edu_mrsp1-edu_mrsp4 deth_mrsp1-deth_mrsp4 time_mrsp1-time_mrsp4 nocntct_mrsp1-nocntct_mrsp4 samelive_mrsp1-samelive_mrsp4
disab_mrsp1-disab_mrsp4 handi_mrsp1-handi_mrsp4
mrspoh1-mrspoh5 male_mrspoh1-male_mrspoh5 age_mrspoh1-age_mrspoh5 tel_mrspoh1-tel_mrspoh5
hous_mrspoh1-hous_mrspoh5 mrsp_n mrspoh_n mrsp_s
male_mrspoh1-male_mrspoh5 age_mrspoh1-age_mrspoh5 tel_mrspoh1-tel_mrspoh5 hous_mrspoh1-hous_mrspoh5
rsn_mrspoh1-rsn_mrspoh5;

save mrsp_data.dta, replace;


log close;
exit;

*/


