#!/bin/bash

set MLCP=".\\mlcp-Hadoop2-1.3-1\\bin\\mlcp.bat"
set USERNAME=admin
set PASSWORD=admin
set CURL="bin\curl.exe -X PUT --digest --user $USERNAME:$PASSWORD"
set PWD=%~dp0

## setup the database and apperserver.

# these two steps enable the triples index and can set the inference
# Really only needs to be done once
echo "Configuring database"
%CURL% -Hcontent-type:application/json -d@database-properties.json "http://localhost:8002/manage/v2/databases/Documents/properties?group-id=Default"

# intall an extension that can be the web server for this application
# this is the "middle tier" that serves the HTML pages for the application.
echo "Installing HTML page server extension"
%CURL% -Hcontent-type:application/javascript -d@htmlServer.sjs http://localhost:8000/v1/config/resources/htmlServer ; 

##
## data imports
##

#echo "Loading RDF Data..."
#%MLCP% IMPORT -input_file_path data/rdf -input_file_type rdf -username $USERNAME -password $PASSWORD -host localhost -port 8000
echo "Loading JSON..."
%MLCP% IMPORT -input_file_path data/json -username $USERNAME -password $PASSWORD -host localhost -port 8000 -output_uri_replace "$PWD/data/json,''"
#echo "Loading XML..."
%MLCP% IMPORT -input_file_path data/xml/matches -username $USERNAME -password $PASSWORD -host localhost -port 8000 -output_uri_replace "$PWD/data/xml,''"
#echo "Loading XML Triples Docs..."
%MLCP% IMPORT -input_file_path data/xml/triples -username $USERNAME -password $PASSWORD -host localhost -port 8000 -output_uri_replace "$PWD/data/xml/triples,''" -output_collections "http://marklogic.com/semantics#default-graph" 
#

# installs the tutorial html page on MarkLogic REST server as a document.
echo "Installing HTML page"
%CURL% -Hcontent-type:text/html -d@tutorial.html http://localhost:8000/v1/documents?uri=tutorial.html 

echo "Installing the semantic extension"
%CURL% -Hcontent-type:application/javascript -d@semanticExtension.sjs http://localhost:8000/v1/config/resources/semanticExtension ; 

