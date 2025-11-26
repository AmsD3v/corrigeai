from http.server import HTTPServer, BaseHTTPRequestHandler

class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b'Hello, world!')

httpd = HTTPServer(('0.0.0.0', 8000), SimpleHTTPRequestHandler)
print("Serving on port 8000...")
httpd.serve_forever()
