# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )
GITHUB_PN="DSView"
LIBDIR="/usr/lib64"

inherit autotools cmake python-r1 udev xdg

DESCRIPTION="An open source multi-function instrument"
HOMEPAGE="
	https://www.dreamsourcelab.com
	https://github.com/DreamSourceLab/DSView
"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/DreamSourceLab/${GITHUB_PN}.git"
else
	SRC_URI="https://github.com/DreamSourceLab/${GITHUB_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${GITHUB_PN}-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	virtual/libusb:1
	>=dev-libs/libzip-0.8
	>=dev-libs/boost-1.55
	>=dev-libs/glib-2.28.0:2
	>=dev-cpp/glibmm-2.28.0:2
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtsvg:5
"

DEPEND="
	${RDEPEND}
"

PATCHES=(
	"${FILESDIR}"/${PN}-1.01-viewport.patch
)

src_prepare() {
	default

	grep -rl "/usr/local/lib" "${S}" | xargs sed -i "s@/usr/local/lib@${LIBDIR}@g" || die
	grep -rl "/usr/local" "${S}" | xargs sed -i "s@/usr/local@/usr@g" || die
	cd "${S}/libsigrok4DSL" || die
	sh ./autogen.sh || die
	cd "${S}/libsigrokdecode4DSL" || die
	sh ./autogen.sh || die
}

src_configure() {
	cd "${S}/libsigrok4DSL" || die
	sh ./configure --libdir=${LIBDIR} --prefix=/usr || die
	cd "${S}/libsigrokdecode4DSL" || die
	sh ./configure --libdir=${LIBDIR} --prefix=/usr || die
}

src_compile() {
	cd "${S}/libsigrok4DSL" || die
	emake DESTDIR="${D}"
	cd "${S}/libsigrokdecode4DSL" || die
	emake DESTDIR="${D}"
	cd "${S}"
}

src_install() {
	cd "${S}/libsigrok4DSL" || die
	emake DESTDIR="${D}" install
	cd "${S}/libsigrokdecode4DSL" || die
	emake DESTDIR="${D}" install
	cd "${S}/DSView" || die

	DESTDIR="${D}" \
	PKG_CONFIG_PATH="${D}${LIBDIR}/pkgconfig" \
	CFLAGS="-I${D}/usr/include" \
	CXXFLAGS="-I${D}/usr/include" \
	LDFLAGS="-L${D}${LIBDIR}" \
	cmake -DCMAKE_INSTALL_PREFIX=/usr . || die
	emake DESTDIR="${D}" install
}

pkg_postinst() {
	xdg_pkg_postinst
	udev_reload
}
