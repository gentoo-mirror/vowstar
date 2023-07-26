# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

GIT_PN="KikoPlay"

inherit cmake xdg

DESCRIPTION="KikoPlay is a full-featured danmu player"
HOMEPAGE="
	https://kikoplay.fun
	https://github.com/KikoPlayProject/KikoPlay
"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/KikoPlayProject/${GIT_PN}.git"
else
	SRC_URI="https://github.com/KikoPlayProject/${GIT_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~m68k ~mips ~ppc ~ppc64 ~s390 ~x86"
	S="${WORKDIR}/${GIT_PN}-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	${LUA_DEPS}
	dev-libs/qhttpengine:5
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5
	media-video/mpv[libmpv]
	net-misc/aria2
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/${PN}-0.9.3-cmake-fix.patch"
)

src_configure() {
	local mycmakeargs=(
		-D USE_VCPKG_QT=OFF
	)
	cmake_src_configure
}

src_install() {
	# Can't use default, set INSTALL_ROOT
	emake INSTALL_ROOT="${D}" install
}
