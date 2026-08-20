{ ... }:

{

  home-manager.users.roos = {
    home.stateVersion = "26.05";
    programs.git = {
      enable = false;
    };
  };
}