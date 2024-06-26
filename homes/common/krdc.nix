{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    kdePackages.krdc
  ];
}
