# Mime library
**WARNING :** This library isn't done yet, some things are not implemented or do not work properly.

## Usage
```vlang
module main

import mime

fn main() {
    mime_str := "text/css"
    mime_type := mime.parse(mime_str)!
    // text
    println(mime_type.type)
    // css
    println(mime_type.subtype)
}
```