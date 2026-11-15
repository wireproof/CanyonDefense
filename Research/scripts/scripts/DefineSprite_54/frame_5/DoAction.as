var loadedPercent = int(_root.getBytesLoaded() / _root.getBytesTotal() * 100);
if(loadedPercent < 100)
{
   mcLoadingAnimated.mcLoading.gotoAndStop(loadedPercent);
   mcLoadingAnimated.mcLoading.txtPercentLoaded1 = "The game is loading (" + loadedPercent + "%)";
   mcLoadingAnimated.mcLoading.txtPercentLoaded2 = "The game is loading (" + loadedPercent + "%)";
   gotoAndPlay(_currentframe - 1);
}
else
{
   mcLoadingAnimated.play();
   stop();
}
