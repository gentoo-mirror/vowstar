# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="HTTP server for Qt applications"
HOMEPAGE="https://github.com/nitroshare/qhttpengine"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nitroshare/${PN}.git"
else
	SRC_URI="https://github.com/nitroshare/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
	S="${WORKDIR}/${PN}-${PV}"
fi

LICENSE="GPL-2"
SLOT="5"

IUSE="doc examples test"

RDEPEND="
	dev-qt/qtnetwork:5
"

DEPEND="
	doc? ( app-doc/doxygen )
	test? ( dev-qt/qttest:5 )
	${RDEPEND}
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_DOC=$(usex doc)
		-DBUILD_EXAMPLES=$(usex examples)
		-DBUILD_TESTS=$(usex test)
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DLIB_INSTALL_DIR=$(get_libdir)
		${CMAKE_CONF}
	)

	cmake-utils_src_configure
}
