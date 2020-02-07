:set laststatus=2
set statusline=[%{expand('%:p')}][%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\ %{strlen(&filetype)?&filetype:'plain'}]%{FileSize()}%{IsBinary()}%=%c,%l/%L\ [%3p%%]
function IsBinary()
    if (&binary == 0)
        return ""
    else
        return "[Binary]"
    endif
endfunction
function FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return "[Empty]"
    endif
    if bytes < 1024
        return "[" . bytes . "B]"
    elseif bytes < 1048576
        return "[" . (bytes / 1024) . "KB]"
    else
        return "[" . (bytes / 1048576) . "MB]"
    endif
endfunction
set statusline=%#filepath#[%{expand('%:p')}]%#filetype#[%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\ %{strlen(&filetype)?&filetype:'plain'}]%#filesize#%{FileSize()}%{IsBinary()}%=%#position#%c,%l/%L\ [%3p%%]
hi filepath cterm=none ctermbg=238 ctermfg=117
hi filetype cterm=none ctermbg=238 ctermfg=45
hi filesize cterm=none ctermbg=238 ctermfg=225
hi position cterm=none ctermbg=238 ctermfg=204
	"狀態列"

:syntax on
:set autoread
	"自動偵測外部修改"
:set number
	"行號"
:set ai	
	"自動對齊縮排"
:set cursorline
	"行：底線"
:set cursorcolumn
	"顯示目前列"
:set tabstop=4
	"縮排間隔數"
:set mouse=a
	"啟用游標選取"
:set encoding=utf-8
	"UTF-8編碼"
:set clipboard=unnamed
	"剪貼簿"


:set t_Co=256
	"最大顏色數"
hi LineNr ctermfg=202
	"行號設置"
hi CursorLine ctermbg=94
	"行設置"
hi CursorColumn ctermbg=202
	"列設置"
hi Search cterm=reverse ctermbg=none ctermfg=none
	"搜尋結果設置（反白）"

map <F5> :call SaveFile()<CR>
func! SaveFile()
    exec "w"
endfunc

map <F6> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc
