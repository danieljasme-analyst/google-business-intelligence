-- Google Fiber Course 2 End-of-Course Project
-- BI Analyst: Ahmad Daniel
-- Purpose: Combine all three market datasets into a single target table
--          using UNION ALL (tables have identical columns, no JOIN needed)

CREATE OR REPLACE TABLE `google-fiber-bi.google_fiber.target_table` AS

SELECT
  date_created,
  contacts_n,
  contacts_n_1,
  contacts_n_2,
  contacts_n_3,
  contacts_n_4,
  contacts_n_5,
  contacts_n_6,
  contacts_n_7,
  new_type,
  new_market
FROM `google-fiber-bi.google_fiber.market_1`

UNION ALL

SELECT
  date_created,
  contacts_n,
  contacts_n_1,
  contacts_n_2,
  contacts_n_3,
  contacts_n_4,
  contacts_n_5,
  contacts_n_6,
  contacts_n_7,
  new_type,
  new_market
FROM `google-fiber-bi.google_fiber.market_2`

UNION ALL

SELECT
  date_created,
  contacts_n,
  contacts_n_1,
  contacts_n_2,
  contacts_n_3,
  contacts_n_4,
  contacts_n_5,
  contacts_n_6,
  contacts_n_7,
  new_type,
  new_market
FROM `google-fiber-bi.google_fiber.market_3`;

-- After running, verify with:
-- SELECT COUNT(*) FROM `google-fiber-bi.google_fiber.target_table`
-- Expected result: 1,350 rows
