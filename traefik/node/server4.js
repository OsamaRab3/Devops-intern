import http from 'http';

const server = http.createServer((req, res) => {
  const url = req.url;

  if (url === '/' || url === '/home') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Admin Dashboard - Home Page\n');
  } else if (url === '/stats') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Admin Stats Page\n');
  } else {
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.end('Page not found\n');
  }
});

server.listen(9000, () => {
  console.log('Admin server running at http://localhost:9000/');
});
