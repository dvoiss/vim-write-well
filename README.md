An exercise to get better at customizing VIM and learning Vimscript...

This plugin implements the writing rules listed by Matthew Might at his blog: [here](http://matt.might.net/articles/shell-scripts-for-passive-voice-weasel-words-duplicates/). The plugin operates on markdown files in the current buffer, to add other file types, add the following autocmd with the file-types you want to your .vimrc:

    autocmd Bufnewfile,Bufread *.myfiletype set ft=writewell

### Key mappings

- `<leader>hw` -- highlight "weasel words"
- `<leader>hp` -- highlight passive-irregular words
- `<leader>hi` -- highlight lexical illusions

The relevant words will be highlighted with the ERROR highlight color of your colorscheme, the quickfix window will open so you can jump to individual words.
