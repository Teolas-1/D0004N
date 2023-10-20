

INSERT INTO hotell.gaster(
    "Jenny", 
    "123456789", 
    "jenenc-0@student.ltu.se",
     0, 
     "Luleå"
);

INSERT INTO hotell.anstallda(
    "199703144367",
    "Alice",
    "receptionen@hotelhedvig.se",
    "Gatugatan 1",
    "Receptionist",
    1.0,
    "2020-09-23",
    0,
    0,
    2
);

INSERT INTO hotell.anstallda(
    "199903134387",
    "Bob",
    "städ@hotelhedvig.se",
    "Gatugatan 3",
    "Städare",
    1.0,
    "2020-09-23",
    0,
    0,
    1
);


INSERT INTO hotell.rum_typ(
    1,
    "Enkelrum",
    250.50
);

INSERT INTO hotell.rum_typ(
    2,
    "Dubbelrum",
    340.50
);

INSERT INTO hotell.rum_typ(
    3,
    "Familjerum",
    450.50
);

#Ett enkelrum städat av bob
INSERT INTO hotell.rum(
    1,
    1,
    0,
    1,
    2
);


INSERT INTO hotell.bokning_rum(
    1,
    2,
    "2023-10-16",
    250.50
);

INSERT INTO hotell.bokning_gaster(
    1, #'Jenny'
    1  #Rum nr 1
);


INSERT INTO hotell.in_ut_checkning(
    "2023-10-20",
    "2023-10-21",
    "2023-10-20 12:23:11",
    null, #Ej utcheckad
    1, #bg 1
    1, #incheckad av alice
    null #Ej utcheckad
);

INSERT INTO hotell.bokning_res(
    3,
    1,
    2,
    "2023-10-20",
    0
);




