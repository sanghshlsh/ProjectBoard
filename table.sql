
select * from (select rownum rnum, num, title,id, writeday, money,category,location, readcnt,likes from (select * from board where visible=1 order by num desc)) where rnum>=1 and rnum <=10
create user ca4 identified by ca4;
asdasdsad
grant connect,resource,dba to ca4;

     SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE = 'TABLE'
    alter table board add likes number(4) default 0
select * from dba_tables where owner='ca4'
select * from user_tables
select * from (select * from board where writeday > sysdate -1)
select * from board
select * from noticeboard
select * from member
select * from attfile
select * from user_tables
SELECT * FROM USER_TAB_PRIVS_RECD;
select * from user_role_privs;
select * from likelist
insert into trashboard select * from board where num = 27
delete from board where num = 27
GRANT CONNECT, RESOURCE, DBA TO ca4;

--자신이 볼수 있는 테이블 목록 
drop table log
SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='TABLE';

select * from (select rownum rnum,id,title,num,money from (select * from board order by money desc )) where rnum <4
select rownum rnum,id,title,num from board
select * from board order by num desc
select * from trashboard order by num desc
--자신에게 권한이 있는 모든 테이블

SELECT table_name FROM ALL_tables ORDER BY TABLE_NAME;
select max(attnum) from attfile
select * from attfile
select * from attfile where num = 26 order by attnum
select nickname from member where id = 'a'


select * from (select rownum rnum, num, title,id, writeday, money,category,location, readcnt,likes from (select * from board where visible=1 order by num desc)) where rnum>=1 and rnum <=10

select * from reply



create table board(
num number(4) primary key,
id varchar2(21) references member(id),
title varchar2(81) not null,
content varchar2(3000),
readcnt number(4),
writeday date default sysdate,
money number(8) default 0,
category varchar2(21),
location varchar2(21),
likes number(4) default 0
);


drop table trashboard
alter table board drop column likes
alter table noticeboard drop column likes
alter table board add visible number(1) default 1 check(visible<2) 

0 - false(출력x)  1 - true(출력o) 통일할게요

alter table board drop column visible

select * from (select * from board where visible = 1 order by num desc) where title like '%2%' or content like '%2%'
insert into member (id,pw,name,nickname,contact,location,birthdate,gender) values ('a','a','a','a','a','a',123,'a')
SELECT * FROM MEMBER
select * from board
insert into board 
(num, id, title, content, money, category, location, readcnt) 
values (2,'a','aaa','aa',1,'가구','서울',0);



create table member(
id varchar2(21) primary key,
pw varchar2(21) not null,
name varchar2(21) not null,
nickname varchar2(60) not null,
contact varchar2(11) not null,
location varchar2(21) not null,
birthdate number(8) not null,
gender varchar2(6) not null,
joinday date default sysdate
);
alter table member add joinday date default sysdate

create table memberCopy(
id varchar2(21) primary key,
pw varchar2(21) not null,
name varchar2(21) not null,
nickname varchar2(60) not null,
contact varchar2(11) not null,
location varchar2(21) not null,
birthdate number(8) not null,
gender varchar2(6) not null,
joinday date default sysdate
);
alter table memberCopy add joinday date default sysdate


create table likeList(
likeNum number(4) primary key,
num number(4) references board(num),
id varchar2(21) references member(id)
);

create table reply(
renum number(4) primary key,
num number(4) references board(num),
content varchar2(1000),
id varchar2(21) references member(id),
writeday date default sysdate,
repRoot  number(4),
repStep number(4),
repIndent number(4),
orgnum number(4) default 0
);

create table NoticeBoard(
num number(4) primary key,
id varchar2(21) references member(id),
title varchar2(81) not null,
content varchar2(3000),
readcnt number(4),
writeday date default sysdate,
money number(8) default 0,
category varchar2(21),
location varchar2(21)
);

create table attfile(
attNum number(4) primary key,
num number(4) references board(num),
attPath varchar2(1000)
);
select *from ATTFILE

create table board(
num number(4) primary key,
id varchar2(21) references member(id),
title varchar2(81) not null,
content varchar2(3000),
readcnt number(4),
writeday date default sysdate,
money number(8) default 0,
category varchar2(21),
location varchar2(21),
likes number(4) default 0,
visible number(1) default 1
);
alter table board add visible number(1) default 1

select *from BOARD
select * from attfilenotice



create table location(
location varchar2(21) primary key,
loVal varchar2(21)
);
insert into location values ('서울','서울' )
insert into location values ('경기도','경기도' )
insert into location values ('강원도','강원도' )
insert into location values ('충청도','충청도' )
insert into location values ('전라도','전라도' )
insert into location values ('경상도','경상도' )
insert into location values ('제주도','제주도' )



create table category(
category varchar2(21) primary key,
caVal varchar2(21)
);
insert into category values ('가구/가전','가구_가전')
insert into category values ('뷰티/미용','뷰티_미용')
insert into category values ('유아','유아')
insert into category values ('생활/식품','생활_식품')
insert into category values ('스포츠/레저','스포츠_레저')
insert into category values ('의류','의류')
insert into category values ('반려동물','반려동물')
insert into category values ('기타중고','기타중고')

