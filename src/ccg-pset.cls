\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ccg-pset}[2019-04-14 Colton's version of Arun Debray's problem set template]

% This template was forked from Arun Debray <ccg, 2019-04-14>. The mistakes are my own.

% Provides a switch gto check whether you're using this class (e.g. \ifdefined\UsingPsetD)
\def\UsingCCGPset{}

% Provides a switch gto check whether you're using this class (e.g. \ifdefined\UsingPsetD)
% Option 'onesided' places a header on each page; `twosided' (default) on each odd-numbered page.
\DeclareOption{onesided}{\def\@nesided{}}
\DeclareOption{twosided}{}

% Other options can be handed off to the amsart class (e.g. fontsize)
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}

\ExecuteOptions{twosided}
\ProcessOptions\relax

\LoadClass[reqno]{amsart}

% fakesection: import packages shared with ccg-notes.cls %
% namely physics %

#include "packages.tex"

% fakesection: header and page labels %

% Sets up the title -- each document specifies the \title, \author, \course,
% \psnum, and \date, and \maketitle formats the title based on those
% constraints. TODO may want to rearrange

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

% The header is primarily for keeping the document organized, e.g. if the pages
% are separated, it should be easy to put it back together. Options `onesided'
% and `twosided' determine whether the header is on each odd-numbered page or
% all pages.

\RequirePackage{fancyhdr}

% Format: FIRST LAST COURSE-NUMBER HW-NUMBER
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

% fakesection: equation numbering %
% truly distracting %

\numberwithin{equation}{enumi}

% fakesection: mathmacros shared with ccg-notes.cls %

#include "macros.tex"

% fakesection: theorems %

% Numbered (thm, lem) environments are already coming in from theorems.tex via
% macros.tex. here we provide unnumbered (thm*, lem*) versions theorems are
% numbered within problems, as forced by \numberwithin{equation}{enumi}

\newtheorem*{thm*}{Theorem}
\newtheorem*{lem*}{Lemma}
\newtheorem*{prop*}{Proposition}
\newtheorem*{coro*}{Corollary}
\theoremstyle{definition}
\newtheorem*{claim*}{Claim}

% Problem numbering. By default, problems are numbered in bold, with a period at
% the end: 1. 2. 3. I also adjusted the spacing of lists: after every item in a
% list, there is a little space, and inside itemize or enumerate environments,
% paragraphs are double-spaced rather than indented. I found this to look less
% cramped, and therefore easier to read.

% TODO: oftentimes, I must specify the problem number by hand, e.g. as
% `\item[3.4.]`. When this happens, the bold formatting is lost, and references
% to that item don't automatically use 3.4 (indeed, the item counter isn't even
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
