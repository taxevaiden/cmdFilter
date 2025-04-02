# cmdFilter

a command-line tool for applying filters to images

i mostly just made this little tool for fun. [after working on my own dithering example,](https://taxevaiden.pages.dev/posts/dither-filter/), i wondered if i could convert this to a command-line tool. it made sense to me because you know, you wouldn't just take low-quality screenshots of a window containing the filtered image, right?

(i mean i probably would if there was no other option)

anyways, i just made this fun little tool for my convenience. you might find it useful too

> [!WARNING]
> this is not very uh polished
> i made this in like a few days

## commands

the commands for the tool there's not a lot of filters, but i will add some soon!

### chromatic abberation

the command for this is

`image.png chromatic-abberation (shiftX) (shiftY)`

the `shift` parameters offset the R and B values in the image.

### perspective chromatic abberation

the command for this is

`image.png pers-chromatic-abberation (shift 1-inf)`

the shift value is divided by 100. without it even setting it to `0.01` has a very dramatic effect.

### dither

the command for this is

`image.png dither`

simple command, uses less colors, saves space!

### tax-dither (STYLIZED)

the command for this is

`image.png tax-dither`

my own version of uh dithering. if you could call it that. i don't recommend this for saving space, since it uses **A LOT** more space than actual dithering. this is the dithering i came up with in [a dithering post i made.](https://taxevaiden.pages.dev/posts/dither-filter/)

### invert

the command for this is

`image.png invert`

kinda plain idk

## contributing

### building

building this is very simple. right now i only support building for windows on windows. (it may work on other operating systems, such as macOS or Linux. in the makefile, you can fix and work it around to add functionality for those.)

what you'll need is:
- zip (i think it's needed for windows, didn't work for me when i used makefiles): `choco install zip`
- a [Love2D](https://love2d.org/) installation (on windows)
- an installation of Make (and has like everything set up. i got my installation from [w64devkit](https://github.com/skeeto/w64devkit). add the `bin/` directory with all the `.exe` files like `g++.exe` in the `Path` user variable)
- a good enough text editor (VS Code, etc)

all you need to do is..

`make` 

it'll clean everything up, prepare, and package the whole thing!

### testing

this is also very simple. all you have to do is run

`love . some/image/located/somewhere.png dither`

note that the command above is an example