load data
infile 'C:\post\zipcode.CSV'
insert into table zipcodes
FIELDS TERMINATED BY ','
TRAILING NULLCOLS(
	zipcode	char,
	sido	char,
	gugun	char,
	dong	char,
	bunji	char,
	seqnum	integer external
)