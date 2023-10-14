drop database if exists hotell;
create database hotell;

--Gäst
create table hotell.gast(
  gast_id               int  unsigned    unique    not null,
  namn                  varchar(40) not null,
  tel                   int not null,
  mail                  varchar(40) not null,
  stam                  boolean not null,
  addr                  varchar(40) not null,

  primary key(gast_id)
  on delete no action
  on update cascade
);

--Bokning_Gäster
create table hotell.bokning_gaster(
  bg_id     int  unsigned unique not null,
  gast_id   int  unsigned not null,
  rum_nr    int not null,
  bok_id    int not null,

  primary key(bg_id),

  foreign key(gast_id) references hotell.gast(gast_id)
  foreign key(bok_id) references hotell.bokning_rum(bok_id)
  on delete no action
  on update cascade
);

--Bokning
create table hotell.bokning_rum(
  bok_id        int  unsigned unique not null,
  gast_id       int  unsigned not null,
  gast_antal    int not null,
  bok_datum     date not null,
  pris          double unsigned not null,

  primary key(bok_id),

  foreign key(gast_id) references hotell.gast(gast_id)
  on delete no action
  on update cascade
);

--Rum
create table hotell.rum(
  rum_nr     int  unsigned unique not null,
  typ   varchar(15) not null,
  upptaget  boolean not null,
  stadad    boolean not null,
  anst_id   int not null,

  primary key(rum_nr),

  foreign key(anst_id) references hotell.anstallda(anst_id)
  on delete no action
  on update cascade
);


create table hotell.in_ut_checkning(
  check_id       int  unsigned unique not null,
  in_check_tid   date not null,
  in_check_tid   date not null,
  in_tid         timestamp, -- Null innan inchecning gjorts
  ut_tid         timestamp, --Null innan utchening gjorts
  bg_id          int not null,
  in_anst_id     int, --Null innan inceckning
  ut_anst_id     int, --Null innan utceckning

  primary key(check_id),

  foreign key(bg_id) references hotell.bokning(bg_id)
  foreign key(in_anst_id) references hotell.anstallda(anst_id)
  foreign key(ut_anst_id) references hotell.anstallda(anst_id)
  on delete no action
  on update cascade
);


create table hotell.anstallda(
  anst_id     int  unsigned unique not null,
  pers_nr int not null,
  namn  varchar(20) not null,
  tel   int not null,
  mail  varchar(40) not null,
  addr  varchar(50) not null,
  yrke  varchar(20) not null,
  omfattning    double unsigned not null,
  dat_anst  date not null,
  tot_semester  double unsigned not null,
  forb_semester double unsigned not null,
  sk_tab int not null,

  primary key(anst_id),

  on delete no action
  on update cascade
);

create table hotell.skift(
  skift_id     int  unsigned unique not null,
  anst_id      int  unsigned not null,
  start        date not null,
  slut         date not null,
  tid          double unsigned not null,

  primary key(skift_id),

  foreign key(anst_id) references hotell.anstallda(anst_id)
  on delete no action
  on update cascade
);

create table hotell.bokning_res(
  bok_id     int  unsigned unique not null,
  gast_id    int not null,
  bg_id      int unsigned,
  gast_antal int not null,
  datum      date not null,
  betald     boolean not null,

  primary key(bok_id),

  foreign key(bg_id) references hotell.bokning_gaster(bg_id)
  foreign key(gast_id) references hotell.gaster(gast_id)
  on delete no action
  on update cascade
);

create table hotell.betalning(
  betalning_id     int  unsigned unique not null,
  bok_id           int not null,
  anst_id          int not null,
  gast_id          int not null,

  primary key(betalning_id),

  foreign key(bok_id) references hotell.bokning(bok_id)
  foreign key(gast_id) references hotell.gaster(gast_id)
  foreign key(anst_id) references hotell.anstallda(anst_id)
  on delete no action
  on update cascade
);



--Butiken
drop database if exists butik;
create database butik;


create table butik.produkt(
    produkt_id  int unsigned unique not null,
    produktnamn varchar(20) not null,
    antal_lager int not null,
    pris        double unsigned not null,

    primary key(produkt_id)

    on delete no action
    on update cascade
);

create table butik.kop_produkt(
    kp_id       int unsigned unique not null,
    produkt_id  int unsigned,

    primary key(kp_id),
    foreign key(produkt_id) references butik.produkt(produkt_id),

    on delete no action
    on update cascade
);

create table butik.kop(
  kop_id  int unsigned unique not null,
  kp_id   int unsigned not null,
  summa   double unsigned not null,

  primary key(kop_id),
  foreign key(kp_id) references butik.produkt(kp_id),
  on delete no action
  on update cascade
);
