# Use the GRUB BIOS boot loader.

{ config, grubDevice, encryptedDisk }:

{
  # Install GRUB to `grubDevice`, optionally with encryption enabled based on `encryptedDisk`.
  boot.loader.grub = {
    enable = true;
    device = grubDevice;
    enableCryptodisk = encryptedDisk;
  };
  boot.loader.timeout = 3;

}
