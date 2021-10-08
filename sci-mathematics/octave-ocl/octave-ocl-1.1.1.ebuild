# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Package using OpenCL for parallelization, mostly suitable to Single-Instruction-Multiple-Data (SIMD) computations, selectively using available OpenCL hardware and drivers"
HOMEPAGE="https://octave.sourceforge.io/ocl"
SRC_URI="https://downloads.sourceforge.net/octave/${P/octave-/}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
RESTRICT="test"

RDEPEND="sci-mathematics/octave"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${PN/octave-/}"

src_install() {
	local INST_PREFIX="${D}/usr/share/octave/packages"
	local ARCH_PREFIX="${D}/usr/$(get_libdir)/octave/packages"

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
	elog "Please append 'pkg load ${PN/octave-/}' to ~/.octaverc"
}

pkg_postrm() {
	einfo "Updating Octave internal packages cache..."
	octave --no-history --no-init-file --no-site-file --no-window-system -q -f \
		--eval "pkg rebuild;" || die
	elog "Please remove 'pkg load ${PN/octave-/}' to ~/.octaverc"
}