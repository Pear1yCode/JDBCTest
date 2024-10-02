-- CREATE DATABASE monsterdb;

USE monsterdb;

-- 스크립트의 테이블 초기화용

#DROP TABLE IF EXISTS RISK;
#DROP TABLE IF EXISTS SIZE;
#DROP TABLE IF EXISTS MONSTER;
#DROP TABLE IF EXISTS MOON;
#DROP TABLE IF EXISTS PERMONSTER;
#DROP TABLE IF EXISTS LANDING;
#DROP TABLE IF EXISTS INTERIOR;
#DROP TABLE IF EXISTS SPAWN;

-- 테이블 생성 (팁 : 만약 외래키로 참조될 경우 더 위에있어야 먼저 실행되고 아래의 코드에서 받아서 실행하기 때문에 위치 조절이 필수

CREATE TABLE IF NOT EXISTS RISK
(
	RISK_RANK CHAR(1) COMMENT '위험도아이디',
    RISK_NAME VARCHAR(30) COMMENT '위험단계',
    PRIMARY KEY (RISK_RANK),
    CHECK (RISK_RANK IN('S', 'A', 'B', 'C', 'D', 'F')),
    CHECK (RISK_NAME IN('매우높음', '높음', '중간', '낮음', '매우낮음', '안전'))
) ENGINE=INNODB COMMENT '위험도';

CREATE TABLE IF NOT EXISTS SIZE
(
	SIZE_ID VARCHAR(5) COMMENT '크기 아이디',
    MONSTER_SIZE VARCHAR(30) NOT NULL COMMENT '생명체 크기',
    PRIMARY KEY (SIZE_ID),
    CHECK (SIZE_ID IN('G', 'B', 'N', 'S', 'T')),
    CHECK (MONSTER_SIZE IN('거대', '큼', '보통', '작음', '매우작음'))
)ENGINE=INNODB COMMENT '크기';

CREATE TABLE IF NOT EXISTS SPAWN
(
	SPAWN_ID CHAR(2) COMMENT '생성아이디',
    SPAWN_LOCATION VARCHAR(10) COMMENT '생성위치',
    PRIMARY KEY (SPAWN_ID),
    CHECK (SPAWN_ID IN('I', 'O', 'IO')),
    CHECK (SPAWN_LOCATION IN('내부', '외부', '내외부'))
)ENGINE=INNODB COMMENT '생성';

CREATE TABLE IF NOT EXISTS INTERIOR
(
	INTERIOR_ID VARCHAR(5) COMMENT '내부유형 구분 아이디',
    INTERIOR_NAME VARCHAR(10) NOT NULL COMMENT '내부유형 이름',
    PRIMARY KEY (INTERIOR_ID),
    CHECK (INTERIOR_ID IN('F', 'H', 'M', 'FH', 'FM', 'HM', 'FHM')),
    CHECK (INTERIOR_NAME IN('공장', '저택', '광산', '공장, 저택', '공장, 광산', '저택, 광산', '공장, 저택, 광산'))
)ENGINE=INNODB COMMENT '내부유형';

CREATE TABLE IF NOT EXISTS MONSTER
(
	MONSTER_CODE VARCHAR(5) COMMENT '생명체코드',
    MONSTER_NAME VARCHAR(35) NOT NULL COMMENT '생명체이름',
    MONSTER_ORGANIC CHAR(1) NOT NULL COMMENT '생명체여부',
    MONSTER_KILL CHAR(1) CHECK (MONSTER_KILL IN('Y', 'N')) COMMENT '살상가능여부',
    MONSTER_POWER INT COMMENT '공격력',
    MONSTER_SPEED VARCHAR(6) COMMENT '속도',
    MONSTER_INTELLIGENCE CHAR(1) NOT NULL COMMENT '개폐가능여부',
    SPAWN_NUMBER INT COMMENT '생성가능수량',
    SIZE_ID VARCHAR(5),
    RISK_RANK CHAR(1),
    SPAWN_ID CHAR(2),
    INTERIOR_ID VARCHAR(5),
    FOREIGN KEY (SIZE_ID) REFERENCES SIZE (SIZE_ID),
	FOREIGN KEY (RISK_RANK) REFERENCES RISK (RISK_RANK),
    FOREIGN KEY (SPAWN_ID) REFERENCES SPAWN (SPAWN_ID),
    FOREIGN KEY (INTERIOR_ID) REFERENCES INTERIOR (INTERIOR_ID),
    PRIMARY KEY (MONSTER_CODE),
    CHECK (MONSTER_ORGANIC IN('Y', 'N')),
    CHECK(MONSTER_SPEED IN('없음', '느림', '보통', '빠름')),
    CHECK (MONSTER_INTELLIGENCE IN('Y', 'N'))
) ENGINE=INNODB COMMENT '생명체';

CREATE TABLE IF NOT EXISTS MOON
(
	MOON_CODE VARCHAR(5) COMMENT '행성코드',
    MOON_NAME VARCHAR(35) NOT NULL COMMENT '행성이름',
    RISK_RANK CHAR(1),
    FOREIGN KEY(RISK_RANK) REFERENCES RISK (RISK_RANK),
    PRIMARY KEY (MOON_CODE)
) ENGINE=INNODB COMMENT '행성';

CREATE TABLE IF NOT EXISTS PERMONSTER
(
	MONSTER_CODE VARCHAR(5),
    MOON_CODE VARCHAR(5),
	FOREIGN KEY (MONSTER_CODE) REFERENCES MONSTER (MONSTER_CODE),
    FOREIGN KEY (MOON_CODE) REFERENCES MOON (MOON_CODE),
    PRIMARY KEY (MONSTER_CODE, MOON_CODE)
)ENGINE=INNODB COMMENT '행성당 생명체';

-- CREATE TABLE IF NOT EXISTS LANDING
-- (
-- 	INTERIOR_ID CHAR(1),
--     MONSTER_CODE VARCHAR(4),
--     MOON_CODE VARCHAR(4),
-- 	FOREIGN KEY (INTERIOR_ID) REFERENCES INTERIOR (INTERIOR_ID),
-- 	FOREIGN KEY (MONSTER_CODE) REFERENCES MONSTER (MONSTER_CODE),
-- 	FOREIGN KEY (MOON_CODE) REFERENCES MOON (MOON_CODE)
-- )ENGINE=INNODB COMMENT '착륙';

-- RISK 데이터 삽입
INSERT INTO RISK VALUES('S', '매우높음');
INSERT INTO RISK VALUES('A', '높음');
INSERT INTO RISK VALUES('B', '중간');
INSERT INTO RISK VALUES('C', '낮음');
INSERT INTO RISK VALUES('D', '매우낮음');
INSERT INTO RISK VALUES('F', '안전');

-- SIZE 데이터 삽입
INSERT INTO SIZE VALUES('G', '거대');
INSERT INTO SIZE VALUES('B', '큼');
INSERT INTO SIZE VALUES('N', '보통');
INSERT INTO SIZE VALUES('S', '작음');
INSERT INTO SIZE VALUES('T', '매우작음');

-- SPAWN 데이터 삽입
INSERT INTO SPAWN VALUES('I', '내부');
INSERT INTO SPAWN VALUES('O', '외부');
INSERT INTO SPAWN VALUES('IO', '내외부');

-- INTERIOR 데이터 삽입
INSERT INTO INTERIOR VALUES ('F', '공장');
INSERT INTO INTERIOR VALUES ('H', '저택');
INSERT INTO INTERIOR VALUES ('M', '광산');
INSERT INTO INTERIOR VALUES ('FH', '공장, 저택');
INSERT INTO INTERIOR VALUES ('FM', '공장, 광산');
INSERT INTO INTERIOR VALUES ('HM', '저택, 광산');
INSERT INTO INTERIOR VALUES ('FHM', '공장, 저택, 광산');

-- MOON 데이터 삽입
INSERT INTO MOON VALUES ('#E001','Experimentation', 'D');
INSERT INTO MOON VALUES ('#A001', 'Assurance', 'C');
INSERT INTO MOON VALUES ('#V001', 'Vow', 'C');
INSERT INTO MOON VALUES ('#O001', 'Offense', 'C');
INSERT INTO MOON VALUES ('#M001', 'March', 'B');
INSERT INTO MOON VALUES ('#R001', 'Rend', 'A');
INSERT INTO MOON VALUES ('#D001', 'Dine', 'A');
INSERT INTO MOON VALUES ('#T001', 'Titan', 'S');
INSERT INTO MOON VALUES ('#A002', 'Adamance', 'C');
INSERT INTO MOON VALUES ('#E002', 'Embrion', 'A');
INSERT INTO MOON VALUES ('#A003', 'Artifice', 'S');
INSERT INTO MOON VALUES ('#L001', 'Liquidation', 'S');

-- MONSTER 데이터 삽입
INSERT INTO MONSTER VALUES ('#CI01','Circuit Bees','Y','N', 25,'빠름','N', 6, 'T', 'A', 'O', 'FHM');	-- FOREIGN KEY는 NULL로 집어넣어야 함
INSERT INTO MONSTER VALUES ('#MA01','Manticoil','Y','Y', null,'빠름','N', 16, 'T', 'F', 'O', 'FHM'); -- cannot add or update 와 foreign키의 문제가 있다는 오류는 먼저 데이터 값을 넣지 않는 문제도 있지만 테이블 생성 시 varchar나 char의 데이터 값을 똑같이 두지 않는 문제도 동일하다.
INSERT INTO MONSTER VALUES ('#RO01','Roaming Locust','Y','N', null,'빠름','N', null, 'T', 'F', 'O', 'FHM');
INSERT INTO MONSTER VALUES ('#TU01','Tulip Snake','Y','Y', null,'빠름','N', 12, 'T', 'D', 'O', 'FHM');
INSERT INTO MONSTER VALUES ('#EY01','Eyeless Dog','Y','Y', 100,'빠름','N', 8, 'G', 'A', 'O', 'FHM');
INSERT INTO MONSTER VALUES ('#FO01','Forest Keeper','Y','Y', 100, '빠름', 'Y', 3, 'G', 'S', 'O', 'FHM');
INSERT INTO MONSTER VALUES ('#EA01','Earth Leviathan','Y','N', 100,'빠름','Y', 3, 'G', 'S', 'O', 'FHM');
INSERT INTO MONSTER VALUES ('#BA01','Baboon Hawk','Y','Y', 20,'보통','Y', 15, 'N', 'B', 'O', 'FHM');
INSERT INTO MONSTER VALUES ('#OL01','Old Bird','Y','Y', 30,'보통','Y', 20, 'G', 'A', 'O', 'FHM');
INSERT INTO MONSTER VALUES ('#KI01','Kidnapper Fox','Y','Y', 100,'느림','N', 1, 'N', 'A', 'O', 'FHM');
INSERT INTO MONSTER VALUES ('#FL01','Flower Man','Y','Y', 100,'느림','Y', 1, 'B', 'A', 'I', 'FHM');
INSERT INTO MONSTER VALUES ('#HO01','Hoarding Bug','Y','Y', 10,'보통','Y', 8, 'S', 'C', 'I', 'FHM');
INSERT INTO MONSTER VALUES ('#SN01','Snare Flea','Y','Y', 75,'보통','Y', 5, 'S', 'A', 'I', 'FHM');
INSERT INTO MONSTER VALUES ('#CO01','Coil Head','Y','N', 90,'빠름','Y', 5, 'B', 'S', 'I', 'FHM');
INSERT INTO MONSTER VALUES ('#TH01','Thumper','Y','Y', 40,'빠름','Y', 4, 'B', 'S', 'I', 'FHM');
INSERT INTO MONSTER VALUES ('#BU01','Bunker Spider','Y','Y', 90,'느림','Y', 1, 'B', 'C', 'I', 'FHM');
INSERT INTO MONSTER VALUES ('#JE01','Jester','Y','N', 100,'빠름','Y', 1, 'N', 'S', 'I', 'FHM');
INSERT INTO MONSTER VALUES ('#HY01','Hygrodere','Y','N', 35,'느림','N', 2, 'N', 'C', 'I', 'FHM');
INSERT INTO MONSTER VALUES ('#SP01','Spore Lizard','Y','N', 20, '보통','Y', 2, 'B', 'D', 'I', 'FHM');
INSERT INTO MONSTER VALUES ('#NU01','Nutcracker','Y','Y', 100, '보통','Y', 10, 'B', 'A', 'I', 'FHM');
INSERT INTO MONSTER VALUES ('#BU02','Butler','Y','Y', 10, '보통','Y', 7, 'B', 'S', 'I', 'H');
INSERT INTO MONSTER VALUES ('#MA02','Mask Hornets','Y','Y', 10,'빠름','Y', 7, 'T', 'A', 'I', 'H');
INSERT INTO MONSTER VALUES ('#BA02','Barber','Y','N', 100, '보통','N', 1, 'B', 'S', 'I', 'FHM');
INSERT INTO MONSTER VALUES ('#MA03','Maneater','Y','Y', 100, '빠름','Y', 1, 'B', 'S', 'I', 'FHM');
INSERT INTO MONSTER VALUES ('#GH01','Ghost Gril','Y','N', 100, '빠름','Y', 1, 'S', 'S', 'IO', 'FHM');
INSERT INTO MONSTER VALUES ('#MA04','Masked','Y','Y', 100, '빠름','Y', 10, 'N', 'A', 'IO', 'FHM');
INSERT INTO MONSTER VALUES ('#RE01','REDPILL','Y','N', 100, '빠름','N', null, 'B', 'A', 'I', 'FHM');
INSERT INTO MONSTER VALUES ('#LA03','Lasso Man','Y','N', null,'느림','Y', 2, null, null, 'I', 'FHM');
INSERT INTO MONSTER VALUES ('#VA01','Valve','N','N', null, null,'N', null, null, null, 'I', 'FHM');
INSERT INTO MONSTER VALUES ('#MI01','Mine','N','N', null, null,'N', null, null, null, 'I', 'FHM');
INSERT INTO MONSTER VALUES ('#TU02','Turret','N','N', 50, null,'N', null, null, null, 'I', 'FHM');
INSERT INTO MONSTER VALUES ('#SP02','SpikeTrap','N','N', 100, null,'N', null, null, null, 'I', 'FHM');

COMMIT;

