IF NOT EXISTS(SELECT * FROM syscolumns WHERE name='physical_location')
	ALTER TABLE Reference
		ADD PHYSICAL_LOCATION VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS