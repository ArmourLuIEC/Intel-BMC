
SUMMARY = "PCH BMC time service"
DESCRIPTION = "This service will read date/time from PCH device periodically, and set the BMC system time accordingly"

SRC_URI = "\
    file://CMakeLists.txt;subdir=${BP} \
    file://pch-time-sync.cpp;subdir=${BP} \
    "
PV = "0.1"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${INTELBASE}/COPYING.apache-2.0;md5=34400b68072d710fecd0a2940a0d1658"

SYSTEMD_SERVICE:${PN} = "pch-time-sync.service"

inherit cmake
inherit obmc-phosphor-systemd

DEPENDS += " \
            sdbusplus \
            phosphor-logging \
            boost \
            i2c-tools \
           "
