1. よく見られているエピソードを知りたいです。エピソード視聴数トップ3のエピソードタイトルと視聴数を取得してください
```
SELECT
  ep.title AS episode_title,
  SUM(ctsv.view_num) AS total_views
FROM
  episodes AS ep
  INNER JOIN channel_time_slot AS cts
    ON ep.id = cts.episode_id
  INNER JOIN channel_time_slot_views AS ctsv
    ON cts.id = ctsv.channel_time_slot_id
GROUP BY
  ep.id
ORDER BY
  SUM(ctsv.view_num) DESC
LIMIT
  3
;
```

2. よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得してください
```
SELECT
  pg.title AS program_title,
  s.season_num,
  ep.episode_num,
  ep.title AS episode_title,
  SUM(ctsv.view_num) AS total_views
FROM
  episodes AS ep
  INNER JOIN channel_time_slot AS cts
    ON ep.id = cts.episode_id
  INNER JOIN channel_time_slot_views AS ctsv
    ON cts.id = ctsv.channel_time_slot_id
  INNER JOIN seasons AS s
    ON ep.season_id = s.id
  INNER JOIN programs AS pg
    ON s.program_id = pg.id
GROUP BY
  ep.id
ORDER BY
  SUM(ctsv.view_num) DESC
LIMIT
  3
;
```

3. 本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたいです。本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得してください。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします
```
SELECT
  ch.name AS channel_name,
  cts.starting_time,
  cts.end_time,
  s.season_num,
  ep.episode_num,
  ep.title AS episode_title,
  ep.detail AS episode_detail
FROM
  channel_time_slot AS cts
  INNER JOIN channels AS ch
    ON cts.channel_id = ch.id
  INNER JOIN episodes AS ep
    ON cts.episode_id = ep.id
  INNER JOIN seasons AS s
    ON ep.season_id = s.id
WHERE
  DATE(cts.starting_time) = CURDATE()
;
```

4. ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得してください
```
-- 次のクエリは、"ドラマ1"チャンネルのデータを取得するものです
SELECT
  cts.starting_time,
  cts.end_time,
  s.season_num,
  ep.episode_num,
  ep.title AS episode_title,
  ep.detail AS episode_detail
FROM
  channel_time_slot AS cts
  INNER JOIN channels AS ch
    ON cts.channel_id = ch.id
  INNER JOIN episodes AS ep
    ON cts.episode_id = ep.id
  INNER JOIN seasons AS s
    ON ep.season_id = s.id
WHERE
  ch.name = "ドラマ1"
  AND cts.starting_time >= CURDATE()
  AND cts.starting_time < CURDATE() + INTERVAL 1 WEEK + INTERVAL 1 DAY
;
```

5. (advanced) 直近一週間で最も見られた番組が知りたいです。直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得してください
```
SELECT
  pg.title AS program_title,
  SUM(ctsv.view_num) AS total_views
FROM
  episodes AS ep
  INNER JOIN channel_time_slot AS cts
    ON ep.id = cts.episode_id
  INNER JOIN channel_time_slot_views AS ctsv
    ON cts.id = ctsv.channel_time_slot_id
  INNER JOIN seasons AS s
    ON ep.season_id = s.id
  INNER JOIN programs AS pg
    ON s.program_id = pg.id
WHERE
  cts.starting_time >= CURDATE() - INTERVAL 1 WEEK
  AND cts.starting_time < CURDATE() + INTERVAL 1 DAY
GROUP BY
  pg.id
ORDER BY
  SUM(ctsv.view_num) DESC
LIMIT
  2
;
```
6. (advanced) ジャンルごとの番組の視聴数ランキングを知りたいです。番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得してください。
```
-- エピソード毎の総視聴数を持つ一時テーブル
WITH episode_views AS (
  SELECT
    cts.episode_id,
    SUM(ctsv.view_num) AS total_episode_views
  FROM
    channel_time_slot AS cts
  INNER JOIN
    channel_time_slot_views AS ctsv
      ON cts.id = ctsv.channel_time_slot_id
  GROUP BY
    cts.episode_id
),
-- 番組毎の平均視聴数を持つ一時テーブル
program_views AS (
  SELECT
    s.program_id,
    AVG(ev.total_episode_views) AS average_program_views
  FROM
    episode_views AS ev
    INNER JOIN episodes AS ep
      ON ev.episode_id = ep.id
    INNER JOIN seasons AS s
      ON ep.season_id = s.id
  GROUP BY
    s.program_id
),
-- カテゴリー毎の番組の最大平均視聴数を持つ一時テーブル
category_views AS (
  SELECT
    pc.category_id,
    MAX(pv.average_program_views) AS max_category_views
  FROM
    program_views AS pv
  INNER JOIN program_category AS pc
    ON pv.program_id = pc.program_id
  GROUP BY
    pc.category_id
)

SELECT
  cat.name AS category_name,
  pg.title AS program_title,
  ROUND(cv.max_category_views) AS average_views
FROM
  category_views AS cv
  INNER JOIN categories AS cat
    ON cv.category_id = cat.id
  INNER JOIN program_views AS pv
    ON cv.max_category_views = pv.average_program_views
  INNER JOIN programs AS pg
    ON pv.program_id = pg.id
;
```
