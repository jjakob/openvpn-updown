#!/bin/bash
#
# (c) Jernej Jakob <jernej.jakob@gmail.com> 2016-2019
#
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

echo "Adding resolvconf options for $dev:"

n=1
opt_n="foreign_option_$n"
while [[ -n ${!opt_n} ]]; do
        case ${!opt_n} in
                "dhcp-option DNS"*)
                        resolvconf_options="${resolvconf_options}nameserver ${!opt_n##dhcp-option DNS }\n"
		;;
                "dhcp-option DOMAIN"*)
			resolvconf_options="${resolvconf_options}domain ${!opt_n##dhcp-option DOMAIN }\n"
		;;
        esac
        let n=++n
        opt_n="foreign_option_$n"
done
echo -ne $resolvconf_options
echo -ne $resolvconf_options | resolvconf -a ${dev}.openvpn
e=$?
if [ $e == 0 ]; then
  echo "Success"
else
  echo "Failed! resolvconf exit status $e"
fi
