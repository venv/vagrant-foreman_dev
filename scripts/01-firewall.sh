#! /bin/bash
# firewall provisioning
firewall-cmd --permanent --zone=public --add-port=3000/tcp
firewall-cmd --reload
