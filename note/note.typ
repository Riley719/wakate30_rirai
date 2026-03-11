#set text(
  lang: "ja",
  font: ("CMU Serif", "Harano Aji Mincho"),
  size: 11pt
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
  paper: "a4",
  header: context [
    #let page-num = counter(page).get().last()
    #if page-num > 1 [
      #rect(width: 100%, height: 100%, stroke: (bottom: 1pt))[
        #grid(
          columns: (1fr, 1fr, 1fr),
          align(left)[#hydra(1, skip-starting: false)], 
          align(center)[],
          align(right)[#link("https://github.com/Riley719/wakate30_rirai")[#github-icon() ノート置き場]]
        )
      ]
    ]
  ],
  footer: context [
    #let page-num = counter(page).get().last()
    #if page-num > 1 [
      #rect(width: 100%, height: 100%, stroke: (top: 1pt))[
        #grid(
          columns: (1fr, 1fr, 1fr),
          align(left)[#link(<outline>)[目次へジャンプ]], 
          align(center)[#counter(page).display("— 1/1 —", both: true)],
          align(right)[\@Rirai]
        )
      ]
    ]
  ]
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
#let title = "第30回代数学若手研究会ノート"
#show title: set align(center)
#show title: set text(weight: "black", size: 2em, font: ("CMU Serif", "Harano Aji Mincho"))
#let author = "池田　吏来"
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
  box-color: rgb("#FFCCCC")
)
#newstatementsp(
  box-name: "def",
  box-display: "Def",
  title-color: black,
  box-color: rgb("#FFCCCC")
)
#newstatementsp(
  box-name: "th",
  box-display: "Th",
  title-color: black,
  box-color: rgb("#B380FF")
)
#newstatementsp(
  box-name: "prop",
  box-display: "Prop",
  title-color: black,
  box-color: rgb("#CCCCFF")
)
#newstatementsp(
  box-name: "lem",
  box-display: "Lem",
  title-color: black,
  box-color: rgb("#CCCCFF")
)
#newstatementsp(
  box-name: "cor",
  box-display: "Cor",
  title-color: black,
  box-color: rgb("#CCCCFF")
)
#newstatementsp(
  box-name: "rem",
  box-display: "Rem",
  title-color: black,
  box-color: rgb("#FFFF99")
)
#newstatementsp(
  box-name: "ex",
  box-display: "Example",
  title-color: black,
  box-color: rgb("#CCCCCC")
)
#newstatementsp(
  box-name: "exer",
  box-display: "演習",
  title-color: black,
  box-color: rgb("#CCCCCC")
)
#newstatementsp(
  box-name: "qu",
  box-display: "Question",
  title-color: black,
  box-color: rgb("#CCFFCC")
)


#let pfsp(
  title: "(" + text[$p r o o f$] + ")",
  body
) = [
  #title \ #body #h(1fr) $qed$
]

#title
#author

このノートは2026年3月10日の第30回代数学若手研究会での池田吏来の講演ノートである。スライドでは発表しきれなかった箇所や証明しなかった部分をすべて記述する．

#show outline: set text(fill: blue)
#set outline.entry(
  fill: text(fill: black)[#repeat([$dot$], gap: 0.1em)]
)
#text(font: ("CMU Serif", "Harano Aji Mincho"), size: 2em, weight: "black")[目次#label("outline")]
#columns(2, gutter: 0em)[
  #outline(title: none, indent: 2em)
]

#pagebreak()

= Introduction
ネーター局所環の次元論の一つの到達点は，次のクルルの次元定理と思われる．

#statementsp(
  box-name: "th",
  box-title: "Krull の次元定理",
  box-label: "",
  number: true
)[
  $(A, frak(m))$をネーター局所環とする．このとき次が成り立つ．
  $
    dim(A) = d(A) = delta(A)
  $
  ただし，$dim(A)$は$A$のクルル次元，$d(A)$は$A$の随伴次数環$gr_frak(m) (A)$のポアンカレ級数$P(t)$の$t=1$での極の位数，$delta(A)$は$A$の$frak(m)$準素イデアルの生成系の最小個数である．
]

ところで，可換代数において「局所環」と書いてある部分を「$H$局所環」と変えると，類似の定理が成立するという観察がある．詳しくは述べないが，クルルの次元定理も次のスモークの次元定理として類似の定理が成り立つ．次は@SMOKE1972149[Theorem 5.5] による．

#statementsp(
  box-name: "th",
  box-title: "Smoke の次元定理",
  box-label: "smoke",
  number: true
)[
  $R = plus.o.big_(n=0)^infinity R_n$を$R_0 = k$を体とするネーター次数環とする．このとき次が成り立つ．
  $
    dim_gr (R) = d(R) = s(R)
  $
  ここで$dim_gr (R)$は$R$の斉次クルル次元，$d(R)$は$R$のポアンカレ級数$P_R (t)$の$t=1$での極の位数，$s(R)$は$S = k[x_1,dots, x_s] subset R$が部分次数環として有限になるような最小の$s$である．
]

実は上のようなネーター$NN$型次数環の場合$dim(R) = dim_gr (R)$が成り立つ．

#linksp(<th:smoke>)を，ネーターでない場合に拡張しようとすると何がいえるだろうか？そこで計算を進めると次が成り立つことがわかった．

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "",
  number: true
)[
  $R = plus.o.big_(n=0)^infinity R_n$をHilbert-Serre 環とする．このとき
  $
    dim_gr (R) <= d(R)
  $
  である．
]
Hilbert-Serre 環という条件はポアンカレ級数とその極が定義できるためのものであり，そう強い仮定ではない．ネーターでない場合も含んでいる．#linksp(<th:smoke>)における$s(R)$はネーター性がないと明らかに定義できないので，主張に含めることはできない．ゆえに上の形をある種のクルルの次元定理の非ネーター版と考えることができる．

整域を課すともう少し強いことがいえるとわかった．

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "intromain2",
  number: true
)[
  $R = plus.o.big_(n=1)^infinity R_n$をHilbert-Serre 環で整域とする．このとき次が成り立つ．
  $
    dim_gr (R) <= dim(R) <= trdeg_k (R) = GKdim(R) <= d(R)
  $
  $trdeg_k (R)$は$R$の商体の$k$上の超越次数，$GKdim(R)$はGelfand-Kirillov 次元である．
]

次の章でこれらの定理を考えるに至ったモチベーションを説明し，その後にHilbert-Serre 環をはじめとする定義と基本的な性質を述べる．次に上の定理の証明をし，最後に応用例や残された問題について述べる．

#pagebreak()

= Motivation
なぜクルルの次元定理，スモークの次元定理の非ネーター版を考察しようと思ったのか，その最初の動機を説明する．

それは以下に述べるイニシャル代数である．

#statementsp(
  box-name: "def",
  box-title: "",
  box-label: "",
  number: true
)[
  $R = k[x_1, dots, x_n]$を体$k$上の$n$変数多項式環とする．$R$にひとつ単項式順序を固定する．$S = k[f_1 ,dots, f_m] subset R$を斉次多項式で生成される有限生成$k$部分代数とする．このとき，$S$の*イニシャル代数*$ini(S)$を$k$上に$g in S$のイニシャル$ini(g)$で生成される$R$の部分代数$ini(S) = k[ini(g) | g in S]$として定義する．

  $S$の多項式の集合$cal(F) subset S$に対して，そのイニシャル多項式の集合$ini(cal(F)) = {ini(f) | f in cal(F)}$が$k$上に$ini(S)$を生成するとき，$cal(F)$を$S$の*Sagbi基底*という．
]

イニシャル代数とSagbi基底については@robiano を参照されたい．多項式を斉次としているのは，$S$が次数環になるようにするためだけに置いている仮定である．

与えられた部分代数からSagbi基底を計算する手法が確立しており，Macaulay2でもそれは実装されている．@SubalgebraBasesSource, @SubalgebraBasesArticle しかし，Gr\u{00F6}bner基底と違って，有限なSagbi基底を持つとは限らない．

#statementsp(
  box-name: "ex",
  box-title: "",
  box-label: "",
  number: true
)[
  $k$を体として$S = k[x+y+z,x y, x y^2] subset k[x,y,z]$を考える．さらに単項式順序を
  $
    x^a y^b z^c > x^a' y^b' z^c' <==>_("def") (a+b > a'+b') "or" (a+b = a'+b' "and" (a,b,c)>_("lex") (a',b',c'))
  $
  ここでlexとはlexicographic order，つまり辞書式順序である．このとき$ini(S)$は有限なSagbi基底を持たず，したがってネーター環にならない．
]
この例の$S$は正則環になっているが，それでもネーター環にならないのである．Macaulay2でこの例のSagbi基底をある程度計算したのが以下になる．

#showybox[
  ```
  Macaulay2, version 1.25.11
  Type "help" to see useful commands

  i1 : load "computesagbi.m2"
  (Partial SAGBIBasis Computation Object with 8 generators, Limit = 7., false, | x+y+z xy xy2 xy3+xy2z xy4+x2y2z+2xy3z+xy2z2 x2y3z xy5+x3y2z+3xy4z+2x2y2z2+3xy3z2+xy2z3 xy6+x4y2z+x2y4z+4xy5z+3x3y2z2+4x2y3z2+6xy4z2+3x2y2z3+4xy3z3+xy2z4 |)
  ```
]


`computesagbi.m2`の中身は以下の通り．

#showybox[
  ```
  needsPackage "SubalgebraBases"
  R = QQ[x,y,z,MonomialOrder=>{Weights=>{1,1,0},Lex=>1}]

  P = {x+y+z,x*y,x*y^2}
  SB = sagbi(P, Limit=>7);
  print(SB,isSAGBI SB,gens SB)
  ```
]

例の$S$は$ini(S) = k[x,x y, x y^2, x y^3, x y^4, x^2 y^3 z, x y^5, x y^6, dots]$と続くようである．(その先がどうなっているかは不明．)

イニシャル代数をとると，このように構造が破壊される．しかし，次のようにポアンカレ級数は保存することが知られている．@Conca[Proposition 2.4] 

#statementsp(
  box-name: "prop",
  box-title: "",
  box-label: "",
  number: true
)[
  $S$を$R = k[x_1,dots, x_n]$の有限生成$k$次数付き部分代数とする．このとき$S$とそのイニシャル代数$ini(S)$は同じポアンカレ級数を持つ．つまり
  $
    P_S (t) = P_(ini(S)) (t)
  $
]

$S$は正則環なので$dim(S) = d(S) = 3$である．イニシャル代数は整域であることに注意すれば，この例では$ini(S)$の具体的な素イデアルを見ることなしに#linksp(<th:intromain2>)を適用して$dim(ini(S)) <= d(S) = 3$までは言える．

ちなみに今回の実際のクルル次元はどうなっているかというと，それは$3$である．これを説明しよう．まず，イニシャル代数をとると必ず単項式代数になることはやさしい．イニシャル代数のクルル次元を観察するうえで次の定理は大変強力である．@gilmer[Theorem 21.4]

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "gilmer",
  number: true
)[
  $R$を単位的可換環，$S$を簡約的なモノイドで，グロタンディーク群を$G$とする．すると
  $
    dim(R[S]) = dim(R[G])
  $
  である．ただし，$R[S]$は$R$上のモノイド環，$R[G]$は$R$上の群環である．
]
$ini(S)$はある$ZZ^3$の部分モノイドのモノイド環になっているが，計算結果から少なくとも生成系の一部として$(1,0,0), (1,1,0), (1,2,0), (1,3,0), (1,4,0), (2,3,1), (1,5,0), (1,6,0)$が取れるとわかる．それぞれ順に$ini(S)$の元$x,x y, x y^2, x y^3, x y^4, x^2 y^3 z, x y^5, x y^6$に対応する．これら元があれば，そのグロタンディーク群は$ZZ^3$全体になるので，#linksp(<th:gilmer>)より$dim(ini(S)) = dim(k[x,y,z,x^(-1),y^(-1),z^(-1)]) = 3$が従う．#linksp(<th:intromain2>)の適用結果と矛盾しないことが分かる．

さて，イニシャル代数をとってもネーター環になるならば，ポアンカレ級数を通じて#linksp(<th:smoke>)によって$dim(S) = d(S) = d(ini(S)) = dim(ini(S))$となり，クルル次元が保存されることがわかる．しかし，上で見たようにイニシャル代数がネーター環かわからないので，特に最後のイコール$d(ini(S)) = dim(ini(S))$が非自明となる．そこで，クルルの次元定理，スモークの次元定理の非ネーター版を考察するという動機が生まれた．

#pagebreak()

= 次数環
まず，扱う次数環とポアンカレ級数，斉次素イデアルの性質について述べる．

#statementsp(
  box-name: "def",
  box-title: "ポアンカレ級数",
  box-label: "poincare",
  number: true
)[
  $R = plus.o.big_(n=0)^infinity R_n$を$R_0 = k$が体であるような次数環とする．$M = plus.o.big_(n=-infinity)^infinity M_n$を次数付き$R$加群で十分小さな任意の$n in ZZ$で$M_n = 0$とし，さらに$dim_k (M_n) < infinity$とする．このとき
  $
    P_M (t) = sum_(n=-infinity)^infinity dim_k (M_n) t^n in ZZ((t))
  $
  を$M$のポアンカレ級数という．
]

ポアンカレ級数の性質を述べるうえで次数加群を負の次数を許す形で定義したが，実際に使いたいのは$M=R$の場合である．

#statementsp(
  box-name: "lem",
  box-title: "",
  box-label: "poincare",
  number: true
)[
  $R, M$を#linksp(<def:poincare>)の通りとする．$x in R_h$を$M$正則元とするとき，次が成り立つ．
  $
    P_(M \/ x M) (t) = (1 - t^h) P_M (t)
  $
]
#pfsp[
  次の次数を保存する完全列を考える．
  $
    0 --> M(-h) stretch(-->)^(x) M -> M \/ x M -> 0
  $
  これの各$n$次成分を取り出して足し上げると，求める等式が得られる．
]

次数環$R$においてクルル次元を$dim(R)$と表すが，考える素イデアルとして斉次素イデアルのみを考えたバージョンを$dim_gr (R)$と表して$R$の斉次クルル次元ということにする．つまり
$
  dim_gr (R) = sup{r in ZZ_(>=0) | frak(p_0) subset.neq dots.c subset.neq frak(p)_r "は斉次素イデアルの長さ" r "の列" }
$
と定める．

また，与えられた$frak(p) in Spec(R)$に対して$frak(p)^* = (x in frak(p) | x "は斉次元")$と定めると，これも$R$の素イデアルとなる．これに関して次の定理がある．@roberts[Lemma 1] では近いことが述べられているが，この証明は$frak(p)$の高さに関する帰納法であり，ネーター性が仮定されているものと思われるので，改めて証明する．

#statementsp(
  box-name: "lem",
  box-title: "",
  box-label: "htgraded",
  number: true
)[
  $R$を#linksp(<def:poincare>)の通りとする．任意の$frak(p) in Spec(R)$であって斉次素イデアルでないものに対して次が成り立つ．
  $
    ht(frak(p)\/frak(p)^*) = 1
  $
]

これの証明のため，まずは次を示す．

#statementsp(
  box-name: "lem",
  box-title: "",
  box-label: "unit",
  number: true
)[
  $R = plus.o.big_(n in ZZ) R_n$を$ZZ$次数付き環とする．このとき次は同値．
  #enum(
    numbering: "(1)",
    enum.item(1)[$R_0$は体であって，ある斉次元$T in R$をとって次数環として$R = R_0 [T,T^(-1)]$である．],
    enum.item(2)[$R$の任意の$0$でない斉次元は単元である．],
  )
]
#pfsp[
  (1) $==>$ (2): 自明．

  (2) $==>$ (1): 仮定から$R_0$は体である．また，$n > 0$を$R_n eq.not 0$であるような最小の整数とする．$T in R_n$を$0$でない斉次元とする．もし$R_m eq.not 0$ならば$m = k n$なる$k in ZZ$が取れる．$m=0$の場合は明らかで，$m eq.not 0$の場合に成立しないとすると，$m, n$の最大公約数の絶対値$d$に対して$R_d eq.not 0$となり$n$の最小性に矛盾する．したがって，任意の$R_m$の元は$T^k$と$R_0$の元の積で書ける．ゆえに$R = R_0 [T,T^(-1)]$である．
]

#pfsp(
  title: "(" + linksp(<lem:htgraded>) + "の証明)"
)[
  $S$を$frak(p)$には含まれない$R$のすべての斉次元全体の集合とする．$S$は積閉集合となり$S^(-1) frak(p)$と$S^(-1) frak(p)^*$はともに$ZZ$次数環$S^(-1) R$の素イデアルであると分かる．また，$S^(-1) frak(p)^*$は斉次素イデアルであるが，$S^(-1) R \/ S^(-1) frak(p)^*$は#linksp(<lem:unit>)の(2)を満たすと確認できる．ゆえにこれのクルル次元は$1$であり，
  $
    ht(frak(p) \/ frak(p)^*) = ht(S^(-1) frak(p) \/ S^(-1) frak(p)^*) = 1
  $
  となる．
]

これを用いて次の定理を証明できる．

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "ineq",
  number: true
)[
  $R$を#linksp(<def:poincare>)の通りとする．このとき，長さ$r$の素イデアルの鎖が存在すれば，少なくとも長さ$lr(ceil.l (r-2)/2 ceil.r)$の斉次素イデアルの鎖が存在する．特に，次が成り立つ．
  $
    lr(ceil.l (dim(R) -2)/ (2) ceil.r) <= dim_gr (R)
  $
  $ceil.l dot.c ceil.r$は天井関数である．
]
#pfsp[
  $r=0,1$のときは$R_+ = plus.o.big_(n=1)^infinity R_n$が斉次極大イデアルであることに注意して明らかである．$r>=2$で示す．もし長さ$2$の素イデアルの列$frak(p)_0 subset.neq frak(p)_1 subset.neq frak(p)_2$があったとき，$frak(p)_0^* subset frak(p)_1^* subset frak(p)_2^*$であるが，どちらの包含もイコールになることはあり得ない．もしそうであるなら
  $
    frak(p)_2^* subset frak(p)_0 subset.neq frak(p)_1 subset.neq frak(p)_2
  $
  となってしまい，#linksp(<lem:htgraded>)に矛盾する．このことから，一般に長さ$r$の素イデアルの列
  $
    frak(p)_0 subset.neq frak(p)_1 subset.neq dots.c subset.neq frak(p)_r
  $
  があったとき，次のように斉次素イデアルの列を作ることができる．
  $
    frak(p)_0^* subset frak(p)_2^* subset dots.c subset frak(p)_r^*
  $
  この包含のうちいくつかはイコールになりうるが，隣り合った包含をイコールにすることは先ほどの話から不可能である．よって少なくとも$lr(ceil.l (r-2)/2 ceil.r)$個は真の包含になり，主張が従う．
]

#pagebreak()

= Hilbert-Serre 環
次数環におけるクルルの次元定理を一般化するうえで，ポアンカレ級数とその極が定義できていなければいけない．そこで次のような定義を行う．

#statementsp(
  box-name: "def",
  box-title: "Hilbert-Serre 環",
  box-label: "hs",
  number: true
)[
  $R = plus.o.big_(n=0)^infinity R_n$を$R_0 = k$が体であるような次数環で，次を満たすとする．

  #enum(
    numbering: "(1)",
    enum.item(1)[$forall n, dim_k (R_n) < infinity$],
    enum.item(2)[ポアンカレ級数$P_R (t) = sum_(n=0)^infinity dim_k (R_n) t^n$が収束半径$1$をもつ．],
    enum.item(3)[$d(R) = min{d in NN | lim_(t -> 1-0)(1-t)^d P_R (t) "が存在"}$が有限値で存在する．],
  )

  このとき，$R$を*Hilbert-Serre 環*という．また，$d(R)$を$R$の*Hilbert-Serre 次元*という．
]

名前の由来は，次の定理による．

#statementsp(
  box-name: "th",
  box-title: "Hilbert-Serre の定理",
  box-label: "",
  number: true
)[
  $R = plus.o.big_(n=0)^infinity R_n$を$R_0 = k$が体であるような次数環で，さらにネーター環とする．このとき$R$のポアンカレ級数は
  $
    P_R (t) = f(t) / (product_(i=1)^r (1-t^(d_i)))
  $
  という有理関数である．ここで，$f(t)$は多項式，$d_i$は正の整数である．
]

これにより，ネーター環の場合は$R$はHilbert-Serre 環であることがわかる．

#statementsp(
  box-name: "rem",
  box-title: "",
  box-label: "",
  number: true
)[
  #linksp(<def:hs>)から明らかなこととして次がある．

  #enum(
    numbering: "(1)",
    enum.item(1)[$R$がネーター環であれば，$R$はHilbert-Serre 環である．],
    enum.item(2)[$R$がHilbert-Serre 環であれば，任意の$R$の斉次部分$k$代数$S = plus.o.big_(n=0)^infinity S_n$（$S_0 = k$）もHilbert-Serre 環で，$d(S) <= d(R)$である．],
    enum.item(3)[$R$がHilbert-Serre 環であれば，任意の次数を保存する全射$k$準同型$ phi colon R --> S = plus.o.big_(n=0)^infinity S_n quad (S_0 = k) $に対して，$S$もHilbert-Serre 環で，$d(S) <= d(R)$である．],
    enum.item(4)[$R$がHilbert-Serre 環であれば，任意の正則斉次元$x in R$に対して，$R \/ x R$もHilbert-Serre 環で，#linksp(<lem:poincare>)によって$d(R \/ x R) = d(R)-1$である．],
  )
]

次の章で，このHilbert-Serre 環に対してIntroductionで述べたようなクルルの次元定理の非ネーター版を示す．

#pagebreak()

= main theorem
この章では特筆無ければ$R = plus.o.big_(n=0)^infinity R_n$を#linksp(<def:hs>)の通りのものとする．

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "main",
  number: true
)[
  $R$:Hilbert-Serre 環に対して$dim_gr (R) <= d(R)$が成立する．
]
#pfsp[
  $d = d(R)$に関する帰納法で示す．$d=0$のとき，ポアンカレ級数$P_R (t)$は$t=1$で極を持たないので，十分大きな任意の$n > 0$に対して$R_n = 0$となる．ゆえに$R_+ = plus.o.big_(n=1)^(infinity) R_n$:極大イデアルについて，$R_+^m = 0$となる$m>0$が存在する．任意に$R$の素イデアル$frak(p)$をとると$R_+^m = 0 subset frak(p)$となり，$frak(p) = R_+$となる．よって$dim(R) = 0$だから確かに成立する．

  $d-1$では成立するとする．もし長さ$r$の斉次素イデアルの鎖$frak(p)_0 subset.neq dots.c subset.neq frak(p)_r$が存在したとする．斉次元$x in frak(p)_1 \\ frak(p)_0$をとる．$R' = R\/frak(p)_0$とおき，$x'$を$x$の$R'$における像とする．$R'$はHilbert-Serre 環であり，整域だから$x' in R'$は正則元である．また，$R' \/ x' R'$には少なくとも長さ$r-1$の斉次素イデアルの鎖があるので，帰納法の仮定と合わせて
  $
    r-1 <= dim_gr (R' \/ x' R') <= d(R' \/ x' R') = d(R') - 1 <= d(R) - 1 = d - 1
  $
  となり，$dim_gr (R) <= d(R)$が示された．
]

このことから，$R$がHilbert-Serre 環ならば，次が従う．

#statementsp(
  box-name: "cor",
  box-title: "",
  box-label: "finitedim",
  number: true
)[
  Hilbert-Serre 環はクルル次元有限である．
]
#pfsp[
  もし$dim(R) = infinity$なら任意の$r in NN$に対して長さ$r$の素イデアルの鎖をとれる．#linksp(<th:ineq>)より，任意の$r in NN$に対して長さ$lr(ceil.l (r-2)/2 ceil.r)$の斉次素イデアルの鎖がとれるとわかる．ゆえに，#linksp(<th:main>)にょり任意の$r in NN$に対して
  $
    lr(ceil.l (r-2)/2 ceil.r) <= dim_gr (R) <= d(R)
  $
  であるが，$r --> infinity$とすると矛盾する．
]

次数環が整域であれば，もう少し強いことがいえる．

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "main2",
  number: true
)[
  $R$はHilbert-Serre 環で整域とする．このとき次が成り立つ．
  $
    dim_gr (R) <= dim(R) <= trdeg_k (R) = GKdim(R) <= d(R)
  $
]

これの証明のために，$trdeg_k (R)$と$GKdim(R)$の簡単な説明をする．

#statementsp(
  box-name: "def",
  box-title: "Transcendence degree",
  box-label: "",
  number: true
)[
  整域$R$が体$k$を含んでいるとする．このとき$R$の商体$Frac(R)$の体$k$上の超越次数を整域$R$の*超越次数*といって，$trdeg_k (R)$とかく．
]

上の定義の場合，$R$は次数環でなくともよい．$R$が$k$上有限生成（したがってネーター環）なら次が知られている．

#statementsp(
  box-name: "prop",
  box-title: "",
  box-label: "trnoe",
  number: true
)[
  $R$がネーター整域で体$k$を含んでいるとする．$R$が体$k$上有限生成ならば
  $
    dim(R) = trdeg_k (R)
  $
  である．
]

しかし，$R$がネーター環でなくても次が示せる．

#statementsp(
  box-name: "lem",
  box-title: "",
  box-label: "ineqoftrdeg",
  number: true
)[
  $R$が体$k$を含む整域であるとする．このとき
  $
    dim(R) <= trdeg_k (R)
  $
  である．
]
#pfsp[
  任意に$R$の素イデアルの列$frak(p)_0 subset.neq dots.c subset.neq frak(p)_r$をとる．$x_i in frak(p)_i \\ frak(p)_(i-1)$をとる．$S = k[x_1,dots, x_r]$とすると，$frak(p)_0 inter S subset.neq dots.c subset.neq frak(p)_r inter S$となるので
  $
    r <= dim(S) = trdeg_k (S) <= trdeg_k (R)
  $
  となって$dim(R) <= trdeg_k (R)$が示された．
]

これは$R$がネーター環でも$k$上有限生成でないと真の不等式になりうる．例えば$R = k(x)$:1変数有理関数体とすると，$dim(R) = 0 < 1 = trdeg_k (R)$である．

さらに，超越次元は次のように有限生成なものの極限である．

#statementsp(
  box-name: "lem",
  box-title: "",
  box-label: "supoftr",
  number: true
)[
  $R$を体$k$を含む整域とする．このとき次が成り立つ．
  $
    trdeg_k (R) = sup{trdeg_k (S) | S subset R, S "は体" k "上有限生成な部分代数"}
  $
]
#pfsp[
  $>=$は明らか．任意に$n$個の体$k$上代数的に独立な$(r_i)/(s_i) in Frac(R)$をとる．
  $
    S = k(r_i, s_i | i = 1, ..., n) subset R
  $
  は体$k$上有限生成な部分整域で，$trdeg_k (S) >= n$となる．よって$n <= ("右辺")$となり，$n$は任意だから$trdeg_k (R) <= ("右辺")$が従う．
]

次にGK次元を定義する．詳細は@gkdim を参照されたい．

#statementsp(
  box-name: "def",
  box-title: "Gelfand-Kirillov dimension",
  box-label: "",
  number: true
)[
  $R$を体$k$を含む可換代数とする．$V subset R$を体$k$上有限次元の部分ベクトル空間とする．このとき，$n in NN$に対して
  $
    d_V (n) = dim_k (k + V + V^2 + dots + V^n)
  $
  と定める．ただし$V^n$は$V$の基底の$n$次の積すべてで生成される$k$部分ベクトル空間である．このとき，$R$の*Gelfand-Kirillov 次元*を
  $
    GKdim(R) = sup_V (limsup_(n -> infinity) (log d_V (n)) / (log n))
  $
  と定める．ここで，$V$は体$k$上有限次元の部分ベクトル空間を渡る．
]

@gkdim によると，次が成り立つ．

#statementsp(
  box-name: "lem",
  box-title: "",
  box-label: "supofgk",
  number: true
)[
  $R$を体$k$を含む可換代数とする．このとき次が成り立つ．
  $
    GKdim(R) = sup{GKdim(S) | S subset R, S "は体" k "上有限生成な部分代数"}
  $
]

#statementsp(
  box-name: "lem",
  box-title: "",
  box-label: "gkdimandkrull",
  number: true
)[
  $R$を体$k$上有限生成な代数とする．このとき
  $
    GKdim(R) = dim(R)
  $
]

これにより次がわかる．

#statementsp(
  box-name: "lem",
  box-title: "",
  box-label: "gkandtr",
  number: true
)[
  $R$を体$k$を含む整域とする．このとき
  $
    trdeg_k (R) = GKdim(R)
  $
]
#pfsp[
  次のように計算できる．
  $
    GKdim(R) &= sup{GKdim(S) | S subset R, S "は体" k "上有限生成な部分代数"} \
    &= sup{dim(S) | S subset R, S "は体" k "上有限生成な部分代数"} \
    &= sup{trdeg_k (S) | S subset R, S "は体" k "上有限生成な部分代数"} \
    &= trdeg_k (R)
  $
  一つ目の等式は#linksp(<lem:supofgk>)，二つ目の等式は#linksp(<lem:gkdimandkrull>)，三つ目の等式は#linksp(<lem:supoftr>)による．
]

さて，ここまで準備すると，#linksp(<th:main2>)の証明は次のようになる．

#pfsp(
  title: "(" + linksp(<th:main2>) + "の証明)"
)[
  $dim_gr (R) <= dim(R)$は自明．$dim(R) <= trdeg_k (R)$は#linksp(<lem:ineqoftrdeg>)による．$trdeg_k (R) = GKdim(R)$は#linksp(<lem:gkandtr>)による．残りは$trdeg_k (R) <= d(R)$を示せばいい．

  任意に$t$個の体$k$上代数的に独立な元$(r_i)/(s_i) in Frac(R)$をとる．$r_i, s_i$の斉次分解に現れるすべての斉次元の集合を$H$とおく．すると
  $
    S = k(h | h in H)
  $
  とすると$trdeg_k (S) >= t$であるので，$H$から$t$個の$k$上代数的独立な斉次元をとれる．ゆえに，初めから$t$個の体$k$上代数的独立な斉次元をとればよい．それを$x_1, ..., x_t in R$とする．すると
  $
    T = k[x_1, dots, x_t] subset R
  $
  は部分次数環で$d(T) = trdeg_k (T) = t$である．$d(T) <= d(R)$なので，$t <= d(R)$が従う．$t$は任意だったので，$trdeg_k (R) <= d(R)$が示された．
]

#pagebreak()

= 応用例
いくつかHilbert-Serre 環とそのポアンカレ級数を用意して#linksp(<th:main>)や#linksp(<th:main2>)を適用してみる．

#statementsp(
  box-name: "ex",
  box-title: "",
  box-label: "",
  number: true
)[
  $k$を体として$a_n in ZZ_(n>=0)$を$n in ZZ_(n>=1)$に対して任意に固定する．$k$上のベクトル空間として次を考える．
  $
    M = plus.o.big_(n=1)^infinity k^(plus.o a_n)
  $
  ここで$k$と$M$のイデアル化$R = k times.r M$を考える．するとこれは次数環となり，そのポアンカレ級数は
  $
    P_R (t) = sum_(n=0)^infinity a_n t^n quad (a_0 = 1)
  $
  となる．つまり，（ほぼ）任意の形式的べき級数をポアンカレ級数として持つ次数環が存在する．このときの$R$は$a_n = 0, forall n>0$であるとき，かつそのときに限り整域となる．また，有限個を除くすべての$n>0$で$a_n = 0$であるとき，かつそのときに限りネーター環となる．また，常に$dim(R) = 0$である．ゆえに，#linksp(<th:main>)の不等式はいくらでも離すことができる．
]

#statementsp(
  box-name: "ex",
  box-title: "",
  box-label: "",
  number: true
)[
  $S = k[f_1, dots, f_m] subset R = k[x_1, dots, x_n]$を体$k$上の$n$変数多項式環と，その有限生成次数付き部分$k$代数とする．$R$に単項式順序を固定する．すると#linksp(<th:main2>)によって
  $
    dim(ini(S)) <= d(ini(S)) = d(S) = dim(S) 
  $
  がわかる．
]

#statementsp(
  box-name: "ex",
  box-title: "",
  box-label: "",
  number: true
)[
  $k$を体とする．

  #enum(
    numbering: "(1)",
    enum.item(1)[
      $R = k[x,x y, x y^2, x y^3, dots]$を考える．これはネーター環ではないがHilbert-Serre 環である．実際，このポアンカレ級数は
      $
        P_R (t) = 1 + sum_(n=1)^infinity n t^n = (t^2 - t + 1) / (1-t)^2
      $
      である．ゆえに$R$はHilbert-Serre 環で$d(R) = 2$である．#linksp(<th:main2>)より$dim(R) <= 2$である．今回の場合，#linksp(<th:gilmer>)を適用して$dim(R) = 2$まで言える．
      ],
    enum.item(2)[
      $R = k[x y, x y^2, x y^3, dots]$を考える．これはネーター環ではないがHilbert-Serre 環である．実際，このポアンカレ級数は
      $
        P_R (t) = 1 + sum_(n=1)^infinity lr(floor.l n/2 floor.r) t^n = (t^4 + t^3 - t^2 + 1) / (1-t^2)^2
      $
      である．ゆえに$R$はHilbert-Serre 環で$d(R) = 2$である．#linksp(<th:main2>)より$dim(R) <= 2$である．今回の場合も，#linksp(<th:gilmer>)を適用して$dim(R) = 2$まで言える．
      ],
  )
]

次に，ヒルベルトの第14問題の反例として有名なNagataの例を考える．@nagata

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
  とおく．ただし$t=y_1 dots y_r, w_i = sum_(j=1)^r a_(i j) x_i y_1 dots y_(i-1) y_(i+1) dots y_r$である．これはネーター環ではないことが知られている．さらにこれは自然な次数環の構造を持つと分かるので，Hilbert-Serre 環である．ゆえに#linksp(<th:main2>)によって次がわかる．
  $
    dim(frak(o)) <= 4 = trdeg_k (frak(o)) = GKdim(frak(o)) <= d(frak(o)) < infinity
  $
]

#pagebreak()

= 残された問題
最後に，いまだにわかっていないことを挙げておく．

#statementsp(
  box-name: "qu",
  box-title: "Best possible?-1",
  box-label: "q1",
  number: true
)[
  #linksp(<th:main>)の仮定の下で$d(R) < dim(R)$となることはあるか？
]

#statementsp(
  box-name: "qu",
  box-title: "Best possible?-2",
  box-label: "q2",
  number: true
)[
  #linksp(<th:main2>)の仮定の下で$dim(R) = d(R)$は成立するか？
]

特に#linksp(<qu:q2>)について，例えば#linksp(<ex:nagata>)では$r$は$16$以上の平方数であればなんでもいい一方，$dim(R) <= 4$という制約は常に受ける．$r$が大きいときは$dim(R) < d(R)$となってしまうかもしれない．そのまた一方，$d(R)$の挙動に関係しそうな超越次数も常に$4$だから，実は常に$dim(R) = d(R) = 4$なのかもしれない．どちらにせよ興味深い．

追記１（2026/03/12）:代数若手前日に少し考えたら#linksp(<qu:q1>)については肯定的に解決した。
#pfsp[
  $R$をHilbert-Serre 環とする。#linksp(<cor:finitedim>)よりこれはKrull次元有限。よって
  $
    frak(p)_0 subset.neq frak(p)_1 subset.neq dots.c subset.neq frak(p)_r
  $
  を$R$の素イデアルの列であって$r = dim(R)$であるものとする。$frak(p)_0$は$R$の斉次素イデアルである。よって
  $
    dim(R) = dim(R\/frak(p)_0) <= d(R\/frak(p)_0) <= d(R)
  $
  となり示せた。整域なら不等号は正しいことを用いた。
]

#pagebreak()

#bibliography(
  "../references.bib"
)