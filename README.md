# nix-bundle-config

`nix-bundle-config` is an integration between [bundler][] and the [nix
package manager][nix] aimed at developers and development environments
that configures bundler to use dependencies from nix.

[bundler]: https://bundler.io/
[nix]: https://nixos.org/nix/

# Usage

The current recommendation is to copy the file `mk-bundle-config.nix`
from this project into your project, and integrate it as shown in the
example project in `example/`.

## Compared to bundix

This trades the robustness guarantees of [bundix][] for the ability to
use bundler to install gems. This is particularly useful if you need
git type dependencies, as bundler git sources must be entire
repositories, and [canonicalising a git repository is
hard][#46739]. Notably this does not permit patching gems during
installation, and is thus strictly less powerful.

[bundix]: https://github.com/manveru/bundix
[#46739]: https://github.com/NixOS/nixpkgs/pull/46739

