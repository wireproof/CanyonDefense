class CEventMovieClip extends MovieClip
{
   static var MSG_UNDEFINED = 0;
   static var MSG_TOGGLEPRESS = 1;
   static var MSG_MOUSECLICK = 2;
   static var MSG_MOUSEOVER = 3;
   static var MSG_MOUSEOUT = 4;
   static var MSG_TARGETLOST = 5;
   static var MSG_READYTOSHOOT = 6;
   static var MSG_SPLASHEFFECT = 7;
   static var MSG_CREATEGFX = 8;
   static var MSG_ENEMYDEAD = 9;
   static var MSG_ENEMYPASSED = 10;
   static var MSG_HURRYATTACK = 11;
   static var MSG_QUITGAME = 12;
   static var MSG_PAUSEGAME = 13;
   function CEventMovieClip()
   {
      super();
   }
   function dispatchMessage(__numMessage, __objParam, __mcInvoker)
   {
      if(__numMessage == undefined)
      {
         __numMessage = MSG_UNDEFINED;
      }
      if(__mcInvoker == undefined)
      {
         __mcInvoker = this;
      }
      var _loc3_ = this._parent;
      while(!(_loc3_ instanceof CEventMovieClip))
      {
         _loc3_ = _loc3_._parent;
         if(_loc3_ == _root)
         {
            return false;
         }
      }
      _loc3_.processMessage(__numMessage,__objParam,__mcInvoker);
      return true;
   }
   function processMessage(__numMessage, __objParam, __mcInvoker)
   {
      this.dispatchMessage(__numMessage,__objParam,__mcInvoker);
   }
}
