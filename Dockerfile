FROM golang:1.14-alpine3.12 AS build

RUN apk add --no-cache make git

WORKDIR /opt/keycloak
COPY . .

RUN go get golang.org/x/oauth2
RUN go build -o backend .

FROM alpine:3.12

RUN addgroup -S keycloak && adduser -S keycloak -G keycloak

COPY --from=build /opt/keycloak/backend /bin

USER keycloak
CMD /bin/backend

EXPOSE 8091


