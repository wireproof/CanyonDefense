on(release){
   CSoundService.playSound(Const.SND_SWITCH);
   _parent.numProgram = 1;
   _parent.numState = CGame.STATE_MISSION;
}
