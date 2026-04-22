



import http from 'http';

const server = http.createServer((req, res) => {
  const url = req.url;

  if (url === '/' || url === '/home') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Hello, World!, from 22222 - Home Page\n');
  } else if (url === '/about') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Hello, World!, from ap2 - About Page\n');
  } else {
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.end('Page not found\n');
  }
});



server.listen(22222, () => {
  console.log('Server running at http://localhost:22222/');
});