FILESEXTRAPATHS:prepend:kudo := "${THISDIR}/${PN}:"
RDEPENDS:${PN}:append:kudo = " bash"

# Remove what installed by common recipe
OBMC_CONSOLE_HOST_TTY = ""
SYSTEMD_SUBSTITUTIONS:remove:kudo = " OBMC_CONSOLE_HOST_TTY:${OBMC_CONSOLE_HOST_TTY}:${PN}-ssh@.service"
SYSTEMD_SUBSTITUTIONS:remove:kudo = " OBMC_CONSOLE_HOST_TTY:${OBMC_CONSOLE_HOST_TTY}:${PN}-ssh.socket"

# Declare port spcific conf and service files
HOST_CONSOLE_TTY = "ttyS1 ttyS3"

CONSOLE_CONF_FMT = "file://server.{0}.conf"
SRC_URI:append:kudo = " ${@compose_list(d, 'CONSOLE_CONF_FMT', 'HOST_CONSOLE_TTY')}"
SRC_URI:append:kudo = " file://${BPN}@.service"
SRC_URI:append:kudo = " file://kudo_uart_mux_ctrl.sh"

SYSTEMD_SERVICE:${PN}:append:kudo = " \
        ${PN}@.service \
        "

do_install:append() {
    for i in ${HOST_CONSOLE_TTY}
    do
        install -m 0644 ${WORKDIR}/server.${i}.conf ${D}${sysconfdir}/${BPN}/server.${i}.conf
    done

    # Deal with files installed by the base package's .bb install function
    rm -f ${D}${sysconfdir}/${BPN}.conf
    rm -f ${D}${sysconfdir}/${BPN}/server.ttyVUART0.conf

    # Overwrite base package's obmc-console@.service with our own
    install -m 0644 ${WORKDIR}/${BPN}@.service ${D}${systemd_unitdir}/system/${BPN}@.service
    install -d ${D}/usr/sbin
    install -m 0755 ${WORKDIR}/kudo_uart_mux_ctrl.sh ${D}/${sbindir}/kudo_uart_mux_ctrl.sh

}

pkg_postinst:${PN}:append () {
    systemctl --root=$D enable obmc-console@ttyS1.service
    systemctl --root=$D enable obmc-console@ttyS3.service
}
