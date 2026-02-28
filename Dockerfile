# -- BUILD STAGE --
# base image
FROM golang:1.23 AS builder

# copy files into build stage
COPY go.mod .
COPY main.go .
COPY templates .

# compile the app into a static binary
RUN CGO_ENABLED=0 go build -o bin .

# -- FINAL STAGE --
FROM scratch

# set working directory
WORKDIR /app
COPY --from=builder bin .
COPY --from=builder templates .

# run the golang binary (idk if this will work, never used go)
CMD ["./bin"]


