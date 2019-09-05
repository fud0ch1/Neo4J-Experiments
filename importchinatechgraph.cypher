Old Way
---

//view data rows in chinese_companies
USING PERIODIC COMMIT
WITH "file:///" AS base
WITH base + "chinese_companies.csv" AS uri
LOAD CSV WITH HEADERS FROM uri AS row
MERGE (:chineseCompanies {id: row.id})

//view data rows in partner
USING PERIODIC COMMIT
WITH "file:///" AS base
WITH base + "partner.csv" AS uri
LOAD CSV WITH HEADERS FROM uri AS row
MERGE (:partner {id: row.id, latitude: row.overseas_infrastructure_lat, longitude: row.overseas_infastructure_lng})

--

New Way

//view data rows in countries , type: row.type
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///countries.csv" AS row
CREATE (:countries {id: row.id})

//view data rows in countries , type: row.type
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///chinese_companies.csv" AS row
CREATE (:chineseCompanies {id: row.id})

//view data rows in countries , type: row.type
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///partner.csv" AS row
CREATE  (:partner {id: row.id})

//view data rows in company_partner_relation
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///company_partner_relation.csv" AS row
MATCH (source:chineseCompanies {id: row.src})
MATCH (destination:partner {id: row.dst})
CREATE (source)-[:Investing]->(destination)

//view data rows in partner_country_relation
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///partner_country_relation.csv" AS row
MATCH (source:partner {id: row.src})
MATCH (destination:countries {id: row.dst})
CREATE (source)-[:Located]->(destination)

//view data rows in Persons Nationality
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///company_country_relation.csv" AS row
MATCH (source:chineseCompanies {id: row.src})
MATCH (destination:countries {id: row.dst})
CREATE (source)-[:presence]->(destination)
