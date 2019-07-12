" X-do and return cursor
"===========
" Similar to default x-do but returns cursor to last position 
" https://vim.fandom.com/wiki/Run_a_command_in_multiple_buffers
if !(exists("*WinDo"))
	function! WinDo(command)
		let currwin=winnr()
		let curaltwin=winnr('#')
		execute 'windo ' . a:command
		" restore previous/alt window
		execute curaltwin . 'wincmd w'
		" restore current windo
		execute currwin . 'wincmd w'
	endfunction
	com! -nargs=+ -complete=command Windo call WinDo(<q-args>)
endif

if !(exists("*BufDo"))
	function! BufDo(command)
		let currBuff=bufnr("%")
		execute 'bufdo ' . a:command
		execute 'buffer ' . currBuff
	endfunction
	com! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)
endif

if !(exists("*TabDo"))
	function TabDo(command)
		let currTab=tabpagenr()
		execute 'tabdo ' . a:command
		execute 'tabn ' . currTab
	endfunction
	com! -nargs=+ -complete=command Tabdo call TabDo(<q-args>)
endif
