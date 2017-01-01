.PHONY: install
LS=ls | grep -v '_bin\|_etc\|makefile'

install:
	$(LS) | xargs -I% -n1 ln -fs $$(pwd)/% $$HOME/.%
	ls -1 _bin | grep -v '_bin' |  xargs -I% -n1 ln -fs $$(pwd)/_bin/% $$HOME/bin/%
