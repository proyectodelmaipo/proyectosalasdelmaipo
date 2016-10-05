/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     04-10-2016 16:49:53                          */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_IMPLEMEN_CONTIENE_SOLICITU') then
    alter table IMPLEMENTOS
       delete foreign key FK_IMPLEMEN_CONTIENE_SOLICITU
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_IMPLEMEN_TIENE_2_LOCAL') then
    alter table IMPLEMENTOS
       delete foreign key FK_IMPLEMEN_TIENE_2_LOCAL
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_LOCAL_TIENE_USUARIO_') then
    alter table LOCAL
       delete foreign key FK_LOCAL_TIENE_USUARIO_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SALAS_TIENE_1_LOCAL') then
    alter table SALAS
       delete foreign key FK_SALAS_TIENE_1_LOCAL
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SOLICITU_TIENE_4_USUARIO_') then
    alter table SOLICITUD
       delete foreign key FK_SOLICITU_TIENE_4_USUARIO_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SOLICITU_TIENE_5_SALAS') then
    alter table SOLICITUD
       delete foreign key FK_SOLICITU_TIENE_5_SALAS
end if;

drop index if exists IMPLEMENTOS.CONTIENE_FK;

drop index if exists IMPLEMENTOS.TIENE_2_FK;

drop index if exists IMPLEMENTOS.IMPLEMENTOS_PK;

drop table if exists IMPLEMENTOS;

drop index if exists LOCAL.TIENE_FK;

drop index if exists LOCAL.LOCAL_PK;

drop table if exists LOCAL;

drop index if exists SALAS.TIENE_1_FK;

drop index if exists SALAS.SALAS_PK;

drop table if exists SALAS;

drop index if exists SOLICITUD.TIENE_5_FK;

drop index if exists SOLICITUD.TIENE_4_FK;

drop index if exists SOLICITUD.SOLICITUD_PK;

drop table if exists SOLICITUD;

drop index if exists USUARIO_A.USUARIO_A_PK;

drop table if exists USUARIO_A;

drop index if exists USUARIO_M.USUARIO_M_PK;

drop table if exists USUARIO_M;

/*==============================================================*/
/* Table: IMPLEMENTOS                                           */
/*==============================================================*/
create table IMPLEMENTOS 
(
   ID_IMPLEMENTO        integer                        not null,
   ID_LOCAL             integer                        null,
   ID_SOLICITUD         integer                        null,
   NOMBRE               char(100)                      null,
   MARCA                char(100)                      null,
   CANTIDAD             integer                        null,
   constraint PK_IMPLEMENTOS primary key (ID_IMPLEMENTO)
);

/*==============================================================*/
/* Index: IMPLEMENTOS_PK                                        */
/*==============================================================*/
create unique index IMPLEMENTOS_PK on IMPLEMENTOS (
ID_IMPLEMENTO ASC
);

/*==============================================================*/
/* Index: TIENE_2_FK                                            */
/*==============================================================*/
create index TIENE_2_FK on IMPLEMENTOS (
ID_LOCAL ASC
);

/*==============================================================*/
/* Index: CONTIENE_FK                                           */
/*==============================================================*/
create index CONTIENE_FK on IMPLEMENTOS (
ID_SOLICITUD ASC
);

/*==============================================================*/
/* Table: LOCAL                                                 */
/*==============================================================*/
create table LOCAL 
(
   ID_LOCAL             integer                        not null,
   ID_ARRENDADOR        integer                        null,
   NOMBRE               char(100)                      null,
   FOTO                 long varchar                   null,
   CALIFICACION         float                          null,
   DESCRIPCION          long varchar                   null,
   HORARIO              timestamp                      null,
   DIRECCION            long varchar                   null,
   LOCALIZACION         long varchar                   null,
   constraint PK_LOCAL primary key (ID_LOCAL)
);

/*==============================================================*/
/* Index: LOCAL_PK                                              */
/*==============================================================*/
create unique index LOCAL_PK on LOCAL (
ID_LOCAL ASC
);

/*==============================================================*/
/* Index: TIENE_FK                                              */
/*==============================================================*/
create index TIENE_FK on LOCAL (
ID_ARRENDADOR ASC
);

/*==============================================================*/
/* Table: SALAS                                                 */
/*==============================================================*/
create table SALAS 
(
   ID_SALA              integer                        not null,
   ID_LOCAL             integer                        null,
   NOMBRE               char(100)                      null,
   FOTO                 long varchar                   null,
   VALOR                integer                        null,
   DESCRIPCION          long varchar                   null,
   CALENDARIO           long varchar                   null,
   constraint PK_SALAS primary key (ID_SALA)
);

/*==============================================================*/
/* Index: SALAS_PK                                              */
/*==============================================================*/
create unique index SALAS_PK on SALAS (
ID_SALA ASC
);

/*==============================================================*/
/* Index: TIENE_1_FK                                            */
/*==============================================================*/
create index TIENE_1_FK on SALAS (
ID_LOCAL ASC
);

/*==============================================================*/
/* Table: SOLICITUD                                             */
/*==============================================================*/
create table SOLICITUD 
(
   ID_SOLICITUD         integer                        not null,
   ID_MUSICO            integer                        null,
   ID_SALA              integer                        null,
   ESTADO               long varchar                   null,
   constraint PK_SOLICITUD primary key (ID_SOLICITUD)
);

/*==============================================================*/
/* Index: SOLICITUD_PK                                          */
/*==============================================================*/
create unique index SOLICITUD_PK on SOLICITUD (
ID_SOLICITUD ASC
);

/*==============================================================*/
/* Index: TIENE_4_FK                                            */
/*==============================================================*/
create index TIENE_4_FK on SOLICITUD (
ID_MUSICO ASC
);

/*==============================================================*/
/* Index: TIENE_5_FK                                            */
/*==============================================================*/
create index TIENE_5_FK on SOLICITUD (
ID_SALA ASC
);

/*==============================================================*/
/* Table: USUARIO_A                                             */
/*==============================================================*/
create table USUARIO_A 
(
   ID_ARRENDADOR        integer                        not null,
   NOMBRE               char(100)                      null,
   EMAIL                char(100)                      null,
   TELEFONO             integer                        null,
   CLAVE                char(100)                      null,
   constraint PK_USUARIO_A primary key (ID_ARRENDADOR)
);

/*==============================================================*/
/* Index: USUARIO_A_PK                                          */
/*==============================================================*/
create unique index USUARIO_A_PK on USUARIO_A (
ID_ARRENDADOR ASC
);

/*==============================================================*/
/* Table: USUARIO_M                                             */
/*==============================================================*/
create table USUARIO_M 
(
   ID_MUSICO            integer                        not null,
   NOMBRE               char(100)                      null,
   EMAIL                char(100)                      null,
   TELEFONO             integer                        null,
   CLAVE                char(100)                      null,
   CALIFICACION         float                          null,
   RADIO                integer                        null,
   constraint PK_USUARIO_M primary key (ID_MUSICO)
);

/*==============================================================*/
/* Index: USUARIO_M_PK                                          */
/*==============================================================*/
create unique index USUARIO_M_PK on USUARIO_M (
ID_MUSICO ASC
);

alter table IMPLEMENTOS
   add constraint FK_IMPLEMEN_CONTIENE_SOLICITU foreign key (ID_SOLICITUD)
      references SOLICITUD (ID_SOLICITUD)
      on update restrict
      on delete restrict;

alter table IMPLEMENTOS
   add constraint FK_IMPLEMEN_TIENE_2_LOCAL foreign key (ID_LOCAL)
      references LOCAL (ID_LOCAL)
      on update restrict
      on delete restrict;

alter table LOCAL
   add constraint FK_LOCAL_TIENE_USUARIO_ foreign key (ID_ARRENDADOR)
      references USUARIO_A (ID_ARRENDADOR)
      on update restrict
      on delete restrict;

alter table SALAS
   add constraint FK_SALAS_TIENE_1_LOCAL foreign key (ID_LOCAL)
      references LOCAL (ID_LOCAL)
      on update restrict
      on delete restrict;

alter table SOLICITUD
   add constraint FK_SOLICITU_TIENE_4_USUARIO_ foreign key (ID_MUSICO)
      references USUARIO_M (ID_MUSICO)
      on update restrict
      on delete restrict;

alter table SOLICITUD
   add constraint FK_SOLICITU_TIENE_5_SALAS foreign key (ID_SALA)
      references SALAS (ID_SALA)
      on update restrict
      on delete restrict;

