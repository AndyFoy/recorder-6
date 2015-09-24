IF  EXISTS 
   (SELECT * FROM sys.foreign_keys 
    WHERE object_id = OBJECT_ID(N'[dbo].[FK_SURVEY_EVENT_SURVEY]') 
    AND parent_object_id = OBJECT_ID(N'[dbo].[SURVEY_EVENT]'))
ALTER TABLE [dbo].[SURVEY_EVENT] DROP CONSTRAINT [FK_SURVEY_EVENT_SURVEY]
