% Author: Andreu Gimenez Bolinches <esdandreu@gmail.com>
% Adapted from Felix Duvallet's RI thesis template:
% https://github.com/felixduvallet/ri-thesis-template
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{src/stem-thesis}

\LoadClassWithOptions{book}

%% Default packages setup -----------------------------------------------------
% Appendix
\RequirePackage{appendix}
% Colors
\RequirePackage{xcolor}  % Get extra colours.
\colorlet{documentLinkColor}{blue}
\colorlet{documentCitationColor}{black!80}
\definecolor{headergray}{rgb}{0.5,0.5,0.5}
% Hyperlinks
\RequirePackage[
  pageanchor=true,
  plainpages=false,
  pdfpagelabels,
  bookmarks,
  bookmarksnumbered,
]{hyperref}
\hypersetup{
  colorlinks = true,
  citecolor = documentCitationColor,
  linkcolor = documentLinkColor,
  urlcolor = documentLinkColor,
}
% Figures
\RequirePackage{graphicx}
% Fancy headers
\RequirePackage{fancyhdr}

%% Header styling -------------------------------------------------------------

% Remove rulers around the chapter titles
\renewcommand{\headrulewidth}{0.0pt}
\renewcommand{\footrulewidth}{0.0pt}

% headers
\fancyhead[LO,R]{\hyperlink{contents}{\slshape \leftmark}}
\fancyhead[LO,R]{\hyperlink{contents}{\slshape \leftmark}}
% Make chapter header line: N. <name>
\renewcommand{\chaptermark}[1]{%
  \markboth{%
    \color{headergray}{%
      \thechapter.\ #1%
    }%
  }{}%
}

% footers
\fancyfoot[C]{}

%% Title ----------------------------------------------------------------------

% Parameters:
% Required
\def\title#1{\gdef\@title{#1}}
\def\author#1{\gdef\@author{#1}}
\def\date#1{\gdef\@date{#1}}
\def\Year#1{\gdef\@Year{#1}}
% Optional
\def\subtitle#1{\gdef\@subtitle{#1}}
\def\supervisor#1{\gdef\@supervisor{#1}}
\def\organization#1{\gdef\@organization{#1}}
\def\logopath#1{\gdef\@logopath{#1}}
\def\committee#1{\gdef\@committee{#1}}
\def\keywords#1{\gdef\@keywords{#1}}

\def\disclaimer#1{\gdef\@disclaimer{#1}}
\def\support#1{\gdef\@support{#1}}
\def\permission#1{\gdef\@permission{#1}}


\newsavebox{\@copyrightbox}
%\def\@copyrightnotice#1{{\small\sbox{\@copyrightbox}{#1}\ifthenelse{\lengthtest{\wd\@copyrightbox > \linewidth}}{\noindent #1 \par}{\begin{center} #1 \end{center}}}}
\def\@copyrightnotice#1{{\small\sbox{\@copyrightbox}{#1}\ifdim\wd\@copyrightbox>\linewidth \noindent #1 \par\else\begin{center} #1 \end{center}\fi}}

\def\maketitle{
  \thispagestyle{empty}

  % calculate skip needed to ensure that title appears in the cut-out
  \newlength{\@cutoutvskip}
  \setlength{\@cutoutvskip}{2.1875 true in}       % position of cut-out
  \addtolength{\@cutoutvskip}{-1 true in}         % printer margin
  \addtolength{\@cutoutvskip}{-\topmargin}
  \addtolength{\@cutoutvskip}{-\headheight}
  \addtolength{\@cutoutvskip}{-\headsep}

  %% Centered things on the title page must be *physically* centered
  %% on the page, so they line up with the cut-out window. So we hardwire
  %% the margins for the title page so that left margin = right margin:
  %%         left margin = (8.5in - textwidth)/2
  \oddsidemargin=8.5in
  \advance\oddsidemargin by -\textwidth
  \oddsidemargin=.5\oddsidemargin
  \advance\oddsidemargin by -1in % TeX sux
  %
  \let\footnoterule\relax
  \vglue\@cutoutvskip
  \begin{center}
    %\begin{minipage}[t]{4.875in}   % must be a minipage due to \thanks
    \begin{minipage}[t]{4.8in}      % hackery
      \vbox to 2in{
        \vfill
        \begin{center}
          {\huge \strut \bf \@title\par}
          \smallskip
          \@ifundefined{@subtitle}{}{\large \strut \@subtitle\par}
          \bigskip
          {\large \begin{tabular}[t]{c}\@author\end{tabular}\par}
          \vfill
          {\large \@date\par}
        \end{center}
        \vfill
      }
    \end{minipage}
  \end{center}

  \@ifundefined{@logopath}{}{
    \begin{figure}[!htb]
      \centering
      \scalebox{.2}{
        \hyperlink{contents}{  % Link To TOC -- define label in main file.
          \includegraphics{\@logopath}
      }}
    \end{figure}
  }

  \@ifundefined{@organization}{}{
    \begin{center}
      \@organization
    \end{center}
  }
  \vfill
  \@ifundefined{@supervisor}{}{
    \begin{center}
        {\bf Supervisor:} \\
        \@supervisor
    \end{center}
    \vspace{1em}
  }
  \vfill
  \@ifundefined{@committee}{}{
    \begin{center}
        {\bf Committee:} \\
        \@committee
    \end{center}
    \vspace{1em}
  }
  \vfill
  \@ifundefined{@permission}{
    \@copyrightnotice{Copyright \copyright\ \@Year\ \@author}
  }{
    \@copyrightnotice{Copyright \copyright\ \@Year\ \@author. \@permission}
  }
  \@ifundefined{@disclaimer}{}{
    {\medskip\center\em\footnotesize\noindent\@disclaimer\par}
  }
  \medskip
  \@ifundefined{@keywords}{}{
    \vspace*{\fill} {\bf Keywords:} \@keywords
  }
  \clearpage
}

%% Preface

\newenvironment{dedication}
  {
    \thispagestyle{fancy}
    \vspace*{\stretch{1}} \begin{center} \em
  }
  {
    \end{center} \vspace*{\stretch{3}} \clearpage
  }

\newenvironment{pseudochapter}[1]
  {
    \thispagestyle{fancy}
    %%\vspace*{\stretch{1}}
    \begin{center} \large {\bf #1} \end{center}
    \begin{quotation}
  }
  {
    \end{quotation}
    \vspace*{\stretch{3}}
    \clearpage
  }

\newenvironment{abstract}{
  \begin{pseudochapter}{Abstract}}{\end{pseudochapter}
}

\newenvironment{acknowledgments}{
  \begin{pseudochapter}{Acknowledgments}}{\end{pseudochapter}
}

\newenvironment{funding}{
  \begin{pseudochapter}{Funding}}{\end{pseudochapter}
}

%% Page styles ----------------------------------------------------------------

\fancypagestyle{plain}{%
  \fancyhf{}
  %\fancyfoot[C]{}
  \fancyfoot[RO,LE]{\thepage}
}

\fancypagestyle{thesis}{%
  \fancyhead{}%
  \fancyhead[RO,LE]{\hyperlink{contents}{\slshape \leftmark}}
  \fancyfoot[RO,LE]{\thepage}%
}