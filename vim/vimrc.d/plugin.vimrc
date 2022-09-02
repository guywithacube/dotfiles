"===========
" vim-plug (plugin manager)
"===========
" Download and install vim-plug (if necessary)
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	if v:shell_error
		echo 'A problem occured while downloading vim-plug'
		finish
	else
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
endif

call plug#begin("~/.vim/plugged")
	" NERDTree
	Plug 'scrooloose/nerdtree'
	Plug 'Xuyuanp/nerdtree-git-plugin'
	" NERDCommenter
	Plug 'scrooloose/nerdcommenter'

	" Status bar
	Plug 'itchyny/lightline.vim'
	" Git side-bar status
	Plug 'airblade/vim-gitgutter'
	" Move panes with <Leader>ww
	Plug 'wesQ3/vim-windowswap'

	" Color scheme
	Plug 'dracula/vim',{'as':'dracula'}
call plug#end()

"==========
" NERDTree
"==========
" Minimize clutter
let NERDTreeMinimalUI = 1

" https://www.mokacoding.com/blog/nerdtree-relative-numbers/
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

" Auto-start
autocmd vimenter * call AutoStartNERDTree()
function AutoStartNERDTree()
	if !exists(":NERDTree")
		echo "NERDTree is not installed"
		return 0
	endif
	if (@% =~ "-fc.") " case where Vim was opened because of fc (used by GNU Readline)
		echo "NERDTree ignored; in 'fc' mode"
		return 0
	endif
	if (exists("b:NERDTree")) " case where directory was opened first
		echo "NERDTree ignored; it is already open"
		return 0
	endif
	let height = str2float(&columns)
	let width = str2float(&lines)
	if (((height >= 80) && (width >= 24))) " case where terminal is larger than 24x80
		NERDTree " open NERDTree
		wincmd w " move cursor
		echo "NERDTree auto started"
	else " case where terminal is smaller than 24x80
		echo "NERDTree ignored; window too small"
	endif
endfunction

" Auto-close if last buffer
" https://github.com/scrooloose/nerdtree/issues/21
autocmd bufenter * call AutoCloseNERDTree()
function AutoCloseNERDTree()
	if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree())
		q
	endif
endfunction
