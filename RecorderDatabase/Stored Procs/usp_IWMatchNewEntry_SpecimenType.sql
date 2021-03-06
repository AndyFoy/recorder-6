/*===========================================================================*\
  Drop stored proc before re-creating.
\*===========================================================================*/
IF EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.usp_IWMatchNewEntry_SpecimenType') AND SysStat & 0xf = 4)
	DROP PROCEDURE [dbo].[usp_IWMatchNewEntry_SpecimenType]
GO

/*===========================================================================*\
  Description:	Create a new item in a term list from an import value.

  Parameters:	
	@ImportValue	The name of the new item.
	@EnteredBy

  Created:	June 2004

  Last revision information:
    $Revision: 4 $
    $Date: 16/12/04 15:46 $
    $Author: Johnvanbreda $

\*===========================================================================*/
CREATE PROCEDURE [dbo].[usp_IWMatchNewEntry_SpecimenType]
	@ImportValue varchar(100),
	@EnteredBy char(16)
AS
	DECLARE @Key char(16)
	EXECUTE spNextKey 'Specimen_Type', @Key OUTPUT

	BEGIN TRANSACTION
		INSERT INTO Specimen_Type(
			Specimen_Type_Key, Short_Name, Long_Name, Entered_By
		) VALUES (
			@Key, 
			CASE WHEN LEN(@ImportValue)>20 THEN LEFT(@ImportValue, 17) + '...' ELSE @ImportValue END, 
			@ImportValue, 
			@EnteredBy
		)

		IF @@Error <> 0 GOTO RollbackAndExit

		-- And update import table with new data.
		UPDATE	#SpecimenTypes
		SET	Match_Value = Import_Value,
			Match_Key = @Key,
			Match_Count = 1,
			Manual_Match = 1,
			Remembered = 0
		WHERE	Import_Value = @ImportValue
	COMMIT TRANSACTION
	RETURN 0

RollBackAndExit: 
	ROLLBACK TRANSACTION
GO

/*===========================================================================*\
  Grant permissions.
\*===========================================================================*/
IF EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.usp_IWMatchNewEntry_SpecimenType') AND SysStat & 0xf = 4)
BEGIN
    	PRINT 'Setting up security on procedure usp_IWMatchNewEntry_SpecimenType'
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_Administrator')
		GRANT EXECUTE ON dbo.usp_IWMatchNewEntry_SpecimenType TO [R2k_Administrator]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_FullEdit')
		GRANT EXECUTE ON dbo.usp_IWMatchNewEntry_SpecimenType TO [R2k_FullEdit]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'Dev - JNCC SQL')
        	GRANT EXECUTE ON dbo.usp_IWMatchNewEntry_SpecimenType TO [Dev - JNCC SQL]
END
GO