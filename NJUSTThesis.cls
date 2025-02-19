\ProvidesClass{NJUSTThesis}
\LoadClass[UTF-8,a4paper,zihao=-4,twoside,heading=true,fontset=none]{ctexart}

\RequirePackage{expl3}
\RequirePackage{xparse}
\RequirePackage{xstring}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                ctex 设置
\ctexset{
  % 设置标题，当前标题深度为4级
  section/format=\bfseries\zihao{-3},
  subsection/format= \zihao{4}\bfseries,
  subsubsection/format= \zihao{-4}\bfseries,
  paragraph/format=\zihao{-4}\normalfont,
  % 标题段前段后缩进
  section/beforeskip= 18pt,
  section/afterskip= 18pt,
  subsection/beforeskip= 12pt,
  subsection/afterskip= 12pt,
  subsubsection/beforeskip= 6pt,
  subsubsection/afterskip= 6pt,
  % 目录名称
  %contentsname={目\hspace*{2em}录},
  listfigurename={图表目录},
  listtablename={},
  % 目录样式
}
% 重定义 \paragraph 为四级标题
\newcommand{\subsubsubsection}[1]{%
    \paragraph{#1}%
    \mbox{}\\% 确保换行
}
% 设置标题编号深度为四级
\setcounter{secnumdepth}{4} 
% 设置行距
\linespread{1.4}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              论文版式设置
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\geometry{
  a4paper,
  top=30mm,
  bottom=24mm,
  left=25mm,
  right=25mm,
}

%%           设置页眉
\RequirePackage{tocloft}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LO,RE]{\zihao{-5}学士学位论文}
\fancyhead[OR]{\zihao{-5}\getTitle}
\fancyhead[EL]{\zihao{-5}\leftmark}
\fancyfoot[RO,LE]{\zihao{-5}\thepage}
\renewcommand{\headrulewidth}{0.75pt}
%%       设置页眉页脚高度
\setlength{\voffset}{-5.4mm}
\setlength{\topmargin}{0mm}
\setlength{\headsep}{7mm}
\setlength{\footskip}{5mm}
\tocloftpagestyle{fancy}
\fancypagestyle{plain}{
	\pagestyle{fancy}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          目录设置
% 修复没有声明、摘要时目录的页码显示不正确的问题
\newcounter{tempstate}
\setcounter{tempstate}{0}
% 声明存在，置1
% 摘要存在，置2
% 声明、摘要均不存在，置0

% 设置目录样式
\renewcommand\cftsecleader{\bfseries\cftdotfill{\cftdotsep}}
\renewcommand\cftsecfont{\zihao{4}\bfseries}
\renewcommand\cftsecpagefont{\zihao{4}\bfseries}
\renewcommand\cftsubsecfont{\zihao{-4}}
\renewcommand\cftsubsecpagefont{\zihao{-4}}
\renewcommand\cftsubsubsecfont{\zihao{-4}}
\renewcommand\cftsubsubsecpagefont{\zihao{-4}}
\renewcommand\cfttoctitlefont{\hfill\zihao{3}\bfseries}
\renewcommand\contentsname{目\hspace*{2em}录}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftbeforetoctitleskip}{18pt}
\renewcommand{\cftaftertoctitleskip}{18pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           公式编号设置
\RequirePackage{amsmath}
\numberwithin{equation}{section}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          图表格式设置
%% 图片格式
\RequirePackage{caption}
% 图名中文
\captionsetup[figure]{font={small},name={图}}
% 图片编号格式
\let\origthesection\thesection
\counterwithin{figure}{section}
\renewcommand{\thefigure}{\origthesection.\arabic{figure}}
% 图片编号和图名分隔符
\DeclareCaptionLabelSeparator{space}{\hspace*{0.5em}}
\captionsetup{labelsep=space}
%% 表格格式
% 表名中文
\captionsetup[table]{font={small},name={表}}
% 表格编号格式
\let\origthesection\thesection
\counterwithin{table}{section}
\renewcommand{\thetable}{\origthesection.\arabic{table}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              日期功能
\ExplSyntaxOn
\RequirePackage[calc]{datetime2}

% 中文日期
\NewDocumentCommand{\chineseDate}{O{}O{kaiti}}
{
    \IfStrEq{#1}{} % 第一个参数没有日期，使用默认日期
    {
        \IfStrEq{#2}{kaiti}
        {
            {\kai\kaiti\the\year 年 \the\month 月}
        }
        {
            \the\year 年 \the\month 月
        }
    }
    {
        \StrBefore{#1}{年}[\yearpart]
        \StrBehind{#1}{年}[\monthpart]
        \StrBefore{\monthpart}{月}[\monthpart]
        
        \IfStrEq{#2}{kaiti}
        {
            {\kai\kaiti\yearpart 年 \monthpart 月}
        }
        {
            \yearpart 年 \monthpart 月
        }
    }   
}

% 英文日期
\NewDocumentCommand{\convertMonthToEnglish}{m}
{
    \IfStrEqCase{#1}{
        {1}{January}
        {2}{February}
        {3}{March}
        {4}{April}
        {5}{May}
        {6}{June}
        {7}{July}
        {8}{August}
        {9}{September}
        {10}{October}
        {11}{November}
        {12}{December}
    }[Invalid month] % 如果输入的月份无效，输出 "Invalid month"
}

\NewDocumentCommand{\englishDate}{O{}}
{
    \IfStrEq{#1}{}
    {
        \convertMonthToEnglish{\the\month}\hspace*{0.1em},\hspace*{0.5em}\the\year
    }
    {
        \StrBefore{#1}{年}[\yearpart]
        \StrBehind{#1}{年}[\monthpart]
        \StrBefore{\monthpart}{月}[\monthpart]

        \convertMonthToEnglish{\monthpart}\hspace*{0.1em},\hspace*{0.5em}\yearpart
    }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                  论文信息接口
\tl_new:N \njust_zh_title_tl	% 中文标题
\tl_new:N \njust_en_title_tl	% 英文标题
\tl_new:N \njust_zh_author_tl	% 中文作者
\tl_new:N \njust_en_author_tl	% 英文作者
\tl_new:N \njust_student_number_tl	% 学号
\tl_new:N \njust_zh_school_tutor_tl % 中文校内指导老师
\tl_new:N \njust_en_school_tutor_tl % 英文校内指导老师
\tl_new:N \njust_school_tutor_level_tl	% 校内指导老师职称
\tl_new:N \njust_zh_external_tutor_tl	% 中文校外指导老师
\tl_new:N \njust_en_external_tutor_tl	% 英文校外指导老师
\tl_new:N \njust_external_tutor_level_tl	% 校外指导老师职称
\tl_new:N \njust_research_direction_tl	% 研究方向
\tl_new:N \njust_major_tl	% 专业
\tl_new:N \njust_school_tl	% 学院
\tl_new:N \njust_date_tl	% 论文提交时间
\tl_new:N \njust_zh_keywords_tl    % 中文关键词
\tl_new:N \njust_en_keywords_tl    % 英文关键词
\bool_new:N \njust_figtab_contents_bool % 图表目录
\tl_new:N \njust_fontset_tl 	% 字体设置

%% 设置默认值
\tl_set:Nn \njust_zh_title_tl {南京理工大学本科学士学位论文}
\tl_set:Nn \njust_en_title_tl {Nanjing~University~of~Science~\&~Technology}
\tl_set:Nn \njust_zh_author_tl {王麻子}
\tl_set:Nn \njust_en_author_tl {Wang~Mazi}
\tl_set:Nn \njust_student_number_tl {321465798798645}
\tl_set:Nn \njust_zh_school_tutor_tl {书\hspace*{1em}雪}
\tl_set:Nn \njust_en_school_tutor_tl {Xue~Shu}
\tl_set:Nn \njust_school_tutor_level_tl {教授}
\tl_set:Nn \njust_zh_external_tutor_tl {}
\tl_set:Nn \njust_en_external_tutor_tl {}
\tl_set:Nn \njust_external_tutor_level_tl {}
\tl_set:Nn \njust_research_direction_tl {大数据处理}
\tl_set:Nn \njust_major_tl {数学与应用数学}
\tl_set:Nn \njust_school_tl {数学与统计学院}
\tl_set:Nn \njust_date_tl {}
\tl_set:Nn \njust_zh_keywords_tl {南京理工大学，论文模板}
\tl_set:Nn \njust_en_keywords_tl {NJUST,paper~template}
\bool_set_false:N \njust_figtab_contents_bool
\tl_set:Nn \njust_fontset_tl {songti}

\keys_define:nn {njust}	{
  info .code:n = {\keys_set:nn {njust/info}{#1}},	% 信息
  figtab .bool_set:N = \njust_figtab_contents_bool,        % 设置是否生成图表目录
  keywords .code:n = {\keys_set:nn {njust/keywords}{#1}}, % 关键词
  fontset .choice:,
  fontset / songti .code:n = {\tl_set:Nn \njust_fontset_tl {songti}},
  fontset / source .code:n = {\tl_set:Nn \njust_fontset_tl {Source~Han~Serif~SC}},
}

\keys_define:nn {njust/info}	{
  title .code:n = {\keys_set:nn {njust/info/title}{#1}},	% 设置标题
  author .code:n = {\keys_set:nn {njust/info/author}{#1}},	% 设置作者
  tutor .code:n = {\keys_set:nn {njust/info/tutor}{#1}},	% 设置指导老师

  direction .tl_set:N = \njust_research_direction_tl,	% 设置研究方向
  number .tl_set:N = \njust_student_number_tl,			% 设置学号
  major .tl_set:N = \njust_major_tl,						% 设置专业
  school .tl_set:N = \njust_major_tl,						% 设置学院
  date .tl_set:N = \njust_date_tl,						% 设置时间
}

\keys_define:nn {njust/info/title}	{
  zh .tl_set:N = \njust_zh_title_tl,	% 中文标题
  en .tl_set:N = \njust_en_title_tl,	% 英文标题
}

\keys_define:nn {njust/info/author}	{
  zh .tl_set:N = \njust_zh_author_tl,	% 中文作者
  en .tl_set:N = \njust_en_author_tl,	% 英文作者
}

\keys_define:nn {njust/info/tutor}	{
  school/zh .tl_set:N = \njust_zh_school_tutor_tl,	% 中文校内指导老师
  school/en .tl_set:N = \njust_en_school_tutor_tl,	% 英文校内指导老师
  school/level .tl_set:N = \njust_school_tutor_level_tl,	% 校内指导老师职称
  external/zh .tl_set:N = \njust_zh_external_tutor_tl,	% 中文校外指导老师
  external/en .tl_set:N = \njust_en_external_tutor_tl,	% 英文校外指导老师
  external/level .tl_set:N = \njust_external_tutor_level_tl,	% 校外指导老师职称
}

\keys_define:nn {njust/keywords}	{
  zh .tl_set:N = \njust_zh_keywords_tl,  % 设置中文关键词
  en .tl_set:N = \njust_en_keywords_tl,  % 设置英文关键词
}

\NewDocumentCommand{\njustsetup}{ m }{
    \keys_set:nn {njust} {#1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          对标题进行特殊处理
% 标题加横线
\tl_new:N \title_lined_zh_tl
\newcommand\gettitlelined{
    \tl_set_eq:NN \title_lined_zh_tl \njust_zh_title_tl
    \regex_replace_all:nnN {\c{\\}}{\c{\\}\c{hline}} \title_lined_zh_tl
    \tl_use:N \title_lined_zh_tl
}

% 标题取消换行符
\tl_new:N \title_no_newline_tl
\newcommand\getTitle{
    \tl_set_eq:NN \title_no_newline_tl \njust_zh_title_tl
    \regex_replace_all:nnN {\c{\\}}{} \title_no_newline_tl
    \tl_use:N \title_no_newline_tl
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 保留一些接口
\newcommand\authorname[2]{
  \tl_set:Nn \njust_zh_author_tl {#1}
  \tl_set:Nn \njust_en_author_tl {#2}
}

\renewcommand\title[1]{
    \tl_set:Nn \njust_zh_title_tl {#1}
}

\newcommand\englishtitle[1]{
    \tl_set:Nn \njust_en_title_tl {#1}
}

\newcommand\studentnumber[1]{
    \tl_set:Nn \njust_student_number_tl {#1}
}

\newcommand\tutor[2]{
  \tl_set:Nn \njust_zh_school_tutor_tl {#1}
  \tl_set:Nn \njust_zh_external_tutor_tl {#2}
}

\newcommand\post[2]{
  \tl_set:Nn \njust_school_tutor_level_tl {#1}
  \tl_set:Nn \njust_external_tutor_level_tl {#2}
}

\newcommand\englishtutor[2]{
  \tl_set:Nn \njust_en_school_tutor_tl {#1}
  \tl_set:Nn \njust_en_external_tutor_tl {#2}
}

\newcommand\school[1]{
  \tl_set:Nn \njust_school_tl {#1}
}

\newcommand\major[1]{
  \tl_set:Nn \njust_major_tl {#1}
}

\newcommand\direction[1]{
  \tl_set:Nn \njust_direction_tl {#1}
}

\DeclareDocumentCommand{\date}{m}{
  \tl_set:Nn \njust_date_tl {#1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              获取键值

% 获取日期
\newcommand\getDate{
    \tl_use:N \njust_date_tl
}

% 获取校外导师
\newcommand\getOutterTutor
{
    \IfStrEq{\njust_zh_external_tutor_tl}{}
    {}
    { & \tl_use:N \njust_zh_external_tutor_tl \hspace*{1em}}
}

% 获取校外导师职称
\newcommand\getOutterPost
{
    \IfStrEq{\njust_external_tutor_level_tl}{}
    {}
    %{& 你好 \\ \cline{2-3}}
    { & \hspace*{1em} \tl_use:N \njust_external_tutor_level_tl （校外）\\ \cline{2-3}}
}

% 获取英文校外导师
\newcommand{\getOutterTutorEnglish}
{
  \IfStrEq{\njust_en_external_tutor_tl}{}
  {}
  {
    \& \hspace*{0.5em} \njust_en_external_tutor_tl
  }
}

\newcommand\getOutterPostCover
{
    \IfStrEq{\njust_external_tutor_level_tl}{}
    {}
  { & \hspace*{2em} \tl_use:N \njust_external_tutor_level_tl （校外）\\}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%               字体设置
\IfStrEqCase{\njust_fontset_tl}{
  {songti}{
    \setCJKmainfont[AutoFakeBold = {2.17}]{SimSun}
    \setmainfont{Times~New~Roman}
  }
  {Source~Han~Serif~SC}{
    \setCJKmainfont{Source~Han~Serif~SC}
    \setmainfont{Times~New~Roman}
  }
}[Invalid font]
\setCJKfamilyfont{kaiti}[AutoFakeBold={2.17}]{KaiTi}
\setCJKfamilyfont{heiti}[AutoFakeBold={2.17}]{SimHei}
\setCJKfamilyfont{weibei}[AutoFakeBold={2.17}]{方正魏碑简体}
\setfontfamily\kai{KaiTi}[BoldFeatures={FakeBold=1.5}]
\newcommand{\kaiti}{\CJKfamily{kaiti}}
\newcommand{\heiti}{\CJKfamily{heiti}}
\newcommand{\weibei}{\CJKfamily{weibei}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              自定义命令

% 罗马数字转阿拉伯数字
\NewExpandableDocumentCommand{\RomanToInt}{m}
{
  \int_from_roman:e { \tl_lower_case:n { #1 } }
}
\cs_generate_variant:Nn \int_from_roman:n { e }

% 奇数页自动添加空白页，保证目录结束时为偶数页
\NewDocumentCommand{\IfEvenAddBlankPage}{m}
{
  % 判断数字是否为偶数
  \int_if_even:nTF { #1 }
  {
    \newpage
    \null\newpage % 输出空白页
  }
  { }
}

% 图表目录生成命令
\makeatletter
\newcommand\contentsoffigtabs{
  \begingroup
    \ctexset{section/break=}
    \begin{center}
      \section *{\listfigurename }
    \end{center}
  \endgroup
  \@mkboth {\MakeUppercase \listfigurename }{\MakeUppercase \listfigurename }
  \@starttoc {lof}
  \@starttoc {lot}
}
\makeatother


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              摘要和关键词
\DeclareDocumentEnvironment{abstract}{O{chinese}}
{
    \newpage
  \ifnum\value{tempstate}=0
    \pagenumbering{Roman}
  \fi
  \setcounter{tempstate}{2}
  \IfStrEqCase{#1}{
    {chinese}{
    \begingroup
        \ctexset{section/break=}
        \begin{center}
          \section*{摘\hspace*{2em}要}
        \end{center}
    \endgroup
        \markboth{摘\hspace*{2em}要}{}
        \addcontentsline{toc}{section}{摘\hspace*{2em}要}
      }
    {english}{
        \begingroup
          \ctexset{section/break=}
          \begin{center}
            \section*{Abstract}
          \end{center}
        \endgroup
        \markboth{Abstract}{}
        \addcontentsline{toc}{section}{Abstract}
      }
    }[Invalid value]
}
{
    \vspace*{1em}
  \newline

    \IfStrEqCase{#1}{
        {chinese}{
            {\zihao{4}\bfseries 关键词：}\tl_use:N \njust_zh_keywords_tl
        }
        {english}{
            {\zihao{4}\bfseries Keywords:}\tl_use:N \njust_en_keywords_tl
        }
    }[Invalid value]
    \newpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              封面
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{array}
\RequirePackage{ragged2e}

% 封面命令
\NewDocumentCommand\NJUSTCover{}
{
  \thispagestyle{empty}
  {
    \begin{center}
      \includegraphics*[width=12.53cm]{./logo/logo.pdf}
    \end{center}
    \begin{center}
      \fontsize{32pt}{1.2}\selectfont \CJKfamily{kaiti}
      \bfseries
        学\hspace*{0.5em}士\hspace*{0.5em}学\hspace*{0.5em}位\hspace*{0.5em}论\hspace*{0.5em}文
    \end{center}
    \vspace*{2em}
    \begin{table*}[!ht]
      \centering
      \renewcommand{\arraystretch}{1.7}
      \begin{tabular}{>{\CJKfamily{heiti} \bfseries \zihao{-1}}c}
                \gettitlelined
        \\ \hline
      \end{tabular}
    \end{table*}
    \vspace*{0.5em}
    \begin{table*}[!ht]
      \centering
      \renewcommand\arraystretch{1.2}
      \begin{tabular}{cc}
        {\zihao{-2}\CJKfamily{kaiti}\bfseries \hspace*{1em} 
                \tl_use:N \njust_zh_author_tl \hspace*{1em}} \\ \cline{1-1}
        {\zihao{-2}\kai \hspace*{1em}
                \tl_use:N \njust_student_number_tl \hspace*{1em}} \\ \cline{1-1}
      \end{tabular}
    \end{table*}
  }
  \vspace*{-0.5em}
  \begin{table*}[!ht]
    \centering
    \renewcommand\arraystretch{1.1}
    \begin{tabular}{
            >{\bfseries \zihao{4}}c
            >{\raggedleft\arraybackslash\zihao{4}\bfseries\kaiti}m{4.46cm}
            >{\raggedright\arraybackslash\bfseries\kaiti\zihao{4}}m{4.46cm}
            }
      \makebox[3.25cm]{指\hspace*{\fill}导\hspace*{\fill}老\hspace*{\fill}师}	   &
      \tl_use:N \njust_zh_school_tutor_tl\hspace*{1em}                          &
            \hspace*{1em}\tl_use:N \njust_school_tutor_level_tl \\ \cline{2-3}
      \getOutterTutor  \getOutterPost
      \makebox[3.25cm]{学\hspace*{\fill}生\hspace*{\fill}学\hspace*{\fill}院}    &
      \multicolumn{2}{c}{\bfseries \kaiti \zihao{4}
            \tl_use:N \njust_school_tl } \\ \cline{2-3}
      \makebox[3.25cm]{专\hspace*{\fill}业}                                      &
      \multicolumn{2}{c}{\bfseries \kaiti \zihao{4}
            \tl_use:N \njust_major_tl } \\ \cline{2-3} 
      \makebox[3.25cm]{研\hspace*{\fill}究\hspace*{\fill}方\hspace*{\fill}向}    &
      \multicolumn{2}{c}{\bfseries \kaiti \zihao{4}
            \tl_use:N \njust_research_direction_tl} \\ \cline{2-3}  
      \makebox[3.25cm]{论\hspace*{\fill}文\hspace*{\fill}提\hspace*{\fill}交\hspace*{\fill}时\hspace*{\fill}间} & 
      \multicolumn{2}{c}{\bfseries\zihao{4}\chineseDate[\getDate][kaiti]} 
        \\ \cline{2-3}
    \end{tabular}
  \end{table*}
  \newpage

% 第二页封面，中文封面
{
  \thispagestyle{empty}
  \begin{center}
    \makebox[4.87cm]{
    \zihao{-2}\CJKfamily{weibei}
    学\hspace*{\fill}士\hspace*{\fill}学\hspace*{\fill}位\hspace*{\fill}论\hspace*{\fill}文}
    \end{center}

    \vspace*{3.5em}
    \begin{table*}[!ht]
      \centering
      \renewcommand{\arraystretch}{1.7}
      \begin{tabular}{>{\CJKfamily{heiti} \bfseries \zihao{-1}}c}
        \tl_use:N \njust_zh_title_tl
        \\ 
      \end{tabular}
    \end{table*}

    \vspace*{5em}
    \begin{table*}[!ht]
      \centering
      \zihao{-2}\bfseries\CJKfamily{kaiti}
      \begin{tabular}{cll}
        作\hspace*{2em}者： & 
                \multicolumn{2}{l}{\tl_use:N \njust_zh_author_tl} \\
                &          &              \\ % 一行空白表格
        指导老师:  & \tl_use:N \njust_zh_school_tutor_tl & 
                \hspace*{2em}\tl_use:N \njust_school_tutor_level_tl   \\
        \getOutterTutor \getOutterPostCover
      \end{tabular}
    \end{table*}
    \vspace*{16.5em}
    \begin{center}
      \zihao{-2}\bfseries
        南\hspace*{0.334em}京\hspace*{0.334em}理\hspace*{0.334em}
        工\hspace*{0.334em}大\hspace*{0.334em}学
        \end{center}
        \begin{center}
      \zihao{-2}\bfseries
      \chineseDate[\getDate][song]
    \end{center}
  }
  \newpage
% 第三页封面，英文封面
{
  \thispagestyle{empty}
  \begin{center}
    \zihao{-2}Bachelor~Dissertation
  \end{center}

  \vspace*{4.3em}

    \begin{table*}[!ht]
      \centering
      \begin{tabular}{>{\linespread{1.2}\zihao{2}\bfseries}c}
        \tl_use:N \njust_en_title_tl
      \end{tabular}
    \end{table*}

    \vspace*{1.5em}
    \begin{center}
      \zihao{-2}\itshape
      By\\
      {\zihao{-2}\itshape \bfseries \tl_use:N \njust_en_author_tl}
    \end{center}
    \vspace*{2em}
    \begin{center}
      \zihao{-2}\itshape
      Supervised~by~Prof.~{\bfseries 
        \tl_use:N \njust_en_school_tutor_tl 
                \hspace*{0.5em} \getOutterTutorEnglish}
    \end{center}
    \vspace*{18em}
%\newline
    \begin{center}
      \zihao{-2}
        Nanjing~University~of~Science~\&~Technology
    \end{center}
    \begin{center}
      \zihao{-2}
      \englishDate[\getDate]
    \end{center}
}
  \newpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              声明
\NewDocumentCommand\NJUSTStatement{}{
\setcounter{tempstate}{1}% 声明存在
\thispagestyle{empty}
\begin{center}
  {\bfseries\zihao{3}{声\hspace{1em}明}}
\end{center}

\vspace{3ex}

{
	\zihao{4}\justifying\linespread{1.2}\selectfont
	本学位论文是我在导师的指导下取得的研究成果，尽我所知，在本学位论文中，
	除了加以标注和致谢的部分外，不包含其他人已经发表或公布过的研究成果，
	也不包含我为获得任何教育机构的学位或学历而使用过的材料。与我一同工作
	的同事对本学位论文做出的贡献均已在论文中作了明确的说明。
	\newline
	\begin{flushleft}
		学生签名：\underline{\hbox to 6em{}}\hspace*{6.5em}
		年\hspace*{1em}月\hspace*{1em}日
	\end{flushleft}
}
\vspace*{12em}
\begin{center}
	{\bfseries\zihao{3}{学位论文使用授权声明}}
\end{center}
{
\vspace*{1em}
\zihao{4}\justifying\linespread{1.2}\selectfont\par
南京理工大学有权保存本学位论文的电子和纸质文档，可以借阅或上网公
布本学位论文的部分或全部内容，可以向有关部门或机构送交并授权其保
存、借阅或上网公布本学位论文的部分或全部内容。对于保密论文，按保
密的有关规定和程序处理。

\vspace*{2em}
\begin{flushleft}
	学生签名：\underline{\hbox to 6em{}}\hspace*{6.5em}
	年\hspace*{1em}月\hspace*{1em}日
\end{flushleft}
}
\newpage
\pagenumbering{Roman}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              目录生成命令
\newcommand\NJUSTContents
{
	\ifnum\value{tempstate}=0
		\pagenumbering{Roman}
	\fi
	{\tableofcontents}
    \bool_if:nTF {\njust_figtab_contents_bool}{
		\newlength{\figlen}
		\newlength{\tablen}

		\renewcommand{\cftfigpresnum}{\figurename\enspace}
		\renewcommand{\cfttabpresnum}{\tablename\enspace}
		%\renewcommand{\cftfigaftersnum}{}
		%\renewcommand{\cfttabaftersnum}{}
		\settowidth{\figlen}{\cftfigpresnum\cftfigaftersnum}
		\settowidth{\tablen}{\cfttabpresnum\cfttabaftersnum}
		\addtolength{\cftfignumwidth}{\figlen}
		\addtolength{\cfttabnumwidth}{\tablen}
		\newpage
		{\contentsoffigtabs}
    }
    {
        %不添加图表目录
    }
	\newpage

	\IfEvenAddBlankPage{\RomanToInt{\thepage}}

	\pagenumbering{arabic}

}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              致谢
%% 致谢环境
\DeclareDocumentCommand\thanks{}
{
	\clearpage
	\begingroup
		\ctexset{section/break=}
		\begin{center}
			\section*{致\hspace*{2em}谢}
			\addcontentsline{toc}{section}{\bfseries 致\hspace*{2em}谢}
			\markboth{致\hspace*{2em}谢}{}
		\end{center}
	\endgroup

}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              参考文献
%% 参考文献
\RequirePackage[backend=biber,bibstyle=gb7714-2015,doi=false,url=false,gbnamefmt=lowercase%nature,% 加载 biblatex 宏包，使用参考文献citestyle=gb7714-2015%,backref=true % 其中后端 backend 使用 biber
]{biblatex} % 标注(引用)样式 citestyle，著录样式 bibstyle 都采用 gb7714-2015 样式

\NewDocumentCommand\printreference{}
{
	\newpage
	
	\begingroup
		\ctexset{section/format += \centering }
		\addcontentsline{toc}{section}{参考文献}
		\markboth{参考文献}{}
		\printbibliography[heading=bibliography,title={参考文献}]
	\endgroup
}
\ExplSyntaxOff
