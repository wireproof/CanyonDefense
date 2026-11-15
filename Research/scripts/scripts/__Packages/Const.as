class Const
{
   static var TRACE_DEBUG_INFO = false;
   static var DISABLE_QUESTS = false;
   static var MATRIX_CELL_WIDTH = 32;
   static var MATRIX_CELL_HEIGHT = 32;
   static var MATRIX_WIDTH = 14;
   static var MATRIX_HEIGHT = 14;
   static var SOUND_NAMES = new Array("snd_mainLoop","snd_quest","snd_error","snd_nuclearExplosion","snd_switch","snd_popDead","snd_nuclearLaunch","snd_timeStop","snd_construction","snd_sell","snd_bigExplosion","snd_mediumExplosion","snd_smallExplosion","snd_NulificatorShot","snd_teslaTowerShot","snd_gaussCannonShot","snd_gutlingLaserShot","snd_oilSprayShot","snd_chainGunShot","snd_gooCannonShot","snd_mortarShot","snd_aaGunShot","snd_missileTurretShot","snd_hit");
   static var SND_MAINLOOP = 0;
   static var SND_QUEST = 1;
   static var SND_ERROR = 2;
   static var SND_NUCLEAREXPLOSION = 3;
   static var SND_SWITCH = 4;
   static var SND_POPDEAD = 5;
   static var SND_NUCLEARLAUNCH = 6;
   static var SND_TIMESTOP = 7;
   static var SND_CONSTRUCTION = 8;
   static var SND_SELL = 9;
   static var SND_BIGEXPLOSION = 10;
   static var SND_MEDIUMEXPLOSION = 11;
   static var SND_SMALLEXPLOSION = 12;
   static var SND_NULIFICATORSHOT = 13;
   static var SND_TESLATOWERSHOT = 14;
   static var SND_GAUSSCANNONSHOT = 15;
   static var SND_GUTLINGLASERSHOT = 16;
   static var SND_OILSPRAYSHOT = 17;
   static var SND_CHAINGUNSHOT = 18;
   static var SND_GOOCANNONSHOT = 19;
   static var SND_MORTARSHOT = 20;
   static var SND_AAGUNSHOT = 21;
   static var SND_MISSILETURRETSHOT = 22;
   static var SND_HIT = 23;
   function Const()
   {
   }
   static function TRACE(__strMessage)
   {
      if(TRACE_DEBUG_INFO)
      {
         trace(__strMessage);
      }
   }
}
