FROM postgres:17

# Install dependencies
RUN apt-get update && apt-get install -y \
    gnupg \
    wget \
    curl \
    lsb-release \
    ca-certificates

# Add TimescaleDB GPG key and repository
RUN curl -sL https://packagecloud.io/timescale/timescaledb/gpgkey | gpg --dearmor > /etc/apt/trusted.gpg.d/timescale.gpg && \
    echo "deb https://packagecloud.io/timescale/timescaledb/debian/ bookworm main" > /etc/apt/sources.list.d/timescaledb.list

# Install TimescaleDB for PostgreSQL 17
RUN apt-get update && \
    apt-get install -y timescaledb-2-postgresql-17 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


COPY init-timescaledb.sql /docker-entrypoint-initdb.d/
# Add timescaledb to shared_preload_libraries in the default config
RUN echo "shared_preload_libraries = 'timescaledb'" >> /usr/share/postgresql/postgresql.conf.sample
