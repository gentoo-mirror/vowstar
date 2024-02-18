# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Automatically generated files without careful validation.
# Packages in ::guru are preferred, those packages are carefully maintained.
# Generated by https://github.com/vowstar/octave-gentoo-package

EAPI=8

DESCRIPTION="Create and manage triangular and tetrahedral meshes for Finite Element or Finite Volume PDE solvers"
HOMEPAGE="https://octave.sourceforge.io/msh"
SRC_URI="https://downloads.sourceforge.net/octave/${P}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~riscv ~x86"
RESTRICT="test"

RDEPEND="
	sci-mathematics/octave
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${PN}"

src_install() {
	local INST_PREFIX="${D}/usr/share/octave/packages"
	local ARCH_PREFIX="${D}/usr/$(get_libdir)/octave/packages"
	local OCTAVE_VER="$(best_version sci-mathematics/octave)"
	OCTAVE_VER_FULL=${OCTAVE_VER#sci-mathematics/octave-}
	OCTAVE_VER=${OCTAVE_VER_FULL%-*}
	export LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/$(get_libdir)/octave/${OCTAVE_VER}:/usr/$(get_libdir)/octave/${OCTAVE_VER_FULL}"

	octave --no-history --no-init-file --no-site-file --no-window-system -q -f \
		--eval "warning off all;\
		pkg prefix ${INST_PREFIX} ${ARCH_PREFIX};\
		pkg local_list octave_packages;\
		pkg global_list octave_packages;\
		pkg install -verbose -nodeps ${DISTDIR}/${P}.tar.gz;" || die
}

pkg_postinst() {
	einfo "Updating Octave internal packages cache..."
	octave --no-history --no-init-file --no-site-file --no-window-system -q -f \
		--eval "pkg rebuild;" || die
	elog "Please append 'pkg load ${PN}' to ~/.octaverc"
}

pkg_postrm() {
	einfo "Updating Octave internal packages cache..."
	octave --no-history --no-init-file --no-site-file --no-window-system -q -f \
		--eval "pkg rebuild;" || die
	elog "Please remove 'pkg load ${PN}' from ~/.octaverc"
}
