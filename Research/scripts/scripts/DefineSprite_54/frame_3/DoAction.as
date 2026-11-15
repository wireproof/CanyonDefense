var loadedPercent = int(_root.getBytesLoaded() / _root.getBytesTotal() * 100);
if(loadedPercent == 100)
{
   _root.play();
   stop();
}
else
{
   loadAdNow = true;
   mcLoadingAnimated._visible = true;
}
