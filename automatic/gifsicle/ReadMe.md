[![](https://img.shields.io/chocolatey/v/gifsicle?color=green&label=gifsicle)](https://chocolatey.org/packages/gifsicle) [![](https://img.shields.io/chocolatey/dt/gifsicle)](https://chocolatey.org/packages/gifsicle)

## Gifsicle
Gifsicle is a command-line tool for creating, editing, and getting information about GIF images and animations. Making a GIF animation with gifsicle is easy:

```
gifsicle --delay=10 --loop *.gif > anim.gif
```
Extracting frames from animations is easy too:
```
gifsicle anim.gif '#0' > firstframe.gif
```
You can also edit animations by replacing, deleting, or inserting frames:
```
gifsicle -b anim.gif --replace '#0' new.gif
```
Some more gifsicle features:

Batch mode for changing GIFs in place.
Prints detailed information about GIFs, including comments.
Control over interlacing, comments, looping, transparency...
Creates well-behaved GIFs: removes redundant colors, only uses local color tables if it absolutely has to (local color tables waste space and can cause viewing artifacts), etc.
It can shrink colormaps and change images to use the Web-safe palette (or any colormap you choose).
Optimize your animations! This stores only the changed portion of each frame, and can radically shrink your GIFs. You can also use transparency to make them even smaller. Gifsicle’s optimizer is pretty powerful, and usually reduces animations to within a couple bytes of the best commercial optimizers.
Unoptimizing animations, which makes them easier to edit.
A dumb name.

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/tunisiano)