SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO

/*============================================================================*\
VI 21080 (CCN 352) -- standard naming of survey spatial reference fields in
report wizard output so that they are recognised as spatial references by
TJNCCQuery.
\*============================================================================*/
UPDATE		dbo.REPORT_FIELD
SET			FIELD_ITEM_NAME				=	'Survey_NE_Spatial_Ref'
WHERE		REPORT_FIELD_KEY			=	'NBNSYS0000000004'

UPDATE		dbo.REPORT_FIELD
SET			FIELD_ITEM_NAME				=	'Survey_SW_Spatial_Ref'
WHERE		REPORT_FIELD_KEY			=	'NBNSYS0000000005'

IF NOT EXISTS (	SELECT		1
				FROM		dbo.REPORT_FIELD
				WHERE		REPORT_FIELD_KEY	=	'NBNSYS0000000143')
BEGIN
	INSERT INTO	dbo.REPORT_FIELD (
				REPORT_FIELD_KEY,
				REPORT_ATTRIBUTE_KEY,
				FIELD_ITEM_NAME,
				FIELD_TYPE,
				FIELD_SIZE,
				SYSTEM_SUPPLIED_DATA)
	VALUES		('NBNSYS0000000143',
				'NBNSYS0000000004',
				'Survey_NE_Spatial_Ref_System',
				'varchar',
				4,
				1)
END

IF NOT EXISTS (	SELECT		1
				FROM		dbo.REPORT_FIELD
				WHERE		REPORT_FIELD_KEY	=	'NBNSYS0000000144')
BEGIN
	INSERT INTO	dbo.REPORT_FIELD (
				REPORT_FIELD_KEY,
				REPORT_ATTRIBUTE_KEY,
				FIELD_ITEM_NAME,
				FIELD_TYPE,
				SYSTEM_SUPPLIED_DATA)
	VALUES		('NBNSYS0000000144',
				'NBNSYS0000000004',
				'Survey_NE_Lat',
				'float',
				1)
END

IF NOT EXISTS (	SELECT		1
				FROM		dbo.REPORT_FIELD
				WHERE		REPORT_FIELD_KEY	=	'NBNSYS0000000145')
BEGIN
	INSERT INTO	dbo.REPORT_FIELD (
				REPORT_FIELD_KEY,
				REPORT_ATTRIBUTE_KEY,
				FIELD_ITEM_NAME,
				FIELD_TYPE,
				SYSTEM_SUPPLIED_DATA)
	VALUES		('NBNSYS0000000145',
				'NBNSYS0000000004',
				'Survey_NE_Long',
				'float',
				1)
END

IF NOT EXISTS (	SELECT		1
				FROM		dbo.REPORT_FIELD
				WHERE		REPORT_FIELD_KEY	=	'NBNSYS0000000146')
BEGIN
	INSERT INTO	dbo.REPORT_FIELD (
				REPORT_FIELD_KEY,
				REPORT_ATTRIBUTE_KEY,
				FIELD_ITEM_NAME,
				FIELD_TYPE,
				FIELD_SIZE,
				SYSTEM_SUPPLIED_DATA)
	VALUES		('NBNSYS0000000146',
				'NBNSYS0000000005',
				'Survey_SW_Spatial_Ref_System',
				'varchar',
				4,
				1)
END

IF NOT EXISTS (	SELECT		1
				FROM		dbo.REPORT_FIELD
				WHERE		REPORT_FIELD_KEY	=	'NBNSYS0000000147')
BEGIN
	INSERT INTO	dbo.REPORT_FIELD (
				REPORT_FIELD_KEY,
				REPORT_ATTRIBUTE_KEY,
				FIELD_ITEM_NAME,
				FIELD_TYPE,
				SYSTEM_SUPPLIED_DATA)
	VALUES		('NBNSYS0000000147',
				'NBNSYS0000000005',
				'Survey_SW_Lat',
				'float',
				1)
END

IF NOT EXISTS (	SELECT		1
				FROM		dbo.REPORT_FIELD
				WHERE		REPORT_FIELD_KEY	=	'NBNSYS0000000148')
BEGIN
	INSERT INTO	dbo.REPORT_FIELD (
				REPORT_FIELD_KEY,
				REPORT_ATTRIBUTE_KEY,
				FIELD_ITEM_NAME,
				FIELD_TYPE,
				SYSTEM_SUPPLIED_DATA)
	VALUES		('NBNSYS0000000148',
				'NBNSYS0000000005',
				'Survey_SW_Long',
				'float',
				1)
END

UPDATE		dbo.REPORT_ATTRIBUTE
SET			ATTRIBUTE_SQL				=	'#REPORT_OUTPUT.Survey_NE_Spatial_Ref = SURVEY.NE_SPATIAL_REF, #REPORT_OUTPUT.Survey_NE_Spatial_Ref_System = SURVEY.SPATIAL_REF_SYSTEM, #REPORT_OUTPUT.Survey_NE_Lat = SURVEY.NE_LAT, #REPORT_OUTPUT.Survey_NE_Long = SURVEY.NE_LONG'
WHERE		REPORT_ATTRIBUTE_KEY		=	'NBNSYS0000000004'

UPDATE		dbo.REPORT_ATTRIBUTE
SET			ATTRIBUTE_SQL				=	'#REPORT_OUTPUT.Survey_SW_Spatial_Ref = SURVEY.SW_SPATIAL_REF, #REPORT_OUTPUT.Survey_SW_Spatial_Ref_System = SURVEY.SPATIAL_REF_SYSTEM, #REPORT_OUTPUT.Survey_SW_Lat = SURVEY.SW_LAT, #REPORT_OUTPUT.Survey_SW_Long = SURVEY.SW_LONG'
WHERE		REPORT_ATTRIBUTE_KEY		=	'NBNSYS0000000005'
GO
