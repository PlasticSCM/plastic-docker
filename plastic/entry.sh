#! /bin/bash
set -e
for FILE in "users.conf" "groups.conf" "plasticd.lic" "loader.log.conf" "db.conf"; do
    if [ -f /confbase/$FILE ] && [ ! -e /conf/$FILE ]; then
        cp /confbase/$FILE /conf/$FILE
    fi
    if [ ! -e /opt/plasticscm5/server/$FILE ]; then
        ln -s /conf/$FILE /opt/plasticscm5/server/$FILE
    fi
done

# If and when that one is finally there.
if [ ! -e /opt/plasticscm5/server/plasticd.token.lic ]; then
    ln -s /conf/plasticd.token.lic /opt/plasticscm5/server/plasticd.token.lic
fi

# first boot?
if [ ! -f /conf/provisionned ]; then
    umtool cu root root
    umtool cg administrators
    umtool autg root administrators
    touch /conf/provisionned
fi

echo "Executing this: $@"
exec "$@"
