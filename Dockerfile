# Rebuild the original release with a patched Go runtime and supported Alpine.
FROM --platform=$BUILDPLATFORM golang:1.26.7-alpine AS build
ARG TARGETOS
ARG TARGETARCH
WORKDIR /src
ADD https://api.github.com/repos/appleboy/drone-gh-pages/tarball/545eea3d0241374991d4443b08c7dfad99665be7 /tmp/source.tar.gz
RUN echo "11be73d0d387c14feff5c6c52f4a5301b2ab457bb116112382bb636db0e60293  /tmp/source.tar.gz" | sha256sum -c - \
    && tar -xzf /tmp/source.tar.gz --strip-components=1 -C /src \
    && CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -trimpath -o /bin/drone-gh-pages .

FROM alpine:3.23
RUN apk add --no-cache ca-certificates git openssh curl rsync perl
COPY --from=build /bin/drone-gh-pages /bin/drone-gh-pages
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
