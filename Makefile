
jades = $(shell find src/jade -name '*.jade')
styles = src/sass/*
scripts = src/coffee/*

assets = $(shell find src/assets)

coffee = ./node_modules/.bin/coffee
compass = compass
watch = ./node_modules/.bin/watch
serve = ./node_modules/.bin/http-server

.PHONY: all css pages watch dev clean

all: public css public/main.js pages

public: $(assets)
	mkdir --parents $@
	cp --recursive $</* $@

node_modules: package.json
	npm install
	@touch $@

pages: node_modules $(jades)
	$(coffee) src/jade/build.litcoffee

css: compass.rb $(styles)
	$(compass) compile --config $<

public/main.js: node_modules $(scripts)
	$(coffee) --no-header --print --compile src/coffee > $@

watch: node_modules
	$(watch) '$(MAKE) all' src --wait=0

dev: node_modules
	$(serve) public -a localhost -p 31415 -i -c-1 &
	$(MAKE) watch

clean:
	rm --recursive --force node_modules
	rm --recursive --force .sass-cache
	rm --recursive --force public
