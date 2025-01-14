#!/usr/bin/env bash

set -euo pipefail

GH_REPO_GODOT='https://github.com/godotengine/godot-builds'
GH_REPO_REDOT='https://github.com/Redot-Engine/redot-engine'
ASDF_GODOT_INSTALL_MONO='0' #HACK: for some reason this bash script doesn't like unbound vars

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

get_redot_release_name() {
	local version=$1
	local platform=$2
	local arch=$3
	local mono=$4

	redot_version=$(echo "$version" | sed 's/redot-\(.*\)/\1/')
	if [ "${platform}" == 'darwin' ]; then
		echo "Redot_v${redot_version}_${mono}macos"
		exit 0
	fi
	echo "Redot_v${version}_${mono}${platform}.${arch}"
}

get_release_file_name() {
	local version="$1"
	local tool_name="$2"

	platform=$(uname | tr '[:upper:]' '[:lower:]')
	arch=$(uname -m)
	mono=
	if [[ "$ASDF_GODOT_INSTALL_MONO" != "0" ]]; then
		mono="mono_"
	fi

	if [ "$tool_name" == "redot" ]; then
		get_redot_release_name "$version" "$platform" "$arch" "$mono"
		exit 0
	fi

	if [ "${platform}" == 'darwin' ]; then
		echo "Godot_v${version}_${mono}macos.universal"
		exit 0
	fi

	echo "Godot_v${version}_${mono}${platform}.${arch}"
}

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_all_versions() {
	local repo="$1"
	local tool_name="$2"

	sed_command='s/^v//; /2024101114/d'
	if [[ "$tool_name" == "redot" ]]; then 
		sed_command='s/^v//; /godot/d; /2024101114/d'
	fi
	git ls-remote --tags --refs "$repo" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed "$sed_command" # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

download_release() {
	local tool_name repo version filename url
	tool_name="$1"
	repo="$2"
	version="$3"
	filename="$4"

	url="$repo/releases/download/${version}/$(get_release_file_name "${version}" "${tool_name}").zip"
	echo "$url"
	echo "* Downloading $tool_name release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local tool_name="$1"
	local install_type="$2"
	local version="$3"
	local install_path="${4%/bin}/bin"

	echo "$install_type"
	if [ "$install_type" != "version" ]; then
		fail "asdf-$tool_name supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(echo "${tool_name} --help" | cut -d' ' -f1)"
		platform=$(uname | tr '[:upper:]' '[:lower:]')

		mono=
		if [[ "$ASDF_GODOT_INSTALL_MONO" != "0" ]]; then
			mono="_mono"
		fi

		app_path=

		if [ "$tool_name" == "redot" ]; then
			app_path="${install_path}/Redot.app/Contents/MacOS/Redot"
		else
			app_path="${install_path}/Godot.app/Contents/MacOS/Godot"
		fi

		if [ "${platform}" == "darwin" ]; then
			ln -s "$app_path" "$install_path/${tool_cmd}"
		fi

		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$tool_name $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $tool_name $version."
	)
}
