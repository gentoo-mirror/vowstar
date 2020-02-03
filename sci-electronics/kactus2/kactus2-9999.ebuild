# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A open source IP-XACT-based tool"
HOMEPAGE="
	http://funbase.cs.tut.fi
	https://github.com/kactus2/kactus2dev
"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}dev.git"
else
	SRC_URI="https://github.com/${PN}/${PN}dev/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
	S="${WORKDIR}/${PN}dev-${PV}"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="examples"

# If you are building from git, you will also need gperf to generate
# the configure scripts.
RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtxml:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qthelp:5
	dev-qt/qtsvg:5
"

DEPEND="
	${RDEPEND}
"

src_prepare() {
	default
}

src_configure() {
	default
}

src_compile() {
	default
}

src_install() {
	# Can't use default here, neet set INSTALL_ROOT
	emake DESTDIR="${D}" INSTALL_ROOT="${ED}" install
}
