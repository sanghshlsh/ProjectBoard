
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
