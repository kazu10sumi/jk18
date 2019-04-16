#delimit;

global ly 2018; /* 最新調査年度 */

/*** 家族表　母親関連変数 ***/

gen mr=.;			/* 母親の有無 */
gen male_mr=.;		/* 性別 */
gen birthy_mr=.;	/* 生まれ年 */
gen age_mr=.;		/* 年齢 */
gen job_mr=.;		/* 就労 */
gen job_mr_j=.;		/* 就労 (K2014～ / J2009～) */
gen dokyo_mr=.;		/* 同居 */
gen mar_mr=.;		/* 有配偶 */
gen edu_mr=.;		/* 最終学歴 */
gen chng_mr=.;		/* 家族関係の変化 */
gen deth_mr=.;		/* 死別 */
gen time1_mr=.;		/* 対象者の家からかかる時間（時間） */
gen time2_mr=.;		/* 対象者の家からかかる時間（分） */
gen time_mr=.;		/* 対象者の家からかかる時間（合計・分） */
gen nocntct_mr=.;	/* 連絡がつかない */
gen samelive_mr=.;	/* 生計を同じにしている */
gen disab_mr=.;		/* 慢性的な日常活動の制限 */
gen handi_mr=.;		/* 要支援・要介護認定／障害支援区分の認定 */

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

		/* 母親の有無 */
		replace mr=1 if v`n0'==5 & v`n1'==2 & year==`y';
		
		/* 性別 */
		replace male_mr=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n1'==2; /* 男性 */
		replace male_mr=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n1'==2; /* 女性 */
		
		/* 年齢 */
		replace birthy_mr=v`n2' if v`n0'==5 & v`n1'==2 & year==`y' & v`n2'<7777;					/* 生まれ年 */
		replace age_mr=`y'-v`n2' if v`n0'==5 & v`n1'==2 & year==`y' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
		replace age_mr=`y'-v`n2'-1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
		
		/* 就労 */
		replace job_mr=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n4'==8;		/* 就労 (K2004～K2013) */
		replace job_mr=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n4'!=8;		/* 非就労 (K2004～K2013) */
		replace job_mr_j=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
		replace job_mr_j=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
		local n4a=`n4a'+3;
		
		/* 同居 */
		replace dokyo_mr=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n5'==1; /* 同居 */
		replace dokyo_mr=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n5'==2; /* 別居 */
		
		/* 有配偶 */
		replace mar_mr=0 if v`n0'==5 & v`n1'==2 & year==`y' & v`n6'==1; /* 無配偶 */
		replace mar_mr=1 if v`n0'==5 & v`n1'==2 & year==`y' & v`n6'==2; /* 有配偶 */
			
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

		/* 母親の有無 */
		replace mr=1 if v`n0'==4 & v`n1'==2 & year==`y';
		
		/* 性別 */
		replace male_mr=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n1'==2; /* 男性 */
		replace male_mr=0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n1'==2; /* 女性 */
		
		/* 年齢 */
		replace birthy_mr=v`n2' if v`n0'==4 & v`n1'==2 & year==`y' & v`n2'<7777;					/* 生まれ年 */
		replace age_mr=`y'-v`n2' if v`n0'==4 & v`n1'==2 & year==`y' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
		replace age_mr=`y'-v`n2'-1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
		
		/* 就労 */
		replace job_mr=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n4'==8;		/* 就労 (K2004～K2013) */
		replace job_mr=0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n4'!=8;		/* 非就労 (K2004～K2013) */
		replace job_mr_j=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
		replace job_mr_j=0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
		
		/* 同居 */
		replace dokyo_mr=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n5'==1; /* 同居 */
		replace dokyo_mr=0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n5'==2; /* 別居 */
		
		/* 有配偶 */
		replace mar_mr=0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n6'==1; /* 無配偶 */
		replace mar_mr=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n6'==2; /* 有配偶 */
		
		/* 最終学歴 */
		replace edu_mr=v`n7' if v`n0'==4 & v`n1'==2 & year==`y'; 

		/* 家族関係の変化 */
		replace chng_mr=v`n8' if v`n0'==4 & v`n1'==2 & year==`y';

		/* 家族関係の変化: 死別 */
		replace deth_mr=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n8'==2;					/* 死別 */
		replace deth_mr=0 if v`n0'==4 & v`n1'==2 & year==`y' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

		/* 配偶関係・婚姻届けを出していない */
		replace mar_mr=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n9'==1; /* 事実婚 */

		/* 対象者の家からかかる時間（時間） */
		replace time1_mr= v`n10' if v`n0'==4 & v`n1'==2 & year==`y' & v`n10'<888;

		/* 対象者の家からかかる時間（分） */
		replace time2_mr= v`n11' if v`n0'==4 & v`n1'==2 & year==`y' & v`n11'<888;

		/* 対象者の家からかかる時間（合計・分） */
		replace time_mr= time1_mr*60+time2_mr	if v`n0'==4 & v`n1'==2 & year==`y' & time1_mr!=. & time2_mr!=.;
		replace time_mr= time1_mr*60				if v`n0'==4 & v`n1'==2 & year==`y' & time1_mr!=. & time2_mr==.;
		replace time_mr= time2_mr					if v`n0'==4 & v`n1'==2 & year==`y' & time1_mr==. & time2_mr!=.;

		/* 連絡がつかない */
		replace nocntct_mr= 1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n12'==1; /* 連絡がつかない */
		replace nocntct_mr= 0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n12'==9; /* 該当しない */

		/* 同一生計 */
		replace samelive_mr= 1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n13' ==1; /* 同一家計 */
		replace samelive_mr= 0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n13' ==9; /* 該当しない */

		/* 慢性的な日常生活の制限 disability*/
		replace disab_mr= 1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n14' ==1; /* 制限あり */
		replace disab_mr= 0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n14' ==9; /* 該当しない */

		/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
		replace handi_mr = 1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n15' ==1; /* 認定あり */
		replace handi_mr = 0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n15' ==9; /* 該当しない */

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

		/* 母親の有無 */
		replace mr=1 if v`n0'==4 & v`n1'==2 & year==`y';
		
		/* 性別 */
		replace male_mr=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n1'==2; /* 男性 */
		replace male_mr=0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n1'==2; /* 女性 */
		
		/* 年齢 */
		replace birthy_mr=v`n2' if v`n0'==4 & v`n1'==2 & year==`y' & v`n2'<7777;					/* 生まれ年 */
		replace age_mr=`y'-v`n2' if v`n0'==4 & v`n1'==2 & year==`y' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
		replace age_mr=`y'-v`n2'-1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
		
		/* 就労 */
		replace job_mr_j=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
		replace job_mr_j=0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
		
		/* 同居 */
		replace dokyo_mr=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n5'==1; /* 同居 */
		replace dokyo_mr=0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n5'==2; /* 別居 */
		
		/* 有配偶 */
		replace mar_mr=0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n6'==1; /* 無配偶 */
		replace mar_mr=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n6'==2; /* 有配偶 */
		
		/* 最終学歴 */
		replace edu_mr=v`n7' if v`n0'==4 & v`n1'==2 & year==`y'; 

		/* 家族関係の変化 */
		replace chng_mr=v`n8' if v`n0'==4 & v`n1'==2 & year==`y';

		/* 家族関係の変化: 死別 */
		replace deth_mr=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n8'==2;					/* 死別 */
		replace deth_mr=0 if v`n0'==4 & v`n1'==2 & year==`y' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

		/* 配偶関係・婚姻届けを出していない */
		replace mar_mr=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n9'==1; /* 事実婚 */

		/* 対象者の家からかかる時間（時間） */
		replace time1_mr= v`n10' if v`n0'==4 & v`n1'==2 & year==`y' & v`n10'<888;

		/* 対象者の家からかかる時間（分） */
		replace time2_mr= v`n11' if v`n0'==4 & v`n1'==2 & year==`y' & v`n11'<888;

		/* 対象者の家からかかる時間（合計・分） */
		replace time_mr= time1_mr*60+time2_mr	if v`n0'==4 & v`n1'==2 & year==`y' & time1_mr!=. & time2_mr!=.;
		replace time_mr= time1_mr*60				if v`n0'==4 & v`n1'==2 & year==`y' & time1_mr!=. & time2_mr==.;
		replace time_mr= time2_mr					if v`n0'==4 & v`n1'==2 & year==`y' & time1_mr==. & time2_mr!=.;

		/* 連絡がつかない */
		replace nocntct_mr= 1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n12'==1; /* 連絡がつかない */
		replace nocntct_mr= 0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n12'==9; /* 該当しない */

		/* 同一生計 */
		replace samelive_mr= 1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n13' ==1; /* 同一家計 */
		replace samelive_mr= 0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n13' ==9; /* 該当しない */

		/* 慢性的な日常生活の制限 disability*/
		replace disab_mr= 1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n14' ==1; /* 制限あり */
		replace disab_mr= 0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n14' ==9; /* 該当しない */

		/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
		replace handi_mr = 1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n15' ==1; /* 認定あり */
		replace handi_mr = 0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n15' ==9; /* 該当しない */
			
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

		/* 母親の有無 */
		replace mr=1 if v`n0'==4 & v`n1'==2 & year==`y';
		
		/* 性別 */
		replace male_mr=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n1'==2; /* 男性 */
		replace male_mr=0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n1'==2; /* 女性 */
		
		/* 年齢 */
		replace birthy_mr=v`n2' if v`n0'==4 & v`n1'==2 & year==`y' & v`n2'<7777;					/* 生まれ年 */
		replace age_mr=`y'-v`n2' if v`n0'==4 & v`n1'==2 & year==`y' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
		replace age_mr=`y'-v`n2'-1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
		
		/* 就労 */
		replace job_mr_j=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
		replace job_mr_j=0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
		
		/* 同居 */
		replace dokyo_mr=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n5'==1; /* 同居 */
		replace dokyo_mr=0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n5'==2; /* 別居 */
		
		/* 有配偶 */
		replace mar_mr=0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n6'==1; /* 無配偶 */
		replace mar_mr=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n6'==2; /* 有配偶 */
		
		/* 最終学歴 */
		replace edu_mr=v`n7' if v`n0'==4 & v`n1'==2 & year==`y'; 

		/* 家族関係の変化 */
		replace chng_mr=v`n8' if v`n0'==4 & v`n1'==2 & year==`y';

		/* 家族関係の変化: 死別 */
		replace deth_mr=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n8'==2;					/* 死別 */
		replace deth_mr=0 if v`n0'==4 & v`n1'==2 & year==`y' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

		/* 配偶関係・婚姻届けを出していない */
		replace mar_mr=1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n9'==1; /* 事実婚 */

		/* 対象者の家からかかる時間（時間） */
		replace time1_mr= v`n10' if v`n0'==4 & v`n1'==2 & year==`y' & v`n10'<888;

		/* 対象者の家からかかる時間（分） */
		replace time2_mr= v`n11' if v`n0'==4 & v`n1'==2 & year==`y' & v`n11'<888;

		/* 対象者の家からかかる時間（合計・分） */
		replace time_mr= time1_mr*60+time2_mr	if v`n0'==4 & v`n1'==2 & year==`y' & time1_mr!=. & time2_mr!=.;
		replace time_mr= time1_mr*60				if v`n0'==4 & v`n1'==2 & year==`y' & time1_mr!=. & time2_mr==.;
		replace time_mr= time2_mr					if v`n0'==4 & v`n1'==2 & year==`y' & time1_mr==. & time2_mr!=.;

		/* 連絡がつかない */
		replace nocntct_mr= 1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n12'==1; /* 連絡がつかない */
		replace nocntct_mr= 0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n12'==9; /* 該当しない */

		/* 同一生計 */
		replace samelive_mr= 1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n13' ==1; /* 同一家計 */
		replace samelive_mr= 0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n13' ==9; /* 該当しない */

		/* 慢性的な日常生活の制限 disability*/
		replace disab_mr= 1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n14' ==1; /* 制限あり */
		replace disab_mr= 0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n14' ==9; /* 該当しない */

		/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
		replace handi_mr = 1 if v`n0'==4 & v`n1'==2 & year==`y' & v`n15' ==1; /* 認定あり */
		replace handi_mr = 0 if v`n0'==4 & v`n1'==2 & year==`y' & v`n15' ==9; /* 該当しない */

		};
	};

/* job_mrの統合 */
replace job_mr = job_mr_j if job_mr_j!=.;
drop job_mr_j;

/* 70歳以上は誤記と考え、欠損値とする
foreach k of num 1/10{;
	replace age_mr=. if age_mr>70;

	replace mr=. 		if age_mr>70;
	replace dokyo_mr=.	if age_mr>70;
	replace mar_mr=.	if age_mr>70;
	replace job_mr=.	if age_mr>70;
};
 */
/* 年齢の補完 */
	/* -1は0歳にする */
	replace age_mr=0 if age_mr <0 & age_mr !=.;

label var mr "1:母親あり";
label var dokyo_mr "1:母親と同居";
label var mar_mr "1:母親既婚";
label var job_mr  "1:母親就業";
label var age_mr  "母親年齢(歳)";

/* 記述統計 */
sum mr male_mr mar_mr dokyo_mr job_mr
age_mr edu_mr chng_mr deth_mr time_mr
nocntct_mr samelive_mr disab_mr handi_mr, separator(0);

/*
チェック用
browse v1 year v13 v15 v20 v22 v27 v29  v34 v36 v41 v43 v48 v50 v55 v57 v62 v64 v69 v71  agemr1 agemr2 agemr3 agemr4 agemr5 agemr6 
browse v1 year agemr1 agemr2 agemr3 agemr4 agemr5 agemr6 dokyo_mr1-dokyo_mr6
*/

/*
keep id v1 year mr_n mr1-mr6 dokyo_mr1-dokyo_mr6 male_mr1-male_mr6 mar_mr1-mar_mr6 
job_mr1-job_mr6 birthy_mr1-birthy_mr6  agemr1-agemr6 
edu_mr1-edu_mr4 deth_mr1-deth_mr4 time_mr1-time_mr4 nocntct_mr1-nocntct_mr4 samelive_mr1-samelive_mr4
disab_mr1-disab_mr4 handi_mr1-handi_mr4
mroh1-mroh5 male_mroh1-male_mroh5 age_mroh1-age_mroh5 tel_mroh1-tel_mroh5
hous_mroh1-hous_mroh5 mr_n mroh_n mr_s
male_mroh1-male_mroh5 age_mroh1-age_mroh5 tel_mroh1-tel_mroh5 hous_mroh1-hous_mroh5
rsn_mroh1-rsn_mroh5;

save mr_data.dta, replace;


log close;
exit;

*/


