#!/bin/bash

# Banner:
echo "                                                -------- STARTING INSTALL_GOLANG.SH"

# Some globals:
version_req=$(curl -sSL "https://golang.org/dl/?mode=json")
# Following line: grep -o: "only output the matched part of the line rather than entire line"
#               : -P: "Perl-compatible regular expressions (adv. reg ex)"
#               : '(?<="version": ") positive look-behind assertion matching the substring but doesn't include
#                   it in the final match
#               : '[^"]+' matches one of more characters which aren't double quotes
current_go_version=$(echo "$version_req" | grep -oP '(?<="version": ")[^"]+' | head -n 1)

check_for_go(){}

install_go(){}

extract_tarball(){

}

update_environment(){

}

clean_up(){}
