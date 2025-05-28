let
  okashi =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMgAse9mETOchcLsEwEwvQbQnXo+J+rHgyRSUrIUE24b";
in { "secrets/secrets.age".publicKeys = [ okashi ]; }

