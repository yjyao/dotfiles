setlocal commentstring=//\ %s

" Go to related file (switch between c/h files).
nnoremap gr <Cmd>e %:p:s,.h$,.X123X,:s,.cc$,.h,:s,.X123X$,.cc,<CR>
