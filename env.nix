{
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
  environment.variables = {
    TERMINAL = "kitty";
  };

}
