SET QUOTED_IDENTIFIER ON
GO

/*===========================================================================*\
  Drop stored proc before re-creating.
\*===========================================================================*/
IF EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.usp_IWMatch_DeterminationTypes') AND SysStat & 0xf = 4)
    DROP PROCEDURE [dbo].[usp_IWMatch_DeterminationTypes]
GO

/*===========================================================================*\
  Description:  Populate import table with matched values for unique matched only.

  Parameters:   <none>

  Created:  January 2009

  Last revision information:
    $Revision: 1 $
    $Date: 19/01/09 11:30 $
    $Author: Pauldavies $

\*===========================================================================*/
CREATE PROCEDURE [dbo].[usp_IWMatch_DeterminationTypes]
AS
    UPDATE  #DeterminationTypes
    SET Match_Count =  (SELECT  Count(*)
                FROM    Determination_Type
                WHERE   Import_Value = Short_Name
                OR      Import_Value = Long_Name
                )
    WHERE   Match_Key IS NULL

    UPDATE  #DeterminationTypes
    SET Match_Value = Short_Name,
        Match_Key = Determination_Type_Key
    FROM    Determination_Type
    WHERE   Match_Count = 1
    AND Match_Key IS NULL
    AND (Import_Value = Short_Name
    OR  Import_Value = Long_Name)
GO

/*===========================================================================*\
  Grant permissions.
\*===========================================================================*/
IF EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.usp_IWMatch_DeterminationTypes') AND SysStat & 0xf = 4)
BEGIN
    PRINT 'Setting up security on procedure usp_IWMatch_DeterminationTypes'
    IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_Administrator')
        GRANT EXECUTE ON dbo.usp_IWMatch_DeterminationTypes TO [R2k_Administrator]
    IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_FullEdit')
        GRANT EXECUTE ON dbo.usp_IWMatch_DeterminationTypes TO [R2k_FullEdit]
    IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'Dev - JNCC SQL')
        GRANT EXECUTE ON dbo.usp_IWMatch_DeterminationTypes TO [Dev - JNCC SQL]
END
GO