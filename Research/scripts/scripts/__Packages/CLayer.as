class CLayer extends MovieClip
{
   var _boolPaused;
   var _numCounter;
   function CLayer()
   {
      super();
      this._numCounter = 0;
      this._boolPaused = false;
   }
   function get boolPaused()
   {
      return this._boolPaused;
   }
   function set boolPaused(__boolValue)
   {
      this._boolPaused = __boolValue;
      if(this._boolPaused)
      {
         for(var _loc3_ in this)
         {
            if(this[_loc3_] instanceof MovieClip)
            {
               this[_loc3_].stop();
               for(var _loc2_ in this[_loc3_])
               {
                  this[_loc3_][_loc2_].stop();
               }
               if(this[_loc3_]._mcObject != undefined)
               {
                  for(_loc2_ in this[_loc3_]._mcObject)
                  {
                     this[_loc3_]._mcObject[_loc2_].stop();
                  }
               }
            }
         }
      }
      else
      {
         for(_loc3_ in this)
         {
            if(this[_loc3_] instanceof MovieClip)
            {
               this[_loc3_].play();
               for(_loc2_ in this[_loc3_])
               {
                  this[_loc3_][_loc2_].play();
               }
               if(this[_loc3_]._mcObject != undefined)
               {
                  for(_loc2_ in this[_loc3_]._mcObject)
                  {
                     this[_loc3_]._mcObject[_loc2_].play();
                  }
               }
            }
         }
      }
   }
   function clear()
   {
      for(var _loc2_ in this)
      {
         if(this[_loc2_] instanceof MovieClip)
         {
            this[_loc2_].removeMovieClip();
         }
      }
      this._numCounter = 0;
   }
   function addElement(__strSymbolName, __objInit)
   {
      this._numCounter = this._numCounter + 1;
      return this.attachMovie(__strSymbolName,"_mcElement" + this._numCounter,this.getNextHighestDepth(),__objInit);
   }
   function removeElement(__mcTarget)
   {
      if(__mcTarget._parent != this)
      {
         Const.TRACE("ERROR! " + __mcTarget + " isn\'t element of layer.");
         return false;
      }
      __mcTarget.removeMovieClip();
      return true;
   }
   function process()
   {
      for(var _loc2_ in this)
      {
         if(this[_loc2_] instanceof MovieClip)
         {
            this[_loc2_].process();
         }
      }
   }
}
