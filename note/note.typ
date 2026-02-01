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
  box-display: "Ex",
  title-color: black,
  box-color: rgb("#CCCCCC")
)
#newstatementsp(
  box-name: "exer",
  box-display: "演習",
  title-color: black,
  box-color: rgb("#CCCCCC")
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

#pagebreak()

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

ところで，可換代数において「局所環」と書いてある部分を「$H$局所環」と変えると，類似の定理が成立するという観察がある．例えば中山の補題がこれに該当する．

#statementsp(
  box-name: "lem",
  box-title: "中山の補題",
  box-label: "",
  number: true
)[
  $R = plus.o.big_(n=0)^infinity R_n$を次数環として$R_+ = plus.o.big_(n=1)^infinity R_n$とする．
]

#pagebreak()

= Hilbert-Serre 環
次数環におけるクルルの次元定理を一般化するうえで，ポアンカレ級数とその極が定義できていなければいけない．そこで次のような定義を行う．

#statementsp(
  box-name: "def",
  box-title: "",
  box-label: "",
  number: true
)[
  $R = plus.o.big_(n=0)^infinity R_n$を$R_0 = k$が体であるような次数環で，次を満たすとする．

  #enum(
    numbering: "(1)",
    enum.item(1)[$forall n, dim_k (R_n) < infinity$],
    enum.item(2)[ポアンカレ級数$P_R (t) = sum_(n=0)^infinity dim_k (R_n) t^n$が収束半径$1$をもつ．],
    enum.item(3)[$d(R) = min{d in NN | lim_(t ^> 1-0)(1-t)^d P_R (t) "が存在"}$が有限値で存在する．],
  )

  このとき，$R$を*Hilbert-Serre 環*という．また，$d(R)$を$R$の*Hilbert-Samuel 次元*という．
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

= main theorem
次数環$R$について，まずは次が成り立つ．

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "",
  number: true
)[
  $ceil.l (dim(R) -1 )/ (2) ceil.r <= dim_gr (R) <= dim(R)$
]
#pfsp[
  あとでかく．
]

そして次のクルルの次元定理の非ネーターだが弱いバージョンが成り立つ．

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "",
  number: true
)[
  $dim_gr (R) <= d(R)$
]
#pfsp[
  後で書く．
]

このことから，$R$がHilbert-Serre 環ならば，次が従う．

#statementsp(
  box-name: "cor",
  box-title: "",
  box-label: "",
  number: true
)[
  Hilbert-Serre 環はクルル次元有限である．
]
#pfsp[
  前定理などから直ちに従う．
]

次数環が整域であれば，もう少し強いことがいえる．

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "",
  number: true
)[
  $R$はHilbert-Serre 環で整域とする．このとき次が成り立つ．
  $
    dim_gr (R) <= dim(R) <= trdeg_k (R) = GKdim(R) <= d(R)
  $
]

#pagebreak()

= 応用例

じつはもともとの目的は次に述べるイニシャル代数をとる操作でクルル次元がどうなるか調べることであった．

まず，体$k$上の多項式環$R = k[x_1, ..., x_n]$の有限生成$k$部分代数$S = k[f_1, dots, f_m]$を考える．ただし，$f_i$は$R$の斉次元とする．また，$R$にはひとつ単項式順序を固定する．このとき，$S$のイニシャル代数$ini(S)$を$k$上に$g in S$のイニシャル$ini(g)$で生成される$R$の部分代数として定義できる．この操作でポアンカレ級数が変化しないことが知られている．しかし，もとが正則局所環であったとしてもイニシャル代数がネーター環になるとさえ限らない．

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
この例の$S$は正則局所環になっているが，それでもネーター環にならないのである．Macaulay2でこの例のSagbi基底をある程度計算したのが以下になる．

#showybox[
  ```
  Macaulay2, version 1.25.11
  Type "help" to see useful commands

  i1 : load "computesagbi.m2"
  (Partial SAGBIBasis Computation Object with 11 generators, Limit = 10., false, | a+b+c ab ab2 ab3+ab2c ab4+a2b2c+2ab3c+ab2c2 a2b3c ab5+a3b2c+3ab4c+2a2b2c2+3ab3c2+ab2c3 ab6+a4b2c+a2b4c+4ab5c+3a3b2c2+4a2b3c2+6ab4c2+3a2b2c3+4ab3c3+ab2c4 ab7+a5b2c+2a2b5c+5ab6c+4a4b2c2+5a3b3c2+8a2b4c2+10ab5c2+6a3b2c3+10a2b3c3+10ab4c3+4a2b2c4+5ab3c4+ab2c5 ab8+a6b2c+3a2b6c+6ab7c+5a5b2c2+6a4b3c2+9a3b4c2+14a2b5c2+15ab6c2+10a4b2c3+18a3b3c3+24a2b4c3+20ab5c3+10a3b2c4+18a2b3c4+15ab4c4+5a2b2c5+6ab3c5+ab2c6 ab9+a7b2c+4a2b7c+7ab8c+6a6b2c2+7a5b3c2+10a4b4c2+14a3b5c2+22a2b6c2+21ab7c2+15a5b2c3+28a4b3c3+41a3b4c3+48a2b5c3+35ab6c3+20a4b2c4+42a3b3c4+52a2b4c4+35ab5c4+15a3b2c5+28a2b3c5+21ab4c5+6a2b2c6+7ab3c6+ab2c7 |)
  ```
]


`computesagbi.m2`の中身は以下の通り．

#showybox[
  ```
  needsPackage "SubalgebraBases"
  R = QQ[a,b,c,MonomialOrder=>{Weights=>{1,1,0},Lex=>1}]

  P = {a+b+c,a*b,a*b^2}
  SB = sagbi(P, Limit=>10);
  print(SB,isSAGBI SB,gens SB)
  ```
]

例の$S$は$ini(S) = k[x,x y, x y^2, x y^3, x y^4, x^2 y^3 z, x y^5, x y^6, dots]$と続くようである．(その先がどうなっているかは不明．)

イニシャル代数をとるとこのように構造が破壊される．しかし，ポアンカレ級数は一致している．もとの$S$は正則局所環なので$dim(S) = d(S) = 3$である．イニシャル代数は整域であることに注意すればこの例では$ini(S)$の具体的な素イデアルを見ることなしに$dim(ini(S)) <= d(S) = 3$までは言える．

イニシャル代数をとると必ず単項式代数になることはやさしい．イニシャル代数のクルル次元を観察するうえで次の定理は大変強力である．

#statementsp(
  box-name: "th",
  box-title: "Theorem 21.4",
  box-label: "",
  number: true
)[
  $R$を単位的可換環，$S$を簡約的なモノイドで，グロタンディーク群を$G$とする．すると
  $
    dim(R[S]) = dim(R[G])
  $
  である．ただし，$R[S]$は$R$上のモノイド環，$R[G]$は$R$上の群環である．
]
$ini(S)$はある$ZZ^3$の部分モノイドのモノイド環になっているが，計算結果から少なくとも生成系の一部として$(1,0,0), (1,1,0), (1,2,0), (1,3,0), (1,4,0), (2,3,1), (1,5,0), (1,6,0)$が取れるとわかる．これら元があれば，そのグロタンディーク群は$ZZ^3$全体になるので，定理21.4より$dim(ini(S)) = dim(k[x,y,z,x^(-1),y^(-1),z^(-1)]) = 3$が従う．主定理の適用結果は正しかったと分かる．

次に，ヒルベルトの第14問題の反例として有名なNagataの例を考える．

#statementsp(
  box-name: "ex",
  box-title: "Hilbert の第14問題の反例 (Nagata)",
  box-label: "",
  number: true
)[
  $r$を$16$以上の平方数とする．素体$Pi$を一つ固定して，$3r$個の$Pi$上代数的に独立な元$a_(i j)$をとる．($i=1,2,3, j=1,dots,r$)$k$をこれらの元を含む$Pi$の拡大体とする．
  $
    frak(o) = k[x_1, dots, x_r, y_1, dots, y_r] inter k(w_1,w_2,w_3,t)
  $
  とおく．ただし$t=y_1 dots y_r, w_i = sum_(j=1)^r a_(i j) x_i y_1 dots y_(i-1) y_(i+1) dots y_r$である．これはネーター環ではないことが知られている．さらにこれは自然な次数環の構造を持つと分かるので，Hilbert-Serre 環である．ゆえに次がわかる．
  $
    dim(frak(o)) <= 4 = trdeg_k (frak(o)) = GKdim(frak(o)) <= d(frak(o)) < infinity
  $
]

