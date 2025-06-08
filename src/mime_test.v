module mime

fn test_parse() {
	assert parse("text/html")! == MimeType{
		type: "text"
		subtype: "html"
		parameters: {}
	}
	assert parse("audio/webm;codecs=av4")! == MimeType{
		type: "audio"
		subtype: "webm"
		parameters: {
			"codecs": "av4"
		}
	}
	assert parse('video/mp4; codecs="avc1.640020"')! == MimeType{
		type: "video"
		subtype: "mp4"
		parameters: {
			"codecs": "avc1.640020"
		}
	}
}