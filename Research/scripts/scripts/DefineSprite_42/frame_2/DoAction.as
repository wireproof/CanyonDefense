if(_url.indexOf("http") > -1)
{
   if(_parent._parent._parent.loadAdNow)
   {
      cacheBuster = getTimer() + random(999999);
      showAd = "http://www.miniclip.com/swfcontent/push/didyouknow.swf?cacheBuster" + cacheBuster;
      trace("Loading ad: " + showAd);
      mcAd.loadMovie(showAd);
   }
   else
   {
      gotoAndPlay(_currentframe - 1);
   }
}
