let
  nixpkgs =
    let
      src = builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/30d3d79b7d3607d56546dd2a6b49e156ba0ec634.tar.gz";
        sha256 = "0x5j9q1vi00c6kavnjlrwl3yy1xs60c34pkygm49dld2sgws7n0a";
      };
    in import src {};

  ifd1 = import ./ifd.nix { nonce = "1"; buildInputs = [ ifd2 ]; };
  ifd2 = import ./ifd.nix { nonce = "2"; buildInputs = [ ifd3 ifd6 ]; };
  ifd3 = import ./ifd.nix { nonce = "3"; buildInputs = [ ifd6 ]; };

  ifd4 = import ./ifd.nix { nonce = "4"; buildInputs = [ ifd2 ifd5 ]; };
  ifd5 = import ./ifd.nix { nonce = "5"; buildInputs = [ ifd6 ]; };
  ifd6 = import ./ifd.nix { nonce = "6"; buildInputs = [ ]; };

in
nixpkgs.stdenv.mkDerivation {
  name = "trivial-ifd-2";
  src = ./data;
  buildInputs = [
    ifd1
    ifd4
    ifd6
  ];
  installPhase = ''
    mkdir -p $out
    cp ${ifd1}/ifd.txt $out/ifd1.txt
    cp ${ifd2}/ifd.txt $out/ifd2.txt
    cp ${ifd3}/ifd.txt $out/ifd3.txt
    cp ${ifd4}/ifd.txt $out/ifd4.txt
    cp ${ifd5}/ifd.txt $out/ifd5.txt
    cp ${ifd6}/ifd.txt $out/ifd6.txt
  '';
}

