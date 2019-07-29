"===========
" Binds
"===========
" Map Control+S to save
" normal mode
nmap <C-s> :update<CR>
imap <C-s> <Esc>:update<CR>

" Quick movement between splits
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Map Control+Left/Right to move between tabs
" https://superuser.com/a/884981
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Map Control+Up/Down to re-order tabs
noremap <C-Up> :<C-u>call TabMove("left")<CR>
noremap <C-Down> :<C-u>call TabMove("right")<CR>
" Normal tabmove does not wrap-around like tabprevious/tabnext.
" Custom TabMove to add wrap-around functionality.
" https://vi.stackexchange.com/a/3813
function TabMove(direction)
	let curTab = tabpagenr()
	let numTabs = tabpagenr("$")
	if (a:direction == "left")
		if (curTab == 1)
			execute "tabmove " . numTabs
		else
			execute "tabmove -1"
		endif
	elseif (a:direction == "right")
		if (curTab == numTabs)
			execute "tabmove 0"
		else
			execute "tabmove +1"
		endif
	endif
endfunction

" Map "qq" to quit
nnoremap qq :q<CR>

" Map "qa" to quit all
nnoremap qa :qa<CR>

" Map "jk" to ESC
" insert mode
inoremap jk <Esc>
" command mode
cnoremap jk <ESC>
" Map "JK" to ESC
" visual mode
vnoremap JK <Esc>

