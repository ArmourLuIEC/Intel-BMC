
SUMMARY = "Beep code manager service"
DESCRIPTION = "The beep code manager service will provide a method for beep code"

SRC_URI = "\
    file://CMakeLists.txt;subdir=${BP} \
    file://beepcode_mgr.cpp;subdir=${BP} \
    "
PV = "0.1"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${INTELBASE}/COPYING.apache-2.0;md5=34400b68072d710fecd0a2940a0d1658"

SYSTEMD_SERVICE:${PN} = "beepcode-mgr.service"

inherit cmake
inherit obmc-phosphor-systemd

DEPENDS += " \
            sdbusplus \
            phosphor-logging \
            boost \
           "
