/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Terminus:size=11",
	"stlarch:size=11"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */

#define normBg "#282a36"
#define normFg "#6272a4"
#define selFg "#f8f8f2"
#define selBg "#bd93f9"

static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { selFg, normBg },
	[SchemeSel] = { selFg, selBg },
	[SchemeOut] = { selFg, selBg },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 30;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
static int centered = 1;                    /* -c option; centers dmenu on screen */
static int min_width = 500;                    /* minimum width when centered */
static const unsigned int border_width = 3;
static int incremental = 0;                 /* -r  option; if 1, outputs text each time a key is pressed */
