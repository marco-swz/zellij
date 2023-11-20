final: prev: {
    zellij-config = prev.stdenv.mkDerivation {
        name = "zellij-config";

        src = ./.;

        installPhase = ''
            mkdir -p $out
            cp -rv . $out/
        '';
    };

    zellij-configured = let 
        zellij-script = final.writeShellScriptBin "zellij" "${prev.zellij}/bin/zellij --config-dir ${final.zellij-config}";
    in final.stdenv.mkDerivation {

        name = "zellij-configured";

        src = ./.;

        installPhase = ''
            mkdir -p $out
        '';

        propagatedBuildInputs = [
            zellij-script
        ];

        buildInputs = [
            prev.zellij
        ];
    };
}
