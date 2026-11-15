class CQuest
{
   var _numPointCap;
   var _numPoints;
   var _numType;
   var boolActive;
   var strCompleteMsg;
   static var TYPE_TOWERS1_1 = 1;
   static var TYPE_TOWERS1_2 = 2;
   static var TYPE_TOWERS1_3 = 3;
   static var TYPE_TOWERS1_4 = 4;
   static var TYPE_TOWERS1_5 = 5;
   static var TYPE_TOWERS2_1 = 6;
   static var TYPE_TOWERS2_2 = 7;
   static var TYPE_TOWERS2_3 = 8;
   static var TYPE_TOWERS2_4 = 9;
   static var TYPE_TOWERS2_5 = 10;
   static var TYPE_STRUCTURES_1 = 11;
   static var TYPE_STRUCTURES_2 = 12;
   static var TYPE_STRUCTURES_3 = 13;
   static var TYPE_STRUCTURES_4 = 14;
   static var TYPE_STRUCTURES_5 = 15;
   function CQuest(__numType)
   {
      this.numType = __numType;
      this._numPoints = 0;
      this.boolActive = false;
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
            case TYPE_TOWERS1_1:
               this._numPointCap = 0;
               this.strCompleteMsg = "MISSILE TURRET";
               break;
            case TYPE_TOWERS1_2:
               this._numPointCap = 1;
               this.strCompleteMsg = "HOWITZER";
               break;
            case TYPE_TOWERS1_3:
               this._numPointCap = 5;
               this.strCompleteMsg = "TESLA TOWER";
               break;
            case TYPE_TOWERS1_4:
               this._numPointCap = 40;
               this.strCompleteMsg = "GUTLING LASER";
               break;
            case TYPE_TOWERS1_5:
               this._numPointCap = 1;
               this.strCompleteMsg = "NULIFICATOR";
               break;
            case TYPE_TOWERS2_1:
               this._numPointCap = 0;
               this.strCompleteMsg = "AA GUN";
               break;
            case TYPE_TOWERS2_2:
               this._numPointCap = 5;
               this.strCompleteMsg = "GOO CANNON";
               break;
            case TYPE_TOWERS2_3:
               this._numPointCap = 1000;
               this.strCompleteMsg = "CHAIN GUN";
               break;
            case TYPE_TOWERS2_4:
               this._numPointCap = 1;
               this.strCompleteMsg = "GAUSS CANNON";
               break;
            case TYPE_TOWERS2_5:
               this._numPointCap = 10;
               this.strCompleteMsg = "OIL SPRAY";
               break;
            case TYPE_STRUCTURES_1:
               this._numPointCap = 5;
               this.strCompleteMsg = "NUCLEAR SILO";
               break;
            case TYPE_STRUCTURES_2:
               this._numPointCap = 15;
               this.strCompleteMsg = "WALL FACTORY";
               break;
            case TYPE_STRUCTURES_3:
               this._numPointCap = 3;
               this.strCompleteMsg = "RECYCLER";
               break;
            case TYPE_STRUCTURES_4:
               this._numPointCap = 7;
               this.strCompleteMsg = "RADAR DOME";
               break;
            case TYPE_STRUCTURES_5:
               this.strCompleteMsg = "LABORATORY";
               this._numPointCap = 2;
         }
      }
   }
   function get numPoints()
   {
      return this._numPoints;
   }
   function set numPoints(__numValue)
   {
      this._numPoints = __numValue;
      if(this._numPoints < 0)
      {
         this._numPoints = 0;
      }
   }
   function get numPointCap()
   {
      return this._numPointCap;
   }
   function get boolComplete()
   {
      return this._numPoints >= this._numPointCap;
   }
}
