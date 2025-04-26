# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper xdg

DESCRIPTION="A free VoIP and video softphone based on the SIP protocol"
HOMEPAGE="https://linphone.org/"

SRC_URI="
	https://download.linphone.org/releases/linux/app/Linphone-${PV}.AppImage -> ${P}.AppImage
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
	app-arch/bzip2
	dev-libs/glib:2
	dev-libs/libxml2
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	media-libs/alsa-lib
	media-libs/mesa
	media-libs/opus
	media-video/pipewire[sound-server]
	net-libs/gnutls
	sys-libs/zlib
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libxcb
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/patchelf
"

QA_PREBUILT="*"
RESTRICT="strip"

src_unpack() {
	mkdir "${S}" || die
	cp "${DISTDIR}/${P}.AppImage" "${S}"/ || die
	pushd "${S}" || die
	chmod +x "${S}/${P}.AppImage" || die
	"${S}/${P}.AppImage" --appimage-extract || die
	rm "${S}/${P}.AppImage" || die
	popd || die
}

src_install() {
	# Remove AppImage files - not needed after extraction
	rm -f "${S}"/squashfs-root/{*.{AppImage,desktop},.DirIcon} || die

	# Install into /opt
	insinto /opt/"${PN}"
	doins -r "${S}"/squashfs-root/*

	# Set executable bit for the main binary
	chmod +x "${ED}/opt/${PN}/AppRun" || die
	fperms +x /opt/${PN}/AppRun

	# Create icon and desktop file
	newicon -s scalable "${S}"/squashfs-root/usr/share/icons/hicolor/scalable/apps/linphone.svg linphone.svg
	make_desktop_entry linphone "Linphone" linphone "Network;Telephony;" "MimeType=x-scheme-handler/sip;x-scheme-handler/sip-linphone;x-scheme-handler/tel;x-scheme-handler/callto;x-scheme-handler/linphone;"

	# Create wrapper
	make_wrapper linphone "/opt/${PN}/AppRun"
}
