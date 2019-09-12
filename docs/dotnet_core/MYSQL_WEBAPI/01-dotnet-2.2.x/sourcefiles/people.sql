IF EXISTS(SELECT 1 FROM sys.tables WHERE object_id = OBJECT_ID('tbl_people'))
BEGIN;
    DROP TABLE [tbl_people];
END;
GO

CREATE TABLE [tbl_people] (
    [tbl_peopleID] INTEGER NOT NULL IDENTITY(1, 1),
    [ID] INTEGER NULL,
    [FNAME] VARCHAR(255) NULL,
    [LNAME] VARCHAR(255) NULL,
    [EMAIL] VARCHAR(255) NULL,
    [POST] INTEGER NULL,
    PRIMARY KEY ([tbl_peopleID])
);
GO

INSERT INTO tbl_people([ID],[FNAME],[LNAME],[EMAIL],[POST]) VALUES(1,'Aileen','Sullivan','nec.tempus.mauris@musProin.net',22),(2,'Erica','Frank','consectetuer.adipiscing@purusaccumsan.net',44),(3,'David','Clemons','Nulla@nec.net',21),(4,'Raja','Travis','elit@vitaesodales.com',92),(5,'Reese','Tucker','amet@rutrumlorem.net',36),(6,'Branden','Bernard','a.auctor@convallis.ca',57),(7,'Jermaine','Crosby','ac@Vivamusnibh.ca',80),(8,'Breanna','Barker','aliquet.magna.a@eleifend.com',74),(9,'Jenna','Taylor','ac.arcu.Nunc@Pellentesque.ca',74),(10,'Aristotle','Gonzalez','molestie.dapibus.ligula@intempus.com',3);

INSERT INTO tbl_people([ID],[FNAME],[LNAME],[EMAIL],[POST]) VALUES(11,'Demetrius','Eaton','eu.nulla@semperNamtempor.com',18),(12,'Hedda','Navarro','metus.In@blandit.com',29),(13,'Marsden','Hunter','fringilla.porttitor.vulputate@vehiculaPellentesquetincidunt.edu',89),(14,'Aladdin','Watkins','cubilia.Curae.Donec@acarcuNunc.net',95),(15,'Nehru','Boyd','pede@Curabitur.com',96),(16,'Dana','Schroeder','fermentum.risus.at@Nuncmauris.edu',67),(17,'Kelly','Snow','odio.Etiam.ligula@libero.org',74),(18,'Ian','Giles','consequat.purus.Maecenas@amet.edu',48),(19,'Kelsie','Acevedo','arcu.Morbi.sit@fringillapurusmauris.org',17),(20,'Blair','Guerra','velit.Aliquam.nisl@sem.edu',74);