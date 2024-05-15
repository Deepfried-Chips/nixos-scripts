{
  pkgs,
  inputs,
  ...
}: {
  programs.git = {
    enable = true;
    extraConfig = {
      credential = {
        credentialStore = "gpg";
        helper = "/run/current-system/sw/bin/git-credential-manager"; #hopefully this fixes path shit
      };
    };
  };
}
