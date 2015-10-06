.PHONY: install force-install

install:
	-@ls -a | grep -v 'git\|super_key\|makefile' |grep -v '\.\.\?$$' | xargs -I% -n1 ln -s $$(pwd)/% $$HOME/%

force-install:
	ls -a | grep -v 'git\|super_key\|makefile' |grep -v '\.\.\?$$' | xargs -I% -n1 ln -fs $$(pwd)/% $$HOME/%
