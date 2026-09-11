{ config, pkgs, ... }:

# Warning after a resinstallation be sure to launch one time
# sudo ssh -i /root/.ssh/id_ed25519 root@192.168.35.200

let
  backupScript = pkgs.writeShellScript "backup-home" ''
    set -euo pipefail

    export PATH=${pkgs.openssh}/bin:${pkgs.rsync}/bin:${pkgs.coreutils}/bin

    SRC="/home/csman"
    DEST="root@192.168.35.200:/media/disk1/share/csman/07-Sauvegardes/t14/"

    exec rsync \
      -aHAX \
      --delete \
      --numeric-ids \
      --compress \
      --info=progress2 \
      --exclude=".cache/" \
      --exclude="Downloads/" \
      --exclude=".local/share/Trash/" \
      --exclude="node_modules/" \
      --exclude="*.tmp" \
      --exclude="pCloudDrive/" \
      -e "ssh -i /root/.ssh/id_ed25519" \
      "$SRC" \
      "$DEST"
  '';
in
{
  environment.systemPackages = with pkgs; [
    rsync
  ];

  systemd.services.backup-home = {
    description = "Backup /home vers le NAS";

    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = backupScript;

      Nice = 10;
      IOSchedulingClass = "best-effort";
      IOSchedulingPriority = 7;
    };
  };

  systemd.timers.backup-home = {
    wantedBy = [ "timers.target" ];

    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "30min";
    };
  };
}