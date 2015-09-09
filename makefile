.PHONY: install

install:
	ls -a | xargs -I% -n1 echo $$(pwd)/% %$HOME/%
