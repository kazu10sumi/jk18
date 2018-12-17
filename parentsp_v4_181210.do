#delimit;
/************
clear;
clear matrix;

set more off;


/* 自分用 */
cd "C:\Users\Kazuto Sumita\Dropbox\DATA\JK18\var";
use temp.dta;
log using parntsp_v4.log, replace;

*************/

/*** 最新調査年 ***/
global ly 2018;


/*** 家族表　配偶者の親関連変数 ***/

/* 配偶者の親の有無 */
gen prntsp1 =.;
gen prntsp2 =.;

/* 結婚しているか */
gen mar_prntsp1 = .;
gen mar_prntsp2 = .;

/* 就職している */
gen job_prntsp1 = .;
gen job_prntsp2 = .;

gen job_prntsp1_j = .;
gen job_prntsp2_j = .;

/* 生年 */
gen birthy_prntsp1 =.;
gen birthy_prntsp2 =.;

/* 配偶者の親の年齢 */
gen ageprntsp1=.;
gen ageprntsp2=.;

/* 同居 */
gen dokyo_prntsp1 =.;
gen dokyo_prntsp2 =.;


forvalues Y=2004/2016 {;

* scalar Y=2004;
* scalar X=2004;

/* 一人目の配偶者の親(父親) */

	local n4a=3015; /* J2009-J2014, K2014 就職 変数作成用*/
	forvalues n0= 13(7)69 {;
		local n1 = `n0'+1; /* 性別 */
		local n2 = `n0'+2; /* 生年 */
		local n3 = `n0'+3; /* 生年月 */
		local n4 = `n0'+4; /* 就職 */
		local n5 = `n0'+5; /* 同居 */
		local n6 = `n0'+6; /* 結婚 */

		/* 父親 */
		replace prntsp1 = 1 if v`n0'==6 & v`n1'==1 & year==`Y' & prntsp1!=1; /* 男性 */
		replace prntsp1 = 0 if v`n0'==6 & v`n1'==2 & year==`Y' & prntsp1!=1; /* 女性 */

		/* 生年 */
		replace birthy_prntsp1 = v`n2' if v`n0'==6 & v`n1'==1  & year==`Y' & birthy_prntsp1==. &  v`n2' <8888; 

		/* 年齢 */
		local X = `Y'-1;
		replace ageprntsp1 = `Y'-birthy_prntsp1 if v`n0'==6 & v`n1'==1  & year==`Y' & ageprntsp1==.& v`n3' ==1; /* 1月生まれ */
		replace ageprntsp1 = `X'-birthy_prntsp1 if v`n0'==6 & v`n1'==1  & year==`Y' & ageprntsp1==.& v`n3' !=1; 

		/* 同居 */
		replace dokyo_prntsp1 =1 if v`n0'==6 & v`n1'==1  & v`n5'==1 & year==`Y' & dokyo_prntsp1!=1; /* 男性・同居 */
		replace dokyo_prntsp1 =0 if v`n0'==6 & v`n1'==1  & v`n5'==2 & year==`Y' & dokyo_prntsp1!=1; /* 男性・別居 */
		replace dokyo_prntsp1 =0 if v`n0'==6 & v`n1'==2  & v`n5'==1 & year==`Y' & dokyo_prntsp1!=1; /* 女性・同居 */
		replace dokyo_prntsp1 =0 if v`n0'==6 & v`n1'==2  & v`n5'==2 & year==`Y' & dokyo_prntsp1!=1; /* 女性・別居 */

		/* 配偶状況 */
		replace mar_prntsp1 = 1 if v`n0'==6 & v`n1'==1  & v`n6'==2 & year==`Y' & mar_prntsp1 != 1; /* 男性・既婚 */
		replace mar_prntsp1 = 0 if v`n0'==6 & v`n1'==1  & v`n6'==1 & year==`Y' & mar_prntsp1 != 1; /* 男性・未婚 */
		replace mar_prntsp1 = 0 if v`n0'==6 & v`n1'==2  & v`n6'==2 & year==`Y' & mar_prntsp1 != 1; /* 女性・既婚 */
		replace mar_prntsp1 = 0 if v`n0'==6 & v`n1'==2  & v`n6'==1 & year==`Y' & mar_prntsp1 != 1; /* 女性・未婚 */

		/* 就業状況 */
		/* K2004-K2013 */
		replace job_prntsp1 = 1 if v`n0'==6 & v`n1'==1  & v`n4'==8 & year==`Y' & job_prntsp1 != 1; /* 男性・就職 */
		replace job_prntsp1 = 0 if v`n0'==6 & v`n1'==1  & v`n4'!=8 & year==`Y' & job_prntsp1 != 1; /* 男性・就職していない */
		replace job_prntsp1 = 0 if v`n0'==6 & v`n1'==2  & v`n4'==8 & year==`Y' & job_prntsp1 != 1; /* 女性・就職 */
		replace job_prntsp1 = 0 if v`n0'==6 & v`n1'==2  & v`n4'!=8 & year==`Y' & job_prntsp1 != 1; /* 女性・就職していない */

		/* J2009-J2014, K2014 */
		replace job_prntsp1_j = 1 if v`n0'==6 & v`n1'==1  & v`n4a'==2 & year==`Y' & job_prntsp1_j != 1; /* 男性・就職 */
		replace job_prntsp1_j = 0 if v`n0'==6 & v`n1'==1  & v`n4a'==1 & year==`Y'& job_prntsp1_j != 1; /* 男性・就職していない */
		replace job_prntsp1_j = 0 if v`n0'==6 & v`n1'==2  & v`n4a'==2 & year==`Y'& job_prntsp1_j != 1; /* 女性・就職 */
		replace job_prntsp1_j = 0 if v`n0'==6 & v`n1'==2  & v`n4a'==1 & year==`Y'& job_prntsp1_j != 1; /* 女性・就職していない */

		* des v`n', short;
	};

	/* 二人目の配偶者の親 */

	forvalues n0= 13(7)69 {;
		local n1 = `n0'+1; /* 性別 */
		local n2 = `n0'+2; /* 生年 */
		local n3 = `n0'+3; /* 生年月 */
		local n4 = `n0'+4; /* 就職 */
		local n5 = `n0'+5; /* 同居 */
		local n6 = `n0'+6; /* 結婚 */

		/* 母親 */
		replace prntsp2 = 0 if v`n0'==6 & v`n1'==1 & year==`Y' & prntsp2!=1; /* 男性 */
		replace prntsp2 = 1 if v`n0'==6 & v`n1'==2 & year==`Y' & prntsp2!=1; /* 女性 */
		/*  prnt2!=1 の意味
		父親・母親の順で回答されている場合には、
		初めのreplaceで、prnt2=0が入ってしまうケースが多いので、
		次のreplaceで、prnt2==.を対象にしては、replaceがスキップされてしまうため。
		*/

		/* 生年 */
		replace birthy_prntsp2 = v`n2' if v`n0'==6 & v`n1'==2 & year==`Y' & birthy_prntsp2==. &  v`n2' <8888; 
		/* prnt2==1となったときの出生年である必要がある。*/

		/* 年齢 */
		local X = `Y'-1;
		replace ageprntsp2 = `Y'-birthy_prntsp2 if prntsp2 == 1 & year==`Y' & ageprntsp2==.& v`n0' ==1; /* 1月生まれ*/
		replace ageprntsp2 = `X'-birthy_prntsp2 if prntsp2 == 1 & year==`Y' & ageprntsp2==.& v`n0' !=1; 

		/* 同居 */
		replace dokyo_prntsp2 =0 if  v`n0'==6 & v`n1'==1  & v`n5'==1 & year==`Y' & dokyo_prntsp2 !=1; /* 男性・同居 */
		replace dokyo_prntsp2 =0 if  v`n0'==6 & v`n1'==1  & v`n5'==2 & year==`Y' & dokyo_prntsp2 !=1; /* 男性・別居 */
		replace dokyo_prntsp2 =1 if  v`n0'==6 & v`n1'==2  & v`n5'==1 & year==`Y' & dokyo_prntsp2 !=1; /* 女性・同居 */
		replace dokyo_prntsp2 =0 if  v`n0'==6 & v`n1'==2  & v`n5'==2 & year==`Y' & dokyo_prntsp2 !=1; /* 女性・別居 */

		/* 配偶状況 */
		replace mar_prntsp2 = 0 if  v`n0'==6 & v`n1'==1  & v`n6'==2 & year==`Y' & mar_prntsp2 != 1; /* 男性・既婚 */
		replace mar_prntsp2 = 0 if  v`n0'==6 & v`n1'==1  & v`n6'==1 & year==`Y' & mar_prntsp2 != 1; /* 男性・未婚 */
		replace mar_prntsp2 = 1 if  v`n0'==6 & v`n1'==2  & v`n6'==2 & year==`Y' & mar_prntsp2 != 1; /* 女性・既婚 */
		replace mar_prntsp2 = 0 if  v`n0'==6 & v`n1'==2  & v`n6'==1 & year==`Y' & mar_prntsp2 != 1; /* 女性・未婚 */

		/* 就業状況 */
		/* K2004-K2013 */
		replace job_prntsp2 = 0 if  v`n0'==6 & v`n1'==1  & v`n4'==8 & year==`Y' & job_prntsp2 != 1; /* 男性・就職 */
		replace job_prntsp2 = 0 if  v`n0'==6 & v`n1'==1  & v`n4'!=8 & year==`Y' & job_prntsp2 != 1; /* 男性・就職していない */
		replace job_prntsp2 = 1 if  v`n0'==6 & v`n1'==2  & v`n4'==8 & year==`Y' & job_prntsp2 != 1; /* 女性・就職 */
		replace job_prntsp2 = 0 if  v`n0'==6 & v`n1'==2  & v`n4'!=8 & year==`Y' & job_prntsp2 != 1; /* 女性・就職していない */
		/* id=10195: 次に就業している子を回答していると、その回答が入ってしまう傾向がある。*/

		/* J2009-J2014, K2014 */
		replace job_prntsp2_j = 0 if  v`n0'==6 & v`n1'==1  & v`n4a'==2 & year==`Y' & job_prntsp2_j != 1; /* 男性・就職 */
		replace job_prntsp2_j = 0 if  v`n0'==6 & v`n1'==1  & v`n4a'==1 & year==`Y' & job_prntsp2_j != 1; /* 男性・就職していない */
		replace job_prntsp2_j = 1 if  v`n0'==6 & v`n1'==2  & v`n4a'==2 & year==`Y' & job_prntsp2_j != 1; /* 女性・就職 */
		replace job_prntsp2_j = 0 if  v`n0'==6 & v`n1'==2  & v`n4a'==1 & year==`Y' & job_prntsp2_j != 1; /* 女性・就職していない */

		des v`n4a', short;
		local n4a = `n4a'+3;

	};
};


/*** 2017年からの新しい家族表 ***/

/* 最終学歴 */
gen edu_prntsp1=.;
label var edu_prntsp1 "父親:学歴";

gen edu_prntsp2=.;
label var edu_prntsp2 "母親:学歴";

/* 家族関係の変化 */
gen chng_prntsp1 = .;
label var chng_prntsp1 "父親・家族関係変化";

gen chng_prntsp2 = .;
label var chng_prntsp2 "母親・家族関係変化";

gen deth_prntsp1=. ;
label var deth_prntsp1 "父親：死別";

gen deth_prntsp2 = .;
label var deth_prntsp2 "母親：死別";

gen samelive_prntsp1 = .;
label var samelive_prntsp1 "1:同一生計";

gen samelive_prntsp2 = .;
label var samelive_prntsp2 "1:同一生計";

gen time1_prntsp1 = .;
gen time2_prntsp1 = .;
gen time_prntsp1 = .;
label var time_prntsp1 "対象者の家からかかる時間・分";

gen time1_prntsp2 = .;
gen time2_prntsp2 = .;
gen time_prntsp2 = .;
label var time_prntsp2 "対象者の家からかかる時間・分";

gen nocntct_prntsp1 =.;
label var nocntct_prntsp1 "1:対象者・配偶者から連絡がつかない";

gen nocntct_prntsp2 =.;
label var nocntct_prntsp2 "1:対象者・配偶者から連絡がつかない";


gen disab_prntsp1 =.;
label var disab_prntsp1 "1:慢性的な日常生活制限";

gen disab_prntsp2 =.;
label var disab_prntsp2 "1:慢性的な日常生活制限";


gen handi_prntsp1 =.;
label var handi_prntsp1 "1:要支援・要介護認定・障害支援区分の認定";

gen handi_prntsp2 =.;
label var handi_prntsp2 "1:要支援・要介護認定・障害支援区分の認定";

forvalues Y=2017/$ly {;

	/* 一人目の親(父親) */
	local n4a=3015; /* J2009-J2014, K2014 就職 変数作成用 2人目の家族*/
	forvalues n0= 13(7)69 {;
		local n1 = `n0'+1; /* 性別 */
		local n2 = `n0'+2; /* 生年 */
		local n3 = `n0'+3; /* 生年月 */
		local n4 = `n0'+4; /* 就職 */
		local n5 = `n0'+5; /* 同居 */
		local n6 = `n0'+6; /* 結婚 */

		des v`n0', short;

		/* 父親 */
		replace prntsp1 = 1 if v`n0'==5 & v`n1'==1 & year==`Y' & prntsp1!=1; /* 男性 */
		replace prntsp1 = 0 if v`n0'==5 & v`n1'==2 & year==`Y' & prntsp1!=1; /* 女性 */
		/*  prntsp1!=1 の意味
		prntsp1==. or prntsp1==0を対象とする
		*/
		des v`n1', short;

		/* 生年 */
		replace birthy_prntsp1 = v`n2' if v`n0'==5 & v`n1'==1  & year==`Y' & birthy_prntsp1==. &  v`n2' <7777; 
		* replace birthy_prntsp1 = . if prntsp1==. & year==`Y';
		des v`n2', short;

		/* 年齢 */
		local X = `Y'-1;
		replace ageprntsp1 = `Y'-birthy_prntsp1 if v`n0'==5 & v`n1'==1  & year==`Y' & ageprntsp1==.& v`n3' ==1; /* 1月生まれ */
		replace ageprntsp1 = `X'-birthy_prntsp1 if v`n0'==5 & v`n1'==1  & year==`Y' & ageprntsp1==.& v`n3' !=1; 
		des v`n3', short;

		/* 同居 */
		replace dokyo_prntsp1 =1 if v`n0'==5 & v`n1'==1  & v`n5'==1 & year==`Y' & dokyo_prntsp1!=1; /* 男性・同居 */
		replace dokyo_prntsp1 =0 if v`n0'==5 & v`n1'==1  & v`n5'==2 & year==`Y' & dokyo_prntsp1!=1; /* 男性・別居 */
		replace dokyo_prntsp1 =0 if v`n0'==5 & v`n1'==2  & v`n5'==1 & year==`Y' & dokyo_prntsp1!=1; /* 女性・同居 */
		replace dokyo_prntsp1 =0 if v`n0'==5 & v`n1'==2  & v`n5'==2 & year==`Y' & dokyo_prntsp1!=1; /* 女性・別居 */
		des v`n5', short;

		/* 配偶状況 */
		replace mar_prntsp1 = 1 if v`n0'==5 & v`n1'==1  & v`n6'==2 & year==`Y' & mar_prntsp1 != 1; /* 男性・既婚 */
		replace mar_prntsp1 = 0 if v`n0'==5 & v`n1'==1  & v`n6'==1 & year==`Y' & mar_prntsp1 != 1; /* 男性・未婚 */
		replace mar_prntsp1 = 0 if v`n0'==5 & v`n1'==2  & v`n6'==2 & year==`Y' & mar_prntsp1 != 1; /* 女性・既婚 */
		replace mar_prntsp1 = 0 if v`n0'==5 & v`n1'==2  & v`n6'==1 & year==`Y' & mar_prntsp1 != 1; /* 女性・未婚 */
		des v`n6', short;


		/* 就業状況 */
		replace job_prntsp1_j = 1 if prntsp1==1 & v`n4a' ==2 & year==`Y' & job_prntsp1_j==. & v`n4a' <8 & v`n4a' !=. ; /* 就業 */
		replace job_prntsp1_j = 0 if prntsp1==1 & v`n4a' ==1 & year==`Y' & job_prntsp1_j==. & v`n4a' <8 & v`n4a' !=. ; /* 非就業 */

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
		replace edu_prntsp1= v`n7' if prntsp1==1 & year==`Y' & edu_prntsp1==.; 
		des v`n7', short;

		/* 家族関係の変化 */
		replace chng_prntsp1 = v`n8' if prntsp1==1 & year==`Y' & chng_prntsp1==.;
		des v`n8', short;

		/* 家族関係の変化: 死別 */
		replace deth_prntsp1 = 1 if prntsp1==1 & year==`Y' & deth_prntsp1==. & v`n8' ==2; /* 死別 */
		replace deth_prntsp1 = 0 if prntsp1==1 & year==`Y' & deth_prntsp1==. & (v`n8' ==1 |v`n8'==3); /* 生存 */

		/* 配偶関係 */
		replace mar_prntsp1 = 1 if v`n9'==5 & prntsp1==1  & v`n9'==2 & year==`Y' & mar_prntsp1 ==.; /* 男性・既婚 */
		replace mar_prntsp1 = 0 if v`n9'==5 & prntsp1==1  & v`n9'==1 & year==`Y' & mar_prntsp1 ==.; /* 男性・未婚 */
		des v`n9', short;

		/* 対象者の家からかかる時間・時 */
		replace time1_prntsp1 = v`n10' if prntsp1==1 & v`n10'<888 & year==`Y' & time1_prntsp1==.;
		des v`n10', short;

		/* 対象者の家からかかる時間・分 */
		replace time2_prntsp1 = v`n11' if prntsp1==1 & v`n11'<888 & year==`Y' & time2_prntsp1==.;
		des v`n11', short;

		/* 対象者の家からかかる時間・分 */
		replace time_prntsp1 = time1_prntsp1*60+time2_prntsp1 if time1_prntsp1 !=. & time2_prntsp1!=.;
		replace time_prntsp1 = time1_prntsp1*60 if time1_prntsp1 !=. & time2_prntsp1==.;
		replace time_prntsp1 = time2_prntsp1 if time1_prntsp1 ==. & time2_prntsp1!=.;

		/* 配偶者から連絡がつかない */
		replace nocntct_prntsp1 = 1 if prntsp1 ==1 & v`n12'==1 & year==`Y' & nocntct_prntsp1==.;
		replace nocntct_prntsp1 = 0 if prntsp1 ==1 & v`n12'==8 & year==`Y'& nocntct_prntsp1==.;
		des v`n12', short;

		/* 同一生計 */
		replace samelive_prntsp1 = 1 if prntsp1 ==1 & v`n13' ==1 & year==`Y' & samelive_prntsp1==.; /* 同一家計 */
		replace samelive_prntsp1 = 0 if prntsp1 ==1 & v`n13' ==9 & year==`Y' & samelive_prntsp1==.; /* 該当しない */
		des v`n13', short;

		/* 慢性的な日常生活の制限 disability*/
		replace disab_prntsp1 = 1 if prntsp1 ==1 & v`n14' ==1 & year==`Y' & disab_prntsp1==.; /* 制限あり */
		replace disab_prntsp1 = 0 if prntsp1 ==1 & v`n14' ==9 & year==`Y' & disab_prntsp1==.; /* 該当しない */
		des v`n14', short;

		/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
		replace handi_prntsp1 = 1 if prntsp1 ==1 & v`n15' ==1 & year==`Y' & handi_prntsp1==.; /* 認定あり */
		replace handi_prntsp1 = 0 if prntsp1 ==1 & v`n15' ==9 & year==`Y'& handi_prntsp1==.; /* 該当しない */
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
		replace prntsp2 = 0 if v`n0'==5 & v`n1'==1 & year==`Y' & prntsp2!=1; /* 男性 */
		replace prntsp2 = 1 if v`n0'==5 & v`n1'==2 & year==`Y' & prntsp2!=1; /* 女性 */
		/*  prntsp2!=1 の意味
		父親・母親の順で回答されている場合には、
		初めのreplaceで、prntsp2=0が入ってしまうケースが多いので、
		次のreplaceで、prntsp2==.を対象にしては、replaceがスキップされてしまうため。
		*/
		des v`n1', short;

		/* 生年 */
		replace birthy_prntsp2 = v`n2' if v`n0'==5 & v`n1'==2 & year==`Y' & birthy_prntsp2==. &  v`n2' <7777; 
		/* prntsp2==1となったときの出生年である必要がある。*/
		* replace birthy_prntsp2 = . if prntsp2==. & year==`Y';
		des v`n2', short;

		/* 年齢 */
		local X = `Y'-1;
		replace ageprntsp2 = `Y'-birthy_prntsp2 if prntsp2 == 1 & year==`Y' & ageprntsp2==.& v`n0' ==1; /* 1月生まれ*/
		replace ageprntsp2 = `X'-birthy_prntsp2 if prntsp2 == 1 & year==`Y' & ageprntsp2==.& v`n0' !=1; 
		des v`n0', short;

		/* 同居 */
		replace dokyo_prntsp2 =0 if  v`n0'==5 & v`n1'==1  & v`n5'==1 & year==`Y' & dokyo_prntsp2 !=1; /* 男性・同居 */
		replace dokyo_prntsp2 =0 if  v`n0'==5 & v`n1'==1  & v`n5'==2 & year==`Y' & dokyo_prntsp2 !=1; /* 男性・別居 */
		replace dokyo_prntsp2 =1 if  v`n0'==5 & v`n1'==2  & v`n5'==1 & year==`Y' & dokyo_prntsp2 !=1; /* 女性・同居 */
		replace dokyo_prntsp2 =0 if  v`n0'==5 & v`n1'==2  & v`n5'==2 & year==`Y' & dokyo_prntsp2 !=1; /* 女性・別居 */
		des v`n5', short;

		/* 配偶状況 */
		replace mar_prntsp2 = 0 if  v`n0'==5 & v`n1'==1  & v`n6'==2 & year==`Y' & mar_prntsp2 != 1; /* 男性・既婚 */
		replace mar_prntsp2 = 0 if  v`n0'==5 & v`n1'==1  & v`n6'==1 & year==`Y' & mar_prntsp2 != 1; /* 男性・未婚 */
		replace mar_prntsp2 = 1 if  v`n0'==5 & v`n1'==2  & v`n6'==2 & year==`Y' & mar_prntsp2 != 1; /* 女性・既婚 */
		replace mar_prntsp2 = 0 if  v`n0'==5 & v`n1'==2  & v`n6'==1 & year==`Y' & mar_prntsp2 != 1; /* 女性・未婚 */
		des v`n6', short;

		/* 就業状況 */
		/* K2004-K2013 */
		replace job_prntsp2 = 0 if  v`n0'==5 & v`n1'==1  & v`n4'==8 & year==`Y' & job_prntsp2 != 1; /* 男性・就職 */
		replace job_prntsp2 = 0 if  v`n0'==5 & v`n1'==1  & v`n4'!=8 & year==`Y' & job_prntsp2 != 1; /* 男性・就職していない */
		replace job_prntsp2 = 1 if  v`n0'==5 & v`n1'==2  & v`n4'==8 & year==`Y' & job_prntsp2 != 1; /* 女性・就職 */
		replace job_prntsp2 = 0 if  v`n0'==5 & v`n1'==2  & v`n4'!=8 & year==`Y' & job_prntsp2 != 1; /* 女性・就職していない */
		/* id=10195: 次に就業している子を回答していると、その回答が入ってしまう傾向がある。*/
		des v`n4', short;

		/* J2009-J2014, K2014 */
		replace job_prntsp2_j = 0 if  v`n0'==5 & v`n1'==1  & v`n4a'==2 & year==`Y' & job_prntsp2_j != 1; /* 男性・就職 */
		replace job_prntsp2_j = 0 if  v`n0'==5 & v`n1'==1  & v`n4a'==1 & year==`Y' & job_prntsp2_j != 1; /* 男性・就職していない */
		replace job_prntsp2_j = 1 if  v`n0'==5 & v`n1'==2  & v`n4a'==2 & year==`Y' & job_prntsp2_j != 1; /* 女性・就職 */
		replace job_prntsp2_j = 0 if  v`n0'==5 & v`n1'==2  & v`n4a'==1 & year==`Y' & job_prntsp2_j != 1; /* 女性・就職していない */

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
		replace edu_prntsp2= v`n7' if prntsp2==1 & year==`Y' & edu_prntsp2!=1; 
		des v`n7', short;

		/* 家族関係の変化 */
		replace chng_prntsp2 = v`n8' if prntsp2==1 & year==`Y' & chng_prntsp2!=1;
		des v`n8', short;

		/* 家族関係の変化: 死別 */
		replace deth_prntsp2 = 1 if prntsp2==1 & year==`Y' & deth_prntsp2!=1 & v`n8' ==2; /* 死別 */
		replace deth_prntsp2 = 0 if prntsp2==1 & year==`Y' & deth_prntsp2!=1 & (v`n8' ==1 |v`n8'==3); /* 生存 */

		/* 配偶関係 */
		replace mar_prntsp2 = 1 if v`n9'==5 & prntsp2==1  & v`n9'==2 & year==`Y' & mar_prntsp2 !=1; /* 男性・既婚 */
		replace mar_prntsp2 = 0 if v`n9'==5 & prntsp2==1  & v`n9'==1 & year==`Y' & mar_prntsp2 !=1; /* 男性・未婚 */
		des v`n9', short;

		/* 対象者の家からかかる時間・時 */
		replace time1_prntsp2 = v`n10' if prntsp2==1 & v`n10'<888 & year==`Y' & time1_prntsp2!=1;
		des v`n10', short;

		/* 対象者の家からかかる時間・分 */
		replace time2_prntsp2 = v`n11' if prntsp2==1 & v`n11'<888 & year==`Y' & time2_prntsp2!=1;
		des v`n11', short;

		/* 対象者の家からかかる時間・分 */
		replace time_prntsp2 = time1_prntsp1*60+time2_prntsp2 if time1_prntsp1 !=. & time2_prntsp2!=1;
		replace time_prntsp2 = time1_prntsp2*60 if time1_prntsp2!=. & time2_prntsp2!=1;
		replace time_prntsp2 = time2_prntsp2 if time1_prntsp2 ==. & time2_prntsp2!=1;

		/* 配偶者から連絡がつかない */
		replace nocntct_prntsp2 = 1 if prntsp2 ==1 & v`n12'==1 & year==`Y' & nocntct_prntsp2!=1;
		replace nocntct_prntsp2 = 0 if prntsp2 ==1 & v`n12'==8 & year==`Y'& nocntct_prntsp2!=1;
		des v`n12', short;

		/* 同一生計 */
		replace samelive_prntsp2 = 1 if prntsp2 ==1 & v`n13' ==1 & year==`Y' & samelive_prntsp2!=1; /* 同一家計 */
		replace samelive_prntsp2 = 0 if prntsp2 ==1 & v`n13' ==9 & year==`Y' & samelive_prntsp2!=1; /* 該当しない */
		des v`n13', short;

		/* 慢性的な日常生活の制限 disability*/
		replace disab_prntsp2 = 1 if prntsp2 ==1 & v`n14' ==1 & year==`Y' & disab_prntsp2!=1; /* 制限あり */
		replace disab_prntsp2 = 0 if prntsp2 ==1 & v`n14' ==9 & year==`Y' & disab_prntsp2!=1; /* 該当しない */
		des v`n14', short;

		/* 要支援・要介護認定・障害支援区分の認定 handicapped*/
		replace handi_prntsp2 = 1 if prntsp2 ==1 & v`n15' ==1 & year==`Y' & handi_prntsp2!=1; /* 認定あり */
		replace handi_prntsp2 = 0 if prntsp2 ==1 & v`n15' ==9 & year==`Y'& handi_prntsp2!=1; /* 該当しない */
		des v`n15', short;
	};

};


/* job_prntspの統合 */
forvalues i=1/2{;
	replace job_prntsp`i' = job_prntsp`i'_j if  job_prntsp`i'_j !=.;
	drop job_prntsp`i'_j;
};


/* 年齢の補完 */
forvalues i=1/2{;
	/*
	ageprntsp2
	ageprntsp`i'[_n-1] = 4
	ageprntsp`i'[_n] = .
	ageprntsp`i'[_n+1] =6
	*/
	* replace ageprntsp`i' =ageprntsp`i'[_n-1]+1 if ageprntsp`i'==. & ageprntsp`i'[_n-1]!=. & ageprntsp`i'[_n+1]!=. & v1[_n]==v1[_n-1] & v1[_n]==v1[_n+1] & attr==0;
	
	/* 次のようなケースの修正
	   ageprntsp`i'[_n-1] = 25
	   ageprntsp`i'[_n] =  55
	   ageprntsp`i'[_n+1] = 27

	v1==10578
	year birthy_prntsp2	ageprntsp2
	2004	1940		63
	2005	1940		64
	2006	1940		65
	2007	1942		64
	2007年はおそらく誤記
	*/

	/* n+1は不明の場合 */
	replace ageprntsp`i' = ageprntsp`i'[_n-1]+1 if ageprntsp`i'[_n-1]!=. 
						& prntsp`i'==1 & ageprntsp`i'!=ageprntsp`i'[_n-1]+1 
						& v1[_n]==v1[_n-1] & attr==0;

	* replace ageprntsp`i' = ageprntsp`i'[_n-1]+1 if ageprntsp`i'!=ageprntsp`i'[_n-1]+1 & ageprntsp`i'[_n+1] ==ageprntsp`i'[_n-1]+2 & v1[_n]==v1[_n-1] & v1[_n]==v1[_n+1] & attr==0;
};

/*
チェック用
browse v1 year v13 v15 v20 v22 v27 v29  v34 v36 v41 v43 v48 v50 v55 v57 v62 v64 v69 v71  prntsp1 ageprntsp1 prntsp2 ageprntsp2 
browse v1 year ageprnt1 ageprnt2 ageprnt3 ageprnt4 ageprnt5 ageprnt6 dokyo_prnt1-dokyo_prnt6
*/

sum prntsp1-prntsp2;
sum dokyo_prntsp1-dokyo_prntsp2;
sum mar_prntsp1-mar_prntsp2;
sum job_prntsp1-job_prntsp2;
sum ageprntsp1-ageprntsp2;



