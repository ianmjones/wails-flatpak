BACKEND_SRC := $(wildcard *.go)
FRONTEND_SRC := \
	$(wildcard frontend/*.js) \
	$(wildcard frontend/*.json) \
	$(wildcard frontend/public/*.*) \
	$(wildcard frontend/src/*.*) \
	$(wildcard frontend/src/components/*.svelte)

.PHONY: clean clean-all

wails-flatpak.tar.gz: build/wails-flatpak
	tar -C build -czvf $@ $(^F)

build/wails-flatpak: $(BACKEND_SRC) $(FRONTEND_SRC)
	wails build

clean:
	rm wails-flatpak.tar.gz build/wails-flatpak

clean-all: clean
	rm -rf node_modules
