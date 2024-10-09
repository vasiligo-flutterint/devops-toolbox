# Use the latest Ubuntu image as the base
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Install base packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    unzip \
    less \
    net-tools \
    zsh \
    locales \
    && locale-gen en_US.UTF-8

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/

# Install zoxide
RUN apt-get install -y zoxide

# Install Oh My Zsh
RUN RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install starship prompt
RUN curl -fsSL https://starship.rs/install.sh | sh -s -- --yes --bin-dir /usr/local/bin

# Configure zsh
RUN echo 'eval "$(zoxide init zsh)"' >> /root/.zshrc \
    && echo 'eval "$(starship init zsh)"' >> /root/.zshrc \
    && sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' /root/.zshrc \
    && sed -i 's/plugins=(git)/plugins=(git docker kubectl aws)/' /root/.zshrc

# Set zsh as the default shell
CMD ["zsh"]
