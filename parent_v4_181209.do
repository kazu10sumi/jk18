#delimit;

/***********
clear;
clear matrix;

set more off;


/* 自分用 */
cd "C:\Users\Kazuto Sumita\Dropbox\DATA\JK18\var";
use temp.dta;
log using parnt_v4.log, replace;

************/

/*** 最新調査年 ***/
global ly 2018;

/********************************************/

/*** 家族表　両親関連変数 ***/

/* 両親の有無 */
gen prnt1 =.;
gen prnt2 =.;

/* 結婚しているか */
gen mar_prnt1 = .;
gen mar_prnt2 = .;

/* 就職している */
gen job_prnt1 = .;
gen job_prnt2 = .;

gen job_prnt1_j = .;
gen job_prnt2_j = .;

/* 生年 */
gen birthy_prnt1 =.;
gen birthy_prnt2 =.;

/* 両親の年齢 */
gen ageprnt1=.;
gen ageprnt2=.;

/* 同居 */
gen dokyo_prnt1 =.;
gen dokyo_prnt2 =.;


*set trace on;



forvalues Y=2004/2016 {;

	/* 一人目の親(父親) */

	local n4a=3015; /* J2009-J2014, K2014 就職 変数作成用*/
	forvalues n0= 13(7)69 {;
		local n1 = `n0'+1; /* 性別 */
		local n2 = `n0'+2; /* 生年 */
		local n3 = `n0'+3; /* 生年月 */
		local n4 = `n0'+4; /* 就職 */
		local n5 = `n0'+5; /* 同居 */
		local n6 = `n0'+6; /* 結婚 */

		/* 父親 */
		replace prnt1 = 1 if v`n0'==5 & v`n1'==1 & year==`Y' & prnt1!=1; /* 男性 */
		replace prnt1 = 0 if v`n0'==5 & v`n1'==2 & year==`Y' & prnt1!=1; /* 女性 */
		/*  prnt1!=1 の意味
		prnt1==. or prnt1==0を対象とする
		*/

		/* 生年 */
		replace birthy_prnt1 = v`n2' if v`n0'==5 & v`n1'==1  & year==`Y' & birthy_prnt1==. &  v`n2' <8888; 
		* replace birthy_prnt1 = . if prnt1==. & year==`Y';

		/* 年齢 */
		local X = `Y'-1;
		replace ageprnt1 = `Y'-birthy_prnt1 if v`n0'==5 & v`n1'==1  & year==`Y' & ageprnt1==.& v`n3' ==1; /* 1月生まれ */
		replace ageprnt1 = `X'-birthy_prnt1 if v`n0'==5 & v`n1'==1  & year==`Y' & ageprnt1==.& v`n3' !=1; 

		/* 同居 */
		replace dokyo_prnt1 =1 if v`n0'==5 & v`n1'==1  & v`n5'==1 & year==`Y' & dokyo_prnt1!=1; /* 男性・同居 */
		replace dokyo_prnt1 =0 if v`n0'==5 & v`n1'==1  & v`n5'==2 & year==`Y' & dokyo_prnt1!=1; /* 男性・別居 */
		replace dokyo_prnt1 =0 if v`n0'==5 & v`n1'==2  & v`n5'==1 & year==`Y' & dokyo_prnt1!=1; /* 女性・同居 */
		replace dokyo_prnt1 =0 if v`n0'==5 & v`n1'==2  & v`n5'==2 & year==`Y' & dokyo_prnt1!=1; /* 女性・別居 */

		/* 配偶状況 */
		replace mar_prnt1 = 1 if v`n0'==5 & v`n1'==1  & v`n6'==2 & year==`Y' & mar_prnt1 != 1; /* 男性・既婚 */
		replace mar_prnt1 = 0 if v`n0'==5 & v`n1'==1  & v`n6'==1 & year==`Y' & mar_prnt1 != 1; /* 男性・未婚 */
		replace mar_prnt1 = 0 if v`n0'==5 & v`n1'==2  & v`n6'==2 & year==`Y' & mar_prnt1 != 1; /* 女性・既婚 */
		replace mar_prnt1 = 0 if v`n0'==5 & v`n1'==2  & v`n6'==1 & year==`Y' & mar_prnt1 != 1; /* 女性・未婚 */

		/* 就業状況 */
		/* K2004-K2013 現 在 の 就 学 ・ 就 労 状 況, 仕事に就いている=8*/
		replace job_prnt1 = 1 if v`n0'==5 & v`n1'==1  & v`n4'==8 & year==`Y' & job_prnt1 != 1; /* 男性・就職 */
		replace job_prnt1 = 0 if v`n0'==5 & v`n1'==1  & v`n4'!=8 & year==`Y' & job_prnt1 != 1; /* 男性・就職していない */
		replace job_prnt1 = 0 if v`n0'==5 & v`n1'==2  & v`n4'==8 & year==`Y' & job_prnt1 != 1; /* 女性・就職 */
		replace job_prnt1 = 0 if v`n0'==5 & v`n1'==2  & v`n4'!=8 & year==`Y' & job_prnt1 != 1; /* 女性・就職していない */

		/* J2009-J2014, K2014 就業状況, 就業中=2 非就業=1*/
		replace job_prnt1_j = 1 if v`n0'==5 & v`n1'==1  & v`n4a'==2 & year==`Y' & job_prnt1_j != 1; /* 男性・就職 */
		replace job_prnt1_j = 0 if v`n0'==5 & v`n1'==1  & v`n4a'==1 & year==`Y'& job_prnt1_j != 1; /* 男性・就職していない */
		replace job_prnt1_j = 0 if v`n0'==5 & v`n1'==2  & v`n4a'==2 & year==`Y'& job_prnt1_j != 1; /* 女性・就職 */
		replace job_prnt1_j = 0 if v`n0'==5 & v`n1'==2  & v`n4a'==1 & year==`Y'& job_prnt1_j != 1; /* 女性・就職していない */

		des v`n4a', short;
		local n4a = `n4a'+3;


		* des v`n', short;
	};

	* continue, break;

	/* 二人目の親(母親) */

	local n4a=3015; /* J2009-J2014, K2014 就職 変数作成用*/
	forvalues n0= 13(7)69 {;
		local n1 = `n0'+1; /* 性別 */
		local n2 = `n0'+2; /* 生年 */
		local n3 = `n0'+3; /* 生年月 */
		local n4 = `n0'+4; /* 就職 */
		local n5 = `n0'+5; /* 同居 */
		local n6 = `n0'+6; /* 結婚 */

		/* 母親 */
		replace prnt2 = 0 if v`n0'==5 & v`n1'==1 & year==`Y' & prnt2!=1; /* 男性 */
		replace prnt2 = 1 if v`n0'==5 & v`n1'==2 & year==`Y' & prnt2!=1; /* 女性 */
		/*  prnt2!=1 の意味
		父親・母親の順で回答されている場合には、
		初めのreplaceで、prnt2=0が入ってしまうケースが多いので、
		次のreplaceで、prnt2==.を対象にしては、replaceがスキップされてしまうため。
		*/

		/* 生年 */
		replace birthy_prnt2 = v`n2' if v`n0'==5 & v`n1'==2 & year==`Y' & birthy_prnt2==. &  v`n2' <8888; 
		/* prnt2==1となったときの出生年である必要がある。*/
		* replace birthy_prnt2 = . if prnt2==. & year==`Y';

		/* 年齢 */
		local X = `Y'-1;
		replace ageprnt2 = `Y'-birthy_prnt2 if prnt2 == 1 & year==`Y' & ageprnt2==.& v`n0' ==1; /* 1月生まれ*/
		replace ageprnt2 = `X'-birthy_prnt2 if prnt2 == 1 & year==`Y' & ageprnt2==.& v`n0' !=1; 

		/* 同居 */
		replace dokyo_prnt2 =0 if  v`n0'==5 & v`n1'==1  & v`n5'==1 & year==`Y' & dokyo_prnt2 !=1; /* 男性・同居 */
		replace dokyo_prnt2 =0 if  v`n0'==5 & v`n1'==1  & v`n5'==2 & year==`Y' & dokyo_prnt2 !=1; /* 男性・別居 */
		replace dokyo_prnt2 =1 if  v`n0'==5 & v`n1'==2  & v`n5'==1 & year==`Y' & dokyo_prnt2 !=1; /* 女性・同居 */
		replace dokyo_prnt2 =0 if  v`n0'==5 & v`n1'==2  & v`n5'==2 & year==`Y' & dokyo_prnt2 !=1; /* 女性・別居 */

		/* 配偶状況 */
		replace mar_prnt2 = 0 if  v`n0'==5 & v`n1'==1  & v`n6'==2 & year==`Y' & mar_prnt2 != 1; /* 男性・既婚 */
		replace mar_prnt2 = 0 if  v`n0'==5 & v`n1'==1  & v`n6'==1 & year==`Y' & mar_prnt2 != 1; /* 男性・未婚 */
		replace mar_prnt2 = 1 if  v`n0'==5 & v`n1'==2  & v`n6'==2 & year==`Y' & mar_prnt2 != 1; /* 女性・既婚 */
		replace mar_prnt2 = 0 if  v`n0'==5 & v`n1'==2  & v`n6'==1 & year==`Y' & mar_prnt2 != 1; /* 女性・未婚 */

		/* 就業状況 */
		/* K2004-K2013 */
		replace job_prnt2 = 0 if  v`n0'==5 & v`n1'==1  & v`n4'==8 & year==`Y' & job_prnt2 != 1; /* 男性・就職 */
		replace job_prnt2 = 0 if  v`n0'==5 & v`n1'==1  & v`n4'!=8 & year==`Y' & job_prnt2 != 1; /* 男性・就職していない */
		replace job_prnt2 = 1 if  v`n0'==5 & v`n1'==2  & v`n4'==8 & year==`Y' & job_prnt2 != 1; /* 女性・就職 */
		replace job_prnt2 = 0 if  v`n0'==5 & v`n1'==2  & v`n4'!=8 & year==`Y' & job_prnt2 != 1; /* 女性・就職していない */
		/* id=10195: 次に就業している子を回答していると、その回答が入ってしまう傾向がある。*/

		/* J2009-J2014, K2014 */
		replace job_prnt2_j = 0 if  v`n0'==5 & v`n1'==1  & v`n4a'==2 & year==`Y' & job_prnt2_j != 1; /* 男性・就職 */
		replace job_prnt2_j = 0 if  v`n0'==5 & v`n1'==1  & v`n4a'==1 & year==`Y' & job_prnt2_j != 1; /* 男性・就職していない */
		replace job_prnt2_j = 1 if  v`n0'==5 & v`n1'==2  & v`n4a'==2 & year==`Y' & job_prnt2_j != 1; /* 女性・就職 */
		replace job_prnt2_j = 0 if  v`n0'==5 & v`n1'==2  & v`n4a'==1 & year==`Y' & job_prnt2_j != 1; /* 女性・就職していない */

		des v`n4a', short;
		local n4a = `n4a'+3;

	};

	*continue, break;
};



/*** 2017年からの新しい家族表 ***/

/* 最終学歴 */
gen edu_prnt1=.;
label var edu_prnt1 "父親:学歴";

gen edu_prnt2=.;
label var edu_prnt2 "母親:学歴";

/* 家族関係の変化 */
gen chng_prnt1 = .;
label var chng_prnt1 "父親・家族関係変化";

gen chng_prnt2 = .;
label var chng_prnt2 "母親・家族関係変化";

gen deth_prnt1=. ;
label var deth_prnt1 "父親：死別";

gen deth_prnt2 = .;
label var deth_prnt2 "母親：死別";

gen samelive_prnt1 = .;
label var samelive_prnt1 "1:同一生計";

gen samelive_prnt2 = .;
label var samelive_prnt2 "1:同一生計";

gen time1_prnt1 = .;
gen time2_prnt1 = .;
gen time_prnt1 = .;
label var time_prnt1 "対象者の家からかかる時間・分";

gen time1_prnt2 = .;
gen time2_prnt2 = .;
gen time_prnt2 = .;
label var time_prnt2 "対象者の家からかかる時間・分";

gen nocntct_prnt1 =.;
label var nocntct_prnt1 "1:対象者・配偶者から連絡がつかない";

gen nocntct_prnt2 =.;
label var nocntct_prnt2 "1:対象者・配偶者から連絡がつかない";


gen disab_prnt1 =.;
label var disab_prnt1 "1:慢性的な日常生活制限";

gen disab_prnt2 =.;
label var disab_prnt2 "1:慢性的な日常生活制限";


gen handi_prnt1 =.;
label var handi_prnt1 "1:要支援・要介護認定・障害支援区分の認定";

gen handi_prnt2 =.;
label var handi_prnt2 "1:要支援・要介護認定・障害支援区分の認定";



/** 2017年以降 **/
forvalues Y=2017/$ly {;

	/* 一人目の親(父親) */
	local n4a=3015; /* J2009-J2014, K2014 就職 変数作成用 2人目の家族*/
	forvalues n0= 20(7)69 {;
		local n1 = `n0'+1; /* 性別 */
		local n2 = `n0'+2; /* 生年 */
		local n3 = `n0'+3; /* 生年月 */
		local n4 = `n0'+4; /* 就職 */
		local n5 = `n0'+5; /* 同居 */
		local n6 = `n0'+6; /* 結婚 */

		des v`n0', short;

		/* 父親 */
		replace prnt1 = 1 if v`n0'==4 & v`n1'==1 & year==`Y' & prnt1!=1; /* 男性 */
		replace prnt1 = 0 if v`n0'==4 & v`n1'==2 & year==`Y' & prnt1!=1; /* 女性 */
		/*  prnt1!=1 の意味
		prnt1==. or prnt1==0を対象とする
		*/
		des v`n1', short;

		/* 生年 */
		replace birthy_prnt1 = v`n2' if v`n0'==4 & v`n1'==1  & year==`Y' & birthy_prnt1==. &  v`n2' <7777; 
		* replace birthy_prnt1 = . if prnt1==. & year==`Y';
		des v`n2', short;

		/* 年齢 */
		local X = `Y'-1;
		replace ageprnt1 = `Y'-birthy_prnt1 if v`n0'==4 & v`n1'==1  & year==`Y' & ageprnt1==.& v`n3' ==1; /* 1月生まれ */
		replace ageprnt1 = `X'-birthy_prnt1 if v`n0'==4 & v`n1'==1  & year==`Y' & ageprnt1==.& v`n3' !=1; 
		des v`n3', short;

		/* 同居 */
		replace dokyo_prnt1 =1 if v`n0'==4 & v`n1'==1  & v`n5'==1 & year==`Y' & dokyo_prnt1!=1; /* 男性・同居 */
		replace dokyo_prnt1 =0 if v`n0'==4 & v`n1'==1  & v`n5'==2 & year==`Y' & dokyo_prnt1!=1; /* 男性・別居 */
		replace dokyo_prnt1 =0 if v`n0'==4 & v`n1'==2  & v`n5'==1 & year==`Y' & dokyo_prnt1!=1; /* 女性・同居 */
		replace dokyo_prnt1 =0 if v`n0'==4 & v`n1'==2  & v`n5'==2 & year==`Y' & dokyo_prnt1!=1; /* 女性・別居 */
		des v`n5', short;

		/* 配偶状況 */
		replace mar_prnt1 = 1 if v`n0'==4 & v`n1'==1  & v`n6'==2 & year==`Y' & mar_prnt1 != 1; /* 男性・既婚 */
		replace mar_prnt1 = 0 if v`n0'==4 & v`n1'==1  & v`n6'==1 & year==`Y' & mar_prnt1 != 1; /* 男性・未婚 */
		replace mar_prnt1 = 0 if v`n0'==4 & v`n1'==2  & v`n6'==2 & year==`Y' & mar_prnt1 != 1; /* 女性・既婚 */
		replace mar_prnt1 = 0 if v`n0'==4 & v`n1'==2  & v`n6'==1 & year==`Y' & mar_prnt1 != 1; /* 女性・未婚 */
		des v`n6', short;


		/* 就業状況 */
		replace job_prnt1_j = 1 if prnt1==1 & v`n4a' ==2 & year==`Y' & job_prnt1_j==. & v`n4a' <8 & v`n4a' !=. ; /* 就業 */
		replace job_prnt1_j = 0 if prnt1==1 & v`n4a' ==1 & year==`Y' & job_prnt1_j==. & v`n4a' <8 & v`n4a' !=. ; /* 非就業 */

		local n4a = `n4a'+3;

		des v`n4a', short;

	};

	forvalues n7= 3697(9)3760 {; /* 最終学歴 */
		local n8 = `n7'+1; /* 家族関係の変化 */
		local n9 = `n7'+2; /* 配偶関係	婚姻届を出していない */
		local n10 = `n7'+3; /* 対象者の家からかかる時間・時 */
		local n11 = `n7'+4; /* 対象者の家からかかる時間・分 */
		local n12 = `n7'+5; /* 該当するもの配偶者から連絡がつかない */
		local n13 = `n7'+6; /* 該当するもの生計が同じ */
		local n14 = `n7'+7; /* 該当するもの慢性的な日常活動の制限	 */
		local n15 = `n7'+8; /* 該当するもの要支援・要介護/障害支援	 */

		/* 最終学歴 */
		replace edu_prnt1= v`n7' if prnt1==1 & year==`Y' & edu_prnt1==.; 
		des v`n7', short;

		/* 家族関係の変化 */
		replace chng_prnt1 = v`n8' if prnt1==1 & year==`Y' & chng_prnt1==.;
		des v`n8', short;

		/* 家族関係の変化: 死別 */
		replace deth_prnt1 = 1 if prnt1==1 & year==`Y' & deth_prnt1==. & v`n8' ==2; /* 死別 */
		replace deth_prnt1 = 0 if prnt1==1 & year==`Y' & deth_prnt1==. & (v`n8' ==1 |v`n8'==3); /* 生存 */

		/* 配偶関係 */
		replace mar_prnt1 = 1 if v`n9'==5 & prnt1==1  & v`n9'==2 & year==`Y' & mar_prnt1 ==.; /* 男性・既婚 */
		replace mar_prnt1 = 0 if v`n9'==5 & prnt1==1  & v`n9'==1 & year==`Y' & mar_prnt1 ==.; /* 男性・未婚 */
		des v`n9', short;

		/* 対象者の家からかかる時間・時 */
		replace time1_prnt1 = v`n10' if prnt1==1 & v`n10'<888 & year==`Y' & time1_prnt1==.;
		des v`n10', short;

		/* 対象者の家からかかる時間・分 */
		replace time2_prnt1 = v`n11' if prnt1==1 & v`n11'<888 & year==`Y' & time2_prnt1==.;
		des v`n11', short;

		/* 対象者の家からかかる時間・分 */
		replace time_prnt1 = time1_prnt1*60+time2_prnt1 if time1_prnt1 !=. & time2_prnt1!=.;
		replace time_prnt1 = time1_prnt1*60 if time1_prnt1 !=. & time2_prnt1==.;
		replace time_prnt1 = time2_prnt1 if time1_prnt1 ==. & time2_prnt1!=.;

		/* 配偶者から連絡がつかない */
		replace nocntct_prnt1 = 1 if prnt1 ==1 & v`n12'==1 & year==`Y' & nocntct_prnt1==.;
		replace nocntct_prnt1 = 0 if prnt1 ==1 & v`n12'==8 & year==`Y'& nocntct_prnt1==.;
		des v`n12', short;

		/* 同一生計 */
		replace samelive_prnt1 = 1 if prnt1 ==1 & v`n13' ==1 & year==`Y' & samelive_prnt1==.; /* 同一家計 */
		replace samelive_prnt1 = 0 if prnt1 ==1 & v`n13' ==9 & year==`Y' & samelive_prnt1==.; /* 該当しない */
		des v`n13', short;

		/* 慢性的な日常生活の制限 disability*/
		replace disab_prnt1 = 1 if prnt1 ==1 & v`n14' ==1 & year==`Y' & disab_prnt1==.; /* 制限あり */
		replace disab_prnt1 = 0 if prnt1 ==1 & v`n14' ==9 & year==`Y' & disab_prnt1==.; /* 該当しない */
		des v`n14', short;

		/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
		replace handi_prnt1 = 1 if prnt1 ==1 & v`n15' ==1 & year==`Y' & handi_prnt1==.; /* 認定あり */
		replace handi_prnt1 = 0 if prnt1 ==1 & v`n15' ==9 & year==`Y'& handi_prnt1==.; /* 該当しない */
		des v`n15', short;

	};

	* continue, break;

	/* 二人目の親(母親) */

	local n4a=3015; /* J2009-J2014, K2014 就職 変数作成用*/
	forvalues n0= 13(7)69 {;
		local n1 = `n0'+1; /* 性別 */
		local n2 = `n0'+2; /* 生年 */
		local n3 = `n0'+3; /* 生年月 */
		local n4 = `n0'+4; /* 就職 */
		local n5 = `n0'+5; /* 同居 */
		local n6 = `n0'+6; /* 結婚 */

		/* 母親 */
		replace prnt2 = 0 if v`n0'==4 & v`n1'==1 & year==`Y' & prnt2!=1; /* 男性 */
		replace prnt2 = 1 if v`n0'==4 & v`n1'==2 & year==`Y' & prnt2!=1; /* 女性 */
		/*  prnt2!=1 の意味
		父親・母親の順で回答されている場合には、
		初めのreplaceで、prnt2=0が入ってしまうケースが多いので、
		次のreplaceで、prnt2==.を対象にしては、replaceがスキップされてしまうため。
		*/
		des v`n1', short;

		/* 生年 */
		replace birthy_prnt2 = v`n2' if v`n0'==4 & v`n1'==2 & year==`Y' & birthy_prnt2==. &  v`n2' <7777; 
		/* prnt2==1となったときの出生年である必要がある。*/
		* replace birthy_prnt2 = . if prnt2==. & year==`Y';
		des v`n2', short;

		/* 年齢 */
		local X = `Y'-1;
		replace ageprnt2 = `Y'-birthy_prnt2 if prnt2 == 1 & year==`Y' & ageprnt2==.& v`n0' ==1; /* 1月生まれ*/
		replace ageprnt2 = `X'-birthy_prnt2 if prnt2 == 1 & year==`Y' & ageprnt2==.& v`n0' !=1; 
		des v`n0', short;

		/* 同居 */
		replace dokyo_prnt2 =0 if  v`n0'==5 & v`n1'==1  & v`n5'==1 & year==`Y' & dokyo_prnt2 !=1; /* 男性・同居 */
		replace dokyo_prnt2 =0 if  v`n0'==5 & v`n1'==1  & v`n5'==2 & year==`Y' & dokyo_prnt2 !=1; /* 男性・別居 */
		replace dokyo_prnt2 =1 if  v`n0'==5 & v`n1'==2  & v`n5'==1 & year==`Y' & dokyo_prnt2 !=1; /* 女性・同居 */
		replace dokyo_prnt2 =0 if  v`n0'==5 & v`n1'==2  & v`n5'==2 & year==`Y' & dokyo_prnt2 !=1; /* 女性・別居 */
		des v`n5', short;

		/* 配偶状況 */
		replace mar_prnt2 = 0 if  v`n0'==5 & v`n1'==1  & v`n6'==2 & year==`Y' & mar_prnt2 != 1; /* 男性・既婚 */
		replace mar_prnt2 = 0 if  v`n0'==5 & v`n1'==1  & v`n6'==1 & year==`Y' & mar_prnt2 != 1; /* 男性・未婚 */
		replace mar_prnt2 = 1 if  v`n0'==5 & v`n1'==2  & v`n6'==2 & year==`Y' & mar_prnt2 != 1; /* 女性・既婚 */
		replace mar_prnt2 = 0 if  v`n0'==5 & v`n1'==2  & v`n6'==1 & year==`Y' & mar_prnt2 != 1; /* 女性・未婚 */
		des v`n6', short;

		/* 就業状況 */
		/* K2004-K2013 */
		replace job_prnt2 = 0 if  v`n0'==5 & v`n1'==1  & v`n4'==8 & year==`Y' & job_prnt2 != 1; /* 男性・就職 */
		replace job_prnt2 = 0 if  v`n0'==5 & v`n1'==1  & v`n4'!=8 & year==`Y' & job_prnt2 != 1; /* 男性・就職していない */
		replace job_prnt2 = 1 if  v`n0'==5 & v`n1'==2  & v`n4'==8 & year==`Y' & job_prnt2 != 1; /* 女性・就職 */
		replace job_prnt2 = 0 if  v`n0'==5 & v`n1'==2  & v`n4'!=8 & year==`Y' & job_prnt2 != 1; /* 女性・就職していない */
		/* id=10195: 次に就業している子を回答していると、その回答が入ってしまう傾向がある。*/
		des v`n4', short;

		/* J2009-J2014, K2014 */
		replace job_prnt2_j = 0 if  v`n0'==5 & v`n1'==1  & v`n4a'==2 & year==`Y' & job_prnt2_j != 1; /* 男性・就職 */
		replace job_prnt2_j = 0 if  v`n0'==5 & v`n1'==1  & v`n4a'==1 & year==`Y' & job_prnt2_j != 1; /* 男性・就職していない */
		replace job_prnt2_j = 1 if  v`n0'==5 & v`n1'==2  & v`n4a'==2 & year==`Y' & job_prnt2_j != 1; /* 女性・就職 */
		replace job_prnt2_j = 0 if  v`n0'==5 & v`n1'==2  & v`n4a'==1 & year==`Y' & job_prnt2_j != 1; /* 女性・就職していない */

		des v`n4a', short;

		local n4a = `n4a'+3;

	};

	*continue, break;

	/* 2018年以降 */
	/* 家族2人目から10人目まで */
	forvalues n7= 3697(9)3760 {; /* 最終学歴 */
		local n8 = `n7'+1; /* 家族関係の変化 */
		local n9 = `n7'+2; /* 配偶関係	婚姻届を出していない */
		local n10 = `n7'+3; /* 対象者の家からかかる時間・時 */
		local n11 = `n7'+4; /* 対象者の家からかかる時間・分 */
		local n12 = `n7'+5; /* 該当するもの配偶者から連絡がつかない */
		local n13 = `n7'+6; /* 該当するもの生計が同じ */
		local n14 = `n7'+7; /* 該当するもの慢性的な日常活動の制限	 */
		local n15 = `n7'+8; /* 該当するもの要支援・要介護/障害支援	 */

		/* 最終学歴 */
		replace edu_prnt2= v`n7' if prnt2==1 & year==`Y' & edu_prnt2!=1; 
		des v`n7', short;

		/* 家族関係の変化 */
		replace chng_prnt2 = v`n8' if prnt2==1 & year==`Y' & chng_prnt2!=1;
		des v`n8', short;

		/* 家族関係の変化: 死別 */
		replace deth_prnt2 = 1 if prnt2==1 & year==`Y' & deth_prnt2!=1 & v`n8' ==2; /* 死別 */
		replace deth_prnt2 = 0 if prnt2==1 & year==`Y' & deth_prnt2!=1 & (v`n8' ==1 |v`n8'==3); /* 生存 */

		/* 配偶関係 */
		replace mar_prnt2 = 1 if v`n9'==5 & prnt2==1  & v`n9'==2 & year==`Y' & mar_prnt2 !=1; /* 男性・既婚 */
		replace mar_prnt2 = 0 if v`n9'==5 & prnt2==1  & v`n9'==1 & year==`Y' & mar_prnt2 !=1; /* 男性・未婚 */
		des v`n9', short;

		/* 対象者の家からかかる時間・時 */
		replace time1_prnt2 = v`n10' if prnt2==1 & v`n10'<888 & year==`Y' & time1_prnt2!=1;
		des v`n10', short;

		/* 対象者の家からかかる時間・分 */
		replace time2_prnt2 = v`n11' if prnt2==1 & v`n11'<888 & year==`Y' & time2_prnt2!=1;
		des v`n11', short;

		/* 対象者の家からかかる時間・分 */
		replace time_prnt2 = time1_prnt1*60+time2_prnt2 if time1_prnt1 !=. & time2_prnt2!=1;
		replace time_prnt2 = time1_prnt2*60 if time1_prnt2!=. & time2_prnt2!=1;
		replace time_prnt2 = time2_prnt2 if time1_prnt2 ==. & time2_prnt2!=1;

		/* 配偶者から連絡がつかない */
		replace nocntct_prnt2 = 1 if prnt2 ==1 & v`n12'==1 & year==`Y' & nocntct_prnt2!=1;
		replace nocntct_prnt2 = 0 if prnt2 ==1 & v`n12'==8 & year==`Y'& nocntct_prnt2!=1;
		des v`n12', short;

		/* 同一生計 */
		replace samelive_prnt2 = 1 if prnt2 ==1 & v`n13' ==1 & year==`Y' & samelive_prnt2!=1; /* 同一家計 */
		replace samelive_prnt2 = 0 if prnt2 ==1 & v`n13' ==9 & year==`Y' & samelive_prnt2!=1; /* 該当しない */
		des v`n13', short;

		/* 慢性的な日常生活の制限 disability*/
		replace disab_prnt2 = 1 if prnt2 ==1 & v`n14' ==1 & year==`Y' & disab_prnt2!=1; /* 制限あり */
		replace disab_prnt2 = 0 if prnt2 ==1 & v`n14' ==9 & year==`Y' & disab_prnt2!=1; /* 該当しない */
		des v`n14', short;

		/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
		replace handi_prnt2 = 1 if prnt2 ==1 & v`n15' ==1 & year==`Y' & handi_prnt2!=1; /* 認定あり */
		replace handi_prnt2 = 0 if prnt2 ==1 & v`n15' ==9 & year==`Y'& handi_prnt2!=1; /* 該当しない */
		des v`n15', short;
	};

};


/* job_prntの統合 */
forvalues i=1/2{;
	replace job_prnt`i' = job_prnt`i'_j if  job_prnt`i'_j !=.;
	drop job_prnt`i'_j;
};


/* 年齢の補完 */
forvalues i=1/2{;
	/*
	ageprnt2
	ageprnt`i'[_n-1] = 4
	ageprnt`i'[_n] = .
	ageprnt`i'[_n+1] =6
	*/
	* replace ageprnt`i' =ageprnt`i'[_n-1]+1 if ageprnt`i'==. & ageprnt`i'[_n-1]!=. & ageprnt`i'[_n+1]!=. & v1[_n]==v1[_n-1] & v1[_n]==v1[_n+1] & attr==0;
	
	/* 次のようなケースの修正
	   ageprnt`i'[_n-1] = 25
	   ageprnt`i'[_n] =  55
	   ageprnt`i'[_n+1] = 27

	v1==10578
	year birthy_prnt2	ageprnt2
	2004	1940		63
	2005	1940		64
	2006	1940		65
	2007	1942		64
	2007年はおそらく誤記
	*/

	/* n+1は不明の場合 */
	replace ageprnt`i' = ageprnt`i'[_n-1]+1 if ageprnt`i'[_n-1]!=. 
						& prnt`i'==1 & ageprnt`i'!=ageprnt`i'[_n-1]+1 
						& v1[_n]==v1[_n-1] & attr==0;

	* replace ageprnt`i' = ageprnt`i'[_n-1]+1 if ageprnt`i'!=ageprnt`i'[_n-1]+1 & ageprnt`i'[_n+1] ==ageprnt`i'[_n-1]+2 & v1[_n]==v1[_n-1] & v1[_n]==v1[_n+1] & attr==0;
};


sum prnt1-prnt2;
sum dokyo_prnt1-dokyo_prnt2;
sum mar_prnt1-mar_prnt2;
sum job_prnt1-job_prnt2;
sum ageprnt1-ageprnt2;


/*
チェック用
browse v1 year v13 v15 v20 v22 v27 v29  v34 v36 v41 v43 v48 v50 v55 v57 v62 v64 v69 v71  prnt1 ageprnt1 prnt2 ageprnt2 
browse v1 year ageprnt1 ageprnt2 ageprnt3 ageprnt4 ageprnt5 ageprnt6 dokyo_prnt1-dokyo_prnt6
*/

sum prnt1-prnt2 dokyo_prnt1-dokyo_prnt2 mar_prnt1-mar_prnt2 
job_prnt1-job_prnt2 ageprnt1-ageprnt2 deth_prnt1 deth_prnt2 birthy_prnt1 birthy_prnt2
edu_prnt1 edu_prnt2 
time1_prnt1 time2_prnt1 time1_prnt2 time2_prnt2 nocntct_prnt1 nocntct_prnt2
disab_prnt1 disab_prnt2 handi_prnt1 handi_prnt2, separator(0);

/*
keep id v1 year prnt1-prnt2 dokyo_prnt1-dokyo_prnt2 mar_prnt1-mar_prnt2 
job_prnt1-job_prnt2 ageprnt1-ageprnt2 deth_prnt1 deth_prnt2 birthy_prnt1 birthy_prnt2
time1_prnt1 time2_prnt1 time1_prnt2 time2_prnt2 nocntct_prnt1 nocntct_prnt2
disab_prnt1 disab_prnt2 handi_prnt1 handi_prnt2;
*/

* save parent_data.dta, replace;


* browse v1 year v4 v6 prnt1 prnt2 birthy_prnt1 birthy_prnt2

