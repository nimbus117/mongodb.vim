Specify the connection string to use with `b:db` or `g:db`.

```vim
let b:db = "mongodb://host/database"
```

Use `:DB` to execute the current buffer line using the [mongo
shell](https://www.mongodb.com/docs/mongodb-shell/) and show the results in a
vertical split, takes a range.

`:Mongo` opens a buffer named './vim.mongo.js' with collection method
autocompletion `<c-x><c-u>` and maps `<c-j>` to execute the current line `:.DB`
in normal mode and the highlighted range in visual mode `'<,'>:DB`.
