# Maintainer: winbo-yml-exe <winbo.yml@proton.me>
# Reference: <https://postmarketos.org/devicepkg>
pkgname=device-sineware-protopocket
pkgver=1
pkgrel=0
pkgdesc="Sineware Pocket Workstation Prototype (Rolling)"
url="https://postmarketos.org"
license="MIT"
arch="aarch64"
options="!check !archcheck"
depends="postmarketos-base raspberrypi-bootloader linux-rpi"
makedepends="devicepkg-dev"
subpackages="
	$pkgname-nonfree-firmware:nonfree_firmware
	$pkgname-openrc
	"
source="
	deviceinfo
	modules-initfs
	usercfg.txt
	cmdline.txt
	95-vchiq-permissions.rules
	enforce-platform.sh
	"

build() {
	devicepkg_build $startdir $pkgname
}

package() {
	devicepkg_package $startdir $pkgname
	install -Dm644 "$srcdir"/usercfg.txt "$pkgdir"/boot/usercfg.txt
	install -Dm644 "$srcdir"/cmdline.txt "$pkgdir"/boot/cmdline.txt
	install -Dm644 "$srcdir"/95-vchiq-permissions.rules \
		"$pkgdir"/etc/udev/rules.d/95-vchiq-permissions.rules
	install -Dm755 "$srcdir"/enforce-platform.sh -t "$pkgdir"/etc/profile.d/
}

nonfree_firmware() {
	pkgdesc="WiFi/Bluetooth firmware"
	depends="linux-firmware-brcm"
	mkdir "$subpkgdir"
}

openrc() {
	install_if="$pkgname=$pkgver-r$pkgrel openrc"
	install="$subpkgname.post-install $subpkgname.post-upgrade"

	mkdir -p "$subpkgdir"
}


sha512sums="
d53fc3523e2b10c0a07dc475dcff2ee2b877fbeeffe325de187d0b86436cbe0202371d698a4f987635b3ecc146ff4287c75554765ace7a5cc725f36714bd35ec  deviceinfo
f63c5b669b8d700ccd8445e65262ece9a4cba57dc29d7b514ab13f7f7dfe1da55223b214cca5fe1107e43f2679b0d9ddacbc7d4d2559d3044d8f10133c9b8c41  modules-initfs
59cc47624360698f1db9449d1c494646bc1767eee7b072a9b58985e40d5870f236cb30263176bd7285703249bce4bc44cfb6da06e4db103a0f390aa86fed8016  usercfg.txt
6ab902e62fe5b6a4782caaf10bfdd26eefba28e8d6e9f688d29e0168cde15c1e4a272613bc6fbafc0f448703d56408d687f35644e4553856b3430f244395fdc2  cmdline.txt
7e5505cb07d5b4a81bd28443d508336b5c547356538f1c06f91ed93ad0d7d456d4f74f1d24df5a2e08c17e74f0a66607352ac4874e967e9a91dfec9522d2d58d  95-vchiq-permissions.rules
5ebdd05414792b82073a6453517c19458863809cdfb25e7d8857030c1feb69cbebc02c5309e6a14373125d83e5e673a20f2006520a34148af17219fb1863dd95  enforce-platform.sh
"
