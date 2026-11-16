const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const handlers = {};
const sent = [];
const canvas = {tagName:'CANVAS', dispatchEvent: e => sent.push(e)};
class PointerEvent { constructor(type, init) { this.type=type; Object.assign(this,init); } }
const document = {addEventListener: (name, fn, options) => {assert.equal(options.capture,true); assert.equal(options.passive,true); handlers[name]=fn;}};
vm.runInNewContext(fs.readFileSync(__dirname + '/touch-position.js','utf8'), {document, PointerEvent});
const e = {isTrusted:true,pointerType:'touch',isPrimary:true,pointerId:9,clientX:140,clientY:85,screenX:140,screenY:85,buttons:1,pressure:0.5,composedPath:()=>[canvas]};
handlers.pointerdown(e); assert.equal(sent.length,1); assert.equal(sent[0].type,'pointermove'); assert.equal(sent[0].clientX,140); assert.equal(sent[0].pointerId,9);
handlers.pointerup({...e,clientX:210,buttons:0}); assert.equal(sent[1].clientX,210); assert.equal(sent[1].buttons,0);
handlers.pointerdown({...e,pointerType:'mouse'}); handlers.pointerdown({...e,isTrusted:false}); handlers.pointerdown({...e,isPrimary:false}); handlers.pointerdown({...e,composedPath:()=>[]}); assert.equal(sent.length,2);
console.log('Touch position candidate checks passed');
