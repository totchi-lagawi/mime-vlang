module mime

fn test_parse() {
	assert parse("text/html")! == MimeType{
		type: "text"
		subtype: "html"
		parameters: map[string]string{}
	}
	assert parse("audio/webm;codec=av4")! == MimeType{
		type: "audio"
		subtype: "webm"
		parameters: {
			"codec": "av4"
		}
	}
}