select fact.cal_dt, sum(fact.price) as sum_price, count(1) as cnt_1
from test_kylin_fact fact 
 left JOIN edw.test_cal_dt as test_cal_dt
 ON fact.cal_dt = test_cal_dt.cal_dt
 left JOIN test_category_groupings
 ON fact.leaf_categ_id = test_category_groupings.leaf_categ_id AND fact.lstg_site_id = test_category_groupings.site_id
 left JOIN edw.test_sites as test_sites
 ON fact.lstg_site_id = test_sites.site_id
inner join
(
	select test_kylin_fact.cal_dt, max(test_kylin_fact.cal_dt) as mmm from test_kylin_fact  left JOIN edw.test_cal_dt as test_cal_dt
 ON test_kylin_fact.cal_dt = test_cal_dt.cal_dt
 left JOIN test_category_groupings
 ON test_kylin_fact.leaf_categ_id = test_category_groupings.leaf_categ_id AND test_kylin_fact.lstg_site_id = test_category_groupings.site_id
 left JOIN edw.test_sites as test_sites
 ON test_kylin_fact.lstg_site_id = test_sites.site_id group by test_kylin_fact.cal_dt order by 2 desc limit 7
) cal_2 on fact.cal_dt = cal_2.mmm
group by fact.cal_dt