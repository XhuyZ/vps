{ config, lib, pkgs, ... }:

let
  domain = "myhome"; # subdomain trên DuckDNS (không có .duckdns.org)
  token  = "your-duckdns-token"; # token DuckDNS
in
{
  systemd.services.duckdns-update = {
    description = "DuckDNS IP updater";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.curl}/bin/curl -s \"https://www.duckdns.org/update?domains=${domain}&token=${token}&ip=\"";
    };
  };

  systemd.timers.duckdns-update = {
    description = "Run DuckDNS updater every 5 minutes";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "5min";
      Unit = "duckdns-update.service";
    };
  };
}

