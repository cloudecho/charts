CHARTS=$(shell ls charts)

default: index

merge:
	GIT_MERGE_AUTOEDIT=no git merge main

package: merge
	$(foreach c, $(CHARTS), helm package charts/$(c))

index: package
	helm repo index . --url https://echoyun.xyz/charts/