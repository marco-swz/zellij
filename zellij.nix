{ pkgs, stdenv }:
let 
    zellij-configured = pkgs.writeShellScriptBin "ze" ''
        ${pkgs.zellij}/bin/zellij --config-dir $out
    '';
    
in stdenv.mkDerivation {
    name = "zellij-configured";

    src = ./.;

    buildInputs = [ zellij-configured ];

    installPhase = ''
        mkdir -p $out
        cp -r ./config.kdl $out/
        ln -s ${zellij-configured}/bin/ze $out/bin
    '';
}
