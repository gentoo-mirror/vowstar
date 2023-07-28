# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )

inherit python-r1

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.code.sf.net/p/urjtag/git"
	inherit git-r3 autotools
	S="${WORKDIR}/${P}/${PN}"
else
	SRC_URI="mirror://sourceforge/urjtag/${P}.tar.xz"
	KEYWORDS="amd64 ppc sparc x86"
fi

DESCRIPTION="Tool for communicating over JTAG with flash chips, CPUs, and many more"
HOMEPAGE="http://urjtag.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
IUSE="ftdi ftd2xx python readline usb"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="ftdi? ( dev-embedded/libftdi:1= )
	ftd2xx? ( dev-embedded/libftd2xx )
	python? ( ${PYTHON_DEPS} )
	readline? ( sys-libs/readline:= )
	usb? ( virtual/libusb:1 )"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	sed -i "s|setup.py install .*|setup.py install --root=\"\$(DESTDIR)\" --prefix=\"\$(PREFIX)\" |g" \
		"${S}"/bindings/python/Makefile.am || die
	sed -i "s|setup.py install .*|setup.py install --root=\"\$(DESTDIR)\" --prefix=\"\$(PREFIX)\" |g" \
		"${S}"/bindings/python/Makefile.in || die

	if [[ ${PV} == "9999" ]] ; then
		mkdir -p m4 || die
		eautopoint
		eautoreconf
	fi
}

src_configure() {
	econf \
		--disable-werror \
		--disable-static \
		--disable-python \
		$(use_with readline) \
		$(use_with ftdi libftdi) \
		$(use_with ftd2xx) \
		$(use_with usb libusb 1.0)
}

src_compile() {
	use python && python_copy_sources

	emake

	if use python; then
		building() {
			cd bindings || die
			emake \
				pyexecdir="$(python_get_sitedir)" \
				pythondir="$(python_get_sitedir)"
		}
		python_foreach_impl run_in_build_dir building
	fi
}

src_install() {
	default

	if use python; then
		installation() {
			cd bindings || die
			emake \
				DESTDIR="${D}" \
				PREFIX="${EPREFIX}/usr" \
				pyexecdir="$(python_get_sitedir)" \
				pythondir="$(python_get_sitedir)" \
				install
		}
		python_foreach_impl run_in_build_dir installation
		python_foreach_impl python_optimize
	fi

	find "${D}" -name '*.la' -type f -delete || die
}
