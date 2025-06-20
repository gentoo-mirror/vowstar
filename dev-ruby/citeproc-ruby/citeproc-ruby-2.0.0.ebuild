# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_GEMSPEC="citeproc-ruby.gemspec"
RUBY_FAKEGEM_RECIPE_TEST="rspec3"

inherit ruby-fakegem

DESCRIPTION="A cite processor interface for Citation Style Language (CSL)"
HOMEPAGE="https://github.com/inukshuk/citeproc-ruby"
SRC_URI="https://github.com/inukshuk/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="AGPL-3 BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~riscv ~sparc ~x86"

ruby_add_rdepend ">=dev-ruby/citeproc-1.0 <dev-ruby/citeproc-3
	>=dev-ruby/csl-2.0"
