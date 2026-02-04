#set text(
  lang: "ja",
  font: ("CMU Serif", "Harano Aji Mincho"),
  size: 24pt
)
#set par(leading: 0.8em)
#show link: underline
#show link: set text(fill: blue)
#import "@preview/scienceicons:0.1.0": *
#import "@preview/hydra:0.6.2": hydra
#import "@preview/showybox:2.0.4": *
#let current-chapter = state("chapter", "")
#let bg-color = rgb("#ffffff")

#set page(
  fill: bg-color,
  numbering: "1 / 1",
  width: 25.4cm,
  height: 19.05cm,
  header: context [
    #let page-num = counter(page).get().last()
    #if page-num > 1 [
      #rect(width: 100%, height: 100%, stroke: (bottom: 1pt))[
        #grid(
          columns: (1fr, 1fr),
          align(left)[#hydra(1, skip-starting: false)], 
          align(right)[]
        )
      ]
    ]
  ],
)

#import "@preview/showybox:2.0.3": showybox

#let becausebox(body) = showybox(
  frame: (
    border-color: blue,
    radius: 8pt,
    thickness: 1pt,
  ),
  [
    // 本文の冒頭にアイコンをインラインで配置
    #box(baseline: 25%, circle(radius: 0.8em, stroke: 1pt + blue)[
      #set align(center + horizon)
      #text(fill: blue, size: 1.6em)[$because$]
    ])
    #h(0.1em) // アイコンと本文の間のスペース
    #body
  ]
)

#show heading.where(level: 1): it => {
    current-chapter.update(it.body)  // 状態を更新
    it  // 見出しをそのまま表示
}
#set par(justify: true)
#let title = text(size: 44pt, lang: "en")[On Krull's Dimension Theorem for Certain Graded Rings and its applications]
#let author = "池田 吏来 東京科学大M1"
#show author: set align(center)
#show author: set text(size: 1em, font: ("CMU Serif", "Harano Aji Mincho"))
#set heading(numbering: (..args) => {
  let nums = args.pos() // 引数の位置引数を`array`として取得
  if nums.len() == 1 { // 階層総数が1しかない、即ち最高階層
    return numbering("§ 1", ..nums)
  } else {
    return numbering("1.1", ..nums)
  }
})
#let heading_font(body) = {
  // font: (日本語文字を含まないフォント, 日本語文字を含むフォント)
  set text(font: ("CMU Serif", "Harano Aji Mincho"))
  body
}
#show heading: heading_font
#show strong: set text(font: ("CMU Serif", "Harano Aji Mincho"))
#import "@preview/rubby:0.10.2": get-ruby
#let ruby = get-ruby(
  size: 0.5em,         // Ruby font size
  dy: 0pt,             // Vertical offset of the ruby
  pos: top,            // Ruby position (top or bottom)
  alignment: "center", // Ruby alignment ("center", "start", "between", "around")
  delimiter: "|",      // The delimiter between words
  auto-spacing: true,  // Automatically add necessary space around words
)

#let Ker = "Ker"
#let Spec = "Spec"
#let ovl(math) = $overline(math)$
#let cong = $tilde.equiv$
#let Max = "Max"
#let Hom = "Hom"
#let ht = "ht"
#let coht = "coht" 
#let tensor = $times.o$
#let gldim = "gl.dim"
#let Der = "Der"
#let Reg = "Reg"
#set math.mat(delim: "[")
#let GKdim = "GKdim"
#let trdeg = "tr.deg"
#let gr = "gr"
#let ini = "in"
#let Frac = "Frac"


#import "@preview/statementsp:0.1.1": *
#show heading: reset-counter(statementnum, levels: 1)
#newstatementsp(
  box-name: "axiom",
  box-display: "Axiom",
  title-color: black,
  box-color: rgb("#FF6666")
)
#newstatementsp(
  box-name: "def",
  box-display: "Def",
  title-color: black,
  box-color: rgb("#FF6666")
)
#newstatementsp(
  box-name: "th",
  box-display: "Th",
  title-color: black,
  box-color: rgb("#7733FF")
)
#newstatementsp(
  box-name: "prop",
  box-display: "Prop",
  title-color: black,
  box-color: rgb("#6666FF")
)
#newstatementsp(
  box-name: "lem",
  box-display: "Lem",
  title-color: black,
  box-color: rgb("#6666FF")
)
#newstatementsp(
  box-name: "cor",
  box-display: "Cor",
  title-color: black,
  box-color: rgb("#6666FF")
)
#newstatementsp(
  box-name: "rem",
  box-display: "Rem",
  title-color: black,
  box-color: rgb("#FFFF33")
)
#newstatementsp(
  box-name: "ex",
  box-display: "Example",
  title-color: white,
  box-color: rgb("#333333")
)
#newstatementsp(
  box-name: "exer",
  box-display: "演習",
  title-color: black,
  box-color: rgb("#666666")
)
#newstatementsp(
  box-name: "qu",
  box-display: "Question",
  title-color: black,
  box-color: rgb("#66FF66")
)
#newstatementsp(
  box-name: "fact",
  box-display: "Fact",
  title-color: black,
  box-color: rgb("#00A000")
)


#let pfsp(
  title: "(" + text[$p r o o f$] + ")",
  body
) = [
  #title \ #body #h(1fr) $qed$
]

#align(center)[
  #title
]
#author

#figure(
  image("../to_git.png", width: 4.1em),
  caption: "資料へのリンク（GitHub）"
)

#pagebreak()

#show outline: set text(fill: blue)
#set outline.entry(
  fill: text(fill: black)[#repeat([$dot$], gap: 0.1em)]
)
#text(font: ("CMU Serif", "Harano Aji Mincho"), size: 2em, weight: "black")[目次#label("outline")]
#columns(1, gutter: 0em)[
  #outline(title: none, indent: 2em)
]

#pagebreak()

= Krullの次元定理

#statementsp(
  box-name: "fact",
  box-title: "Krullの次元定理",
  box-label: "",
  number: true
)[
  $(A, frak(m))$:ネーター局所環．このとき次が成り立つ．
  $
    dim(A) = d(A) = delta(A)
  $
  $dim(A)$:$A$のクルル次元 \ 
  $d(A)$:$A$の随伴次数環$gr_frak(m) (A)$のポアンカレ級数$P(t)$の$t=1$での極の位数 \ 
  $delta(A)$:$A$の$frak(m)$準素イデアルの生成系の最小個数．
]

#pagebreak()

#statementsp(
  box-name: "fact",
  box-title: "Smoke の次元定理",
  box-label: "smoke",
  number: true
)[
  $R = plus.o.big_(n=0)^infinity R_n$:ネーター$NN$型次数環（$R_0 = k$:体）．このとき次が成り立つ．
  $
    dim_gr (R) = d(R) = s(R)
  $
  $dim_gr (R)$:$R$の斉次クルル次元 \ 
  $d(R)$:$R$のポアンカレ級数$P_R (t)$の$t=1$での極の位数 \ 
  $s(R)$:$S = k[x_1,dots, x_s] subset R$が部分次数環として有限になるような最小の$s$．
]

#pagebreak()

= イニシャル代数

#statementsp(
  box-name: "def",
  box-title: "イニシャル代数",
  box-label: "",
  number: true
)[
  $R = k[x_1, dots, x_n]$:体$k$上の$n$変数多項式環．$R$に単項式順序を固定．$S = k[f_1 ,dots, f_m] subset R$を斉次多項式で生成される有限生成$k$部分代数とする．このとき，$S$の*イニシャル代数*$ini(S)$を
  $
    ini(S) = k[ini(g) | g in S]
  $
  で定義．
]

#pagebreak()

#statementsp(
  box-name: "def",
  box-title: "Sagbi基底",
  box-label: "",
  number: true
)[
  $S$の多項式の集合$cal(F) subset S$に対して，そのイニシャル多項式の集合$ini(cal(F)) = {ini(f) | f in cal(F)}$が$k$上に$ini(S)$を生成するとき，$cal(F)$を$S$の*Sagbi基底*という．
]

Subalgebra Analogue to Gr\u{00F6}bner Bases for Idealsの略．

有限なSagbi基底を持つとは限らない！

つまり$ini(S)$はネーター環にならないかもしれない．

#pagebreak()

#statementsp(
  box-name: "ex",
  box-title: "イニシャル代数がネーターでない例",
  box-label: "",
  number: true
)[
  $S = k[x+y+z,x y, x y^2] subset k[x,y,z]$\ 
  単項式順序を
  $
    &x^a y^b z^c > x^a' y^b' z^c' \ 
    &<==>_("def") (a+b > a'+b') "or" \ 
    &(a+b = a'+b' "and" (a,b,c)>_("lex") (a',b',c'))
  $
  lexは辞書式順序．このとき$ini(S)$は有限なSagbi基底を持たず，したがってネーター環にならない．

  Macaulay2で計算すると
  $
    k[x,x y, x y^2, x y^3, x y^4, x^2 y^3 z, x y^5, x y^6, dots]
  $
  となっているのがわかる．ちなみに$S$は正則環．
]

#pagebreak()

#showybox[
  ```
  Macaulay2, version 1.25.11
  Type "help" to see useful commands

  i1 : load "computesagbi.m2"
  (Partial SAGBIBasis Computation Object with 8 generators, Limit = 7., false, | x+y+z xy xy2 xy3+xy2z xy4+x2y2z+2xy3z+xy2z2 x2y3z xy5+x3y2z+3xy4z+2x2y2z2+3xy3z2+xy2z3 xy6+x4y2z+x2y4z+4xy5z+3x3y2z2+4x2y3z2+6xy4z2+3x2y2z3+4xy3z3+xy2z4 |)
  ```
]

#pagebreak()

#statementsp(
  box-name: "fact",
  box-title: "",
  box-label: "",
  number: true
)[
  $S = k[f_1 ,dots, f_m] subset R = k[x_1, dots, x_n]$このとき$S$とそのイニシャル代数$ini(S)$は同じポアンカレ級数を持つ．
  $
    P_S (t) = P_(ini(S)) (t)
  $
]

よって，もし$ini(S)$がネーター環であれば，Smokeの次元定理より
$
  dim_gr (ini(S)) = d(ini(S)) = d(S) = dim_gr (S)
$
しかもネーター次数環なら$dim(R) = dim_gr (R)$なので$dim(S) = dim(ini(S))$である．

この手法を使うため，Smokeの次元定理を拡張したいという動機が生まれる．

#pagebreak()

= 主定理
#statementsp(
  box-name: "def",
  box-title: "Hilbert-Serre 環",
  box-label: "hs",
  number: true
)[
  $R = plus.o.big_(n=0)^infinity R_n$を$R_0 = k$が体であるような次数環．

  #enum(
    numbering: "(1)",
    enum.item(1)[$forall n, dim_k (R_n) < infinity$],
    enum.item(2)[$P_R (t) = sum_(n=0)^infinity dim_k (R_n) t^n$の収束半径は$1$．],
    enum.item(3)[$d(R) = min{d in NN | lim_(t -> 1-0)(1-t)^d P_R (t)<infinity}$が有限値で存在する．],
  )

  このとき，$R$を*Hilbert-Serre 環*という．また，$d(R)$を$R$の*Hilbert-Serre 次元*という．
]

#pagebreak()

#statementsp(
  box-name: "th",
  box-title: "主定理",
  box-label: "",
  number: true
)[
  $R$: Hilbert-Serre 環ならば
  $
    dim_gr (R) <= d(R)
  $
  さらに整域なら
  $
    dim_gr (R) <= dim(R) <= trdeg_k (R) = GKdim(R) <= d(R)
  $
]

#pagebreak()

#statementsp(
  box-name: "def",
  box-title: "",
  box-label: "",
  number: true
)[
  $R = plus.o.big_(n=0)^infinity R_n$: Hilbert-Serre 整域

  #enum(
    numbering: "(1)",
    enum.item(1)[$dim_gr (R) = sup{r | frak(p)_0 subset.neq dots.c subset.neq frak(p)_r ": graded prime" }$],
    enum.item(2)[$dim(R) = sup{r | frak(p)_0 subset.neq dots.c subset.neq frak(p)_r ": prime" }$],
    enum.item(3)[$trdeg_k (R) = trdeg_k (Frac(R))$],
    enum.item(4)[$GKdim(R) = sup_V limsup_(n -> infinity) log(d_V (n)) / log(n)$],
    enum.item(5)[$d(R) = min{d in NN | lim_(t -> 1-0)(1-t)^d P_R (t)<infinity}$],
  )
]

#pagebreak()

= 応用例

#statementsp(
  box-name: "ex",
  box-title: "",
  box-label: "",
  number: true
)[
  $S = k[f_1, dots, f_m] subset R = k[x_1, dots, x_n]$，$R$に単項式順序を固定．このとき
  $
    dim(ini(S)) <= d(ini(S)) = d(S) = dim(S)
  $
  イニシャル代数をとっても次元は増えないとわかる．
]

#pagebreak()

#statementsp(
  box-name: "ex",
  box-title: "",
  box-label: "",
  number: true
)[
  $k$を体とする．$R = k[x,x y, x y^2, x y^3, dots]$を考える．これはネーター環ではないがHilbert-Serre 環である．実際，このポアンカレ級数は
  $
    P_R (t) = 1 + sum_(n=1)^infinity n t^n = (t^2 - t + 1) / (1-t)^2
  $
  である．$d(R)=2$で，実は$dim(R) = 2$．主定理は正しそう．
]

#pagebreak()

#statementsp(
  box-name: "ex",
  box-title: "",
  box-label: "",
  number: true
)[
  $k$を体とする．$R = k[x y, x y^2, x y^3, dots]$を考える．これはネーター環ではないがHilbert-Serre 環である．実際，このポアンカレ級数は
  $
    P_R (t) = 1 + sum_(n=1)^infinity lr(floor.l n/2 floor.r) t^n = (t^4 + t^3 - t^2 + 1) / (1-t^2)^2
  $
  である．$d(R) = 2$で，実は$dim(R) = 2$．主定理は正しそう．
]

#pagebreak()

#statementsp(
  box-name: "ex",
  box-title: "Hilbert の第14問題の反例 (Nagata)",
  box-label: "nagata",
  number: true
)[
  $r$を$16$以上の平方数とする．素体$Pi$を一つ固定して，$3r$個の$Pi$上代数的に独立な元$a_(i j)$をとる．（$i=1,2,3, j=1,dots,r$）$k$をこれらの元を含む$Pi$の拡大体とする．
  $
    frak(o) = k[x_1, dots, x_r, y_1, dots, y_r] inter k(w_1,w_2,w_3,t)
  $
  とおく．ただし
  $
    t=y_1 dots y_r, quad w_i = sum_(j=1)^r a_(i j) x_i y_1 dots y_(i-1) y_(i+1) dots y_r
  $
  である．これはネーター環ではないことが知られている．さらにこれは自然な次数環の構造を持つと分かるので，Hilbert-Serre 環である．ゆえに
  $
    dim(frak(o)) <= 4 = trdeg_k (frak(o)) = GKdim(frak(o)) <= d(frak(o)) < infinity
  $
]

#pagebreak()



= 疑問
#statementsp(
  box-name: "th",
  box-title: "主定理（再掲）",
  box-label: "",
  number: true
)[
  $R$: Hilbert-Serre 環ならば
  $
    dim_gr (R) <= d(R)
  $
  さらに整域なら
  $
    dim_gr (R) <= dim(R) <= trdeg_k (R) = GKdim(R) <= d(R)
  $
]

#pagebreak()

#align(center + horizon)[
  + 第一不等式で，より強く$dim(R) <= d(R)$か？
  + 第二不等式で$dim(R) = d(R)$は成立しないか？
]

#pagebreak()

#set page(header: none)

#align(center + horizon)[
  #text(size: 3em)[$zws$]
  #figure(
    image("../to_git.png", width: 9em),
    caption: "資料へのリンク（GitHub）"
  )
]

#pagebreak()

#align(center + horizon)[
  #text(size: 3em)[Thank you!]
  #figure(
    image("../to_git.png", width: 9em),
    caption: "資料へのリンク（GitHub）"
  )
]
