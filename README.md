# asdf-godot

[godot](https://godotengine.org) and redot [redot](https://www.redotengine.org/) plugin based from [ez-connect/asdf-godot](https://github.com/ez-connect/asdf-godot) repo for the [asdf version manager](https://asdf-vm.com).
Credit also to [asdf-hashicorp](https://github.com/asdf-community/asdf-hashicorp) plugin for inspiration for how to do multiple plugins in one repo
## Contents

- [asdf-godot](#asdf-godot)
  - [Contents](#contents)
  - [Dependencies](#dependencies)
  - [Install](#install)
    - [Plugin](#plugin)
    - [Godot](#godot)
    - [Redot](#redot)
    - [Dotnet/Mono support](#dotnetmono-support)
- [Contributing](#contributing)
- [License](#license)

## Dependencies

- `bash`, `curl`, `unzip`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

## Install

### Plugin

```sh
asdf plugin add godot https://github.com/mrllama123/asdf-godot
```

### Godot
```sh
# Show all installable versions
asdf list-all godot

# Install specific version 
asdf install godot 4.3-stable

# Set a version globally (on your ~/.tool-versions file)
asdf global godot 4.3-stable


# Now godot commands are available
godot --help
```

### Redot
```sh
# Show all installable versions
asdf list-all redot

# Install specific version 
asdf install redot redot-4.3-stable

# Set a version globally (on your ~/.tool-versions file)
asdf global redot redot-4.3-stable


# Now redot commands are available
redot --help
```

### Dotnet/Mono support

You can also install mono version for redot or godot vai adding env var: `ASDF_GODOT_INSTALL_MONO=1` i.e:

```sh
#godot
ASDF_GODOT_INSTALL_MONO=1 asdf install godot 4.3-stable
```

```sh
#redot
ASDF_GODOT_INSTALL_MONO=1 asdf install redot redot-4.3-stable
```


Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/ez-connect/asdf-godot/graphs/contributors)!

# License

See [LICENSE](LICENSE)
