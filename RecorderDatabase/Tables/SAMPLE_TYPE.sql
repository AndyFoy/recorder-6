if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_SAMPLE_SAMPLE_TYPE]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[SAMPLE] DROP CONSTRAINT FK_SAMPLE_SAMPLE_TYPE
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SAMPLE_TYPE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SAMPLE_TYPE]
GO

CREATE TABLE [dbo].[SAMPLE_TYPE] (
	[SAMPLE_TYPE_KEY] [char] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[SHORT_NAME] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[LONG_NAME] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DESCRIPTION] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[IMAGE] [image] NULL ,
	[RECORDING_CARD] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ENTERED_BY] [char] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ENTRY_DATE] [smalldatetime] NOT NULL ,
	[CHANGED_BY] [char] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CHANGED_DATE] [smalldatetime] NULL ,
	[SYSTEM_SUPPLIED_DATA] [bit] NOT NULL ,
	[CUSTODIAN] [char] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

GRANT  SELECT  ON [dbo].[SAMPLE_TYPE]  TO [R2k_ReadOnly]
GO

GRANT  SELECT ,  UPDATE  ON [dbo].[SAMPLE_TYPE]  TO [R2k_RecordCardsOnly]
GO

GRANT  SELECT ,  UPDATE ,  INSERT  ON [dbo].[SAMPLE_TYPE]  TO [R2k_AddOnly]
GO

GRANT  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[SAMPLE_TYPE]  TO [R2k_FullEdit]
GO

GRANT  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[SAMPLE_TYPE]  TO [R2k_Administrator]
GO

