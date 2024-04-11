{ config, pkgs, ... }:

{
  # Ollama
  services.ollama = {
    enable = true;
    acceleration = "rocm"; # Or Cuda for Nvidia GPUs
    listenAddress = "127.0.0.1:11434";
  };
}
