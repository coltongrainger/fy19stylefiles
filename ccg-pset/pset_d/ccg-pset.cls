\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ccg-pset}[2019-04-14 Colton's version of Arun Debray's problem set template]
% this template was forked from Arun Debray <ccg, 2019-04-14>
% the mistakes are my own

% Provides a switch gto check whether you're using this class (e.g. \ifdefined\UsingPsetD)
\def\UsingCCGPset{}

% Some package options
% 1. Option `thminenum' (default) numbers theorems inside problem numbers, e.g. Theorem 27.1; `thmalone' numbers
% them independently, e.g. Theorem 1.
\DeclareOption{thminenum}{}
\DeclareOption{thmalone}{\def\thm@enum{}}
% 2. Option `eqninenum' numbers equations inside problem numbers, e.g. (27.1); `eqnalone' (default) tags them with
% dingbats, e.g. (*), (§), etc.
\DeclareOption{eqninenum}{\def\eqn@enum{}}
\DeclareOption{eqnalone}{}
% 3. Option 'onesided' places a header on each page; `twosided' (default) on each odd-numbered page.
\DeclareOption{onesided}{\def\@nesided{}}
\DeclareOption{twosided}{}

% Other options can be handed off to the amsart class (e.g. fontsize)
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}

\ExecuteOptions{thmienum}
\ExecuteOptions{eqnalone}
\ExecuteOptions{twosided}
\ProcessOptions\relax

\LoadClass[reqno]{amsart}

% This allows us to use characters like é and ö directly, rather than having to write \'e and \"o
\RequirePackage[utf8]{inputenc}

% Sets the margin.
\RequirePackage[margin=1in]{geometry}

% Other basic packages I load.

% fakesection: header and page labels %

% Sets up the title -- each document specifies the \title, \author, \course, \psnum, and \date, and \maketitle
% formats the title based on those constraints.
% TODO may want to rearrange
\newcommand{\@uthor}{\@empty}
\newcommand{\c@urse}{\@empty}
\newcommand{\psn@m}{\@empty}
\newcommand{\d@e}{\@empty}
\let\@oldauthor\author % preserves original amsart definitions
\renewcommand{\author}[1]{\renewcommand{\@uthor}{#1}}
\newcommand*{\course}[1]{\renewcommand{\c@urse}{\MakeUppercase{#1}}}
\newcommand*{\psnum}[1]{\renewcommand{\psn@m}{#1}}
\renewcommand*{\date}[1]{\renewcommand{\d@e}{#1}}

% Format title based on amsart's native title command
\title{\c@urse{} Homework \psn@m}
\@oldauthor{\@uthor\\\d@e}

% The header is primarily for keeping the document organized, e.g. if the pages are separated, it should be easy to
% put it back together. Options `onesided' and `twosided' determine whether the header is on each odd-numbered page
% or all pages.
\RequirePackage{fancyhdr}

% Format: ARUN DEBRAY M383C HW1
\newcommand{\he@der}{\footnotesize{\MakeUppercase{\@uthor{}} \c@urse{} HW\psn@m}}

\pagestyle{fancy}
\fancyfoot[C]{\footnotesize{\thepage}}
\fancyhead[L,R]{}
\ifdefined\@nesided
	\fancyhead[C]{\he@der}
\else
	\fancyhead[CO]{\he@der}
\fi

\renewcommand{\headrulewidth}{0pt}

% fakesection: mathmacros %


% fakesection: equation numbering %
% TODO: right now, equation numbering only works when problems are numbered consecutively, since `\item[custom
% number]` doesn't update the item counter. This is part of the reason that `eqnalone` is the default option. This
% is also a problem for \ref. That is, I would like to be able to define \item[2.A.] and automatically number
% equations inside it as (2.A.1), etc., and have references to it evaluate to 2.A. One way this might work is to
% use this to define some command like \itemname and then, instead of using \numberwithin as I do below, to use
% \renewcommand{\theequation}{\itemname . \arabic{equation}}, but I haven't begun to look at this.
\ifdefined\eqn@enum
	\numberwithin{equation}{enumi}
\else
	% If you use symbols to number equations, there's a good chance you may want to number at least ten equations.
	% However, if you do that, the default implementation of fnsymbol throws an error; it only supports up to nine
	% symbols. This code extends it to allow more symbols, up to 24. If you have more than 24 equations, it's
	% likely a good idea to switch to numbering them, as that will confuse your reader less; however, equation
	% numbering is not yet working the way I like it to (see above).

	\def\@fnsone{*}
	\def\@fnstwo{\dagger}
	\def\@fnsthree{\ddagger}
	\def\@fnsfour{\mathsection}
	\def\@fnsfive{\natural}
	\def\@fnssix{\asymp}
	\def\@fnsseven{\clubsuit}
	\def\@fnseight{\lozenge}
	
	\newcommand{\@dbl}[1]{#1 #1}
	\newcommand{\@tpl}[1]{#1 #1 #1}

	\renewcommand{\@fnsymbol}[1]{\ensuremath {\ifcase #1\or
	\@fnsone\or \@fnstwo\or \@fnsthree\or \@fnsfour\or
	\@fnsfive\or \@fnssix\or \@fnsseven\or \@fnseight\or
	\@dbl\@fnsone\or \@dbl\@fnstwo\or \@dbl\@fnsthree\or \@dbl\@fnsfour\or 
	\@dbl\@fnsfive\or \@dbl\@fnssix\or \@dbl\@fnsseven\or \@dbl\@fnseight\or 
	\@tpl\@fnsone\or \@tpl\@fnstwo\or \@tpl\@fnsthree\or \@tpl\@fnsfour\or 
	\@tpl\@fnsfive\or \@tpl\@fnssix\or \@tpl\@fnsseven\or \@tpl\@fnseight
	\else \@ctrerr \fi }}

	\renewcommand{\theequation}{\fnsymbol{equation}}
\fi

% Problem numbering.
% By default, problems are numbered in bold, with a period at the end: 1. 2. 3.
% I also adjusted the spacing of lists: after every item in a list, there is a little space, and inside itemize or
% enumerate environments, paragraphs are double-spaced rather than indented. I found this to look less cramped, and
% therefore easier to read.

% TODO: oftentimes, I must specify the problem number by hand, e.g. as `\item[3.4.]`. When this happens, the bold
% formatting is lost, and references to that item don't automatically use 3.4 (indeed, the item counter isn't even
% updated). This is the current major thing I want to fix in this package.
\RequirePackage{enumitem}

\def\thisitem{\empty}

\setlist{parsep=1.5ex, listparindent=0cm}
\setlist[enumerate, 1]{label=\textbf{\arabic*.},
					   %\textbf{\protect\thisitem.},
					   %ref={\protect\thisitem},
					   ref=\arabic{enumi},
					   leftmargin=0cm,
					   parsep=2ex
					  }
