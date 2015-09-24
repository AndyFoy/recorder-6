
DELETE FROM USABLE_FIELD
WHERE USABLE_FIELD_KEY = 'LCA0002100000002'
AND EXISTS(SELECT * FROM USABLE_FIELD WHERE USABLE_FIELD_KEY = 'LCA0002100000002')

GO
DELETE FROM USABLE_FIELD
WHERE USABLE_FIELD_KEY = 'LCA0002100000001' 
AND EXISTS(SELECT * FROM USABLE_FIELD WHERE USABLE_FIELD_KEY = 'LCA0002100000001')


GO

DELETE FROM USABLE_TABLE
WHERE USABLE_TABLE_KEY = 'LCA0002100000002'
AND EXISTS(SELECT * FROM USABLE_TABLE WHERE USABLE_TABLE_KEY = 'LCA0002100000002')

GO 

DELETE FROM USABLE_TABLE 
WHERE USABLE_TABLE_KEY = 'LCA0002100000001' 
AND EXISTS(SELECT * FROM USABLE_TABLE WHERE USABLE_TABLE_KEY = 'LCA0002100000001')
 
GO
INSERT INTO USABLE_TABLE(USABLE_TABLE_KEY,TABLE_NAME,LINK_TABLE,LINK,APPLY_TO,JOIN_ORDER)
VALUES ('LCA0002100000002', 'LC_DATE_FILTER','Taxon_Occurrence',
'LC_DATE_FILTER.Taxon_Occurrence_Key = Taxon_Occurrence.Taxon_Occurrence_Key',
'T',8)

GO


INSERT INTO USABLE_FIELD(USABLE_FIELD_KEY,TABLE_NAME,FIELD_NAME,FIELD_DESCRIPTION,
FIELD_TYPE,APPLY_TO,SELECTABLE,SORTABLE,FILTERABLE,CALCULATION_SQL)
VALUES ('LCA0002100000002','LC_DATE_FILTER','DATESTRING','Occ_Entry_Date(yyyymmdd)',
'NUMBER','T',0,0,1,'LC_DATE_FILTER.DATESTRING')

GO


INSERT INTO USABLE_TABLE(USABLE_TABLE_KEY,TABLE_NAME,LINK_TABLE,LINK,APPLY_TO,JOIN_ORDER)
VALUES ('LCA0002100000001', 'LC_DATE_FILTER_CHANGED','Taxon_Occurrence',
'LC_DATE_FILTER_CHANGED.Taxon_Occurrence_Key = Taxon_Occurrence.Taxon_Occurrence_Key',
'T',8)

GO

INSERT INTO USABLE_FIELD(USABLE_FIELD_KEY,TABLE_NAME,FIELD_NAME,FIELD_DESCRIPTION,
FIELD_TYPE,APPLY_TO,SELECTABLE,SORTABLE,FILTERABLE,CALCULATION_SQL)
VALUES ('LCA0002100000001','LC_DATE_FILTER_CHANGED','DATESTRING','Occ_Changed_Date(yyyymmdd)',
'NUMBER','T',0,0,1,'LC_DATE_FILTER_CHANGED.DATESTRING')


