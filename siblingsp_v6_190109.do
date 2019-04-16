#delimit;

global ly 2018; /* 最新調査年度 */

/*** 家族表　配偶者のきょうだい関連変数 ***/

foreach k of num 1/10{;
	gen sibsp`k'=.;				/* 配偶者のきょうだいの有無 */
	gen male_sibsp`k'=.;		/* 性別 */
	gen birthy_sibsp`k'=.;		/* 生まれ年 */
	gen age_sibsp`k'=.;			/* 年齢 */
	gen job_sibsp`k'=.;			/* 就労 */
	gen job_sibsp`k'_j=.;		/* 就労 (K2014～ / J2009～) */
	gen dokyo_sibsp`k'=.;		/* 同居 */
	gen mar_sibsp`k'=.;			/* 有配偶 */
	gen edu_sibsp`k'=.;			/* 最終学歴 */
	gen chng_sibsp`k'=.;		/* 家族関係の変化 */
	gen deth_sibsp`k'=.;		/* 死別 */
	gen time1_sibsp`k'=.;		/* 対象者の家からかかる時間（時間） */
	gen time2_sibsp`k'=.;		/* 対象者の家からかかる時間（分） */
	gen time_sibsp`k'=.;		/* 対象者の家からかかる時間（合計・分） */
	gen nocntct_sibsp`k'=.;		/* 連絡がつかない */
	gen samelive_sibsp`k'=.;	/* 生計を同じにしている */
	gen disab_sibsp`k'=.;		/* 慢性的な日常活動の制限 */
	gen handi_sibsp`k'=.;		/* 要支援・要介護認定／障害支援区分の認定 */
	};

gen num_sibsp=0; /* 配偶者のきょうだいの数のカウント用 */

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

		replace num_sibsp=num_sibsp+1 if v`n0'==10 & year==`y';
		
		foreach k of num 1/10{;

			/* 配偶者のきょうだいの有無 */
			replace sibsp`k'=1 if v`n0'==10 & year==`y' & num_sibsp==`k';
			
			/* 性別 */
			replace male_sibsp`k'=1 if v`n0'==10 & year==`y' & num_sibsp==`k' & v`n1'==1; /* 男性 */
			replace male_sibsp`k'=0 if v`n0'==10 & year==`y' & num_sibsp==`k' & v`n1'==2; /* 女性 */
			
			/* 年齢 */
			replace birthy_sibsp`k'=v`n2' if v`n0'==10 & year==`y' & num_sibsp==`k' & v`n2'<7777;				/* 生まれ年 */
			replace age_sibsp`k'=`y'-v`n2' if v`n0'==10 & year==`y' & num_sibsp==`k' & v`n2'<7777 & v`n3'==1;	/* 年齢（1月生まれ） */
			replace age_sibsp`k'=`y'-v`n2'-1 if v`n0'==10 & year==`y' & num_sibsp==`k' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
			
			/* 就労 */
			replace job_sibsp`k'=1 if v`n0'==10 & year==`y' & num_sibsp==`k' & v`n4'==8;		/* 就労 (K2004～K2013) */
			replace job_sibsp`k'=0 if v`n0'==10 & year==`y' & num_sibsp==`k' & v`n4'!=8;		/* 非就労 (K2004～K2013) */
			replace job_sibsp`k'_j=1 if v`n0'==10 & year==`y' & num_sibsp==`k' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
			replace job_sibsp`k'_j=0 if v`n0'==10 & year==`y' & num_sibsp==`k' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
			local n4a=`n4a'+3;
			
			/* 同居 */
			replace dokyo_sibsp`k'=1 if v`n0'==10 & year==`y' & num_sibsp==`k' & v`n5'==1; /* 同居 */
			replace dokyo_sibsp`k'=0 if v`n0'==10 & year==`y' & num_sibsp==`k' & v`n5'==2; /* 別居 */
			
			/* 有配偶 */
			replace mar_sibsp`k'=0 if v`n0'==10 & year==`y' & num_sibsp==`k' & v`n6'==1; /* 無配偶 */
			replace mar_sibsp`k'=1 if v`n0'==10 & year==`y' & num_sibsp==`k' & v`n6'==2; /* 有配偶 */
			
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

		replace num_sibsp=num_sibsp+1 if v`n0'==11 & year==`y';
		
		foreach k of num 1/10{;

			/* 配偶者のきょうだいの有無 */
			replace sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k';
			
			/* 性別 */
			replace male_sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n1'==1; /* 男性 */
			replace male_sibsp`k'=0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n1'==2; /* 女性 */
			
			/* 年齢 */
			replace birthy_sibsp`k'=v`n2' if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n2'<7777;				/* 生まれ年 */
			replace age_sibsp`k'=`y'-v`n2' if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n2'<7777 & v`n3'==1;	/* 年齢（1月生まれ） */
			replace age_sibsp`k'=`y'-v`n2'-1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
			
			/* 就労 */
			replace job_sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n4'==8;		/* 就労 (K2004～K2013) */
			replace job_sibsp`k'=0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n4'!=8;		/* 非就労 (K2004～K2013) */
			replace job_sibsp`k'_j=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
			replace job_sibsp`k'_j=0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
			
			/* 同居 */
			replace dokyo_sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n5'==1; /* 同居 */
			replace dokyo_sibsp`k'=0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n5'==2; /* 別居 */
			
			/* 有配偶 */
			replace mar_sibsp`k'=0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n6'==1; /* 無配偶 */
			replace mar_sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n6'==2; /* 有配偶 */
			
			/* 最終学歴 */
			replace edu_sibsp`k'=v`n7' if v`n0'==11 & year==`y' & num_sibsp==`k'; 

			/* 家族関係の変化 */
			replace chng_sibsp`k'=v`n8' if v`n0'==11 & year==`y' & num_sibsp==`k';

			/* 家族関係の変化: 死別 */
			replace deth_sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n8'==2;				/* 死別 */
			replace deth_sibsp`k'=0 if v`n0'==11 & year==`y' & num_sibsp==`k' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

			/* 配偶関係・婚姻届けを出していない */
			replace mar_sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n9'==1; /* 事実婚 */

			/* 対象者の家からかかる時間（時間） */
			replace time1_sibsp`k'= v`n10' if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n10'<888;

			/* 対象者の家からかかる時間（分） */
			replace time2_sibsp`k'= v`n11' if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n11'<888;

			/* 対象者の家からかかる時間（合計・分） */
			replace time_sibsp`k'= time1_sibsp`k'*60+time2_sibsp`k'	if v`n0'==11 & year==`y' & num_sibsp==`k' & time1_sibsp`k'!=. & time2_sibsp`k'!=.;
			replace time_sibsp`k'= time1_sibsp`k'*60				if v`n0'==11 & year==`y' & num_sibsp==`k' & time1_sibsp`k'!=. & time2_sibsp`k'==.;
			replace time_sibsp`k'= time2_sibsp`k'					if v`n0'==11 & year==`y' & num_sibsp==`k' & time1_sibsp`k'==. & time2_sibsp`k'!=.;

			/* 連絡がつかない */
			replace nocntct_sibsp`k'= 1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n12'==1; /* 連絡がつかない */
			replace nocntct_sibsp`k'= 0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n12'==9; /* 該当しない */

			/* 同一生計 */
			replace samelive_sibsp`k'= 1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n13' ==1; /* 同一家計 */
			replace samelive_sibsp`k'= 0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n13' ==9; /* 該当しない */

			/* 慢性的な日常生活の制限 disability*/
			replace disab_sibsp`k'= 1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n14' ==1; /* 制限あり */
			replace disab_sibsp`k'= 0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n14' ==9; /* 該当しない */

			/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
			replace handi_sibsp`k' = 1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n15' ==1; /* 認定あり */
			replace handi_sibsp`k' = 0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n15' ==9; /* 該当しない */
			
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

		replace num_sibsp=num_sibsp+1 if v`n0'==11 & year==`y';
		
		foreach k of num 1/10{;

			/* 配偶者のきょうだいの有無 */
			replace sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k';
			
			/* 性別 */
			replace male_sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n1'==1; /* 男性 */
			replace male_sibsp`k'=0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n1'==2; /* 女性 */
			
			/* 年齢 */
			replace birthy_sibsp`k'=v`n2' if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n2'<7777;				/* 生まれ年 */
			replace age_sibsp`k'=`y'-v`n2' if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n2'<7777 & v`n3'==1;	/* 年齢（1月生まれ） */
			replace age_sibsp`k'=`y'-v`n2'-1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
			
			/* 就労 */
			replace job_sibsp`k'_j=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
			replace job_sibsp`k'_j=0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
			
			/* 同居 */
			replace dokyo_sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n5'==1; /* 同居 */
			replace dokyo_sibsp`k'=0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n5'==2; /* 別居 */
			
			/* 有配偶 */
			replace mar_sibsp`k'=0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n6'==1; /* 無配偶 */
			replace mar_sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n6'==2; /* 有配偶 */
			
			/* 最終学歴 */
			replace edu_sibsp`k'=v`n7' if v`n0'==11 & year==`y' & num_sibsp==`k'; 

			/* 家族関係の変化 */
			replace chng_sibsp`k'=v`n8' if v`n0'==11 & year==`y' & num_sibsp==`k';

			/* 家族関係の変化: 死別 */
			replace deth_sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n8'==2;				/* 死別 */
			replace deth_sibsp`k'=0 if v`n0'==11 & year==`y' & num_sibsp==`k' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

			/* 配偶関係・婚姻届けを出していない */
			replace mar_sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n9'==1; /* 事実婚 */

			/* 対象者の家からかかる時間（時間） */
			replace time1_sibsp`k'= v`n10' if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n10'<888;

			/* 対象者の家からかかる時間（分） */
			replace time2_sibsp`k'= v`n11' if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n11'<888;

			/* 対象者の家からかかる時間（合計・分） */
			replace time_sibsp`k'= time1_sibsp`k'*60+time2_sibsp`k'	if v`n0'==11 & year==`y' & num_sibsp==`k' & time1_sibsp`k'!=. & time2_sibsp`k'!=.;
			replace time_sibsp`k'= time1_sibsp`k'*60				if v`n0'==11 & year==`y' & num_sibsp==`k' & time1_sibsp`k'!=. & time2_sibsp`k'==.;
			replace time_sibsp`k'= time2_sibsp`k'					if v`n0'==11 & year==`y' & num_sibsp==`k' & time1_sibsp`k'==. & time2_sibsp`k'!=.;

			/* 連絡がつかない */
			replace nocntct_sibsp`k'= 1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n12'==1; /* 連絡がつかない */
			replace nocntct_sibsp`k'= 0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n12'==9; /* 該当しない */

			/* 同一生計 */
			replace samelive_sibsp`k'= 1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n13' ==1; /* 同一家計 */
			replace samelive_sibsp`k'= 0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n13' ==9; /* 該当しない */

			/* 慢性的な日常生活の制限 disability*/
			replace disab_sibsp`k'= 1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n14' ==1; /* 制限あり */
			replace disab_sibsp`k'= 0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n14' ==9; /* 該当しない */

			/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
			replace handi_sibsp`k' = 1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n15' ==1; /* 認定あり */
			replace handi_sibsp`k' = 0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n15' ==9; /* 該当しない */
			
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

		replace num_sibsp=num_sibsp+1 if v`n0'==11 & year==`y';
		
		foreach k of num 1/10{;

			/* 配偶者のきょうだいの有無 */
			replace sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k';
			
			/* 性別 */
			replace male_sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n1'==1; /* 男性 */
			replace male_sibsp`k'=0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n1'==2; /* 女性 */
			
			/* 年齢 */
			replace birthy_sibsp`k'=v`n2' if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n2'<7777;				/* 生まれ年 */
			replace age_sibsp`k'=`y'-v`n2' if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n2'<7777 & v`n3'==1;	/* 年齢（1月生まれ） */
			replace age_sibsp`k'=`y'-v`n2'-1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
			
			/* 就労 */
			replace job_sibsp`k'_j=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
			replace job_sibsp`k'_j=0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
			
			/* 同居 */
			replace dokyo_sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n5'==1; /* 同居 */
			replace dokyo_sibsp`k'=0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n5'==2; /* 別居 */
			
			/* 有配偶 */
			replace mar_sibsp`k'=0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n6'==1; /* 無配偶 */
			replace mar_sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n6'==2; /* 有配偶 */
			
			/* 最終学歴 */
			replace edu_sibsp`k'=v`n7' if v`n0'==11 & year==`y' & num_sibsp==`k'; 

			/* 家族関係の変化 */
			replace chng_sibsp`k'=v`n8' if v`n0'==11 & year==`y' & num_sibsp==`k';

			/* 家族関係の変化: 死別 */
			replace deth_sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n8'==2;				/* 死別 */
			replace deth_sibsp`k'=0 if v`n0'==11 & year==`y' & num_sibsp==`k' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

			/* 配偶関係・婚姻届けを出していない */
			replace mar_sibsp`k'=1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n9'==1; /* 事実婚 */

			/* 対象者の家からかかる時間（時間） */
			replace time1_sibsp`k'= v`n10' if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n10'<888;

			/* 対象者の家からかかる時間（分） */
			replace time2_sibsp`k'= v`n11' if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n11'<888;

			/* 対象者の家からかかる時間（合計・分） */
			replace time_sibsp`k'= time1_sibsp`k'*60+time2_sibsp`k'	if v`n0'==11 & year==`y' & num_sibsp==`k' & time1_sibsp`k'!=. & time2_sibsp`k'!=.;
			replace time_sibsp`k'= time1_sibsp`k'*60				if v`n0'==11 & year==`y' & num_sibsp==`k' & time1_sibsp`k'!=. & time2_sibsp`k'==.;
			replace time_sibsp`k'= time2_sibsp`k'					if v`n0'==11 & year==`y' & num_sibsp==`k' & time1_sibsp`k'==. & time2_sibsp`k'!=.;

			/* 連絡がつかない */
			replace nocntct_sibsp`k'= 1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n12'==1; /* 連絡がつかない */
			replace nocntct_sibsp`k'= 0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n12'==9; /* 該当しない */

			/* 同一生計 */
			replace samelive_sibsp`k'= 1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n13' ==1; /* 同一家計 */
			replace samelive_sibsp`k'= 0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n13' ==9; /* 該当しない */

			/* 慢性的な日常生活の制限 disability*/
			replace disab_sibsp`k'= 1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n14' ==1; /* 制限あり */
			replace disab_sibsp`k'= 0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n14' ==9; /* 該当しない */

			/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
			replace handi_sibsp`k' = 1 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n15' ==1; /* 認定あり */
			replace handi_sibsp`k' = 0 if v`n0'==11 & year==`y' & num_sibsp==`k' & v`n15' ==9; /* 該当しない */
			
			};
		};
	};

/* job_sibspの統合 */
foreach k of num 1/10{;
	replace job_sibsp`k' = job_sibsp`k'_j if job_sibsp`k'_j!=.;
	drop job_sibsp`k'_j;
};
/*
/* 70歳以上は誤記と考え、欠損値とする */
foreach k of num 1/10{;
	replace age_sibsp`k'=. if age_sibsp`k'>70;

	replace sibsp`k'=. 		if age_sibsp`k'>70;
	replace dokyo_sibsp`k'=.	if age_sibsp`k'>70;
	replace mar_sibsp`k'=.	if age_sibsp`k'>70;
	replace job_sibsp`k'=.	if age_sibsp`k'>70;
};
*/
/* 年齢の補完 */
foreach k of num 1/10{;
	/*
	agesibsp2
	agesibsp`i'[_n-1] = 4
	agesibsp`i'[_n] = .
	agesibsp`i'[_n+1] =6
	*/
	* replace agesibsp`i' =agesibsp`i'[_n-1]+1 if agesibsp`i'==. & agesibsp`i'[_n-1]!=. & agesibsp`i'[_n+1]!=. & v1[_n]==v1[_n-1] & v1[_n]==v1[_n+1] & attr==0;
	
	/* 次のようなケースの修正
	   agesibsp`i'[_n-1] = 25
	   agesibsp`i'[_n] =  55
	   agesibsp`i'[_n+1] = 27
	*/
/*
	replace agesibsp`i' = agesibsp`i'[_n-1]+1 if agesibsp`i'[_n-1]!=. 
						& sibsp`i'==1 & agesibsp`i'!=agesibsp`i'[_n-1]+1 
						& v1[_n]==v1[_n-1] & attr==0;
*/
	/* -1は0歳にする */
	replace age_sibsp`k'=0 if age_sibsp`k' <0 & age_sibsp`k' !=.;
};

foreach k of num 1/10{;
	label var sibsp`k' "1:`k'人目の配偶者のきょうだい";
	label var dokyo_sibsp`k' "1:`k'人目の配偶者のきょうだいと同居";
	label var mar_sibsp`k' "1:`k'人目の配偶者のきょうだい既婚";
	label var job_sibsp`k'  "1:`k'人目の配偶者のきょうだい就業";
	label var age_sibsp`k'  "`k'人目の配偶者のきょうだい年齢(歳)";
};

/* 配偶者のきょうだい数 */
label var num_sibsp "家族票:配偶者のきょうだい数";
sum num_sibsp;

/* 配偶者の年齢 */


/* 兄弟姉妹数の計算 */
g male_sp2=0;
replace male_sp2=1 if v4==1&v5==2;
replace male_sp2=0 if v4==1&v5==1;
label var male_sp2 "1: 配偶者が男性（対象者情報から作成）";

g tmp_mar=0;
replace tmp_mar=1 if v4==1;
label var tmp_mar "1: 有配偶";

g num_eldbrosp=0; // 配偶者の兄の人数
g num_yngbrosp=0; // 配偶者の弟の人数
g num_eldsissp=0; // 配偶者の姉の人数
g num_yngsissp=0; // 配偶者の妹の人数

foreach k of num 1/10{;
	replace num_eldbrosp=num_eldbrosp+1 if age_sibsp`k'>age_sp  & tmp_mar==1 & male_sibsp`k'==1 & age_sibsp`k'!=. & male_sibsp`k'!=. & (year==2017|year==2018);
	replace num_yngbrosp=num_yngbrosp+1 if age_sibsp`k'<=age_sp & tmp_mar==1 & male_sibsp`k'==1 & age_sibsp`k'!=. & male_sibsp`k'!=. & (year==2017|year==2018);
	replace num_eldsissp=num_eldsissp+1 if age_sibsp`k'>age_sp  & tmp_mar==1 & male_sibsp`k'==0 & age_sibsp`k'!=. & male_sibsp`k'!=. & (year==2017|year==2018);
	replace num_yngsissp=num_yngsissp+1 if age_sibsp`k'<=age_sp & tmp_mar==1 & male_sibsp`k'==0 & age_sibsp`k'!=. & male_sibsp`k'!=. & (year==2017|year==2018);
	};
	
label var num_eldbrosp "配偶者の兄の人数";
label var num_yngbrosp "配偶者の弟の人数";
label var num_eldsissp "配偶者の姉の人数";
label var num_yngsissp "配偶者の妹の人数";

g eldestsonsp=0;
replace eldestsonsp=1 if male_sp2==1&num_eldbrosp==0;
label var eldestsonsp "1: 配偶者が長男";

g eldestkidsp=0;
replace eldestkidsp=1 if num_eldbrosp==0&num_eldsissp==0;
label var eldestkidsp "1: 配偶者が長子";

g onlykidsp=0;
replace onlykidsp=1 if num_sibsp==0;
label var onlykidsp "1: 対象者が一人っ子";

g num_brosp=num_eldbrosp+num_yngbrosp;
label var num_brosp "1: 配偶者の男兄弟の数";

/* 記述統計 */
foreach k of num 1/10{;
    sum sibsp`k' male_sibsp`k' mar_sibsp`k' dokyo_sibsp`k' job_sibsp`k'
    age_sibsp`k' edu_sibsp`k' chng_sibsp`k' deth_sibsp`k' time_sibsp`k'
    nocntct_sibsp`k' samelive_sibsp`k' disab_sibsp`k' handi_sibsp`k', separator(0);
};

/*
チェック用
browse v1 year v13 v15 v20 v22 v27 v29  v34 v36 v41 v43 v48 v50 v55 v57 v62 v64 v69 v71  agesibsp1 agesibsp2 agesibsp3 agesibsp4 agesibsp5 agesibsp6 
browse v1 year agesibsp1 agesibsp2 agesibsp3 agesibsp4 agesibsp5 agesibsp6 dokyo_sibsp1-dokyo_sibsp6
*/

/*
keep id v1 year sibsp_n sibsp1-sibsp6 dokyo_sibsp1-dokyo_sibsp6 male_sibsp1-male_sibsp6 mar_sibsp1-mar_sibsp6 
job_sibsp1-job_sibsp6 birthy_sibsp1-birthy_sibsp6  agesibsp1-agesibsp6 
edu_sibsp1-edu_sibsp4 deth_sibsp1-deth_sibsp4 time_sibsp1-time_sibsp4 nocntct_sibsp1-nocntct_sibsp4 samelive_sibsp1-samelive_sibsp4
disab_sibsp1-disab_sibsp4 handi_sibsp1-handi_sibsp4
sibspoh1-sibspoh5 male_sibspoh1-male_sibspoh5 age_sibspoh1-age_sibspoh5 tel_sibspoh1-tel_sibspoh5
hous_sibspoh1-hous_sibspoh5 sibsp_n sibspoh_n sibsp_s
male_sibspoh1-male_sibspoh5 age_sibspoh1-age_sibspoh5 tel_sibspoh1-tel_sibspoh5 hous_sibspoh1-hous_sibspoh5
rsn_sibspoh1-rsn_sibspoh5;

save sibsp_data.dta, replace;


log close;
exit;

*/


