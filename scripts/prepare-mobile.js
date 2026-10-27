'use strict';
const fs = require('node:fs');
const path = require('node:path');
const root = path.resolve(__dirname, '..');
const www = path.join(root, 'www');
fs.rmSync(www, { recursive: true, force: true });
fs.mkdirSync(www, { recursive: true });
for (const file of ['index.html', 'app.js', 'one-shots.json']) {
  const from = path.join(root, file);
  if (!fs.existsSync(from) || !fs.statSync(from).isFile()) {
    throw new Error(`Required web asset missing: ${file}`);
  }
  fs.copyFileSync(from, path.join(www, file));
}
JSON.parse(fs.readFileSync(path.join(www, 'one-shots.json'), 'utf8'));
JSON.parse(fs.readFileSync(path.join(root, 'capacitor.config.json'), 'utf8'));
console.log('Prepared Capacitor assets: index.html, app.js, one-shots.json');
