#!/usr/bin/env bash

# Install/update vim-go needed dependency
# Somehow vim-go :GoInstallBinaries doesn't work for me
# https://github.com/fatih/vim-go/blob/master/plugin/go.vim#L9

go get -u github.com/FiloSottile/gorebuild
go get -u github.com/alecthomas/gometalinter
go get -u github.com/client9/misspell/cmd/misspell
go get -u github.com/cweill/gotests/...
go get -u github.com/davidrjenni/reftools/cmd/fillstruct
go get -u github.com/derekparker/delve/cmd/dlv
go get -u github.com/dominikh/go-tools/cmd/keyify
go get -u github.com/fatih/gomodifytags
go get -u github.com/fatih/motion
go get -u github.com/josharian/impl
go get -u github.com/jstemmer/gotags
go get -u github.com/kisielk/errcheck
go get -u github.com/klauspost/asmfmt/cmd/asmfmt
go get -u github.com/koron/iferr
go get -u github.com/newhook/go-symbols
go get -u github.com/mdempsky/gocode
go get -u github.com/ramya-rao-a/go-outline
go get -u github.com/rogpeppe/godef
go get -u github.com/tylerb/gotype-live
go get -u github.com/uber/go-torch
go get -u github.com/uudashr/gopkgs/cmd/gopkgs
go get -u github.com/vektra/mockery/.../
go get -u github.com/y0ssar1an/q
go get -u github.com/zmb3/gogetdoc

go get -u golang.org/x/lint/golint
go get -u golang.org/x/tools/cmd/eg
go get -u golang.org/x/tools/cmd/godoc
go get -u golang.org/x/tools/cmd/goimports
go get -u golang.org/x/tools/cmd/gomvpkg
go get -u golang.org/x/tools/cmd/gorename
go get -u golang.org/x/tools/cmd/guru

# https://github.com/dominikh/go-tools
go get -u honnef.co/go/tools/...
# https://github.com/sqs/goreturns
go get -u sourcegraph.com/sqs/goreturns
# https://github.com/mvdan/interfacer
go get -u mvdan.cc/interfacer
