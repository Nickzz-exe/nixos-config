#!/usr/bin/env bash
	set -e
	pushd /etc/nixos/
	git add .
	sudo nixos-rebuild switch --flake /etc/nixos#leanas --show-trace
	generation=$(sudo nix-env -p /nix/var/nix/profiles/system --list-generations | grep current | awk '{print $1}')
		message="NixOS build #${generation}"

		read -rp "${message}: " commit_msg
		message="${message}: ${commit_msg}"

		git commit -m "${message}"
		echo -e "\n\n\033[32mCommitted as ${message}\033[0m"
	
