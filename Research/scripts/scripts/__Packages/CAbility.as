class CAbility
{
   var _boolAvaliable;
   var _numCooldown;
   var _numSources;
   var _numTimer;
   var numType;
   var tgbtnLink;
   static var TYPE_SELL = 1;
   static var TYPE_MISSILE = 2;
   static var TYPE_WALL = 3;
   static var TYPE_TIMEBOMB = 4;
   static var TYPE_MONEYBONUS = 5;
   static var TYPE_TOWERBONUS = 6;
   function CAbility(__numType, __tgbtnLink, __numSources)
   {
      this.numType = __numType;
      switch(this.numType)
      {
         case TYPE_SELL:
         case TYPE_MONEYBONUS:
         case TYPE_TOWERBONUS:
            this._numCooldown = 0;
            break;
         case TYPE_MISSILE:
            this._numCooldown = 5400;
            break;
         case TYPE_WALL:
            this._numCooldown = 5400;
            break;
         case TYPE_TIMEBOMB:
            this._numCooldown = 5400;
      }
      this.tgbtnLink = __tgbtnLink;
      this.tgbtnLink.mcClock.gotoAndStop(7201);
      this.numSources = __numSources;
   }
   static function getCursorSymbol(__numType)
   {
      switch(__numType)
      {
         case TYPE_SELL:
            return "id_cursor_sell";
         case TYPE_MISSILE:
            return "id_cursor_missile";
         case TYPE_WALL:
            return "id_cursor_wall";
         case TYPE_TIMEBOMB:
            return "id_cursor_timebomb";
         default:
            return undefined;
      }
   }
   function get numSources()
   {
      return this._numSources;
   }
   function set numSources(__numValue)
   {
      this._numSources = __numValue;
      if(this._numSources < 0)
      {
         this._numSources = 0;
      }
      this.boolAvaliable = this._numSources > 0;
   }
   function get boolAvaliable()
   {
      return this._boolAvaliable;
   }
   function set boolAvaliable(__boolValue)
   {
      if(!this._boolAvaliable && __boolValue)
      {
         this.numTimer = 0;
      }
      this._boolAvaliable = __boolValue;
      this.tgbtnLink.boolEnabled = this._boolAvaliable;
      this.tgbtnLink._visible = this._boolAvaliable;
   }
   function get numTimer()
   {
      return this._numTimer;
   }
   function set numTimer(__numValue)
   {
      this._numTimer = __numValue;
      if(this._numTimer < 0)
      {
         this._numTimer = 0;
      }
      this.updateClock();
   }
   function tick()
   {
      if(this._boolAvaliable)
      {
         if(this.numTimer == 0)
         {
            if(!this.tgbtnLink.boolEnabled)
            {
               this.tgbtnLink.boolEnabled = true;
            }
         }
         else
         {
            this.numTimer -= this.numSources;
         }
      }
   }
   function updateClock()
   {
      this.tgbtnLink.mcClock.gotoAndStop(7201 - Math.floor(7200 * this._numTimer / this._numCooldown));
   }
   function reset()
   {
      this.numTimer = this._numCooldown;
      if(this.numTimer > 0)
      {
         this.tgbtnLink.boolEnabled = false;
         return true;
      }
      return false;
   }
}
