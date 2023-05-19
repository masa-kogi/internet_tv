use internet_tv;

CREATE TABLE categories (
  id INT(3) PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE programs (
  id BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  detail VARCHAR(255) NOT NULL,
  has_season BOOLEAN NOT NULL
);

CREATE TABLE program_category (
  program_id BIGINT(20),
  category_id INT(3),
  PRIMARY KEY (program_id, category_id),
  FOREIGN KEY (program_id) REFERENCES programs (id),
  FOREIGN KEY (category_id) REFERENCES categories (id)
);

CREATE TABLE seasons (
  id BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  program_id BIGINT(20),
  season_num INT(3) NOT NULL DEFAULT 0,
  FOREIGN KEY (program_id) REFERENCES programs (id),
  UNIQUE (program_id, season_num)
);

CREATE TABLE episodes (
  id BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  season_id BIGINT(20),
  episode_num INT(3) NOT NULL DEFAULT 1,
  title VARCHAR(100) NOT NULL,
  detail VARCHAR(255) NOT NULL,
  video_time INT(6) NOT NULL,
  release_date DATE NOT NULL,
  FOREIGN KEY (season_id) REFERENCES seasons (id),
  UNIQUE (season_id, episode_num)
);

CREATE TABLE channels (
  id INT(3) PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE channel_time_slot (
  id BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
  channel_id INT(3),
  episode_id BIGINT(20),
  starting_time DATETIME NOT NULL,
  end_time DATETIME NOT NULL,
  FOREIGN KEY (channel_id) REFERENCES channels (id),
  FOREIGN KEY (episode_id) REFERENCES episodes (id),
  UNIQUE (channel_id, starting_time),
  INDEX starting_time_index (starting_time)

);

CREATE TABLE channel_time_slot_views (
  channel_time_slot_id BIGINT(20),
  view_num BIGINT(20) NOT NULL,
  FOREIGN KEY (channel_time_slot_id) REFERENCES channel_time_slot (id)
);
