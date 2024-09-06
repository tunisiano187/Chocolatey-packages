[![](https://img.shields.io/chocolatey/v/capture2text?color=green&label=capture2text)](https://chocolatey.org/packages/capture2text) [![](https://img.shields.io/chocolatey/dt/capture2text)](https://chocolatey.org/packages/capture2text)

## Capture2Text
Capture2Text enables users to quickly OCR a small portion of the screen and, by default, save the result to the clipboard. Capture2Text can OCR 50+ languages. By default only the following languages are installed:

* English
* French
* German
* Italian
* Japanese 
* Spanish

To acquire other languages:

1. Download the appropriate OCR language dictionaries from: https://sourceforge.net/projects/capture2text/files/Dictionaries/
2. Extract the ".zip" file you just downloaded with 7-Zip or similar decompression software.
3. Drag all files contained within the zip file to this path in the Capture2Text directory: `$Env:ChocolateyInstall\lib\capture2text\Capture2Text\Utils\tesseract\tessdata`
4. Restart Capture2Text

Note: Arabic and Hindi are more CPU intensive and will thus be slower to OCR.

To install the Chinese (NHocr) language pack:

1. Download nhocr from: https://sourceforge.jp/projects/nhocr/
2. Open it with 7-Zip and copy `PLM-zh_CN.dic` and `cctable-zh_CN` to `$Env:ChocolateyInstall\lib\capture2text\Capture2Text\Utils\nhocr\Dic`
3. Restart Capture2Text

[FAQ](https://capture2text.sourceforge.net/#troubleshooting)

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/bePatron?u=39585820)
