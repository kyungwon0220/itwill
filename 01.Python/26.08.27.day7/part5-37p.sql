-- CREATE TABLE if not exists student(
--     id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
--     name TEXT NOT NULL,
--     age INTEGER NOT NULL,
--     addr TEXT DEFAULT "서울" NOT NULL);

-- INSERT INTO student(name, age, addr) VALUES("김영희", 23, "대구");
-- INSERT INTO student(name, age) VALUES("고길동",299);

-- UPDATE student SET addr = "제주" WHERE name = "김영희";
-- update student set age = 29 WHERE age = 299;

-- delete from student where name = "고길동";

select * from student;
