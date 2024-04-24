{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    vscode
    codeql
  ];
}
