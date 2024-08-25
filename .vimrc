" Notes
" - To see search count above 100 - :%s///gn

" TODO
" - Disable FUCKING STUPID word wrapping (repro: when typing a long comment, it will auto break at 100th)

" Replace Xcode
" - File explorer (with single state, where certain directories stay open)
" - Jump between edited/specific set of files
" - Search and replace in multiple files

" Snippets
if has('mac')
  augroup SwiftSnippets
    autocmd!
    autocmd FileType swift abbrev ws [weak self] in<Left><Left><Left>
    autocmd FileType swift abbrev gl guard let self else { return }
    autocmd FileType swift abbrev si .store(in: &subscribers)
  augroup END
endif
 
" Setup File Search
if has('win32')
    nnoremap <C-S-up> :call OpenOrSwitchToTab('D:\Documents\GitHub\vimrc\.vimrc')<CR>
    nnoremap <C-]> :Files D:\Documents<CR>
    nnoremap <C-p> :AgIn D:\Documents<CR>
elseif has('mac')
    nnoremap <C-S-down> :call OpenOrSwitchToTab('~/Documents/Check24/check24-worklog/worklog.txt')<CR>
    nnoremap <C-S-up> :call OpenOrSwitchToTab('~/Documents/GitHub/vimrc/.vimrc')<CR>

    nnoremap <C-]> :Files ~/Documents/Check24/ios-pod-mobile-sim<CR>
    nnoremap <C-p> :AgIn ~/Documents/Check24/ios-pod-mobile-sim<CR>
    nnoremap <leader><C-]> :Files ~/Documents<CR>
    nnoremap <leader><C-p> :AgIn ~/Documents<CR>
elseif has('linux')
    nnoremap <C-S-down> :call OpenOrSwitchToTab('~/Documents/os-todos.txt')<CR>
    nnoremap <C-S-up> :call OpenOrSwitchToTab('~/Documents/GitHub/vimrc/.vimrc')<CR>
    nnoremap <C-]> :Files ~/Documents/<CR>
    nnoremap <C-p> :AgIn ~/Documents/<CR>
endif

" Search symbol under cursor
if has('mac')
    nnoremap <leader>p *ve"+y:exe 'AgIn ~/Documents/Check24/ios-pod-mobile-sim ' . @+<CR>
    vnoremap <leader>p "+y:exe 'AgIn ~/Documents/Check24/ios-pod-mobile-sim ' . @+<CR>
elseif has('linux')
    nnoremap <leader>p *ve"+y:exe 'AgIn ~/Documents ' . @+<CR>
    vnoremap <leader>p "+y:exe 'AgIn ~/Documents ' . @+<CR>
endif

nnoremap <C-h> :History<CR>

" List of installed plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Syntax highlighting
Plug 'keith/swift.vim' " Swift support
Plug 'jansedivy/jai.vim' " Jai support

" Plug 'mbbill/undotree'
" Plug 'neovim/nvim-lspconfig'
Plug 'tpope/vim-fugitive' " Git
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim' " Status line
Plug 'mhinz/vim-startify' " Startup screen
Plug 'tpope/vim-commentary' " Comment lines of code
Plug 'preservim/nerdtree' | " File browser
    \ Plug 'Xuyuanp/nerdtree-git-plugin' " Plugin with git status
Plug 'Mofiqul/vscode.nvim' " color theme
call plug#end()

let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_action = { 'enter': 'tab split' }


let g:bufferline_echo = 0
autocmd VimEnter *
    \ let &statusline='%{bufferline#refresh_status()}'
    \ .bufferline#get_status_string()

" Files setup
command! -bang -nargs=+ -complete=dir Files
	\ call fzf#vim#files(<q-args>, 
    \     fzf#vim#with_preview(
    \         {
    \             'options': [
    \                 '--reverse', '-i', '--info=inline',
    \                 '--keep-right', '--preview="bat -p --color always {}"'
    \             ]
    \         },
    \         'right:40%'
    \     ), 
    \ <bang>0)

" AgIn setup
function! s:ag_in(bang, ...)
    call fzf#vim#ag(join(a:000[1:], ' '),
        \ '--ignore=*.pbxproj',
        \     fzf#vim#with_preview(
        \         {
        \             'dir': expand(a:1), 
        \             'options': [
        \                 '--reverse', '-i', '--info=inline', 
        \                 '--keep-right', '--preview="bat -p --color always {}"' 
        \             ]
        \         }, 
        \         'down:70%'
        \     ), 
        \ a:bang)
endfunction
command! -bang -nargs=+ -complete=dir AgIn call s:ag_in(<bang>0, <f-args>)

" Setup Plugin Manager
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" LSP setup
" lua require'lspconfig'.sourcekit.setup{}

" Setup nerd tree
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=50
let NERDTreeCustomOpenArgs={'file':{'where': 't'}}

set noshowmode
let g:lightline = { 'colorscheme': 'one', 
      \   'active': {
      \     'left': [ [ 'mode', 'paste' ],
      \               [ 'gitbranch', 'readonly', 'filename', 'modified' ]]
      \   },
      \   'component_function': {
      \     'gitbranch': 'FugitiveHead'
      \   },
      \ }

" weird auto-text wrapping to new line, this is horrible
set formatoptions-=cro

" Before this theme is installed via :PlugInstall, vimrc will give an error here
colorscheme vscode
noremap <C-S-Right> :set background=light<CR><C-l>
noremap <C-S-Left> :set background=dark<CR><C-l>

if has('mac')
    if system('defaults read -g AppleInterfaceStyle') == "Dark\n"
        set background=dark
    else
        set background=light
    endif
else
    set background=dark
endif

" Copy paste stuff
noremap p "+p
noremap P "+P
noremap y "+y
noremap Y "+Y

" Visuals
if has('win32')
    set guifont=Fira\ Code:h15
elseif has('linux')
    set guifont=Fira\ Code:h20
elseif has('mac')
    set guifont=Fira_Code_Retina:h16
endif

if has('win32')
    set backspace=indent,eol,start
    set belloff=all
endif

syntax on
set ruler
set rnu
set number 
set autowrite
set wildignorecase
set scroll=15

" Search
set ic " case insensitive search
set gdefault
let g:searchindex_line_limit=2000000
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR

" Navigation
" nnoremap <C-d> <C-d>zz 
" nnoremap <C-u> <C-u>zz 
nnoremap n nzzzv
nnoremap N Nzzzv
let mapleader = " "

" Brackets around selection
xnoremap <leader>[ <ESC>a]<ESC>gv`<<ESC>i[<ESC>
xnoremap <leader>( <ESC>a)<ESC>gv`<<ESC>i(<ESC>
xnoremap <leader>{ <ESC>a}<ESC>gv`<<ESC>i{<ESC>

" Jump to next empty line
noremap } <Cmd>call search('^\s*$\\|\%$', 'W')<CR>
noremap { <Cmd>call search('^\s*$\\|\%^', 'Wb')<CR>

" Jump to next git change
nmap ]h <Plug>(GitGutterNextHunk)zz
nmap [h <Plug>(GitGutterPrevHunk)zz

nnoremap <leader>g :vertical:G<CR>

" Create new tab
nnoremap tg gT
nnoremap <leader>' :tabnew<CR>
nnoremap <leader>q :bd<CR>

" Funny command to quit insert mode without escape
imap jk <Esc>:cd %:p:h<CR>

" Tab lines
vnoremap < <gv
vnoremap > >gv

" Nerd tree
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Modified'  :'m',
    \ 'Staged'    :'s',
    \ 'Untracked' :'t',
    \ 'Renamed'   :'r',
    \ 'Unmerged'  :'n',
    \ 'Deleted'   :'d',
    \ 'Dirty'     :'✗',
    \ 'Ignored'   :'i',
    \ 'Clean'     :'c',
    \ 'Unknown'   :'u',
    \ }

nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <C-t> :NERDTreeToggleVCS<CR>

" Prettify json (depends on installed jq)
command! Prettify :%!jq .

" Move lines
nnoremap <S-down> :m .+1<CR>==
nnoremap <S-up> :m .-2<CR>==
inoremap <S-down> <Esc>:m .+1<CR>==gi
inoremap <S-up> <Esc>:m .-2<CR>==gi
vnoremap <S-down> :m '>+1<CR>gv=gv
vnoremap <S-up> :m '<-2<CR>gv=gv

" Tabs and shit
filetype plugin indent on
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.
set sw=4

if has('mac')
    command! Worklog execute 'cd ' . expand('%:p:h') . ' | !git add . && git commit -m "-"'
    nnoremap <C-b> :w<CR>:!osascript ~/Documents/GitHub/vimrc/build_xcode.applescript<CR><CR>
else
    nnoremap <C-b> :make -B<CR>
endif

" close all other buffers
command! Bufo silent! execute "%bd|e#|bd#"

function! OpenOrSwitchToTab(file)
  let tab_open = 0
  for tab in range(tabpagenr('$'))
      if fnamemodify(bufname(tabpagebuflist(tab + 1)[0]), ':p') == fnamemodify(a:file, ':p')
      execute 'tabnext ' . (tab + 1)
      let tab_open = 1
      break
    endif
  endfor
  if !tab_open
    execute 'tabnew ' . a:file
  endif
endfunction
