{
  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
    };

    tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_AC = 0;
        CPU_BOOST_ON_BAT = 0;

        CPU_DRIVER_OPMODE_ON_AC = "active";
        CPU_DRIVER_OPMODE_ON_BAT = "active";

        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

        CPU_HWP_DYN_BOOST_ON_AC = 0;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;

        CPU_SCALING_MIN_FREQ_ON_AC = 400000;
        CPU_SCALING_MAX_FREQ_ON_AC = 3001000;
        CPU_SCALING_MIN_FREQ_ON_BAT = 400000;
        CPU_SCALING_MAX_FREQ_ON_BAT = 3001000;

        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        NATACPI_ENABLE = 1;

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };

    xserver.xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
  };
}
