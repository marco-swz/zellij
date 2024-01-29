{ pkgs, stdenv, runtimeShell }:
stdenv.mkDerivation rec {
    name = "zellijc";

    src = ./.;

    buildInputs = [ pkgs.zellij pkgs.makeWrapper ];

    binScript = ''
        #!${runtimeShell}
        ${pkgs.zellij}/bin/zellij --config-dir ${placeholder "out"}
    '';

    passAsFile = [ "binScript" ];

    installPhase = ''
        mkdir -p $out/bin
        cp -r ./config.kdl $out/
        cp $binScriptPath $out/bin/zellijc
        chmod +x $out/bin/zellijc
    '';

}
