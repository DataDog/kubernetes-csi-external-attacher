ARG BASE_IMAGE
ARG BUILDER_IMAGE

FROM $BUILDER_IMAGE as builder
WORKDIR /go/src/kubernetes-csi/external-attacher
ADD . .
ENV GOTOOLCHAIN auto
RUN make build

FROM $BASE_IMAGE
LABEL maintainers="Compute"
LABEL description="CSI External Attacher"
ARG binary=./bin/csi-attacher

COPY --from=builder /go/src/kubernetes-csi/external-attacher/${binary} csi-attacher
ENTRYPOINT ["/csi-attacher"]
