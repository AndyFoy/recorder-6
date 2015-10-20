/****** Object:  View [dbo].[LC_ASSOCIATE_FILTER]    Script Date: 14/09/2015 13:18:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[LC_ASSOCIATE_FILTER]
AS
SELECT S.SAMPLE_KEY,ISNULL(I.FORENAME,'') +  ISNULL(I.INITIALS,'') + ISNULL(I.SURNAME,'')  AS ASSOCNAME FROM Sample S
INNER JOIN Sample_recorder SR  ON SR.sample_Key = S.Sample_Key
INNER JOin Survey_Event_Recorder SER ON SER.SE_RECORDER_KEY = SR.SE_RECORDER_KEY
INNER JOIN NAME_RELATION NR ON NR.NAME_KEY_1 = SER.NAME_KEy
INNER JOIN INDIVIDUAL I ON I.NAME_KEY = NR.NAME_KEY_2

UNION Select S.SAMPLE_KEY,O.Full_Name AS ASSOCNAME FROM Sample S
INNER JOIN Sample_recorder SR  ON SR.sample_Key = S.Sample_Key
INNER JOin Survey_Event_Recorder SER ON SER.SE_RECORDER_KEY = SR.SE_RECORDER_KEY
INNER JOIN NAME_RELATION NR ON NR.NAME_KEY_1 = SER.NAME_KEy
INNER JOIN ORGANISATION O ON O.NAME_KEY = NR.NAME_KEY_2

UNION Select S.SAMPLE_KEY,O.Acronym AS ASSOCNAME FROM Sample S
INNER JOIN Sample_recorder SR  ON SR.sample_Key = S.Sample_Key
INNER JOin Survey_Event_Recorder SER ON SER.SE_RECORDER_KEY = SR.SE_RECORDER_KEY
INNER JOIN NAME_RELATION NR ON NR.NAME_KEY_1 = SER.NAME_KEy
INNER JOIN ORGANISATION O ON O.NAME_KEY = NR.NAME_KEY_2 WHERE O.Acronym is not null

UNION Select S.SAMPLE_KEY,NR.NAME_KEY_2 AS ASSOCNAME FROM Sample S
INNER JOIN Sample_recorder SR  ON SR.sample_Key = S.Sample_Key
INNER JOin Survey_Event_Recorder SER ON SER.SE_RECORDER_KEY = SR.SE_RECORDER_KEY
INNER JOIN NAME_RELATION NR ON NR.NAME_KEY_1 = SER.NAME_KEy
          

GO

GRANT SELECT ON [dbo].[LC_ASSOCIATE_FILTER] TO PUBLIC

GO 
Insert Into USABLE_TABLE (USABLE_TABLE_KEY,TABLE_NAME,LInK_TABLE,LINK,APPLY_TO,JOIN_ORDER)
VALUES ('SRA0000400000006','LC_ASSOCIATE_FILTER','Sanmple','LC_ASSOCIATE_FILTER.Sample_Key =Sample.Sample_Key','T',9)

GO
INSERT INTO USABLE_FIELD(USABLE_FIELD_KEY,TABLE_NAME,FIELD_NAME, FIELD_DESCRIPTION,FIELD_TYPE,APPLY_TO,SELECTABLE,
SORTABLE,FILTERABLE,CALCULATION_SQL)
VALUES ('SRA0000400000006','LC_ASSOCIATE_FILTER','ASSOCNAME','Associate (Name or Key)','TEXT','T',0,0,1,'LC_ASSOCIATE_FILTER.ASSOCNAME')
