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

" Map "qq" to quit all
nnoremap qq :q<CR>

" Map "qa" to quit all
nnoremap qa :qa<CR>

