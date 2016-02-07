all: tuto.zip img.zip

#.PHONY: tuto.zip img.zip

.ONESHELL:

img.zip: $(wildcard img img/* img/*/* img/*/*/*)
	cd img
	zip ../img.zip -ru *

tuto.zip: $(wildcard tuto tuto/* tuto/*/* tuto/*/*/*)
	cd tuto
	zip ../tuto.zip -ru *
