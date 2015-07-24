# docker-proxmark3

This is a simple Dockerfile and build script to cleanly build and bundle the latest git HEAD of Proxmark3. This will (hopefully) leave you with a neat tarball containing the latest proxmark3 client, flasher, bootrom and fullimage.

At the moment this will only build x86_64 ELF binaries, but there's nothing stopping someone from pulling in i386 build deps or targeting other alternate architectures.

Build image (create build environment)

```
git clone git@github.com:chrisfu/docker-proxmark3.git
cd docker-proxmark3
docker build -t proxmark3-build .
```

Run a container from the image (build latest Proxmark3 git HEAD within build environment)

```
docker run -it proxmark3-build
```

Once that's done, just pull the tarball out of the container using 'docker cp' from the location that it gives you in stdout. If you're not attached to your container whilst Proxmark3 is building, to get the tarball location, just use:

```
docker logs --tail=10 <container_id>
```

The command above will simply show you the last 10 lines of stdout from the build process. The tarball location will be at the very end.
