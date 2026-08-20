{ ... }:

{
  users.users.r0.extraGroups = [ "wheel" ];
  home-manager.users.r0 = {
    home.stateVersion = "26.05";
    programs.git = {
      enable = true;
    };
  };
}