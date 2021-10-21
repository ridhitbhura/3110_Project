# Prison Dash - Installation and Game Initialization

# Dependencies

## For Mac:

### 0. Install [Homebrew](https://brew.sh/) if it is not already installed using installiation instructions found on its website.

### 1. Install the [Graphics Library](https://github.com/ocaml/graphics).

1. Install [XQuartz](https://www.xquartz.org/)
2. `brew install pkg-config`
3. `opam install graphics`

### 2. Install an image processing library. We use [camlimages](https://www.google.com/url?q=https://gitlab.com/camlspotter/camlimages&sa=D&source=editors&ust=1617134969939000&usg=AOvVaw3al_S_FsgYZIQaoyCdh0Bz) to render images in OCaml. In order to install this, install libpng and libjpg first.

1. `brew install libpng`
2. `brew install libjpg`
3. `opam install camlimages`


## For Windows:

### 1. Install the [Graphics Library](https://github.com/ocaml/graphics).

1. Install [Xming](https://sourceforge.net/projects/xming/)
2. `sudo apt install pkg-config`
3. `opam install graphics`

### 2. Install an image processing library. We use [camlimages](https://www.google.com/url?q=https://gitlab.com/camlspotter/camlimages&sa=D&source=editors&ust=1617134969939000&usg=AOvVaw3al_S_FsgYZIQaoyCdh0Bz) to render images in OCaml. In order to install this, install libpng and libjpg first.
 
1. `sudo apt install libpng-dev libjpeg-dev`
2. `opam install camlimages`


# Initialization

### Run the following commands to start the game

`make build`
`make play`

    
