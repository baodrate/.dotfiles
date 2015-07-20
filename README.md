# qubidt's dotfiles

## dotbot

My dotfiles currently use 
[anishathalye's very convenient dotbot tool](https://github.com/anishathalye/dotbot) 
to handled the sym-linking of the config files.

Run `install.sh` to form the links in your home-directory.
(This is highly *not* recommended for anyone but me.
Feel free to grep through and grab whatever you like, but
my defaults probably don't make sense for you.)

## vim
Using 
[junegunn's vim-plug](https://github.com/junegunn/vim-plug)
for plugin management.

### colorschemes
Most of these require gvim/256-colors terminal support
[vim-colors-solarized](https://github.com/altercation/vim-colors-solarized)
[seoul256.vim](https://github.com/junegunn/seoul256.vim)
[vim-hybrid](https://github.com/w0ng/vim-hybrid)
[Zenburn](https://github.com/jnurmine/Zenburn)
 - GOAT

### interface
[lightline.vim](https://github.com/itchyny/lightline.vim)
 - for that pretty statusbar

### tools
[vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors)
 - SOOOOO useful
[ctrlp.vim](https://github.com/kien/ctrlp.vim)
 - fuzzy file loader
[YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
 - code completion and syntax checking
[Conque-Shell](https://github.com/jewes/Conque-Shell)

### utilities
[vimwiki](https://github.com/vimwiki/vimwiki)

### code
[DoxygenToolkit.vim](https://github.com/vim-scripts/DoxygenToolkit.vim)
 - Use `:Dox` to generate doxygen outline
[rhysd/vim-clang-format](https://github.com/rhysd/vim-clang-format)
 - not currently in use
[tagbar](https://github.com/majutsushi/tagbar)
 - for that 
[vim-easytags](https://github.com/xolox/vim-easytags)
 * [vim-misc](https://github.com/xolox/vim-misc) (required)

### syntax
[neomake](https://github.com/benekastah/neomake)
 - currently only used when in neovim
[syntastic](https://github.com/scrooloose/syntastic)
