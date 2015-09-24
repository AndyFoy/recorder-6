/*===========================================================================*\
  Drop stored proc before re-creating.
\*===========================================================================*/
IF EXISTS (SELECT *
	   FROM   SysObjects 
	   WHERE  Id = Object_Id(N'[dbo].[usp_User_Select]')
	   AND 	  Type = 'P')
    DROP PROCEDURE [dbo].[usp_User_Select]
GO

/*===========================================================================*\
  Description:	Returns a user, and the formatted user name.

  Parameters:	@NameKey

  Created:	December 2003

  Last revision information:
    $Revision: 1 $
    $Date: 5/12/03 16:58 $
    $Author: Ericsalmon $

\*===========================================================================*/
CREATE PROCEDURE [dbo].[usp_User_Select]
	@NameKey char(16)
AS
SET NOCOUNT ON

	SELECT 	*, dbo.ufn_GetFormattedName(@NameKey) AS [User_Name]
	FROM	[User]
	WHERE	Name_Key = @NameKey

SET NOCOUNT OFF
GO

/*===========================================================================*\
  Grant permissions.
\*===========================================================================*/
IF EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.usp_User_Select') AND SysStat & 0xf = 4)
BEGIN
    	PRINT 'Setting up security on procedure usp_User_Select'
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_AddOnly')
        	GRANT EXECUTE ON dbo.usp_User_Select TO [R2k_AddOnly]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_Administrator')
		GRANT EXECUTE ON dbo.usp_User_Select TO [R2k_Administrator]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_FullEdit')
		GRANT EXECUTE ON dbo.usp_User_Select TO [R2k_FullEdit]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_ReadOnly')
		GRANT EXECUTE ON dbo.usp_User_Select TO [R2k_ReadOnly]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_RecordCardsOnly')
		GRANT EXECUTE ON dbo.usp_User_Select TO [R2k_RecordCardsOnly]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'Dev - JNCC SQL')
        	GRANT EXECUTE ON dbo.usp_User_Select TO [Dev - JNCC SQL]
END
GO