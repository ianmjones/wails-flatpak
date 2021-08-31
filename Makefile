BACKEND_SRC := $(wildcard *.go)
FRONTEND_SRC := \
	$(wildcard frontend/*.js) \
	$(wildcard frontend/*.json) \
	$(wildcard frontend/public/*.*) \
	$(wildcard frontend/src/*.*) \
	$(wildcard frontend/src/components/*.svelte)

.PHONY: clean clean-all flatpak

wails-flatpak.tar.gz: build/wails-flatpak
	tar -C build -czvf $@ $(^F)

build/wails-flatpak: $(BACKEND_SRC) $(FRONTEND_SRC)
	wails build

install-flatpak: com.ianmjones.wails-flatpak.yml
	flatpak-builder .flatpak-tmp $< --user --install --force-clean

clean:
	rm -rf wails-flatpak.tar.gz build frontend/public/build .flatpak-tmp

clean-all: clean
	rm -rf frontend/node_modules .flatpak-builder
