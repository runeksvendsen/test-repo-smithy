let
  nixpkgs =
    let
      src = builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/30d3d79b7d3607d56546dd2a6b49e156ba0ec634.tar.gz";
        sha256 = "0x5j9q1vi00c6kavnjlrwl3yy1xs60c34pkygm49dld2sgws7n0a";
      };
    in import src {};

  ifd1 = import ./ifd.nix { nonce = "1"; };
  ifd2 = import ./ifd.nix { nonce = "2"; };
  ifd3 = import ./ifd.nix { nonce = "3"; };
in
nixpkgs.stdenv.mkDerivation {
  name = "trivial-ifd-2";
  src = ./data;
  buildInputs = [
    ifd1
    ifd2
    ifd3
  ];
  installPhase = ''
    mkdir -p $out
    cp ${ifd1}/ifd.txt $out/ifd1.txt
    cp ${ifd2}/ifd.txt $out/ifd2.txt
    cp ${ifd3}/ifd.txt $out/ifd3.txt
  '';
}

