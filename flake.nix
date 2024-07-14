{
 inputs = { 
  nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  nix-functions = {
   url = "github:probablyrohan/nix-functions";
   inputs.nixpkgs.follows = "nixpkgs";
  };
 };
 outputs = inputs@{ self, nixpkgs, nix-functions }: 
 let
  pkgs = import nixpkgs { system = "x86_64-linux"; };
  lib = import ./lib/lib.nix { inherit pkgs inputs; };
 in {
  packages.x86_64-linux.scripts = import ./pkg/scripts.nix { inherit pkgs lib; };
  packages.x86_64-linux.mods = import ./pkg/mods.nix { inherit pkgs lib; };
  lib = lib;
  apps.x86_64-linux.fetch = { type = "app"; program = "${self.packages.x86_64-linux.scripts.fetchModrinthMods}/bin/fetch-modrinth.nu"; };
  apps.x86_64-linux.update = { type = "app"; program = "${self.packages.x86_64-linux.scripts.updateModrinthMods}/bin/update-modrinth.nu"; };
 };
}
