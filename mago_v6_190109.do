#delimit;

global ly 2018; /* 最新調査年度 */

/*** 家族表　孫関連変数 ***/

foreach k of num 1/10{;
	gen gkid`k'=.;			/* 孫の有無 */
	gen male_gkid`k'=.;		/* 性別 */
	gen birthy_gkid`k'=.;	/* 生まれ年 */
	gen age_gkid`k'=.;		/* 年齢 */
	gen job_gkid`k'=.;		/* 就労 */
	gen job_gkid`k'_j=.;		/* 就労 (K2014～ / J2009～) */
	gen dokyo_gkid`k'=.;		/* 同居 */
	gen mar_gkid`k'=.;		/* 有配偶 */
	gen edu_gkid`k'=.;		/* 最終学歴 */
	gen chng_gkid`k'=.;		/* 家族関係の変化 */
	gen deth_gkid`k'=.;		/* 死別 */
	gen time1_gkid`k'=.;		/* 対象者の家からかかる時間（時間） */
	gen time2_gkid`k'=.;		/* 対象者の家からかかる時間（分） */
	gen time_gkid`k'=.;		/* 対象者の家からかかる時間（合計・分） */
	gen nocntct_gkid`k'=.;	/* 連絡がつかない */
	gen samelive_gkid`k'=.;	/* 生計を同じにしている */
	gen disab_gkid`k'=.;		/* 慢性的な日常活動の制限 */
	gen handi_gkid`k'=.;		/* 要支援・要介護認定／障害支援区分の認定 */
	};

gen num_gkid=0; /* 孫の数のカウント用 */

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

		replace num_gkid=num_gkid+1 if v`n0'==4 & year==`y';
		
		foreach k of num 1/10{;

			/* 孫の有無 */
			replace gkid`k'=1 if v`n0'==4 & year==`y' & num_gkid==`k';
			
			/* 性別 */
			replace male_gkid`k'=1 if v`n0'==4 & year==`y' & num_gkid==`k' & v`n1'==1; /* 男性 */
			replace male_gkid`k'=0 if v`n0'==4 & year==`y' & num_gkid==`k' & v`n1'==2; /* 女性 */
			
			/* 年齢 */
			replace birthy_gkid`k'=v`n2' if v`n0'==4 & year==`y' & num_gkid==`k' & v`n2'<7777;					/* 生まれ年 */
			replace age_gkid`k'=`y'-v`n2' if v`n0'==4 & year==`y' & num_gkid==`k' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
			replace age_gkid`k'=`y'-v`n2'-1 if v`n0'==4 & year==`y' & num_gkid==`k' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
			
			/* 就労 */
			replace job_gkid`k'=1 if v`n0'==4 & year==`y' & num_gkid==`k' & v`n4'==8;		/* 就労 (K2004～K2013) */
			replace job_gkid`k'=0 if v`n0'==4 & year==`y' & num_gkid==`k' & v`n4'!=8;		/* 非就労 (K2004～K2013) */
			replace job_gkid`k'_j=1 if v`n0'==4 & year==`y' & num_gkid==`k' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
			replace job_gkid`k'_j=0 if v`n0'==4 & year==`y' & num_gkid==`k' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
			local n4a=`n4a'+3;
			
			/* 同居 */
			replace dokyo_gkid`k'=1 if v`n0'==4 & year==`y' & num_gkid==`k' & v`n5'==1; /* 同居 */
			replace dokyo_gkid`k'=0 if v`n0'==4 & year==`y' & num_gkid==`k' & v`n5'==2; /* 別居 */
			
			/* 有配偶 */
			replace mar_gkid`k'=0 if v`n0'==4 & year==`y' & num_gkid==`k' & v`n6'==1; /* 無配偶 */
			replace mar_gkid`k'=1 if v`n0'==4 & year==`y' & num_gkid==`k' & v`n6'==2; /* 有配偶 */
			
			};
		};
	};
	

/* 2016年以前の世帯外の孫についてはとりあえず考えない（後ほど検討） */	

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

		replace num_gkid=num_gkid+1 if v`n0'==6 & year==`y';
		
		foreach k of num 1/10{;

			/* 孫の有無 */
			replace gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k';
			
			/* 性別 */
			replace male_gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n1'==1; /* 男性 */
			replace male_gkid`k'=0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n1'==2; /* 女性 */
			
			/* 年齢 */
			replace birthy_gkid`k'=v`n2' if v`n0'==6 & year==`y' & num_gkid==`k' & v`n2'<7777;					/* 生まれ年 */
			replace age_gkid`k'=`y'-v`n2' if v`n0'==6 & year==`y' & num_gkid==`k' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
			replace age_gkid`k'=`y'-v`n2'-1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
			
			/* 就労 */
			replace job_gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n4'==8;		/* 就労 (K2004～K2013) */
			replace job_gkid`k'=0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n4'!=8;		/* 非就労 (K2004～K2013) */
			replace job_gkid`k'_j=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
			replace job_gkid`k'_j=0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
			
			/* 同居 */
			replace dokyo_gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n5'==1; /* 同居 */
			replace dokyo_gkid`k'=0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n5'==2; /* 別居 */
			
			/* 有配偶 */
			replace mar_gkid`k'=0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n6'==1; /* 無配偶 */
			replace mar_gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n6'==2; /* 有配偶 */
			
			/* 最終学歴 */
			replace edu_gkid`k'=v`n7' if v`n0'==6 & year==`y' & num_gkid==`k'; 

			/* 家族関係の変化 */
			replace chng_gkid`k'=v`n8' if v`n0'==6 & year==`y' & num_gkid==`k';

			/* 家族関係の変化: 死別 */
			replace deth_gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n8'==2;					/* 死別 */
			replace deth_gkid`k'=0 if v`n0'==6 & year==`y' & num_gkid==`k' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

			/* 配偶関係・婚姻届けを出していない */
			replace mar_gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n9'==1; /* 事実婚 */

			/* 対象者の家からかかる時間（時間） */
			replace time1_gkid`k'= v`n10' if v`n0'==6 & year==`y' & num_gkid==`k' & v`n10'<888;

			/* 対象者の家からかかる時間（分） */
			replace time2_gkid`k'= v`n11' if v`n0'==6 & year==`y' & num_gkid==`k' & v`n11'<888;

			/* 対象者の家からかかる時間（合計・分） */
			replace time_gkid`k'= time1_gkid`k'*60+time2_gkid`k'	if v`n0'==6 & year==`y' & num_gkid==`k' & time1_gkid`k'!=. & time2_gkid`k'!=.;
			replace time_gkid`k'= time1_gkid`k'*60				if v`n0'==6 & year==`y' & num_gkid==`k' & time1_gkid`k'!=. & time2_gkid`k'==.;
			replace time_gkid`k'= time2_gkid`k'					if v`n0'==6 & year==`y' & num_gkid==`k' & time1_gkid`k'==. & time2_gkid`k'!=.;

			/* 連絡がつかない */
			replace nocntct_gkid`k'= 1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n12'==1; /* 連絡がつかない */
			replace nocntct_gkid`k'= 0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n12'==9; /* 該当しない */

			/* 同一生計 */
			replace samelive_gkid`k'= 1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n13' ==1; /* 同一家計 */
			replace samelive_gkid`k'= 0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n13' ==9; /* 該当しない */

			/* 慢性的な日常生活の制限 disability*/
			replace disab_gkid`k'= 1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n14' ==1; /* 制限あり */
			replace disab_gkid`k'= 0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n14' ==9; /* 該当しない */

			/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
			replace handi_gkid`k' = 1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n15' ==1; /* 認定あり */
			replace handi_gkid`k' = 0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n15' ==9; /* 該当しない */
			
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

		replace num_gkid=num_gkid+1 if v`n0'==6 & year==`y';
		
		foreach k of num 1/10{;

			/* 孫の有無 */
			replace gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k';
			
			/* 性別 */
			replace male_gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n1'==1; /* 男性 */
			replace male_gkid`k'=0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n1'==2; /* 女性 */
			
			/* 年齢 */
			replace birthy_gkid`k'=v`n2' if v`n0'==6 & year==`y' & num_gkid==`k' & v`n2'<7777;					/* 生まれ年 */
			replace age_gkid`k'=`y'-v`n2' if v`n0'==6 & year==`y' & num_gkid==`k' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
			replace age_gkid`k'=`y'-v`n2'-1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
			
			/* 就労 */
			replace job_gkid`k'_j=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
			replace job_gkid`k'_j=0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
			
			/* 同居 */
			replace dokyo_gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n5'==1; /* 同居 */
			replace dokyo_gkid`k'=0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n5'==2; /* 別居 */
			
			/* 有配偶 */
			replace mar_gkid`k'=0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n6'==1; /* 無配偶 */
			replace mar_gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n6'==2; /* 有配偶 */
			
			/* 最終学歴 */
			replace edu_gkid`k'=v`n7' if v`n0'==6 & year==`y' & num_gkid==`k'; 

			/* 家族関係の変化 */
			replace chng_gkid`k'=v`n8' if v`n0'==6 & year==`y' & num_gkid==`k';

			/* 家族関係の変化: 死別 */
			replace deth_gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n8'==2;					/* 死別 */
			replace deth_gkid`k'=0 if v`n0'==6 & year==`y' & num_gkid==`k' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

			/* 配偶関係・婚姻届けを出していない */
			replace mar_gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n9'==1; /* 事実婚 */

			/* 対象者の家からかかる時間（時間） */
			replace time1_gkid`k'= v`n10' if v`n0'==6 & year==`y' & num_gkid==`k' & v`n10'<888;

			/* 対象者の家からかかる時間（分） */
			replace time2_gkid`k'= v`n11' if v`n0'==6 & year==`y' & num_gkid==`k' & v`n11'<888;

			/* 対象者の家からかかる時間（合計・分） */
			replace time_gkid`k'= time1_gkid`k'*60+time2_gkid`k'	if v`n0'==6 & year==`y' & num_gkid==`k' & time1_gkid`k'!=. & time2_gkid`k'!=.;
			replace time_gkid`k'= time1_gkid`k'*60				if v`n0'==6 & year==`y' & num_gkid==`k' & time1_gkid`k'!=. & time2_gkid`k'==.;
			replace time_gkid`k'= time2_gkid`k'					if v`n0'==6 & year==`y' & num_gkid==`k' & time1_gkid`k'==. & time2_gkid`k'!=.;

			/* 連絡がつかない */
			replace nocntct_gkid`k'= 1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n12'==1; /* 連絡がつかない */
			replace nocntct_gkid`k'= 0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n12'==9; /* 該当しない */

			/* 同一生計 */
			replace samelive_gkid`k'= 1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n13' ==1; /* 同一家計 */
			replace samelive_gkid`k'= 0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n13' ==9; /* 該当しない */

			/* 慢性的な日常生活の制限 disability*/
			replace disab_gkid`k'= 1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n14' ==1; /* 制限あり */
			replace disab_gkid`k'= 0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n14' ==9; /* 該当しない */

			/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
			replace handi_gkid`k' = 1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n15' ==1; /* 認定あり */
			replace handi_gkid`k' = 0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n15' ==9; /* 該当しない */
			
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

		replace num_gkid=num_gkid+1 if v`n0'==6 & year==`y';
		
		foreach k of num 1/10{;

			/* 孫の有無 */
			replace gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k';
			
			/* 性別 */
			replace male_gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n1'==1; /* 男性 */
			replace male_gkid`k'=0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n1'==2; /* 女性 */
			
			/* 年齢 */
			replace birthy_gkid`k'=v`n2' if v`n0'==6 & year==`y' & num_gkid==`k' & v`n2'<7777;					/* 生まれ年 */
			replace age_gkid`k'=`y'-v`n2' if v`n0'==6 & year==`y' & num_gkid==`k' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
			replace age_gkid`k'=`y'-v`n2'-1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
			
			/* 就労 */
			replace job_gkid`k'_j=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
			replace job_gkid`k'_j=0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
			
			/* 同居 */
			replace dokyo_gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n5'==1; /* 同居 */
			replace dokyo_gkid`k'=0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n5'==2; /* 別居 */
			
			/* 有配偶 */
			replace mar_gkid`k'=0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n6'==1; /* 無配偶 */
			replace mar_gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n6'==2; /* 有配偶 */
			
			/* 最終学歴 */
			replace edu_gkid`k'=v`n7' if v`n0'==6 & year==`y' & num_gkid==`k'; 

			/* 家族関係の変化 */
			replace chng_gkid`k'=v`n8' if v`n0'==6 & year==`y' & num_gkid==`k';

			/* 家族関係の変化: 死別 */
			replace deth_gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n8'==2;					/* 死別 */
			replace deth_gkid`k'=0 if v`n0'==6 & year==`y' & num_gkid==`k' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

			/* 配偶関係・婚姻届けを出していない */
			replace mar_gkid`k'=1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n9'==1; /* 事実婚 */

			/* 対象者の家からかかる時間（時間） */
			replace time1_gkid`k'= v`n10' if v`n0'==6 & year==`y' & num_gkid==`k' & v`n10'<888;

			/* 対象者の家からかかる時間（分） */
			replace time2_gkid`k'= v`n11' if v`n0'==6 & year==`y' & num_gkid==`k' & v`n11'<888;

			/* 対象者の家からかかる時間（合計・分） */
			replace time_gkid`k'= time1_gkid`k'*60+time2_gkid`k'	if v`n0'==6 & year==`y' & num_gkid==`k' & time1_gkid`k'!=. & time2_gkid`k'!=.;
			replace time_gkid`k'= time1_gkid`k'*60				if v`n0'==6 & year==`y' & num_gkid==`k' & time1_gkid`k'!=. & time2_gkid`k'==.;
			replace time_gkid`k'= time2_gkid`k'					if v`n0'==6 & year==`y' & num_gkid==`k' & time1_gkid`k'==. & time2_gkid`k'!=.;

			/* 連絡がつかない */
			replace nocntct_gkid`k'= 1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n12'==1; /* 連絡がつかない */
			replace nocntct_gkid`k'= 0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n12'==9; /* 該当しない */

			/* 同一生計 */
			replace samelive_gkid`k'= 1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n13' ==1; /* 同一家計 */
			replace samelive_gkid`k'= 0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n13' ==9; /* 該当しない */

			/* 慢性的な日常生活の制限 disability*/
			replace disab_gkid`k'= 1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n14' ==1; /* 制限あり */
			replace disab_gkid`k'= 0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n14' ==9; /* 該当しない */

			/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
			replace handi_gkid`k' = 1 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n15' ==1; /* 認定あり */
			replace handi_gkid`k' = 0 if v`n0'==6 & year==`y' & num_gkid==`k' & v`n15' ==9; /* 該当しない */
			
			};
		};
	};

/* job_gkidの統合 */
foreach k of num 1/10{;
	replace job_gkid`k' = job_gkid`k'_j if job_gkid`k'_j!=.;
	drop job_gkid`k'_j;
};

/* 70歳以上は誤記と考え、欠損値とする */
foreach k of num 1/10{;
	replace age_gkid`k'=. if age_gkid`k'>70;

	replace gkid`k'=. 		if age_gkid`k'>70;
	replace dokyo_gkid`k'=.	if age_gkid`k'>70;
	replace mar_gkid`k'=.	if age_gkid`k'>70;
	replace job_gkid`k'=.	if age_gkid`k'>70;
};

/* 年齢の補完 */
foreach k of num 1/10{;
	/*
	agegkid2
	agegkid`i'[_n-1] = 4
	agegkid`i'[_n] = .
	agegkid`i'[_n+1] =6
	*/
	* replace agegkid`i' =agegkid`i'[_n-1]+1 if agegkid`i'==. & agegkid`i'[_n-1]!=. & agegkid`i'[_n+1]!=. & v1[_n]==v1[_n-1] & v1[_n]==v1[_n+1] & attr==0;
	
	/* 次のようなケースの修正
	   agegkid`i'[_n-1] = 25
	   agegkid`i'[_n] =  55
	   agegkid`i'[_n+1] = 27
	*/
/*
	replace agegkid`i' = agegkid`i'[_n-1]+1 if agegkid`i'[_n-1]!=. 
						& gkid`i'==1 & agegkid`i'!=agegkid`i'[_n-1]+1 
						& v1[_n]==v1[_n-1] & attr==0;
*/
	/* -1は0歳にする */
	replace age_gkid`k'=0 if age_gkid`k' <0 & age_gkid`k' !=.;
};

foreach k of num 1/10{;
	label var gkid`k' "1:`k'人目の孫";
	label var dokyo_gkid`k' "1:`k'人目の孫と同居";
	label var mar_gkid`k' "1:`k'人目の孫既婚";
	label var job_gkid`k'  "1:`k'人目の孫就業";
	label var age_gkid`k'  "`k'人目の孫年齢(歳)";
};

/* 孫数 */
label var num_gkid "家族票:孫数";
sum num_gkid;

/* 記述統計 */
foreach k of num 1/10{;
    sum gkid`k' male_gkid`k' mar_gkid`k' dokyo_gkid`k' job_gkid`k'
    age_gkid`k' edu_gkid`k' chng_gkid`k' deth_gkid`k' time_gkid`k'
    nocntct_gkid`k' samelive_gkid`k' disab_gkid`k' handi_gkid`k', separator(0);
};

/*
チェック用
browse v1 year v13 v15 v20 v22 v27 v29  v34 v36 v41 v43 v48 v50 v55 v57 v62 v64 v69 v71  agegkid1 agegkid2 agegkid3 agegkid4 agegkid5 agegkid6 
browse v1 year agegkid1 agegkid2 agegkid3 agegkid4 agegkid5 agegkid6 dokyo_gkid1-dokyo_gkid6
*/

/*
keep id v1 year gkid_n gkid1-gkid6 dokyo_gkid1-dokyo_gkid6 male_gkid1-male_gkid6 mar_gkid1-mar_gkid6 
job_gkid1-job_gkid6 birthy_gkid1-birthy_gkid6  agegkid1-agegkid6 
edu_gkid1-edu_gkid4 deth_gkid1-deth_gkid4 time_gkid1-time_gkid4 nocntct_gkid1-nocntct_gkid4 samelive_gkid1-samelive_gkid4
disab_gkid1-disab_gkid4 handi_gkid1-handi_gkid4
gkidoh1-gkidoh5 male_gkidoh1-male_gkidoh5 age_gkidoh1-age_gkidoh5 tel_gkidoh1-tel_gkidoh5
hous_gkidoh1-hous_gkidoh5 gkid_n gkidoh_n gkid_s
male_gkidoh1-male_gkidoh5 age_gkidoh1-age_gkidoh5 tel_gkidoh1-tel_gkidoh5 hous_gkidoh1-hous_gkidoh5
rsn_gkidoh1-rsn_gkidoh5;

save gkid_data.dta, replace;


log close;
exit;

*/


