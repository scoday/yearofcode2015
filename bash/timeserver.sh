#!/bin/bash
#
# Use this to get a list of nameservers on HP networks:


asia() {
    host -T -t SRV _ldap._tcp.dc._msdcs.asiapacific.somecorp.net | awk '{print $8}' | perl -pe 's/.$//'
}

emea() {
    host -T -t SRV _ldap._tcp.dc._msdcs.emea.somecorp.net | awk '{print $8}' | perl -pe 's/.$//'
}

americas() {
    host -T -t SRV _ldap._tcp.dc._msdcs.americas.somecorp.net | awk '{print $8}' | perl -pe 's/.$//'
}

#asia
#emea
#americas

# Take an input:
    echo -n "Which area do you need timeservers for (asia / emea / americas)? "
      read answer
        if echo "$answer" | grep -iq "^as" ; then
            asia
        exit 2
        elif echo "$answer" | grep -iq "^am"; then
           americas
        exit 0
        else
           emea
        exit 1
      fi
