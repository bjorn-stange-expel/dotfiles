" reset to vim-defaults
if &compatible          " only if not set before:
  set nocompatible      " use vim-defaults instead of vi-defaults (easier, more user friendly)
endif

" Plugins

call plug#begin('~/.vim/plugged')

" Spacegray Theme
Plug 'https://github.com/ajh17/Spacegray.vim.git'

" Syntastic
Plug 'https://github.com/scrooloose/syntastic.git'

" Rust Plugin
Plug 'https://github.com/rust-lang/rust.vim.git'

" Go Plugin
Plug 'https://github.com/fatih/vim-go.git', { 'for': 'go' }

" Ruby Blocks are real
Plug 'https://github.com/nelstrom/vim-textobj-rubyblock.git', { 'for': 'ruby' }

" Terraform
Plug 'https://github.com/hashivim/vim-terraform.git', { 'for': 'tf' }

Plug 'https://github.com/tpope/vim-fugitive.git'

Plug 'https://github.com/vim-airline/vim-airline.git'

Plug 'https://github.com/kana/vim-textobj-user.git'

" TypeScript
Plug 'https://github.com/leafgarland/typescript-vim.git', { 'for': 'xml' }

" Only load this if running neovim
if has("nvim")
  " Deoplete
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

call plug#end()

" Javascript Syntax Checking with jshint
let g:syntastic_javascript_checkers = ['jshint']

" TypeScript Syntax Checking with tslint
let g:syntastic_typescript_checkers = ['tslint']

" Terraform format on write
let g:terraform_fmt_on_save = 1

" display settings
set t_Co=256
" colorscheme leo
colorscheme spacegray
set background=dark     " enable for dark terminals
set nowrap              " dont wrap lines
set scrolloff=2         " 2 lines above/below cursor when scrolling
set number              " show line numbers
set showmatch           " show matching bracket (briefly jump)
set showmode            " show mode in status bar (insert/replace/...)
set showcmd             " show typed command in status bar
set ruler               " show cursor position in status bar
set title               " show file in titlebar
set wildmenu            " completion with menu
set ls=2                " show filename at bottom

" editor settings
set esckeys             " map missed escape sequences (enables keypad keys)
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase characters
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
set autoindent
set smarttab            " smart tab handling for indenting
set magic               " change the way backslashes are used in search patterns
set bs=indent,eol,start " Allow backspacing over everything in insert mode

set tabstop=4           " number of spaces a tab counts for
set softtabstop=4
set shiftwidth=4        " spaces for autoindents
set expandtab           " turn a tabs into spaces

" misc settings
set fileformat=unix     " file mode is unix
"set fileformats=unix,dos    " only detect unix file format, displays that ^M with dos files

set viminfo='20,\"500   " remember copy registers after quitting in the .viminfo file -- 20 jump links, regs up to 500 lines'
set hidden              " remember undo after quitting
set history=50          " keep 50 lines of command history

" color settings (if terminal/gui supports it)
if &t_Co > 2 || has("gui_running")
syntax on          " enable colors
  set hlsearch       " highlight search (very useful!)
  set incsearch      " search incremently (search while typing)
endif

" paste mode toggle (needed when using autoindent/smartindent)
map <F10> :set paste<CR>
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>
highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /^\t\+/
match BadWhitespace /\s\+$/
map <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>i
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <Leader>g :s/\<<C-r><C-w>\>//g<Left><Left>
cmap w!! w !sudo tee % >/dev/null
cmap dsp %s/\s\+$//g

" window
nmap <leader>sw<left>  :topleft  vnew<CR>
nmap <leader>sw<right> :botright vnew<CR>
nmap <leader>sw<up>    :topleft  new<CR>
nmap <leader>sw<down>  :botright new<CR>
" buffer
nmap <leader>s<left>   :leftabove  vnew<CR>
nmap <leader>s<right>  :rightbelow vnew<CR>
nmap <leader>s<up>     :leftabove  new<CR>
nmap <leader>s<down>   :rightbelow new<CR>
" disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

syntax on

let @i = 'f{vi{>'
let @f = ':%s/^ \+//g:g/{\(.*}\)\@!/ norm @iggvi{>'
let @d = 'vi(>'
let @c = 'I// j'
let @b = 'I# j'
let @w = 'EBi"^[Ei<80>kr"^[EB'

" Make Backspaces Normal
set backspace=indent,eol,start

if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " ...
endif

runtime macros/matchit.vim "required for vim-textobj-rubyblock

let g:airline_powerline_fonts = 1

if has("nvim")
  " load deoplete
  let g:deoplete#enable_at_startup = 1
endif
