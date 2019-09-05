//view data rows in people
WITH "file:///" AS base
WITH base + "people.csv" AS uri
LOAD CSV WITH HEADERS FROM uri AS row
MERGE (:people {id: row.id})

//view data rows in organizations , type: row.type
WITH "file:///" AS base
WITH base + "organizations.csv" AS uri
LOAD CSV WITH HEADERS FROM uri AS row
MERGE (:organizations {id: row.id})

//view data rows in countries
WITH "file:///" AS base
WITH base + "countries.csv" AS uri
LOAD CSV WITH HEADERS FROM uri AS row
MERGE (:countries {id: row.id})

//view data rows in colleges
WITH "file:///" AS base
WITH base + "colleges.csv" AS uri
LOAD CSV WITH HEADERS FROM uri AS row
MERGE (:colleges {id: row.id})

//view data rows in Organizational Relationships
WITH "file:///" AS base
WITH base + "organizationalRelationships.csv" AS uri
LOAD CSV WITH HEADERS FROM uri AS row
MATCH (source:people {id: row.src})
MATCH (destination:organizations {id: row.dst})
MERGE (source)-[:worksFor]->(destination)

//view data rows in Organization Location
WITH "file:///" AS base
WITH base + "organizationalLocation.csv" AS uri
LOAD CSV WITH HEADERS FROM uri AS row
MATCH (source:organizations {id: row.src})
MATCH (destination:countries {id: row.dst})
MERGE (source)-[:location]->(destination)

//view data rows in Persons Nationality
WITH "file:///" AS base
WITH base + "nationalRelationshipsPerson.csv" AS uri
LOAD CSV WITH HEADERS FROM uri AS row
MATCH (source:people {id: row.src})
MATCH (destination:countries {id: row.dst})
MERGE (source)-[:nationality]->(destination)

//view data rows in College Relationship
WITH "file:///" AS base
WITH base + "collegeRelationships.csv" AS uri
LOAD CSV WITH HEADERS FROM uri AS row
MATCH (source:people {id: row.src})
MATCH (destination:colleges {id: row.dst})
MERGE (source)-[:Attended]->(destination)
