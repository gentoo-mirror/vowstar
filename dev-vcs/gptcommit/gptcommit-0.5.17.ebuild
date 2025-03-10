# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.5

EAPI=8

CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	ahash@0.7.8
	aho-corasick@1.1.3
	alloc-no-stdlib@2.0.4
	alloc-stdlib@0.2.2
	anstream@0.6.15
	anstyle-parse@0.2.5
	anstyle-query@1.1.1
	anstyle-wincon@3.0.4
	anstyle@1.0.8
	anyhow@1.0.89
	async-channel@1.9.0
	async-channel@2.3.1
	async-compression@0.4.14
	async-convert@1.0.0
	async-executor@1.13.1
	async-global-executor@2.4.1
	async-io@2.3.4
	async-lock@3.4.0
	async-openai@0.14.3
	async-std@1.13.0
	async-task@4.7.1
	async-trait@0.1.83
	atomic-waker@1.1.2
	autocfg@1.4.0
	backoff@0.4.0
	backtrace@0.3.74
	base64@0.13.1
	base64@0.21.7
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	bitflags@2.6.0
	block-buffer@0.10.4
	blocking@1.6.1
	brotli-decompressor@4.0.1
	brotli@7.0.0
	bstr@1.10.0
	bumpalo@3.16.0
	byteorder@1.5.0
	bytes@1.7.2
	cc@1.1.30
	cfg-if@1.0.0
	clap@4.5.20
	clap_builder@4.5.20
	clap_derive@4.5.18
	clap_lex@0.7.2
	colorchoice@1.0.2
	colored@2.1.0
	concurrent-queue@2.5.0
	config@0.13.4
	core-foundation-sys@0.8.7
	core-foundation@0.9.4
	cpufeatures@0.2.14
	crc32fast@1.4.2
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.20
	crypto-common@0.1.6
	darling@0.14.4
	darling_core@0.14.4
	darling_macro@0.14.4
	deranged@0.3.11
	derive_builder@0.12.0
	derive_builder_core@0.12.0
	derive_builder_macro@0.12.0
	digest@0.10.7
	dirs-sys@0.4.1
	dirs@5.0.1
	dlv-list@0.3.0
	either@1.13.0
	encoding_rs@0.8.34
	equivalent@1.0.1
	errno@0.3.9
	event-listener-strategy@0.5.2
	event-listener@2.5.3
	event-listener@5.3.1
	eventsource-stream@0.2.3
	fancy-regex@0.12.0
	fastrand@2.1.1
	flate2@1.0.34
	fnv@1.0.7
	form_urlencoded@1.2.1
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-lite@2.3.0
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-timer@3.0.3
	futures-util@0.3.31
	futures@0.3.31
	generic-array@0.14.7
	getrandom@0.2.15
	gimli@0.31.1
	globset@0.4.15
	globwalk@0.9.1
	gloo-timers@0.3.0
	h2@0.3.26
	hashbrown@0.12.3
	hashbrown@0.15.0
	heck@0.4.1
	heck@0.5.0
	hermit-abi@0.3.9
	hermit-abi@0.4.0
	home@0.5.9
	http-body@0.4.6
	http@0.2.12
	httparse@1.9.5
	httpdate@1.0.3
	hyper-rustls@0.24.2
	hyper@0.14.30
	ident_case@1.0.1
	idna@0.5.0
	ignore@0.4.23
	indexmap@2.6.0
	instant@0.1.13
	ipnet@2.10.1
	is_terminal_polyfill@1.70.1
	itoa@1.0.11
	js-sys@0.3.72
	json5@0.4.1
	kv-log-macro@1.0.7
	lazy_static@1.5.0
	libc@0.2.159
	libredox@0.1.3
	linked-hash-map@0.5.6
	linux-raw-sys@0.4.14
	lock_api@0.4.12
	log@0.4.22
	memchr@2.7.4
	mime@0.3.17
	mime_guess@2.0.5
	minimal-lexical@0.2.1
	miniz_oxide@0.8.0
	mio@1.0.2
	nom@7.1.3
	num-conv@0.1.0
	num_threads@0.1.7
	object@0.36.5
	once_cell@1.20.2
	openssl-probe@0.1.5
	option-ext@0.2.0
	ordered-multimap@0.4.3
	parking@2.2.1
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	pathdiff@0.2.2
	percent-encoding@2.3.1
	pest@2.7.13
	pest_derive@2.7.13
	pest_generator@2.7.13
	pest_meta@2.7.13
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	piper@0.2.4
	polling@3.7.3
	powerfmt@0.2.0
	ppv-lite86@0.2.20
	proc-macro2@1.0.87
	quote@1.0.37
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.5.7
	redox_users@0.4.6
	regex-automata@0.4.8
	regex-syntax@0.8.5
	regex@1.11.0
	reqwest-eventsource@0.4.0
	reqwest@0.11.27
	ring@0.17.8
	ron@0.7.1
	rust-ini@0.18.0
	rustc-demangle@0.1.24
	rustc-hash@1.1.0
	rustix@0.38.37
	rustls-native-certs@0.6.3
	rustls-pemfile@1.0.4
	rustls-webpki@0.101.7
	rustls@0.21.12
	rustversion@1.0.17
	ryu@1.0.18
	same-file@1.0.6
	schannel@0.1.26
	scopeguard@1.2.0
	sct@0.7.1
	security-framework-sys@2.12.0
	security-framework@2.11.1
	serde@1.0.210
	serde_derive@1.0.210
	serde_json@1.0.128
	serde_spanned@0.6.8
	serde_urlencoded@0.7.1
	sha2@0.10.8
	shlex@1.3.0
	signal-hook-registry@1.4.2
	simple_logger@4.3.3
	slab@0.4.9
	smallvec@1.13.2
	socket2@0.5.7
	spin@0.9.8
	strsim@0.10.0
	strsim@0.11.1
	strum@0.25.0
	strum_macros@0.25.3
	syn@1.0.109
	syn@2.0.79
	sync_wrapper@0.1.2
	system-configuration-sys@0.5.0
	system-configuration@0.5.1
	tera@1.20.0
	thiserror-impl@1.0.64
	thiserror@1.0.64
	tiktoken-rs@0.5.9
	time-core@0.1.2
	time-macros@0.2.18
	time@0.3.36
	tinyvec@1.8.0
	tinyvec_macros@0.1.1
	tokio-macros@2.4.0
	tokio-rustls@0.24.1
	tokio-socks@0.5.2
	tokio-stream@0.1.16
	tokio-util@0.7.12
	tokio@1.40.0
	toml@0.5.11
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.20.7
	toml_edit@0.22.22
	tower-service@0.3.3
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing@0.1.40
	try-lock@0.2.5
	typenum@1.17.0
	ucd-trie@0.1.7
	unic-char-property@0.9.0
	unic-char-range@0.9.0
	unic-common@0.9.0
	unic-segment@0.9.0
	unic-ucd-segment@0.9.0
	unic-ucd-version@0.9.0
	unicase@2.7.0
	unicode-bidi@0.3.17
	unicode-ident@1.0.13
	unicode-normalization@0.1.24
	untrusted@0.9.0
	url@2.5.2
	utf8parse@0.2.2
	value-bag@1.9.0
	version_check@0.9.5
	walkdir@2.5.0
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.95
	wasm-bindgen-futures@0.4.45
	wasm-bindgen-macro-support@0.2.95
	wasm-bindgen-macro@0.2.95
	wasm-bindgen-shared@0.2.95
	wasm-bindgen@0.2.95
	wasm-streams@0.4.1
	web-sys@0.3.72
	webpki-roots@0.25.4
	which@4.4.2
	winapi-util@0.1.9
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	winnow@0.5.40
	winnow@0.6.20
	winreg@0.50.0
	yaml-rust@0.4.5
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
"

inherit cargo

DESCRIPTION="A git prepare-commit-msg hook for summarizing commits with LLMs"
HOMEPAGE="https://github.com/zurawiki/gptcommit"
SRC_URI="
	https://github.com/zurawiki/${PN}/archive/v${PV}/${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD ISC MIT MPL-2.0 Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~loong ~riscv"

PATCHES=(
	"${FILESDIR}/${PN}-0.5.17-deepseek-fix.patch"
)

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"
