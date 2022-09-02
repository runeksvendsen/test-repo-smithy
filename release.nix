let
  nixpkgs =
    let dir = dep/nixpkgs-30d3d79b7d3607d56546dd2a6b49e156ba0ec634;
    in import dir {};
in
nixpkgs.stdenv.mkDerivation {
  name = "test-repo-smithy";
  src = ./data;
  allowSubstitutes = false; # disable fetch from cache
  installPhase = ''
    mkdir -p $out
    cp data.bin $out/
  '';
}
