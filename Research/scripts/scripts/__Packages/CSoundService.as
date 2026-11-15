class CSoundService extends MovieClip
{
   var m_sounds;
   var m_soundsNames;
   var m_soundsState;
   var onEnterFrame;
   var parent;
   var sounID;
   var m_loopSoundID = -1;
   static var m_instance = null;
   var m_soundOff = false;
   static var ST_PLAY = -1;
   static var ST_STOP = 0;
   static var PLAY_OPT_ALWAYS = 0;
   static var PLAY_OPT_IFSTOP = 1;
   static var PLAY_OPT_STOPANDPLAY = 2;
   function CSoundService()
   {
      super();
   }
   function realPlaySound(id, repeatCount)
   {
      if(this.m_soundOff)
      {
         return undefined;
      }
      Sound(this.m_sounds[id]).start(0,repeatCount);
   }
   function processSounds()
   {
      var _loc2_ = 0;
      while(_loc2_ < this.m_sounds.length)
      {
         if(this.m_soundsState[_loc2_] > 0)
         {
            this.realPlaySound(_loc2_,this.m_soundsState[_loc2_]);
            this.m_soundsState[_loc2_] = ST_PLAY;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function init(soundNames)
   {
      this.m_soundsNames = soundNames;
      this.m_sounds = new Array(soundNames.length);
      this.m_soundsState = new Array(soundNames.length);
      var _loc2_ = 0;
      var _loc4_;
      var _loc3_;
      while(_loc2_ < soundNames.length)
      {
         _loc4_ = this.createEmptyMovieClip("_contMovie" + _loc2_,1000 + _loc2_);
         _loc3_ = new Sound(_loc4_);
         _loc3_.attachSound(soundNames[_loc2_]);
         this.m_soundsState[_loc2_] = ST_STOP;
         _loc3_.sounID = _loc2_;
         _loc3_.parent = m_instance;
         _loc3_.onSoundComplete = function()
         {
            this.parent.m_soundsState[this.sounID] = ST_STOP;
         };
         this.m_sounds[_loc2_] = _loc3_;
         _loc2_ = _loc2_ + 1;
      }
      this.onEnterFrame = this.processSounds;
   }
   static function createSoundService(soundNames, soundsPlace, depthInSoundsPlace)
   {
      m_instance = CSoundService(soundsPlace.attachMovie("dmSoundService","__SoundServiceObject",depthInSoundsPlace));
      m_instance.init(soundNames);
      return m_instance;
   }
   static function playLoopSound(soundID)
   {
      if(m_instance.m_loopSoundID >= 0 && m_instance.m_loopSoundID != soundID)
      {
         stopSound(m_instance.m_loopSoundID);
      }
      m_instance.m_loopSoundID = soundID;
      if(!soundIsPlay(m_instance.m_loopSoundID))
      {
         playCurLoopSound();
      }
   }
   static function playCurLoopSound()
   {
      playSound(m_instance.m_loopSoundID,true,9999);
   }
   static function stopCurLoopSound()
   {
      stopSound(m_instance.m_loopSoundID);
      m_instance.m_loopSoundID = -1;
   }
   static function soundOff()
   {
      var _loc1_ = 0;
      while(_loc1_ < m_instance.m_sounds.length)
      {
         stopSound(_loc1_);
         _loc1_ = _loc1_ + 1;
      }
      m_instance.m_soundOff = true;
   }
   static function soundOn()
   {
      m_instance.m_soundOff = false;
      if(m_instance.m_loopSoundID >= 0)
      {
         playCurLoopSound();
      }
   }
   static function soundIsPlay(id)
   {
      return m_instance.m_soundsState[id] != ST_STOP;
   }
   static function playSound(id, ifSoundStop, repeatCount)
   {
      if(repeatCount == undefined)
      {
         repeatCount = 1;
      }
      if(ifSoundStop == undefined)
      {
         ifSoundStop = false;
      }
      if(m_instance.m_soundOff)
      {
         return undefined;
      }
      if(ifSoundStop && soundIsPlay(id))
      {
         return undefined;
      }
      m_instance.m_soundsState[id] = repeatCount;
   }
   static function stopSound(id)
   {
      Sound(m_instance.m_sounds[id]).stop(m_instance.m_soundsNames[id]);
      m_instance.m_soundsState[id] = ST_STOP;
   }
   static function getSoundAt(soundNum)
   {
      return m_instance.m_sounds[soundNum];
   }
   static function soundIsOn()
   {
      return !m_instance.m_soundOff;
   }
   static function stopAllSound()
   {
      var _loc1_ = 0;
      while(_loc1_ < m_instance.m_sounds.length)
      {
         stopSound(_loc1_);
         _loc1_ = _loc1_ + 1;
      }
   }
}
