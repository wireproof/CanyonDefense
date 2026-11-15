if(mcAd.getBytesTotal() != 0 && mcAd.getBytesLoaded() == mcAd.getBytesTotal())
{
   gotoAndStop("showAd");
}
else
{
   gotoAndPlay(_currentframe - 1);
}
