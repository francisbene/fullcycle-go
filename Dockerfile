# Use a imagem oficial mínima do Golang como base
FROM golang:alpine as builder

# Defina o diretório de trabalho dentro do contêiner
WORKDIR /go/src/app

# Copie o código fonte para o diretório de trabalho
COPY . .

# Inicialize um novo módulo Go
RUN go mod init app

# Compile o programa
RUN go build -o main .

# Use uma imagem mínima como base
FROM scratch

# Copie o executável compilado do primeiro estágio
COPY --from=builder /go/src/app/main /

# Comando a ser executado quando o contêiner for iniciado
CMD ["/main"]