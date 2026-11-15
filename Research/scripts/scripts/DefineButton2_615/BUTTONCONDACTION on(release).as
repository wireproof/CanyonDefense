on(release){
   _parent._parent.numMap = 1;
   _parent.mcSelectedMap.gotoAndStop(1);
   CSoundService.playSound(Const.SND_SWITCH);
   _parent.gotoAndStop(2);
}
