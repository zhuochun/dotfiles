#!/usr/bin/env bash

# Install/update vim-go needed dependency
# Somehow vim-go :GoInstallBinaries doesn't work for me
# https://github.com/fatih/vim-go/blob/master/plugin/go.vim#L9

go get -v -u github.com/FiloSottile/gorebuild
go get -v -u github.com/alecthomas/gometalinter
go get -v -u github.com/cweill/gotests/...
go get -v -u github.com/fatih/gomodifytags
go get -v -u github.com/fatih/motion
go get -v -u github.com/golang/lint/golint
go get -v -u github.com/josharian/impl
go get -v -u github.com/jstemmer/gotags
go get -v -u github.com/kisielk/errcheck
go get -v -u github.com/klauspost/asmfmt/cmd/asmfmt
go get -v -u github.com/lukehoban/go-outline
go get -v -u github.com/mvdan/interfacer/cmd/interfacer
go get -v -u github.com/newhook/go-symbols
go get -v -u github.com/nsf/gocode
go get -v -u github.com/rogpeppe/godef
go get -v -u github.com/tpng/gopkgs
go get -v -u github.com/vektra/mockery/.../
go get -v -u github.com/y0ssar1an/q
go get -v -u github.com/zmb3/gogetdoc

go get -v -u golang.org/x/tools/cmd/goimports
go get -v -u golang.org/x/tools/cmd/gomvpkg
go get -v -u golang.org/x/tools/cmd/gorename
go get -v -u golang.org/x/tools/cmd/guru

go get -v -u honnef.co/go/tools/cmd/staticcheck
go get -v -u sourcegraph.com/sqs/goreturns
