" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"
" An example for a Japanese version vimrc file.
" 日本語版のデフォルト設定ファイル(vimrc) - Vim7用試作
"
" Last Change: 14-May-2016.
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
set noerrorbells

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
set listchars=eol:¬,tab:▸-,extends:<,trail:+
" 長い行を折り返して表示 (nowrap:折り返さない)
set nowrap

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
"set nobackup
set swapfile
set backup
set noundofile
"set directory=$HOME./vimbackup
"set backupdir=$HOME./vimbackup
if s:iswin
  set directory=C:/vimbackup
  set backupdir=C:/vimbackup
" set undodir=C:/vimbackup
elseif s:ismac
  set directory=$HOME/_vimbackup
  set backupdir=$HOME/_vimbackup
" set undodir=$HOME/_vimbackup
endif

set tags=tags;

"---------------------------------------------------------------------------
" NeoBundle
filetype off

if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/vimfiles/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/vimfiles/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neocomplcache'
" jellybeans カラースキーム
"NeoBundle 'nanotech/jellybeans.vim'
" Syntax
NeoBundle 'helino/vim-json' 

call neobundle#end()








"---------------------------------------------------------------------------
"
" Dein
"
if &compatible
  set nocompatible
endif
set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim

"call dein#begin(expand('~/.cache/dein'))
call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/neocomplete.vim')
...

call dein#end()
"
"---------------------------------------------------------------------------








" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" NeoComplCache
let g:neocomplcache_enable_at_startup = 1 "neocomplcacheを起動時に有効化

" insert modeで開始
let g:unite_enable_start_insert = 0

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" grep検索
"nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,g  :<C-u>Unite grep -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
"nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

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