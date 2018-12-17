/* 
Part 1 of generating the variables
*/

/*** preamble ***/
#delimit;
clear;
clear matrix;

* erase JK17.dta;


set more off;

set maxvar 12000;

* C:\Users\Kazuto Sumita\Dropbox\DATA\JK18\var
cd "C:\Users\Kazuto Sumita\Dropbox\DATA\JK18\var"; 

log using JK18_var_prt1_181104.log, replace;

/* JK18 */
global JK18 "C:\JHPS_KHPS\JHPS_KHPS.dta";

/* C:\Users\Kazuto Sumita\Dropbox\DATA\JK18\JHPSKHPS2018_city */
global JK18_city_dat "..\JHPSKHPS2018_city\city_jk18_dat.csv";

/* 出力ファイル */
global output_data JK18_var_part1_181104.dta;

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


/*** idの読み込み ***/
clear;
cd "C:\Users\Kazuto Sumita\Dropbox\DATA\JK18\id";
* insheet using "..\id\jk_id_dat.csv";
insheet using "jk_id_dat.csv";
sort id year;
label var id "id";
save JK18_id.dta, replace;

/*** idデータの接続 ***/
clear;
use JK18_id.dta;
sort id year;
merge 1:1 id year using $JK18;

table _merge;


drop if _merge == 2;
drop _merge;



/** attrition indicator **/
gen attr=0;
replace attr=1 if v2==.;

label var attr "1: attrition";

sort id year;

cd "C:\Users\Kazuto Sumita\Dropbox\DATA\JK18\var";

save $temp_dat, replace;



/* 市区町村データの読み込み */
clear;
insheet using $JK18_city_dat;
sort id year;

label var pref_id "都道府県コード";
label var pref_name "都道府県名";
label var city_code "市区町村コード";
label var city_name "区市町村名";
label var saigai "災害救助法適応地域";

save JK18_city.dta, replace;



/*** 市区町村データの接続 ***/
clear;
use $temp_dat;
sort id year;
merge 1:1 id year using JK18_city.dta;

table _merge;
drop if _merge == 2;
drop _merge;

save $temp_dat, replace;



/*** 調査員データの読み込み ***/
clear;
insheet using "..\JHPSKHPS2017_investigators_20171030\jk_intvw_dat.csv";
sort id year;

/* j_interview_2009_2017_171121.xlsx */
/* k_interview_varlist_2005_2017_171119.xlsx */

label var intv2	"ＲＥＣﾅﾝﾊﾞｰ";
label var intv3	"パネル回数";
label var intv4	"性別";
label var intv5	"生年月日　年";
label var intv6	"生年月日　月";
label var intv7	"生年月日　日";
label var intv8	"最終訪問日時(月)";
label var intv9	"最終訪問日時(日)";
label var intv10	"最終訪問日時(時)";
label var intv11	"訪問１回目調査月";
label var intv12	"訪問１回目調査日";
label var intv13	"１回目訪問日時(時)";
label var intv14	"訪問２回目調査月";
label var intv15	"訪問２回目調査日";
label var intv16	"２回目訪問日時(時)";
label var intv17	"訪問３回目調査月";
label var intv18	"訪問３回目調査日";
label var intv19	"３回目訪問日時(時)";
label var intv20	"訪問４回目調査月";
label var intv21	"訪問４回目調査日";
label var intv22	"４回目訪問日時(時)";
label var intv23	"訪問５回目調査月";
label var intv24	"訪問５回目調査日";
label var intv25	"５回目訪問日時(時)";
label var intv26	"接触状況_01事前拒否";
label var intv27	"接触状況_02インターホン";
label var intv28	"接触状況_03会えなかった";
label var intv29	"接触状況_04その他の家族";
label var intv30	"接触状況_05配偶者に会えた";
label var intv31	"接触状況_06本人に会えた";
label var intv32	"回収状況";
label var intv33	"対象者の状況";
label var intv34	"付問　死亡時期死亡年";
label var intv35	"付問　死亡時期死亡月";
label var intv36	"付問　死亡時の配偶者の有無";
label var intv37	"配偶関係";
label var intv38	"配偶関係の変化";
label var intv39	"付問　配偶関係の変化1:結婚, 2:離別, 3:死別";
label var intv40	"協力状況";
label var intv41	"配偶者の記入状況";
label var intv42	"配偶者の協力状況";
label var intv43	"調査拒否対象者本人";
label var intv44	"調査拒否配偶者";
label var intv45	"調査拒否その他家族";
label var intv46	"調査拒否の理由健康状態が良くない";
label var intv47	"調査拒否の理由忙しい";
label var intv48	"調査拒否の理由調査項目が過多";
label var intv49	"調査拒否の理由アンケート一般に不信感";
label var intv50	"調査拒否の理由本調査に不信感";
label var intv51	"調査拒否の理由前回と調査項目が同じ";
label var intv52	"調査拒否の理由調査項目の内容が難しい";
label var intv53	"調査拒否の理由プライバシーに触れる項目がある";
label var intv54	"調査拒否の理由家族の事情";
label var intv55	"調査拒否の理由家族が反対するから";
label var intv56	"調査拒否の理由漠然とした理由";
label var intv57	"調査拒否の理由挨拶状やフィードバックがない";
label var intv58	"調査拒否の理由謝礼が少ない";
label var intv59	"調査拒否の理由その他";
label var intv60	"調査拒否の程度";
label var intv61	"対象者の障害程度";
label var intv62	"再協力の可能性";
label var intv63	"（欠票のみ）就業状況の変化";
label var intv64	"付問　退職後の職探し";
label var intv68	"訪問１回目接触状況対象者本人と話した";
label var intv69	"訪問１回目接触状況対象者の配偶者と話した";
label var intv70	"訪問１回目接触状況対象者の配偶者以外の家族等と話した";
label var intv71	"訪問１回目接触状況対象者宅の誰かと話したが、相手が誰だかわからなかった";
label var intv72	"訪問１回目接触状況対象者宅の誰とも話せなかった";
label var intv73	"訪問１回目接触状況留置調査票を渡した";
label var intv74	"訪問１回目接触状況留置調査票を回収した";
label var intv75	"訪問２回目接触状況対象者本人と話した";
label var intv76	"訪問２回目接触状況対象者の配偶者と話した";
label var intv77	"訪問２回目接触状況対象者の配偶者以外の家族等と話した";
label var intv78	"訪問２回目接触状況対象者宅の誰かと話したが、相手が誰だかわからなかった";
label var intv79	"訪問２回目接触状況対象者宅の誰とも話せなかった";
label var intv80	"訪問２回目接触状況留置調査票を渡した";
label var intv81	"訪問２回目接触状況留置調査票を回収した";
label var intv82	"訪問３回目接触状況対象者本人と話した";
label var intv83	"訪問３回目接触状況対象者の配偶者と話した";
label var intv84	"訪問３回目接触状況対象者の配偶者以外の家族等と話した";
label var intv85	"訪問３回目接触状況対象者宅の誰かと話したが、相手が誰だかわからなかった";
label var intv86	"訪問３回目接触状況対象者宅の誰とも話せなかった";
label var intv87	"訪問３回目接触状況留置調査票を渡した";
label var intv88	"訪問３回目接触状況留置調査票を回収した";
label var intv89	"訪問４回目接触状況対象者本人と話した";
label var intv90	"訪問４回目接触状況対象者の配偶者と話した";
label var intv91	"訪問４回目接触状況対象者の配偶者以外の家族等と話した";
label var intv92	"訪問４回目接触状況対象者宅の誰かと話したが、相手が誰だかわからなかった";
label var intv93	"訪問４回目接触状況対象者宅の誰とも話せなかった";
label var intv94	"訪問４回目接触状況留置調査票を渡した";
label var intv95	"訪問４回目接触状況留置調査票を回収した";
label var intv96	"訪問５回目接触状況対象者本人と話した";
label var intv97	"訪問５回目接触状況対象者の配偶者と話した";
label var intv98	"訪問５回目接触状況対象者の配偶者以外の家族等と話した";
label var intv99	"訪問５回目接触状況対象者宅の誰かと話したが、相手が誰だかわからなかった";
label var intv100	"訪問５回目接触状況対象者宅の誰とも話せなかった";
label var intv101	"訪問５回目接触状況留置調査票を渡した";
label var intv102	"訪問５回目接触状況留置調査票を回収した";
label var intv103	"訪問６回目調査月";
label var intv104	"訪問６回目調査日";
label var intv105	"訪問６回目接触状況対象者本人と話した";
label var intv106	"訪問６回目接触状況対象者の配偶者と話した";
label var intv107	"訪問６回目接触状況対象者の配偶者以外の家族等と話した";
label var intv108	"訪問６回目接触状況対象者宅の誰かと話したが、相手が誰だかわからなかった";
label var intv109	"訪問６回目接触状況対象者宅の誰とも話せなかった";
label var intv110	"訪問６回目接触状況留置調査票を渡した";
label var intv111	"訪問６回目接触状況留置調査票を回収した";
label var intv112	"訪問７回目調査月";
label var intv113	"訪問７回目調査日";
label var intv114	"訪問７回目接触状況対象者本人と話した";
label var intv115	"訪問７回目接触状況対象者の配偶者と話した";
label var intv116	"訪問７回目接触状況対象者の配偶者以外の家族等と話した";
label var intv117	"訪問７回目接触状況対象者宅の誰かと話したが、相手が誰だかわからなかった";
label var intv118	"訪問７回目接触状況対象者宅の誰とも話せなかった";
label var intv119	"訪問７回目接触状況留置調査票を渡した";
label var intv120	"訪問７回目接触状況留置調査票を回収した";
label var intv121	"訪問８回目調査月";
label var intv122	"訪問８回目調査日";
label var intv123	"訪問８回目接触状況対象者本人と話した";
label var intv124	"訪問８回目接触状況対象者の配偶者と話した";
label var intv125	"訪問８回目接触状況対象者の配偶者以外の家族等と話した";
label var intv126	"訪問８回目接触状況対象者宅の誰かと話したが、相手が誰だかわからなかった";
label var intv127	"訪問８回目接触状況対象者宅の誰とも話せなかった";
label var intv128	"訪問８回目接触状況留置調査票を渡した";
label var intv129	"訪問８回目接触状況留置調査票を回収した";
label var intv130	"訪問９回目調査月";
label var intv131	"訪問９回目調査日";
label var intv132	"訪問９回目接触状況対象者本人と話した";
label var intv133	"訪問９回目接触状況対象者の配偶者と話した";
label var intv134	"訪問９回目接触状況対象者の配偶者以外の家族等と話した";
label var intv135	"訪問９回目接触状況対象者宅の誰かと話したが、相手が誰だかわからなかった";
label var intv136	"訪問９回目接触状況対象者宅の誰とも話せなかった";
label var intv137	"訪問９回目接触状況留置調査票を渡した";
label var intv138	"訪問９回目接触状況留置調査票を回収した";
label var intv139	"訪問１０回目調査月";
label var intv140	"訪問１０回目調査日";
label var intv141	"訪問１０回目接触状況対象者本人と話した";
label var intv142	"訪問１０回目接触状況対象者の配偶者と話した";
label var intv143	"訪問１０回目接触状況対象者の配偶者以外の家族等と話した";
label var intv144	"訪問１０回目接触状況対象者宅の誰かと話したが、相手が誰だかわからなかった";
label var intv145	"訪問１０回目接触状況対象者宅の誰とも話せなかった";
label var intv146	"訪問１０回目接触状況留置調査票を渡した";
label var intv147	"訪問１０回目接触状況留置調査票を回収した";
label var intv148	"１０回以上訪問回数";
label var intv149	"3-付問 本人転居先（全員転居）";
label var intv150	"4-付問 本人転居先（配偶者残り）";
label var intv151	"調査実施対象(JHPS)";
label var intv152	"留置調査の方法(JHPS)";
label var intv153	"調査拒否の理由面接調査に応じられない(JHPS)";

/* 以下JHPS2009の調査票 現在読み込んでいない。
label var intv154	"正規予備別(JHPS)";
label var intv155	"正規対象番号１(JHPS)";
label var intv156	"正規対象番号２(JHPS)";
label var intv157	"予備対象(JHPS)";
label var intv158	"居住状況(JHPS)";
*/

label var intv159	"地域ブロック(JHPS)";
label var intv160	"市郡規模(JHPS)";
label var intv161	"配偶関係の変化結婚した(JHPS)";
label var intv162	"配偶関係の変化離別した(JHPS)";
label var intv163	"配偶関係の変化死別した(JHPS)";

sort id year;
save JK17_intvw.dta, replace;

/* 調査員データの接続 */
clear;
use $temp_dat;
sort id year;
merge 1:1 id year using JK17_intvw.dta;

table _merge;

* table year if _merge == 2;
drop if _merge == 2;
drop _merge;

save $temp_dat, replace;



/** v1 **/
clonevar v1 = id;

/* 
v1: 10001から14009 KHPS
v1: 15001-16419, 2007B
v1: 17001-18012, 2012C
v1: 20000以上, JHPS
*/


/* 固体認識 */
/* iis v1; */
/* 時間 */
/* tis y; */


/* sort */
sort v1 year;


/* 現住居居住形態不明(v1752=99 or 過去の居住形態不明(nv872a=99)は削除 */
/* drop if v1752==99|v2388==99; */

/* 観測値をcountするための変数 */
gen count=1;

/*** attr1: 磨耗した世帯を示すダミー変数 ***/
gen attr1 = attr;

/* t+1年調査で摩耗したt年調査世帯 */
forvalues Y= $ly(-1)2005 {;
	local X=`Y'-1;
	replace attr1 =1 if attr1[_n+1]==1 & year==`X' & v1[_n+1]==v1[_n] ;
};
label var attr1 "1:磨耗した世帯";


/*** 回答者が死亡し、配偶者が引き継いでいるサンプル ***/
gen v1_origin = v1;

/** KHPS **/

/*11655	→	14011	(第３回調査時に変更)		2006 */
drop if v1==11655 & attr==1;
replace v1=11655 if v1==14011 & year>=2006;

/* 10911	→	14012	(第３回調査時に変更)		2006 */
drop if v1==10911 & attr==1;
replace v1=10911 if v1==14012 & year>=2006;

/* 10159	→	14013	(第３回調査時に変更)		2006 */
drop if v1==10159 & attr==1;
replace v1=10159 if v1==14013 & year>=2006;

/* 10075	→	14014	(第４回調査時に変更)		2007 */
drop if v1==10075 & attr==1;
replace v1=10075 if v1==14014 & year>=2007;

/* 13478	→	14015	(第４回調査時に変更)		2007 */
drop if v1==13478 & attr==1;
replace v11=3478 if v1==14015 & year>=2007;

/* 13643	→	14016	(第４回調査時に変更)		2007 */
drop if v1==13643 & attr==1;
replace v1=13643 if v1==14016 & year>=2007;

/* 13534	→	14017	(第４回調査時に変更)		2007 */
drop if v1==13534 & attr==1;
replace v1=13534 if v1==14017 & year>=2007;

/* 12816	→	14020	(第５回調査時に変更)		2008 */
drop if v1==12816 & attr==1;
replace v1=12816 if v1==14020 & year>=2008;

/* 13437	→	14021	(第５回調査時に変更)		2008 */
drop if v1==13437 & attr==1;
replace v1=13437 if v1==14021 & year>=2008;

/* 16044	→	16420	(第５回調査時に変更)		2008 */
drop if v1==16044 & attr==1;
replace v1=16044 if v1==16420 & year>=2008;

/* 13051	→	14022	(第６回調査時に変更)		2009 */
drop if v1==13051 & attr==1;
replace v1=13051 if v1==14022 & year>=2009;

/* 16245	→	16421	(第６回調査時に変更)		2009 */
drop if v1==16245 & attr==1;
replace v1=16245 if v1==16421 & year>=2009;

/* 11537	→	14024	(第７回調査時に変更)		2010 */
drop if v1==1537 & attr==1;
replace v1=1537 if v1==14024 & year>=2010;

/* 13016	→	14025	(第７回調査時に変更)		2010 */
drop if v1==13016 & attr==1;
replace v11=3016 if v1==14025 & year>=2010;

/* 15771	→	16423	(第７回調査時に変更)		2010 */
drop if v1==15771 & attr==1;
replace v1=15771 if v1==16423 & year>=2010;

/* 16086	→	16424	(第７回調査時に変更)		2010 */
drop if v1==16086 & attr==1;
replace v1=16086 if v1==16424 & year>=2010;

/* 16091	→	16425	(第７回調査時に変更)		2010 */
drop if v1==16091 & attr==1;
replace v1=16091 if v1==16425 & year>=2010;

/* 11597	→	16426	(第８回調査時に変更)		2011 */
drop if v1==11597 & attr==1;
replace v1=11597 if v1==16426 & year>=2011;

/* 11369	→	16427	(第９回調査時に変更)		2012 */
drop if v1==11369 & attr==1;
replace v1=11369 if v1==16427 & year>=2012;

/* 11575	→	16428	(第９回調査時に変更)		2013 */
drop if v1==11575 & attr==1;
replace v1=11575 if v1==16428 & year>=2013;

/* 13597	→	16429	(第９回調査時に変更)		2013 */
drop if v1==13597 & attr==1;
replace v1=13597 if v1==16429 & year>=2013;

/* 10819	→	16440	(第11回調査時に変更)		2014 */
drop if v1==10819 & attr==1;
replace v1=10819 if v1==16440 & year>=2014;

/* 12772 → 16441 (第12回調査時に変更) 2015 */
drop if v1==12772 & attr==1;
replace v1=12772 if v1==16441 & year>=2015;


/* 1３２０３→1６４４２(第12回調査時に変更) 2015 */
drop if v1==13203 & attr==1;
replace v1=13203 if v1==16442 & year >=2015;

/* １２５７５→１６４４３(第13回調査時に変更)2016 */
drop if v1==12575 & attr==1;
replace v1=12575 if v1==16443 & year >=2016;

/* １２９４４→１６４４４(第13回調査時に変更)2016 */
drop if v1==12944 & attr==1;
replace v1=12944 if v1==16444 & year >=2016;

/* １５０７２→１６４４６(第13回調査時に変更)2016 */
drop if v1==15072 & attr==1;
replace v1=15072 if v1==15072 & year >=2016;

/* １６１９８→１６４４７(第14回調査時に変更)2017 */
drop if v1==16198 & attr==1;
replace v1=16198 if v1==16447 & year >=2017;

/* １５２５８→１６４４８(第15回調査時に変更) */
drop if v1==15258 & attr==1;
replace v1=15258 if v1==16448 & year >=2018;

/* １０７６３→１６４４９(第15回調査時に変更) */
drop if v1==10763 & attr==1;
replace v1=10763 if v1==16449 & year >=2018;

/* １１２２１→１６４５０(第15回調査時に変更) */
drop if v1==11221 & attr==1;
replace v1=11221 if v1==16450 & year >=2018;

/* １５７９７→１６４５１(第15回調査時に変更) */
drop if v1==15797 & attr==1;
replace v1=15797 if v1==16451 & year >=2018;

/* １７６９８→１８０１３(第15回調査時に変更) */
drop if v1==17697 & attr==1;
replace v1=17697 if v1==18013 & year >=2018;



/* JHPS */
/* JHPSは20000代であることを反映させる */

/* 22513	→	25544	(第２回調査時に変更)	2010 */
drop if v1==22513 & attr==1;
replace v1=22513 if v1==25544 & year>=2010;

/* 23117	→	25545	(第２回調査時に変更)	2010 */
drop if v1==23117 & attr==1;
replace v1=23117 if v1==25545 & year>=2010;
 
/* 21337	→	25546	(第３回調査時に変更)	2011 */
drop if v1==21337 & attr==1;
replace v1=21337 if v1==25546 & year>=2011;

/* 21118	→	24550	(第４回調査時に変更)	2012 */
drop if v1==21118 & attr==1;
replace v1=21118 if v1==24550 & year>=2012;

/* 2３０６２→2３４１８(第５回調査時に変更) 2014 */
drop if v1== 23062 & attr==1;
replace v1= 23062 if v1==23418 & year>=2014;

/* 2３１１６→2３４１９(第５回調査時に変更) 2014 */
drop if v1== 23419 & attr==1;
replace v1= 23116 if v1==23419 & year>=2014;

/* 2２４９１→2５６００(第６回調査時に変更) 2015 */
drop if v1== 22491 & attr==1;
replace v1= 22491 if v1==25600 & year>=2015;



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
	replace v`i'_chck = 3 if v`i'==2 & v`i'_chck==0 & year<2016;
	replace v`i' = 3 if v`i'_chck==3;

	/* 孫: 3-> 4 */
	replace v`i'_chck = 4 if v`i'==3 & v`i'_chck==0 & year<2016;
	replace v`i' = 4 if v`i'_chck==4;

	/* 父母: 4-> 5 */
	replace v`i'_chck = 5 if v`i'==4 & v`i'_chck==0 & year<2016;
	replace v`i' = 5 if v`i'_chck==5;

	/* 祖父母: 5 -> 7 */
	replace v`i'_chck = 7 if v`i'==5 & v`i'_chck==0 & year<2016;
	replace v`i' = 7 if  v`i'_chck==7;

	/* 兄弟姉妹: 6->9 */
	replace v`i'_chck = 9 if v`i'==6 & v`i'_chck==0 & year<2016;
	replace v`i' = 9 if v`i'_chck==9;

	/* その他の親族: 7 -> 11 */
	replace v`i'_chck = 11 if v`i'==7 & v`i'_chck==0 & year<2016;
	replace v`i' = 11 if v`i'_chck==11;

	/* その他: 8 -> 12 */
	replace v`i'_chck = 12 if v`i'==8 & v`i'_chck==0 & year<2016;
	replace v`i' = 12 if v`i'_chck==12;
};

/* チェック変数の削除 */
forvalues i=13(7)69 {;
	drop v`i'_chck;
};


save $temp_dat, replace;



/**** 家族表 ****/

/*** 両親関連 ***/
do parent_v4_181209.do; 

save $temp_dat, replace;



/*** 配偶者の両親関連 ***/
do parentsp_v4_181210.do; 

save $temp_dat, replace;


/*** 子供関連 ***/

/* 子供の有無 4人目まで */
do kid_v4_181210.do;

save $temp_dat, replace;

log close;
exit;


/*** 子供の配偶者関連 ***/
do yome_v2_171210.do;

/* 子どもの配偶者データの接続 */
clear;
use $temp_dat;
sort id year;
merge 1:1 id year using kidsp_data.dta;

table _merge;

* table year if _merge == 2;
drop if _merge == 2;
drop _merge;

save $temp_dat, replace;


/*** 孫関連 ***/
/* 世帯外の子供の子は補足できないので、不正確な変数となる */
* clear;
* use JK17.dta;
do mago_v2_171211.do; 

/* 孫データの接続 */
clear;
use $temp_dat;
sort id year;
merge 1:1 id year using mago_data.dta;

table _merge;

* table year if _merge == 2;
drop if _merge == 2;
drop _merge;

save $temp_dat, replace;

compress;

sort v1 year;
aorder;

save $output_data, replace;


exit;


