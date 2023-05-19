LOAD DATA INFILE '/var/lib/mysql-files/data/categories.csv' INTO TABLE internet_tv.categories FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE '/var/lib/mysql-files/data/programs.csv' INTO TABLE internet_tv.programs FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE '/var/lib/mysql-files/data/program_category.csv' INTO TABLE internet_tv.program_category FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE '/var/lib/mysql-files/data/seasons.csv' INTO TABLE internet_tv.seasons FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE '/var/lib/mysql-files/data/episodes.csv' INTO TABLE internet_tv.episodes FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE '/var/lib/mysql-files/data/channels.csv' INTO TABLE internet_tv.channels FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE '/var/lib/mysql-files/data/channel_time_slot.csv' INTO TABLE internet_tv.channel_time_slot FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE '/var/lib/mysql-files/data/channel_time_slot_views.csv' INTO TABLE internet_tv.channel_time_slot_views FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;
