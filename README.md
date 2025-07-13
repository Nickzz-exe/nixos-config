#My NixOS configuration repo

##You can utilize my configuration files for non-commercial uses only


###Notes:
- hardware configuration must be re generated after pulling from repo!

## Immich setup
```bash
sudo chown -R root:media /mnt/hdd/photos
sudo chmod -R 770 /mnt/hdd/photos
```
-> find a way to implement this in configuration.nix

## Nuclearise Nextcloud

```bash
sudo rm -rf /var/lib/nextcloud
sudo -u postgres psql -c "DROP DATABASE nextcloud;"
sudo -u postgres psql -c "DROP ROLE nextcloud;"
```
