" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"
" An example for a Japanese version vimrc file.
" 日本語版のデフォルト設定ファイル(vimrc) - Vim7用試作
"
" Last Change: 14-Jun-2018.
" Maintainer:  MURAOKA Taro <koron.kaoriya@gmail.com>
"
" 解説:
" このファイルにはVimの起動時に必ず設定される、編集時の挙動に関する設定が書
" かれています。GUIに関する設定はgvimrcに書かかれています。
"
" 個人用設定は_vimrcというファイルを作成しそこで行ないます。_vimrcはこのファ
" イルの後に読込まれるため、ここに書かれた内容を上書きして設定することが出来
" ます。_vimrcは$HOMEまたは$VIMに置いておく必要があります。$HOMEは$VIMよりも
" 優先され、$HOMEでみつかった場合$VIMは読込まれません。
"
" 管理者向けに本設定ファイルを直接書き換えずに済ませることを目的として、サイ
" トローカルな設定を別ファイルで行なえるように配慮してあります。Vim起動時に
" サイトローカルな設定ファイル($VIM/vimrc_local.vim)が存在するならば、本設定
" ファイルの主要部分が読み込まれる前に自動的に読み込みます。
"
" 読み込み後、変数g:vimrc_local_finishが非0の値に設定されていた場合には本設
" 定ファイルに書かれた内容は一切実行されません。デフォルト動作を全て差し替え
" たい場合に利用して下さい。
"
" 参考:
"   :help vimrc
"   :echo $HOME
"   :echo $VIM
"   :version

" windows環境用変数
let s:iswin = has('win32') || has('win64') || has('win32unix')

" mac環境用変数
let s:ismac = has('mac')

" エラーメッセージ表示時のbeep音をOFF
"set noerrorbells

"---------------------------------------------------------------------------
" 日本語対応のための設定:
"
" BOM対応
let &termencoding = &encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=4
set shiftwidth=4  "自動インデントに影響

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を非表示 (number:表示)
set number
" タブや改行を表示 (list:表示)
set list
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:\|-,extends:<,trail:+,eol:<
if s:iswin
  set listchars=eol:¬,tab:▸-,extends:<,trail:+
elseif s:ismac
  set listchars=eol:¬,tab:>-,extends:<,trail:+
endif
" 長い行を折り返して表示 (nowrap:折り返さない)
set nowrap

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
"set nobackup
set noswapfile
set backup
set noundofile
"set directory=$HOME./vimbackup
"set backupdir=$HOME./vimbackup
if s:iswin
  set directory=C:/_vimbackup
  set backupdir=C:/_vimbackup
" set undodir=C:/vimbackup
elseif s:ismac
  set directory=$HOME/_vimbackup
  set backupdir=$HOME/_vimbackup
" set undodir=$HOME/_vimbackup
endif

set tags=tags;

" デフォルトvimrc_exampleのtextwidth設定上書き
autocmd FileType text setlocal textwidth=0

" Python
autocmd FileType python setl noexpandtab tabstop=4








let s:oldplugin = 0
if s:oldplugin
"---------------------------------------------------------------------------
" NeoBundle (begin)
"---------------------------------------------------------------------------
NeoBundle 'helino/vim-json' 
"---------------------------------------------------------------------------
" NeoBundle (end)
"---------------------------------------------------------------------------
endif








"---------------------------------------------------------------------------
" vim-plug

if s:iswin
  call plug#begin('~/vimfiles/plugged')
elseif s:ismac
  call plug#begin('~/.vim/plugged')
endif

Plug 'rking/ag.vim'
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'

Plug 'Shougo/neocomplete.vim'

call plug#end()

"---------------------------------------------------------------------------








"---------------------------------------------------------------------------
" dein

if &compatible
  set nocompatible
endif
if s:iswin
  set runtimepath+=~/vimfiles/dein/repos/github.com/Shougo/dein.vim
elseif s:ismac
  set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
endif

if s:iswin
  call dein#begin(expand('~/vimfiles/dein'))
elseif s:ismac
  call dein#begin(expand('~/.vim/dein'))
endif

"call dein#add('Shougo/dein.vim')
"call dein#add('Shougo/neocomplete.vim')

"call dein#add('rking/ag.vim')
"call dein#add('scrooloose/nerdtree')
"call dein#add('ctrlpvim/ctrlp.vim')
"call dein#add('junegunn/fzf', { 'build': './install' })
"call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
"call dein#add('itchyny/lightline.vim')

call dein#end()

"---------------------------------------------------------------------------








" Required:
filetype plugin indent on




"---------------------------------------------------------------------------
" NeoComplete

let g:neocomplete#enable_at_startup = 1 "neocompleteを起動時に有効化

"---------------------------------------------------------------------------




"---------------------------------------------------------------------------
" NERDTree

let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowHidden = 1
"let g:NERDTreeIgnore = ['.[oa]$', '.(so)$', '.(tgz|gz|zip)$' ]
let g:NERDTreeIgnore = ['\.meta$']
nnoremap <silent><C-e> :NERDTreeToggle<CR>
nnoremap <silent><C-f> :NERDTreeFind<CR>

"---------------------------------------------------------------------------




"---------------------------------------------------------------------------
"
" CtrlP
"
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_custom_ignore = '\.meta$'
"---------------------------------------------------------------------------




"---------------------------------------------------------------------------
"
" lightline
"
"let g:lightline = {
"    \ 'colorscheme': 'jellybeans',
"    \ 'separator': { 'left': '>', 'right': '<' },
"    \ 'subseparator': { 'left': '>', 'right': '<' }
"    \ }
"---------------------------------------------------------------------------




"runtime macros/editexisting.vim
packadd! editexisting

"---------------------------------------------------------------------------
" 
"command! -nargs=? Jq call s:Jq(<f-args>)
"function! s:Jq(...)
"    if 0 == a:0
"        let l:arg = "."
"    else
"        let l:arg = a:1
"    endif
"    execute "%!jq 95fe1a73-e2e2-4737-bea1-a44257c50fc8quot;" . l:arg . "95fe1a73-e2e2-4737-bea1-a44257c50fc8quot;"
"endfunction

" end of _vimrc
