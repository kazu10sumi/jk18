#delimit;

global ly 2018; /* 最新調査年度 */

/*** 家族表　きょうだい関連変数 ***/

foreach k of num 1/10{;
	gen sib`k'=.;			/* きょうだいの有無 */
	gen male_sib`k'=.;		/* 性別 */
	gen birthy_sib`k'=.;	/* 生まれ年 */
	gen age_sib`k'=.;		/* 年齢 */
	gen job_sib`k'=.;		/* 就労 */
	gen job_sib`k'_j=.;		/* 就労 (K2014～ / J2009～) */
	gen dokyo_sib`k'=.;		/* 同居 */
	gen mar_sib`k'=.;		/* 有配偶 */
	gen edu_sib`k'=.;		/* 最終学歴 */
	gen chng_sib`k'=.;		/* 家族関係の変化 */
	gen deth_sib`k'=.;		/* 死別 */
	gen time1_sib`k'=.;		/* 対象者の家からかかる時間（時間） */
	gen time2_sib`k'=.;		/* 対象者の家からかかる時間（分） */
	gen time_sib`k'=.;		/* 対象者の家からかかる時間（合計・分） */
	gen nocntct_sib`k'=.;	/* 連絡がつかない */
	gen samelive_sib`k'=.;	/* 生計を同じにしている */
	gen disab_sib`k'=.;		/* 慢性的な日常活動の制限 */
	gen handi_sib`k'=.;		/* 要支援・要介護認定／障害支援区分の認定 */
	};

gen num_sib=0; /* きょうだいの数のカウント用 */

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

		replace num_sib=num_sib+1 if v`n0'==9 & year==`y';
		
		foreach k of num 1/10{;

			/* きょうだいの有無 */
			replace sib`k'=1 if v`n0'==9 & year==`y' & num_sib==`k';
			
			/* 性別 */
			replace male_sib`k'=1 if v`n0'==9 & year==`y' & num_sib==`k' & v`n1'==1; /* 男性 */
			replace male_sib`k'=0 if v`n0'==9 & year==`y' & num_sib==`k' & v`n1'==2; /* 女性 */
			
			/* 年齢 */
			replace birthy_sib`k'=v`n2' if v`n0'==9 & year==`y' & num_sib==`k' & v`n2'<7777;					/* 生まれ年 */
			replace age_sib`k'=`y'-v`n2' if v`n0'==9 & year==`y' & num_sib==`k' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
			replace age_sib`k'=`y'-v`n2'-1 if v`n0'==9 & year==`y' & num_sib==`k' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
			
			/* 就労 */
			replace job_sib`k'=1 if v`n0'==9 & year==`y' & num_sib==`k' & v`n4'==8;		/* 就労 (K2004～K2013) */
			replace job_sib`k'=0 if v`n0'==9 & year==`y' & num_sib==`k' & v`n4'!=8;		/* 非就労 (K2004～K2013) */
			replace job_sib`k'_j=1 if v`n0'==9 & year==`y' & num_sib==`k' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
			replace job_sib`k'_j=0 if v`n0'==9 & year==`y' & num_sib==`k' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
			local n4a=`n4a'+3;
			
			/* 同居 */
			replace dokyo_sib`k'=1 if v`n0'==9 & year==`y' & num_sib==`k' & v`n5'==1; /* 同居 */
			replace dokyo_sib`k'=0 if v`n0'==9 & year==`y' & num_sib==`k' & v`n5'==2; /* 別居 */
			
			/* 有配偶 */
			replace mar_sib`k'=0 if v`n0'==9 & year==`y' & num_sib==`k' & v`n6'==1; /* 無配偶 */
			replace mar_sib`k'=1 if v`n0'==9 & year==`y' & num_sib==`k' & v`n6'==2; /* 有配偶 */
			
			};
		};
	};
	
/**************/
/* 2017年以降 */
/**************/

foreach y of num 2017/$ly{;

	/* 家族ID 2番～10番 */
	
	local n4a = 3015; 		/* 就労（K2014～ / J2009～） */
	local n7 = 3697;		/* 最終学歴 */
	local n8 = `n7'+1;		/* 家族関係の変化 */
	local n9 = `n7'+2;		/* 配偶関係・婚姻届を出していない */
	local n10 = `n7'+3;		/* 対象者の家からかかる時間（時間） */
	local n11 = `n7'+4;		/* 対象者の家からかかる時間（分） */
	local n12 = `n7'+5;		/* 連絡がつかない */
	local n13 = `n7'+6;		/* 生計を同じにしている */
	local n14 = `n7'+7;		/* 慢性的な日常活動の制限	 */
	local n15 = `n7'+8;		/* 要支援・要介護認定／障害支援区分の認定	 */
	
	foreach n0 of num 13(7)69{;	/* 続柄 */
		local n1 = `n0'+1;		/* 性別 */
		local n2 = `n0'+2;		/* 生まれ年 */
		local n3 = `n0'+3;		/* 生まれ月 */
		local n4 = `n0'+4;		/* 就労 */
		local n5 = `n0'+5;		/* 同居・別居 */
		local n6 = `n0'+6;		/* 未既婚 */

		replace num_sib=num_sib+1 if v`n0'==10 & year==`y';
		
		foreach k of num 1/10{;

			/* きょうだいの有無 */
			replace sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k';
			
			/* 性別 */
			replace male_sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n1'==1; /* 男性 */
			replace male_sib`k'=0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n1'==2; /* 女性 */
			
			/* 年齢 */
			replace birthy_sib`k'=v`n2' if v`n0'==10 & year==`y' & num_sib==`k' & v`n2'<7777;					/* 生まれ年 */
			replace age_sib`k'=`y'-v`n2' if v`n0'==10 & year==`y' & num_sib==`k' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
			replace age_sib`k'=`y'-v`n2'-1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
			
			/* 就労 */
			replace job_sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n4'==8;		/* 就労 (K2004～K2013) */
			replace job_sib`k'=0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n4'!=8;		/* 非就労 (K2004～K2013) */
			replace job_sib`k'_j=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
			replace job_sib`k'_j=0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
			
			/* 同居 */
			replace dokyo_sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n5'==1; /* 同居 */
			replace dokyo_sib`k'=0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n5'==2; /* 別居 */
			
			/* 有配偶 */
			replace mar_sib`k'=0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n6'==1; /* 無配偶 */
			replace mar_sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n6'==2; /* 有配偶 */
			
			/* 最終学歴 */
			replace edu_sib`k'=v`n7' if v`n0'==10 & year==`y' & num_sib==`k'; 

			/* 家族関係の変化 */
			replace chng_sib`k'=v`n8' if v`n0'==10 & year==`y' & num_sib==`k';

			/* 家族関係の変化: 死別 */
			replace deth_sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n8'==2;					/* 死別 */
			replace deth_sib`k'=0 if v`n0'==10 & year==`y' & num_sib==`k' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

			/* 配偶関係・婚姻届けを出していない */
			replace mar_sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n9'==1; /* 事実婚 */

			/* 対象者の家からかかる時間（時間） */
			replace time1_sib`k'= v`n10' if v`n0'==10 & year==`y' & num_sib==`k' & v`n10'<888;

			/* 対象者の家からかかる時間（分） */
			replace time2_sib`k'= v`n11' if v`n0'==10 & year==`y' & num_sib==`k' & v`n11'<888;

			/* 対象者の家からかかる時間（合計・分） */
			replace time_sib`k'= time1_sib`k'*60+time2_sib`k'	if v`n0'==10 & year==`y' & num_sib==`k' & time1_sib`k'!=. & time2_sib`k'!=.;
			replace time_sib`k'= time1_sib`k'*60				if v`n0'==10 & year==`y' & num_sib==`k' & time1_sib`k'!=. & time2_sib`k'==.;
			replace time_sib`k'= time2_sib`k'					if v`n0'==10 & year==`y' & num_sib==`k' & time1_sib`k'==. & time2_sib`k'!=.;

			/* 連絡がつかない */
			replace nocntct_sib`k'= 1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n12'==1; /* 連絡がつかない */
			replace nocntct_sib`k'= 0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n12'==9; /* 該当しない */

			/* 同一生計 */
			replace samelive_sib`k'= 1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n13' ==1; /* 同一家計 */
			replace samelive_sib`k'= 0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n13' ==9; /* 該当しない */

			/* 慢性的な日常生活の制限 disability*/
			replace disab_sib`k'= 1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n14' ==1; /* 制限あり */
			replace disab_sib`k'= 0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n14' ==9; /* 該当しない */

			/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
			replace handi_sib`k' = 1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n15' ==1; /* 認定あり */
			replace handi_sib`k' = 0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n15' ==9; /* 該当しない */
			
			};

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

		replace num_sib=num_sib+1 if v`n0'==10 & year==`y';
		
		foreach k of num 1/10{;

			/* きょうだいの有無 */
			replace sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k';
			
			/* 性別 */
			replace male_sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n1'==1; /* 男性 */
			replace male_sib`k'=0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n1'==2; /* 女性 */
			
			/* 年齢 */
			replace birthy_sib`k'=v`n2' if v`n0'==10 & year==`y' & num_sib==`k' & v`n2'<7777;					/* 生まれ年 */
			replace age_sib`k'=`y'-v`n2' if v`n0'==10 & year==`y' & num_sib==`k' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
			replace age_sib`k'=`y'-v`n2'-1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
			
			/* 就労 */
			replace job_sib`k'_j=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
			replace job_sib`k'_j=0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
			
			/* 同居 */
			replace dokyo_sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n5'==1; /* 同居 */
			replace dokyo_sib`k'=0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n5'==2; /* 別居 */
			
			/* 有配偶 */
			replace mar_sib`k'=0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n6'==1; /* 無配偶 */
			replace mar_sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n6'==2; /* 有配偶 */
			
			/* 最終学歴 */
			replace edu_sib`k'=v`n7' if v`n0'==10 & year==`y' & num_sib==`k'; 

			/* 家族関係の変化 */
			replace chng_sib`k'=v`n8' if v`n0'==10 & year==`y' & num_sib==`k';

			/* 家族関係の変化: 死別 */
			replace deth_sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n8'==2;					/* 死別 */
			replace deth_sib`k'=0 if v`n0'==10 & year==`y' & num_sib==`k' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

			/* 配偶関係・婚姻届けを出していない */
			replace mar_sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n9'==1; /* 事実婚 */

			/* 対象者の家からかかる時間（時間） */
			replace time1_sib`k'= v`n10' if v`n0'==10 & year==`y' & num_sib==`k' & v`n10'<888;

			/* 対象者の家からかかる時間（分） */
			replace time2_sib`k'= v`n11' if v`n0'==10 & year==`y' & num_sib==`k' & v`n11'<888;

			/* 対象者の家からかかる時間（合計・分） */
			replace time_sib`k'= time1_sib`k'*60+time2_sib`k'	if v`n0'==10 & year==`y' & num_sib==`k' & time1_sib`k'!=. & time2_sib`k'!=.;
			replace time_sib`k'= time1_sib`k'*60				if v`n0'==10 & year==`y' & num_sib==`k' & time1_sib`k'!=. & time2_sib`k'==.;
			replace time_sib`k'= time2_sib`k'					if v`n0'==10 & year==`y' & num_sib==`k' & time1_sib`k'==. & time2_sib`k'!=.;

			/* 連絡がつかない */
			replace nocntct_sib`k'= 1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n12'==1; /* 連絡がつかない */
			replace nocntct_sib`k'= 0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n12'==9; /* 該当しない */

			/* 同一生計 */
			replace samelive_sib`k'= 1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n13' ==1; /* 同一家計 */
			replace samelive_sib`k'= 0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n13' ==9; /* 該当しない */

			/* 慢性的な日常生活の制限 disability*/
			replace disab_sib`k'= 1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n14' ==1; /* 制限あり */
			replace disab_sib`k'= 0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n14' ==9; /* 該当しない */

			/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
			replace handi_sib`k' = 1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n15' ==1; /* 認定あり */
			replace handi_sib`k' = 0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n15' ==9; /* 該当しない */
			
			};
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

		replace num_sib=num_sib+1 if v`n0'==10 & year==`y';
		
		foreach k of num 1/10{;

			/* きょうだいの有無 */
			replace sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k';
			
			/* 性別 */
			replace male_sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n1'==1; /* 男性 */
			replace male_sib`k'=0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n1'==2; /* 女性 */
			
			/* 年齢 */
			replace birthy_sib`k'=v`n2' if v`n0'==10 & year==`y' & num_sib==`k' & v`n2'<7777;					/* 生まれ年 */
			replace age_sib`k'=`y'-v`n2' if v`n0'==10 & year==`y' & num_sib==`k' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
			replace age_sib`k'=`y'-v`n2'-1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
			
			/* 就労 */
			replace job_sib`k'_j=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
			replace job_sib`k'_j=0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
			
			/* 同居 */
			replace dokyo_sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n5'==1; /* 同居 */
			replace dokyo_sib`k'=0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n5'==2; /* 別居 */
			
			/* 有配偶 */
			replace mar_sib`k'=0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n6'==1; /* 無配偶 */
			replace mar_sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n6'==2; /* 有配偶 */
			
			/* 最終学歴 */
			replace edu_sib`k'=v`n7' if v`n0'==10 & year==`y' & num_sib==`k'; 

			/* 家族関係の変化 */
			replace chng_sib`k'=v`n8' if v`n0'==10 & year==`y' & num_sib==`k';

			/* 家族関係の変化: 死別 */
			replace deth_sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n8'==2;					/* 死別 */
			replace deth_sib`k'=0 if v`n0'==10 & year==`y' & num_sib==`k' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

			/* 配偶関係・婚姻届けを出していない */
			replace mar_sib`k'=1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n9'==1; /* 事実婚 */

			/* 対象者の家からかかる時間（時間） */
			replace time1_sib`k'= v`n10' if v`n0'==10 & year==`y' & num_sib==`k' & v`n10'<888;

			/* 対象者の家からかかる時間（分） */
			replace time2_sib`k'= v`n11' if v`n0'==10 & year==`y' & num_sib==`k' & v`n11'<888;

			/* 対象者の家からかかる時間（合計・分） */
			replace time_sib`k'= time1_sib`k'*60+time2_sib`k'	if v`n0'==10 & year==`y' & num_sib==`k' & time1_sib`k'!=. & time2_sib`k'!=.;
			replace time_sib`k'= time1_sib`k'*60				if v`n0'==10 & year==`y' & num_sib==`k' & time1_sib`k'!=. & time2_sib`k'==.;
			replace time_sib`k'= time2_sib`k'					if v`n0'==10 & year==`y' & num_sib==`k' & time1_sib`k'==. & time2_sib`k'!=.;

			/* 連絡がつかない */
			replace nocntct_sib`k'= 1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n12'==1; /* 連絡がつかない */
			replace nocntct_sib`k'= 0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n12'==9; /* 該当しない */

			/* 同一生計 */
			replace samelive_sib`k'= 1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n13' ==1; /* 同一家計 */
			replace samelive_sib`k'= 0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n13' ==9; /* 該当しない */

			/* 慢性的な日常生活の制限 disability*/
			replace disab_sib`k'= 1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n14' ==1; /* 制限あり */
			replace disab_sib`k'= 0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n14' ==9; /* 該当しない */

			/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
			replace handi_sib`k' = 1 if v`n0'==10 & year==`y' & num_sib==`k' & v`n15' ==1; /* 認定あり */
			replace handi_sib`k' = 0 if v`n0'==10 & year==`y' & num_sib==`k' & v`n15' ==9; /* 該当しない */
			
			};
		};
	};

/* job_sibの統合 */
foreach k of num 1/10{;
	replace job_sib`k' = job_sib`k'_j if job_sib`k'_j!=.;
	drop job_sib`k'_j;
};
/*
/* 70歳以上は誤記と考え、欠損値とする */
foreach k of num 1/10{;
	replace age_sib`k'=. if age_sib`k'>70;

	replace sib`k'=. 		if age_sib`k'>70;
	replace dokyo_sib`k'=.	if age_sib`k'>70;
	replace mar_sib`k'=.	if age_sib`k'>70;
	replace job_sib`k'=.	if age_sib`k'>70;
};
*/
/* 年齢の補完 */
foreach k of num 1/10{;
	/*
	agesib2
	agesib`i'[_n-1] = 4
	agesib`i'[_n] = .
	agesib`i'[_n+1] =6
	*/
	* replace agesib`i' =agesib`i'[_n-1]+1 if agesib`i'==. & agesib`i'[_n-1]!=. & agesib`i'[_n+1]!=. & v1[_n]==v1[_n-1] & v1[_n]==v1[_n+1] & attr==0;
	
	/* 次のようなケースの修正
	   agesib`i'[_n-1] = 25
	   agesib`i'[_n] =  55
	   agesib`i'[_n+1] = 27
	*/
/*
	replace agesib`i' = agesib`i'[_n-1]+1 if agesib`i'[_n-1]!=. 
						& sib`i'==1 & agesib`i'!=agesib`i'[_n-1]+1 
						& v1[_n]==v1[_n-1] & attr==0;
*/
	/* -1は0歳にする */
	replace age_sib`k'=0 if age_sib`k' <0 & age_sib`k' !=.;
};

foreach k of num 1/10{;
	label var sib`k' "1:`k'人目のきょうだい";
	label var dokyo_sib`k' "1:`k'人目のきょうだいと同居";
	label var mar_sib`k' "1:`k'人目のきょうだい既婚";
	label var job_sib`k'  "1:`k'人目のきょうだい就業";
	label var age_sib`k'  "`k'人目のきょうだい年齢(歳)";
};

/* きょうだい数 */
label var num_sib "家族票:きょうだい数";
sum num_sib;

/* 兄弟姉妹数の計算 */
g age_resp=.;
replace age_resp=year-v6 if v7==1;
replace age_resp=year-v6-1 if v7!=1;
label var age_resp "対象者の年齢";

g male_resp=.;
replace male_resp=1 if v5==1;
replace male_resp=0 if v5==2;
label var male_resp "1: 対象者が男性";

g num_eldbro=0; // 兄の人数
g num_yngbro=0; // 弟の人数
g num_eldsis=0; // 姉の人数
g num_yngsis=0; // 妹の人数

foreach k of num 1/10{;
	replace num_eldbro=num_eldbro+1 if age_sib`k'>age_resp  & male_sib`k'==1 & age_sib`k'!=. & male_sib`k'!=. & (year==2017|year==2018);
	replace num_yngbro=num_yngbro+1 if age_sib`k'<=age_resp & male_sib`k'==1 & age_sib`k'!=. & male_sib`k'!=. & (year==2017|year==2018);
	replace num_eldsis=num_eldsis+1 if age_sib`k'>age_resp  & male_sib`k'==0 & age_sib`k'!=. & male_sib`k'!=. & (year==2017|year==2018);
	replace num_yngsis=num_yngsis+1 if age_sib`k'<=age_resp & male_sib`k'==0 & age_sib`k'!=. & male_sib`k'!=. & (year==2017|year==2018);
	};
	
label var num_eldbro "兄の人数";
label var num_yngbro "弟の人数";
label var num_eldsis "姉の人数";
label var num_yngsis "妹の人数";

g eldestson=0;
replace eldestson=1 if male_resp==1&num_eldbro==0;
label var eldestson "1: 対象者が長男";

g eldestkid=0;
replace eldestkid=1 if num_eldbro==0&num_eldsis==0;
label var eldestkid "1: 対象者が長子";

g onlykid=0;
replace onlykid=1 if num_sib==0;
label var onlykid "1: 対象者が一人っ子";

g num_bro=num_eldbro+num_yngbro;
label var num_bro "1: 男兄弟の数";

/* 記述統計 */
foreach k of num 1/10{;
    sum sib`k' male_sib`k' mar_sib`k' dokyo_sib`k' job_sib`k'
    age_sib`k' edu_sib`k' chng_sib`k' deth_sib`k' time_sib`k'
    nocntct_sib`k' samelive_sib`k' disab_sib`k' handi_sib`k', separator(0);
};

/*
チェック用
browse v1 year v13 v15 v20 v22 v27 v29  v34 v36 v41 v43 v48 v50 v55 v57 v62 v64 v69 v71  agesib1 agesib2 agesib3 agesib4 agesib5 agesib6 
browse v1 year agesib1 agesib2 agesib3 agesib4 agesib5 agesib6 dokyo_sib1-dokyo_sib6
*/

/*
keep id v1 year sib_n sib1-sib6 dokyo_sib1-dokyo_sib6 male_sib1-male_sib6 mar_sib1-mar_sib6 
job_sib1-job_sib6 birthy_sib1-birthy_sib6  agesib1-agesib6 
edu_sib1-edu_sib4 deth_sib1-deth_sib4 time_sib1-time_sib4 nocntct_sib1-nocntct_sib4 samelive_sib1-samelive_sib4
disab_sib1-disab_sib4 handi_sib1-handi_sib4
siboh1-siboh5 male_siboh1-male_siboh5 age_siboh1-age_siboh5 tel_siboh1-tel_siboh5
hous_siboh1-hous_siboh5 sib_n siboh_n sib_s
male_siboh1-male_siboh5 age_siboh1-age_siboh5 tel_siboh1-tel_siboh5 hous_siboh1-hous_siboh5
rsn_siboh1-rsn_siboh5;

save sib_data.dta, replace;


log close;
exit;

*/


