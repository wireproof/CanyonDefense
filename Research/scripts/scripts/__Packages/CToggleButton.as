class CToggleButton extends CEventMovieClip
{
   var _boolEnabled;
   var _boolPressed;
   var _mcToolTip;
   var _numToolTipTimer;
   var _strToolTip;
   var _visible;
   var _xmouse;
   var _ymouse;
   var attachMovie;
   var gotoAndStop;
   var mcHitArea;
   var onEnterFrame;
   var onMouseMove;
   var onRollOut;
   var onRollOver;
   static var TOOLTIP_DELAY = 12;
   function CToggleButton()
   {
      super();
      if(this.mcHitArea == undefined)
      {
         this.mcHitArea = this;
      }
      this._boolPressed = false;
      this._boolEnabled = true;
   }
   function get boolPressed()
   {
      return this._boolPressed;
   }
   function set boolPressed(__boolValue)
   {
      if(this._boolPressed != __boolValue)
      {
         this._boolPressed = __boolValue;
         if(this._boolPressed)
         {
            this.gotoAndStop("frmPressed");
         }
         else
         {
            this.gotoAndStop("frmReleased");
         }
      }
   }
   function get boolEnabled()
   {
      return this._boolEnabled;
   }
   function set boolEnabled(__boolValue)
   {
      if(this._boolEnabled != __boolValue)
      {
         this._boolEnabled = __boolValue;
         if(this._boolEnabled == false)
         {
            this.boolPressed = false;
         }
         else
         {
            this._numToolTipTimer = TOOLTIP_DELAY;
         }
      }
   }
   function get strToolTip()
   {
      return this._strToolTip;
   }
   function set strToolTip(__strValue)
   {
      this._strToolTip = " " + __strValue + " ";
      if(this._strToolTip != undefined && this._strToolTip != "")
      {
         this.onRollOver = this.ttOnRollOver;
         this.onRollOut = this.ttOnRollOut;
         this.attachMovie("id_mcToolTip","_mcToolTip",1);
         this._mcToolTip.textToolTip.autoSize = true;
         this._mcToolTip.textToolTip.text = this._strToolTip;
         this._mcToolTip._visible = false;
      }
      else
      {
         this.onRollOver = undefined;
         this.onRollOut = undefined;
         this.onEnterFrame = undefined;
         this.onMouseMove = undefined;
         this._mcToolTip.removeMovieClip();
      }
   }
   function onMouseDown()
   {
      if(this._boolEnabled)
      {
         if(this.mcHitArea.hitTest(_root._xmouse,_root._ymouse,true))
         {
            this.dispatchMessage(CEventMovieClip.MSG_TOGGLEPRESS,{isHit:true});
            CSoundService.playSound(Const.SND_SWITCH);
         }
         else
         {
            this.dispatchMessage(CEventMovieClip.MSG_TOGGLEPRESS,{isHit:false});
         }
      }
      if(this._strToolTip != undefined && this._strToolTip != "")
      {
         this.toggleToolTip(false);
         this._numToolTipTimer = TOOLTIP_DELAY;
      }
      updateAfterEvent();
   }
   function toggleToolTip(__boolShow)
   {
      if(this._visible || !__boolShow)
      {
         this._mcToolTip._visible = __boolShow;
         if(__boolShow)
         {
            this._mcToolTip._x = this._xmouse - this._mcToolTip._width;
            this._mcToolTip._y = this._ymouse + 22;
         }
      }
   }
   function ttOnRollOver()
   {
      this.onEnterFrame = this.ttOnEnterFrame;
      this.onMouseMove = this.ttOnMouseMove;
      this._numToolTipTimer = TOOLTIP_DELAY;
      updateAfterEvent();
   }
   function ttOnRollOut()
   {
      this.toggleToolTip(false);
      this.onEnterFrame = undefined;
      this.onMouseMove = undefined;
      updateAfterEvent();
   }
   function ttOnMouseMove()
   {
      this.toggleToolTip(false);
      this._numToolTipTimer = TOOLTIP_DELAY;
      updateAfterEvent();
   }
   function ttOnEnterFrame()
   {
      this._numToolTipTimer = this._numToolTipTimer - 1;
      if(this._numToolTipTimer == 0)
      {
         this.toggleToolTip(true);
      }
   }
}
