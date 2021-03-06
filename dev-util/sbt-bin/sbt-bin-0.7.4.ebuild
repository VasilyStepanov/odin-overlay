# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


EAPI=3

DESCRIPTION="A build tool for Scala"
HOMEPAGE="http://code.google.com/p/simple-build-tool/"
SRC_URI="http://simple-build-tool.googlecode.com/files/sbt-launch-${PV}.jar -> sbt-launch-${PV}.jar"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=virtual/jdk-1.5"
RDEPEND="${DEPEND}"

src_unpack() {
	cp ${DISTDIR}/${A} ${WORKDIR}
}
src_install() {
	local dir="/usr/share/${P}"
	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}/${A}"
	dodir /usr/bin
	local sbt_bin="sbt"
	cat > "${D}/usr/bin/${sbt_bin}" <<-EOF
#!/bin/bash
JAVA_OPTS=""
ARGS=""
for i in "\$@";
do
if [[ \$i == -D* ]] ;
then JAVA_OPTS="\$JAVA_OPTS \$i"
else ARGS="\$ARGS \$i"
fi;
done
java -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256m -Xmx512M -Xss2M \$JAVA_OPTS -jar ${dir}/${A} \$ARGS
EOF
	fperms 755 /usr/bin/${sbt_bin}
}
