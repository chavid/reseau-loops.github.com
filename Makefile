.PHONY: site
SHELL=/bin/bash

build: style catpages
	echo url: file://`pwd`/_site > _config_local.yml
	jekyll build --config _config.yml,_config_local.yml

serve: style catpages
	echo url: file://`pwd`/_site > _config_local.yml
	jekyll serve --host 0.0.0.0 --config _config.yml,_config_local.yml

bundle_build: style catpages
	echo url: file://`pwd`/_site > _config_local.yml
	bundle exec jekyll build --config _config.yml,_config_local.yml

bundle_serve: style catpages
	echo url: file://`pwd`/_site > _config_local.yml
	bundle exec jekyll serve --host 0.0.0.0 --config _config.yml,_config_local.yml

catpages:
	./mk_cat_dirs.sh

# en utilisant jekyll < 1.0
pre1.0: style
	jekyll --url file://`pwd`/_site

style:
	lessc less/bootstrap.less > style.css

.PHONY: tools

tools:
	cd tools && $(MAKE)

interviews: tools
	rm -fr tags/*
	./tools/gen_interviews interviews/20*.md

tmp: style
	echo url: file:///tmp/loops > _config_local.yml
	jekyll build --config _config.yml,_config_local.yml
	rm -fr /tmp/loops
	cp -fr _site /tmp/loops