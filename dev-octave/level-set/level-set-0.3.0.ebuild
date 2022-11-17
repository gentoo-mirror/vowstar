# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Automatically generated files without careful validation.
# Packages in ::guru are preferred, those packages are carefully maintained.
# Generated by https://github.com/vowstar/octave-gentoo-package

EAPI=8

inherit octaveforge

DESCRIPTION="Routines for calculating the time-evolution of the level-set equation and extracting geometric information from the level-set function"
HOMEPAGE="https://octave.sourceforge.io/level-set"
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
