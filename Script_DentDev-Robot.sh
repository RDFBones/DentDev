#! /bin/bash

## BUILD CORE ONTOLOGY

cd RDFBones-O/robot

./Script-Build_RDFBones-Robot.sh

cd ../..

## COMPILE TEMPLATE

robot template --template Template_DentDev-Robot.tsv \
      --input RDFBones-O/robot/results/rdfbones.owl \
      --prefix "dentdev: http://w3id.org/rdfbones/ext/dentdev/" \
      --prefix "obo: http://purl.obolibrary.org/obo/" \
      --prefix "rdfbones: http://w3id.org/rdfbones/core#" \
      --ontology-iri "http://w3id.org/rdfbones/ext/dentdev/latest/dentdev.owl" \
      --output results/dentdev.owl
      
## Annotate output

robot annotate --input results/dentdev.owl \
      --remove-annotations \
      --ontology-iri "http://w3id.org/rdfbones/ext/dentdev/latest/dentdev.owl" \
      --version-iri "http://w3id.org/rdfbones/ext/dentdev/v0-1/dentdev.owl" \
      --annotation dc:creator "Felix Engel" \
      --annotation dc:creator "Stefan Schlager" \
      --annotation owl:versionInfo "0.1" \
      --language-annotation dc:description "This RDFBones ontology extension implements the formation stages for permanent teeth introduced by Moorrees et al. (1963)." en \
      --language-annotation dc:title "Permanent teeth formation stages" en \
      --language-annotation rdfs:label "Permanent teeth formation stages" en \
      --language-annotation rdfs:comment "The RDFBones core ontology, version 0.2 or later, needs to be loaded into the same information system for this ontology extension to work." en \
      --output results/dentdev.owl
      
## Quality check of output  

robot reason --reasoner ELK \
      --input results/dentdev.owl \
      -D results/debug.owl
