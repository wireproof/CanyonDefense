class CCursor extends CEventMovieClip
{
   var _alpha;
   var _boolJustAttached;
   var _dragArmed;
   var _mapReference;
   var _numAbilityAttached;
   var _numState;
   var _objCell;
   var _parent;
   var _visible;
   var _x;
   var _y;
   var attachMovie;
   var filters;
   var mcCursor;
   static var CURSOR_DEPTH = 1;
   static var STATE_CLEAR = 0;
   static var STATE_BUILDING = 1;
   static var STATE_ABILITY = 2;
   static var FORBIDDEN_GLOW = new flash.filters.GlowFilter(16711680,30,7,7);
   static var PERMISSION_GLOW = new flash.filters.GlowFilter(65280,30,7,7);
   function CCursor()
   {
      super();
   }
   function get numState()
   {
      return this._numState;
   }
   function set numState(__newValue)
   {
      if(this._numState != __newValue)
      {
         this._numState = __newValue;
      }
   }
   function get buildingCursor()
   {
      return CBuilding(this.mcCursor);
   }
   function get numAbility()
   {
      return this._numAbilityAttached;
   }
   function initCursor(__mapReference)
   {
      this._mapReference = __mapReference;
   }
   function attachBuilding(__numType)
   {
      this.clear();
      this.attachMovie("id_building","mcCursor",CURSOR_DEPTH);
      if(this.mcCursor.initBuilding(__numType) == false)
      {
         return false;
      }
      this.mcCursor.numState = CBuilding.STATE_PLACING;
      this.numState = STATE_BUILDING;
      this._boolJustAttached = true;
      this._dragArmed = true;
      return true;
   }
   function attachAbility(__numType)
   {
      this._numAbilityAttached = __numType;
      this.attachMovie(CAbility.getCursorSymbol(__numType),"mcCursor",CURSOR_DEPTH);
      this.numState = STATE_ABILITY;
      this._boolJustAttached = true;
   }
   function clear()
   {
      if(!this._boolJustAttached)
      {
         this.mcCursor.removeMovieClip();
         this.numState = STATE_CLEAR;
         this.filters = new Array();
      }
   }
   function refresh()
   {
      var _loc4_;
      var _loc3_;
      if(this.numState != STATE_CLEAR)
      {
         this._objCell = this._mapReference.cellHitTest(_root._xmouse,_root._ymouse);
         this._parent.globalToLocal(this._objCell);
         _loc4_ = this.mcCursor._numCellI != this._objCell.i || this.mcCursor._numCellJ != this._objCell.j;
         this.mcCursor._numCellI = this._objCell.i;
         this.mcCursor._numCellJ = this._objCell.j;
         this._visible = !this._objCell.out;
         if(this.numState == STATE_BUILDING)
         {
            this._x = this._objCell.x;
            this._y = this._objCell.y;
            if(_loc4_)
            {
               this.dispatchMessage(CEventMovieClip.MSG_MOUSEOUT,{forceHide:true},this.buildingCursor);
               if(!this._objCell.out)
               {
                  this.dispatchMessage(CEventMovieClip.MSG_MOUSEOVER,{forceShow:true},this.buildingCursor);
               }
               this._mapReference.toggleGrid(!this._objCell.out);
            }
            if(this._mapReference.checkPlacingSpace(this._objCell.i,this._objCell.j,this.mcCursor._matrixPattern))
            {
               this._objCell.free = true;
               _loc3_ = new Array();
               _loc3_.push(PERMISSION_GLOW);
               this.filters = _loc3_;
            }
            else
            {
               this._objCell.free = false;
               _loc3_ = new Array();
               _loc3_.push(FORBIDDEN_GLOW);
               this.filters = _loc3_;
            }
         }
         else if(this.numState == STATE_ABILITY && this.numAbility == CAbility.TYPE_WALL)
         {
            this._x = this._objCell.x;
            this._y = this._objCell.y;
            if(this._mapReference.checkWallSpace(this._objCell.i,this._objCell.j))
            {
               this._objCell.free = true;
               _loc3_ = new Array();
               _loc3_.push(PERMISSION_GLOW);
               this.filters = _loc3_;
            }
            else
            {
               this._objCell.free = false;
               _loc3_ = new Array();
               _loc3_.push(FORBIDDEN_GLOW);
               this.filters = _loc3_;
            }
            this._mapReference.toggleGrid(!this._objCell.out);
         }
         else
         {
            this._x = this._parent._xmouse;
            this._y = this._parent._ymouse;
            switch(this.numAbility)
            {
               case CAbility.TYPE_SELL:
                  if(this._mapReference.checkBuildingSpace(this._objCell.i,this._objCell.j))
                  {
                     this._objCell.free = true;
                     this.filters = new Array();
                  }
                  else
                  {
                     this._objCell.free = false;
                     _loc3_ = new Array();
                     _loc3_.push(FORBIDDEN_GLOW);
                     this.filters = _loc3_;
                  }
                  this._mapReference.toggleGrid(!this._objCell.out);
                  break;
               case CAbility.TYPE_MISSILE:
               case CAbility.TYPE_TIMEBOMB:
                  this._objCell.free = true;
                  this._alpha = 100;
               default:
                  return;
            }
         }
      }
   }
   function onMouseMove()
   {
      this.refresh();
      updateAfterEvent();
   }
   function onMouseDown()
   {
      if(this.numState == STATE_BUILDING || this.numState == STATE_ABILITY)
      {
         this.refresh();
         this.dispatchMessage(CEventMovieClip.MSG_MOUSECLICK,this._objCell);
      }
      updateAfterEvent();
   }
   function onMouseUp()
   {
      if(this._dragArmed && this.numState == STATE_BUILDING)
      {
         this._dragArmed = false;
         this.refresh();
         if(!this._objCell.out)
         {
            this._boolJustAttached = false;
            this.dispatchMessage(CEventMovieClip.MSG_MOUSECLICK,this._objCell);
         }
      }
      updateAfterEvent();
   }
   function onEnterFrame()
   {
      this._boolJustAttached = false;
   }
}
