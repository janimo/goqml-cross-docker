# Cross build Go QML packages to armhf

This Docker image allows easy armhf cross-builds of packages using go-qml residing in your $GOPATH.
$GOPATH can be shared between the host and the container so that the binaries of the dependencies are saved
and reused across invocations, thus reducing build times.

## Install

```sh
docker pull janimo/goqml-cross
```

Or you can build one locally from the Dockerfile.

## Run

Make your working directory and $GOPATH available in the container and build the contents of the package you are in.

```sh
docker run --rm -it -v $(pwd):/home/developer -v $GOPATH:/home/developer/gopath janimo/goqml-cross build
```

For convenience, you could set up an alias like this which then acts like the go tool, accepting the usual go subcommands and flags. This also makes sure to switch to a subdirectory of $GOPATH in the container so that go build -i and go install work.

```sh
alias goqml-cross='docker run --rm -it -v $(pwd):/home/developer -v $GOPATH:/home/developer/gopath -w $(pwd|sed "s,$GOPATH,/home/developer/gopath,") janimo/goqml-cross'
```

## References

CGO specific cross-build workarounds taken from
http://blog.surgut.co.uk/2014/06/cross-compile-go-code-including-cgo.html

