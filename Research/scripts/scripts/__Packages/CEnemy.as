class CEnemy extends CEventMovieClip
{
   var _arrEffects;
   var _boolAutoMove;
   var _boolNearExit;
   var _height;
   var _mapReference;
   var _mcFastEffect;
   var _mcHealthBar;
   var _mcObject;
   var _mcRepairEffect;
   var _mcShieldEffect;
   var _mcSlowEffect;
   var _numCellI;
   var _numCellJ;
   var _numHealth;
   var _numLevel;
   var _numMaxHealth;
   var _numMaxSpeed;
   var _numOldCellI;
   var _numOldCellJ;
   var _numReward;
   var _numThrottle;
   var _numTurnSpeed;
   var _numType;
   var _numWaypointX;
   var _numWaypointY;
   var _parent;
   var _rotation;
   var _strDeathEffect;
   var _vectSpeed;
   var _width;
   var _x;
   var _y;
   var attachMovie;
   var boolExists;
   var getNextHighestDepth;
   var localToGlobal;
   var numAltitude;
   var removeMovieClip;
   static var TYPE_BAGGI = 1;
   static var TYPE_TRICYCLE = 2;
   static var TYPE_CAR = 3;
   static var TYPE_HOWERTANK = 4;
   static var TYPE_PLANE = 5;
   static var TYPE_INSECT = 6;
   static var TYPE_SCORPIO = 7;
   static var REWARDS = new Array(20,50,85,120,30,75,100);
   static var SYMBOL_BASE = "id_enemy";
   static var WAYPOINT_HIT_TOLERANCE = 20;
   static var WAYPOINT_TURN_TOLERANCE = 0.1;
   static var WAYPOINT_RANDOM = 16;
   static var MIN_SPEED = 0.35;
   function CEnemy()
   {
      super();
      this.boolExists = true;
      this._boolNearExit = false;
      this._boolAutoMove = false;
   }
   function get numType()
   {
      return this._numType;
   }
   function set numType(__numValue)
   {
      var _loc2_;
      if(this._numType != __numValue)
      {
         this._numType = __numValue;
         switch(this._numType)
         {
            case TYPE_BAGGI:
               this._numMaxSpeed = 2;
               this._numThrottle = 0.3;
               this._numTurnSpeed = 0.11;
               this._vectSpeed = new CVector(1,1);
               this._vectSpeed.numLength = this._numMaxSpeed;
               this._numMaxHealth = 15;
               this._strDeathEffect = "id_gfx_explosion_small";
               break;
            case TYPE_TRICYCLE:
               this._numMaxSpeed = 1.7;
               this._numThrottle = 0.3;
               this._numTurnSpeed = 0.1;
               this._vectSpeed = new CVector(1,1);
               this._vectSpeed.numLength = this._numMaxSpeed;
               this._numMaxHealth = 35;
               this._strDeathEffect = "id_gfx_explosion_medium";
               break;
            case TYPE_CAR:
               this._numMaxSpeed = 1.5;
               this._numThrottle = 0.25;
               this._numTurnSpeed = 0.08;
               this._vectSpeed = new CVector(1,1);
               this._vectSpeed.numLength = this._numMaxSpeed;
               this._numMaxHealth = 70;
               this._strDeathEffect = "id_gfx_explosion_medium";
               break;
            case TYPE_HOWERTANK:
               this._numMaxSpeed = 1.1;
               this._numThrottle = 0.2;
               this._numTurnSpeed = 0.06;
               this._vectSpeed = new CVector(1,1);
               this._vectSpeed.numLength = this._numMaxSpeed;
               this._numMaxHealth = 120;
               this._strDeathEffect = "id_gfx_explosion_big";
               break;
            case TYPE_PLANE:
               this._numMaxSpeed = 1.8;
               this._numThrottle = 0.3;
               this._numTurnSpeed = 0.11;
               this._vectSpeed = new CVector(0,1);
               this._vectSpeed.numLength = this._numMaxSpeed;
               this._numMaxHealth = 8;
               this._strDeathEffect = "id_gfx_explosion_small";
               break;
            case TYPE_INSECT:
               this._numMaxSpeed = 1.5;
               this._numThrottle = 0.3;
               this._numTurnSpeed = 0.16;
               this._vectSpeed = new CVector(0,1);
               this._vectSpeed.numLength = this._numMaxSpeed;
               this._numMaxHealth = 20;
               this._strDeathEffect = "id_gfx_explosion_medium";
               break;
            case TYPE_SCORPIO:
               this._numMaxSpeed = 1.2;
               this._numThrottle = 0.3;
               this._numTurnSpeed = 0.06;
               this._vectSpeed = new CVector(0,1);
               this._vectSpeed.numLength = this._numMaxSpeed;
               this._numMaxHealth = 40;
               this._strDeathEffect = "id_gfx_explosion_big";
         }
         this._numMaxHealth += Math.round(1.2 * (this._numLevel - 1) * this._numMaxHealth);
         _loc2_ = this._numMaxHealth >= 100 ? 100 : this._numMaxHealth;
         this._numHealth = this._numMaxHealth;
         this._mcHealthBar._width = _loc2_ / 2;
         this._numReward = REWARDS[this._numType - 1] * (1 + 0.5 * (this._numLevel - 1));
      }
   }
   function get numHealth()
   {
      return this._numHealth;
   }
   function set numHealth(__numValue)
   {
      this._numHealth = __numValue;
      if(this._numHealth < 0)
      {
         this._numHealth = 0;
      }
      if(this._numHealth > this._numMaxHealth)
      {
         this._numHealth = this._numMaxHealth;
      }
      this._mcHealthBar.mcBar._width = 100 * this._numHealth / this._numMaxHealth;
      var _loc2_;
      if(this._numHealth == 0)
      {
         _loc2_ = {symbol:this._strDeathEffect,x:this._x,y:this._y,altitude:this.numAltitude};
         this.dispatchMessage(CEventMovieClip.MSG_ENEMYDEAD,_loc2_);
      }
   }
   function initEnemy(__numType, __numLevel, __mcLayerInfo)
   {
      this.attachMovie(SYMBOL_BASE + __numType.toString(),"_mcObject",1);
      this._mcHealthBar = __mcLayerInfo.addElement("id_healthbar");
      var _loc2_ = {x:this._mcObject._x,y:this._mcObject._y - this._mcObject._height / 2 - 5};
      this.localToGlobal(_loc2_);
      __mcLayerInfo.globalToLocal(_loc2_);
      this._mcHealthBar._x = _loc2_.x;
      this._mcHealthBar._y = _loc2_.y;
      this._numLevel = __numLevel;
      this.numType = __numType;
      this._arrEffects = new Array();
   }
   function updateWaypoint()
   {
      this._boolAutoMove = false;
      var _loc2_ = this._mapReference.getNextCell(this._numCellI,this._numCellJ);
      if(_loc2_ == undefined)
      {
         return false;
      }
      if(this._numCellJ == _loc2_.j)
      {
         if(this._numCellI < _loc2_.i)
         {
            this._numWaypointX = (this._numCellJ + 0.5) * Const.MATRIX_CELL_WIDTH;
            this._numWaypointY = (this._numCellI + 1) * Const.MATRIX_CELL_HEIGHT;
         }
         else
         {
            this._numWaypointX = (this._numCellJ + 0.5) * Const.MATRIX_CELL_WIDTH;
            this._numWaypointY = this._numCellI * Const.MATRIX_CELL_HEIGHT;
         }
      }
      if(this._numCellI == _loc2_.i)
      {
         if(this._numCellJ < _loc2_.j)
         {
            this._numWaypointX = (this._numCellJ + 1) * Const.MATRIX_CELL_WIDTH;
            this._numWaypointY = (this._numCellI + 0.5) * Const.MATRIX_CELL_HEIGHT;
         }
         else
         {
            this._numWaypointX = this._numCellJ * Const.MATRIX_CELL_WIDTH;
            this._numWaypointY = (this._numCellI + 0.5) * Const.MATRIX_CELL_HEIGHT;
         }
      }
      return true;
   }
   function process()
   {
      if(this._vectSpeed.numLength < this._numMaxSpeed)
      {
         this._vectSpeed.numLength += this._numMaxSpeed;
      }
      if(this._vectSpeed.numLength > this._numMaxSpeed)
      {
         this._vectSpeed.numLength = this._numMaxSpeed;
      }
      var _loc15_ = false;
      var _loc8_ = false;
      var _loc4_ = false;
      var _loc11_ = false;
      var _loc6_ = false;
      var _loc7_ = false;
      var _loc17_ = false;
      var _loc9_ = 0;
      var _loc12_ = 0;
      var _loc10_ = 0;
      var _loc19_ = 0;
      var _loc18_ = 0;
      var _loc5_ = 1;
      var _loc3_ = 0;
      var _loc2_ = 0;
      while(_loc2_ < this._arrEffects.length)
      {
         switch(this._arrEffects[_loc2_].numType)
         {
            case CEffect.TYPE_DAMAGE:
               _loc15_ = true;
               _loc10_ += this._arrEffects[_loc2_].objParams.damage;
               break;
            case CEffect.TYPE_FAST:
               _loc8_ = true;
               _loc9_ += this._vectSpeed.numLength * this._arrEffects[_loc2_].objParams.percent;
               break;
            case CEffect.TYPE_SLOW:
               _loc4_ = true;
               _loc12_ += this._vectSpeed.numLength * this._arrEffects[_loc2_].objParams.percent;
               break;
            case CEffect.TYPE_CLEAR:
               _loc11_ = true;
               break;
            case CEffect.TYPE_REPAIR:
               _loc6_ = true;
               _loc19_ += this._numMaxHealth * this._arrEffects[_loc2_].objParams.percent;
               break;
            case CEffect.TYPE_SHIELD:
               _loc7_ = true;
               _loc5_ = Math.min(_loc5_,this._arrEffects[_loc2_].objParams.pass);
               break;
            case CEffect.TYPE_PIERCEDAMAGE:
               _loc18_ += this._arrEffects[_loc2_].objParams.damage;
               break;
            case CEffect.TYPE_CONFUSE:
               _loc3_ += this._numTurnSpeed * this._arrEffects[_loc2_].objParams.percent;
               if(_loc3_ >= this._numTurnSpeed)
               {
                  _loc3_ = this._numTurnSpeed;
               }
               break;
            case CEffect.TYPE_TIMESTOP:
               _loc4_ = true;
               _loc17_ = true;
         }
         if(this._arrEffects[_loc2_].tick())
         {
            this._arrEffects.splice(_loc2_,1);
            _loc2_ = _loc2_ - 1;
         }
         _loc2_ = _loc2_ + 1;
      }
      this._vectSpeed.numLength += _loc9_ - _loc12_;
      if(this._vectSpeed.numLength < MIN_SPEED)
      {
         this._vectSpeed.numLength = MIN_SPEED;
      }
      var _loc20_ = this._numTurnSpeed - _loc3_;
      if(_loc17_)
      {
         this._vectSpeed.numLength = 0;
         _loc20_ = 0;
      }
      this.numHealth += _loc19_ - _loc18_ - _loc5_ * _loc10_;
      if(_loc11_)
      {
         this._arrEffects = new Array();
      }
      if(_loc8_ && this._mcFastEffect == undefined)
      {
         this.attachMovie("id_effect_fast","_mcFastEffect",this.getNextHighestDepth(),{_width:1.3 * this._mcObject._width,_height:1.3 * this._mcObject._height});
      }
      if(!_loc8_ && this._mcFastEffect != undefined)
      {
         this._mcFastEffect.removeMovieClip();
      }
      if(_loc4_ && this._mcSlowEffect == undefined)
      {
         this.attachMovie("id_effect_slow","_mcSlowEffect",this.getNextHighestDepth(),{_width:1.3 * this._mcObject._width,_height:1.3 * this._mcObject._height});
      }
      if(!_loc4_ && this._mcSlowEffect != undefined)
      {
         this._mcSlowEffect.removeMovieClip();
      }
      if(_loc6_ && this._mcRepairEffect == undefined)
      {
         this.attachMovie("id_effect_repair","_mcRepairEffect",this.getNextHighestDepth(),{_width:1.3 * this._mcObject._width,_height:1.3 * this._mcObject._height});
      }
      if(!_loc6_ && this._mcRepairEffect != undefined)
      {
         this._mcRepairEffect.removeMovieClip();
      }
      if(_loc7_ && this._mcShieldEffect == undefined)
      {
         this.attachMovie("id_effect_shield","_mcShieldEffect",this.getNextHighestDepth(),{_width:1.3 * this._mcObject._width,_height:1.3 * this._mcObject._height});
      }
      if(!_loc7_ && this._mcShieldEffect != undefined)
      {
         this._mcShieldEffect.removeMovieClip();
      }
      if(_loc15_)
      {
         CSoundService.playSound(Const.SND_HIT);
      }
      var _loc16_ = new CVector(0,0);
      if(this._boolNearExit)
      {
         if(this._x - this._width / 2 > Const.MATRIX_WIDTH * Const.MATRIX_CELL_WIDTH || this._y - this._height / 2 > Const.MATRIX_HEIGHT * Const.MATRIX_CELL_HEIGHT)
         {
            this.dispatchMessage(CEventMovieClip.MSG_ENEMYPASSED);
         }
         if(this._numCellI == this._mapReference._matrixPattern.height - 1)
         {
            _loc16_.numY = 1;
         }
         if(this._numCellJ == this._mapReference._matrixPattern.width - 1)
         {
            _loc16_.numX = 1;
         }
      }
      else
      {
         _loc16_.numX = this._numWaypointX - this._x;
         _loc16_.numY = this._numWaypointY - this._y;
      }
      var _loc21_;
      var _loc23_;
      var _loc22_;
      if(this.numAltitude != CMap.ALTITUDE_AIR)
      {
         _loc21_ = this._vectSpeed.getAngleWith(_loc16_);
         if(_loc21_ > WAYPOINT_TURN_TOLERANCE)
         {
            _loc23_ = _loc16_.numX * this._vectSpeed.numY - this._vectSpeed.numX * _loc16_.numY;
            _loc22_ = _loc20_ <= _loc21_ ? _loc20_ : _loc21_;
            if(_loc23_ > 0)
            {
               this._vectSpeed.rotate(_loc22_);
            }
            else
            {
               this._vectSpeed.rotate(- _loc22_);
            }
         }
      }
      var _loc25_ = this._x;
      var _loc24_ = this._y;
      this._x += this._vectSpeed.numX;
      this._y += this._vectSpeed.numY;
      this._rotation = this._vectSpeed.numRotation;
      var _loc13_ = Math.floor(this._x / Const.MATRIX_CELL_WIDTH);
      var _loc14_ = Math.floor(this._y / Const.MATRIX_CELL_HEIGHT);
      if(this.numAltitude != CMap.ALTITUDE_AIR && _loc14_ >= 0 && _loc14_ < Const.MATRIX_HEIGHT && _loc13_ >= 0 && _loc13_ < Const.MATRIX_WIDTH && this._mapReference._matrixPattern[_loc14_ * Const.MATRIX_WIDTH + _loc13_] > CMap.CELL_VOID)
      {
         this._vectSpeed.numLength = 0.1;
         this._x = _loc25_;
         this._y = _loc24_;
         _loc14_ = -1;
         _loc13_ = -1;
      }
      else
      {
         this._mcHealthBar._x += this._vectSpeed.numX;
         this._mcHealthBar._y += this._vectSpeed.numY;
      }
      if(_loc14_ >= 0 && _loc13_ >= 0 && (this._numCellI != _loc14_ || this._numCellJ != _loc13_))
      {
         this._numOldCellI = this._numCellI;
         this._numOldCellJ = this._numCellJ;
         this._numCellJ = _loc13_;
         this._numCellI = _loc14_;
         if(this.numAltitude == CMap.ALTITUDE_AIR || !this.updateWaypoint())
         {
            this._boolNearExit = true;
         }
      }
   }
   function restoreOldCell()
   {
      this._numCellI = this._numOldCellI;
      this._numCellJ = this._numOldCellJ;
   }
   function remove()
   {
      this._mcHealthBar.removeMovieClip();
      this.removeMovieClip();
   }
   function getDistanceFrom(__numX, __numY)
   {
      var _loc2_ = {x:__numX,y:__numY};
      this._parent.globalToLocal(_loc2_);
      return Math.sqrt((this._x - _loc2_.x) * (this._x - _loc2_.x) + (this._y - _loc2_.y) * (this._y - _loc2_.y));
   }
   function applyEffect(__effectNew)
   {
      this._arrEffects.push(__effectNew);
   }
}
