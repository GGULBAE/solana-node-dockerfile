# Set Docker Build Environment Variables
ARG RUST_VERSION=1.52.0

# [1] Start From Rust
FROM rust:${RUST_VERSION}

# [2] Initialize
RUN apt-get update \
 && apt-get install -y curl libudev-dev nodejs npm

# [3] Install Solana & Set Path
RUN sh -c "$(curl -sSfL https://release.solana.com/v1.6.7/install)"
ENV PATH="/root/.local/share/solana/install/active_release/bin:$PATH"

# [4] Install Solana Program Library (CLI Version) and update Node modules
RUN cargo install spl-token-cli \
 && npm install -g npm \
 && npm cache clean -f \
 && npm install -g n \
 && n stable

# [5] Check Solana Config & Connect To Solana Dev Net
# RUN solana config get \
#  && solana config set --url https://devnet.solana.com