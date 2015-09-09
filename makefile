.PHONY: install

install:
	ls -a | xargs -I% -n1 ln -s $$(pwd)/% $$HOME/%
