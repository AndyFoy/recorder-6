SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT Name FROM   SysObjects 
	   WHERE  Id = Object_ID('[dbo].[usp_SampleDetails_Get]') AND Type = 'P')
    DROP PROCEDURE [dbo].[usp_SampleDetails_Get]
GO

/*
  DESCRIPTION
  This procedure returns the whole row from SAMPLE

  PARAMETERS
  @SampleKey  Parameter holding the Sample Key  

  $History: 0000004R.sql $
 * 
 * *****************  Version 1  *****************
 * User: Johnvanbreda Date: 11/03/08   Time: 13:57
 * Created in $/JNCC/Development/Build/SQL Scripts/Upgrade Scripts/Sequenced
 * 
 * *****************  Version 5  *****************
 * User: Johnvanbreda Date: 11/03/08   Time: 11:43
 * Updated in $/JNCC/Development/Build/SQL Scripts/Stored Procs
 * VI16259
 * Sample details includes the sample reference
 * 
 * *****************  Version 4  *****************
 * User: Johndurman   Date: 18/02/08   Time: 10:27
 * Updated in $/JNCC/Development/Build/SQL Scripts/Stored Procs
 * VI 15117 - CCN174 - NPWS - location and date cascading in observations

*/

CREATE PROCEDURE [dbo].[usp_SampleDetails_Get] 	
	@SampleKey char(16)
AS
	SELECT	S.SAMPLE_KEY, L.ITEM_NAME AS LOCATION, S.LOCATION_NAME, S.VAGUE_DATE_START, S.VAGUE_DATE_END,
			S.VAGUE_DATE_TYPE, S.SPATIAL_REF, ST.SHORT_NAME AS SAMPLE_TYPE, S.SAMPLE_REFERENCE			
	FROM	SAMPLE S
	LEFT JOIN LOCATION_NAME L
	ON 	S.LOCATION_KEY = L.LOCATION_KEY	
	INNER JOIN SAMPLE_TYPE ST
	ON	S.SAMPLE_TYPE_KEY = ST.SAMPLE_TYPE_KEY	
	WHERE S.SAMPLE_KEY = @SampleKey
	ORDER BY Sample_Reference
GO

-- Grant access permissions
IF EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('[dbo].[usp_SampleDetails_Get]') AND type = 'P')
BEGIN
	PRINT 'Setting up security on procedure [dbo].[usp_SampleDetails_Get]'
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_AddOnly')
	GRANT EXECUTE ON [dbo].[usp_SampleDetails_Get] TO [R2k_AddOnly]

	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_Administrator')
	GRANT EXECUTE ON [dbo].[usp_SampleDetails_Get] TO [R2k_Administrator]

	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_FullEdit')
	GRANT EXECUTE ON [dbo].[usp_SampleDetails_Get] TO [R2k_FullEdit]

	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_ReadOnly')
	GRANT EXECUTE ON [dbo].[usp_SampleDetails_Get] TO [R2k_ReadOnly]

	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_RecordCardsOnly')
	GRANT EXECUTE ON [dbo].[usp_SampleDetails_Get] TO [R2k_RecordCardsOnly]
END
GO

/*===========================================================================*\
  Drop stored proc before re-creating.
\*===========================================================================*/
IF EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.usp_Surveys_Select_ForSurveyTag') AND SysStat & 0xf = 4)
    DROP PROCEDURE [dbo].[usp_Surveys_Select_ForSurveyTag]
GO

/*===========================================================================*\
  Description:	Retrieve the surveys for a tag

  Parameters:
	@Key		Survey Tag Key

  Created:	February 2008

  Last revision information:
    $Revision: 1 $
    $Date: 11/03/08 13:57 $
    $Author: Johnvanbreda $

\*===========================================================================*/
CREATE PROCEDURE [dbo].[usp_Surveys_Select_ForSurveyTag]
	@Key 	CHAR(16),
	@Order	BIT = 0
AS
	SET NOCOUNT ON

	DECLARE @Results TABLE (
		Survey_Tag_Key	CHAR(16) COLLATE SQL_Latin1_General_CP1_CI_AS,
		Survey_Tag_Term	VARCHAR(150) COLLATE SQL_Latin1_General_CP1_CI_AS,
		Concept_Key		CHAR(16) COLLATE SQL_Latin1_General_CP1_CI_AS,
		Survey_Key		CHAR(16) COLLATE SQL_Latin1_General_CP1_CI_AS,
		Item_Name		VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS,
		FullName		VARCHAR(60) COLLATE SQL_Latin1_General_CP1_CI_AS,
		Entered_By		CHAR(16) COLLATE SQL_Latin1_General_CP1_CI_AS,
		Custodian		CHAR(8) COLLATE SQL_Latin1_General_CP1_CI_AS
	)

	CREATE TABLE #Synonyms (
		Item_Key 		CHAR(16) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Item_Name 		VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Language_Key 	VARCHAR(4) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Language 		VARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Custodian 		CHAR(8) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Entered_By 		CHAR(16) COLLATE SQL_Latin1_General_CP1_CI_AS
	)
	INSERT INTO #Synonyms EXEC usp_ListSynonyms_Select_ForConcept @Key
	INSERT INTO #Synonyms (Item_Key) VALUES (@Key)

	INSERT INTO @Results
	SELECT		Survey_Tag_Key,
				CT.PlainText,
				CP.Preferred_Concept_Key,
				ST.Survey_Key, 
				SU.Item_Name,
				CASE N.Organisation
					WHEN 0 THEN CASE WHEN I.Forename IS NULL THEN I.Surname ELSE I.Forename + ' ' + I.Surname END
					WHEN 1 THEN O.Full_Name
					ELSE ''
				END,
				S.User_Name_Key, 
				ST.Custodian
	FROM		Survey_Tag				ST
	JOIN		VW_ConceptTerm			CT	ON	CT.Concept_Key	=	ST.Concept_Key
	JOIN		VW_ConceptTermPreferred CP 	ON 	CP.Concept_Key 	= 	ST.Concept_Key
	JOIN		Survey					SU	ON	SU.Survey_Key	=	ST.Survey_Key
	JOIN		Session					S	ON	S.Session_ID	= 	ST.Entered_Session_ID
	JOIN		Name					N	ON	N.Name_Key		=	SU.Run_By
	LEFT JOIN	Individual				I	ON	I.Name_Key		=	N.Name_Key
											AND	N.Organisation	=	0
	LEFT JOIN	Organisation 			O 	ON	O.Name_Key		=	N.Name_Key
											AND	N.Organisation	=	1
	WHERE		ST.Concept_Key				IN	(SELECT Item_Key FROM #Synonyms)

	DROP TABLE #Synonyms

	/* Return list sorted as requested */
	SELECT	R.Survey_Tag_Key,
			R.Concept_Key,
			R.Survey_Key,
			R.Item_Name AS SurveyName,
			R.FullName,
			CASE 
				WHEN ST.Concept_Key <> R.Concept_Key THEN '<' + R.Survey_Tag_Term + '> ' 
				ELSE '' 
			END + R.Item_Name + ' - ' + R.FullName AS ItemName,
			R.Entered_By,
			R.Custodian
	FROM	@Results	R
	JOIN	Survey_Tag	ST	ON	ST.Survey_Tag_Key = R.Survey_Tag_Key
	ORDER BY 
		CASE WHEN @Order = 0 THEN Item_Name ELSE FullName END
GO

/*===========================================================================*\
  Grant permissions.
\*===========================================================================*/
IF EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.usp_Surveys_Select_ForSurveyTag') AND SysStat & 0xf = 4)
BEGIN
   	PRINT 'Setting up security on procedure usp_Surveys_Select_ForSurveyTag'
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_Administrator')
		GRANT EXECUTE ON dbo.usp_Surveys_Select_ForSurveyTag TO [R2k_Administrator]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_FullEdit')
		GRANT EXECUTE ON dbo.usp_Surveys_Select_ForSurveyTag TO [R2k_FullEdit]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_AddOnly')
		GRANT EXECUTE ON dbo.usp_Surveys_Select_ForSurveyTag TO [R2k_AddOnly]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_RecordCardsOnly')
       	GRANT EXECUTE ON dbo.usp_Surveys_Select_ForSurveyTag TO [R2k_RecordCardsOnly]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_ReadOnly')
       	GRANT EXECUTE ON dbo.usp_Surveys_Select_ForSurveyTag TO [R2k_ReadOnly]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'Dev - JNCC SQL')
       	GRANT EXECUTE ON dbo.usp_Surveys_Select_ForSurveyTag TO [Dev - JNCC SQL]
END
GO

/*===========================================================================*\
  Drop stored proc before re-creating.
\*===========================================================================*/
IF EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.usp_SurveyTags_Select_ForSurvey') AND SysStat & 0xf = 4)
    DROP PROCEDURE [dbo].[usp_SurveyTags_Select_ForSurvey]
GO

/*===========================================================================*\
  Description:	Retrieve the tags for a survey

  Parameters:
	@Key		Survey Key

  Created:	January 2008

  Last revision information:
    $Revision: 1 $
    $Date: 11/03/08 13:57 $
    $Author: Johnvanbreda $

\*===========================================================================*/
CREATE PROCEDURE [dbo].[usp_SurveyTags_Select_ForSurvey]
	@Key CHAR(16)
AS
	SELECT 	ST.Survey_Tag_Key,
			CT.Concept_Key, 
			CP.Preferred_Concept_Key,
			CASE 
				WHEN CP.Preferred_Concept_Key <> CT.Concept_Key THEN CT.PlainText + ' (' + CP.PlainText + ')' 
				ELSE CP.PlainText 
			END AS PlainText,
			S.User_Name_Key AS Entered_By, 
			ST.Custodian
	FROM 	Survey_Tag				ST
	JOIN 	VW_ConceptTerm 			CT 	ON 	CT.Concept_Key	=	ST.Concept_Key
	JOIN 	VW_ConceptTermPreferred CP 	ON 	CP.Concept_Key	=	ST.Concept_Key
	JOIN 	Session 				S 	ON 	S.Session_ID	=	ST.Entered_Session_ID
	WHERE 	ST.Survey_Key 			= 	@Key
	ORDER BY CT.Sort_Code, CT.Plaintext
GO

/*===========================================================================*\
  Grant permissions.
\*===========================================================================*/
IF EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.usp_SurveyTags_Select_ForSurvey') AND SysStat & 0xf = 4)
BEGIN
   	PRINT 'Setting up security on procedure usp_SurveyTags_Select_ForSurvey'
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_Administrator')
		GRANT EXECUTE ON dbo.usp_SurveyTags_Select_ForSurvey TO [R2k_Administrator]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_FullEdit')
		GRANT EXECUTE ON dbo.usp_SurveyTags_Select_ForSurvey TO [R2k_FullEdit]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_AddOnly')
		GRANT EXECUTE ON dbo.usp_SurveyTags_Select_ForSurvey TO [R2k_AddOnly]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_RecordCardsOnly')
       	GRANT EXECUTE ON dbo.usp_SurveyTags_Select_ForSurvey TO [R2k_RecordCardsOnly]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_ReadOnly')
       	GRANT EXECUTE ON dbo.usp_SurveyTags_Select_ForSurvey TO [R2k_ReadOnly]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'Dev - JNCC SQL')
       	GRANT EXECUTE ON dbo.usp_SurveyTags_Select_ForSurvey TO [Dev - JNCC SQL]
END
GO

