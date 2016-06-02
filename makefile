.PHONY: install
LS=ls -a | grep -v '_bin\|git\|super_key\|makefile\|bootstrap.sh' |grep -v '\.\.\?$$'

install:
	$(LS) | xargs -I% -n1 ln -fs $$(pwd)/% $$HOME/%
	ls -1 _bin | grep -v '_bin' | xargs -I% -n1 ln -fs $$(pwd)/_bin/% $$HOME/bin/%
