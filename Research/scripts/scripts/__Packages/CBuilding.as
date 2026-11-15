class CBuilding extends CEventMovieClip
{
   var _boolMouseOver;
   var _boolTower;
   var _enemyTarget;
   var _matrixPattern;
   var _mcMatrix;
   var _mcObject;
   var _numAimingAltitude;
   var _numCellI;
   var _numCellJ;
   var _numPrice;
   var _numRange;
   var _numReloadTime;
   var _numReloadTimer;
   var _numState;
   var _numTurnSpeed;
   var _numType;
   var _parent;
   var _vectDirection;
   var _x;
   var _y;
   var attachMovie;
   var localToGlobal;
   var onRollOut;
   var onRollOver;
   var useHandCursor;
   static var TYPE_TOWER_1_1 = 1;
   static var TYPE_TOWER_1_2 = 2;
   static var TYPE_TOWER_1_3 = 3;
   static var TYPE_TOWER_1_4 = 4;
   static var TYPE_TOWER_1_5 = 5;
   static var TYPE_TOWER_2_1 = 6;
   static var TYPE_TOWER_2_2 = 7;
   static var TYPE_TOWER_2_3 = 8;
   static var TYPE_TOWER_2_4 = 9;
   static var TYPE_TOWER_2_5 = 10;
   static var TYPE_BULIDING_1 = 11;
   static var TYPE_BULIDING_2 = 12;
   static var TYPE_BULIDING_3 = 13;
   static var TYPE_BULIDING_4 = 14;
   static var TYPE_BULIDING_5 = 15;
   static var PRICES = new Array(100,200,500,800,1000,150,200,500,800,1000,500,800,900,1200,1250);
   static var MATRICES = new Array(15);
   static var SYMBOL_BASE = "id_construction";
   static var CELL_VOID = 0;
   static var CELL_OCCUPIED = 1;
   static var STATE_UNDEFINED = 0;
   static var STATE_PLACING = 1;
   static var STATE_INSTALLED = 2;
   static var ENEMY_TURN_TOLERANCE = 0.1;
   static var RANGE_BONUS = 0;
   static var _BONUS = 0;
   function CBuilding()
   {
      super();
      this._boolMouseOver = false;
      this._boolTower = false;
      this.useHandCursor = false;
      this._numState = STATE_UNDEFINED;
   }
   function get numType()
   {
      return this._numType;
   }
   function set numType(__numValue)
   {
      if(this._numType != __numValue)
      {
         this._numType = __numValue;
         switch(this._numType)
         {
            case TYPE_TOWER_1_1:
               this._boolTower = true;
               this._numRange = 100;
               this._numTurnSpeed = 0.1;
               this._numAimingAltitude = CMap.ALTITUDE_GROUND;
               this._numReloadTime = 36;
               this._numReloadTimer = this._numReloadTime;
               break;
            case TYPE_TOWER_1_2:
               this._boolTower = true;
               this._numRange = 200;
               this._numTurnSpeed = 0.05;
               this._numAimingAltitude = CMap.ALTITUDE_GROUND;
               this._numReloadTime = 108;
               this._numReloadTimer = this._numReloadTime;
               break;
            case TYPE_TOWER_1_3:
               this._boolTower = true;
               this._numRange = 60;
               this._numTurnSpeed = 0;
               this._numAimingAltitude = CMap.ALTITUDE_GROUND;
               this._numReloadTime = 48;
               this._numReloadTimer = this._numReloadTime;
               break;
            case TYPE_TOWER_1_4:
               this._boolTower = true;
               this._numRange = 70;
               this._numTurnSpeed = 0.1;
               this._numAimingAltitude = CMap.ALTITUDE_GROUND;
               this._numReloadTime = 6;
               this._numReloadTimer = this._numReloadTime;
               break;
            case TYPE_TOWER_1_5:
               this._boolTower = true;
               this._numRange = 100;
               this._numTurnSpeed = 0.1;
               this._numAimingAltitude = CMap.ALTITUDE_BOTH;
               this._numReloadTime = 250;
               this._numReloadTimer = this._numReloadTime;
               break;
            case TYPE_TOWER_2_1:
               this._boolTower = true;
               this._numRange = 110;
               this._numTurnSpeed = 0.1;
               this._numAimingAltitude = CMap.ALTITUDE_AIR;
               this._numReloadTime = 6;
               this._numReloadTimer = this._numReloadTime;
               break;
            case TYPE_TOWER_2_2:
               this._boolTower = true;
               this._numRange = 90;
               this._numTurnSpeed = 0.1;
               this._numAimingAltitude = CMap.ALTITUDE_BOTH;
               this._numReloadTime = 24;
               this._numReloadTimer = this._numReloadTime;
               break;
            case TYPE_TOWER_2_3:
               this._boolTower = true;
               this._numRange = 100;
               this._numTurnSpeed = 0.1;
               this._numAimingAltitude = CMap.ALTITUDE_GROUND;
               this._numReloadTime = 24;
               this._numReloadTimer = this._numReloadTime;
               break;
            case TYPE_TOWER_2_4:
               this._boolTower = true;
               this._numRange = 90;
               this._numTurnSpeed = 0.1;
               this._numAimingAltitude = CMap.ALTITUDE_AIR;
               this._numReloadTime = 24;
               this._numReloadTimer = this._numReloadTime;
               break;
            case TYPE_TOWER_2_5:
               this._boolTower = true;
               this._numRange = 120;
               this._numTurnSpeed = 0.1;
               this._numAimingAltitude = CMap.ALTITUDE_GROUND;
               this._numReloadTime = 24;
               this._numReloadTimer = this._numReloadTime;
               break;
            case TYPE_BULIDING_1:
            case TYPE_BULIDING_2:
            case TYPE_BULIDING_3:
            case TYPE_BULIDING_4:
            case TYPE_BULIDING_5:
               this._boolTower = false;
         }
         this._numPrice = PRICES[this._numType - 1];
      }
   }
   function get numRange()
   {
      return this._numRange * (1 + RANGE_BONUS);
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
         switch(this._numState)
         {
            case STATE_PLACING:
               this.onRollOver = undefined;
               this.onRollOut = undefined;
               break;
            case STATE_INSTALLED:
               this.onRollOver = this.onInstalledRollOver;
               this.onRollOut = this.onInstalledRollOut;
         }
      }
   }
   function initBuilding(__numType)
   {
      this.numType = __numType;
      trace("Building type " + this.numType);
      this._vectDirection = new CVector(0,-1);
      var _loc8_;
      var _loc7_;
      var _loc5_;
      var _loc4_;
      var _loc3_;
      if(MATRICES[__numType] == undefined)
      {
         if(this.attachMovie(SYMBOL_BASE + __numType.toString() + "_matrix","_mcMatrix",0) == undefined)
         {
            Const.TRACE("ERROR! Couldn\'t load building matrix " + SYMBOL_BASE + __numType.toString() + "_matrix");
            return false;
         }
         _loc8_ = Math.ceil(this._mcMatrix._width / Const.MATRIX_CELL_WIDTH);
         _loc7_ = Math.ceil(this._mcMatrix._height / Const.MATRIX_CELL_HEIGHT);
         MATRICES[__numType] = new Array(_loc8_ * _loc7_);
         MATRICES[__numType].width = _loc8_;
         MATRICES[__numType].height = _loc7_;
         _loc5_ = {x:this._mcMatrix._x,y:this._mcMatrix._y};
         this.localToGlobal(_loc5_);
         _loc4_ = 0;
         while(_loc4_ < MATRICES[__numType].height)
         {
            _loc3_ = 0;
            while(_loc3_ < MATRICES[__numType].width)
            {
               if(this._mcMatrix.hitTest(_loc5_.x + Const.MATRIX_CELL_WIDTH / 2 + _loc3_ * Const.MATRIX_CELL_WIDTH,_loc5_.y + Const.MATRIX_CELL_HEIGHT / 2 + _loc4_ * Const.MATRIX_CELL_HEIGHT,true))
               {
                  MATRICES[__numType][_loc4_ * MATRICES[__numType].width + _loc3_] = CELL_OCCUPIED;
               }
               else
               {
                  MATRICES[__numType][_loc4_ * MATRICES[__numType].width + _loc3_] = CELL_VOID;
               }
               _loc3_ = _loc3_ + 1;
            }
            _loc4_ = _loc4_ + 1;
         }
         this._mcMatrix.removeMovieClip();
      }
      this._matrixPattern = MATRICES[__numType];
      if(this.attachMovie(SYMBOL_BASE + __numType.toString(),"_mcObject",1) == undefined)
      {
         Const.TRACE("ERROR! Couldn\'t load construction image " + SYMBOL_BASE + __numType.toString());
         return false;
      }
      var _loc6_;
      if(Const.TRACE_DEBUG_INFO)
      {
         _loc6_ = "Buidling matrix: \n";
         _loc4_ = 0;
         while(_loc4_ < this._matrixPattern.height)
         {
            _loc3_ = 0;
            while(_loc3_ < this._matrixPattern.width)
            {
               _loc6_ += this._matrixPattern[_loc4_ * this._matrixPattern.width + _loc3_] + " ";
               _loc3_ = _loc3_ + 1;
            }
            _loc6_ += "\n";
            _loc4_ = _loc4_ + 1;
         }
         Const.TRACE(_loc6_);
      }
      return true;
   }
   function copyFrom(__buildingSource)
   {
      var _loc2_ = {x:0,y:0};
      __buildingSource.localToGlobal(_loc2_);
      this._parent.globalToLocal(_loc2_);
      this._x = _loc2_.x;
      this._y = _loc2_.y;
      if(!this.initBuilding(__buildingSource.numType))
      {
         return false;
      }
      this._numCellI = __buildingSource._numCellI;
      this._numCellJ = __buildingSource._numCellJ;
      this._numState = __buildingSource.numState;
      return true;
   }
   function onInstalledRollOver()
   {
      if(!this._boolMouseOver)
      {
         this._boolMouseOver = true;
         this.dispatchMessage(CEventMovieClip.MSG_MOUSEOVER);
      }
      updateAfterEvent();
   }
   function onInstalledRollOut()
   {
      if(this._boolMouseOver)
      {
         this._boolMouseOver = false;
         this.dispatchMessage(CEventMovieClip.MSG_MOUSEOUT);
      }
      updateAfterEvent();
   }
   function process()
   {
      var _loc3_;
      var _loc6_;
      var _loc4_;
      var _loc2_;
      var _loc5_;
      var _loc7_;
      if(this._boolTower)
      {
         if(this._numReloadTimer > 0)
         {
            this._numReloadTimer = this._numReloadTimer - 1;
         }
         if(this._enemyTarget == undefined)
         {
            this.dispatchMessage(CEventMovieClip.MSG_TARGETLOST);
         }
         if(this._enemyTarget != undefined)
         {
            _loc3_ = {x:this._mcObject.mcGun._x,y:this._mcObject.mcGun._y};
            this._mcObject.localToGlobal(_loc3_);
            this._enemyTarget._parent.globalToLocal(_loc3_);
            _loc6_ = this._enemyTarget.getDistanceFrom(_loc3_.x,_loc3_.y);
            if(_loc6_ > this.numRange || _loc6_ == undefined)
            {
               this._enemyTarget = undefined;
            }
            else
            {
               _loc4_ = new CVector(this._enemyTarget._x - _loc3_.x,this._enemyTarget._y - _loc3_.y);
               if(this._vectDirection.getAngleWith(_loc4_) <= ENEMY_TURN_TOLERANCE)
               {
                  if(this._numReloadTimer == 0)
                  {
                     _loc2_ = {x:_loc3_.x,y:_loc3_.y,direction:this._vectDirection,altitude:this._enemyTarget.numAltitude};
                     _loc5_ = {x:this._enemyTarget._x,y:this._enemyTarget._y};
                     this._enemyTarget._parent.localToGlobal(_loc5_);
                     switch(this._numType)
                     {
                        case TYPE_TOWER_1_1:
                           _loc2_.type = CBlast.TYPE_ROCKET;
                           _loc2_.targetsEnemy = true;
                           _loc2_.target = this._enemyTarget;
                           _loc2_.speed = 3;
                           CSoundService.playSound(Const.SND_MISSILETURRETSHOT);
                           break;
                        case TYPE_TOWER_1_2:
                           _loc2_.type = CBlast.TYPE_BALL;
                           _loc2_.targetsEnemy = false;
                           _loc2_.targetX = _loc5_.x;
                           _loc2_.targetY = _loc5_.y;
                           _loc2_.speed = 3;
                           CSoundService.playSound(Const.SND_MORTARSHOT);
                           break;
                        case TYPE_TOWER_1_3:
                           _loc2_.type = CBlast.TYPE_ELECTRICFIELD;
                           _loc2_.targetsEnemy = false;
                           _loc2_.targetX = _loc3_.x;
                           _loc2_.targetY = _loc3_.y;
                           _loc2_.speed = 0;
                           CSoundService.playSound(Const.SND_TESLATOWERSHOT);
                           break;
                        case TYPE_TOWER_1_4:
                           _loc2_.type = CBlast.TYPE_LASERBEAM;
                           _loc2_.targetsEnemy = true;
                           _loc2_.target = this._enemyTarget;
                           _loc2_.speed = _loc4_.numLength;
                           CSoundService.playSound(Const.SND_GUTLINGLASERSHOT);
                           break;
                        case TYPE_TOWER_1_5:
                           _loc2_.type = CBlast.TYPE_NULIFYBALL;
                           _loc2_.targetsEnemy = true;
                           _loc2_.target = this._enemyTarget;
                           _loc2_.speed = 4;
                           CSoundService.playSound(Const.SND_NULIFICATORSHOT);
                           break;
                        case TYPE_TOWER_2_1:
                           _loc2_.type = CBlast.TYPE_AASHELL;
                           _loc2_.targetsEnemy = true;
                           _loc2_.target = this._enemyTarget;
                           _loc2_.speed = _loc4_.numLength;
                           CSoundService.playSound(Const.SND_AAGUNSHOT);
                           break;
                        case TYPE_TOWER_2_2:
                           _loc2_.type = CBlast.TYPE_SLOWSHOT;
                           _loc2_.targetsEnemy = true;
                           _loc2_.target = this._enemyTarget;
                           _loc2_.speed = 4;
                           CSoundService.playSound(Const.SND_GOOCANNONSHOT);
                           break;
                        case TYPE_TOWER_2_3:
                           _loc2_.type = CBlast.TYPE_CHAINBLAST;
                           _loc2_.targetsEnemy = true;
                           _loc2_.target = this._enemyTarget;
                           _loc2_.speed = 7;
                           CSoundService.playSound(Const.SND_CHAINGUNSHOT);
                           break;
                        case TYPE_TOWER_2_4:
                           _loc2_.type = CBlast.TYPE_GAUSSRAIL;
                           _loc2_.targetsEnemy = true;
                           _loc2_.target = this._enemyTarget;
                           _loc2_.speed = _loc4_.numLength;
                           CSoundService.playSound(Const.SND_GAUSSCANNONSHOT);
                           break;
                        case TYPE_TOWER_2_5:
                           _loc2_.type = CBlast.TYPE_CONFUSEBALL;
                           _loc2_.targetsEnemy = true;
                           _loc2_.target = this._enemyTarget;
                           _loc2_.speed = 5;
                           CSoundService.playSound(Const.SND_OILSPRAYSHOT);
                     }
                     this.dispatchMessage(CEventMovieClip.MSG_READYTOSHOOT,_loc2_);
                     this._numReloadTimer = this._numReloadTime;
                  }
               }
               else if(this._numTurnSpeed == 0)
               {
                  this._vectDirection.numX = _loc4_.numX;
                  this._vectDirection.numY = _loc4_.numY;
                  this._vectDirection.numLength = 1;
               }
               else
               {
                  _loc7_ = _loc4_.numX * this._vectDirection.numY - this._vectDirection.numX * _loc4_.numY;
                  if(_loc7_ > 0)
                  {
                     this._vectDirection.rotate(this._numTurnSpeed);
                  }
                  else
                  {
                     this._vectDirection.rotate(- this._numTurnSpeed);
                  }
               }
               this._mcObject.mcGun._rotation = this._vectDirection.numRotation;
            }
         }
      }
   }
}
