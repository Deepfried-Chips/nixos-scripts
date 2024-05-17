{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    brave
  ];
}
