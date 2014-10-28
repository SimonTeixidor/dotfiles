/* See LICENSE file for copyright and license details. */

/* appearance */
static const char font[]            = "montecarlo:pixelsize=10";
static const unsigned int systrayspacing = 2; /* systray spacing */
static const Bool showsystray = True; 

#define NUMCOLORS 8

static const char colors[NUMCOLORS][ColLast][8] = {
   // border   foreground  background
   { "#999999", "#FFFFFF", "#1b1d1e" },  // 0 = normal
   { "#9e6ffe", "#fd971f", "#1b1d1e" },  // 1 = selected
   { "#1b1d1e", "#f92671", "#1b1d1e" },  // 2 = urgent/warning
   { "#1b1d1e", "#a6e22e", "#1b1d1e" },  // 3 = red
   { "#1b1d1e", "#66d9ef", "#1b1d1e" },  // 4 = blue
   { "#1b1d1e", "#ffffff", "#1b1d1e" },  // 5 = white
   { "#1b1d1e", "#b6e354", "#1b1d1e" },  // 6 = green
   { "#1b1d1e", "#feed6c", "#1b1d1e" },  // 7 = yellow
   // add more here
};

static Bool resizehints = False;
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx = 0; // Gap pixel between windows
static const unsigned int snap      = 32;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=", True, tile },    /* first entry is default */
};

/* tagging */
static const Tag tags[] = {
    /* name layout mfact nmaster*/
    { "A", &layouts[0], -1, -1 },
    { "B", &layouts[0], -1, -1 },
    { "C", &layouts[0], -1, -1 },
    { "D", &layouts[0], -1, -1 },
    { "E", &layouts[0], -1, -1 },
};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Firefox",  NULL,       NULL,       1 << 8,       False,       -1 },

};

/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      toggleview,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      view,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },



static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_Tab,      focusstack,   {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_l,  setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_h,   setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_o,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_x,      killclient,     {0} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
