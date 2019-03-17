.PHONY: install
LS=ls | grep -v '_bin\|_etc\|_fontconfig\|makefile'

install:
	mkdir -p $$HOME/bin && ln -fs $$HOME/bin $$HOME/.local/bin
	$(LS) | xargs -I% -n1 ln -fs $$(pwd)/% $$HOME/.%
	ls -1 _bin | grep -v '_bin' |  xargs -I% -n1 ln -fs $$(pwd)/_bin/% $$HOME/bin/%
	ln -fs $$(pwd)/_fontconfig $$HOME/.config/fontconfig
	mkdir -p ~/.config/xfce4 && \
	  ln -fs $$(pwd)/_config/xfce4_xinitrc ~/.config/xfce4/xinitrc && \
	  chmod +x ~/.config/xfce4/xinitrc

ls:
	$(LS)
