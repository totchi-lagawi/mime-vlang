module mime

pub struct MimeType {
pub mut:
	type string
	subtype string
	essence string
	parameters map[string]string
}

pub fn (mime_type MimeType) str() string {
	return ""
}

pub fn parse(str string) !MimeType {
	mut type := ""
	mut pos := 0
	for pos < str.len && str[pos] != `/` {
		type += str[pos].ascii_str()
		pos++
	}

	if type.len == 0 {
		return error("malformed MIME type (empty type)")
	}

	// if !contains_only_http_token_point_code(type) {
	// 	return error("malformed MIME type (invalid character in type)")
	// }

	if pos >= str.len {
		return error("malformed MIME type (no subtype)")
	}

	type = type.to_lower_ascii()

	pos++

	mut subtype := ""
	for pos < str.len && str[pos] != `;` {
		subtype += str[pos].ascii_str()
		pos++
	}

	if subtype.len == 0 {
		return error("malformed MIME type (empty subtype)")
	}

	// if !contains_only_http_token_point_code(subtype) {
	// 	return error("malformed MIME type (invalid character in subtype)")
	// }

	subtype = subtype.to_lower_ascii()

	mut parameters := map[string]string{}

	for pos < str.len {
		pos++

		for str[pos] == ` ` || str[pos] == `\n` || str[pos] == `\t` || str[pos] == `\r` {
			pos++
		}

		mut param_name := ""
		for pos < str.len && str[pos] != `;` && str[pos] != `=` {
			param_name += str[pos].ascii_str()
			pos++
		}
		param_name = param_name.to_lower()

		if pos < str.len {
			if str[pos] == `;` {
				continue
			}

			pos++
		}

		mut param_value := ""
		if str[pos] == `"` {
			for pos < str.len && str[pos] != `"` {
				pos++
				param_value += str[pos].ascii_str()
				
			}
			for pos < str.len && str[pos] != `;` {
				pos++
			}
		} else {
			for pos < str.len && str[pos] != `;` {
				param_value += str[pos].ascii_str()
				pos++
			}
			param_value = param_value.trim(" ")
			if param_value == "" {
				continue
			}
		}

		if param_name != "" && !parameters.keys().contains(param_name) {
			parameters[param_name] = param_value
		}
	}
	
	return MimeType{
		type: type
		subtype: subtype
		parameters: parameters
	}
}

// FIXME
// fn contains_only_http_token_point_code(str string) bool {
// 	return str.match_glob("[-!#$%&'*+.^_`|~A-Za-z0-9]*")
// }

// fn contains_only_http_quoted_token_point_code(str string) bool {
// 	return str.match_glob("[-!#$%&'*+.^_`|~A-Za-z0-9]*")
// }