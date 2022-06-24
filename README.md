# HaxeFlixelTest
`FlxBitmapText` Vs `FlxText` performance test

Uses [Hiero](https://libgdx.com/wiki/tools/hiero) for bitmap font generation.

Todo! Hiero seems to generate .fnt files without XML tags. Might be the reason for the code below giving runtime error. 
```
var textBytes = Assets.getText("assets/font/ps2p.fnt");
var XMLData = Xml.parse(textBytes);
// this does not seem to work, runtime error:
// Segmentation fault (core dumped)
var fontAngleCode = FlxBitmapFont.fromAngelCode("assets/font/ps2p.png", XMLData);  
```
