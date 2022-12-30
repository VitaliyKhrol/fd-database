
CREATE TABLE student (
    first_name varchar (256) NOT NULL CHECK (first_name !=''),
    last_name varchar (256) NOT NULL CHECK (last_name !=''),
    student_id integer NOT NULL,
    group_number int REFERENCES groups(id),
    PRIMARY KEY (student_id)
);


CREATE TABLE groups(
    id serial PRIMARY KEY,
    name_group varchar (256) NOT NULL CHECK (name_group !=''),
    faculty_id int REFERENCES faculty(id)
);


DROP TABLE faculty;

CREATE TABLE faculty (
    id serial PRIMARY KEY,
    name_faculty varchar (200) NOT NULL UNIQUE CHECK (name_faculty !='')
);

CREATE TABLE discipline(
    id serial PRIMARY KEY,
    name_discipline varchar (256) NOT NULL CHECK (name_discipline !=''),
    name_teacher varchar (256) NOT NULL CHECK (name_teacher !=''),
    CONSTRAINT name_dis_teach UNIQUE (name_discipline,name_teacher)
);

CREATE TABLE exam_to_student(fd_universityfd_university
    student_id int REFERENCES student(student_id ),
    discipline_id int REFERENCES discipline(id ),
    rating smallint NOT NULL CHECK (rating>0)
);

