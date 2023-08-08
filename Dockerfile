ARG BASE_IMAGE

FROM golang:1.20 as builder
WORKDIR /go/src/kubernetes-csi/external-attacher
ADD . .
ENV GOFLAGS="-buildvcs=false"
RUN make build

FROM $BASE_IMAGE
LABEL maintainers="Compute"
LABEL description="CSI External Attacher"
ARG binary=./bin/csi-attacher

COPY --from=builder /go/src/kubernetes-csi/external-attacher/${binary} csi-attacher
ENTRYPOINT ["/csi-attacher"]
