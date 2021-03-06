" Write Well.
" based on Matthew Might's article:
" http://matt.might.net/articles/
"   shell-scripts-for-passive-voice-weasel-words-duplicates/
" URL: http://github.com/dvoiss

if exists("b:writewell_plugin")
  finish
endif
let b:writewell_plugin = 1

" Variables {{{
let s:TOGGLE_WEASEL = 1
let s:TOGGLE_PASSIVE = 2
let s:TOGGLE_ILLUSION = 3

let s:toggle = 0
let s:window = 0
" }}}

" FIND WEASEL WORDS {{{
" =================

let s:weasels="many|various|very|fairly|several|extremely|"
      \ . "exceedingly|quite|remarkably|few|surprisingly|mostly|largely|huge|"
      \ . "tiny|is a number|excellent|interestingly|significantly|"
      \ . "substantially|clearly|vast|relatively|completely"

" if the user wants to append their own weasel words,
" set g:WW#WEASEL_WORDS in vimrc
if exists("g:WW#WEASEL_WORDS")
  let s:weasels = s:weasels . '|' . g:WW#WEASEL_WORDS
endif

if !hasmapto('<Plug>HighlightWeaselWords')
  map <unique> <Leader>hw <Plug>HighlightWeaselWords
endif
noremap <unique> <script> <Plug>HighlightWeaselWords
      \ <SID>HighlightWeaselWords2
noremap <SID>HighlightWeaselWords2 :call <SID>HighlightWeaselWords()<cr>

function! s:HighlightWeaselWords()
  if s:toggle != s:TOGGLE_WEASEL
    execute ':match Error /\v\c<(' . s:weasels . ')>/'
    silent! execute ':vimgrep! /\v\c<(' . s:weasels . ')>/j %'

    if len(getqflist()) > 0
      call s:Open(s:TOGGLE_WEASEL)
    else
      call s:Reset()
    endif
  else
    call s:Reset()
  endif
endfunction " }}}

" FIND PASSIVE VOICE {{{
" ==================

" find the passive voice
let s:irregulars="awoken|been|born|beat|become|begun|bent|beset|bet|bidden|"
  \ . "bid|bound|bitten|bled|blown|broken|bred|brought|broadcast|built|burnt|"
  \ . "burst|bought|cast|caught|chosen|clung|come|cost|crept|cut|dealt|dug|"
  \ . "dived|done|drawn|dreamt|driven|drunk|eaten|fallen|fed|felt|fought|found|"
  \ . "fit|fled|flung|flown|forbidden|forgotten|foregone|forgiven|forsaken|"
  \ . "frozen|gotten|given|gone|ground|grown|hung|heard|hidden|hit|held|hurt|"
  \ . "kept|knelt|knit|known|laid|led|leapt|learnt|left|lent|let|lain|lighted|"
  \ . "lost|made|meant|met|misspelt|mistaken|mown|overcome|overdone|overtaken|"
  \ . "overthrown|paid|pled|proven|put|quit|read|ridden|rid|rung|risen|run|sawn|"
  \ . "said|seen|sought|sold|sent|set|sewn|shaken|shaven|shorn|shed|shone|shod|"
  \ . "shot|shown|shrunk|shut|sung|sunk|sat|slept|slain|slid|slung|slit|smitten|"
  \ . "sown|spoken|sped|spent|spilt|spun|spit|split|spread|sprung|stood|stolen|"
  \ . "stuck|stung|stunk|stridden|struck|strung|striven|sworn|swept|swollen|"
  \ . "swum|swung|taken|taught|torn|told|thought|thrived|thrown|thrust|trodden|"
  \ . "understood|upheld|upset|woken|worn|woven|wed|wept|wound|won|withheld|"
  \ . "withstood|wrung|written"

" if the user wants to append their own passive words,
" set g:WW#PASSIVE_WORDS in vimrc
if exists("g:WW#PASSIVE_WORDS")
  let s:irregulars = s:irregulars . '|' . g:WW#PASSIVE_WORDS
endif

if !hasmapto('<Plug>HighlightPassiveVoice')
  map <unique> <Leader>hp <Plug>HighlightPassiveVoice
endif
noremap <unique> <script> <Plug>HighlightPassiveVoice
      \ <SID>HighlightPassiveVoice
noremap <SID>HighlightPassiveVoice :call <SID>HighlightPassiveVoice()<cr>

function! s:HighlightPassiveVoice()
  if s:toggle != s:TOGGLE_PASSIVE
    execute ':match Error /\v\c<(' . s:irregulars . ')>/'
    silent! execute ':vimgrep! /\v\c<(' . s:irregulars . ')>/j %'

    if len(getqflist()) > 0
      call s:Open(s:TOGGLE_PASSIVE)
    else
      call s:Reset()
    end
  else
    call s:Reset()
  endif
endfunction " }}}

" FIND LEXICAL ILLUSIONS {{{
" ======================

if !hasmapto('<Plug>HighlightIllusions')
  map <unique> <Leader>hi <Plug>HighlightIllusions
endif

noremap <unique> <script> <Plug>HighlightIllusions <SID>HighlightIllusions
noremap <SID>HighlightIllusions :call <SID>HighlightIllusions()<cr>

function! s:HighlightIllusions()
  if s:toggle != s:TOGGLE_ILLUSION
    let line_num = 0
    let last_word = ''
    let match_list = []

    while line_num <= line("$")
      let words = split(getline(line_num))

      for word in words
        if last_word ==? word
          " match any entries in the form:
          " 'word word', '  word   word word', 'word\n  word'
          let entry = '(<' . word . '>((\s|\n)+<' . word . '>)+)'
          if index(match_list, entry) == -1
            let match_list = add(match_list, entry)
          endif
        endif

        if strlen(word) != 0
          let last_word = word
        endif
      endfor

      let line_num = line_num + 1
    endwhile

    if len(match_list) != 0
      execute ':match Error /\v\c' . join(match_list, '|') . '/'
      silent! execute ':vimgrep! /\v\c' . join(match_list, '|') . '/j %'
    endif

    if len(getqflist()) > 0
      call s:Open(s:TOGGLE_ILLUSION)
    else
      call s:Reset()
    endif
  else
    call s:Reset()
  endif
endfunction " }}}

" Open Function {{{
function! s:Open(toggle_value)
  let s:toggle = a:toggle_value
  let s:window = winnr()
  copen
endfunction
" }}}

" Reset Function {{{
function! s:Reset()
  let s:toggle = 0
  execute s:window . "wincmd w | match none"
  cclose
endfunction
" }}}

" Commands {{{
command! -bang -bar HighlightWeaselWords call s:HighlightWeaselWords()
command! -bang -bar HighlightPassiveVoice call s:HighlightPassiveVoice()
command! -bang -bar HighlightIllusions call s:HighlightIllusions()
" }}}