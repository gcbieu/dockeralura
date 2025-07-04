# 1. Use uma imagem oficial do Python como imagem base.
# A imagem 'slim' é usada para manter o tamanho final reduzido.
# A versão 3.11 é estável e compatível com o requisito do seu README (3.10+).
FROM python:3.11-slim-bullseye

# 2. Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 3. Copia o arquivo de dependências para o diretório de trabalho.
# É uma boa prática copiar e instalar as dependências primeiro para aproveitar o cache do Docker.
COPY requirements.txt .

# 4. Instala as dependências listadas no requirements.txt.
# --no-cache-dir: Desabilita o cache do pip para reduzir o tamanho da imagem.
# --upgrade pip: Garante que estamos usando a versão mais recente do pip.
RUN pip install --no-cache-dir --upgrade pip -r requirements.txt

# 5. Copia o restante do código da aplicação.
COPY . .

# 6. Expõe a porta em que a aplicação será executada.
EXPOSE 8000

# 7. Define o comando para executar a aplicação.
# Usa o uvicorn para rodar a aplicação FastAPI.
# --host 0.0.0.0 torna a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
