# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_EXTRAINSTALL="vendor"
RUBY_FAKEGEM_GEMSPEC="csl.gemspec"
RUBY_FAKEGEM_RECIPE_TEST="rspec3"

inherit ruby-fakegem

DESCRIPTION="Citation Style Language (CSL) API for Ruby"
HOMEPAGE="https://github.com/inukshuk/csl-ruby"
SRC_URI="https://github.com/inukshuk/csl-ruby/archive/${PV}.tar.gz -> ${P}.tar.gz"
RUBY_S="${PN}-ruby-${PV}"
LICENSE="AGPL-3 BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~riscv ~sparc ~x86"

ruby_add_rdepend ">=dev-ruby/namae-1.0 <dev-ruby/namae-2
	dev-ruby/rexml"
