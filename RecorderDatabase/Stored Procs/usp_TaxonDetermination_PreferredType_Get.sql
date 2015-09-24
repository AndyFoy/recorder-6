/*===========================================================================*\
  Drop stored proc before re-creating.
\*===========================================================================*/
IF EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.usp_TaxonDetermination_PreferredType_Get') AND SysStat & 0xf = 4)
	DROP PROCEDURE [dbo].usp_TaxonDetermination_PreferredType_Get
GO

/*===========================================================================*\
  Description:	Returns the verified value of the given determination type.

  Parameters:	@DetTypeKey

  Created:	January 2008

  Last revision information:
    $Revision: 2 $
    $Date: 29/01/08 15:43 $
    $Author: Davidkelly $

\*===========================================================================*/
CREATE PROCEDURE [dbo].usp_TaxonDetermination_PreferredType_Get
	@Key char(16),
	@Output char(16) output
AS
	SELECT @Output = Determination_Type_Key
	FROM Taxon_Determination
	WHERE Taxon_Occurrence_Key = @Key AND Preferred = 1
GO

/*===========================================================================*\
  Grant permissions.
\*===========================================================================*/
IF EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.usp_TaxonDetermination_PreferredType_Get') AND SysStat & 0xf = 4)
BEGIN
    	PRINT 'Setting up security on procedure usp_TaxonDetermination_PreferredType_Get'
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_AddOnly')
        	GRANT EXECUTE ON dbo.usp_TaxonDetermination_PreferredType_Get TO [R2k_AddOnly]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_Administrator')
		GRANT EXECUTE ON dbo.usp_TaxonDetermination_PreferredType_Get TO [R2k_Administrator]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_FullEdit')
		GRANT EXECUTE ON dbo.usp_TaxonDetermination_PreferredType_Get TO [R2k_FullEdit]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_ReadOnly')
		GRANT EXECUTE ON dbo.usp_TaxonDetermination_PreferredType_Get TO [R2k_ReadOnly]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_RecordCardsOnly')
		GRANT EXECUTE ON dbo.usp_TaxonDetermination_PreferredType_Get TO [R2k_RecordCardsOnly]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'Dev - JNCC SQL')
        	GRANT EXECUTE ON dbo.usp_TaxonDetermination_PreferredType_Get TO [Dev - JNCC SQL]
END
GO