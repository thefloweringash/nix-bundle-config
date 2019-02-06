{ nixpkgs ? import <nixpkgs> {} }:

with nixpkgs;

let
  mkBundleConfig = callPackage ../mk-bundle-config.nix {};

  myGemConfig = {
    FFI = {
      dirConfigLibs = {
        ffi_c = libffi;
      };
    };
    PG = {
      dirConfigLibs = {
        pg = postgresql;
      };
    };
    NOKOGIRI = {
      dirConfigLibs = {
        inherit zlib;
      };
      pkgConfigLibs = [
        libxml2 libxslt
      ];
      extraFlags = [ "--use-system-libraries" ];
    };
  };

  bundleConfig = mkBundleConfig { gemConfig = myGemConfig; inherit ruby; };
in

rec {
  inherit bundleConfig;

  # nix-build -A bundleConfigFile -o .bundle/config
  # nix-build -A bashEnvFile -o env && source env
  inherit (bundleConfig) bundleConfigFile bashEnvFile;
}
