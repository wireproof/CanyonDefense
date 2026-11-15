class CMap extends MovieClip
{
   var _boolPaused;
   var _layerBlasts1;
   var _layerBuildings;
   var _layerEffects1;
   var _layerEffects2;
   var _layerEnemies1;
   var _layerEnemies2;
   var _layerInfo;
   var _layerWallShadows;
   var _layerWalls;
   var _matrixCache;
   var _matrixPattern;
   var _mcGrid;
   static var CELL_VOID = 0;
   static var CELL_ROCK = 1;
   static var CELL_WALL = 2;
   static var CELL_BUILDING = 10;
   static var ALTITUDE_GROUND = 1;
   static var ALTITUDE_AIR = 2;
   static var ALTITUDE_BOTH = 3;
   static var SYMBOL_BASE = "id_map";
   function CMap()
   {
      super();
      this.attachMovie("id_layer","_layerEnemies1",2);
      this.attachMovie("id_layer","_layerWallShadows",3);
      this.attachMovie("id_layer","_layerWalls",4);
      this.attachMovie("id_layer","_layerEffects1",5);
      this.attachMovie("id_layer","_layerBuildings",8);
      this.attachMovie("id_layer","_layerBlasts1",9);
      this.attachMovie("id_layer","_layerEffects2",10);
      this.attachMovie("id_layer","_layerEnemies2",11);
      this.attachMovie("id_layer","_layerInfo",12);
      this._matrixCache = new Array(Const.MATRIX_WIDTH * Const.MATRIX_HEIGHT);
      this._matrixCache.width = Const.MATRIX_WIDTH;
      this._matrixCache.height = Const.MATRIX_HEIGHT;
      this._boolPaused = false;
   }
   function get buildingsLayer()
   {
      return this._layerBuildings;
   }
   function get enemiesLayer1()
   {
      return this._layerEnemies1;
   }
   function get enemiesLayer2()
   {
      return this._layerEnemies2;
   }
   function get noEnemies()
   {
      for(var _loc2_ in this._layerEnemies1)
      {
         if(this._layerEnemies1[_loc2_] instanceof CEnemy)
         {
            return false;
         }
      }
      for(_loc2_ in this._layerEnemies2)
      {
         if(this._layerEnemies2[_loc2_] instanceof CEnemy)
         {
            return false;
         }
      }
      return true;
   }
   function get boolPaused()
   {
      return this._boolPaused;
   }
   function set boolPaused(__boolValue)
   {
      this._boolPaused = __boolValue;
      this._layerEffects1.boolPaused = __boolValue;
      this._layerEffects2.boolPaused = __boolValue;
      this._layerBlasts1.boolPaused = __boolValue;
      this._layerEnemies1.boolPaused = __boolValue;
      this._layerEnemies2.boolPaused = __boolValue;
   }
   function loadMap(__numIndex)
   {
      this._matrixPattern = new Array(Const.MATRIX_WIDTH * Const.MATRIX_HEIGHT);
      this._matrixPattern.width = Const.MATRIX_WIDTH;
      this._matrixPattern.height = Const.MATRIX_HEIGHT;
      var _loc5_ = this.attachMovie(SYMBOL_BASE + __numIndex.toString() + "_matrix","_mcMatrix",1);
      if(_loc5_ == undefined)
      {
         Const.TRACE("ERROR! Couldn\'t load map " + SYMBOL_BASE + __numIndex.toString() + "_matrix");
         return false;
      }
      var _loc4_ = {x:0,y:0};
      this.localToGlobal(_loc4_);
      var _loc3_ = 0;
      var _loc2_;
      while(_loc3_ < Const.MATRIX_HEIGHT)
      {
         _loc2_ = 0;
         while(_loc2_ < Const.MATRIX_WIDTH)
         {
            if(_loc5_.hitTest(_loc4_.x + Const.MATRIX_CELL_WIDTH / 2 + _loc2_ * Const.MATRIX_CELL_WIDTH,_loc4_.y + Const.MATRIX_CELL_HEIGHT / 2 + _loc3_ * Const.MATRIX_CELL_HEIGHT,true))
            {
               this._matrixPattern[_loc3_ * Const.MATRIX_WIDTH + _loc2_] = CELL_ROCK;
            }
            else
            {
               this._matrixPattern[_loc3_ * Const.MATRIX_WIDTH + _loc2_] = CELL_VOID;
            }
            _loc2_ = _loc2_ + 1;
         }
         _loc3_ = _loc3_ + 1;
      }
      _loc5_.removeMovieClip();
      this.attachMovie(SYMBOL_BASE + __numIndex.toString() + "_sand","_mcSand",1);
      this.attachMovie(SYMBOL_BASE + __numIndex.toString() + "_landscape","_mcLandscape",6);
      this.attachMovie("id_grid","_mcGrid",7);
      this._mcGrid._visible = false;
      this.markCacheMatrix();
      this.writeMatrixFromCache();
      return true;
   }
   function markCacheMatrix(__numNewWallI, __numNewWallJ)
   {
      var _loc7_ = 0;
      while(_loc7_ < this._matrixPattern.length)
      {
         this._matrixCache[_loc7_] = this._matrixPattern[_loc7_];
         _loc7_ = _loc7_ + 1;
      }
      var _loc2_ = new Array();
      var _loc3_;
      if(__numNewWallI == undefined || __numNewWallJ == undefined)
      {
         _loc3_ = CELL_VOID;
      }
      else if(this._matrixCache[__numNewWallI * this._matrixCache.width + __numNewWallJ] <= CELL_VOID)
      {
         _loc3_ = CELL_VOID - this._matrixCache[__numNewWallI * this._matrixCache.width + __numNewWallJ];
         this._matrixCache[__numNewWallI * this._matrixCache.width + __numNewWallJ] = CELL_WALL;
      }
      _loc7_ = 0;
      var _loc4_;
      while(_loc7_ < this._matrixCache.height)
      {
         _loc4_ = 0;
         while(_loc4_ < this._matrixCache.width)
         {
            if(this._matrixCache[_loc7_ * this._matrixCache.width + _loc4_] < CELL_VOID)
            {
               if(this._matrixCache[_loc7_ * this._matrixCache.width + _loc4_] == CELL_VOID - _loc3_)
               {
                  _loc2_.push({i:_loc7_,j:_loc4_});
               }
               else if(this._matrixCache[_loc7_ * this._matrixCache.width + _loc4_] < CELL_VOID - _loc3_)
               {
                  this._matrixCache[_loc7_ * this._matrixCache.width + _loc4_] = CELL_VOID;
               }
            }
            _loc4_ = _loc4_ + 1;
         }
         _loc7_ = _loc7_ + 1;
      }
      if(_loc3_ == CELL_VOID)
      {
         _loc3_ = 1;
         _loc2_ = this.getExitCells();
         for(_loc7_ in _loc2_)
         {
            this._matrixCache[_loc2_[_loc7_].i * this._matrixCache.width + _loc2_[_loc7_].j] = CELL_VOID - _loc3_;
         }
      }
      var _loc5_ = false;
      var _loc6_;
      _loc3_ = _loc3_ + 1;
      while(!_loc5_)
      {
         _loc6_ = new Array();
         _loc5_ = true;
         for(var _loc8_ in _loc2_)
         {
            _loc7_ = Math.max(_loc2_[_loc8_].i - 1,0);
            while(_loc7_ <= Math.min(_loc2_[_loc8_].i + 1,this._matrixCache.height - 1))
            {
               _loc4_ = Math.max(_loc2_[_loc8_].j - 1,0);
               while(_loc4_ <= Math.min(_loc2_[_loc8_].j + 1,this._matrixCache.width - 1))
               {
                  if(!(_loc7_ != _loc2_[_loc8_].i && _loc4_ != _loc2_[_loc8_].j || _loc7_ == _loc2_[_loc8_].i && _loc4_ == _loc2_[_loc8_].j))
                  {
                     if(this._matrixCache[_loc7_ * this._matrixCache.width + _loc4_] == CELL_VOID)
                     {
                        this._matrixCache[_loc7_ * this._matrixCache.width + _loc4_] = CELL_VOID - _loc3_;
                        _loc6_.push({i:_loc7_,j:_loc4_});
                        _loc5_ = false;
                     }
                  }
                  _loc4_ = _loc4_ + 1;
               }
               _loc7_ = _loc7_ + 1;
            }
         }
         _loc3_ = _loc3_ + 1;
         _loc2_ = _loc6_;
      }
      _loc7_ = 0;
      while(_loc7_ < this._matrixCache.length)
      {
         if(this._matrixCache[_loc7_] == CELL_VOID)
         {
            return false;
         }
         _loc7_ = _loc7_ + 1;
      }
      return true;
   }
   function writeMatrixFromCache()
   {
      var _loc2_ = 0;
      while(_loc2_ < this._matrixPattern.length)
      {
         this._matrixPattern[_loc2_] = this._matrixCache[_loc2_];
         _loc2_ = _loc2_ + 1;
      }
   }
   function addWall(__numCellI, __numCellJ)
   {
      this._layerWalls.addElement("id_cursor_wall",{_x:__numCellJ * Const.MATRIX_CELL_WIDTH,_y:__numCellI * Const.MATRIX_CELL_HEIGHT});
      this._layerWallShadows.addElement("id_wall_shadow",{_x:__numCellJ * Const.MATRIX_CELL_WIDTH,_y:__numCellI * Const.MATRIX_CELL_HEIGHT});
      this.writeMatrixFromCache();
      trace("Added wall at [" + __numCellI + "," + __numCellJ + "]");
      var _loc2_;
      for(var _loc3_ in this._layerEnemies1)
      {
         if(this._layerEnemies1[_loc3_] instanceof CEnemy)
         {
            _loc2_ = CEnemy(this._layerEnemies1[_loc3_]);
            trace("Enemy at [" + _loc2_._numCellI + "," + _loc2_._numCellJ + "]");
            _loc2_.updateWaypoint();
         }
      }
   }
   function cellHitTest(__numX, __numY)
   {
      var _loc2_ = {out:false,i:0,j:0,x:0,y:0};
      var _loc3_ = {x:0,y:0};
      this.localToGlobal(_loc3_);
      _loc2_.j = Math.floor((__numX - _loc3_.x) / Const.MATRIX_CELL_WIDTH);
      _loc2_.i = Math.floor((__numY - _loc3_.y) / Const.MATRIX_CELL_HEIGHT);
      if(_loc2_.i < 0)
      {
         _loc2_.out = true;
         _loc2_.j = undefined;
      }
      if(_loc2_.j < 0)
      {
         _loc2_.out = true;
         _loc2_.j = undefined;
      }
      if(_loc2_.j >= this._matrixPattern.width)
      {
         _loc2_.out = true;
         _loc2_.j = undefined;
      }
      if(_loc2_.i >= this._matrixPattern.height)
      {
         _loc2_.out = true;
         _loc2_.j = undefined;
      }
      _loc2_.x = _loc3_.x + _loc2_.j * Const.MATRIX_CELL_WIDTH;
      _loc2_.y = _loc3_.y + _loc2_.i * Const.MATRIX_CELL_HEIGHT;
      return _loc2_;
   }
   function checkPlacingSpace(__numI, __numJ, __matrixPattern)
   {
      if(__numI < 0 || __numJ < 0 || __numI + __matrixPattern.height > this._matrixPattern.height || __numJ + __matrixPattern.width > this._matrixPattern.width)
      {
         return false;
      }
      var _loc3_ = 0;
      var _loc2_;
      while(_loc3_ < __matrixPattern.height)
      {
         _loc2_ = 0;
         while(_loc2_ < __matrixPattern.width)
         {
            if(__matrixPattern[_loc3_ * __matrixPattern.width + _loc2_] != CBuilding.CELL_VOID && this._matrixPattern[(_loc3_ + __numI) * this._matrixPattern.width + (_loc2_ + __numJ)] != CELL_ROCK && this._matrixPattern[(_loc3_ + __numI) * this._matrixPattern.width + (_loc2_ + __numJ)] != CELL_WALL)
            {
               return false;
            }
            _loc2_ = _loc2_ + 1;
         }
         _loc3_ = _loc3_ + 1;
      }
      return true;
   }
   function checkBuildingSpace(__numI, __numJ)
   {
      return this._matrixPattern[__numI * this._matrixPattern.width + __numJ] >= CELL_BUILDING;
   }
   function checkWallSpace(__numI, __numJ)
   {
      if(this._matrixPattern[__numI * this._matrixPattern.width + __numJ] > CELL_VOID || __numI == 0 || __numJ == 0 || __numI == this._matrixPattern.height - 1 || __numJ == this._matrixPattern.width - 1)
      {
         return false;
      }
      return true;
   }
   function isHitWithGroundEnemy(__mcTarget)
   {
      var _loc2_ = false;
      for(var _loc4_ in this._layerEnemies1)
      {
         if(this._layerEnemies1[_loc4_] instanceof CEnemy && this._layerEnemies1[_loc4_].hitTest(__mcTarget))
         {
            _loc2_ = true;
            break;
         }
      }
      return _loc2_;
   }
   function addBuilding(__buildingSource)
   {
      var _loc2_ = this._layerBuildings.addElement("id_building");
      if(!_loc2_.copyFrom(__buildingSource))
      {
         return false;
      }
      _loc2_.numState = CBuilding.STATE_INSTALLED;
      var _loc4_ = 0;
      var _loc3_;
      while(_loc4_ < _loc2_._matrixPattern.height)
      {
         _loc3_ = 0;
         while(_loc3_ < _loc2_._matrixPattern.width)
         {
            if(_loc2_._matrixPattern[_loc4_ * _loc2_._matrixPattern.width + _loc3_] == CBuilding.CELL_OCCUPIED)
            {
               this._matrixPattern[(_loc4_ + _loc2_._numCellI) * this._matrixPattern.width + (_loc3_ + _loc2_._numCellJ)] = CELL_BUILDING + _loc2_.getDepth();
            }
            _loc3_ = _loc3_ + 1;
         }
         _loc4_ = _loc4_ + 1;
      }
      return true;
   }
   function getBuildingAt(__numI, __numJ)
   {
      var _loc2_ = this._matrixPattern[__numI * this._matrixPattern.width + __numJ] - CELL_BUILDING;
      return CBuilding(this._layerBuildings.getInstanceAtDepth(_loc2_));
   }
   function deleteBuilding(__bldTarget)
   {
      var _loc4_;
      var _loc2_;
      if(__bldTarget._parent == this._layerBuildings)
      {
         _loc4_ = 0;
         while(_loc4_ < __bldTarget._matrixPattern.height)
         {
            _loc2_ = 0;
            while(_loc2_ < __bldTarget._matrixPattern.width)
            {
               if(__bldTarget._matrixPattern[_loc4_ * __bldTarget._matrixPattern.width + _loc2_] == CBuilding.CELL_OCCUPIED)
               {
                  this._matrixPattern[(_loc4_ + __bldTarget._numCellI) * this._matrixPattern.width + (_loc2_ + __bldTarget._numCellJ)] = CELL_ROCK;
               }
               _loc2_ = _loc2_ + 1;
            }
            _loc4_ = _loc4_ + 1;
         }
         __bldTarget.removeMovieClip();
      }
   }
   function addEnemy(__numType, __numLevel, __effectInitial, __numWaveIndex)
   {
      var _loc5_ = false;
      if(__numType == CEnemy.TYPE_PLANE || __numType == CEnemy.TYPE_INSECT || __numType == CEnemy.TYPE_SCORPIO)
      {
         _loc5_ = true;
      }
      var _loc3_;
      var _loc4_;
      var _loc6_;
      var _loc7_;
      if(_loc5_)
      {
         _loc3_ = 0;
         _loc4_ = 4 + random(6);
      }
      else
      {
         _loc6_ = this.getEntryCells();
         _loc7_ = random(_loc6_.length);
         _loc3_ = _loc6_[_loc7_].i;
         _loc4_ = _loc6_[_loc7_].j;
      }
      var _loc2_;
      if(_loc5_)
      {
         _loc2_ = this._layerEnemies2.addElement("id_enemy",{_mapReference:this,_numCellI:_loc3_,_numCellJ:_loc4_});
         _loc2_.numAltitude = ALTITUDE_AIR;
      }
      else
      {
         _loc2_ = this._layerEnemies1.addElement("id_enemy",{_mapReference:this,_numCellI:_loc3_,_numCellJ:_loc4_});
         _loc2_.numAltitude = ALTITUDE_GROUND;
      }
      _loc2_._x = _loc4_ * Const.MATRIX_CELL_WIDTH + Const.MATRIX_CELL_WIDTH / 2;
      _loc2_._y = _loc3_ * Const.MATRIX_CELL_HEIGHT + Const.MATRIX_CELL_HEIGHT / 2;
      if(_loc3_ == 0)
      {
         _loc2_._y -= Const.MATRIX_CELL_HEIGHT;
         _loc2_._x += random(16) - 8;
         _loc2_._y -= 35 * __numWaveIndex;
         _loc2_._vectSpeed.numX = 0;
         _loc2_._vectSpeed.numY = 100;
      }
      else if(_loc4_ == 0)
      {
         _loc2_._x -= Const.MATRIX_CELL_WIDTH;
         _loc2_._y += random(16) - 8;
         _loc2_._x -= 35 * __numWaveIndex;
         _loc2_._vectSpeed.numX = 100;
         _loc2_._vectSpeed.numY = 0;
      }
      if(_loc5_)
      {
         _loc2_._numWaypointX = _loc2_._x;
         _loc2_._numWaypointY = this._matrixPattern.height * Const.MATRIX_CELL_HEIGHT + Const.MATRIX_CELL_HEIGHT / 2;
      }
      else
      {
         _loc2_.updateWaypoint();
      }
      _loc2_.initEnemy(__numType,__numLevel,this._layerInfo);
      if(__effectInitial != undefined)
      {
         _loc2_.applyEffect(__effectInitial);
      }
   }
   function addBlast(__objParam)
   {
      this._layerBlasts1.globalToLocal(__objParam);
      var _loc4_ = {_x:__objParam.x,_y:__objParam.y,vectSpeed:__objParam.direction,numSpeed:__objParam.speed,_numAltitude:__objParam.altitude};
      var _loc3_ = this._layerBlasts1.addElement("id_blast",_loc4_);
      _loc3_.initBlast(__objParam.type);
      if(__objParam.targetsEnemy)
      {
         _loc3_.setTarget(__objParam.targetsEnemy,__objParam.target);
      }
      else
      {
         _loc3_.setTarget(__objParam.targetsEnemy,{x:__objParam.targetX,y:__objParam.targetY});
      }
   }
   function addGFX(__objParam)
   {
      var _loc4_;
      if(__objParam.altitude == ALTITUDE_AIR || __objParam.altitude == ALTITUDE_BOTH)
      {
         _loc4_ = this._layerEffects2;
      }
      else
      {
         _loc4_ = this._layerEffects1;
      }
      _loc4_.globalToLocal(__objParam);
      var _loc3_ = {_x:__objParam.x,_y:__objParam.y};
      if(__objParam.radius)
      {
         _loc3_._width = 2 * __objParam.radius;
         _loc3_._height = 2 * __objParam.radius;
      }
      _loc4_.addElement(__objParam.symbol,_loc3_);
   }
   function getEntryCells()
   {
      var _loc2_ = new Array();
      var _loc3_ = 0;
      while(_loc3_ < this._matrixPattern.width)
      {
         if(this._matrixPattern[_loc3_] <= CELL_VOID)
         {
            _loc2_.push({i:0,j:_loc3_});
         }
         _loc3_ = _loc3_ + 1;
      }
      var _loc4_ = 0;
      while(_loc4_ < this._matrixPattern.height)
      {
         if(this._matrixPattern[_loc4_ * this._matrixPattern.width] <= CELL_VOID)
         {
            _loc2_.push({i:_loc4_,j:0});
         }
         _loc4_ = _loc4_ + 1;
      }
      return _loc2_;
   }
   function getNextCell(__numCellI, __numCellJ)
   {
      var _loc7_;
      var _loc6_ = false;
      var _loc5_ = Math.max(__numCellI - 1,0);
      var _loc4_;
      while(_loc5_ <= Math.min(__numCellI + 1,this._matrixPattern.height - 1))
      {
         _loc4_ = Math.max(__numCellJ - 1,0);
         while(_loc4_ <= Math.min(__numCellJ + 1,this._matrixPattern.width - 1))
         {
            if(!(_loc5_ != __numCellI && _loc4_ != __numCellJ || _loc5_ == __numCellI && _loc4_ == __numCellJ))
            {
               if(this._matrixPattern[_loc5_ * this._matrixPattern.width + _loc4_] == this._matrixPattern[__numCellI * this._matrixPattern.width + __numCellJ] + 1 && this._matrixPattern[_loc5_ * this._matrixPattern.width + _loc4_] <= CELL_VOID)
               {
                  _loc7_ = {i:_loc5_,j:_loc4_};
                  _loc6_ = true;
                  break;
               }
            }
            _loc4_ = _loc4_ + 1;
         }
         if(_loc6_)
         {
            break;
         }
         _loc5_ = _loc5_ + 1;
      }
      return _loc7_;
   }
   function getExitCells()
   {
      var _loc2_ = new Array();
      var _loc3_ = 0;
      while(_loc3_ < this._matrixPattern.width)
      {
         if(this._matrixPattern[(this._matrixPattern.height - 1) * this._matrixPattern.width + _loc3_] <= CELL_VOID)
         {
            _loc2_.push({i:this._matrixPattern.height - 1,j:_loc3_});
         }
         _loc3_ = _loc3_ + 1;
      }
      var _loc4_ = 0;
      while(_loc4_ < this._matrixPattern.height)
      {
         if(this._matrixPattern[(_loc4_ + 1) * this._matrixPattern.width - 1] <= CELL_VOID)
         {
            _loc2_.push({i:_loc4_,j:this._matrixPattern.width - 1});
         }
         _loc4_ = _loc4_ + 1;
      }
      return _loc2_;
   }
   function getNearestEnemy(__numX, __numY, __numRange, __numAltitude, __enemyForbidden)
   {
      var _loc3_ = 999999;
      var _loc4_;
      var _loc2_;
      if(__numAltitude == ALTITUDE_GROUND || __numAltitude == ALTITUDE_BOTH)
      {
         for(var _loc9_ in this._layerEnemies1)
         {
            if(this._layerEnemies1[_loc9_] instanceof CEnemy && this._layerEnemies1[_loc9_] != __enemyForbidden && this._layerEnemies1[_loc9_]._x > 0 && this._layerEnemies1[_loc9_]._y > 0)
            {
               _loc2_ = this._layerEnemies1[_loc9_].getDistanceFrom(__numX,__numY);
               if(_loc2_ <= __numRange && _loc2_ < _loc3_)
               {
                  _loc3_ = _loc2_;
                  _loc4_ = this._layerEnemies1[_loc9_];
               }
            }
         }
      }
      if(__numAltitude == ALTITUDE_AIR || __numAltitude == ALTITUDE_BOTH)
      {
         for(_loc9_ in this._layerEnemies2)
         {
            if(this._layerEnemies2[_loc9_] instanceof CEnemy && this._layerEnemies2[_loc9_] != __enemyForbidden && this._layerEnemies2[_loc9_]._x > 0 && this._layerEnemies2[_loc9_]._y > 0)
            {
               _loc2_ = this._layerEnemies2[_loc9_].getDistanceFrom(__numX,__numY);
               if(_loc2_ <= __numRange && _loc2_ < _loc3_)
               {
                  _loc3_ = _loc2_;
                  _loc4_ = this._layerEnemies2[_loc9_];
               }
            }
         }
      }
      return _loc4_;
   }
   function applySplashEffect(__effectSplash, __numCenterX, __numCenterY, __numRadius, __numAltitude)
   {
      var _loc2_;
      if(__numAltitude == ALTITUDE_GROUND || __numAltitude == ALTITUDE_BOTH)
      {
         for(var _loc7_ in this._layerEnemies1)
         {
            if(this._layerEnemies1[_loc7_] instanceof CEnemy)
            {
               _loc2_ = this._layerEnemies1[_loc7_].getDistanceFrom(__numCenterX,__numCenterY);
               if(_loc2_ <= __numRadius)
               {
                  this._layerEnemies1[_loc7_].applyEffect(__effectSplash);
               }
            }
         }
      }
      if(__numAltitude == ALTITUDE_AIR || __numAltitude == ALTITUDE_BOTH)
      {
         for(_loc7_ in this._layerEnemies2)
         {
            if(this._layerEnemies2[_loc7_] instanceof CEnemy)
            {
               _loc2_ = this._layerEnemies2[_loc7_].getDistanceFrom(__numCenterX,__numCenterY);
               if(_loc2_ <= __numRadius)
               {
                  this._layerEnemies2[_loc7_].applyEffect(__effectSplash);
               }
            }
         }
      }
   }
   function toggleGrid(__boolVisible)
   {
      this._mcGrid._visible = __boolVisible;
   }
   function process()
   {
      this._layerEnemies1.process();
      this._layerEnemies2.process();
      this._layerBuildings.process();
      this._layerBlasts1.process();
   }
}
