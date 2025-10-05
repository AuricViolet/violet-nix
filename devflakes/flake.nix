{
  description = "C# + Avalonia DevShell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            android_sdk.accept_license = true;
          };
        };

        dotnetSdk = pkgs.dotnetCorePackages.sdk_9_0;

        # Native dependencies required for Avalonia + SkiaSharp
        nativeLibs = with pkgs; [
          fontconfig
          freetype
          expat
          zlib
          libpng
          libjpeg
          libGL
          wasm-tools
          vulkan-loader
          xorg.libX11
          xorg.libSM
          xorg.libXcursor
          xorg.libXrandr
          xorg.libXinerama
          xorg.libXi
          xorg.libXext
          xorg.libXrender
          xorg.libXtst
          xorg.libICE
          glib
          gtk3
          pango
          cairo
          jdk
          android-tools
        ];
      in {
        devShell = pkgs.mkShell {
          name = "csharp-avalonia-shell";

          buildInputs = [ dotnetSdk pkgs.git ] ++ nativeLibs;

          shellHook = ''
            # Set up .NET SDK
            export DOTNET_ROOT=${dotnetSdk}
            export PATH=$DOTNET_ROOT:$PATH

            # Ensure Avalonia + SkiaSharp native libs are visible
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath nativeLibs}:$LD_LIBRARY_PATH
          '';
        };
      });
}
