class CEffect
{
   var _numDuration;
   var _numTimer;
   var numType;
   var objParams;
   static var TYPE_DAMAGE = 1;
   static var TYPE_FAST = 2;
   static var TYPE_SLOW = 3;
   static var TYPE_CLEAR = 4;
   static var TYPE_REPAIR = 5;
   static var TYPE_SHIELD = 6;
   static var TYPE_PIERCEDAMAGE = 7;
   static var TYPE_CONFUSE = 8;
   static var TYPE_TIMESTOP = 9;
   function CEffect(__numType, __objParams, __numDuration)
   {
      this.numType = __numType;
      this.objParams = __objParams;
      this._numDuration = __numDuration;
      if(this._numDuration == undefined)
      {
         this._numTimer = 0;
      }
      else
      {
         this._numTimer = this._numDuration;
      }
   }
   function tick()
   {
      if(this._numTimer == 0)
      {
         return true;
      }
      this._numTimer = this._numTimer - 1;
      return false;
   }
   function makeCopy()
   {
      return new CEffect(this.numType,this.objParams,this._numDuration);
   }
}
