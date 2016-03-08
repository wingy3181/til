" vimrc for til

" In order for this file to be loaded by Vim, the main `.vimrc` file must
" contain `set exrc` and optionally `set secure`. Without those lines, Vim
" will ignore this file.

" `set exrc` allows per-directory .vimrc configurations. However, this may
" be a security problem. Therefore, `set secure` should be set as well
" which prevents shell and write commands.
" See http://vimdoc.sourceforge.net/htmldoc/options.html#'secure' for more
" information

" NOTE: Run dos2unix on Window systems if you have errors loading this .vimrc
" file

function! CountTILs()
    " vim substitute that counts '- [' matches
    " See http://vim.wikia.com/wiki/Count_number_of_matches_of_a_pattern
    execute '%s/^- \[//n'
endfunction

" 'normal' mode mapping of keys to \ + c and <cr> means carriage return,
" otherwise command won't get executed.
" See http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1) for
" more information
nnoremap <leader>c :call CountTILs()<cr>
