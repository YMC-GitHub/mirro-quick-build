# Contributor: William Pitcock <nenolod@dereferenced.org>
# Contributor: Jose-Luis Rivas <ghostbar@riseup.net>
# Contributor: Jakub Jirutka <jakub@jirutka.cz>
# Contributor: Dave Esaias <dave@containership.io>
# Contributor: Tadahisa Kamijo <kamijin@live.jp>
# Maintainer: Jakub Jirutka <jakub@jirutka.cz>
#
# secfixes:
#   8.11.4-r0:
#     - CVE-2018-12115
#   8.11.3-r0:
#     - CVE-2018-7167
#     - CVE-2018-7161
#     - CVE-2018-1000168
#   8.11.0-r0:
#     - CVE-2018-7158
#     - CVE-2018-7159
#     - CVE-2018-7160
#   8.9.3-r0:
#     - CVE-2017-15896
#     - CVE-2017-15897
#   6.11.5-r0:
#     - CVE-2017-14919
#   6.11.1-r0:
#     - CVE-2017-1000381
#
pkgname=nodejs
# Note: Update only to even-numbered versions (e.g. 6.y.z, 8.y.z)!
# Odd-numbered versions are supported only for 9 months by upstream.
pkgver=8.11.4
pkgrel=0
pkgdesc="JavaScript runtime built on V8 engine - LTS version"
url="https://nodejs.org/"
arch="all"
license="MIT"
depends="ca-certificates"
depends_dev="libuv"
# gold is needed for mksnapshot
makedepends="$depends_dev python2 openssl-dev zlib-dev libuv-dev linux-headers
	paxmark binutils-gold http-parser-dev ca-certificates c-ares-dev"
subpackages="$pkgname-dev $pkgname-doc npm::noarch"
provides="nodejs-lts=$pkgver"  # for backward compatibility
replaces="nodejs-current nodejs-lts"  # nodejs-lts for backward compatibility
source="https://nodejs.org/dist/v$pkgver/node-v$pkgver.tar.gz
	dont-run-gyp-files-for-bundled-deps.patch"
builddir="$srcdir/node-v$pkgver"

prepare() {
	default_prepare

	# Remove bundled dependencies that we're not using.
	rm -rf deps/http_parser deps/openssl deps/uv deps/zlib
}

build() {
	cd "$builddir"

	./configure --prefix=/usr \
		--shared-zlib \
		--shared-libuv \
		--shared-openssl \
		--shared-http-parser \
		--shared-cares \
		--openssl-use-def-ca-store

	# We need run mksnapshot at build time so paxmark it early.
	make -C out mksnapshot BUILDTYPE=Release
	paxmark -m out/Release/mksnapshot
	make

	# paxmark so JIT works
	paxmark -m out/Release/node
}

# TODO Run provided test suite.
check() {
	cd "$builddir"/out/Release

	./node -e 'console.log("Hello, world!")'
	./node -e "require('assert').equal(process.versions.node, '$pkgver')"
}

package() {
	cd "$builddir"

	make DESTDIR="$pkgdir" install

	# It's strange, but it really needs to be paxmarked again...
	paxmark -m "$pkgdir"/usr/bin/node

	cp -pr "$pkgdir"/usr/lib/node_modules/npm/man "$pkgdir"/usr/share
	local d; for d in doc html man; do
		rm -r "$pkgdir"/usr/lib/node_modules/npm/$d
	done
}

dev() {
	provides="nodejs-lts-dev=$pkgver"  # for backward compatibility
	default_dev
}

npm() {
	pkgdesc="A package manager for JavaScript"
	depends="$pkgname"
	# for backward compatibility
	provides="nodejs-npm=$pkgver-r$pkgrel nodejs-current-npm=$pkgver-r$pkgrel"
	replaces="nodejs-npm nodejs-current-npm $pkgname"

	mkdir -p "$subpkgdir"/usr/bin
	mv "$pkgdir"/usr/bin/np[mx] "$subpkgdir"/usr/bin/

	mkdir -p "$subpkgdir"/usr/lib/node_modules
	mv "$pkgdir"/usr/lib/node_modules/npm "$subpkgdir"/usr/lib/node_modules/
}

sha512sums="f93ee89d1db4684ef6ace72ac4676cff6f55fd61968e8316b949d82031c6fd48477f88acdb45e6e0fc4aa6781265afb1ba6c0e175694f6d2e2931f3038a1c886  node-v8.11.4.tar.gz
ba95f21b1e80717ef63941854e7ed412f64a91da068c0dbf0d6d9697333ee266c9f4cd7bf1a01111eeb28aa66adefd8a58cfb3e82debb84b43e35e9dc914dd36  dont-run-gyp-files-for-bundled-deps.patch"
