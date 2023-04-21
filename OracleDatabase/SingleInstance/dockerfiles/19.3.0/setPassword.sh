#!/bin/bash
# LICENSE UPL 1.0
#
# Copyright (c) 1982-2022 Oracle and/or its affiliates. All rights reserved.
# 
# Since: November, 2016
# Author: gerald.venzl@oracle.com
# Description: Sets the password for sys, system and pdb_admin
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
# 

if [ -e "${ORACLE_BASE}/oradata/${ORACLE_SID}/.prebuiltdb" ] && [ -n "${ORACLE_PWD}" ] && [ "${ORACLE_PWD}" != "$1" ]; then
      echo "WARNING: The database password can not be changed for this container having a prebuilt database. The original password exists in the container environment. Your new password has been ignored!"
      exit 1
fi

ORACLE_PWD=$1
ORACLE_SID="$(grep "$ORACLE_HOME" /etc/oratab | cut -d: -f1)"
ORAENV_ASK=NO
source oraenv

sqlplus / as sysdba << EOF
      ALTER USER SYS IDENTIFIED BY "$ORACLE_PWD";
      ALTER USER SYSTEM IDENTIFIED BY "$ORACLE_PWD";
      exit;
EOF

