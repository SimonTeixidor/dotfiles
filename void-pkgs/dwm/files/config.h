#include "mpdcontrol.c"

/* See LICENSE file for copyright and license details. */

static const unsigned int systrayspacing = 2; /* systray spacing */
static const Bool showsystray = True; 

#define NUMCOLORS 4

#define bgCol "#282a36"
#define normFg "#bbbbbb"
#define selFg "#f8f8f2"
#define font "Terminus:pixelsize=11"
#define icon_font "stlarch:pixelsize=11"

static const char *fonts[]            = { icon_font, font };

static const char *colors[][3]      = {
	/*		   fg         bg          border   */
	[SchemeNorm] =	 { normFg, bgCol,  "#555555" },
	[SchemeSel]  =	 { selFg, bgCol,   "#DCDCDC" },
	[SchemeWarn] =	 { "#FF0000", bgCol, "#AF8700" },
	[SchemeUrgent] =	 { "#FF0000", bgCol, "#AF8700" },
};

static Bool resizehints = False;
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int gappx = 10; // Gap pixel between windows
static const unsigned int snap      = 32;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */


/* tagging */
static const char *tags[] = { "web", "editor", "music", "other" };

static const Rule rules[0];

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */

void
topstacksquare(Monitor *m)
{
	unsigned int i, n, h, mw, my, ty;
	Client *c;

	for (n = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), n++);
	if (n == 0)
		return;

	if (n > m->nmaster)
		mw = m->nmaster ? m->ww * m->mfact : 0;
	else
		mw = m->ww;
	for (i = my = ty = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), i++)
		if (i < m->nmaster) {
			h = (m->wh - my) / (MIN(n, m->nmaster) - i);
			resize(c, m->wx, m->wy + my, mw - (2*c->bw), h - (2*c->bw), 0);
			my += HEIGHT(c);
		} else if (i == m->nmaster) {
			h = MIN(m->mh - gappx - c->bw, m->ww - mw);
			resize(c, m->wx + mw, m->wy + ty, m->ww - mw - (2*c->bw), h - (2*c->bw), 0);
			ty += HEIGHT(c);
		} else {
			h = ty > m->wh ? 2*c->bw : (m->wh - ty) / (n - i);
			h = MAX(2*gappx + 2*c->bw + 1, h);
			resize(c, m->wx + mw, m->wy + ty, m->ww - mw - (2*c->bw), h - (2*c->bw), 0);
			ty += HEIGHT(c);
		}
}

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "[]S",      topstacksquare },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY|ControlMask,           KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY,                       KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} },

static char dmenumon[2] = "0";
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", bgCol, "-nf", normFg, "-sb",  bgCol, "-sf", selFg, NULL };
static const char *termcmd[] = { "st", NULL };
static const char *browsercmd[] = { "firefox", NULL };


static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_m,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_b,      spawn,          {.v = browsercmd } },
	{ MODKEY,                       XK_F1,     mpdchange,      {.i = -1} },
	{ MODKEY,                       XK_F2,     mpdchange,      {.i = +1} },
	{ MODKEY,                       XK_Escape, mpdcontrol,     {0} },
	{ MODKEY,                       XK_Tab,    focusstack,   {.i = +1 } },
	{ MODKEY,                       XK_j,      focusstack,   {.i = +1 } },
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
