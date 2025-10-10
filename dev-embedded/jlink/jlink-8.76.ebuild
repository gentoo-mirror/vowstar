# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev wrapper

INSTALLDIR="/opt/${PN}"

DESCRIPTION="Tools for Segger J-Link JTAG adapters"
HOMEPAGE="https://www.segger.com/jlink-software.html"
SRC_URI="
	amd64? ( JLink_Linux_V${PV/./}_x86_64.tgz )
	arm? ( JLink_Linux_V${PV/./}_arm.tgz )
	arm64? ( JLink_Linux_V${PV/./}_arm64.tgz )
	x86? ( JLink_Linux_V${PV/./}_i386.tgz )
"
S="${WORKDIR}/JLink_Linux_V${PV/./}_x86_64"

LICENSE="SEGGER"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="udev"
QA_PREBUILT="*"

RESTRICT="fetch strip"
RDEPEND="
	media-libs/fontconfig
	media-libs/freetype
	sys-devel/gcc
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
"

pkg_nofetch() {
	einfo "Segger requires you to accept their license agreement before downloading."
	einfo "Download ${SRC_URI}"
	einfo "with your browser and place it in DISTDIR (usually /var/cache/distfiles/)"
	einfo "Please place the ${P} installation file ${SRC_URI}"
	einfo "in your \$\{DISTDIR\}."
}

src_install() {
	local bins=(
		DDConditionerExe
		DevProExe
		JFlashExe
		JFlashLiteExe
		JFlashSPI_CL
		JFlashSPICLExe
		JFlashSPIExe
		JLinkConfigExe
		JLinkExe
		JLinkGDBServer
		JLinkGDBServerCLExe
		JLinkGDBServerExe
		JLinkGUIServerExe
		JLinkLicenseManager
		JLinkLicenseManagerExe
		JLinkRegistration
		JLinkRegistrationExe
		JLinkRemoteServer
		JLinkRemoteServerCLExe
		JLinkRemoteServerExe
		JLinkRTTClient
		JLinkRTTClientExe
		JLinkRTTLogger
		JLinkRTTLoggerExe
		JLinkRTTViewerExe
		JLinkSTM32
		JLinkSTM32Exe
		JLinkSWOViewer
		JLinkSWOViewerCLExe
		JLinkSWOViewerExe
		JLinkUSBWebServerExe
		JLinkXVCDServerExe
		JMemExe
		JRunExe
		JTAGLoadExe
	)
	local wrapper
	for wrapper in "${bins[@]}"; do
		make_wrapper "${wrapper}" ./"${wrapper}" "${INSTALLDIR}"
	done

	exeinto "${INSTALLDIR}"
	doexe "${bins[@]}"

	insinto "${INSTALLDIR}"
	local libs=(
		libjlinkarm.so*
		libQtCore.so*
		libQtGui.so*
	)

	local lib
	for lib in "${libs[@]}"; do
		# Use doins for symlinks to avoid making unnecessary copies of the libs.
		if [[ -L "${lib}" ]]; then
			doins "${lib}"
		else
			doexe "${lib}"
		fi
	done

	doins -r \
		Doc \
		ETC \
		Firmwares \
		GDBServer \
		Samples \
		Script \
		README.txt

	if use udev ; then
		udev_dorules 99-jlink.rules
	fi
}

pkg_postinst() {
	if use udev ; then
		udev_reload
	fi
}

pkg_postrm() {
	if use udev ; then
		udev_reload
	fi
}
