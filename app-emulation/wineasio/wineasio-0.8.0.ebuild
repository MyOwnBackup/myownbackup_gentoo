# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit multilib

DESCRIPTION="ASIO driver for WINE"
HOMEPAGE="http://sourceforge.net/projects/wineasio"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${P}/${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""
SLOT="0"

DEPEND="media-libs/asio-sdk"
RDEPEND=">=app-emulation/wine-0.9.35
	>=media-sound/jack-audio-connection-kit-0.117.0[32bit]"

S="${WORKDIR}/${PN}"

src_prepare() {
	cp /opt/asiosdk2.2/common/asio.h .
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	# need to be a bit tricky here
	local mylibdir="lib"
	use amd64 && mylibdir="lib32"

	exeinto /usr/${mylibdir}/wine
	doexe *.so
	dodoc README.TXT
}

pkg_postinst() {
	echo
	elog "You need to register the DLL by typing"
	elog
	elog "regsvr32 wineasio.dll"
	elog
	elog "AS THE USER who uses wine!"
	elog "Then open winecfg -> Audio -> and enable ONLY the ALSA driver!"
	echo
}
