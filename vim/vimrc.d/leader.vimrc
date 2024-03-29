"===========
" Leader commands
"===========
" <Leader>rc to quickly reload .vimrc
map <Leader>rc :Tabdo so $MYVIMRC <CR> :echom "Reloaded .vimrc"<CR>

" <Leader>ne to quickly toggle NERDTree
map <Leader>ne :NERDTreeToggle <CR> :echom "Toggled NERDTree"<CR>

" <Leader>o to add newline without entering insert mode
" https://vi.stackexchange.com/a/3881
nnoremap <silent> <Leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <Leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" <Leader>qt to quickly open a terminal window
" https://vi.stackexchange.com/a/16800
map <Leader>qt :<C-u>call QuickTerm()<CR>
function QuickTerm()
	" Move to very most bottom right window
	wincmd b
	let height = str2nr(&columns)
	let newHeight = string(height / 12)
	execute "below terminal ++close ++rows=" . newHeight

	echo "Opened new terminal (height: " . newHeight . ")"
endfunction

" <Leader>tt to quickly open a new tab
map <Leader>tt :<C-u>tabnew<CR>

" <Leader>li to toggle list mode (see :help 'list')
map <silent> <Leader>li
	\ :<C-u>
		\ Tabdo windo
		\ if &modifiable \|
			\ set list! \|
		\ endif
	\ <CR>

" <Leader>nu to toggle line numbers
map <silent> <Leader>nu
	\ :<C-u>
		\ Tabdo windo
		\ if &modifiable \|
			\ set number! \|
		\ endif
	\ <CR>
