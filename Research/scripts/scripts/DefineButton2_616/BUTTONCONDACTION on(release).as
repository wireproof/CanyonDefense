on(release){
   _parent._parent.numMap = 2;
   _parent.mcSelectedMap.gotoAndStop(2);
   CSoundService.playSound(Const.SND_SWITCH);
   _parent.gotoAndStop(2);
}
