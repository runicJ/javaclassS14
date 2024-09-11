/* notify2.sql */
create table notify (
  idx     int not null auto_increment primary key,	/* 공지사항 고유번호 */
  name    varchar(20)  not null,										/* 공지사항 올린이 */
  title   varchar(100) not null,										/* 공지사항 제목 */
  content text not null,														/* 공지사항 상세내역 */
  startDate datetime default now(),									/* 공지사항 알림 시작일 */
  endDate   datetime default null,									/* 공지사항 알림 종료일 */
  popupSw   char(1)  default 'N'										/* 공지사항 초기화면에 개시여부 */
);

desc notify;
