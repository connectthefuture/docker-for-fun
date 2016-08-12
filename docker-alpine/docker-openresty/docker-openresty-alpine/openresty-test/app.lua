	ngx.header.content_type = 'text/plain;boundary=22222';

    ngx.say()
	
	ngx.say('Hello World! 王八蛋11'..ngx.req.raw_header())
    ngx.exit(200)