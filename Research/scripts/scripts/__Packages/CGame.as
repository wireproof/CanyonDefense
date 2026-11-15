class CGame extends CEventMovieClip
{
   var _arrAbilities;
   var _arrQuests1;
   var _arrQuests2;
   var _arrQuests3;
   var _boolInit;
   var _boolPaused;
   var _boolPausedBeforeQuit;
   var _cursorCurrent;
   var _layerCanvas;
   var _mapCurrent;
   var _mcGameOverDialog;
   var _mcGamePaused;
   var _mcMainScreen;
   var _mcMissionUI;
   var _mcOptionsScreen;
   var _mcQuitDialog;
   var _mcRulesScreen;
   var _mcSaveScoreScreen;
   var _mcViewScoreScreen;
   var _numEnemiesPeriod;
   var _numEnemiesTimer;
   var _numFunds;
   var _numMoneyEarned;
   var _numPopulation;
   var _numProgram;
   var _numProgramPtr;
   var _numState;
   var _parent;
   var attachMovie;
   var numMap;
   var numProgram;
   var numScore;
   var onEnterFrame;
   static var STATE_MAINSCREEN = 1;
   static var STATE_OPTIONSSCREEN = 2;
   static var STATE_RULESSCREEN = 3;
   static var STATE_VIEWSCORE = 4;
   static var STATE_SAVESCORE = 5;
   static var STATE_MISSION = 6;
   static var INITIAL_FUNDS = 350;
   static var INITIAL_POPULATION = 10;
   static var MONEY_SCORE_MULT = 1;
   static var POP_SCORE_MULT = 10000;
   static var WAVE_ALT_GROUND = 1;
   static var WAVE_ALT_AIR = 2;
   static var WAVE_SIZE_TINY = 1;
   static var WAVE_SIZE_SMALL = 2;
   static var WAVE_SIZE_MEDIUM = 3;
   static var WAVE_SIZE_BIG = 4;
   static var WAVE_EFFECT_FAST = 1;
   static var WAVE_EFFECT_SHIELD = 2;
   static var WAVE_EFFECT_REPAIR = 3;
   static var WAVE_TIME = new Array(2880,2160,1440);
   static var SCORE_BONUS = new Array(0,0.25,0.5);
   static var PROGRAMS = new Array(new Array({alt:WAVE_ALT_GROUND,qty:1,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:2,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:1,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_GROUND,qty:2,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_AIR,qty:1,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_AIR,qty:1,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_GROUND,qty:1,size:WAVE_SIZE_MEDIUM,level:1},{alt:WAVE_ALT_AIR,qty:2,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_GROUND,qty:2,size:WAVE_SIZE_MEDIUM,level:1},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_AIR,qty:2,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_AIR,qty:4,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:2,size:WAVE_SIZE_TINY,level:1,effect:WAVE_EFFECT_FAST},{alt:WAVE_ALT_GROUND,qty:12,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_GROUND,qty:1,size:WAVE_SIZE_MEDIUM,level:1,effect:WAVE_EFFECT_REPAIR},{alt:WAVE_ALT_AIR,qty:1,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_MEDIUM,level:1},{alt:WAVE_ALT_AIR,qty:2,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_SMALL,level:1,effect:WAVE_EFFECT_FAST},{alt:WAVE_ALT_GROUND,qty:12,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_AIR,qty:4,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_AIR,qty:2,size:WAVE_SIZE_MEDIUM,level:1},{alt:WAVE_ALT_GROUND,qty:2,size:WAVE_SIZE_BIG,level:1},{alt:WAVE_ALT_GROUND,qty:2,size:WAVE_SIZE_BIG,level:1,effect:WAVE_EFFECT_REPAIR}),new Array({alt:WAVE_ALT_GROUND,qty:1,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:3,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_AIR,qty:1,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:1,size:WAVE_SIZE_SMALL,level:1,effect:WAVE_EFFECT_REPAIR},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_AIR,qty:4,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_AIR,qty:4,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_TINY,level:1,effect:WAVE_EFFECT_FAST},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_MEDIUM,level:1},{alt:WAVE_ALT_AIR,qty:8,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:12,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:10,size:WAVE_SIZE_MEDIUM,level:1},{alt:WAVE_ALT_AIR,qty:4,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_SMALL,level:1,effect:WAVE_EFFECT_FAST},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_TINY,level:2},{alt:WAVE_ALT_GROUND,qty:1,size:WAVE_SIZE_BIG,level:1},{alt:WAVE_ALT_GROUND,qty:12,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_AIR,qty:2,size:WAVE_SIZE_MEDIUM,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_SMALL,level:1,effect:WAVE_EFFECT_REPAIR},{alt:WAVE_ALT_GROUND,qty:12,size:WAVE_SIZE_TINY,level:2},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_SMALL,level:1,effect:WAVE_EFFECT_FAST},{alt:WAVE_ALT_AIR,qty:12,size:WAVE_SIZE_TINY,level:2},{alt:WAVE_ALT_AIR,qty:8,size:WAVE_SIZE_TINY,level:1,effect:WAVE_EFFECT_FAST},{alt:WAVE_ALT_GROUND,qty:10,size:WAVE_SIZE_SMALL,level:2},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_MEDIUM,level:2},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_SMALL,level:3},{alt:WAVE_ALT_GROUND,qty:2,size:WAVE_SIZE_BIG,level:1,effect:WAVE_EFFECT_REPAIR},{alt:WAVE_ALT_AIR,qty:4,size:WAVE_SIZE_MEDIUM,level:2},{alt:WAVE_ALT_GROUND,qty:2,size:WAVE_SIZE_TINY,level:1,effect:WAVE_EFFECT_SHIELD},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_MEDIUM,level:3},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_SMALL,level:3},{alt:WAVE_ALT_GROUND,qty:12,size:WAVE_SIZE_MEDIUM,level:3},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_SMALL,level:2,effect:WAVE_EFFECT_SHIELD},{alt:WAVE_ALT_AIR,qty:1,size:WAVE_SIZE_MEDIUM,level:1,effect:WAVE_EFFECT_SHIELD},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_BIG,level:3,effect:WAVE_EFFECT_FAST}),new Array({alt:WAVE_ALT_GROUND,qty:1,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_AIR,qty:1,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:1,size:WAVE_SIZE_SMALL,level:1,effect:WAVE_EFFECT_REPAIR},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_AIR,qty:4,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_AIR,qty:4,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_TINY,level:1,effect:WAVE_EFFECT_FAST},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_MEDIUM,level:1},{alt:WAVE_ALT_AIR,qty:8,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:12,size:WAVE_SIZE_TINY,level:1},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_MEDIUM,level:1},{alt:WAVE_ALT_AIR,qty:4,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_SMALL,level:1,effect:WAVE_EFFECT_FAST},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_TINY,level:2},{alt:WAVE_ALT_GROUND,qty:1,size:WAVE_SIZE_BIG,level:1},{alt:WAVE_ALT_GROUND,qty:12,size:WAVE_SIZE_SMALL,level:1},{alt:WAVE_ALT_AIR,qty:2,size:WAVE_SIZE_MEDIUM,level:1},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_SMALL,level:1,effect:WAVE_EFFECT_REPAIR},{alt:WAVE_ALT_GROUND,qty:12,size:WAVE_SIZE_TINY,level:2},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_SMALL,level:1,effect:WAVE_EFFECT_FAST},{alt:WAVE_ALT_AIR,qty:12,size:WAVE_SIZE_TINY,level:2},{alt:WAVE_ALT_AIR,qty:8,size:WAVE_SIZE_TINY,level:1,effect:WAVE_EFFECT_FAST},{alt:WAVE_ALT_GROUND,qty:12,size:WAVE_SIZE_SMALL,level:2},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_MEDIUM,level:2},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_SMALL,level:3},{alt:WAVE_ALT_GROUND,qty:2,size:WAVE_SIZE_BIG,level:1,effect:WAVE_EFFECT_REPAIR},{alt:WAVE_ALT_AIR,qty:4,size:WAVE_SIZE_MEDIUM,level:2},{alt:WAVE_ALT_GROUND,qty:2,size:WAVE_SIZE_TINY,level:1,effect:WAVE_EFFECT_SHIELD},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_MEDIUM,level:3},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_SMALL,level:3},{alt:WAVE_ALT_GROUND,qty:12,size:WAVE_SIZE_MEDIUM,level:3},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_SMALL,level:2,effect:WAVE_EFFECT_SHIELD},{alt:WAVE_ALT_AIR,qty:1,size:WAVE_SIZE_MEDIUM,level:1,effect:WAVE_EFFECT_SHIELD},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_SMALL,level:4},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_MEDIUM,level:4},{alt:WAVE_ALT_GROUND,qty:1,size:WAVE_SIZE_BIG,level:2,effect:WAVE_EFFECT_REPAIR},{alt:WAVE_ALT_GROUND,qty:2,size:WAVE_SIZE_BIG,level:2,effect:WAVE_EFFECT_SHIELD},{alt:WAVE_ALT_AIR,qty:4,size:WAVE_SIZE_MEDIUM,level:2,effect:WAVE_EFFECT_FAST},{alt:WAVE_ALT_AIR,qty:8,size:WAVE_SIZE_SMALL,level:3},{alt:WAVE_ALT_GROUND,qty:12,size:WAVE_SIZE_MEDIUM,level:3},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_BIG,level:3,effect:WAVE_EFFECT_FAST},{alt:WAVE_ALT_GROUND,qty:8,size:WAVE_SIZE_TINY,level:5,effect:WAVE_EFFECT_FAST},{alt:WAVE_ALT_GROUND,qty:4,size:WAVE_SIZE_BIG,level:4,effect:WAVE_EFFECT_REPAIR},{alt:WAVE_ALT_AIR,qty:4,size:WAVE_SIZE_MEDIUM,level:4,effect:WAVE_EFFECT_REPAIR}));
   function CGame()
   {
      super();
      CSoundService.createSoundService(Const.SOUND_NAMES,this._parent,9999);
      this.numState = STATE_MAINSCREEN;
   }
   function get numState()
   {
      return this._numState;
   }
   function set numState(__numValue)
   {
      var _loc3_;
      var _loc2_;
      if(this._numState != __numValue)
      {
         this._numState = __numValue;
         this._mcMainScreen.removeMovieClip();
         this._mcOptionsScreen.removeMovieClip();
         this._mcRulesScreen.removeMovieClip();
         this._mcViewScoreScreen.removeMovieClip();
         this._mcSaveScoreScreen.removeMovieClip();
         this._mcMissionUI.removeMovieClip();
         this._mcGamePaused.removeMovieClip();
         this._mcQuitDialog.removeMovieClip();
         this._mcGameOverDialog.removeMovieClip();
         this._mapCurrent.removeMovieClip();
         this._cursorCurrent.removeMovieClip();
         this._layerCanvas.removeMovieClip();
         switch(this._numState)
         {
            case STATE_MAINSCREEN:
               this.attachMovie("id_mcMainScreen","_mcMainScreen",1);
               _loc3_ = CSoundService.getSoundAt(Const.SND_MAINLOOP);
               _loc3_.setVolume(100);
               CSoundService.playLoopSound(Const.SND_MAINLOOP);
               break;
            case STATE_OPTIONSSCREEN:
               this.attachMovie("id_mcOptionsScreen","_mcOptionsScreen",1);
               _loc3_ = CSoundService.getSoundAt(Const.SND_MAINLOOP);
               _loc3_.setVolume(100);
               CSoundService.playLoopSound(Const.SND_MAINLOOP);
               break;
            case STATE_RULESSCREEN:
               this.attachMovie("id_mcRulesScreen","_mcRulesScreen",1);
               _loc3_ = CSoundService.getSoundAt(Const.SND_MAINLOOP);
               _loc3_.setVolume(100);
               CSoundService.playLoopSound(Const.SND_MAINLOOP);
               break;
            case STATE_VIEWSCORE:
               this.attachMovie("id_mcViewScore","_mcViewScoreScreen",1);
               _loc3_ = CSoundService.getSoundAt(Const.SND_MAINLOOP);
               _loc3_.setVolume(100);
               CSoundService.playLoopSound(Const.SND_MAINLOOP);
               break;
            case STATE_SAVESCORE:
               this.attachMovie("id_mcSaveScore","_mcSaveScoreScreen",1);
               _loc3_ = CSoundService.getSoundAt(Const.SND_MAINLOOP);
               _loc3_.setVolume(100);
               CSoundService.playLoopSound(Const.SND_MAINLOOP);
               break;
            case STATE_MISSION:
               this.attachMovie("id_map","_mapCurrent",1);
               this.attachMovie("id_layer","_layerCanvas",3);
               this.attachMovie("id_cursor","_cursorCurrent",4);
               this.attachMovie("id_missionUI","_mcMissionUI",5,{_x:448});
               if(this.numMap == undefined)
               {
                  this.numMap = 1;
               }
               if(this.numProgram == undefined)
               {
                  this.numProgram = 0;
               }
               this.loadMission(this.numMap,this.numProgram);
               this._cursorCurrent.initCursor(this._mapCurrent);
               CBuilding.RANGE_BONUS = 0;
               this._arrAbilities = new Array();
               this._arrAbilities.push(new CAbility(CAbility.TYPE_SELL,this._mcMissionUI._mcBtnAbility1,1));
               this._arrAbilities.push(new CAbility(CAbility.TYPE_MISSILE,this._mcMissionUI._mcBtnAbility2,0));
               this._arrAbilities.push(new CAbility(CAbility.TYPE_WALL,this._mcMissionUI._mcBtnAbility3,0));
               this._arrAbilities.push(new CAbility(CAbility.TYPE_TIMEBOMB,this._mcMissionUI._mcBtnAbility4,0));
               this._arrAbilities.push(new CAbility(CAbility.TYPE_MONEYBONUS,undefined,0));
               this._arrAbilities.push(new CAbility(CAbility.TYPE_TOWERBONUS,undefined,0));
               this.numFunds = INITIAL_FUNDS;
               this._numMoneyEarned = 0;
               this.numPopulation = INITIAL_POPULATION;
               this.numScore = 0;
               this._arrQuests1 = new Array(new CQuest(CQuest.TYPE_TOWERS1_1),new CQuest(CQuest.TYPE_TOWERS1_2),new CQuest(CQuest.TYPE_TOWERS1_3),new CQuest(CQuest.TYPE_TOWERS1_4),new CQuest(CQuest.TYPE_TOWERS1_5));
               this._arrQuests2 = new Array(new CQuest(CQuest.TYPE_TOWERS2_1),new CQuest(CQuest.TYPE_TOWERS2_2),new CQuest(CQuest.TYPE_TOWERS2_3),new CQuest(CQuest.TYPE_TOWERS2_4),new CQuest(CQuest.TYPE_TOWERS2_5));
               this._arrQuests3 = new Array(new CQuest(CQuest.TYPE_STRUCTURES_1),new CQuest(CQuest.TYPE_STRUCTURES_2),new CQuest(CQuest.TYPE_STRUCTURES_3),new CQuest(CQuest.TYPE_STRUCTURES_4),new CQuest(CQuest.TYPE_STRUCTURES_5));
               _loc2_ = 1;
               while(_loc2_ <= 3)
               {
                  this["_arrQuests" + _loc2_].current = -1;
                  _loc2_ = _loc2_ + 1;
               }
               this._boolPaused = false;
               this._boolInit = true;
               this.onEnterFrame = this.oefProcessMission;
               _loc3_ = CSoundService.getSoundAt(Const.SND_MAINLOOP);
               _loc3_.setVolume(30);
               CSoundService.playLoopSound(Const.SND_MAINLOOP);
         }
      }
   }
   function get numFunds()
   {
      return this._numFunds;
   }
   function set numFunds(__numValue)
   {
      this._numFunds = __numValue;
      if(this._numFunds < 0)
      {
         this._numFunds = 0;
      }
      this._mcMissionUI.updatePriceColor(this._numFunds);
      this._arrQuests2[2].numPoints = this._numFunds;
      if(this._arrQuests2[2].boolActive)
      {
         this._mcMissionUI.updateQuest(2,3,this._arrQuests2[2]);
      }
      this._mcMissionUI.textFunds.text = String(this._numFunds);
   }
   function get numPopulation()
   {
      return this._numPopulation;
   }
   function set numPopulation(__numValue)
   {
      this._numPopulation = __numValue;
      if(this._numPopulation <= 0)
      {
         this._numPopulation = 0;
      }
      this._mcMissionUI.textPopulation.text = String(this._numPopulation);
   }
   function get boolPaused()
   {
      return this._boolPaused;
   }
   function set boolPaused(__boolValue)
   {
      if(this.numState == STATE_MISSION)
      {
         this._boolPaused = __boolValue;
         this._mapCurrent.boolPaused = __boolValue;
         if(this._boolPaused)
         {
            this.attachMovie("mc_gamepaused","_mcGamePaused",100,{_x:80,_y:140});
            this.onEnterFrame = null;
            this._layerCanvas.clear();
            this._cursorCurrent.clear();
         }
         else
         {
            this._mcGamePaused.removeMovieClip();
            this.onEnterFrame = this.oefProcessMission;
         }
         this._mcMissionUI.boolEnabled = !this._boolPaused;
         if(!this._mapCurrent.noEnemies)
         {
            this._mcMissionUI._btnStartAttack._visible = false;
         }
      }
   }
   function processMessage(__numMessage, __objParam, __mcInvoker)
   {
      var _loc5_;
      var _loc6_;
      var _loc9_;
      var _loc8_;
      var _loc12_;
      var _loc10_;
      var _loc15_;
      var _loc11_;
      switch(__numMessage)
      {
         case CEventMovieClip.MSG_TOGGLEPRESS:
            _loc5_ = CToggleButton(__mcInvoker);
            if(this._mcMissionUI.hitTest(_root._xmouse,_root._ymouse,true))
            {
               if(__objParam.isHit)
               {
                  _loc5_.boolPressed = !_loc5_.boolPressed;
               }
               else
               {
                  _loc5_.boolPressed = false;
               }
               this._cursorCurrent.clear();
            }
            if(__objParam.isHit && _loc5_.boolPressed)
            {
               switch(_loc5_)
               {
                  case this._mcMissionUI._mcTabPage1._mcBtnBuilding1:
                     this._cursorCurrent.attachBuilding(CBuilding.TYPE_TOWER_1_1);
                     break;
                  case this._mcMissionUI._mcTabPage1._mcBtnBuilding2:
                     this._cursorCurrent.attachBuilding(CBuilding.TYPE_TOWER_1_2);
                     break;
                  case this._mcMissionUI._mcTabPage1._mcBtnBuilding3:
                     this._cursorCurrent.attachBuilding(CBuilding.TYPE_TOWER_1_3);
                     break;
                  case this._mcMissionUI._mcTabPage1._mcBtnBuilding4:
                     this._cursorCurrent.attachBuilding(CBuilding.TYPE_TOWER_1_4);
                     break;
                  case this._mcMissionUI._mcTabPage1._mcBtnBuilding5:
                     this._cursorCurrent.attachBuilding(CBuilding.TYPE_TOWER_1_5);
                     break;
                  case this._mcMissionUI._mcTabPage2._mcBtnBuilding1:
                     this._cursorCurrent.attachBuilding(CBuilding.TYPE_TOWER_2_1);
                     break;
                  case this._mcMissionUI._mcTabPage2._mcBtnBuilding2:
                     this._cursorCurrent.attachBuilding(CBuilding.TYPE_TOWER_2_2);
                     break;
                  case this._mcMissionUI._mcTabPage2._mcBtnBuilding3:
                     this._cursorCurrent.attachBuilding(CBuilding.TYPE_TOWER_2_3);
                     break;
                  case this._mcMissionUI._mcTabPage2._mcBtnBuilding4:
                     this._cursorCurrent.attachBuilding(CBuilding.TYPE_TOWER_2_4);
                     break;
                  case this._mcMissionUI._mcTabPage2._mcBtnBuilding5:
                     this._cursorCurrent.attachBuilding(CBuilding.TYPE_TOWER_2_5);
                     break;
                  case this._mcMissionUI._mcTabPage3._mcBtnBuilding1:
                     this._cursorCurrent.attachBuilding(CBuilding.TYPE_BULIDING_1);
                     break;
                  case this._mcMissionUI._mcTabPage3._mcBtnBuilding2:
                     this._cursorCurrent.attachBuilding(CBuilding.TYPE_BULIDING_2);
                     break;
                  case this._mcMissionUI._mcTabPage3._mcBtnBuilding3:
                     this._cursorCurrent.attachBuilding(CBuilding.TYPE_BULIDING_3);
                     break;
                  case this._mcMissionUI._mcTabPage3._mcBtnBuilding4:
                     this._cursorCurrent.attachBuilding(CBuilding.TYPE_BULIDING_4);
                     break;
                  case this._mcMissionUI._mcTabPage3._mcBtnBuilding5:
                     this._cursorCurrent.attachBuilding(CBuilding.TYPE_BULIDING_5);
                     break;
                  case this._mcMissionUI._mcBtnAbility1:
                     this._cursorCurrent.attachAbility(CAbility.TYPE_SELL);
                     break;
                  case this._mcMissionUI._mcBtnAbility2:
                     this._cursorCurrent.attachAbility(CAbility.TYPE_MISSILE);
                     break;
                  case this._mcMissionUI._mcBtnAbility3:
                     this._cursorCurrent.attachAbility(CAbility.TYPE_WALL);
                     break;
                  case this._mcMissionUI._mcBtnAbility4:
                     this._cursorCurrent.attachAbility(CAbility.TYPE_TIMEBOMB);
               }
            }
            break;
         case CEventMovieClip.MSG_MOUSECLICK:
            if(this._cursorCurrent.numState != CCursor.STATE_CLEAR && !__objParam.free && !__objParam.out)
            {
               CSoundService.playSound(Const.SND_ERROR);
            }
            if(this._cursorCurrent.numState == CCursor.STATE_BUILDING && __objParam.free && !__objParam.out && this.numFunds < this._cursorCurrent.buildingCursor._numPrice)
            {
               this._mcMissionUI.showMessage("NOT ENOUGH\nMONEY!",true);
            }
            if(this._cursorCurrent.numState == CCursor.STATE_BUILDING && __objParam.free && !__objParam.out && this.numFunds >= this._cursorCurrent.buildingCursor._numPrice)
            {
               this._mapCurrent.addBuilding(this._cursorCurrent.buildingCursor);
               this.numFunds -= this._cursorCurrent.buildingCursor._numPrice;
               this._cursorCurrent.refresh();
               CSoundService.playSound(Const.SND_CONSTRUCTION);
               switch(this._cursorCurrent.buildingCursor.numType)
               {
                  case CBuilding.TYPE_TOWER_1_1:
                     this._arrQuests3[0].numPoints++;
                     if(this._arrQuests3[0].boolActive)
                     {
                        this._mcMissionUI.updateQuest(3,1,this._arrQuests3[0]);
                     }
                     break;
                  case CBuilding.TYPE_TOWER_1_3:
                     this._arrQuests3[2].numPoints++;
                     if(this._arrQuests3[2].boolActive)
                     {
                        this._mcMissionUI.updateQuest(3,3,this._arrQuests3[2]);
                     }
                     break;
                  case CBuilding.TYPE_TOWER_2_2:
                     this._arrQuests1[2].numPoints++;
                     if(this._arrQuests1[2].boolActive)
                     {
                        this._mcMissionUI.updateQuest(1,3,this._arrQuests1[2]);
                     }
                     break;
                  case CBuilding.TYPE_TOWER_2_1:
                     this._arrQuests3[3].numPoints++;
                     if(this._arrQuests3[3].boolActive)
                     {
                        this._mcMissionUI.updateQuest(3,4,this._arrQuests3[3]);
                     }
                     break;
                  case CBuilding.TYPE_TOWER_2_3:
                     this._arrQuests3[2].numPoints++;
                     if(this._arrQuests3[2].boolActive)
                     {
                        this._mcMissionUI.updateQuest(3,3,this._arrQuests3[2]);
                     }
                     break;
                  case CBuilding.TYPE_BULIDING_1:
                     this._arrAbilities[1].numSources++;
                     break;
                  case CBuilding.TYPE_BULIDING_2:
                     this._arrAbilities[2].numSources++;
                     this._arrQuests3[4].numPoints++;
                     if(this._arrQuests3[4].boolActive)
                     {
                        this._mcMissionUI.updateQuest(3,5,this._arrQuests3[4]);
                     }
                     break;
                  case CBuilding.TYPE_BULIDING_3:
                     this._arrAbilities[4].numSources++;
                     break;
                  case CBuilding.TYPE_BULIDING_4:
                     this._arrAbilities[5].numSources++;
                     CBuilding.RANGE_BONUS += 0.1;
                     CBlast.DAMAGE_BONUS += 0.1;
                     this._arrQuests2[3].numPoints++;
                     if(this._arrQuests2[3].boolActive)
                     {
                        this._mcMissionUI.updateQuest(2,4,this._arrQuests2[3]);
                     }
                     break;
                  case CBuilding.TYPE_BULIDING_5:
                     this._arrAbilities[3].numSources++;
                     this._arrQuests1[4].numPoints++;
                     if(this._arrQuests1[4].boolActive)
                     {
                        this._mcMissionUI.updateQuest(1,5,this._arrQuests1[4]);
                     }
               }
               this._arrQuests3[1].numPoints++;
               if(this._arrQuests3[1].boolActive)
               {
                  this._mcMissionUI.updateQuest(3,2,this._arrQuests3[1]);
               }
            }
            if(this._cursorCurrent.numState == CCursor.STATE_ABILITY && __objParam.free && !__objParam.out)
            {
               _loc9_ = true;
               switch(this._cursorCurrent.numAbility)
               {
                  case CAbility.TYPE_SELL:
                     _loc6_ = 0;
                     _loc8_ = this._mapCurrent.getBuildingAt(__objParam.i,__objParam.j);
                     this.numFunds += Math.round(0.5 * _loc8_._numPrice);
                     switch(_loc8_.numType)
                     {
                        case CBuilding.TYPE_TOWER_1_1:
                           this._arrQuests3[0].numPoints--;
                           if(this._arrQuests3[0].boolActive)
                           {
                              this._mcMissionUI.updateQuest(3,1,this._arrQuests3[0]);
                           }
                           break;
                        case CBuilding.TYPE_TOWER_1_3:
                           this._arrQuests3[2].numPoints--;
                           if(this._arrQuests3[2].boolActive)
                           {
                              this._mcMissionUI.updateQuest(3,3,this._arrQuests3[2]);
                           }
                           break;
                        case CBuilding.TYPE_TOWER_2_1:
                           this._arrQuests3[3].numPoints--;
                           if(this._arrQuests3[3].boolActive)
                           {
                              this._mcMissionUI.updateQuest(3,4,this._arrQuests3[3]);
                           }
                           break;
                        case CBuilding.TYPE_TOWER_2_2:
                           this._arrQuests1[2].numPoints--;
                           if(this._arrQuests1[2].boolActive)
                           {
                              this._mcMissionUI.updateQuest(1,3,this._arrQuests1[2]);
                           }
                           break;
                        case CBuilding.TYPE_TOWER_2_3:
                           this._arrQuests3[2].numPoints--;
                           if(this._arrQuests3[2].boolActive)
                           {
                              this._mcMissionUI.updateQuest(3,3,this._arrQuests3[2]);
                           }
                           break;
                        case CBuilding.TYPE_BULIDING_1:
                           this._arrAbilities[1].numSources--;
                           break;
                        case CBuilding.TYPE_BULIDING_2:
                           this._arrAbilities[2].numSources--;
                           this._arrQuests3[4].numPoints--;
                           if(this._arrQuests3[4].boolActive)
                           {
                              this._mcMissionUI.updateQuest(3,5,this._arrQuests3[4]);
                           }
                           break;
                        case CBuilding.TYPE_BULIDING_3:
                           this._arrAbilities[4].numSources--;
                           break;
                        case CBuilding.TYPE_BULIDING_4:
                           this._arrAbilities[5].numSources--;
                           CBuilding.RANGE_BONUS -= 0.1;
                           CBlast.DAMAGE_BONUS -= 0.1;
                           this._arrQuests2[3].numPoints--;
                           if(this._arrQuests2[3].boolActive)
                           {
                              this._mcMissionUI.updateQuest(2,4,this._arrQuests2[3]);
                           }
                           break;
                        case CBuilding.TYPE_BULIDING_5:
                           this._arrAbilities[3].numSources--;
                           this._arrQuests1[4].numPoints--;
                           if(this._arrQuests1[4].boolActive)
                           {
                              this._mcMissionUI.updateQuest(1,5,this._arrQuests1[4]);
                           }
                     }
                     CSoundService.playSound(Const.SND_SELL);
                     this._arrQuests3[1].numPoints--;
                     if(this._arrQuests3[1].boolActive)
                     {
                        this._mcMissionUI.updateQuest(3,2,this._arrQuests3[1]);
                     }
                     this._mapCurrent.deleteBuilding(_loc8_);
                     this._layerCanvas.clear();
                     break;
                  case CAbility.TYPE_MISSILE:
                     _loc6_ = 1;
                     _loc12_ = {x:224,y:500,direction:new CVector(0,-1),altitude:CMap.ALTITUDE_BOTH,type:CBlast.TYPE_MISSILE,targetsEnemy:false,targetX:_root._xmouse,targetY:_root._ymouse,speed:6};
                     this._mapCurrent.addBlast(_loc12_);
                     CSoundService.playSound(Const.SND_NUCLEARLAUNCH);
                     if(this._arrQuests1[1].boolActive)
                     {
                        this._arrQuests1[1].numPoints++;
                        this._mcMissionUI.updateQuest(1,2,this._arrQuests1[1]);
                     }
                     break;
                  case CAbility.TYPE_WALL:
                     _loc6_ = 2;
                     if(__objParam.free && !__objParam.out)
                     {
                        if(this._mapCurrent.isHitWithGroundEnemy(__mcInvoker.mcCursor))
                        {
                           this._mcMissionUI.showMessage("YOU CAN\'T INSTALL WALL\nOVER THE ENEMY!",true);
                           _loc9_ = false;
                           break;
                        }
                        if(!this._mapCurrent.markCacheMatrix(__objParam.i,__objParam.j))
                        {
                           this._mcMissionUI.showMessage("YOU CAN\'T\nBLOCK PATH!",true);
                           _loc9_ = false;
                           break;
                        }
                        this._mapCurrent.addWall(__objParam.i,__objParam.j);
                        this._mapCurrent.toggleGrid(false);
                        CSoundService.playSound(Const.SND_CONSTRUCTION);
                        this._arrQuests2[4].numPoints++;
                        if(this._arrQuests2[4].boolActive)
                        {
                           this._mcMissionUI.updateQuest(2,5,this._arrQuests2[4]);
                        }
                     }
                     break;
                  case CAbility.TYPE_TIMEBOMB:
                     _loc6_ = 3;
                     this._mapCurrent.applySplashEffect(new CEffect(CEffect.TYPE_TIMESTOP,undefined,120),_root._xmouse,_root._ymouse,100,CMap.ALTITUDE_BOTH);
                     CSoundService.playSound(Const.SND_TIMESTOP);
               }
               if(_loc9_)
               {
                  if(this._arrAbilities[_loc6_].reset())
                  {
                     this._cursorCurrent.clear();
                  }
               }
            }
            break;
         case CEventMovieClip.MSG_MOUSEOVER:
            if(__mcInvoker instanceof CBuilding && __mcInvoker._boolTower && (this._cursorCurrent.numState == CCursor.STATE_CLEAR || __objParam.forceShow) && !this.boolPaused)
            {
               _loc10_ = {x:__mcInvoker._mcObject.mcGun._x,y:__mcInvoker._mcObject.mcGun._y};
               __mcInvoker._mcObject.localToGlobal(_loc10_);
               this._layerCanvas.globalToLocal(_loc10_);
               _loc15_ = this._layerCanvas.addElement("id_tower_range",{_x:_loc10_.x,_y:_loc10_.y,_width:2 * Math.floor(__mcInvoker.numRange),_height:2 * Math.floor(__mcInvoker.numRange)});
            }
            break;
         case CEventMovieClip.MSG_MOUSEOUT:
            if(__mcInvoker instanceof CBuilding && __mcInvoker._boolTower && (this._cursorCurrent.numState == CCursor.STATE_CLEAR || __objParam.forceHide))
            {
               this._layerCanvas.clear();
            }
            break;
         case CEventMovieClip.MSG_TARGETLOST:
            if(__mcInvoker instanceof CBuilding)
            {
               _loc10_ = {x:__mcInvoker._mcObject.mcGun._x,y:__mcInvoker._mcObject.mcGun._y};
               __mcInvoker._mcObject.localToGlobal(_loc10_);
               __mcInvoker._enemyTarget = this._mapCurrent.getNearestEnemy(_loc10_.x,_loc10_.y,Math.floor(__mcInvoker._numRange * (1 + CBuilding.RANGE_BONUS)),__mcInvoker._numAimingAltitude);
            }
            if(__mcInvoker instanceof CBlast)
            {
               _loc10_ = {x:__mcInvoker._mcObject._x,y:__mcInvoker._mcObject._y};
               __mcInvoker.localToGlobal(_loc10_);
               __mcInvoker._mcTarget = this._mapCurrent.getNearestEnemy(_loc10_.x,_loc10_.y,__objParam.range,__objParam.alt,__objParam.forbidden);
            }
            break;
         case CEventMovieClip.MSG_READYTOSHOOT:
            this._mapCurrent.addBlast(__objParam);
            break;
         case CEventMovieClip.MSG_SPLASHEFFECT:
            this._mapCurrent.applySplashEffect(__objParam.effect,__objParam.centerX,__objParam.centerY,__objParam.radius,__objParam.altitude);
            break;
         case CEventMovieClip.MSG_CREATEGFX:
            this._mapCurrent.addGFX(__objParam);
            break;
         case CEventMovieClip.MSG_ENEMYDEAD:
            _loc11_ = Math.round(__mcInvoker._numReward * (1 + 0.5 * this._arrAbilities[4].numSources));
            this.numFunds += _loc11_;
            this._numMoneyEarned += _loc11_;
            this._mapCurrent.addGFX(__objParam);
            if(__mcInvoker.numAltitude == CMap.ALTITUDE_AIR)
            {
               this._arrQuests2[1].numPoints++;
               if(this._arrQuests2[1].boolActive)
               {
                  this._mcMissionUI.updateQuest(2,2,this._arrQuests2[1]);
               }
            }
            if(__mcInvoker.numAltitude == CMap.ALTITUDE_AIR)
            {
               this._arrQuests1[3].numPoints++;
               if(this._arrQuests1[3].boolActive)
               {
                  this._mcMissionUI.updateQuest(1,4,this._arrQuests1[3]);
               }
            }
            __mcInvoker.remove();
            if(this._mapCurrent.noEnemies)
            {
               if(this._numProgramPtr >= PROGRAMS[this._numProgram].length)
               {
                  this.showGameOverDialog(true);
               }
               else
               {
                  this._mcMissionUI._btnStartAttack._visible = true;
               }
            }
            break;
         case CEventMovieClip.MSG_ENEMYPASSED:
            --this.numPopulation;
            __mcInvoker.remove();
            CSoundService.playSound(Const.SND_POPDEAD,true);
            if(this.numPopulation == 0)
            {
               this.showGameOverDialog(false);
            }
            else if(this._mapCurrent.noEnemies)
            {
               if(this._numProgramPtr >= PROGRAMS[this._numProgram].length)
               {
                  this.showGameOverDialog(true);
               }
               else
               {
                  this._mcMissionUI._btnStartAttack._visible = true;
               }
            }
            break;
         case CEventMovieClip.MSG_HURRYATTACK:
            this._numEnemiesTimer = this._numEnemiesPeriod;
            for(var _loc7_ in this._arrAbilities)
            {
               this._arrAbilities[_loc7_].numTimer -= this._numEnemiesTimer;
            }
            break;
         case CEventMovieClip.MSG_QUITGAME:
            this._boolPausedBeforeQuit = this.boolPaused;
            this.boolPaused = true;
            this._mcMissionUI.switchServiceButtonsVisibility(false);
            this.attachMovie("mc_quitdialog","_mcQuitDialog",100,{_x:80,_y:140});
            break;
         case CEventMovieClip.MSG_PAUSEGAME:
            this.boolPaused = __objParam.pause;
         default:
            return;
      }
   }
   function loadMission(__numMapID, __numProgramID)
   {
      this._numProgram = __numProgramID;
      this._numProgramPtr = 0;
      this._numEnemiesPeriod = WAVE_TIME[this.numProgram];
      this._numEnemiesTimer = 0;
      this._mapCurrent.loadMap(__numMapID);
      this.updateWaveScreen(PROGRAMS[this._numProgram][this._numProgramPtr]);
   }
   function createAttackWave(__objWave)
   {
      var _loc4_;
      if(__objWave.alt == WAVE_ALT_GROUND)
      {
         switch(__objWave.size)
         {
            case WAVE_SIZE_TINY:
               _loc4_ = CEnemy.TYPE_BAGGI;
               break;
            case WAVE_SIZE_SMALL:
               _loc4_ = CEnemy.TYPE_TRICYCLE;
               break;
            case WAVE_SIZE_MEDIUM:
               _loc4_ = CEnemy.TYPE_CAR;
               break;
            case WAVE_SIZE_BIG:
               _loc4_ = CEnemy.TYPE_HOWERTANK;
         }
      }
      else
      {
         switch(__objWave.size)
         {
            case WAVE_SIZE_TINY:
               _loc4_ = CEnemy.TYPE_PLANE;
               break;
            case WAVE_SIZE_SMALL:
               _loc4_ = CEnemy.TYPE_INSECT;
               break;
            case WAVE_SIZE_MEDIUM:
               _loc4_ = CEnemy.TYPE_SCORPIO;
         }
      }
      var _loc5_;
      switch(__objWave.effect)
      {
         case WAVE_EFFECT_FAST:
            _loc5_ = new CEffect(CEffect.TYPE_FAST,{percent:0.5},-1);
            break;
         case WAVE_EFFECT_REPAIR:
            _loc5_ = new CEffect(CEffect.TYPE_REPAIR,{percent:0.005},-1);
            break;
         case WAVE_EFFECT_SHIELD:
            _loc5_ = new CEffect(CEffect.TYPE_SHIELD,{pass:0.1},-1);
      }
      var _loc2_ = 0;
      while(_loc2_ < __objWave.qty)
      {
         this._mapCurrent.addEnemy(_loc4_,__objWave.level,_loc5_.makeCopy(),_loc2_);
         _loc2_ = _loc2_ + 1;
      }
   }
   function updateWaveScreen(__objWave)
   {
      var _loc2_;
      if(__objWave != undefined)
      {
         _loc2_ = "Next attack: #" + (this._numProgramPtr + 1).toString() + "\n";
         _loc2_ += String(__objWave.qty) + " ";
         switch(__objWave.size)
         {
            case WAVE_SIZE_TINY:
               _loc2_ += "TINY ";
               break;
            case WAVE_SIZE_SMALL:
               _loc2_ += "SMALL ";
               break;
            case WAVE_SIZE_MEDIUM:
               _loc2_ += "MEDIUM ";
               break;
            case WAVE_SIZE_BIG:
               _loc2_ += "BIG ";
         }
         _loc2_ += "unit";
         if(__objWave.qty > 1)
         {
            _loc2_ += "s";
         }
         _loc2_ += " Lv[" + __objWave.level.toString() + "]";
         switch(__objWave.alt)
         {
            case WAVE_ALT_GROUND:
               _loc2_ += "\nGROUND";
               break;
            case WAVE_ALT_AIR:
               _loc2_ += "\nAIR";
         }
         switch(__objWave.effect)
         {
            case WAVE_EFFECT_FAST:
               _loc2_ += " / FAST";
               break;
            case WAVE_EFFECT_REPAIR:
               _loc2_ += " / AUTOREPAIR";
               break;
            case WAVE_EFFECT_SHIELD:
               _loc2_ += " / SHIELDED";
         }
         this._mcMissionUI.textScreen.text = _loc2_;
      }
      if(this._numProgramPtr >= PROGRAMS[this._numProgram].length)
      {
         this._mcMissionUI.textScreen._visible = false;
         this._mcMissionUI.textTimer._visible = false;
      }
      var _loc3_ = Math.floor((this._numEnemiesPeriod - this._numEnemiesTimer) / 24);
      if(_loc3_ < 0)
      {
         _loc3_ = 0;
      }
      var _loc5_ = Math.floor(_loc3_ / 60);
      _loc3_ -= _loc5_ * 60;
      this._mcMissionUI.textTimer.text = (_loc5_ >= 10 ? "" : "0") + _loc5_.toString() + ":" + (_loc3_ >= 10 ? "" : "0") + _loc3_.toString();
   }
   function onQuitDialogClose(__boolQuit)
   {
      if(__boolQuit)
      {
         this.numState = STATE_MAINSCREEN;
      }
      else
      {
         this._mcQuitDialog.removeMovieClip();
         this.boolPaused = this._boolPausedBeforeQuit;
         this._mcMissionUI.switchServiceButtonsVisibility(true);
      }
      CSoundService.playSound(Const.SND_SWITCH);
   }
   function showGameOverDialog(__boolWin)
   {
      this.boolPaused = true;
      this.attachMovie("mc_gameoverdialog","_mcGameOverDialog",100,{_x:40,_y:85});
      if(!__boolWin)
      {
         this._mcGameOverDialog.mcMessage.gotoAndStop(2);
      }
      this._mcMissionUI.switchServiceButtonsVisibility(false);
      this._mcGameOverDialog.textMoneyQty.text = this._numMoneyEarned.toString();
      this._mcGameOverDialog.textMoneyMult.text = "x" + MONEY_SCORE_MULT.toString();
      var _loc2_ = this._numMoneyEarned * MONEY_SCORE_MULT;
      this._mcGameOverDialog.textMoneyScore.text = _loc2_.toString();
      this._mcGameOverDialog.textPopQty.text = this.numPopulation.toString();
      this._mcGameOverDialog.textPopMult.text = "x" + POP_SCORE_MULT.toString();
      var _loc3_ = this.numPopulation * POP_SCORE_MULT;
      this._mcGameOverDialog.textPopScore.text = _loc3_.toString();
      this._mcGameOverDialog.textBonus.text = "+" + SCORE_BONUS[this.numProgram] * 100 + " %";
      this.numScore = Math.round((_loc2_ + _loc3_) * (1 + SCORE_BONUS[this.numProgram]));
      this._mcGameOverDialog.textTotalScore.text = this.numScore.toString();
   }
   function onGameOverDialogClose()
   {
      this.numState = STATE_SAVESCORE;
      CSoundService.playSound(Const.SND_SWITCH);
   }
   function oefProcessMission()
   {
      if(this._boolInit)
      {
         this._arrAbilities[1].boolAvaliable = false;
         this._arrAbilities[2].boolAvaliable = false;
         this._arrAbilities[3].boolAvaliable = false;
         this._boolInit = false;
      }
      if(this._numEnemiesTimer > this._numEnemiesPeriod)
      {
         this._numEnemiesTimer = 0;
         this.createAttackWave(PROGRAMS[this._numProgram][this._numProgramPtr]);
         this._numProgramPtr = this._numProgramPtr + 1;
         this.updateWaveScreen(PROGRAMS[this._numProgram][this._numProgramPtr]);
         this._mcMissionUI._btnStartAttack._visible = false;
      }
      else
      {
         this._numEnemiesTimer = this._numEnemiesTimer + 1;
         this.updateWaveScreen();
      }
      for(var _loc3_ in this._arrAbilities)
      {
         this._arrAbilities[_loc3_].tick();
      }
      var _loc3_;
      var _loc2_;
      if(!Const.DISABLE_QUESTS)
      {
         _loc3_ = 1;
         while(_loc3_ <= 3)
         {
            _loc2_ = this["_arrQuests" + _loc3_];
            if(_loc2_.current == -1)
            {
               _loc2_.current = 0;
               this._mcMissionUI.changeBBState(_loc3_,_loc2_.current + 1,CMissionUIPanel.BB_STATE_QUEST);
               _loc2_[_loc2_.current].boolActive = true;
               this._mcMissionUI.updateQuest(_loc3_,_loc2_.current + 1,_loc2_[_loc2_.current]);
            }
            if(_loc2_[_loc2_.current].boolComplete)
            {
               this._mcMissionUI.changeBBState(_loc3_,_loc2_.current + 1,CMissionUIPanel.BB_STATE_SHOW);
               this._mcMissionUI.changeBBState(_loc3_,_loc2_.current + 2,CMissionUIPanel.BB_STATE_QUEST);
               _loc2_[_loc2_.current].boolActive = false;
               _loc2_[_loc2_.current + 1].boolActive = true;
               this._mcMissionUI.updateQuest(_loc3_,_loc2_.current + 2,_loc2_[_loc2_.current + 1]);
               this._mcMissionUI.updatePriceColor(this.numFunds);
               if(_loc2_[_loc2_.current].numPointCap > 0)
               {
                  this._mcMissionUI.showMessage("Quest complete!\n" + _loc2_[_loc2_.current].strCompleteMsg);
               }
               _loc2_.current = _loc2_.current + 1;
            }
            _loc3_ = _loc3_ + 1;
         }
      }
      this._mapCurrent.process();
   }
}
