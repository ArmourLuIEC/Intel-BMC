DEPENDS:append:zaius = " zaius-yaml-config"

EXTRA_OECONF:zaius = " \
    YAML_GEN=${STAGING_DIR_HOST}${datadir}/zaius-yaml-config/ipmi-fru-read.yaml \
    PROP_YAML=${STAGING_DIR_HOST}${datadir}/zaius-yaml-config/ipmi-extra-properties.yaml \
    "
