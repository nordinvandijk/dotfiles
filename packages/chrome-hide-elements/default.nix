{
  lib,
  runCommand,
  writeText,
  hideRules ? {},
}: let
  manifest = writeText "manifest.json" (builtins.toJSON {
    manifest_version = 3;
    name = "Hide elements (nix)";
    version = "1.1";
    permissions = ["storage"];
    background.service_worker = "background.js";
    action.default_title = "Toggle hide elements";
    content_scripts = [
      {
        matches = lib.concatMap (domain: ["*://${domain}/*" "*://*.${domain}/*"]) (lib.attrNames hideRules);
        js = ["rules.js" "content.js"];
        run_at = "document_start";
      }
    ];
  });

  rules = writeText "rules.js" "const rules = ${builtins.toJSON hideRules};\n";
in
  runCommand "chrome-hide-elements" {} ''
    mkdir $out
    cp ${manifest} $out/manifest.json
    cp ${rules} $out/rules.js
    cp ${./content.js} $out/content.js
    cp ${./background.js} $out/background.js
  ''
