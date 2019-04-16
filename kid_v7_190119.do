#delimit;

/*********/
clear;
clear matrix;

set more off;

/* 自分用 */
cd "C:\JHPS_KHPS";
use JHPS_KHPS.dta;

log using kid_v7.log, replace;


/*** 最新調査年 ***/



global ly 2018; /* 最新調査年度 */

/*** 家族表　子供関連変数 ***/

foreach k of num 1/10{;
	gen kid`k'=.;			/* 子どもの有無 */
	gen male_kid`k'=.;		/* 性別 */
	gen birthy_kid`k'=.;	/* 生まれ年 */
	gen age_kid`k'=.;		/* 年齢 */
	gen job_kid`k'=.;		/* 就労 */
	gen job_kid`k'_j=.;		/* 就労 (K2014～ / J2009～) */
	gen dokyo_kid`k'=.;		/* 同居 */
	gen mar_kid`k'=.;		/* 有配偶 */
	gen edu_kid`k'=.;		/* 最終学歴 */
	gen chng_kid`k'=.;		/* 家族関係の変化 */
	gen deth_kid`k'=.;		/* 死別 */
	gen time1_kid`k'=.;		/* 対象者の家からかかる時間（時間） */
	gen time2_kid`k'=.;		/* 対象者の家からかかる時間（分） */
	gen time_kid`k'=.;		/* 対象者の家からかかる時間（合計・分） */
	gen nocntct_kid`k'=.;	/* 連絡がつかない */
	gen samelive_kid`k'=.;	/* 生計を同じにしている */
	gen disab_kid`k'=.;		/* 慢性的な日常活動の制限 */
	gen handi_kid`k'=.;		/* 要支援・要介護認定／障害支援区分の認定 */
	};

gen num_kid=0; /* 子どもの数のカウント用 */

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

		replace num_kid=num_kid+1 if v`n0'==2 & year==`y';
		
		foreach k of num 1/10{;

			/* 子どもの有無 */
			replace kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k';
			
			/* 性別 */
			replace male_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n1'==1; /* 男性 */
			replace male_kid`k'=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n1'==2; /* 女性 */
			
			/* 年齢 */
			replace birthy_kid`k'=v`n2' if v`n0'==2 & year==`y' & num_kid==`k' & v`n2'<7777;					/* 生まれ年 */
			replace age_kid`k'=`y'-v`n2' if v`n0'==2 & year==`y' & num_kid==`k' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
			replace age_kid`k'=`y'-v`n2'-1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
			
			/* 就労 */
			replace job_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n4'==8;		/* 就労 (K2004～K2013) */
			replace job_kid`k'=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n4'!=8;		/* 非就労 (K2004～K2013) */
			replace job_kid`k'_j=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
			replace job_kid`k'_j=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
			local n4a=`n4a'+3;
			
			/* 同居 */
			replace dokyo_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n5'==1; /* 同居 */
			replace dokyo_kid`k'=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n5'==2; /* 別居 */
			
			/* 有配偶 */
			replace mar_kid`k'=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n6'==1; /* 無配偶 */
			replace mar_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n6'==2; /* 有配偶 */
			
			};
		};
	};
	

/* 2016年以前の世帯外の子どもについてはとりあえず考えない（後ほど検討） */	

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

		replace num_kid=num_kid+1 if v`n0'==2 & year==`y';
		
		foreach k of num 1/10{;

			/* 子どもの有無 */
			replace kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k';
			
			/* 性別 */
			replace male_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n1'==1; /* 男性 */
			replace male_kid`k'=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n1'==2; /* 女性 */
			
			/* 年齢 */
			replace birthy_kid`k'=v`n2' if v`n0'==2 & year==`y' & num_kid==`k' & v`n2'<7777;					/* 生まれ年 */
			replace age_kid`k'=`y'-v`n2' if v`n0'==2 & year==`y' & num_kid==`k' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
			replace age_kid`k'=`y'-v`n2'-1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
			
			/* 就労 */
			replace job_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n4'==8;		/* 就労 (K2004～K2013) */
			replace job_kid`k'=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n4'!=8;		/* 非就労 (K2004～K2013) */
			replace job_kid`k'_j=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
			replace job_kid`k'_j=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
			
			/* 同居 */
			replace dokyo_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n5'==1; /* 同居 */
			replace dokyo_kid`k'=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n5'==2; /* 別居 */
			
			/* 有配偶 */
			replace mar_kid`k'=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n6'==1; /* 無配偶 */
			replace mar_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n6'==2; /* 有配偶 */
			
			/* 最終学歴 */
			replace edu_kid`k'=v`n7' if v`n0'==2 & year==`y' & num_kid==`k'; 

			/* 家族関係の変化 */
			replace chng_kid`k'=v`n8' if v`n0'==2 & year==`y' & num_kid==`k';

			/* 家族関係の変化: 死別 */
			replace deth_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n8'==2;					/* 死別 */
			replace deth_kid`k'=0 if v`n0'==2 & year==`y' & num_kid==`k' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

			/* 配偶関係・婚姻届けを出していない */
			replace mar_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n9'==1; /* 事実婚 */

			/* 対象者の家からかかる時間（時間） */
			replace time1_kid`k'= v`n10' if v`n0'==2 & year==`y' & num_kid==`k' & v`n10'<888;

			/* 対象者の家からかかる時間（分） */
			replace time2_kid`k'= v`n11' if v`n0'==2 & year==`y' & num_kid==`k' & v`n11'<888;

			/* 対象者の家からかかる時間（合計・分） */
			replace time_kid`k'= time1_kid`k'*60+time2_kid`k'	if v`n0'==2 & year==`y' & num_kid==`k' & time1_kid`k'!=. & time2_kid`k'!=.;
			replace time_kid`k'= time1_kid`k'*60				if v`n0'==2 & year==`y' & num_kid==`k' & time1_kid`k'!=. & time2_kid`k'==.;
			replace time_kid`k'= time2_kid`k'					if v`n0'==2 & year==`y' & num_kid==`k' & time1_kid`k'==. & time2_kid`k'!=.;

			/* 連絡がつかない */
			replace nocntct_kid`k'= 1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n12'==1; /* 連絡がつかない */
			replace nocntct_kid`k'= 0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n12'==9; /* 該当しない */

			/* 同一生計 */
			replace samelive_kid`k'= 1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n13' ==1; /* 同一家計 */
			replace samelive_kid`k'= 0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n13' ==9; /* 該当しない */

			/* 慢性的な日常生活の制限 disability*/
			replace disab_kid`k'= 1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n14' ==1; /* 制限あり */
			replace disab_kid`k'= 0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n14' ==9; /* 該当しない */

			/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
			replace handi_kid`k' = 1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n15' ==1; /* 認定あり */
			replace handi_kid`k' = 0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n15' ==9; /* 該当しない */
			
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

		replace num_kid=num_kid+1 if v`n0'==2 & year==`y';
		
		foreach k of num 1/10{;

			/* 子どもの有無 */
			replace kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k';
			
			/* 性別 */
			replace male_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n1'==1; /* 男性 */
			replace male_kid`k'=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n1'==2; /* 女性 */
			
			/* 年齢 */
			replace birthy_kid`k'=v`n2' if v`n0'==2 & year==`y' & num_kid==`k' & v`n2'<7777;					/* 生まれ年 */
			replace age_kid`k'=`y'-v`n2' if v`n0'==2 & year==`y' & num_kid==`k' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
			replace age_kid`k'=`y'-v`n2'-1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
			
			/* 就労 */
			replace job_kid`k'_j=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
			replace job_kid`k'_j=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
			
			/* 同居 */
			replace dokyo_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n5'==1; /* 同居 */
			replace dokyo_kid`k'=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n5'==2; /* 別居 */
			
			/* 有配偶 */
			replace mar_kid`k'=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n6'==1; /* 無配偶 */
			replace mar_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n6'==2; /* 有配偶 */
			
			/* 最終学歴 */
			replace edu_kid`k'=v`n7' if v`n0'==2 & year==`y' & num_kid==`k'; 

			/* 家族関係の変化 */
			replace chng_kid`k'=v`n8' if v`n0'==2 & year==`y' & num_kid==`k';

			/* 家族関係の変化: 死別 */
			replace deth_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n8'==2;					/* 死別 */
			replace deth_kid`k'=0 if v`n0'==2 & year==`y' & num_kid==`k' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

			/* 配偶関係・婚姻届けを出していない */
			replace mar_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n9'==1; /* 事実婚 */

			/* 対象者の家からかかる時間（時間） */
			replace time1_kid`k'= v`n10' if v`n0'==2 & year==`y' & num_kid==`k' & v`n10'<888;

			/* 対象者の家からかかる時間（分） */
			replace time2_kid`k'= v`n11' if v`n0'==2 & year==`y' & num_kid==`k' & v`n11'<888;

			/* 対象者の家からかかる時間（合計・分） */
			replace time_kid`k'= time1_kid`k'*60+time2_kid`k'	if v`n0'==2 & year==`y' & num_kid==`k' & time1_kid`k'!=. & time2_kid`k'!=.;
			replace time_kid`k'= time1_kid`k'*60				if v`n0'==2 & year==`y' & num_kid==`k' & time1_kid`k'!=. & time2_kid`k'==.;
			replace time_kid`k'= time2_kid`k'					if v`n0'==2 & year==`y' & num_kid==`k' & time1_kid`k'==. & time2_kid`k'!=.;

			/* 連絡がつかない */
			replace nocntct_kid`k'= 1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n12'==1; /* 連絡がつかない */
			replace nocntct_kid`k'= 0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n12'==9; /* 該当しない */

			/* 同一生計 */
			replace samelive_kid`k'= 1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n13' ==1; /* 同一家計 */
			replace samelive_kid`k'= 0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n13' ==9; /* 該当しない */

			/* 慢性的な日常生活の制限 disability*/
			replace disab_kid`k'= 1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n14' ==1; /* 制限あり */
			replace disab_kid`k'= 0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n14' ==9; /* 該当しない */

			/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
			replace handi_kid`k' = 1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n15' ==1; /* 認定あり */
			replace handi_kid`k' = 0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n15' ==9; /* 該当しない */
			
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

		replace num_kid=num_kid+1 if v`n0'==2 & year==`y';
		
		foreach k of num 1/10{;

			/* 子どもの有無 */
			replace kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k';
			
			/* 性別 */
			replace male_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n1'==1; /* 男性 */
			replace male_kid`k'=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n1'==2; /* 女性 */
			
			/* 年齢 */
			replace birthy_kid`k'=v`n2' if v`n0'==2 & year==`y' & num_kid==`k' & v`n2'<7777;					/* 生まれ年 */
			replace age_kid`k'=`y'-v`n2' if v`n0'==2 & year==`y' & num_kid==`k' & v`n2'<7777 & v`n3'==1;		/* 年齢（1月生まれ） */
			replace age_kid`k'=`y'-v`n2'-1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n2'<7777 & v`n3'!=1;	/* 年齢（1月生まれ以外） */
			
			/* 就労 */
			replace job_kid`k'_j=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n4a'==2;	/* 就労 (K2014～ / J2009～) */
			replace job_kid`k'_j=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n4a'==1;	/* 非就労 (K2014～ / J2009～) */
			
			/* 同居 */
			replace dokyo_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n5'==1; /* 同居 */
			replace dokyo_kid`k'=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n5'==2; /* 別居 */
			
			/* 有配偶 */
			replace mar_kid`k'=0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n6'==1; /* 無配偶 */
			replace mar_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n6'==2; /* 有配偶 */
			
			/* 最終学歴 */
			replace edu_kid`k'=v`n7' if v`n0'==2 & year==`y' & num_kid==`k'; 

			/* 家族関係の変化 */
			replace chng_kid`k'=v`n8' if v`n0'==2 & year==`y' & num_kid==`k';

			/* 家族関係の変化: 死別 */
			replace deth_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n8'==2;					/* 死別 */
			replace deth_kid`k'=0 if v`n0'==2 & year==`y' & num_kid==`k' & (v`n8'==1 | v`n8'==3);	/* それ以外 */

			/* 配偶関係・婚姻届けを出していない */
			replace mar_kid`k'=1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n9'==1; /* 事実婚 */

			/* 対象者の家からかかる時間（時間） */
			replace time1_kid`k'= v`n10' if v`n0'==2 & year==`y' & num_kid==`k' & v`n10'<888;

			/* 対象者の家からかかる時間（分） */
			replace time2_kid`k'= v`n11' if v`n0'==2 & year==`y' & num_kid==`k' & v`n11'<888;

			/* 対象者の家からかかる時間（合計・分） */
			replace time_kid`k'= time1_kid`k'*60+time2_kid`k'	if v`n0'==2 & year==`y' & num_kid==`k' & time1_kid`k'!=. & time2_kid`k'!=.;
			replace time_kid`k'= time1_kid`k'*60				if v`n0'==2 & year==`y' & num_kid==`k' & time1_kid`k'!=. & time2_kid`k'==.;
			replace time_kid`k'= time2_kid`k'					if v`n0'==2 & year==`y' & num_kid==`k' & time1_kid`k'==. & time2_kid`k'!=.;

			/* 連絡がつかない */
			replace nocntct_kid`k'= 1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n12'==1; /* 連絡がつかない */
			replace nocntct_kid`k'= 0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n12'==9; /* 該当しない */

			/* 同一生計 */
			replace samelive_kid`k'= 1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n13' ==1; /* 同一家計 */
			replace samelive_kid`k'= 0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n13' ==9; /* 該当しない */

			/* 慢性的な日常生活の制限 disability*/
			replace disab_kid`k'= 1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n14' ==1; /* 制限あり */
			replace disab_kid`k'= 0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n14' ==9; /* 該当しない */

			/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
			replace handi_kid`k' = 1 if v`n0'==2 & year==`y' & num_kid==`k' & v`n15' ==1; /* 認定あり */
			replace handi_kid`k' = 0 if v`n0'==2 & year==`y' & num_kid==`k' & v`n15' ==9; /* 該当しない */
			
			};
		};
	};

/* job_kidの統合 */
foreach k of num 1/10{;
	replace job_kid`k' = job_kid`k'_j if job_kid`k'_j!=.;
	drop job_kid`k'_j;
};

/* 70歳以上は誤記と考え、欠損値とする */
foreach k of num 1/10{;
	replace age_kid`k'=. if age_kid`k'>70;

	replace kid`k'=. 		if age_kid`k'>70;
	replace dokyo_kid`k'=.	if age_kid`k'>70;
	replace mar_kid`k'=.	if age_kid`k'>70;
	replace job_kid`k'=.	if age_kid`k'>70;
};

/* 年齢の補完 */
foreach k of num 1/10{;
	/*
	agekid2
	agekid`i'[_n-1] = 4
	agekid`i'[_n] = .
	agekid`i'[_n+1] =6
	*/
	* replace agekid`i' =agekid`i'[_n-1]+1 if agekid`i'==. & agekid`i'[_n-1]!=. & agekid`i'[_n+1]!=. & v1[_n]==v1[_n-1] & v1[_n]==v1[_n+1] & attr==0;
	
	/* 次のようなケースの修正
	   agekid`i'[_n-1] = 25
	   agekid`i'[_n] =  55
	   agekid`i'[_n+1] = 27
	*/
/*
	replace agekid`i' = agekid`i'[_n-1]+1 if agekid`i'[_n-1]!=. 
						& kid`i'==1 & agekid`i'!=agekid`i'[_n-1]+1 
						& v1[_n]==v1[_n-1] & attr==0;
*/
	/* -1は0歳にする */
	replace age_kid`k'=0 if age_kid`k' <0 & age_kid`k' !=.;
};

foreach k of num 1/10{;
	label var kid`k' "1:`k'人目の子供";
	label var dokyo_kid`k' "1:`k'人目の子供と同居";
	label var mar_kid`k' "1:`k'人目の子供既婚";
	label var job_kid`k'  "1:`k'人目の子供就業";
	label var age_kid`k'  "`k'人目の子供年齢(歳)";
};

/* 子ども数 */
label var num_kid "家族票:子ども数";
sum num_kid;

/* 記述統計 */
foreach k of num 1/10{;
    sum kid`k' male_kid`k' mar_kid`k' dokyo_kid`k' job_kid`k'
    age_kid`k' edu_kid`k' chng_kid`k' deth_kid`k' time_kid`k'
    nocntct_kid`k' samelive_kid`k' disab_kid`k' handi_kid`k', separator(0);
};


/*** 世帯外の子供関連変数 ***/
/* 2014年調査を用いた修正 */
/* kidoh_150226.do */

/* 世帯外の子供有り */
gen kidoh1 =.;
gen kidoh2 =.;
gen kidoh3 =.;
gen kidoh4 =.;
gen kidoh5 =.;

/* 性別 */
gen male_kidoh1 =.;
gen male_kidoh2 =.;
gen male_kidoh3 =.;
gen male_kidoh4 =.;
gen male_kidoh5 =.;

/* 年齢 */
gen age_kidoh1 = .;
gen age_kidoh2 = .;
gen age_kidoh3 = .;
gen age_kidoh4 = .;
gen age_kidoh5 = .;

/* 連絡可否 */
gen tel_kidoh1 =.;
gen tel_kidoh2 =.;
gen tel_kidoh3 =.;
gen tel_kidoh4 =.;
gen tel_kidoh5 =.;

/* 現在の居住 */
gen hous_kidoh1 = .;
gen hous_kidoh2 = .;
gen hous_kidoh3 = .;
gen hous_kidoh4 = .;
gen hous_kidoh5 = .;

/* 含めない理由 */
gen rsn_kidoh1 = .;
gen rsn_kidoh2 = .;
gen rsn_kidoh3 = .;
gen rsn_kidoh4 = .;
gen rsn_kidoh5 = .;

local i=1; /* 世帯外の子供の数 */
forvalues m= 3043(6)3067 {;  /* KHPSの質問番号 */

		local n1 = `m'+1; /* 生年 */
		local n2 = `m'+2; /* 生まれた月 */
		local n3 = `m'+3; /* 連絡可否 */
		local n4 = `m'+4; /* 現在の居住地 */
		local n5 = `m'+5; /* 含めない理由 */

		/* 家族表以外の子供の有無 */
		replace kidoh`i' =1 if v`m' ==1 | v`m'==2;
		replace kidoh`i' =0 if v`m' ==9; /* 無回答 */
		replace kidoh`i' =0 if v`m' ==8; /* 非該当 */

		/* 性別 */
		replace male_kidoh`i' = 1 if v`m' ==1;
		replace male_kidoh`i' = 0 if v`m' ==2;
		replace male_kidoh`i' = . if v`m' ==9;
		replace male_kidoh`i' = . if v`m' ==8;

		/* 年齢 */
		replace age_kidoh`i' = 2013-v`n1' if v`n1'<8888 & v`n2' !=1;
		replace age_kidoh`i' = 2014-v`n1' if v`n1'<8888 & v`n2' ==1;

		/* 連絡可否 */
		replace tel_kidoh`i' = 1 if v`n3'==1;
		replace tel_kidoh`i' = 0 if v`n3'==2;
		replace tel_kidoh`i' = . if v`n3'==8 | v`n3'==9;

		/* 現在の居住地 */
		replace hous_kidoh`i' = v`n4' if v`n4' <88;
		replace hous_kidoh`i' = . if v`n4' ==88|v`n4' ==99;

		/* 含めない理由 */
		replace rsn_kidoh`i' = v`n5' if v`n5' <8;
		replace rsn_kidoh`i' = . if v`n5'==8|v`n5'==9;
		
		local i = `i'+1;
};

/* 補完 */
forvalues i = 1/5 {;
	/* 2013年以前は、2014年の値を代入する */
	forvalues Y= 2013 (-1) 2004 {;
		replace kidoh`i' = kidoh`i'[_n+1] if year==`Y';
		replace male_kidoh`i' = male_kidoh`i'[_n+1] if year==`Y';
		replace age_kidoh`i' = age_kidoh`i'[_n+1]-1 if year==`Y';
		replace tel_kidoh`i' = tel_kidoh`i'[_n+1]-1 if year==`Y';
		replace hous_kidoh`i' = hous_kidoh`i'[_n+1]-1 if year==`Y';
		replace rsn_kidoh`i' = rsn_kidoh`i'[_n+1]-1 if year==`Y';
	};
};

forvalues i = 1/5 {;
	/* 2015年以降は、2014年の値を代入する */
	forvalues Y= 2015 (1) $ly {;
		replace kidoh`i' = kidoh`i'[_n-1] if year==`Y';
		replace male_kidoh`i' = male_kidoh`i'[_n-1] if year==`Y';
		replace age_kidoh`i' = age_kidoh`i'[_n-1]+1 if year==`Y';
		replace tel_kidoh`i' = tel_kidoh`i'[_n-1]-1 if year==`Y';
		replace hous_kidoh`i' = hous_kidoh`i'[_n-1]-1 if year==`Y';
		replace rsn_kidoh`i' = rsn_kidoh`i'[_n-1]-1 if year==`Y';
	};
};


/* ラベル */
forvalues i = 1/5 {;
	label var kidoh`i' "1:`i'番目の世帯外の子供有り";
	label var male_kidoh`i' "1:`i'番目の世帯外の子供男性";
	label var age_kidoh`i' "1:`i'番目の世帯外の子供年齢";	
	label var tel_kidoh`i'  "1:`i'番目の世帯外の子供連絡可";
	label var hous_kidoh`i' "`i'番目の世帯外の子供居住地";
	label var rsn_kidoh`i' "家族表に含めない理由 ";
};


/** 世帯外の子供の人数 **/
/* kid_n を num_kidに変更 */
gen kidoh_n =.;
replace kidoh_n =0 if kidoh1 !=. & kidoh2 !=. & kidoh3 !=. & kidoh4 !=. & kidoh5 !=. ;
forvalues i=1/5 {;
	replace  kidoh_n = kidoh_n+1 if  kidoh`i'==1;
};

label var kidoh_n "世帯外の子供の数";


/*** 子供数 ***/
/* 家族表内の子供の数 + 家族表外の子供の数*/
gen kid_s = 0;
replace kid_s = num_kid +kidoh_n if num_kid !=. & kidoh_n!=.;
replace kid_s = num_kid if num_kid !=. & kidoh_n==.;
replace kid_s = kidoh_n if num_kid ==. & kidoh_n!=.;
label var kid_s "家族表内の子供数 + 家族表外の子供数";

sum num_kid kidoh_n kid_s;

save temp.dta, replace;

/*
チェック用
browse v1 year v13 v15 v20 v22 v27 v29  v34 v36 v41 v43 v48 v50 v55 v57 v62 v64 v69 v71  agekid1 agekid2 agekid3 agekid4 agekid5 agekid6 
browse v1 year agekid1 agekid2 agekid3 agekid4 agekid5 agekid6 dokyo_kid1-dokyo_kid6
*/

/*
keep id v1 year kid_n kid1-kid6 dokyo_kid1-dokyo_kid6 male_kid1-male_kid6 mar_kid1-mar_kid6 
job_kid1-job_kid6 birthy_kid1-birthy_kid6  agekid1-agekid6 
edu_kid1-edu_kid4 deth_kid1-deth_kid4 time_kid1-time_kid4 nocntct_kid1-nocntct_kid4 samelive_kid1-samelive_kid4
disab_kid1-disab_kid4 handi_kid1-handi_kid4
kidoh1-kidoh5 male_kidoh1-male_kidoh5 age_kidoh1-age_kidoh5 tel_kidoh1-tel_kidoh5
hous_kidoh1-hous_kidoh5 kid_n kidoh_n kid_s
male_kidoh1-male_kidoh5 age_kidoh1-age_kidoh5 tel_kidoh1-tel_kidoh5 hous_kidoh1-hous_kidoh5
rsn_kidoh1-rsn_kidoh5;

save kid_data.dta, replace;


log close;
exit;

*/


