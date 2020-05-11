"  ____ ____
" / ___/ ___|
" \___ \___ \
"  ___) |__) | Sushant Shah
" |____/____/  https://github.com/tsushant

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

call plug#begin()

Plug 'mhinz/vim-startify'
Plug 'preservim/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'preservim/nerdcommenter'

" Wrapper for git and display git diff in the left gutter
Plug 'tpope/vim-fugitive' | Plug 'mhinz/vim-signify'

" Surrounding text objects with whatever you want (paranthesis, quotes, html tags...)
Plug 'tpope/vim-surround'

" Highlight briefly every yank text
Plug 'machakann/vim-highlightedyank'

" Match more stuff with % (html tag, LaTeX...)
Plug 'andymass/vim-matchup'

" Align plugin
Plug 'godlygeek/tabular'

" PHP
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
Plug '2072/php-indenting-for-vim', {'for': 'php'}
Plug 'alvan/vim-php-manual'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'tobyS/vmustache' | Plug 'tobyS/pdv', {'for': 'php'} " PHP doc autocompletion
Plug 'jwalton512/vim-blade'
Plug 'lumiliet/vim-twig', {'for': 'twig'}

" Display the hexadecimal colors - useful for css and color config
Plug 'ap/vim-css-color'

" Split arrays in PHP / other things
Plug 'AndrewRadev/splitjoin.vim'

Plug 'townk/vim-autoclose'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'dense-analysis/ale'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'editorconfig/editorconfig-vim'
Plug 'posva/vim-vue'
Plug 'terryma/vim-multiple-cursors'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Visuals
Plug 'chriskempson/base16-vim'
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'tsushant/vim-base16-lightline'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

call plug#end()

" ========= Theme =========
syntax enable

" This call must happen after the plug#end() call to ensure
" that the colorschemes have been loaded
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
else
    let g:onedark_termcolors=256
    let g:onedark_terminal_italics=1
    colorscheme onedark
endif

if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    let g:python_host_prog = '/usr/bin/python'
    let g:python3_host_prog = '/usr/local/bin/python3'
  else
    let g:python_host_prog = '/usr/bin/python'
    let g:python3_host_prog = '/usr/bin/python3'
  endif
endif

let mapleader = "\<Space>"
let maplocalleader = "\<Space>\<Space>"

" Move cursor out for neovim terminal
if has('nvim')
    :tnoremap <Esc> <C-\><C-n><C-w><C-w>
endif

filetype plugin indent on

set mouse=""
" for vim-ctrlspace
set hidden
set backspace=indent,eol,start   " Allow backspace in insert mode.
set smartcase
set ignorecase
set cursorline               " highlight current line

" ========= Scrolling =========
set scrolloff=8              " Scroll when 8 lines away from margins
set sidescrolloff=15         " How near the cursor must come to the border
set sidescroll=3

" ========= Handling Files =========
set encoding=utf-8           " UTF-8 Encoding to avoid server issues
set noswapfile               " Avoid using Swap Files. Text is in memory
set nobackup                 " Prevent Backup files
set nowb                     " Prevent Backup files
set history=1000             " Amount of :cmdline history
set path+=**

" ========= Folding settings =========
set foldmethod=indent        " fold based on indent
set foldnestmax=10           " deepest fold is 10 levels
set nofoldenable             " dont fold by default
set foldlevel=1              " this is just what i use

" ========= Tabs and indent =========
set nowrap
set autoindent               " on new lines, match indent of previous line
set copyindent               " copy the previous indentation on autoindenting
set cindent                  " smart indenting for c-like code
set expandtab                " Tabs are spaces, not tabs

" ========= Set smarttab =========
set tabstop=4                " tab size
set shiftwidth=4
set shiftround
set softtabstop=4

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

" Reload unchanged files automatically
set autoread
au CursorHold * checktime

highlight SpecialKey ctermfg=19 guifg=#333333
highlight NonText ctermfg=19 guifg=#333333

highlight Comment cterm=italic term=italic gui=italic
highlight htmlArg cterm=italic term=italic gui=italic
highlight xmlAttrib cterm=italic term=italic gui=italic

" Toggle relative numbering, and set to absolute on loss of focus or insert mode
set nu
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

" ========= Bubble/Move selected lines =========
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ========= Split and resize =========
set splitbelow splitright
nnoremap <A-h> :vertical resize -3<cr>
nnoremap <A-j> :resize +3<cr>
nnoremap <A-k> :resize -3<cr>
nnoremap <A-l> :vertical resize +3<cr>

" ========= SAVE =========
nnoremap <C-s> :update<CR>
inoremap <C-s> <Esc>:update<CR>
vnoremap <C-s> <Esc>:update<CR>

" ========= Edit & load .vimrc file =========
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>so :source $MYVIMRC<cr>

" remap esc
inoremap jk <esc>

" Set filetype for ractive template for pagevamp
autocmd BufNewFile,BufRead *.js.twig   set syntax=javascript
autocmd BufNewFile,BufRead *.twig   set syntax=twig
"autocmd BufNewFile,BufRead *.blade.php   set filetype=html

" Auto Remove White Space
autocmd BufWritePre * %s/\s\+$//e

" Convert tabs to Space
command! Tabstospace %s/\t/  /g

" Auto Format JS file as per "standard
" autocmd bufwritepost *.js silent !standard --fix %

" Uppercase word
:nmap <leader>ll m`b~``

" ========= Light Line =========
set noshowmode
set laststatus=0

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
        \ 'colorscheme': 'base16',
        \ 'active': {
        \   'left': [['mode'], ['gitbranch', 'readonly', 'filename', 'modified'], ['gutentags']],
        \   'right': [['lineinfo'], ['percent'], ['filetype'], ['cocstatus', 'currentfunction']]
        \ },
        \ 'component_function': {
        \   'gitbranch': 'fugitive#head',
        \   'cocstatus': 'coc#status',
        \   'currentfunction': 'CocCurrentFunction',
        \   'gutentags': 'gutentags#statusline'
        \ },
      \ }

" ========= Ale =========
set binary

" ---Settings for Ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_php_phpcs_standard = "psr2"
let g:ale_lint_on_enter = 0
let g:ale_set_highlights = 0
let g:ale_fixers = {'javascript': ['eslint']}

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

" ========= UltiSnips =========
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif

" ========= Search =========
set incsearch               "highlight the search text object
set hlsearch                "highlight search result
" Clear the search buffer
nnoremap <leader>, :noh<cr>

" ========= NERDTree =========
let NERDTreeShowHidden=1           "Show hidden file in NERDTree
nmap ,m :NERDTreeToggle<CR>
nmap ,n :NERDTreeFind<CR>
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let g:NERDSpaceDelims = 1           "Add a space after comment
let NERDTreeDirArrowExpandable = "" " make arrows invisible
let NERDTreeDirArrowCollapsible = "" " make arrows invisible
let NERDTreeNodeDelimiter = "\u263a" " smiley face
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1

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

" Webdev icons
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}

" ========= PHP Namespaces Import =========
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
" autocmd FileType php inoremap <C-\> <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>pu :call PhpInsertUse()<CR>

" ========= Expand Namespace =========
function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
"autocmd FileType php inoremap <Leader>pe:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>pe :call PhpExpandClass()<CR>

let g:pdv_template_dir = $HOME ."/.config/nvim/plugged/pdv/templates_snip"
autocmd FileType php noremap <Leader>pd :call pdv#DocumentWithSnip()<CR>

" ========= FZF config =========
nnoremap <silent> <C-p> :FZF<CR>
set rtp+=~/.fzf
let g:fzf_source = 'find . -type f | grep -v "node_modules/" | grep -v "\.git/" | grep -v "\.mat$"'

" ========= run current file in console =========
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

" ========= GutenTags =========
let g:gutentags_cache_dir = '~/.vim/gutentags'
let g:gutentags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*']

" ========= Signify =========
nnoremap <leader>gd :SignifyDiff<cr>
nnoremap <leader>gp :SignifyHunkDiff<cr>
nnoremap <leader>gu :SignifyHunkUndo<cr>

" ========= COC =========
" Some servers have issues with backup files, see #649.
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)