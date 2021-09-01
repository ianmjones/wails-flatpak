OBJ := build/wails-flatpak
BACKEND_SRC := $(wildcard *.go)
FRONTEND_SRC := \
	$(wildcard frontend/*.js) \
	$(wildcard frontend/*.json) \
	$(wildcard frontend/public/*.*) \
	$(wildcard frontend/src/*.*) \
	$(wildcard frontend/src/components/*.svelte)

.PHONY: tgz flatpak run-flatpak install-flatpak clean clean-all

$(OBJ): $(BACKEND_SRC) $(FRONTEND_SRC)
	wails build

tgz: wails-flatpak.tgz

wails-flatpak.tgz: $(OBJ)
	tar -C build -czvf $@ $(^F)

flatpak: com.ianmjones.wails-flatpak.yml $(OBJ)
	flatpak-builder .flatpak-tmp $< --force-clean

run-flatpak: com.ianmjones.wails-flatpak.yml $(OBJ) flatpak
	flatpak-builder --run .flatpak-tmp $< wails-flatpak

install-flatpak: com.ianmjones.wails-flatpak.yml $(OBJ)
	flatpak-builder .flatpak-tmp $< --user --install --force-clean

clean:
	rm -rf wails-flatpak.tgz build frontend/public/build .flatpak-tmp

clean-all: clean
	rm -rf frontend/node_modules .flatpak-builder
