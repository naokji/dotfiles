" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"
" An example for a Japanese version gvimrc file.
" 日本語版のデフォルトGUI設定ファイル(gvimrc) - Vim7用試作
"
" Last Change: 19-May-2016.
" Maintainer:  MURAOKA Taro <koron.kaoriya@gmail.com>
"
" 解説:
" このファイルにはVimの起動時に必ず設定される、GUI関連の設定が書かれていま
" す。編集時の挙動に関する設定はvimrcに書かかれています。
"
" 個人用設定は_gvimrcというファイルを作成しそこで行ないます。_gvimrcはこの
" ファイルの後に読込まれるため、ここに書かれた内容を上書きして設定することが
" 出来ます。_gvimrcは$HOMEまたは$VIMに置いておく必要があります。$HOMEは$VIM
" よりも優先され、$HOMEでみつかった場合$VIMは読込まれません。
"
" 管理者向けに本設定ファイルを直接書き換えずに済ませることを目的として、サイ
" トローカルな設定を別ファイルで行なえるように配慮してあります。Vim起動時に
" サイトローカルな設定ファイル($VIM/gvimrc_local.vim)が存在するならば、本設
" 定ファイルの主要部分が読み込まれる前に自動的に読み込みます。
"
" 読み込み後、変数g:gvimrc_local_finishが非0の値に設定されていた場合には本設
" 定ファイルに書かれた内容は一切実行されません。デフォルト動作を全て差し替え
" たい場合に利用して下さい。
"
" 参考:
"   :help gvimrc
"   :echo $HOME
"   :echo $VIM
"   :version

" windows環境用変数
let s:iswin = has('win32') || has('win64') || has('win32unix')

" mac環境用変数
let s:ismac = has('mac')

"---------------------------------------------------------------------------
" カラー設定:
"colorscheme evening		" (GUI使用時)
"colorscheme metacosm		" (GUI使用時)
"colorscheme zenburn		" 2004-12-11
"colorscheme bluegreen		" 2005-01-04 (文字置換と検索の区別が付け難い)
"colorscheme dusk		" 2005-01-18
"colorscheme blackdust		" 2007-04-16 (←↓この２つを使い分けていく)
"colorscheme oceandeep		" 2007-04-16
"colorscheme dusk		" 2009-05-19 (Pmenu設定が無い為Fuzzyfinderの配色が派手)
"colorscheme darkspectrum	" 2009-06-10 (画面分割時に有効なバッファが分かり辛い)
"colorscheme northland		" 2009-09-09 (置換s/*/*/gc時の進行具合が見れない)
"colorscheme rootwater		" 2009-09-09 (画面を横割りしたときに境目の表示が目立たない)
"colorscheme oceandeep		" 2009-09-11
"colorscheme lucius		" 2010-06-10
"colorscheme phd		" 2011-05-09
"colorscheme macvim		" 2013-01-24 (試しに使ってみたけど背景が明るすぎる)
"colorscheme phd		" 2013-01-24
"colorscheme molokai		" 2013-02-22 (tabキーの表示がitalicになる)
"colorscheme hybrid		" 2013-02-22 (全体に色が薄いため目が疲れる)
colorscheme jellybeans		" 2013-02-22 (コメントがitalicになる)

"---------------------------------------------------------------------------
" フォント設定:
"
"if has('win32')
if s:iswin
  " Windows用
  set guifont=MS_Gothic:h10:cSHIFTJIS
"  set guifont=:M+_1m_regular:h10:cSHIFTJIS
endif

"---------------------------------------------------------------------------
" IMの設定:
"
if s:ismac
  set noimdisableactivate
endif

"---------------------------------------------------------------------------
" ウインドウに関する設定:
"
" ウインドウの幅
"set columns=100
set columns=128
" ウインドウの高さ
"set lines=95
if s:iswin
  set lines=95
elseif s:ismac
  set lines=55
endif

"---------------------------------------------------------------------------
" マウスに関する設定:
"
" 解説:
" mousefocusは幾つか問題(一例:ウィンドウを分割しているラインにカーソルがあっ
" ている時の挙動)があるのでデフォルトでは設定しない。Windowsではmousehide
" が、マウスカーソルをVimのタイトルバーに置き日本語を入力するとチラチラする
" という問題を引き起す。
"
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
set guioptions-=a

"---------------------------------------------------------------------------
" その他、見栄えに関する設定:
"
" 半透明
if s:iswin
  autocmd VimEnter * set transparency=230
else
  set transparency=5
endif
"
" TAB等の表示色の指定 2003-06-17
"highlight SpecialKey guifg=#BBBBBB"	" 色テーマによっては指定済みなので削除
"
" カーソル行を下線でハイライトする 2010-06-10
"highlight CursorLine gui=underline guibg=NONE
"
" 全角スペースを強調表示 2010-06-23
"highlight ZenkakuSpace gui=underline guibg=NONE
highlight ZenkakuSpace ctermbg=gray guibg=gray
match ZenkakuSpace /　/
" コマンドラインからは上手くいくが設定ファイルで指定だと反映されない（謎）
" ↑ファイルの日本語エンコーディングをUTF-8にすると反映された

"---------------------------------------------------------------------------
" 印刷に関する設定:
"
" 注釈:
" 印刷はGUIでなくてもできるのでvimrcで設定したほうが良いかもしれない。この辺
" りはWindowsではかなり曖昧。一般的に印刷には明朝、と言われることがあるらし
" いのでデフォルトフォントは明朝にしておく。ゴシックを使いたい場合はコメント
" アウトしてあるprintfontを参考に。
"
" 参考:
"   :hardcopy
"   :help 'printfont'
"   :help printing
"
" 印刷用フォント
if has('printer')
  if has('win32')
    set printfont=MS_Mincho:h9:cSHIFTJIS
  endif
endif

"---------------------------------------------------------------------------
" ステータスラインに文字コードと改行文字の種別を表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

" end of _gvimrc
