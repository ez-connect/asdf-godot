# asdf-godot [![Build](https://github.com/ez-connect/asdf-godot/actions/workflows/build.yml/badge.svg)](https://github.com/ez-connect/asdf-godot/actions/workflows/build.yml) [![Lint](https://github.com/ez-connect/asdf-godot/actions/workflows/lint.yml/badge.svg)](https://github.com/ez-connect/asdf-godot/actions/workflows/lint.yml)

[godot](https://godotengine.org) plugin for the [asdf version manager](https://asdf-vm.com).

## Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

## Dependencies

- `bash`, `curl`, `unzip`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

## Install

### Plugin

```sh
asdf plugin add godot
# or
asdf plugin add godot https://github.com/ez-connect/asdf-godot.git
```

### Godot

```sh
# Show all installable versions
asdf list-all godot

# Install specific version
asdf install godot latest

# Set a version globally (on your ~/.tool-versions file)
asdf global godot latest

# Now godot commands are available
godot --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/ez-connect/asdf-godot/graphs/contributors)!

# License

See [LICENSE](LICENSE)
