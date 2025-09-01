# V MIME library

## Why?
The standard V MIME library is just a big library of IANA's accepted types. It provides nothing to parse them, which is problematic if an application is using non-standard types, or types with parameters.

## Todo
- [x] Parsing
- [ ] Serializing

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
