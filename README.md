# julia-pycall-mecab

JuliaでPyCallを使ってMecabを動かすDockerイメージ

辞書は[mecab-ipadic-neologd](https://github.com/neologd/mecab-ipadic-neologd)を利用

## Pull

```
docker pull ramenjuniti/julia-pycall-mecab
```

## Run

* Julia REPL
    ```
    docker run -it --rm ramenjuniti/julia-pycall-mecab
    ```

* コンテナにログイン
    ```
    docker run -it --rm ramenjuniti/julia-pycall-mecab /bin/bash
    ```

* ローカルディレクトリをマウント
    ```
    docker run -it --rm -v "$PWD":/usr/myapp -w /usr/myapp ramenjuniti/julia-pycall-mecab /bin/bash
    ```

## example

分かち書き例
```julia
using PyCall
MeCab = pyimport("MeCab")
dic = ENV["DIC"]
mecab = MeCab.Tagger("-d $dic -Owakati")
println(mecab.parse("私はラーメンを食べたい。"))

# 私 は ラーメン を 食べ たい 。
```