
.PHONY: all css pages watch clean clean-html

all: public css public/main.js pages

public: src/assets
	mkdir --parents $@
	cp --recursive $</* $@

node_modules: package.json
	npm install
	@touch $@

pages: node_modules
	./node_modules/.bin/coffee src/jade/build.litcoffee

css: compass.rb
	compass compile --config $<

public/main.js: node_modules src/coffee/*
	./node_modules/.bin/coffee --no-header --print --compile src/coffee > $@

clean: clean-html
	rm --recursive --force node_modules
	rm --recursive --force .sass-cache
	rm --recursive --force public

watch: node_modules
	./node_modules/.bin/watch '$(MAKE) all' src --wait=0

dev:
	./node_modules/.bin/http-server public -a localhost -p 31415 -i -c-1 &
	$(MAKE) watch
