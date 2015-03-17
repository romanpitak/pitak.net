
coffee = ./node_modules/.bin/coffee
compass = compass
watch = ./node_modules/.bin/watch
serve = ./node_modules/.bin/http-server

.PHONY: all css pages watch clean clean-html

all: public css public/main.js pages

public: src/assets
	mkdir --parents $@
	cp --recursive $</* $@

node_modules: package.json
	npm install
	@touch $@

pages: node_modules
	$(coffee) src/jade/build.litcoffee

css: compass.rb
	$(compass) compile --config $<

public/main.js: node_modules src/coffee/*
	$(coffee) --no-header --print --compile src/coffee > $@

clean: clean-html
	rm --recursive --force node_modules
	rm --recursive --force .sass-cache
	rm --recursive --force public

watch: node_modules
	$(watch) '$(MAKE) all' src --wait=0

dev:
	$(serve) public -a localhost -p 31415 -i -c-1 &
	$(MAKE) watch
