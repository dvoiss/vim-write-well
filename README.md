An exercise to get better at customizing VIM and learning Vimscript...

This plugin implements the writing rules listed by Matthew Might at this blog: [here](http://matt.might.net/articles/shell-scripts-for-passive-voice-weasel-words-duplicates/). The plugin operates on markdown files in the current buffer, to add other file types, add the following autocmd with the file-types you want to your .vimrc:

    autocmd Bufnewfile,Bufread *.myfiletype set ft=writewell

### Key mappings

- `<leader>hw` -- highlight "weasel words"
- `<leader>hp` -- highlight passive-irregular words
- `<leader>hi` -- highlight lexical illusions

The relevant words will be highlighted with the ERROR highlight color of your colorscheme, the quickfix window will open so you can jump to individual words.

### .vimrc options

The following global variables can be added to a user's .vimrc file:

    let g:WW#WEASEL_WORDS="obviously|(of course)"
    let g:WW#PASSIVE_WORDS="threw"

These words are appended to the already defined words in the plugin:

    if exists("g:WW#WEASEL_WORDS")
      let s:weasels = s:weasels . '|' . g:WW#WEASEL_WORDS
    endif
