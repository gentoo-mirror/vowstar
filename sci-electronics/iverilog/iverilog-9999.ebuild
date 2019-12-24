# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A Verilog simulation and synthesis tool"
HOMEPAGE="http://iverilog.icarus.com/"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="examples"

RDEPEND="
	app-arch/bzip2
	sys-libs/readline:0=
	sys-libs/zlib:="

# If you are building from git, you will also need software to generate
# the configure scripts.
DEPEND="
	>=sys-devel/autoconf-2.53
	dev-util/gperf
	${RDEPEND}
"

GITHUB_PV=$(ver_rs 1- '_')

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/steveicarus/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/steveicarus/${PN}/archive/v${GITHUB_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sh ~sparc ~x86"
	S="${WORKDIR}/${PN}-${GITHUB_PV}"
fi

src_prepare() {
	default

	# From upstreams autoconf.sh, to make it utilize the autotools eclass
	# Here translate the autoconf.sh, equivalent to the following code
	# > sh autoconf.sh

	# Autoconf in root ...
	eautoconf --force
	# Precompiling lexor_keyword.gperf
	gperf -o -i 7 -C -k 1-4,6,9,\$ -H keyword_hash -N check_identifier -t ./lexor_keyword.gperf > lexor_keyword.cc || die
	# Precompiling vhdlpp/lexor_keyword.gperf
	cd vhdlpp || die
	gperf -o -i 7 --ignore-case -C -k 1-4,6,9,\$ -H keyword_hash -N check_identifier -t ./lexor_keyword.gperf > lexor_keyword.cc || die
}

src_install() {
	emake DESTDIR="${D}" install
	einstalldocs
	dodoc *.txt

	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
