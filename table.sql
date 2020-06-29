select * from (
select * from (
select rownum rnum,num,id,title,writeday,money,category,location,readcnt,likes from (
select * from board where writeday>sysdate-3 and visible = 1 order by likes desc, readcnt desc
)) where rnum<18)where rnum>=1 and rnum<=10 ";
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
select * from board
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

create table attfilenotice(
attNum number(4) primary key,
num number(4) references noticeboard(num),
attPath varchar2(1000)
);


delete from member


select * from attfile

...업로드 경로 (예전에 인서트 한 것 사진 안나올 때 수정하는 방식  우아아아아 ) 
update attfile set attpath = 'http:\\localhost:8089\ProjectBoard\upload\2020-06-23\토슈즈.jpg' where attnum =8

