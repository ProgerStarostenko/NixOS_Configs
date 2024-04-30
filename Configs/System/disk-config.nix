{
    disko.devices = {
        disk = {
            sda = {
                type = "disk";
                device = "/dev/sda";

                content = {
                    type = "gpt";

                    partitions = {
                        ESP = {
                            size = "500M";
                            type = "EF00";

                            content = {
                                type = "filesystem";
                                format = "vfat";
                                mountpoint = "/boot";
                            };
                        };

                        luks = {
                            size = "100%";

                            content = {
                                type = "luks";
                                name = "crypted_partition";
                                
                                settings.allowDiscards = true;
                                passwordFile = "/tmp/secret.key";

                                content = {
                                    type = "filesystem";
                                    format = "btrfs";
                                    extraArgs = [ "-f" ];

                                    subvolumes = {
                                        "/root" = {
                                            mountpoint = "/";
                                            mountOptions = [ "compress=zstd" "noatime"];
                                        };
                                        "/home" = {
                                            mountpoint = "/home";
                                            mountOptions = [ "compress=zstd" "noatime"];
                                        };
                                        "/nix" = {
                                            mountpoint = "/nix";
                                            mountOptions = [ "compress=zstd" "noatime" ];
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        };
    };
}