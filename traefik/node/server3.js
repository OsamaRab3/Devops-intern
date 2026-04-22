



import http from 'http';

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello, World!, from 3333\n');
});



server.listen(3333, () => {
  console.log('Server running at http://localhost:3333/');
});