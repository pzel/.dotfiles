.PHONY: install force-install
LS=ls -a | grep -v 'git\|super_key\|makefile\|bootstrap.sh' |grep -v '\.\.\?$$'

install:
	$(LS) | xargs -I% -n1 ln -s $$(pwd)/% $$HOME/%

force-install:
	$(LS) | xargs -I% -n1 ln -fs $$(pwd)/% $$HOME/%
