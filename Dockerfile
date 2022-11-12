FROM golang:1.19 AS builder
WORKDIR /go/src/github.com/mikeshng/argoworkflow-status-addon
COPY . .
ENV GO_PACKAGE github.com/mikeshng/argoworkflow-status-addon

# Build
RUN make build --warn-undefined-variables

# Use distroless as minimal base image to package the manager binary
# Refer to https://github.com/GoogleContainerTools/distroless for more details
FROM registry.access.redhat.com/ubi8/ubi-minimal:latest

# Add the binaries
COPY --from=builder go/src/github.com/mikeshng/argoworkflow-status-addon/bin/argoworkflow-status-addon .

ENTRYPOINT ["/argoworkflow-status-addon"]
