on(release){
   _parent._parent.numMap = 3;
   _parent.mcSelectedMap.gotoAndStop(3);
   CSoundService.playSound(Const.SND_SWITCH);
   _parent.gotoAndStop(2);
}
