## How to run a Docker wasm container

Step zero is creating/modifing your `/etc/docker/daemon.json` file, adding this feature:

```json
{
  "features": {
    "containerd-snapshotter": true
  }
}
```
Save, close and restart docker:

```bash
systemctl restart docker
```

First step is compiling the containerd-shim-wasmtime that we will use later as runtime in docker.

```bash
docker build --output . - <<EOF
FROM rust:1.70.0 as build
RUN apt-get update -y
RUN apt-get install protobuf-compiler libdbus-1-dev pkg-config -y
RUN cargo install \
    --git https://github.com/mfranzon/runwasi.git \
    --branch oci-artifacts \
    --bin containerd-shim-wasmtime-v1 \
    --root /out \
    containerd-shim-wasmtime
FROM scratch
COPY --from=build /out/bin /
EOF
```

Second step, move the executable into an exported PATH like `/usr/local/bin`

```bash
mv ./containerd-shim-wasmtime-v1 /usr/local/bin
```

Last step, enjoy your docker wasm

```bash
docker run --runtime=io.containerd.wasmtime.v1 --platform wasi/wasm32 rumpl/wasmtest echo 'hello from wasm'
```

