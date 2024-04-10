{ config, pkgs, ... }:

{
  # Ollama
  services.ollama = {
    enable = true;
    acceleration = "rocm"; # Or Cuda for Nvidia GPUs
  };
}
