# -- BUILD STAGE --
# base image
FROM golang:1.23 AS builder

WORKDIR /app

# copy files into build stage
COPY go.mod .
COPY main.go .
COPY templates ./templates

# compile the app into a static binary
RUN CGO_ENABLED=0 go build -o bin .

# -- FINAL STAGE --
FROM scratch

WORKDIR /app

# set working directory
COPY --from=builder /app/bin /app/bin
COPY --from=builder /app/templates /app/templates

EXPOSE 200

# run the golang binary (idk if this will work, never used go)
CMD ["./bin"]


