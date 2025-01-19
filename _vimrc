" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" プラグイン管理
call plug#begin('~/.vim/plugged')

" 必須プラグイン
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'            " ファイルエクスプローラー
Plug 'vim-airline/vim-airline'       " ステータスライン
Plug 'tpope/vim-commentary'          " コメントアウト支援
Plug 'psf/black', { 'branch': 'stable' } " Pythonのフォーマッタ
Plug 'jiangmiao/auto-pairs'          " 自動括弧補完
Plug 'scrooloose/syntastic'          " Lintingツール (補助用)
Plug 'joshdick/onedark.vim'          " OneDark カラースキーム

call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" 一般設定
syntax on
filetype plugin indent on
set number                   " 行番号を表示
set tabstop=4                " タブ幅
set shiftwidth=4             " 自動インデント幅
set expandtab                " タブをスペースに変換
set autoindent               " 自動インデント
set clipboard=unnamedplus    " クリップボードを共有
set mouse=a                  " マウス操作を有効にする
set cursorline               " 現在の行を強調表示

" 検索
set ignorecase               " 大文字小文字を無視
set smartcase                " 大文字を含む場合は区別
set incsearch                " インクリメンタル検索
set hlsearch                 " 検索結果をハイライト

" カラースキーム設定
set termguicolors            " 256色対応ターミナルを有効化
colorscheme onedark          " OneDark カラースキームを有効化

" coc.nvim 設定
" コマンド用キーバインド
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gr <Plug>(coc-references)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> K :call CocActionAsync('doHover')<CR>
" 自動補完
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" coc-settings.json を有効化するための設定
if has('nvim') || v:version > 800
  let g:coc_global_extensions = ['coc-pyright']
endif

" Python関連設定
augroup python
  autocmd!
  autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType python nmap <leader>f :Black<CR> " Blackフォーマッタを実行
augroup END

" NERDTree キーバインド
map <C-n> :NERDTreeToggle<CR>
