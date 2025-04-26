# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Language recognition library by Belledonne Communications"
HOMEPAGE="https://gitlab.linphone.org/BC/public/belr"
SRC_URI="https://gitlab.linphone.org/BC/public/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tools"
RESTRICT="test"

RDEPEND="net-libs/bctoolbox"
DEPEND="${RDEPEND}"
BDEPEND="virtual/libudev
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DENABLE_STRICT=NO
		-DENABLE_TOOLS="$(usex tools)"
		-DENABLE_UNIT_TESTS=NO
	)

	cmake_src_configure
}
