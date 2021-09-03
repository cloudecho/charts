# [chart-doc-gen](https://github.com/kubepack/chart-doc-gen)
CHARTS=$(shell ls charts)

default: index

merge:
	GIT_MERGE_AUTOEDIT=no git merge main

doc: 
	$(foreach c, $(CHARTS), chart-doc-gen \
	  -d=charts/$(c)/doc.yml \
	  -v=charts/$(c)/values.yaml \
	  > charts/$(c)/README.md)
	
package: merge doc
	$(foreach c, $(CHARTS), helm package charts/$(c))

index: package
	helm repo index . --url https://echoyun.xyz/charts/