let
  nixpkgs =
    let
      src = builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/30d3d79b7d3607d56546dd2a6b49e156ba0ec634.tar.gz";
        sha256 = "0x5j9q1vi00c6kavnjlrwl3yy1xs60c34pkygm49dld2sgws7n0a";
      };
    in import src {};
  lol = "pay no attention to this let-binding!!1";
in
nixpkgs.stdenv.mkDerivation {
  name = "test-repo-smithy";
  src = ./data;
  installPhase = ''
    mkdir -p $out
    cp data.bin $out/
  '';
}
