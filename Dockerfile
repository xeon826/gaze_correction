FROM sulfurheron/nvidia-cuda:9.0-cudnn7-devel-ubuntu16.04-2018-06-08

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    curl \
    git \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncurses5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    llvm \
    make \
    tk-dev \
    wget \
    xz-utils \
    zlib1g-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install pyenv and Python 3.7
RUN git clone https://github.com/pyenv/pyenv.git /root/.pyenv && \
    export PYENV_ROOT="/root/.pyenv" && \
    export PATH="$PYENV_ROOT/bin:$PATH" && \
    echo 'export PYENV_ROOT="/root/.pyenv"' >> /root/.bashrc && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> /root/.bashrc && \
    echo 'eval "$(pyenv init --path)"' >> /root/.bashrc && \
    eval "$(pyenv init --path)" && \
    pyenv install 3.7.3 && \
    pyenv global 3.7.3 && \
    pyenv rehash && \
    curl https://bootstrap.pypa.io/pip/3.7/get-pip.py -o get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

# Download and add the new NVIDIA GPG key
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/3bf863cc.pub

# Copy the application code
COPY . /app

# Install Python dependencies
# RUN pip install -r requirements.txt

CMD ["bash"]

