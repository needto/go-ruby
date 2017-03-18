docker pull golang:1.6-onbuild
docker build -t golang-docker ./
docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp golang-docker go build -v -buildmode=c-shared -o mylib_x86_64-linux.so main.go
