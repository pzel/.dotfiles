.PHONY: install

install:
	ls -a | grep -v git |grep -v '\.\.\?$$' | xargs -I% -n1 ln -s $$(pwd)/% $$HOME/%
