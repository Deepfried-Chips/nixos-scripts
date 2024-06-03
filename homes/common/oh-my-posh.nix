{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    oh-my-posh
  ];
}
