  let g:prettier#config#bracket_spacing = 'true'
  let g:prettier#config#jsx_bracket_same_line = 'false'
  let g:prettier#autoformat = 0

  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.py PrettierAsync
