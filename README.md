# Write Well.

A VIM plugin which implements the [academic writing rules of Matthew Might](http://matt.might.net/articles/shell-scripts-for-passive-voice-weasel-words-duplicates/). I wrote the plugin to get a better grasp of Vimscript -- it is a proof of concept.

The plugin operates on markdown files in the current buffer, to add other file types, add the following autocmd with the file-types you want to your .vimrc:

    autocmd Bufnewfile,Bufread *.myfiletype set ft=writewell

### Key mappings

- `<leader>hw` -- highlight "weasel words"
- `<leader>hp` -- highlight passive-irregular words
- `<leader>hi` -- highlight lexical illusions

### .vimrc options

The following global variables can be added to a user's .vimrc file:

    let g:WW#WEASEL_WORDS="obviously|(of course)"
    let g:WW#PASSIVE_WORDS="threw"

These words are appended to the already defined words in the plugin:

    if exists("g:WW#WEASEL_WORDS")
      let s:weasels = s:weasels . '|' . g:WW#WEASEL_WORDS
    endif
