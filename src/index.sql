create
database hocvien;
use
hocvien;
create table student
(
    id           int auto_increment,
    constraint pk_s primary key (id),
    student_code varchar(20)  not null unique,
    name         varchar(100) not null,
    address_id   int,
    course_id    int,
    constraint fk_s1 foreign key (address_id) references address (id),
    constraint fk_s2 foreign key (course_id) references course (id),
    email        varchar(100),
    phone        varchar(15)
);
insert into student(student_code, name, address_id, course_id, email, phone) value ('sv01','Nguyen phu sang',1,1,'sang@gmail.com','098423134554'),
('sv02','Nghuyen van hoang',2,3,'sang@gmail.com','0978423134515'),
('sv03','Nguyen Thanh Tung',3,3,'sang@gmail.com','0968423134525'),
('sv04','Nguyen Quang Ha',4,4,'sang@gmail.com','0958423134555'),
('sv05','Nguyen Văn Hieu',1,2,'sang@gmail.com','094842313455'),
('sv06','Tran Van Luc',1,2,'sang@gmail.com','098423134552'),
('sv07','Nguyen van Cong',2,3,'sang@gmail.com','098423134545'),
('sv08','Nguyen Quoc Khanh',3,4,'sang@gmail.com','098423134551'),
('sv09','Nguyen Xuan Phuong',4,4,'sang@gmail.com','098423134565'),
('sv10','Bui Quang Nam',4,1,'sang@gmail.com','098423134557');
select *
from student;

#
bang dia chi
create table address
(
    id      int auto_increment primary key,
    address varchar(100) not null
);
insert into address(address) value ('Bắc Giang'),
('Hà Nội'),
('Bắc Ninh'),
('Hải Phòng');

#
bang mon hoc
create table course
(
    id          int auto_increment primary key,
    course_code varchar(20)  not null,
    course_name varchar(100) not null,
    constraint un_c unique (course_code, course_name)
);
insert into course(course_code, course_name) value ('c001','java'),
('c002','js'),
('c003','php'),
('c004','python');

#
bang diem
create table point
(
    id         int auto_increment primary key,
    student_id int,
    course_id  int,
    constraint fk_p1 foreign key (student_id) references student (id),
    constraint fk_p2 foreign key (course_id) references course (id),
    point      double not null
);
insert into point(student_id, course_id, point) value (21,2,9.5),
(22,1,9),
(23,2,5),
(24,3,8.5),
(25,1,7.5),
(26,3,5),
(27,2,9),
(28,3,8),
(29,1,7),
(30,2,6);

#
có bao nhieu học sinh thuoc moi tinh
select address, count(s.id) as tongso
from address
         join student s on address.id = s.address_id
group by address;

#
có bao nhieu hoc sinh moi khoa
select course_code as MaSo, course_name as Khoa, count(s.id) as TongSo
from course
         join student s on course.id = s.course_id
group by course_code, course_name;

#
hiển thị điểm số, tên sinh viên, mã số khoa và tên khoa
select course_code, course_name, name, point
from student
         left join point p on student.id = p.student_id
         right join course c on p.course_id = c.id;

#thêm
index cho bảng student
# có 2 loại index...
# create
index tênindex on tên bảng(column1,column2...)
use hocvien;
create
index indexstudent on student(email,phone);
create
index indexnamestudent on student(name);
explain
select name
from student;
explain
select email
from student;
#
kết luận với index dùng để truy xuât dữ liệu nhanh hơn!

# view trong sql: đối với view chúng ta có thể dùng để truy xuất ra một bảng những dữ liệu cần
# có thể sử dụng lại bảng view đó như bảng thông thường
# khi xoá bảng view thì bản gốc k bị ảnh hưởng, khác với thay đổi dữ liệu sẽ bị ảnh hưởng
# cấu trúc tạo 1 view:
create view tênbangview(câu truy vấn dữ liệu ở các bảng cũ)
    use hocvien;
create view studentamountatprovince1 as
(
select address.id, address, count(s.id) as tongso
from address
         join student s on address.id = s.address_id
group by id, address
    );
select *
from studentamountatprovince1;
select *
from studentamountatprovince;
alter table studentamountatprovince1
    add idd varchar(23);


#
procedure trong sql
use hocvien;
create procedure get_person_in_province(in address1 varchar (100))
begin
select name, address
from student
         join address a on a.id = student.address_id
where address = address1;
end;
call get_person_in_province(
    'Bắc Giang'
    );

use
hocvien;
create procedure get_person_in_course1(in course1 varchar (100))
begin
select name, course_name
from student
         join course c on c.id = student.course_id
where course_name = course1;
end;

call get_person_in_course1('java');