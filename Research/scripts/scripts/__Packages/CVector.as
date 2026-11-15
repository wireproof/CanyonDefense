class CVector
{
   var _numX;
   var _numY;
   var MIN_LENGTH = 0.001;
   function CVector(__numX, __numY)
   {
      this._numX = __numX;
      this._numY = __numY;
   }
   function get numX()
   {
      return this._numX;
   }
   function set numX(__numNew)
   {
      this._numX = __numNew;
   }
   function get numY()
   {
      return this._numY;
   }
   function set numY(__numNew)
   {
      this._numY = __numNew;
   }
   function get numLength()
   {
      return Math.sqrt(this._numX * this._numX + this._numY * this._numY);
   }
   function set numLength(__numNew)
   {
      if(__numNew < this.MIN_LENGTH)
      {
         __numNew = this.MIN_LENGTH;
      }
      var _loc2_;
      if(this.numLength)
      {
         _loc2_ = __numNew / this.numLength;
         this._numX *= _loc2_;
         this._numY *= _loc2_;
      }
   }
   function get numRotation()
   {
      var _loc2_ = 180 * this.getAngleWith(new CVector(0,-1)) / 3.141592653589793;
      if(this._numX < 0)
      {
         _loc2_ *= -1;
      }
      return _loc2_;
   }
   function set numRotation(__numValue)
   {
      var _loc2_ = this.numLength;
      this._numX = 0;
      this._numY = 1;
      this.rotate(-3.141592653589793 * __numValue / 180);
      this.numLength = _loc2_;
   }
   function makeCopy()
   {
      return new CVector(this._numX,this._numY);
   }
   function addVector(__vectAdd)
   {
      this._numX += __vectAdd.numX;
      this._numY += __vectAdd.numY;
   }
   function rotate(__numAngle)
   {
      var _loc3_;
      var _loc2_;
      if(__numAngle)
      {
         _loc3_ = Math.atan2(this._numX,this._numY) + __numAngle;
         _loc2_ = this.numLength;
         this._numX = _loc2_ * Math.sin(_loc3_);
         this._numY = _loc2_ * Math.cos(_loc3_);
      }
   }
   function oneWayTo(__vector, __precision)
   {
      return Math.abs(this._numX * __vector.numY - this._numY * __vector.numX) <= __precision;
   }
   function getAngleWith(__vector)
   {
      return Math.acos((this._numX * __vector.numX + this._numY * __vector.numY) / (this.numLength * __vector.numLength));
   }
   function getProjection(__vector)
   {
      return (this._numX * __vector.numX + this._numY * __vector.numY) / __vector.numLength;
   }
   function toString()
   {
      return new String("|" + this._numX + "," + this._numY + "|");
   }
}
