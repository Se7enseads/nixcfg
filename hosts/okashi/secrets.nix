{ username, ... }:

{
  age = {
    secrets = {
      secrets = {
        file = ../../secrets/secrets.age;
        owner = "${username}";
      };
    };
  };
}
