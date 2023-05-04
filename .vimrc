" TODO
" fix file search previews on Windows
" fix auto-identation in C#, Swift files
" Swift LSP support
" Swift autocomplete
" Comment lines of code (vim-commentary)

" Setup File Search
if has('win32')
    nnoremap <C-S-up> :e ~\Documents\GitHub\vimrc\.vimrc<CR>
    nnoremap <C-]> :Files ~\Documents\GitHub\<CR>
    nnoremap <C-p> :AgIn ~\Documents\GitHub\<CR>
    nnoremap <C-h> :History<CR>
elseif has('mac')
    nnoremap <C-S-up> :e ~/Documents/GitHub/vimrc/.vimrc<CR>
    nnoremap <C-]> :Files ~/Documents/ios-pod-mobile-sim<CR>
    nnoremap <C-p> :AgIn ~/Documents/ios-pod-mobile-sim<CR>
    nnoremap <C-h> :History<CR>
endif

command! -bang -nargs=+ -complete=dir Files
	\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': [
	\	'--reverse', '-i', '--info=inline', '--keep-right'
	\ ]}, 'right:40%'), <bang>0)
function! s:ag_in(bang, ...)
    call fzf#vim#ag(join(a:000[1:], ' '), fzf#vim#with_preview({'dir': expand(a:1), 'options': [
		\ '--reverse', '-i', '--info=inline', '--keep-right'
        \ ]}, 'down:60%'), a:bang)
endfunction
command! -bang -nargs=+ -complete=dir AgIn call s:ag_in(<bang>0, <f-args>)

" Setup Plugin Manager
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" List of installed plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" LSP
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

Plug 'keith/swift.vim' " Swift support
Plug 'github/copilot.vim'
Plug 'tpope/vim-fugitive' " Git
Plug 'itchyny/lightline.vim' " Status line
Plug 'mhinz/vim-startify' " Startup screen
Plug 'airblade/vim-gitgutter' " Git diffs

call plug#end()

" SourceKit-LSP configuration
if executable('sourcekit-lsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'sourcekit-lsp',
        \ 'cmd': {server_info->['sourcekit-lsp']},
        \ 'whitelist': ['swift'],
        \ })
endif

" vim-lsp setup
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

" Setup gitgutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" Switch tabs
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Setup lightline
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

" Adjust color theme
colorscheme onehalfdark
noremap <C-S-Left> :colorscheme onehalflight<CR><C-l>
noremap <C-S-Right> :colorscheme onehalfdark<CR><C-l>

" Copy paste stuff
noremap p "+p
noremap P "+P
noremap y "+y
noremap Y "+Y

" Visuals
set guifont=Fira\ Code:h16
syntax on
set ruler
set rnu
set number 
set autowrite
set scroll=20
set wildignorecase

if has('win32')
    set backspace=indent,eol,start
    set belloff=all
endif

" Search and center
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
nnoremap <C-d> <C-d>zz 
nnoremap <C-u> <C-u>zz 
nnoremap n nzzzv
nnoremap N Nzzzv

imap jk <Esc>:cd %:p:h<CR>

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
