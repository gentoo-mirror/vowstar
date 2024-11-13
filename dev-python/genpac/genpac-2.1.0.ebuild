# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="PAC/Dnsmasq/Wingy file Generator"
HOMEPAGE="https://github.com/JinnLynn/genpac"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv ~sparc ~x86"

PATCHES=(
	"${FILESDIR}/${PN}-2.1.0-fix-collections.patch"
)
