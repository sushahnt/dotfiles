" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

call plug#begin()

Plug 'preservim/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'preservim/nerdcommenter'

" wrapper for git and display git diff in the left gutter
Plug 'tpope/vim-fugitive' | Plug 'mhinz/vim-signify'

" surrounding text objects with whatever you want (paranthesis, quotes, html tags...)
Plug 'tpope/vim-surround'

" Highlight briefly every yank text
Plug 'machakann/vim-highlightedyank'

" Match more stuff with % (html tag, LaTeX...)
Plug 'andymass/vim-matchup'

" Align plugin
Plug 'godlygeek/tabular'

" php refactoring options
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
Plug '2072/php-indenting-for-vim', {'for': 'php'}

" php doc autocompletion
Plug 'tobyS/vmustache' | Plug 'tobyS/pdv', {'for': 'php'}

" twig
Plug 'lumiliet/vim-twig', {'for': 'twig'}

" display the hexadecimal colors - useful for css and color config
Plug 'ap/vim-css-color'

" Split arrays in PHP / other things
Plug 'AndrewRadev/splitjoin.vim'

Plug 'townk/vim-autoclose'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'padawan-php/deoplete-padawan', { 'do': 'composer install' }
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'mhinz/vim-startify'
Plug 'ekalinin/Dockerfile.vim'
Plug 'hashivim/vim-hashicorp-tools'
Plug 'dense-analysis/ale'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'sbdchd/neoformat'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'terryma/vim-multiple-cursors'
Plug 'rking/ag.vim'
Plug 'jwalton512/vim-blade'
Plug 'alvan/vim-php-manual'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'sumpygump/php-documentor-vim'
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

call plug#end()

let mapleader = "\<Space>"
let maplocalleader = "\<Space>\<Space>"

" Move cursor out for neovim terminal
if has('nvim')
:tnoremap <Esc> <C-\><C-n><C-w><C-w>
endif

set mouse=""
" for vim-ctrlspace
set hidden
set number
set relativenumber
set backspace=indent,eol,start   "Allow backspace in insert mode.
set smartcase
set ignorecase
set cursorline                   "highlight current line

" Toggle relative numbering, and set to absolute on loss of focus or insert mode
set rnu
function! ToggleNumbersOn()
    set nu!
    set rnu
endfunction
function! ToggleRelativeOn()
    set rnu!
    set nu
endfunction
autocmd FocusLost * call ToggleRelativeOn()
autocmd FocusGained * call ToggleRelativeOn()
autocmd InsertEnter * call ToggleRelativeOn()
autocmd InsertLeave * call ToggleRelativeOn()

" ========== Scrolling ==========
set scrolloff=8                 " Scroll when 8 lines away from margins
set sidescrolloff=15            " How near the cursor must come to the border
set sidescroll=3

" ========== Handling Files ==========
set encoding=utf-8              " UTF-8 Encoding to avoid server issues
set noswapfile                  " Avoid using Swap Files. Text is in memory
set nobackup                    " Prevent Backup files
set nowb                        " Prevent Backup files
set history=1000                " Amount of :cmdline history
set path+=**

" ========== Folding settings ==========
set foldmethod=indent            " fold based on indent
set foldnestmax=10              " deepest fold is 10 levels
set nofoldenable              " dont fold by default
set foldlevel=1                " this is just what i use

" ========== Tabs and indent ==========
set nowrap
set autoindent                " on new lines, match indent of previous line
set copyindent                " copy the previous indentation on autoindenting
set cindent                  " smart indenting for c-like code
set expandtab                " Tabs are spaces, not tabs

" ========== Set smarttab ==========
set tabstop=4                " tab size
set shiftwidth=4
set shiftround
set softtabstop=4

filetype plugin indent on

" Allow for mappings including Esc, while preserving zero timeout after pressing it manually.
set complete-=i

" Set window title by default.
set title
set titleold="Terminal"
set titlestring=%F

" Show the line and column number of the cursor position.
set ruler

" Show white space and tab characters
set list

" Set default whitespace characters when using :set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" System clipboard copy & paste
set pastetoggle=<F2> "F2 before pasting to preserve indentation

" Deoplete
if has('nvim')
    let g:deoplete#enable_at_startup = 1
endif

" ========== Theme ==========
syntax enable
set background=dark
colorscheme onedark

" ========== Light Line ==========
set noshowmode
let g:lightline = {
        \ 'colorscheme': 'onedark',
        \ 'active': {
        \   'left': [['mode'], ['gitbranch','readonly', 'filename', 'modified'], ['gutentags']],
        \   'right': [ [ 'lineinfo' ],
        \              [ 'percent' ],
        \              [ 'filetype' ] ]
        \ },
        \ 'component': {
        \   'gitbranch': '%{FugitiveStatusline()}',
        \   'gutentags': '%{gutentags#statusline("[Generating...]")}'
        \ },
      \ }

" ============ Ale ==========
set binary

" ---------- Settings for Ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_php_phpcs_standard = "psr2"

augroup AleGroup
    autocmd!
    autocmd User ALELint call TouchOpenFile()
augroup END

func! TouchOpenFile()
    let g:ale_enabled = 0
    sleep 500m
    w
    let g:ale_enabled = 1
endfunc

" ========== UltiSnips ==========
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" ========== Search ==========
set incsearch               "highlight the search text object
set hlsearch                "highlight search result
" Clear the search buffer
nnoremap <leader>, :noh<cr>

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

" ========== NERDTree ==========
let NERDTreeShowHidden=1           "Show hidden file in NERDTree
nmap ,m :NERDTreeToggle<CR>
nmap ,n :NERDTreeFind<CR>
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let g:NERDSpaceDelims = 1                 "Add a space after comment
let NERDTreeDirArrowExpandable = "" " make arrows invisible
let NERDTreeDirArrowCollapsible = "" " make arrows invisible
let NERDTreeNodeDelimiter = "\u263a" " smiley face
let g:NERDTreeLimitedSyntax = 1

let g:NERDTreeIndicatorMapCustom = {
\ "Modified"  : "✹",
\ "Staged"    : "✚",
\ "Untracked" : "✭",
\ "Renamed"   : "➜",
\ "Unmerged"  : "═",
\ "Deleted"   : "✖",
\ "Dirty"     : "✗",
\ "Clean"     : "✔︎",
\ 'Ignored'   : '☒',
\ "Unknown"   : "?"
\ }

" webdev icons
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vue'] = 'v'

" Reload unchanged files automatically
set autoread
au CursorHold * checktime

" ======= autoreload rc file on save ========
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" ========== Edit & load .vimrc file ==========
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>so :source $MYVIMRC<cr>

" ========== PHP Namespaces Import =========
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <C-\> <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>pu :call PhpInsertUse()<CR>

" ========== Expand Namespace =========
function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
"autocmd FileType php inoremap <Leader>pe:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>pe :call PhpExpandClass()<CR>

"au BufRead,BufNewFile *.php inoremap <buffer> <leader>pd :call PhpDoc()<CR>
au BufRead,BufNewFile *.php nnoremap <buffer> <leader>pd :call PhpDoc()<CR>
au BufRead,BufNewFile *.php vnoremap <buffer> <leader>pd :call PhpDocRange()<CR>

" =============== FZF config =================
"nnoremap <silent> <C-p> :FZF<CR>

" ======= run current file in console =======
nnoremap <leader>rf :call RunFile()<CR>
func! RunFile()
    if &filetype == 'php'
        exec "!php %:p"
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
    elseif &filetype == "javascript"
        if filereadable("./node_modules/.bin/ava")
            exec "!ava"
        endif
    endif
endfunc

nnoremap <leader>rr :echo cfi#format("%s", "")<CR>

" ========== Bubble/Move selected lines ==========
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ========== Resize buffer ==========
nnoremap <A-h> :vertical resize -5<cr>
nnoremap <A-j> :resize +5<cr>
nnoremap <A-k> :resize -5<cr>
nnoremap <A-l> :vertical resize +5<cr>

" ========== SAVE ==========
nnoremap <C-s> :update<CR>
inoremap <C-s> <Esc>:update<CR>
vnoremap <C-s> <Esc>:update<CR>

" ========== netrw settings ==========
let g:netrw_localrmdir="rm -r"                  "delete non empty directory
nnoremap - :Explore<CR>

" Set filetype for ractive template for pagevamp
autocmd BufNewFile,BufRead *.js.twig   set syntax=javascript
autocmd BufNewFile,BufRead *.twig   set syntax=twig
"autocmd BufNewFile,BufRead *.blade.php   set filetype=html

set laststatus=0

" Auto Remove White Space
autocmd BufWritePre * %s/\s\+$//e

" Convert tabs to Space
command! Tabstospace %s/\t/  /g

" Auto Format JS file as per "standard
" autocmd bufwritepost *.js silent !standard --fix %
"
:nmap <leader>ll m`b~``

" ========== GutenTags ==========
let g:gutentags_cache_dir = '~/.vim/gutentags'
let g:gutentags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*']

let g:gutentags_ctags_extra_args = [
            \ '--recurse=yes',
            \ '--tag-relative=yes',
            \ '--exclude=.git',
            \ '--languages=php',
            \ '--PHP-kinds=+cfit-av'
            \]

" ========== CtrlP ==========
let g:ctrlp_user_command = 'ag %s -l --nocolor -g "" '
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_match_current_file = 1
let g:ctrlp_lazy_update = 1
let g:ctrlp_use_caching = 0
let g:ctrlp_working_path_mode = 'r'
" Jump to definition
map <silent> <leader>jd :CtrlPTag<cr><C-\>w

" ========== Signify ==========
nnoremap <leader>gd :SignifyDiff<cr>
nnoremap <leader>gp :SignifyHunkDiff<cr>
nnoremap <leader>gu :SignifyHunkUndo<cr>
