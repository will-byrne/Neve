{
  lib,
  config,
  ...
}:
{
  imports = [
    ./catppuccin.nix
  ];

  options = {
    colorschemes.enable = lib.mkEnableOption "Enable colorschemes module";
  };
  config = lib.mkIf config.colorschemes.enable {
    catppuccin.enable = lib.mkDefault true;
  };
}
