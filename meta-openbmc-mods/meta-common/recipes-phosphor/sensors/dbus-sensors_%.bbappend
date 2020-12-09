FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
PROJECT_SRC_DIR := "${THISDIR}/${PN}"

SRCREV = "3bcd823e3783bc49c1e75dec2d43a3ef54333c88"
#SRC_URI = "git://github.com/openbmc/dbus-sensors.git"

SRC_URI += "\
    file://intrusionsensor-depend-on-networkd.conf \
    "

DEPENDS_append = " libgpiod libmctp"

PACKAGECONFIG += " \
    adcsensor \
    cpusensor \
    exitairtempsensor \
    fansensor \
    hwmontempsensor \
    intrusionsensor \
    ipmbsensor \
    mcutempsensor \
    psusensor \
"

PACKAGECONFIG[nvmesensor] = "-DDISABLE_NVME=OFF, -DDISABLE_NVME=ON"

SYSTEMD_SERVICE_${PN} += "${@bb.utils.contains('PACKAGECONFIG', 'nvmesensor', \
                                               'xyz.openbmc_project.nvmesensor.service', \
                                               '', d)}"

PACKAGECONFIG_remove = "nvmesensor"

do_install_append() {
    svc="xyz.openbmc_project.intrusionsensor.service"
    srcf="${WORKDIR}/intrusionsensor-depend-on-networkd.conf"
    dstf="${D}/etc/systemd/system/${svc}.d/10-depend-on-networkd.conf"
    mkdir -p "${D}/etc/systemd/system/${svc}.d"
    install "${srcf}" "${dstf}"
}
