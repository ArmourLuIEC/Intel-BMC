SUMMARY = "Cryptographic library for Python"
DESCRIPTION = "PyCryptodome is a self-contained Python package of low-level\
 cryptographic primitives."
HOMEPAGE = "http://www.pycryptodome.org"
LICENSE = "PD & BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE.rst;md5=6dc0e2a13d2f25d6f123c434b761faba"

SRC_URI[md5sum] = "46ba513d95b6e323734074d960a7d57b"
SRC_URI[sha256sum] = "22d970cee5c096b9123415e183ae03702b2cd4d3ba3f0ced25c4e1aba3967167"

inherit pypi

RDEPENDS:${PN} += " \
    ${PYTHON_PN}-io \
    ${PYTHON_PN}-math \
"

RDEPENDS:${PN}-tests += " \
    ${PYTHON_PN}-unittest \
"

PACKAGES =+ "${PN}-tests"

FILES:${PN}-tests += " \
    ${PYTHON_SITEPACKAGES_DIR}/Cryptodome/SelfTest/ \
    ${PYTHON_SITEPACKAGES_DIR}/Cryptodome/SelfTest/__pycache__/ \
"
BBCLASSEXTEND = "native nativesdk"
