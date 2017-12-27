call plug#begin()

Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'tyru/current-func-info.vim'
Plug 'scrooloose/nerdTree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Shougo/deoplete.nvim',    { 'do': ':UpdateRemotePlugins' }
Plug 'mhinz/vim-startify'
Plug 'kshenoy/vim-signature'
Plug 'hashivim/vim-hashicorp-tools'
Plug 'sbdchd/neoformat'
Plug 'slashmili/alchemist.vim'
Plug 'tpope/vim-projectionist' " required for some navigation features
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'ekalinin/Dockerfile.vim'
Plug 'metakirby5/codi.vim'
Plug 'posva/vim-vue'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-projectionist'
Plug 'vimwiki/vimwiki'
Plug 'jwalton512/vim-blade'
Plug 'alvan/vim-php-manual'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'sumpygump/php-documentor-vim'
Plug 'rking/ag.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'dracula/vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'editorconfig/editorconfig-vim'
Plug 'w0rp/ale'
Plug 'terryma/vim-multiple-cursors'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'godlygeek/tabular'
Plug 'padawan-php/deoplete-padawan', { 'do': 'composer install' }
Plug 'pangloss/vim-javascript'
Plug 'joshdick/onedark.vim'
Plug 'trevordmiller/nova-vim'

call plug#end()


" ---------- Theme -----------
" if $TERM == "xterm-256color"
    set t_Co=256
" endif

syntax enable
if has('nvim')
set termguicolors
endif
set background=dark
colorscheme onedark
" colorscheme nova


" ============ Ale
let g:ale_php_phpcs_standard='PSR2'

" ======== UltiSnips ==============
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let mapleader = "\<Space>"
let maplocalleader = "\<Space>\<Space>"

set mouse=""
" for vim-ctrlspace
set hidden
set number
set backspace=indent,eol,start        "Allow backspace in insert mode.
set smartcase
set ignorecase
set cursorline                "highlight current line

" ======== Scrolling =============
set scrolloff=8                 " Scroll when 8 lines away from margins
set sidescrolloff=15            " How near the cursor must come to the border
set sidescroll=3

" ===== Handling Files ==========
set encoding=utf-8              " UTF-8 Encoding to avoid server issues
set noswapfile                  " Avoid using Swap Files. Text is in memory
set nobackup                    " Prevent Backup files
set nowb                        " Prevent Backup files
set history=1000                " Amount of :cmdline history
set path+=**

" ======= folding settings =========
set foldmethod=indent            " fold based on indent
set foldnestmax=10              " deepest fold is 10 levels
set nofoldenable              " dont fold by default
set foldlevel=1                " this is just what i use

" ========= Tabs n indent ==============
set nowrap
set autoindent                " on new lines, match indent of previous line
set copyindent                " copy the previous indentation on autoindenting
set cindent                  " smart indenting for c-like code
set expandtab                " Tabs are spaces, not tabs

" ======== set smarttab ================
set tabstop=4                " tab size
set shiftwidth=4
set shiftround
set softtabstop=4

filetype plugin indent on

"Allow for mappings including Esc, while preserving zero timeout after pressing it manually.
set complete-=i
"Set window title by default.
set title
set titleold="Terminal"
set titlestring=%F
"Show the line and column number of the cursor position.
set ruler
"Show white space and tab characters
set list
"Set default whitespace characters when using :set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" -------------- search moving around -----------------
set incsearch                "highlight the search text object
set hlsearch                "highlight search result
map <leader>hh :set hlsearch!<cr>

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

" ---------------- Ansible -----------
let g:ansible_extra_syntaxes = "sh.vim ruby.vim"
let g:ansible_attribute_highlight = "ob"
let g:ansible_name_highlight = 'd'

" --------------- NERDTree -------------
let NERDTreeShowHidden=1           "Show hidden file in NERDTree
nmap ,m :NERDTreeToggle<CR>
nmap ,n :NERDTreeFind<CR>

" Add space after comment
let g:NERDSpaceDelims = 1                 "Add a space after comment

if has('nvim')
    let g:deoplete#enable_at_startup = 1
endif

autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype eruby setlocal ts=2 sts=2 sw=2

" ------------- Reload unchanged files automatically -----------------
set autoread
au CursorHold * checktime

" ======= autoreload rc file on save ========
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" ========= Edit & load .vimrc file =======
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>so :source $MYVIMRC<cr>

" ------ PHP Namespaces Import -------------
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>pu <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>pu :call PhpInsertUse()<CR>

" ---------- Expand Namespace ---------------
function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>pe <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>pe :call PhpExpandClass()<CR>

au BufRead,BufNewFile *.php inoremap <buffer> <leader>pd :call PhpDoc()<CR>
au BufRead,BufNewFile *.php nnoremap <buffer> <leader>pd :call PhpDoc()<CR>
au BufRead,BufNewFile *.php vnoremap <buffer> <leader>pd :call PhpDocRange()<CR>

" =============== FZF config =================
nnoremap <silent> <C-p> :FZF<CR>
set rtp+=~/.fzf " ZFZ Fuzzy finder in go
let g:fzf_source = 'find . -type f | grep -v "node_modules/" | grep -v "\.git/" | grep -v "\.mat$"'

" ====== Generate ctags ==========
command! Phpctags execute "Dispatch ctags -R --fields=+laimS --languages=php"
command! Rubyctags execute "Dispatch ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)"

" ======= run current file in console =======
nnoremap <leader>rf :call RunFile()<CR>
func! RunFile()
    if &filetype == 'php'
        exec "!php %:p"
    elseif &filetype == 'ruby'
        exec "!ruby %:p"
    elseif &filetype == 'sh'
        exec "!bash %:p"
    elseif &filetype == 'javascript'
        exec "!node %:p"
    endif
endfunc
" ====== Run unit test ============
nnoremap <leader>rt :call RunTest()<CR>
func! RunTest()
    if &filetype == 'php'
        if filereadable("docker-compose.yml")
            let phpunit_exec = "Dispatch docker-compose exec app vendor/bin/phpunit"
        else
            let phpunit_exec = "!./vendor/bin/phpunit"
        end
        if cfi#format('%s', '') == ''
            exec phpunit_exec." --filter %:t:r %"
        else
            exec phpunit_exec." --filter ".cfi#format('%s', '')." %"
        endif
    elseif &filetype == 'ruby'
        exec "!RAILS_ENV=test ruby -I test %:p"
    elseif &filetype == "javascript"
        if filereadable("./node_modules/.bin/ava")
            exec "!ava"
        endif
    elseif &filetype == "javascript.jsx"
        if filereadable("./node_modules/.bin/ava")
            exec "!ava"
        endif
    endif
endfunc

nnoremap <leader>rr :echo cfi#format("%s", "")<CR>

" -------------- Bubble/Move selected lines -----------
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ------------- Resize buffer -----------------
nnoremap <A-h> :vertical resize -5<cr>
nnoremap <A-j> :resize +5<cr>
nnoremap <A-k> :resize -5<cr>
nnoremap <A-l> :vertical resize +5<cr>

" ----------- SAVE -----------------
nnoremap <C-s> :update<CR>
inoremap <C-s> <Esc>:update<CR>
vnoremap <C-s> <Esc>:update<CR>

" -------------- set filetype for ractive template for pagevamp --------------
autocmd BufNewFile,BufRead *.js.twig   set syntax=javascript
autocmd BufNewFile,BufRead *.twig   set syntax=twig
"autocmd BufNewFile,BufRead *.blade.php   set filetype=html

" --------- netrw settings -------------
let g:netrw_localrmdir="rm -r"                  "delete non empty directory
" let g:netrw_liststyle=3                         "tree style for netrw
nnoremap - :Explore<CR>

set laststatus=0

"Move cursor out for neovim terminal
if has('nvim')
:tnoremap <Esc> <C-\><C-n><C-w><C-w>
endif

"Auto Remove White Space
autocmd BufWritePre * %s/\s\+$//e

"convert tabs to Space
command! Tabstospace %s/\t/  /g

"Auto Format JS file as per "standard
" autocmd bufwritepost *.js silent !standard --fix %
"
:nmap <leader>ll m`b~``
