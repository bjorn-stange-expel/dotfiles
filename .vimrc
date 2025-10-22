" reset to vim-defaults
if &compatible          " only if not set before:
  set nocompatible      " use vim-defaults instead of vi-defaults (easier, more user friendly)
endif

" Plugins

call plug#begin('~/.vim/plugged')

" Afterglow Theme
Plug 'https://github.com/danilo-augusto/vim-afterglow.git'

" ALE
Plug 'https://github.com/w0rp/ale.git'

" Instant Markdown
" Plug 'https://github.com/suan/vim-instant-markdown.git'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install'}

" Surround
Plug 'https://github.com/tpope/vim-surround.git'

" Rust Plugin
Plug 'https://github.com/rust-lang/rust.vim.git', { 'for': 'rust' }

" Go Plugin
Plug 'https://github.com/fatih/vim-go.git', { 'for': 'go', 'do': ':GoUpdateBinaries' }

" Ruby Blocks are real
Plug 'https://github.com/nelstrom/vim-textobj-rubyblock.git', { 'for': 'ruby' }

" Terraform
Plug 'https://github.com/hashivim/vim-terraform.git', { 'for': 'terraform' }

Plug 'https://github.com/tpope/vim-fugitive.git'

" Plug 'https://github.com/vim-airline/vim-airline.git'

" Plug 'feline-nvim/feline.nvim'

Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }

Plug 'https://github.com/kana/vim-textobj-user.git'

" resize-splits
Plug 'justincampbell/vim-eighties'

" TypeScript
Plug 'https://github.com/leafgarland/typescript-vim.git', { 'for': 'typescript' }

" YAML
Plug 'https://github.com/chase/vim-ansible-yaml.git', { 'for': 'yaml' }

" Easy Align
Plug 'junegunn/vim-easy-align'

" vim-hcl
Plug 'https://github.com/jvirtanen/vim-hcl.git'

" jsonnet
Plug 'google/vim-jsonnet'

" jinja2
Plug 'https://github.com/Glench/Vim-Jinja2-Syntax.git'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" AI
" Plug 'Exafunction/windsurf.vim', { 'branch': 'main' }

Plug 'nvim-lua/plenary.nvim'
Plug 'greggh/claude-code.nvim'
" After installing, add this to your init.vim:

Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'main' }
Plug 'phelipetls/jsonpath.nvim', { 'branch': 'main' }

" Only load this if running neovim
" if has("nvim")
"   " Deoplete
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" endif
call plug#end()

colorscheme afterglow


" Javascript Syntax Checking with jshint
" let g:syntastic_javascript_checkers = ['jshint']

" TypeScript Syntax Checking with tslint
" let g:syntastic_typescript_checkers = ['tslint']

" Terraform format on write
let g:terraform_fmt_on_save = 1

let g:ale_terraform_tflint_executable = "~/bin/tflint"

" Ignore max line length check for python
let g:ale_python_flake8_options = "--ignore=E501"

" vim-eighties
let g:eighties_enabled = 1
let g:eighties_minimum_width = 80
let g:eighties_extra_width = 0 " Increase this if you want some extra room
let g:eighties_compute = 1 " Disable this if you just want the minimum + extra

set colorcolumn=100

" display settings
set t_Co=256
set background=dark     " enable for dark terminals
set nowrap              " dont wrap lines
set scrolloff=2         " 2 lines above/below cursor when scrolling
set number              " show line numbers
" set relativenumber      " show relative line numbers
set showmatch           " show matching bracket (briefly jump)
set showmode            " show mode in status bar (insert/replace/...)
set showcmd             " show typed command in status bar
set ruler               " show cursor position in status bar
set title               " show file in titlebar
set wildmenu            " completion with menu
set ls=2                " show filename at bottom

set termguicolors

set cursorline
highlight clear CursorLine
highligh CursorLineNR ctermfg=148

" editor settings
" set esckeys             " map missed escape sequences (enables keypad keys)
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase characters
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
set autoindent
set smarttab            " smart tab handling for indenting
set magic               " change the way backslashes are used in search patterns
set bs=indent,eol,start " Allow backspacing over everything in insert mode

set tabstop=2           " number of spaces a tab counts for
set softtabstop=2
set shiftwidth=2        " spaces for autoindents
set expandtab           " Use spaces not tabs

" misc settings
set fileformat=unix     " file mode is unix
"set fileformats=unix,dos    " only detect unix file format, displays that ^M with dos files

set viminfo='20,\"500   " remember copy registers after quitting in the .viminfo file -- 20 jump links, regs up to 500 lines'
set hidden              " remember undo after quitting
set history=50          " keep 50 lines of command history

" Disable mouse
set mouse=

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
" set pastetoggle=<F11>
map <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>i
cmap w!! w !sudo tee % >/dev/null
cmap dsp %s/\s\+$//g

" open file with fzf
nmap <leader>f :Files<CR>

" search with ripgrep
nmap <leader>s :Rg <C-r><C-w><CR>

" git co-author lines
nmap <leader>ga oCo-authored-by: Adam Glenn <adam.glenn@expel.io><esc>
nmap <leader>gdo oCo-authored-by: Doug McCall <doug.mccall@expel.io><esc>
nmap <leader>get oCo-authored-by: Ethan Miller <ethan.miller@expel.io><esc>
nmap <leader>gj oCo-authored-by: Jesse Rhodes <jesse.rhodes@expel.io><esc>
nmap <leader>gp oCo-authored-by: Peter Herndon <peter.herndon@expel.io><esc>
nmap <leader>gro oCo-authored-by: Robert Kernick <robert.kernick@expel.com><esc>
nmap <leader>gcu oCo-authored-by: Char Custodio <char.custodio@expel.io><esc>
nmap <leader>gk oCo-authored-by: Keith Grant <keith.grant@expel.io><esc>
nmap <leader>gbl oCo-authored-by: Brian Leung <brian.leung@expel.com><esc>
nmap <leader>gry oCo-authored-by: Ryan White <ryan.white@expel.com><esc>
nmap <leader>gbf oCo-authored-by: Bryce Frazier <bryce.frazier@expel.com><esc>
nmap <leader>map imig7GMC9ANK62<esc>

nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt
nmap <leader>0 0gt

" Jump to next linting error
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Git specific configuration
let git_path = system("git rev-parse --show-toplevel 2>/dev/null")
let git_vimrc = substitute(git_path, '\n', '', '') . "/.vimrc"
if !empty(glob(git_vimrc))
  sandbox exec ":source " . git_vimrc
endif

syntax on

let @i = 'ofluxcd.io/ignore: "true"'
let @f = ':%s/^ \+//g:g/{\(.*}\)\@!/ norm @iggvi{>'
let @d = 'vi(>'
let @c = 'I// j'
let @b = 'I# j'
let @w = 'EBi"^[Ei<80>kr"^[EB'
let @r = "0100lBi\<BS>\<CR>\"

let @g = 'oCo-authored-by: Jesse Rhodes <jesse.rhodes@expel.io>'

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
" if has("nvim")
"   " load deoplete
"   let g:deoplete#enable_at_startup = 1
"   let g:deoplete#enable_refresh_always = 1
" endif


" Load project specific vimrc files
set exrc
set secure

highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /^\t\+/
match BadWhitespace /\s\+$/

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

let g:go_highlight_structs = 0
let g:go_highlight_interfaces = 0
let g:go_highlight_operators = 0

" let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'test']

" Build/Test on save.
" augroup auto_go
"   autocmd!
"   autocmd BufWritePost *.go :GoBuild
"   autocmd BufWritePost *_test.go :GoTest
" augroup end
"
autocmd BufNewFile,BufRead *.pack set filetype=hcl
autocmd BufNewFile,BufRead Brewfile set filetype=ruby

map Y yy

set grepprg=rg\ --vimgrep\ --smart-case

" markdown-preview settings
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" set foldmethod=indent

" load ~/.config/nvim/lua/statusline.lua
" lua require('statusline')

" load claude-code.nvim
lua require('claude-code').setup()
