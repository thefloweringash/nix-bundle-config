{ nixpkgs ? import <nixpkgs> {} }:

with nixpkgs;

let
  deps = import ./. { inherit nixpkgs; };

  inherit (deps) bundleConfig;
in

stdenv.mkDerivation ({
  name = "nix-bundle-config-shell";
  buildInputs = [ ruby bundler ];
  shellHook = ''
    nix-store --add-root $BUNDLE_PATH/.nix-gem-deps --indirect --realise ${bundleConfig.gemDepsGcRoot} > /dev/null

    echo "Setting gem path to $BUNDLE_PATH via bundle config" >&2
    echo "See https://github.com/rails/spring/issues/339" >&2
    bundle config --local path $BUNDLE_PATH
  '';
} // bundleConfig.envVars)
