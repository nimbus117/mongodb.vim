Specify the connection string to use with `b:db` or `g:db`.

```
let b:db = "mongodb://host/database"
```

Use `:DB` to execute the contents of the current buffer against the database,
takes a range.

`:Mongo` opens a buffer named './vim.mongo.js' and maps `<c-j>` to execute the
current line `.DB` in normal mode and the highlighted range in visual mode
`'<,'>:DB`.




Add
===

autocomplete of table names

autocomplete methods od tables

autocomplete methods on cursor
