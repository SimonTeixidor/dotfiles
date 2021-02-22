#define normBg "#282a36"
#define selFg "#f8f8f2"

static struct Config config = {
	/* fonts, separate different fonts with comma */
	.titlefont = "Terminus:size=11:style=bold",
	.bodyfont = "Terminus:size=11",

	/* colors */
	.background_color = normBg,
	.foreground_color = selFg,
	.border_color = selFg,

	/* geometry and gravity (see the manual) */
	.geometryspec = "500x900",
	.gravityspec = "C",

	/* size of border, gaps and image (in pixels) */
	.border_pixels = 2,
	.gap_pixels = 7,
	.image_pixels = 500,      /* if 0, the image will fit the notification */
	.leading_pixels = 5,    /* space between title and body texts */
	.padding_pixels = 10,   /* space around content */
	.max_height = 1000,      /* maximum height of a notification, after text wrapping */

	/* text alignment, set to LeftAlignment, CenterAlignment or RightAlignment */
	.alignment = LeftAlignment,

	/* set to nonzero to shrink notification width to its content size */
	.shrink = 1,

	/* whether to wrap text */
	.wrap = 1,

	/* time, in seconds, for a notification to stay alive */
	.sec = 10,

	/* mouse button that makes xnotify prints a notification's CMD: */
	.actionbutton = Button3,

	/* display image on top of text, instead of left of text */
	.vertical = 1
};

/* string to be replaced by truncated text, should be a single unicode character */
#define ELLIPSIS "…"
