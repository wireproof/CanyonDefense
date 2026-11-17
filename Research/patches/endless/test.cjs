const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const source = fs.readFileSync(__dirname + '/scripts/__Packages/CGame.as','utf8');
function method(name) {
  const match = source.match(new RegExp('function '+name+'\\(([^)]*)\\)\\s*\\{'));
  assert.ok(match, name);
  let i=match.index+match[0].length, start=i, depth=1;
  while(depth && i<source.length){if(source[i]==='{') depth++; else if(source[i]==='}') depth--; i++;}
  assert.equal(depth,0);
  return vm.runInNewContext('(function('+match[1]+'){'+source.slice(start,i-1)+'})', {PROGRAMS, Math, CSoundService:{playSound(){}},Const:{SND_SWITCH:1}});
}
const original = Array.from({length:12},(_,i)=>({alt:i%2+1,qty:2,size:1,level:i+1}));
const PROGRAMS=[original];
const getWaveAt=method('getWaveAt');
const game={_numProgram:0,_boolEndless:false};
assert.equal(getWaveAt.call(game,11),original[11]);
assert.equal(getWaveAt.call(game,12),undefined);
game._boolEndless=true;
for(let i=12;i<10012;i++){const wave=getWaveAt.call(game,i);assert.ok(wave);assert.ok(wave.level>=1 && wave.level<=50);assert.ok(wave.qty>0);}
assert.equal(original.length,12);assert.equal(original[2].level,3);
const events=[];const towers={kept:true};
const g={_mapCurrent:{towers},_numProgramPtr:12,_numEnemiesTimer:99,_mcGameOverDialog:{removeMovieClip(){events.push('close')}},_mcMissionUI:{textScreen:{},textTimer:{},_btnStartAttack:{},switchServiceButtonsVisibility(x){events.push(x)}},getWaveAt:i=>({wave:i}),updateWaveScreen:w=>events.push(w.wave)};
method('startFreePlay').call(g);
assert.equal(g._boolEndless,true);assert.equal(g._numEnemiesTimer,0);assert.equal(g.boolPaused,false);assert.equal(g._mcMissionUI._btnStartAttack._visible,true);assert.equal(g._mapCurrent.towers,towers);assert.deepEqual(events,['close',true,12]);
assert.equal((source.match(/!this\._boolEndless && this\._numProgramPtr >= PROGRAMS\[this\._numProgram\]\.length/g)||[]).length,3);
assert.ok(source.includes('this._numProgramPtr < PROGRAMS[this._numProgram].length || this._boolEndless'));
console.log('Free Play wave and transition checks passed');
