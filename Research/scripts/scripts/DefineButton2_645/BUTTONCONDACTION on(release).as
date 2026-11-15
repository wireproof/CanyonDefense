on(release){
   CSoundService.playSound(Const.SND_SWITCH);
   _parent.numProgram = 2;
   _parent.numState = CGame.STATE_MISSION;
}
