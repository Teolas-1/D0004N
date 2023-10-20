drop database if exists hotell;
create database hotell;

#Gäst
create table hotell.gast(
  gast_id               int  unsigned    unique    not null AUTO_INCREMENT,
  namn                  varchar(40) not null,
  tel                   VARCHAR(20) not null,
  mail                  varchar(40) not null,
  stam                  boolean not null,
  addr                  varchar(40) not null,

  primary key(gast_id)

);

#Bokning_Gäster
create table hotell.bokning_gaster(
  bg_id     int  unsigned unique not null AUTO_INCREMENT,
  rum_nr    int not null,
  bok_id    int not null,

  primary key(bg_id),

  foreign key(rum_nr) references hotell.rum(rum_nr),
  foreign key(bok_id) references hotell.bokning_rum(bok_id)
  on delete no action
  on update cascade
);

#Bokning
create table hotell.bokning_rum(
  bok_id        int  unsigned unique not null AUTO_INCREMENT,
  gast_id       int  unsigned not null,
  gast_antal    int not null,
  bok_datum     date not null,
  pris          double unsigned not null,

  primary key(bok_id),

  foreign key(gast_id) references hotell.gast(gast_id)
  on delete no action
  on update cascade
);

#Rum
create table hotell.rum(
  rum_nr     int  unsigned unique not null,
  typ_id    int unsigned not null,
  upptaget  boolean not null,
  stadad    boolean not null,
  anst_id   int not null,

  primary key(rum_nr),

  foreign key(anst_id) references hotell.anstallda(anst_id),
  foreign key(typ_id) references hotell.rum_typ(typ_id)
  on delete no action
  on update cascade
);

#Rumstyp
create table hotell.rum_typ(
  typ_id     int  unsigned unique not null,
  namn       varchar(20),
  pris_natt  double unsigned,


  primary key(typ_id)


);

#Ett erbjudande för en typ av rum
create table hotell.erbjudande(
  erb_id     int  unsigned unique not null AUTO_INCREMENT,
  typ_id     int unsigned not null,
  period_fr  date not null,
  period_ti  date not null,
  pris_natt  double unsigned not null,

  primary key(erb_id),

  foreign key(typ_id) references hotell.rum_typ(typ_id)
  on delete no action
  on update cascade
);


# in och utcheckning
create table hotell.in_ut_checkning(
  check_id       int  unsigned unique not null AUTO_INCREMENT,
  in_check_tid   date not null,
  in_check_tid   date not null,
  in_tid         timestamp, # Null innan incheckning gjorts
  ut_tid         timestamp, #Null innan utchening gjorts
  bg_id          int not null,
  in_anst_id     int, #Null innan inceckning
  ut_anst_id     int, #Null innan utceckning

  primary key(check_id),

  foreign key(bg_id) references hotell.bokning_gaster(bg_id),
  foreign key(in_anst_id) references hotell.anstallda(anst_id),
  foreign key(ut_anst_id) references hotell.anstallda(anst_id)
  
  on delete no action
  on update cascade
);

#Anställd på hotellet
create table hotell.anstallda(
  anst_id     int  unsigned unique not null AUTO_INCREMENT,
  pers_nr varchar(12) not null,
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

  primary key(anst_id)

);

#Skift 
create table hotell.skift(
  skift_id     int  unsigned unique not null AUTO_INCREMENT,
  anst_id      int  unsigned not null,
  start        date not null,
  slut         date not null,
  tid          double unsigned not null, #Tid i timmar

  primary key(skift_id),

  foreign key(anst_id) references hotell.anstallda(anst_id)
  
  on delete no action
  on update cascade
);

create table hotell.bokning_res(
  res_bok_id     int  unsigned unique not null AUTO_INCREMENT,
  bord_nr 	int not null,
  bok_id   int not null,
  gast_antal int not null,
  datum      date not null,
  betald     boolean not null,

  primary key(res_bok_id),

  foreign key(bok_id) references hotell.bokning_rum(bok_id)
  
  on delete no action
  on update cascade
);

create table hotell.betalning(
  betalning_id     int  unsigned unique not null AUTO_INCREMENT,
  bok_id           int not null,
  anst_id          int not null,
  pris 			   double unsigned not null, #Tas från pris_natt för rummet/rummen x antal nätter räknat via in/utcheckningen

  primary key(betalning_id),

  foreign key(bok_id) references hotell.bokning_rum(bok_id),
  foreign key(anst_id) references hotell.anstallda(anst_id)
  
  on delete no action
  on update cascade
);



#/////////  Butiken ////////////
drop database if exists butik;
create database butik;


create table butik.produkt(
    produkt_id  int unsigned unique not null AUTO_INCREMENT,
    produktnamn varchar(20) not null,
    antal_lager int not null,
    pris        double unsigned not null,

    primary key(produkt_id)

);

create table butik.kop_produkt(
    kp_id       int unsigned unique not null AUTO_INCREMENT,
    produkt_id  int unsigned,

    primary key(kp_id),
    foreign key(produkt_id) references butik.produkt(produkt_id)

    on delete no action
    on update cascade
);

create table butik.kop(
  kop_id  int unsigned unique not null AUTO_INCREMENT,
  kp_id   int unsigned not null,
  summa   double unsigned not null,

  primary key(kop_id),
  foreign key(kp_id) references butik.kop_produkt(kp_id)
  
  on delete no action
  on update cascade
);