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
        helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
      };
    };
  };
}
