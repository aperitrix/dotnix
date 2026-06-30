{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = [
        {
          monitor = "";
          path = "~/wallpapers/wallpaper.jpg";
        }
      ];
    };
  };
}
