# Run in container
apt update
apt install -y curl \
	git \
	ca-certificates \
	build-essential

VERSION=1.26.3
TARBALL=go${VERSION}.linux-amd64.tar.gz
curl -LO https://go.dev/dl/${TARBALL}
tar -C /usr/local -xzf ${TARBALL}

echo 'export PATH=$PATH:/usr/local/go/bin' >>~/.bashrc
echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.bashrc

export PATH=$PATH:/usr/local/go/bin

HUGODEB=hugo_extended_0.161.1_linux-amd64.deb
curl -LO https://github.com/gohugoio/hugo/releases/download/v0.161.1/${HUGODEB}
apt install -y ./${HUGODEB}

hugo version
go version
git --version
