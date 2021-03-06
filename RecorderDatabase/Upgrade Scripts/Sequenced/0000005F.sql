-- Additional attributes for the Report Wizard
-- by Stuart Ball, JNCC
-- May 2008

--
-- REPORT_JOINS
--
IF NOT EXISTS(SELECT 1 FROM REPORT_join WHERE REPORT_JOIN_KEY='JNCCDEV100000001')
	INSERT INTO dbo.REPORT_join (REPORT_JOIN_KEY,JOIN_SQL,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000001','FROM (#REPORT_OUTPUT LEFT JOIN (SAMPLE LEFT JOIN SAMPLE_TYPE ON SAMPLE.SAMPLE_TYPE_KEY = SAMPLE_TYPE.SAMPLE_TYPE_KEY) ON #REPORT_OUTPUT.SAMPLE_KEY = SAMPLE.SAMPLE_KEY)','NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_join WHERE REPORT_JOIN_KEY='JNCCDEV100000002')
	INSERT INTO dbo.REPORT_join (REPORT_JOIN_KEY,JOIN_SQL,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000002','FROM #REPORT_OUTPUT LEFT JOIN  TAXON_OCCURRENCE ON #REPORT_OUTPUT.OCCURRENCE_KEY = TAXON_OCCURRENCE.TAXON_OCCURRENCE_KEY LEFT JOIN  TAXON_OCCURRENCE_SOURCES ON TAXON_OCCURRENCE.TAXON_OCCURRENCE_KEY = TAXON_OCCURRENCE_SOURCES.TAXON_OCCURRENCE_KEY LEFT JOIN  SOURCE ON TAXON_OCCURRENCE_SOURCES.SOURCE_KEY = SOURCE.SOURCE_KEY AND SOURCE.INTERNAL = 1','NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_join WHERE REPORT_JOIN_KEY='JNCCDEV100000003')
	INSERT INTO dbo.REPORT_join (REPORT_JOIN_KEY,JOIN_SQL,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000003','FROM #REPORT_OUTPUT LEFT JOIN  TAXON_DETERMINATION ON #REPORT_OUTPUT.OCCURRENCE_KEY = TAXON_DETERMINATION.TAXON_OCCURRENCE_KEY AND TAXON_DETERMINATION.PREFERRED=1 ','NBNSYS000000001 ','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_join WHERE REPORT_JOIN_KEY='JNCCDEV100000004')
	INSERT INTO dbo.REPORT_join (REPORT_JOIN_KEY,JOIN_SQL,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000004','FROM #REPORT_OUTPUT LEFT JOIN TAXON_DETERMINATION ON #REPORT_OUTPUT.OCCURRENCE_KEY = TAXON_DETERMINATION.TAXON_OCCURRENCE_KEY AND TAXON_DETERMINATION.PREFERRED=1 LEFT JOIN  DETERMINER_ROLE ON TAXON_DETERMINATION.DETERMINER_ROLE_KEY = DETERMINER_ROLE.DETERMINER_ROLE_KEY','NBNSYS000000001 ','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_join WHERE REPORT_JOIN_KEY='JNCCDEV100000005')
	INSERT INTO dbo.REPORT_join (REPORT_JOIN_KEY,JOIN_SQL,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000005','FROM #REPORT_OUTPUT LEFT JOIN TAXON_DETERMINATION ON #REPORT_OUTPUT.OCCURRENCE_KEY = TAXON_DETERMINATION.TAXON_OCCURRENCE_KEY AND TAXON_DETERMINATION.PREFERRED=1 LEFT JOIN  DETERMINATION_TYPE ON TAXON_DETERMINATION.DETERMINATION_TYPE_KEY = DETERMINATION_TYPE.DETERMINATION_TYPE_KEY','NBNSYS000000001 ','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_join WHERE REPORT_JOIN_KEY='JNCCDEV100000006')
	INSERT INTO dbo.REPORT_join (REPORT_JOIN_KEY,JOIN_SQL,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000006','FROM #REPORT_OUTPUT LEFT JOIN TAXON_OCCURRENCE_RELATION ON #REPORT_OUTPUT.OCCURRENCE_KEY = TAXON_OCCURRENCE_RELATION.TAXON_OCCURRENCE_KEY_1','NBNSYS000000001 ','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_join WHERE REPORT_JOIN_KEY='JNCCDEV100000007')
	INSERT INTO dbo.REPORT_join (REPORT_JOIN_KEY,JOIN_SQL,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000007','FROM #REPORT_OUTPUT LEFT JOIN TAXON_OCCURRENCE_RELATION ON #REPORT_OUTPUT.OCCURRENCE_KEY = TAXON_OCCURRENCE_RELATION.TAXON_OCCURRENCE_KEY_1 LEFT JOIN RELATIONSHIP_TYPE ON TAXON_OCCURRENCE_RELATION.RELATIONSHIP_TYPE_KEY = RELATIONSHIP_TYPE.RELATIONSHIP_TYPE_KEY','NBNSYS000000001 ','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_join WHERE REPORT_JOIN_KEY='JNCCDEV100000008')
	INSERT INTO dbo.REPORT_join (REPORT_JOIN_KEY,JOIN_SQL,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000008','FROM #REPORT_OUTPUT LEFT JOIN TAXON_OCCURRENCE_RELATION ON #REPORT_OUTPUT.OCCURRENCE_KEY = TAXON_OCCURRENCE_RELATION.TAXON_OCCURRENCE_KEY_1 LEFT JOIN TAXON_OCCURRENCE ON TAXON_OCCURRENCE_RELATION.TAXON_OCCURRENCE_KEY_2 = TAXON_OCCURRENCE.TAXON_OCCURRENCE_KEY LEFT JOIN TAXON_DETERMINATION ON TAXON_OCCURRENCE.TAXON_OCCURRENCE_KEY = TAXON_DETERMINATION.TAXON_OCCURRENCE_KEY AND TAXON_DETERMINATION.PREFERRED = 1 LEFT JOIN INDEX_TAXON_NAME ON TAXON_DETERMINATION.TAXON_LIST_ITEM_KEY = INDEX_TAXON_NAME.TAXON_LIST_ITEM_KEY','NBNSYS000000001 ','2008-05-21',NULL,NULL,1)

--
-- REPORT_ATTRIBUTES
--
IF NOT EXISTS(SELECT 1 FROM REPORT_ATTRIBUTE WHERE REPORT_ATTRIBUTE_KEY='JNCCDEV100000001')
	INSERT INTO dbo.REPORT_attribute (REPORT_ATTRIBUTE_KEY,ITEM_GROUP,SOURCE_TABLE,ITEM_NAME,ATTRIBUTE_SQL,REPORT_JOIN_KEY,REPORT_WHERE_KEY,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000001','Observation','OBSERVATION','Obs Key','#REPORT_OUTPUT.[Obs Key]=TAXON_OCCURRENCE.TAXON_OCCURRENCE_KEY','NBNSYS0000000016',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_ATTRIBUTE WHERE REPORT_ATTRIBUTE_KEY='JNCCDEV100000002')
	INSERT INTO dbo.REPORT_attribute (REPORT_ATTRIBUTE_KEY,ITEM_GROUP,SOURCE_TABLE,ITEM_NAME,ATTRIBUTE_SQL,REPORT_JOIN_KEY,REPORT_WHERE_KEY,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000002','Sample\Location','SAMPLE','Sample Location File Code','#REPORT_OUTPUT.[Sample Location File Code]=LOCATION.FILE_CODE','NBNSYS0000000009',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_ATTRIBUTE WHERE REPORT_ATTRIBUTE_KEY='JNCCDEV100000003')
	INSERT INTO dbo.REPORT_attribute (REPORT_ATTRIBUTE_KEY,ITEM_GROUP,SOURCE_TABLE,ITEM_NAME,ATTRIBUTE_SQL,REPORT_JOIN_KEY,REPORT_WHERE_KEY,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000003','Sample\Location','SAMPLE','Sample Location Centroid','#REPORT_OUTPUT.[Sample Location Centroid]=LOCATION.SPATIAL_REF','NBNSYS0000000009',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_ATTRIBUTE WHERE REPORT_ATTRIBUTE_KEY='JNCCDEV100000004')
	INSERT INTO dbo.REPORT_attribute (REPORT_ATTRIBUTE_KEY,ITEM_GROUP,SOURCE_TABLE,ITEM_NAME,ATTRIBUTE_SQL,REPORT_JOIN_KEY,REPORT_WHERE_KEY,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000004','Observation','OBSERVATION','Obs Confidential','#REPORT_OUTPUT.[Obs Confidential]=TAXON_OCCURRENCE.CONFIDENTIAL','NBNSYS0000000016',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_ATTRIBUTE WHERE REPORT_ATTRIBUTE_KEY='JNCCDEV100000005')
	INSERT INTO dbo.REPORT_attribute (REPORT_ATTRIBUTE_KEY,ITEM_GROUP,SOURCE_TABLE,ITEM_NAME,ATTRIBUTE_SQL,REPORT_JOIN_KEY,REPORT_WHERE_KEY,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000005','Sample','SAMPLE','Sample Type','#REPORT_OUTPUT.[Sample Type]=SAMPLE_TYPE.SHORT_NAME','JNCCDEV100000001',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_ATTRIBUTE WHERE REPORT_ATTRIBUTE_KEY='JNCCDEV100000006')
	INSERT INTO dbo.REPORT_attribute (REPORT_ATTRIBUTE_KEY,ITEM_GROUP,SOURCE_TABLE,ITEM_NAME,ATTRIBUTE_SQL,REPORT_JOIN_KEY,REPORT_WHERE_KEY,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000006','Observation','OBSERVATION','Obs Source','#REPORT_OUTPUT.[Obs Source]=dbo.ufn_GetFormattedReferenceName(SOURCE.SOURCE_KEY)','JNCCDEV100000002',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_ATTRIBUTE WHERE REPORT_ATTRIBUTE_KEY='JNCCDEV100000007')
	INSERT INTO dbo.REPORT_attribute (REPORT_ATTRIBUTE_KEY,ITEM_GROUP,SOURCE_TABLE,ITEM_NAME,ATTRIBUTE_SQL,REPORT_JOIN_KEY,REPORT_WHERE_KEY,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000007','Observation\Determination','OBSERVATION','Determiner Comment','#REPORT_OUTPUT.[Obs Determiner Comment]=TAXON_DETERMINATION.COMMENT','JNCCDEV100000003',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_ATTRIBUTE WHERE REPORT_ATTRIBUTE_KEY='JNCCDEV100000008')
	INSERT INTO dbo.REPORT_attribute (REPORT_ATTRIBUTE_KEY,ITEM_GROUP,SOURCE_TABLE,ITEM_NAME,ATTRIBUTE_SQL,REPORT_JOIN_KEY,REPORT_WHERE_KEY,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000008','Observation\Determination','OBSERVATION','Determination Date','#REPORT_OUTPUT.[Det_Vague_Date_Start] = TAXON_DETERMINATION.VAGUE_DATE_START,#REPORT_OUTPUT.[Det_Vague_Date_End] = TAXON_DETERMINATION.VAGUE_DATE_END,#REPORT_OUTPUT.[Det_Vague_Date_Type] = TAXON_DETERMINATION.VAGUE_DATE_TYPE','JNCCDEV100000003',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_ATTRIBUTE WHERE REPORT_ATTRIBUTE_KEY='JNCCDEV100000009')
	INSERT INTO dbo.REPORT_attribute (REPORT_ATTRIBUTE_KEY,ITEM_GROUP,SOURCE_TABLE,ITEM_NAME,ATTRIBUTE_SQL,REPORT_JOIN_KEY,REPORT_WHERE_KEY,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000009','Observation\Determination','OBSERVATION','Determiner Role','#REPORT_OUTPUT.[Determiner Role]=DETERMINER_ROLE.SHORT_NAME','JNCCDEV100000004',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_ATTRIBUTE WHERE REPORT_ATTRIBUTE_KEY='JNCCDEV100000010')
	INSERT INTO dbo.REPORT_attribute (REPORT_ATTRIBUTE_KEY,ITEM_GROUP,SOURCE_TABLE,ITEM_NAME,ATTRIBUTE_SQL,REPORT_JOIN_KEY,REPORT_WHERE_KEY,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000010','Observation\Determination','OBSERVATION','Determination Type','#REPORT_OUTPUT.[Det Type]=DETERMINATION_TYPE.SHORT_NAME','JNCCDEV100000005',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_ATTRIBUTE WHERE REPORT_ATTRIBUTE_KEY='JNCCDEV100000011')
	INSERT INTO dbo.REPORT_attribute (REPORT_ATTRIBUTE_KEY,ITEM_GROUP,SOURCE_TABLE,ITEM_NAME,ATTRIBUTE_SQL,REPORT_JOIN_KEY,REPORT_WHERE_KEY,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000011','Observation\Association','OBSERVATION','Association Comment','#REPORT_OUTPUT.[Assoc Comment]=TAXON_OCCURRENCE_RELATION.COMMENT','JNCCDEV100000006',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_ATTRIBUTE WHERE REPORT_ATTRIBUTE_KEY='JNCCDEV100000012')
	INSERT INTO dbo.REPORT_attribute (REPORT_ATTRIBUTE_KEY,ITEM_GROUP,SOURCE_TABLE,ITEM_NAME,ATTRIBUTE_SQL,REPORT_JOIN_KEY,REPORT_WHERE_KEY,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000012','Observation\Association','OBSERVATION','Association Type','#REPORT_OUTPUT.[Assoc Type]=RELATIONSHIP_TYPE.SHORT_NAME','JNCCDEV100000007',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_ATTRIBUTE WHERE REPORT_ATTRIBUTE_KEY='JNCCDEV100000013')
	INSERT INTO dbo.REPORT_attribute (REPORT_ATTRIBUTE_KEY,ITEM_GROUP,SOURCE_TABLE,ITEM_NAME,ATTRIBUTE_SQL,REPORT_JOIN_KEY,REPORT_WHERE_KEY,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000013','Observation\Association','OBSERVATION','Associated Species','#REPORT_OUTPUT.[Assoc Species]=INDEX_TAXON_NAME.PREFERRED_NAME','JNCCDEV100000008',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)

-- move some existing attributes into new sub-groups in the tree view
UPDATE dbo.REPORT_attribute SET ITEM_GROUP='Sample\Grid square',CHANGED_BY='NBNSYS0000000001',CHANGED_DATE='2008-05-21' WHERE REPORT_ATTRIBUTE_KEY='NBNSYS0000000029' 
UPDATE dbo.REPORT_attribute SET ITEM_GROUP='Sample\Grid square',CHANGED_BY='NBNSYS0000000001',CHANGED_DATE='2008-05-21' WHERE REPORT_ATTRIBUTE_KEY='NBNSYS0000000030'
UPDATE dbo.REPORT_attribute SET ITEM_GROUP='Sample\Location',CHANGED_BY='NBNSYS0000000001',CHANGED_DATE='2008-05-21' WHERE REPORT_ATTRIBUTE_KEY='NBNSYS0000000038'
UPDATE dbo.REPORT_attribute SET ITEM_GROUP='Sample\Location',CHANGED_BY='NBNSYS0000000001',CHANGED_DATE='2008-05-21' WHERE REPORT_ATTRIBUTE_KEY='NBNSYS0000000039'
UPDATE dbo.REPORT_attribute SET ITEM_GROUP='Sample\Location',CHANGED_BY='NBNSYS0000000001',CHANGED_DATE='2008-05-21' WHERE REPORT_ATTRIBUTE_KEY='NBNSYS0000000041'
UPDATE dbo.REPORT_attribute SET ITEM_GROUP='Observation\Determination',CHANGED_BY='NBNSYS0000000001',CHANGED_DATE='2008-05-21' WHERE REPORT_ATTRIBUTE_KEY='NBNSYS0000000063'

--
-- REPORT_FIELDS
--
IF NOT EXISTS(SELECT 1 FROM REPORT_field WHERE REPORT_FIELD_KEY='JNCCDEV100000001')
	INSERT INTO dbo.REPORT_field (REPORT_FIELD_KEY,REPORT_ATTRIBUTE_KEY,FIELD_ITEM_NAME,FIELD_TYPE,FIELD_SIZE,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000001','JNCCDEV100000001','Obs Key','text','16','NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_field WHERE REPORT_FIELD_KEY='JNCCDEV100000002')
	INSERT INTO dbo.REPORT_field (REPORT_FIELD_KEY,REPORT_ATTRIBUTE_KEY,FIELD_ITEM_NAME,FIELD_TYPE,FIELD_SIZE,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000002','JNCCDEV100000002','Sample Location File Code','text','20','NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_field WHERE REPORT_FIELD_KEY='JNCCDEV100000003')
	INSERT INTO dbo.REPORT_field (REPORT_FIELD_KEY,REPORT_ATTRIBUTE_KEY,FIELD_ITEM_NAME,FIELD_TYPE,FIELD_SIZE,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000003','JNCCDEV100000003','Sample Location Centroid','text','40','NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_field WHERE REPORT_FIELD_KEY='JNCCDEV100000004')
	INSERT INTO dbo.REPORT_field (REPORT_FIELD_KEY,REPORT_ATTRIBUTE_KEY,FIELD_ITEM_NAME,FIELD_TYPE,FIELD_SIZE,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000004','JNCCDEV100000004','Obs Confidential','bit',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_field WHERE REPORT_FIELD_KEY='JNCCDEV100000005')
	INSERT INTO dbo.REPORT_field (REPORT_FIELD_KEY,REPORT_ATTRIBUTE_KEY,FIELD_ITEM_NAME,FIELD_TYPE,FIELD_SIZE,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000005','JNCCDEV100000005','Sample Type','text','20','NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_field WHERE REPORT_FIELD_KEY='JNCCDEV100000006')
	INSERT INTO dbo.REPORT_field (REPORT_FIELD_KEY,REPORT_ATTRIBUTE_KEY,FIELD_ITEM_NAME,FIELD_TYPE,FIELD_SIZE,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000006','JNCCDEV100000006','Obs Source','text','100','NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_field WHERE REPORT_FIELD_KEY='JNCCDEV100000007')
	INSERT INTO dbo.REPORT_field (REPORT_FIELD_KEY,REPORT_ATTRIBUTE_KEY,FIELD_ITEM_NAME,FIELD_TYPE,FIELD_SIZE,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000007','JNCCDEV100000007','Obs Determiner Comment','text',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_field WHERE REPORT_FIELD_KEY='JNCCDEV100000008')
	INSERT INTO dbo.REPORT_field (REPORT_FIELD_KEY,REPORT_ATTRIBUTE_KEY,FIELD_ITEM_NAME,FIELD_TYPE,FIELD_SIZE,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000008','JNCCDEV100000008','Det_Vague_Date_Start','int',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_field WHERE REPORT_FIELD_KEY='JNCCDEV100000009')
	INSERT INTO dbo.REPORT_field (REPORT_FIELD_KEY,REPORT_ATTRIBUTE_KEY,FIELD_ITEM_NAME,FIELD_TYPE,FIELD_SIZE,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000009','JNCCDEV100000008','Det_Vague_Date_End','int',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_field WHERE REPORT_FIELD_KEY='JNCCDEV100000010')
	INSERT INTO dbo.REPORT_field (REPORT_FIELD_KEY,REPORT_ATTRIBUTE_KEY,FIELD_ITEM_NAME,FIELD_TYPE,FIELD_SIZE,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000010','JNCCDEV100000008','Det_Vague_Date_Type','varchar','2','NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_field WHERE REPORT_FIELD_KEY='JNCCDEV100000011')
	INSERT INTO dbo.REPORT_field (REPORT_FIELD_KEY,REPORT_ATTRIBUTE_KEY,FIELD_ITEM_NAME,FIELD_TYPE,FIELD_SIZE,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000011','JNCCDEV100000009','Determiner Role','text','20','NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_field WHERE REPORT_FIELD_KEY='JNCCDEV100000012')
	INSERT INTO dbo.REPORT_field (REPORT_FIELD_KEY,REPORT_ATTRIBUTE_KEY,FIELD_ITEM_NAME,FIELD_TYPE,FIELD_SIZE,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000012','JNCCDEV100000010','Det Type','text','20','NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_field WHERE REPORT_FIELD_KEY='JNCCDEV100000013')
	INSERT INTO dbo.REPORT_field (REPORT_FIELD_KEY,REPORT_ATTRIBUTE_KEY,FIELD_ITEM_NAME,FIELD_TYPE,FIELD_SIZE,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000013','JNCCDEV100000011','Assoc Comment','text',NULL,'NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_field WHERE REPORT_FIELD_KEY='JNCCDEV100000014')
	INSERT INTO dbo.REPORT_field (REPORT_FIELD_KEY,REPORT_ATTRIBUTE_KEY,FIELD_ITEM_NAME,FIELD_TYPE,FIELD_SIZE,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000014','JNCCDEV100000012','Assoc Type','text','20','NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_field WHERE REPORT_FIELD_KEY='JNCCDEV100000015')
	INSERT INTO dbo.REPORT_field (REPORT_FIELD_KEY,REPORT_ATTRIBUTE_KEY,FIELD_ITEM_NAME,FIELD_TYPE,FIELD_SIZE,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000015','JNCCDEV100000013','Assoc Species','text','75','NBNSYS0000000001','2008-05-21',NULL,NULL,1)

--
-- REPORT_JOINS
--
IF NOT EXISTS(SELECT 1 FROM REPORT_join WHERE REPORT_JOIN_KEY='JNCCDEV100000001')
	INSERT INTO dbo.REPORT_join (REPORT_JOIN_KEY,JOIN_SQL,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000001','FROM (#REPORT_OUTPUT LEFT JOIN (SAMPLE LEFT JOIN SAMPLE_TYPE ON SAMPLE.SAMPLE_TYPE_KEY = SAMPLE_TYPE.SAMPLE_TYPE_KEY) ON #REPORT_OUTPUT.SAMPLE_KEY = SAMPLE.SAMPLE_KEY)','NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_join WHERE REPORT_JOIN_KEY='JNCCDEV100000002')
	INSERT INTO dbo.REPORT_join (REPORT_JOIN_KEY,JOIN_SQL,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000002','FROM #REPORT_OUTPUT LEFT JOIN  TAXON_OCCURRENCE ON #REPORT_OUTPUT.OCCURRENCE_KEY = TAXON_OCCURRENCE.TAXON_OCCURRENCE_KEY LEFT JOIN  TAXON_OCCURRENCE_SOURCES ON TAXON_OCCURRENCE.TAXON_OCCURRENCE_KEY = TAXON_OCCURRENCE_SOURCES.TAXON_OCCURRENCE_KEY LEFT JOIN  SOURCE ON TAXON_OCCURRENCE_SOURCES.SOURCE_KEY = SOURCE.SOURCE_KEY AND SOURCE.INTERNAL = 1','NBNSYS0000000001','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_join WHERE REPORT_JOIN_KEY='JNCCDEV100000003')
	INSERT INTO dbo.REPORT_join (REPORT_JOIN_KEY,JOIN_SQL,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000003','FROM #REPORT_OUTPUT LEFT JOIN  TAXON_DETERMINATION ON #REPORT_OUTPUT.OCCURRENCE_KEY = TAXON_DETERMINATION.TAXON_OCCURRENCE_KEY AND TAXON_DETERMINATION.PREFERRED=1 ','NBNSYS000000001 ','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_join WHERE REPORT_JOIN_KEY='JNCCDEV100000004')
	INSERT INTO dbo.REPORT_join (REPORT_JOIN_KEY,JOIN_SQL,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000004','FROM #REPORT_OUTPUT LEFT JOIN TAXON_DETERMINATION ON #REPORT_OUTPUT.OCCURRENCE_KEY = TAXON_DETERMINATION.TAXON_OCCURRENCE_KEY AND TAXON_DETERMINATION.PREFERRED=1 LEFT JOIN  DETERMINER_ROLE ON TAXON_DETERMINATION.DETERMINER_ROLE_KEY = DETERMINER_ROLE.DETERMINER_ROLE_KEY','NBNSYS000000001 ','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_join WHERE REPORT_JOIN_KEY='JNCCDEV100000005')
	INSERT INTO dbo.REPORT_join (REPORT_JOIN_KEY,JOIN_SQL,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000005','FROM #REPORT_OUTPUT LEFT JOIN TAXON_DETERMINATION ON #REPORT_OUTPUT.OCCURRENCE_KEY = TAXON_DETERMINATION.TAXON_OCCURRENCE_KEY AND TAXON_DETERMINATION.PREFERRED=1 LEFT JOIN  DETERMINATION_TYPE ON TAXON_DETERMINATION.DETERMINATION_TYPE_KEY = DETERMINATION_TYPE.DETERMINATION_TYPE_KEY','NBNSYS000000001 ','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_join WHERE REPORT_JOIN_KEY='JNCCDEV100000006')
	INSERT INTO dbo.REPORT_join (REPORT_JOIN_KEY,JOIN_SQL,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000006','FROM #REPORT_OUTPUT LEFT JOIN TAXON_OCCURRENCE_RELATION ON #REPORT_OUTPUT.OCCURRENCE_KEY = TAXON_OCCURRENCE_RELATION.TAXON_OCCURRENCE_KEY_1','NBNSYS000000001 ','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_join WHERE REPORT_JOIN_KEY='JNCCDEV100000007')
	INSERT INTO dbo.REPORT_join (REPORT_JOIN_KEY,JOIN_SQL,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000007','FROM #REPORT_OUTPUT LEFT JOIN TAXON_OCCURRENCE_RELATION ON #REPORT_OUTPUT.OCCURRENCE_KEY = TAXON_OCCURRENCE_RELATION.TAXON_OCCURRENCE_KEY_1 LEFT JOIN RELATIONSHIP_TYPE ON TAXON_OCCURRENCE_RELATION.RELATIONSHIP_TYPE_KEY = RELATIONSHIP_TYPE.RELATIONSHIP_TYPE_KEY','NBNSYS000000001 ','2008-05-21',NULL,NULL,1)
IF NOT EXISTS(SELECT 1 FROM REPORT_join WHERE REPORT_JOIN_KEY='JNCCDEV100000008')
	INSERT INTO dbo.REPORT_join (REPORT_JOIN_KEY,JOIN_SQL,ENTERED_BY,ENTRY_DATE,CHANGED_BY,CHANGED_DATE,SYSTEM_SUPPLIED_DATA) 
	VALUES ('JNCCDEV100000008','FROM #REPORT_OUTPUT LEFT JOIN TAXON_OCCURRENCE_RELATION ON #REPORT_OUTPUT.OCCURRENCE_KEY = TAXON_OCCURRENCE_RELATION.TAXON_OCCURRENCE_KEY_1 LEFT JOIN TAXON_OCCURRENCE ON TAXON_OCCURRENCE_RELATION.TAXON_OCCURRENCE_KEY_2 = TAXON_OCCURRENCE.TAXON_OCCURRENCE_KEY LEFT JOIN TAXON_DETERMINATION ON TAXON_OCCURRENCE.TAXON_OCCURRENCE_KEY = TAXON_DETERMINATION.TAXON_OCCURRENCE_KEY AND TAXON_DETERMINATION.PREFERRED = 1 LEFT JOIN INDEX_TAXON_NAME ON TAXON_DETERMINATION.TAXON_LIST_ITEM_KEY = INDEX_TAXON_NAME.TAXON_LIST_ITEM_KEY','NBNSYS000000001 ','2008-05-21',NULL,NULL,1)
