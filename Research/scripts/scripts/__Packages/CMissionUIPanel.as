class CMissionUIPanel extends CEventMovieClip
{
   var _boolEnabled;
   var _btnQuit;
   var _btnStartAttack;
   var _mcBtnAbility1;
   var _mcBtnAbility2;
   var _mcBtnAbility3;
   var _mcBtnAbility4;
   var _mcErrorBlink;
   var _mcPauseSwitch;
   var _mcSoundSwitch;
   var _mcTabButton1;
   var _mcTabButton2;
   var _mcTabButton3;
   var _numCurrentTab;
   var _visible;
   var numMessageTimer;
   var onEnterFrame;
   var textMessage;
   var textScreen;
   var textTimer;
   static var TABBUTTON_NAME_BASE = "_mcTabButton";
   static var TABPAGE_NAME_BASE = "_mcTabPage";
   static var FRAME_NAME_BASE = "_mcFrame";
   static var TABS_NUMBER = 3;
   static var BB_STATE_HIDE = 1;
   static var BB_STATE_QUEST = 2;
   static var BB_STATE_SHOW = 3;
   static var MESSAGE_DELAY = 48;
   function CMissionUIPanel()
   {
      super();
      Key.addListener(this);
      this.onEnterFrame = this.oefInit;
   }
   function get boolEnabled()
   {
      return this._boolEnabled;
   }
   function set boolEnabled(__boolValue)
   {
      this._boolEnabled = __boolValue;
      this._btnStartAttack._visible = this._boolEnabled;
   }
   function oefInit()
   {
      var _loc3_ = 1;
      var _loc2_;
      while(_loc3_ <= 3)
      {
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            if(Const.DISABLE_QUESTS)
            {
               this.changeBBState(_loc3_,_loc2_,BB_STATE_SHOW);
            }
            else
            {
               this.changeBBState(_loc3_,_loc2_,BB_STATE_HIDE);
            }
            _loc2_ = _loc2_ + 1;
         }
         _loc3_ = _loc3_ + 1;
      }
      this._mcBtnAbility1.strToolTip = "SELL";
      this._mcBtnAbility2.strToolTip = "LAUNCH MISSILE";
      this._mcBtnAbility3.strToolTip = "CONSTRUCT WALL";
      this._mcBtnAbility4.strToolTip = "STOP TIME";
      this.onTabChange(1);
      this._visible = true;
      this.textMessage._visible = false;
      this.boolEnabled = true;
      this.onEnterFrame = undefined;
   }
   function changeBBState(__numTabPage, __numButton, __numState)
   {
      var _loc2_ = CToggleButton(this[TABPAGE_NAME_BASE + __numTabPage]["_mcBtnBuilding" + __numButton]);
      switch(__numState)
      {
         case BB_STATE_HIDE:
            _loc2_._visible = false;
            _loc2_.boolEnabled = false;
            this[TABPAGE_NAME_BASE + __numTabPage]["_mcDescription" + __numButton].gotoAndStop(3);
            break;
         case BB_STATE_QUEST:
            _loc2_._visible = false;
            _loc2_.boolEnabled = false;
            this[TABPAGE_NAME_BASE + __numTabPage]["_mcDescription" + __numButton].gotoAndStop(2);
            break;
         case BB_STATE_SHOW:
            if(this._numCurrentTab == __numTabPage)
            {
               _loc2_._visible = true;
               _loc2_.boolEnabled = true;
            }
            this[TABPAGE_NAME_BASE + __numTabPage]["_mcDescription" + __numButton].gotoAndStop(1);
            this[TABPAGE_NAME_BASE + __numTabPage]["_mcDescription" + __numButton].textInfo.text = "PRICE: " + String(CBuilding.PRICES[(__numTabPage - 1) * 5 + (__numButton - 1)]);
         default:
            return;
      }
   }
   function updateQuest(__numTabPage, __numButton, __quest)
   {
      this[TABPAGE_NAME_BASE + __numTabPage]["_mcDescription" + __numButton].textInfo.text = __quest.numPoints.toString() + " / " + __quest.numPointCap.toString();
   }
   function onTabChange(__numTabIndex)
   {
      this._numCurrentTab = __numTabIndex;
      var _loc5_;
      var _loc3_ = 1;
      var _loc4_;
      var _loc2_;
      while(_loc3_ <= TABS_NUMBER)
      {
         _loc5_ = CToggleButton(this[TABBUTTON_NAME_BASE + _loc3_]);
         _loc4_ = false;
         if(_loc3_ == this._numCurrentTab)
         {
            _loc4_ = true;
         }
         _loc5_.boolPressed = _loc4_;
         this[TABPAGE_NAME_BASE + _loc3_]._visible = _loc4_;
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            if(this[TABPAGE_NAME_BASE + _loc3_]["_mcDescription" + _loc2_]._currentframe == 1)
            {
               this[TABPAGE_NAME_BASE + _loc3_]["_mcBtnBuilding" + _loc2_].boolEnabled = _loc4_;
               this[TABPAGE_NAME_BASE + _loc3_]["_mcBtnBuilding" + _loc2_]._visible = _loc4_;
            }
            _loc2_ = _loc2_ + 1;
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function updatePriceColor(__numFunds)
   {
      var _loc3_ = 1;
      var _loc2_;
      while(_loc3_ <= 3)
      {
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            if(this[TABPAGE_NAME_BASE + _loc3_]["_mcDescription" + _loc2_]._currentframe == 1)
            {
               if(__numFunds >= CBuilding.PRICES[(_loc3_ - 1) * 5 + (_loc2_ - 1)])
               {
                  this[TABPAGE_NAME_BASE + _loc3_]["_mcDescription" + _loc2_].textInfo.textColor = 0;
               }
               else
               {
                  this[TABPAGE_NAME_BASE + _loc3_]["_mcDescription" + _loc2_].textInfo.textColor = 16711680;
               }
            }
            _loc2_ = _loc2_ + 1;
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function onHurryRelease()
   {
      this.dispatchMessage(CEventMovieClip.MSG_HURRYATTACK);
      CSoundService.playSound(Const.SND_SWITCH);
   }
   function onQuitRelease()
   {
      this.dispatchMessage(CEventMovieClip.MSG_QUITGAME);
      CSoundService.playSound(Const.SND_SWITCH);
   }
   function onPauseRelease(__boolPause)
   {
      this.dispatchMessage(CEventMovieClip.MSG_PAUSEGAME,{pause:__boolPause});
      CSoundService.playSound(Const.SND_SWITCH);
   }
   function switchServiceButtonsVisibility(__boolVisible)
   {
      this._mcPauseSwitch._visible = __boolVisible;
      this._btnQuit._visible = __boolVisible;
   }
   function showMessage(__strMessage, __boolError)
   {
      if(__boolError == undefined)
      {
         __boolError = false;
      }
      this.textTimer._visible = false;
      this.textScreen._visible = false;
      this.textMessage.text = __strMessage;
      this.textMessage._visible = true;
      this._mcErrorBlink.play();
      if(__boolError)
      {
         CSoundService.playSound(Const.SND_ERROR);
      }
      else
      {
         CSoundService.playSound(Const.SND_QUEST);
      }
      this.numMessageTimer = MESSAGE_DELAY;
      this.onEnterFrame = this.oefWaitMessage;
   }
   function onKeyDown()
   {
      if(Key.isDown(32) && this._btnStartAttack._visible)
      {
         this.onHurryRelease();
      }
      if(Key.isDown(80) && this._mcPauseSwitch._visible)
      {
         if(this._mcPauseSwitch._currentframe == 1)
         {
            this.onPauseRelease(true);
         }
         else
         {
            this.onPauseRelease(false);
         }
         this._mcPauseSwitch.play();
      }
      if(Key.isDown(77) && this._mcSoundSwitch._visible)
      {
         if(this._mcSoundSwitch._currentframe == 1)
         {
            CSoundService.soundOff();
         }
         else
         {
            CSoundService.soundOn();
         }
         this._mcSoundSwitch.play();
      }
      if(Key.isDown(81) && this._btnQuit._visible)
      {
         this.onQuitRelease();
      }
   }
   function oefWaitMessage()
   {
      this.numMessageTimer = this.numMessageTimer - 1;
      if(this.numMessageTimer == 0)
      {
         this.textTimer._visible = true;
         this.textScreen._visible = true;
         this.textMessage._visible = false;
         this.onEnterFrame = undefined;
      }
   }
   function processMessage(__numMessage, __objParam, __mcInvoker)
   {
      var _loc2_ = false;
      var _loc0_;
      var _loc3_;
      if((_loc0_ = __numMessage) === CEventMovieClip.MSG_TOGGLEPRESS)
      {
         if(!this.boolEnabled)
         {
            _loc2_ = true;
         }
         else
         {
            _loc3_ = CToggleButton(__mcInvoker);
            if(_loc3_ == this._mcTabButton1 || _loc3_ == this._mcTabButton2 || _loc3_ == this._mcTabButton3)
            {
               _loc2_ = true;
            }
            if(__objParam.isHit && !_loc3_.boolPressed)
            {
               switch(_loc3_)
               {
                  case this._mcTabButton1:
                     this.onTabChange(1);
                     this._mcTabButton2.boolPressed = false;
                     this._mcTabButton3.boolPressed = false;
                     _loc2_ = true;
                     break;
                  case this._mcTabButton2:
                     this.onTabChange(2);
                     this._mcTabButton1.boolPressed = false;
                     this._mcTabButton3.boolPressed = false;
                     _loc2_ = true;
                     break;
                  case this._mcTabButton3:
                     this.onTabChange(3);
                     this._mcTabButton1.boolPressed = false;
                     this._mcTabButton2.boolPressed = false;
                     _loc2_ = true;
               }
            }
         }
      }
      if(!_loc2_)
      {
         this.dispatchMessage(__numMessage,__objParam,__mcInvoker);
      }
   }
}
