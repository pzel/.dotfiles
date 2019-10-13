.PHONY: install
LS=ls | grep -v '^_\|makefile'
LN=ln -Tfs

install:
	mkdir -p $$HOME/bin && $(LN) $$HOME/bin $$HOME/.local/bin
	$(LS) | xargs -I% -n1 $(LN) $$(pwd)/% $$HOME/.%
	ls -1 _bin | grep -v '_bin' | xargs -I% -n1 $(LN) $$(pwd)/_bin/% $$HOME/bin/%
	$(LN) $$(pwd)/_chrome \
	  $$(find $$HOME/.mozilla/firefox/ | grep default | head -1)/chrome
	$(LN) $$(pwd)/_GNUstep/ $$HOME/GNUstep
	for DIR in $$(ls _config); do \
	  $(LN) $$(pwd)/_config/$$DIR $$HOME/.config/$$DIR; done
ls:
	$(LS)
