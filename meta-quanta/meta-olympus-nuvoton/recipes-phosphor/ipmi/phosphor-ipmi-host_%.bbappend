DEPENDS:append:olympus-nuvoton = " olympus-nuvoton-yaml-config"

EXTRA_OECONF:olympus-nuvoton = " \
    SENSOR_YAML_GEN=${STAGING_DIR_HOST}${datadir}/olympus-nuvoton-yaml-config/ipmi-sensors.yaml \
    FRU_YAML_GEN=${STAGING_DIR_HOST}${datadir}/olympus-nuvoton-yaml-config/ipmi-fru-read.yaml \
    "
