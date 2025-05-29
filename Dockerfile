# @keyiflerolsun tarafından optimize edilmiştir

# Temel İmaj (hafif ve yeterli)
FROM python:3.11.8-slim-bookworm

# Ortam değişkenleri
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        git \
        build-essential \
        gcc \
        clang \
        make \
        cmake \
        nasm \
        ghc \
        libpq-dev \
        libbsd-dev \
        libxext-dev \
        libncurses-dev \
        valgrind && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Çalışma dizini
WORKDIR /

# Francinette klonla
RUN git clone --recursive https://github.com/xicodomingues/francinette.git

# Gereksinimleri yükle
WORKDIR /francinette
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt norminette

# Script çalıştırılabilir olsun
RUN chmod +x tester.sh

# Başlangıç komutu
CMD ["/francinette/tester.sh"]
