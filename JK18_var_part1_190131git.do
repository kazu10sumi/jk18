/* 
Part 1 of generating the variables
Kazuto Sumita
*/

/*** preamble ***/

#delimit;
clear;
clear matrix;
capture log close;

* erase JK17.dta;


set more off;

set maxvar 12000;

cd "working directory";

log using JK18_var_prt1_190131.log, replace;

/* JK18 */
global JK18 "location of data file";

/* doファイル */
global dof "location of data file";


/* 途中保存データ */
global temp_dat temp.dta;


/*** 最新調査年 ***/
global ly 2018;
/* scalar ly=2014; */

/* 最新調査年の1年前 */
global ly_s1 2017;
/* scalar ly_s1 = ly-1; */

/* 最新調査年の2年前 */
global ly_s2 2016;
/*scalar ly_s2 = ly-2;*/

/** データの読み込み **/
use $JK18, clear;


/*
****************************************
2016年調査まで、
単身者票の場合、家族表コードが異なるので、
配偶者表のコードに合わせる
****************************************
*/

/* チェック変数の作成 */
forvalues i=13(7)69 {;
	gen v`i'_chck = .;
	/* 単身者コード v4==2 */
	replace v`i'_chck = 0 if v4==2 & year<=2016;
};

forvalues i=13(7)69 {;

	/* 子供: 1 ->  2 */
	replace v`i'_chck = 2 if v`i'==1 & v`i'_chck==0 & year<=2016;  
	replace v`i' = 2 if v`i'_chck ==2;

	/* 子供の配偶者: 2 -> 3 */
	replace v`i'_chck = 3 if v`i'==2 & v`i'_chck==0 & year<=2016;
	replace v`i' = 3 if v`i'_chck==3;

	/* 孫: 3-> 4 */
	replace v`i'_chck = 4 if v`i'==3 & v`i'_chck==0 & year<=2016;
	replace v`i' = 4 if v`i'_chck==4;

	/* 父母: 4-> 5 */
	replace v`i'_chck = 5 if v`i'==4 & v`i'_chck==0 & year<=2016;
	replace v`i' = 5 if v`i'_chck==5;

	/* 祖父母: 5 -> 7 */
	replace v`i'_chck = 7 if v`i'==5 & v`i'_chck==0 & year<=2016;
	replace v`i' = 7 if  v`i'_chck==7;

	/* 兄弟姉妹: 6->9 */
	replace v`i'_chck = 9 if v`i'==6 & v`i'_chck==0 & year<=2016;
	replace v`i' = 9 if v`i'_chck==9;

	/* その他の親族: 7 -> 11 */
	replace v`i'_chck = 11 if v`i'==7 & v`i'_chck==0 & year<=2016;
	replace v`i' = 11 if v`i'_chck==11;

	/* その他: 8 -> 12 */
	replace v`i'_chck = 12 if v`i'==8 & v`i'_chck==0 & year<=2016;
	replace v`i' = 12 if v`i'_chck==12;
};

/* チェック変数の削除 */
forvalues i=13(7)69 {;
	drop v`i'_chck;
};


save $temp_dat, replace;


/**** 家族表 ****/

/*** 配偶者 ***/
do "${dof}\spouse_v1_190131.do";

/*** 両親関連 ***/
do "${dof}\parent_v4_190109.do"; 
do "${dof}\fr_v1_190109.do"; 
do "${dof}\mr_v1_190109.do"; 

/*** 配偶者の両親関連 ***/
do "${dof}\parentsp_v4_190109.do"; 
do "${dof}\frsp_v1_190109.do"; 
do "${dof}\mrsp_v1_190109.do"; 

/*** 子供関連 ***/

/* 子供の有無 全員把握できているはず？ */
do "${dof}\kid_v7_190127.do";
* do "${dof}kid_v6_190109.do";

/* チェックできていない--子どもの配偶者 */
/*
/*** 子供の配偶者関連 ***/
do ${dof}\kidsp_v6_190109.do;

save $temp_dat, replace;
*/

/*** 孫関連 ***/
/* 世帯外の子供の子は補足できないので、不正確な変数となる */
do "${dof}\mago_v6_190109.do";

/*** 兄弟関連 ***/
do "${dof}\sibling_v6_190109.do";

/*** 配偶者の兄弟関連 ***/
do "${dof}\siblingsp_v6_190109.do";

save $temp_dat, replace;

/*** part 1の保存 ***/
sort id year;
save $output_data, replace;

log close;
exit;
