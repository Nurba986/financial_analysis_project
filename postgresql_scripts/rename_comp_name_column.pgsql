-- Rename columns
ALTER TABLE ind_name
RENAME COLUMN "Ticker" TO "act_symbol";
ALTER TABLE ind_name
RENAME COLUMN "Company Name" TO "name";
ALTER TABLE ind_name
RENAME COLUMN "Exchange" TO "exchange";
ALTER TABLE ind_name
RENAME COLUMN "Industry Group" TO "industry";
ALTER TABLE ind_name
RENAME COLUMN "Primary Sector" TO "sector";
ALTER TABLE ind_name
RENAME COLUMN "SIC Code" TO "sic";
ALTER TABLE ind_name
RENAME COLUMN "Country" TO "country";
ALTER TABLE ind_name
RENAME COLUMN "Broad Group" TO "broad_group";

To save the changes, if you are using a database that requires commits (such as PostgreSQL or Oracle):
COMMIT;