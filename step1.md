# テーブル設計

テーブル：categories

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
| ---- | ---- | ---- | ---- | ---- | ---- |
|id|int(3)||PRIMARY||YES|
|name|varchar(50)|||||

テーブル：programs

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
| ---- | ---- | ---- | ---- | ---- | ---- |
|id|bigint(20)||PRIMARY||YES|
|title|varchar(100)|||||
|detail|varchar(255)|||||
|has_season|boolean|||||

テーブル：program_category

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
| ---- | ---- | ---- | ---- | ---- | ---- |
|program_id|bigint(20)||PRIMARY|||
|category_id|int(3)||PRIMARY|||

- 外部キー制約：
  - program_id に対して、programs テーブルの id カラムから設定
  - category_id に対して、categories テーブルの id カラムから設定

テーブル：seasons

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
| ---- | ---- | ---- | ---- | ---- | ---- |
|id|bigint(20)||PRIMARY||YES|
|program_id|bigint(20)|||||
|season_num|int(3)|||0||

- 外部キー制約：program_id に対して、programs テーブルの id カラムから設定
- 複合ユニークキー制約：program_id と season_num に対して設定

テーブル：episodes

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
| ---- | ---- | ---- | ---- | ---- | ---- |
|id|bigint(20)||PRIMARY||YES|
|season_id|bigint(20)|||||
|episode_num|int(3)|||0||
|title|varchar(100)|||||
|detail|varchar(255)|||||
|video_time|int(6)|||||
|release_date|date|||||

- 外部キー制約：season_id に対して、seasons テーブルの id カラムから設定
- 複合ユニークキー制約：season_id と episode_num に対して設定

テーブル：channels

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
| ---- | ---- | ---- | ---- | ---- | ---- |
|id|int(3)||PRIMARY||YES|
|name|varchar(50)|||||

テーブル：channel_time_slot

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
| ---- | ---- | ---- | ---- | ---- | ---- |
|id|bigint(20)||PRIMARY||YES|
|channel_id|int(3)|||||
|episode_id|bigint(20)|||||
|starting_time|datetime||INDEX|||
|end_time|datetime|||||

- 複合主キー制約：channel_id と starting_time に対して設定
- 外部キー制約：
  - channel_id に対して、channels テーブルの id カラムから設定
  - episode_id に対して、episodes テーブルの id カラムから設定

テーブル：channel_time_slot_views

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
| ---- | ---- | ---- | ---- | ---- | ---- |
|channel_time_slot_id|bigint(20)||PRIMARY||YES|
|view_num|bigint(20)|||||

- 外部キー制約：channel_time_slot_id に対して、channel_time_slot テーブルの id カラムから設定
