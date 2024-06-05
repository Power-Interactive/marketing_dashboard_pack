--新規作成テーブル
CREATE OR REPLACE TABLE
  `pi-dev-dashboard.master.ActivityCategory`
AS
--データ参照元
SELECT
  *
FROM
  `pi-dev-dashboard.master.ActivityCategory_ss`
;

--新規作成テーブル
CREATE OR REPLACE TABLE
  `pi-dev-dashboard.master.ChannelKPI`
AS
--データ参照元
SELECT
  *
FROM
  `pi-dev-dashboard.master.ChannelKPI_ss`
;

--新規作成テーブル
CREATE OR REPLACE TABLE
  `pi-dev-dashboard.master.MarketingROI`
AS
--データ参照元
SELECT
  *
FROM
  `pi-dev-dashboard.master.MarketingROI_ss`
;

--新規作成テーブル
CREATE OR REPLACE TABLE
  `pi-dev-dashboard.master.SalesTarget_Team_Type`
AS
--データ参照元
SELECT
  *
FROM
  `pi-dev-dashboard.master.SalesTarget_Team_Type_ss`
;

--新規作成テーブル
CREATE OR REPLACE TABLE
  `pi-dev-dashboard.master.SalesTarget_User`
AS
--データ参照元
SELECT
  *
FROM
  `pi-dev-dashboard.master.SalesTarget_User_ss`
;
