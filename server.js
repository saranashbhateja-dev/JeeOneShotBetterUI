'use strict';
const http = require('node:http');
const fs = require('node:fs');
const path = require('node:path');
const { URL } = require('node:url');
const ROOT = __dirname;
const PORT = Number(process.env.PORT || 3001);
const HOST = process.env.HOST || '127.0.0.1';
const MIME = { '.html':'text/html; charset=utf-8', '.js':'text/javascript; charset=utf-8', '.json':'application/json; charset=utf-8', '.css':'text/css; charset=utf-8', '.svg':'image/svg+xml', '.png':'image/png', '.ico':'image/x-icon' };
const server = http.createServer((req,res)=>{
  if (req.method !== 'GET' && req.method !== 'HEAD') { res.writeHead(405, {'Allow':'GET, HEAD'}); return res.end('Method not allowed'); }
  let pathname;
  try { pathname = decodeURIComponent(new URL(req.url, `http://${req.headers.host||'localhost'}`).pathname); }
  catch { res.writeHead(400); return res.end('Bad request'); }
  if (pathname === '/') pathname='/index.html';
  const resolved = path.resolve(ROOT, '.' + pathname);
  if (resolved !== ROOT && !resolved.startsWith(ROOT + path.sep)) { res.writeHead(403); return res.end('Forbidden'); }
  fs.stat(resolved,(err,stat)=>{
    if(err||!stat.isFile()){res.writeHead(404,{'Content-Type':'text/plain; charset=utf-8'});return res.end('Not found');}
    res.writeHead(200,{'Content-Type':MIME[path.extname(resolved).toLowerCase()]||'application/octet-stream','Cache-Control':'no-cache','X-Content-Type-Options':'nosniff','Referrer-Policy':'strict-origin-when-cross-origin'});
    if(req.method==='HEAD')return res.end();
    fs.createReadStream(resolved).pipe(res);
  });
});
server.listen(PORT,HOST,()=>console.log(`JEE OneShot OS is running at http://${HOST}:${PORT}`));
server.on('error',e=>{console.error(`Could not start server: ${e.message}`);process.exitCode=1;});
