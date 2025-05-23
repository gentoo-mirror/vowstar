# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 java-pkg-2 multiprocessing

DESCRIPTION="Fast and correct automated build system"
HOMEPAGE="https://bazel.build/"

SRC_URI="https://github.com/bazelbuild/bazel/releases/download/${PV}/${P}-dist.zip"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="examples tools"
# strip corrupts the bazel binary
# test fails with network-sandbox: An error occurred during the fetch of repository 'io_bazel_skydoc' (bug 690794)
RESTRICT="strip test"
RDEPEND=">=virtual/jre-1.8:*"
DEPEND="
	|| (
	   virtual/jdk:1.8
	   virtual/jdk:11
	)
	app-arch/unzip
	app-arch/zip"

bazel-get-flags() {
	local i fs=()
	for i in ${CFLAGS}; do
		fs+=( "--copt=${i}" "--host_copt=${i}" )
	done
	for i in ${CXXFLAGS}; do
		fs+=( "--cxxopt=${i}" "--host_cxxopt=${i}" )
	done
	for i in ${CPPFLAGS}; do
		fs+=( "--copt=${i}" "--host_copt=${i}" )
		fs+=( "--cxxopt=${i}" "--host_cxxopt=${i}" )
	done
	for i in ${LDFLAGS}; do
		fs+=( "--linkopt=${i}" "--host_linkopt=${i}" )
	done
	echo "${fs[*]}"
}

pkg_setup() {
	if has ccache ${FEATURES}; then
		ewarn "${PN} usually fails to compile with ccache, you have been warned"
	fi
	java-pkg-2_pkg_setup
}

src_unpack() {
	# Only unpack the main distfile
	unpack ${P}-dist.zip
}

src_prepare() {
	default

	# F: fopen_wr
	# S: deny
	# P: /proc/self/setgroups
	# A: /proc/self/setgroups
	# R: /proc/24939/setgroups
	# C: /usr/lib/systemd/systemd
	addpredict /proc

	eapply "${FILESDIR}/${PN}-3.2.0-include-limits-for-gcc-11.patch"
	eapply "${FILESDIR}/${PN}-3.7.2-musl-temp-failure-retry.patch"
}

src_compile() {
	export EXTRA_BAZEL_ARGS="--jobs=$(makeopts_jobs) $(bazel-get-flags) --host_javabase=@local_jdk//:jdk"
	VERBOSE=yes ./compile.sh || die

	./scripts/generate_bash_completion.sh \
		--bazel=output/bazel \
		--output=bazel-complete.bash \
		--prepend=scripts/bazel-complete-header.bash \
		--prepend=scripts/bazel-complete-template.bash
}

src_test() {
	output/bazel test \
		--verbose_failures \
		--spawn_strategy=standalone \
		--genrule_strategy=standalone \
		--verbose_test_summary \
		examples/cpp:hello-success_test || die
	output/bazel shutdown
}

src_install() {
	dobin output/bazel
	newbashcomp bazel-complete.bash ${PN}
	bashcomp_alias ${PN} ibazel
	insinto /usr/share/zsh/site-functions
	doins scripts/zsh_completion/_bazel

	if use examples; then
		docinto examples
		dodoc -r examples/*
		docompress -x /usr/share/doc/${PF}/examples
	fi
	# could really build tools but I don't know which ones
	# are actually used
	if use tools; then
		docinto tools
		dodoc -r tools/*
		docompress -x /usr/share/doc/${PF}/tools
		docompress -x /usr/share/doc/${PF}/tools/build_defs/pkg/testdata
	fi
}
