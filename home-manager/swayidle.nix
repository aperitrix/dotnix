{ pkgs, ... }:
{
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300; # 5 minutes, en secondes
        command = "${pkgs.noctalia-shell}/bin/noctalia-shell ipc call lockScreen toggle";
      }
      # éteindre les écrans un peu après le verrouillage
      {
        timeout = 600;
        command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
      }
    ];

    events = [
      {
        event = "before-sleep";
        command = "${pkgs.noctalia-shell}/bin/noctalia-shell ipc call lockScreen toggle";
      }
    ];
  };
}
