# Write Well.

A VIM plugin which implements the [academic writing rules of Matthew Might](http://matt.might.net/articles/shell-scripts-for-passive-voice-weasel-words-duplicates/). I wrote the plugin to get a better grasp of Vimscript &emdash; it is a proof of concept more than anything else and currently operates on the current buffer.

### Key mappings

- `<leader>hw` &emdash; highlight "weasel words"
- `<leader>hp` &emdash; highlight passive-irregular words
- `<leader>hi` &emdash; highlight lexical illusions (view screenshot below)

### .vimrc options

The following global variables can be added to a user's .vimrc file:
    let g:WW#WEASEL_WORDS="obviously|(of course)"
    let g:WW#PASSIVE_WORDS="threw"

These words are appended to the already defined words in the plugin:

    if exists("g:WW#WEASEL_WORDS")
      let s:weasels = s:weasels . '|' . g:WW#WEASEL_WORDS
    endif