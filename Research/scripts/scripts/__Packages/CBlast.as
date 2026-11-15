class CBlast extends CEventMovieClip
{
   var _boolTargetsEnemy;
   var _mcTarget;
   var _numAltitude;
   var _numDamage;
   var _numLiveTimer;
   var _numSpeed;
   var _numSplashRadius;
   var _numTTL;
   var _numTargetX;
   var _numTargetY;
   var _numTurnSpeed;
   var _numType;
   var _parent;
   var _rotation;
   var _strEffectSymbol;
   var _vectSpeed;
   var _x;
   var _y;
   var attachMovie;
   var lineStyle;
   var lineTo;
   var moveTo;
   var removeMovieClip;
   static var TYPE_ROCKET = 1;
   static var TYPE_BALL = 2;
   static var TYPE_SLOWSHOT = 3;
   static var TYPE_ELECTRICFIELD = 4;
   static var TYPE_NULIFYBALL = 5;
   static var TYPE_LASERBEAM = 6;
   static var TYPE_AASHELL = 7;
   static var TYPE_MISSILE = 8;
   static var TYPE_CHAINBLAST = 9;
   static var TYPE_GAUSSRAIL = 10;
   static var TYPE_CONFUSEBALL = 11;
   static var SYMBOL_BASE = "id_blast";
   static var TARGET_HIT_TOLERANCE = 10;
   static var TARGET_TURN_TOLERANCE = 0.1;
   static var TTL = 100;
   static var DAMAGE_BONUS = 0;
   function CBlast()
   {
      super();
      this._numLiveTimer = TTL;
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
            case TYPE_ROCKET:
               this._numTurnSpeed = 0.2;
               this._numDamage = 5 * (1 + DAMAGE_BONUS);
               this._numSplashRadius = 0;
               break;
            case TYPE_BALL:
               this._numTurnSpeed = 0.05;
               this._numDamage = 20 * (1 + DAMAGE_BONUS);
               this._numSplashRadius = 25;
               this._strEffectSymbol = "id_gfx_splash";
               break;
            case TYPE_SLOWSHOT:
               this._numTurnSpeed = 0.1;
               this._numDamage = 1 * (1 + DAMAGE_BONUS);
               this._numSplashRadius = 15;
               this._strEffectSymbol = "id_gfx_slowsplash";
               break;
            case TYPE_ELECTRICFIELD:
               this._numTurnSpeed = 0;
               this._numDamage = 10 * (1 + DAMAGE_BONUS);
               this._numSplashRadius = 60 * (1 + CBuilding.RANGE_BONUS);
               this._strEffectSymbol = "id_gfx_electricfield";
               break;
            case TYPE_NULIFYBALL:
               this._numTurnSpeed = 0.1;
               this._numSplashRadius = 0;
               break;
            case TYPE_LASERBEAM:
               this._numTurnSpeed = 0;
               this._numDamage = 2 * (1 + DAMAGE_BONUS);
               this._numSplashRadius = 0;
               this.lineStyle(0,16732240);
               this.moveTo(0,0);
               this.lineTo(0,this._vectSpeed.numLength);
               this.lineStyle(0,16711680,50);
               this.moveTo(1,0);
               this.lineTo(1,this._vectSpeed.numLength);
               this.moveTo(-1,0);
               this.lineTo(-1,this._vectSpeed.numLength);
               break;
            case TYPE_AASHELL:
               this._numTurnSpeed = 0;
               this._numDamage = 1 * (1 + DAMAGE_BONUS);
               this._numSplashRadius = 0;
               this._strEffectSymbol = "id_gfx_aablast";
               break;
            case TYPE_MISSILE:
               this._numTurnSpeed = 0.1;
               this._numDamage = 25 * (1 + DAMAGE_BONUS);
               this._numSplashRadius = 100;
               this._strEffectSymbol = "id_gfx_missileblast";
               break;
            case TYPE_CHAINBLAST:
               this._numTurnSpeed = 3.141592653589793;
               this._numDamage = 8 * (1 + DAMAGE_BONUS);
               this._numSplashRadius = 0;
               this._numTTL = 1;
               break;
            case TYPE_GAUSSRAIL:
               this._numTurnSpeed = 0;
               this._numDamage = 8 * (1 + DAMAGE_BONUS);
               this._numSplashRadius = 0;
               this.lineStyle(0,0,70);
               this.moveTo(0,0);
               this.lineTo(0,this._vectSpeed.numLength);
               this.lineStyle(0,0,40);
               this.moveTo(1,0);
               this.lineTo(1,this._vectSpeed.numLength);
               this.moveTo(-1,0);
               this.lineTo(-1,this._vectSpeed.numLength);
               break;
            case TYPE_CONFUSEBALL:
               this._numTurnSpeed = 0.5;
               this._numDamage = 3 * (1 + DAMAGE_BONUS);
               this._numSplashRadius = 0;
         }
      }
   }
   function get vectSpeed()
   {
      return this._vectSpeed;
   }
   function set vectSpeed(__vectPattern)
   {
      this._vectSpeed = __vectPattern.makeCopy();
      this._vectSpeed.numLength = this._numSpeed;
   }
   function get numSpeed()
   {
      return this._numSpeed;
   }
   function set numSpeed(__numValue)
   {
      this._numSpeed = __numValue;
      this._vectSpeed.numLength = this._numSpeed;
   }
   function initBlast(__numType)
   {
      this.attachMovie(SYMBOL_BASE + __numType.toString(),"_mcObject",1);
      this.numType = __numType;
   }
   function setTarget(__boolTargetsEnemy, __objTarget)
   {
      this._boolTargetsEnemy = __boolTargetsEnemy;
      if(this._boolTargetsEnemy)
      {
         this._mcTarget = MovieClip(__objTarget);
      }
      else
      {
         this._numTargetX = __objTarget.x;
         this._numTargetY = __objTarget.y;
      }
   }
   function process()
   {
      var _loc2_;
      var _loc3_;
      var _loc4_;
      var _loc7_;
      var _loc5_;
      var _loc8_;
      var _loc6_;
      if(this._boolTargetsEnemy && !this._mcTarget.boolExists)
      {
         this._numLiveTimer = this._numLiveTimer - 1;
         if(this._numLiveTimer == 0)
         {
            this.removeMovieClip();
         }
      }
      else
      {
         _loc2_ = new Object();
         if(this._boolTargetsEnemy)
         {
            _loc2_.x = this._mcTarget._x;
            _loc2_.y = this._mcTarget._y;
            this._mcTarget._parent.localToGlobal(objTargetGlobal);
         }
         else
         {
            _loc2_.x = this._numTargetX;
            _loc2_.y = this._numTargetY;
         }
         var objTargetGlobal = {x:_loc2_.x,y:_loc2_.y};
         this._parent.globalToLocal(_loc2_);
         _loc3_ = new CVector(_loc2_.x - this._x,_loc2_.y - this._y);
         if(_loc3_.numLength <= TARGET_HIT_TOLERANCE)
         {
            switch(this._numType)
            {
               case TYPE_ROCKET:
               case TYPE_AASHELL:
                  this._mcTarget.applyEffect(new CEffect(CEffect.TYPE_DAMAGE,{damage:this._numDamage}));
                  break;
               case TYPE_CHAINBLAST:
                  this._mcTarget.applyEffect(new CEffect(CEffect.TYPE_DAMAGE,{damage:this._numDamage / this._numTTL}));
                  break;
               case TYPE_MISSILE:
                  this.dispatchMessage(CEventMovieClip.MSG_SPLASHEFFECT,{effect:new CEffect(CEffect.TYPE_PIERCEDAMAGE,{damage:this._numDamage}),centerX:objTargetGlobal.x,centerY:objTargetGlobal.y,radius:this._numSplashRadius,altitude:this._numAltitude});
               case TYPE_BALL:
               case TYPE_ELECTRICFIELD:
                  this.dispatchMessage(CEventMovieClip.MSG_SPLASHEFFECT,{effect:new CEffect(CEffect.TYPE_DAMAGE,{damage:this._numDamage}),centerX:objTargetGlobal.x,centerY:objTargetGlobal.y,radius:this._numSplashRadius,altitude:this._numAltitude});
                  break;
               case TYPE_SLOWSHOT:
                  this._mcTarget.applyEffect(new CEffect(CEffect.TYPE_DAMAGE,{damage:this._numDamage}));
                  this.dispatchMessage(CEventMovieClip.MSG_SPLASHEFFECT,{effect:new CEffect(CEffect.TYPE_SLOW,{percent:0.25},36),centerX:objTargetGlobal.x,centerY:objTargetGlobal.y,radius:this._numSplashRadius,altitude:this._numAltitude});
                  break;
               case TYPE_NULIFYBALL:
                  this._mcTarget.applyEffect(new CEffect(CEffect.TYPE_CLEAR));
                  break;
               case TYPE_LASERBEAM:
               case TYPE_GAUSSRAIL:
                  this._mcTarget.applyEffect(new CEffect(CEffect.TYPE_PIERCEDAMAGE,{damage:this._numDamage}));
                  break;
               case TYPE_CONFUSEBALL:
                  this._mcTarget.applyEffect(new CEffect(CEffect.TYPE_DAMAGE,{damage:this._numDamage}));
                  this._mcTarget.applyEffect(new CEffect(CEffect.TYPE_CONFUSE,{percent:0.7},60));
            }
            if(this._strEffectSymbol)
            {
               _loc4_ = {symbol:this._strEffectSymbol,x:this._x,y:this._y,altitude:this._numAltitude};
               if(this._numType == TYPE_ELECTRICFIELD)
               {
                  _loc4_.altitude = CMap.ALTITUDE_AIR;
                  _loc4_.radius = this._numSplashRadius;
               }
               this._parent.localToGlobal(_loc4_);
               this.dispatchMessage(CEventMovieClip.MSG_CREATEGFX,_loc4_);
            }
            if(this._numType == TYPE_CHAINBLAST && this._numTTL < 3)
            {
               this._numTTL = this._numTTL + 1;
               _loc7_ = this._mcTarget;
               this._mcTarget = undefined;
               this.dispatchMessage(CEventMovieClip.MSG_TARGETLOST,{range:50,alt:CMap.ALTITUDE_GROUND,forbidden:_loc7_});
               if(!this._mcTarget.boolExists)
               {
                  this.removeMovieClip();
               }
            }
            else
            {
               this.removeMovieClip();
            }
         }
         _loc5_ = this._vectSpeed.getAngleWith(_loc3_);
         if(_loc5_ > TARGET_TURN_TOLERANCE)
         {
            _loc8_ = _loc3_.numX * this._vectSpeed.numY - this._vectSpeed.numX * _loc3_.numY;
            _loc6_ = this._numTurnSpeed <= _loc5_ ? this._numTurnSpeed : _loc5_;
            if(_loc8_ > 0)
            {
               this._vectSpeed.rotate(_loc6_);
            }
            else
            {
               this._vectSpeed.rotate(- _loc6_);
            }
         }
      }
      this._x += this._vectSpeed.numX;
      this._y += this._vectSpeed.numY;
      this._rotation = this._vectSpeed.numRotation;
   }
}
