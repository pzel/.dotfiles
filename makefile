.PHONY: install
LS=ls | grep -v '_bin\|_etc\|_fontconfig\|makefile\|_chrome'

install:
	mkdir -p $$HOME/bin && ln -fs $$HOME/bin $$HOME/.local/
	$(LS) | xargs -I% -n1 ln -fs $$(pwd)/% $$HOME/.%
	ls -1 _bin | grep -v '_bin' | xargs -I% -n1 ln -fs $$(pwd)/_bin/% $$HOME/bin/%
	ln -fs $$(pwd)/_fontconfig $$HOME/.config/fontconfig
	ln -fs $$(pwd)/_chrome \
	  $$(find $$HOME/.mozilla/firefox/ | grep default | head -1)/chrome

ls:
	$(LS)
