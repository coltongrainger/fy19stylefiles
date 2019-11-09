\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ccg-topic}
%
% Provides a way to check whether this class is being used
\def\UsingCCGTopic{}
%
% For now, this is a one-off that disables the " -> ^(...) feature.
\DeclareOption{quotes}{\def\qu@es{YES}}
\DeclareOption{no_quotes}{\def\noqu@es{}}
\ExecuteOptions{quotes}
%
% Do I want any package options?
% Possibilities:
%	1. \mathbb vs. \mathbf for N, Z, Q, R, ...
%	2. Roman or italic d in f(x) dx
%
% Other options can be handed off to the amsart class (e.g. fontsize)
% TODO: for larger notes, I want to use amsbook instead. How should I efficiently unify
% this with shorter notes, which use amsart?
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}
%
\ProcessOptions\relax
%
\LoadClass{amsart}

#include "packages.tex"
#include "macros.tex"
\renewcommand{\indexname}{Index of Terms and Keywords}
\newcommand{\vocab}[1]{\fbox{#1}\index{#1}} % e.g. "The \term{trace} is defined to be..."
\newcommand{\kw}[1]{\fbox{\color{blue}#1}\index{#1}} % e.g. "The \term{trace} is defined to be..."
\newcommand{\ask}[1]{\fbox{\color{blue}#1}} % e.g. "The \term{trace} is defined to be..."
#include "topic-style.tex"

