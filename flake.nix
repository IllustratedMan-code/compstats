{
  description = "My Flake";
  inputs = { flake-utils.url = "github:numtide/flake-utils"; };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages."${system}";
      in {
        packages = rec { };
        devShells = rec {
          default = pkgs.mkShell {
            packages = with pkgs; [
              pandoc
              texlive.combined.scheme-full
              (rWrapper.override {
                packages = with rPackages; [
                  printr
                  LearnBayes
                  languageserver
                  rmarkdown
                  tidyverse
                  knitr
                  httpgd
                  revealjs
                  R2WinBUGS
                  batchmeans
                  DiffBind
                  profileplyr
                  caret
                  randomForest
                  ggpubr
                ];
              })
            ];
          };
        };
      });
}
