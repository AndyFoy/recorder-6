/*===========================================================================*\
  Drop stored proc before re-creating.
\*===========================================================================*/
IF EXISTS (SELECT *
	   FROM   SysObjects 
	   WHERE  Id = Object_Id(N'[dbo].[usp_LocationFeature_Update_ForDragDrop]')
	   AND 	  Type = 'P')
    DROP PROCEDURE [dbo].[usp_LocationFeature_Update_ForDragDrop]
GO

/*===========================================================================*\
  Description:	Update a features's parent key after a Drag/Drop or Cut/Paste
		operation.

  Parameters:	@Key		Feature to update.
		@ParentKey	New parent location.
		@UserID		ID of user making the change.

  Created:	February 2004

  Last revision information:
    $Revision: 1 $
    $Date: 19/02/04 12:02 $
    $Author: Ericsalmon $

\*===========================================================================*/
CREATE PROCEDURE [dbo].[usp_LocationFeature_Update_ForDragDrop]
	@Key char(16),
	@ParentKey char(16),
	@UserID char(16)
AS
	UPDATE	Location_Feature
	SET	Location_Key = @ParentKey,
		Changed_By = @UserID,
		Changed_Date = GetDate()
	WHERE	Location_Feature_Key = @Key
GO

/*===========================================================================*\
  Grant permissions.
\*===========================================================================*/
IF EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.usp_LocationFeature_Update_ForDragDrop') AND SysStat & 0xf = 4)
BEGIN
    	PRINT 'Setting up security on procedure usp_LocationFeature_Update_ForDragDrop'
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_AddOnly')
        	GRANT EXECUTE ON dbo.usp_LocationFeature_Update_ForDragDrop TO [R2k_AddOnly]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_Administrator')
		GRANT EXECUTE ON dbo.usp_LocationFeature_Update_ForDragDrop TO [R2k_Administrator]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'R2k_FullEdit')
		GRANT EXECUTE ON dbo.usp_LocationFeature_Update_ForDragDrop TO [R2k_FullEdit]
	IF EXISTS (SELECT * FROM SYSUSERS WHERE NAME = 'Dev - JNCC SQL')
        	GRANT EXECUTE ON dbo.usp_LocationFeature_Update_ForDragDrop TO [Dev - JNCC SQL]
END
GO