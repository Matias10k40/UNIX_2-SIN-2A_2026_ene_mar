
# ============================================================================
#  Dockerfile — build recipe for the course container
# ============================================================================
#  A Dockerfile is a plain-text file with step-by-step instructions that
#  Docker reads top-to-bottom to build an "image". An image is a frozen
#  snapshot of a Linux system ready to use. Every time you open the
#  Codespace, Docker creates a fresh "container" from that snapshot.
#
#  Think of it like this: the image is the BLUEPRINT, the container is the
#  HOUSE built from it. You can build many identical houses from one blueprint,
#  and destroying a house leaves the blueprint untouched.
#
#  Each instruction (FROM, ENV, RUN...) creates a new read-only "layer".
#  Docker caches these layers: if the first lines haven't changed, it skips
#  rebuilding them and the next build is almost instant.
#  (BHB Ch.3 - Installing Docker and Docker Compose)
# ============================================================================


# ----------------------------------------------------------------------------
# (a) FROM: the base image we build on top of
# ----------------------------------------------------------------------------
# Instead of starting from scratch, we start from the official Kali Linux
# image in its "rolling" release (continuously updated, always current).
# Everything we install below gets stacked ON TOP of this base.
#
# A base image is a pre-built Linux filesystem that becomes the starting
# point for our own custom image. Kali is chosen because it comes
# pre-configured for security and networking work — the focus of this course.
# (BHB Ch.3 - Installing Kali)
FROM kalilinux/kali-rolling:latest

# ----------------------------------------------------------------------------
# (b) Image / layer / cache idea — why instruction ORDER matters
# ----------------------------------------------------------------------------
# Docker builds images layer by layer, from top to bottom.
# Each instruction creates one layer; layers are cached individually.
# If you change a line, Docker rebuilds that layer AND every layer below it.
# That is why stable instructions (FROM, ENV) go first, and frequently
# changing ones go last — it keeps builds fast by maximizing cache reuse.
# (BHB Ch.3 - Deploying Docker Containers)

# ----------------------------------------------------------------------------
# (c) ENV: permanent environment variables inside the container
# ----------------------------------------------------------------------------
# Environment variables are global settings that any program in the system
# can read. By convention they are written in UPPERCASE.
# In bash, you access them with ${VARIABLE_NAME}. (BHB Ch.1 - Checking Environment Variables)
#
#   DEBIAN_FRONTEND=noninteractive
#     Tells the package manager (apt) "do not ask me interactive questions,
#     assume default answers". Without this, some packages would pause the
#     build waiting for a keypress — and since nobody is watching, it would
#     hang forever.
#
#   LANG / LC_ALL=es_ES.UTF-8
#     Set the language and character encoding. UTF-8 allows accented letters,
#     ñ, special symbols, etc. to display correctly in the terminal.
#
#   TERM=xterm-256color
#     Tells programs that the terminal supports 256 colors, so tools like
#     vim, nvim, and htop render with their full color schemes.
#
# The trailing backslash "\" means "this line continues below" — it is
# purely for readability, not a functional operator. (BHB Ch.1 - Bash Basics)
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=es_ES.UTF-8 \
    LC_ALL=es_ES.UTF-8 \
    TERM=xterm-256color


# ----------------------------------------------------------------------------
# (d) RUN debconf-set-selections — pre-answering Wireshark's install prompt
# ----------------------------------------------------------------------------
# Wireshark/tshark asks an interactive question during installation:
# "Should non-superusers be able to capture packets?"
# Since we always run as root in this container, the answer is "false".
# We pre-feed that answer using debconf-set-selections BEFORE apt runs,
# so the build never pauses waiting for input.
#
# The pipe "|" redirects the output of echo as input to debconf-set-selections.
# This is a core bash pattern: chaining tools together via stdout/stdin.
# (BHB Ch.1 - Redirection Operators)
RUN echo "wireshark-common wireshark-common/install-setuid boolean false" \
    | debconf-set-selections


# ----------------------------------------------------------------------------
# (e) RUN apt-get update && apt-get install — installing all course software
# ----------------------------------------------------------------------------
# This single RUN installs everything the course needs.
#
# WHY ONE SINGLE RUN instead of many small ones?
# Each RUN creates a new layer in the image. More layers = larger image.
# By chaining everything with && and \, we keep it all in one layer,
# which makes the final image smaller and faster to download.
# (BHB Ch.3 - Deploying Docker Containers)
#
# Key flags:
#   apt-get update              → refreshes the list of available packages
#                                 from Kali's repositories; always run before install
#   apt-get install -y          → -y auto-answers "yes" to all prompts,
#                                 equivalent to DEBIAN_FRONTEND for apt itself
#   --no-install-recommends     → installs ONLY required dependencies, not
#                                 suggested extras; saves hundreds of MB
#
# The "&&" operator chains commands: the next one runs ONLY IF the previous
# one succeeded (exit code 0). If apt-get update fails, install never runs.
# (BHB Ch.1 - Control Operators)
#
# The trailing "\" at the end of each package line is a line continuation —
# it lets us write one package per line for readability while keeping it
# as a single shell command. (BHB Ch.1 - Bash Basics)
#
# Notable tools installed and what they are for:
#   gawk        → GNU awk, a powerful text-processing language used to filter
#                 and transform structured output (BHB Ch.2 - Filtering with awk)
#   sed         → stream editor, edits text line by line using patterns
#                 (BHB Ch.2 - Editing Streams with sed)
#   grep        → filters lines that match a pattern; one of the most used
#                 tools in bash scripting (BHB Ch.2 - Filtering with grep)
#   shellcheck  → static analysis linter for bash scripts; catches errors
#                 and bad practices before you run the script
#   nmap        → the most widely used network port scanner; essential for
#                 reconnaissance in pentesting (BHB Ch.3 - The Machines)
#   tcpdump     → captures raw network packets from the command line
#   tshark      → terminal version of Wireshark; deep packet inspection
#   tor         → routes traffic through the Tor anonymity network
#   proxychains4→ forces any command to route through a chain of proxies
#   jq          → parses and queries JSON directly from the command line
#   man-db      → installs the "man" command to read manual pages;
#                 Kali's base image strips docs to save space, we restore them
RUN apt-get update && apt-get install -y --no-install-recommends \
    \
    # === Text editors and shells ===
    neovim \
    vim \
    zsh \
    bash-completion \
    \
    # === Classic UNIX text-processing tools (BHB Ch.2 - Text Processing) ===
    perl \
    make \
    gawk \
    sed \
    grep \
    \
    # === Core UNIX utilities ===
    # coreutils: cat, ls, head, tail, sort, cut, tr, etc.
    # findutils: find and xargs for searching the filesystem
    # procps:    ps, top, kill — process management (BHB Ch.1 - Running Linux Commands)
    # less:      pager for reading long files one screen at a time
    # tree:      displays directory structure as a visual tree
    # jq:        queries JSON from the command line
    coreutils \
    findutils \
    procps \
    less \
    tree \
    jq \
    \
    # === Manual pages ===
    # Kali's base image removes documentation to save space.
    # We reinstall it because "man bash" and "man grep" are required reading.
    # (BHB Ch.1 - Running Linux Commands)
    man-db \
    manpages \
    manpages-posix \
    \
    # === Network and download utilities ===
    curl \
    wget \
    git \
    git-lfs \
    ca-certificates \
    locales \
    \
    # === Bash script linter ===
    shellcheck \
    \
    # === Network reconnaissance and scanning ===
    # nmap:    port scanner, OS detection, service version detection
    # masscan: extremely fast scanner for large IP ranges
    nmap \
    masscan \
    \
    # === Packet capture and analysis ===
    # tcpdump: classic command-line packet sniffer
    # tshark:  terminal-based Wireshark for deep packet inspection
    tcpdump \
    tshark \
    \
    # === Networking utilities ===
    netcat-traditional \
    socat \
    dnsutils \
    whois \
    traceroute \
    mtr-tiny \
    iproute2 \
    net-tools \
    iputils-ping \
    \
    # === Anonymity tools ===
    # tor:         routes traffic through the Tor onion network
    # torsocks:    wrapper that forces any command through Tor
    # proxychains4:chains multiple proxies together
    # obfs4proxy:  obfuscates Tor traffic to bypass blocks
    tor \
    torsocks \
    proxychains4 \
    obfs4proxy \
    \
    # === Human-friendly HTTP client ===
    httpie \
 \

 # ----------------------------------------------------------------------------
 # (f) sed + locale-gen — enabling the Spanish locale
 # ----------------------------------------------------------------------------
 # /etc/locale.gen lists all available locales, but most are commented out
 # with a "#". We use sed -i to edit the file in-place:
 #   's/# es_ES.UTF-8/es_ES.UTF-8/' finds the commented-out Spanish locale
 #   and removes the "# " to activate it.
 # Then locale-gen compiles the locale binary files the system needs.
 # sed is a stream editor — it processes text line by line without opening
 # an interactive editor. (BHB Ch.2 - Editing Streams with sed)
 && sed -i 's/# es_ES.UTF-8/es_ES.UTF-8/' /etc/locale.gen \
 && locale-gen \
 \
# ----------------------------------------------------------------------------
 # (g) apt-get clean && rm -rf — cleaning up to shrink the image
 # ----------------------------------------------------------------------------
 # After installation, apt leaves downloaded package files (.deb) in a cache
 # directory we no longer need. We delete them HERE, in the SAME RUN,
 # so they are removed from this layer before it is saved.
 # If we deleted them in a separate RUN, they would still exist in the
 # previous layer, wasting space in the final image.
 # rm -rf /var/lib/apt/lists/* removes the package index fetched by apt-get update.,
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*


# ----------------------------------------------------------------------------
# (h) SHELL — switch Docker's default shell from sh to bash
# ----------------------------------------------------------------------------
# By default, Docker runs RUN instructions using /bin/sh, a minimal POSIX
# shell that lacks many bash-specific features (arrays, [[ ]], process
# substitution, etc.).
# Setting SHELL to /bin/bash means all subsequent RUN instructions will use
# bash, giving us access to the full bash syntax covered in BHB Ch.1 and Ch.2.
# The "-c" flag tells bash to read commands from the string argument.
# (BHB Ch.1 - Accessing the Bash Shell)
SHELL ["/bin/bash", "-c"]


# ----------------------------------------------------------------------------
# (i) WORKDIR — set the default working directory
# ----------------------------------------------------------------------------
# WORKDIR sets the directory that all subsequent instructions and the
# container's terminal sessions will start in.
# Codespaces always mounts the repository at /workspaces/<repo-name>,
# so pointing WORKDIR here means the terminal opens near our course files.
# This is equivalent to running "cd /workspaces" every time the container starts.
# (BHB Ch.1 - Running Linux Commands)
WORKDIR /workspaces

# ----------------------------------------------------------------------------
# (j) RUN git config --system && git lfs install --system
# ----------------------------------------------------------------------------
# These lines configure Git globally for the root user inside the container.
#
#   safe.directory '*'
#     Codespaces mounts /workspaces with a different owner than the container's
#     root user. Without this, Git refuses to work in those directories.
#     The '*' wildcard trusts ALL mounted directories. (BHB Ch.1 - Variables)
#
#   init.defaultBranch main
#     Sets "main" as the default branch name for new repos (git init),
#     avoiding the deprecation warning about "master".
#
#   pull.rebase false
#     When running "git pull", merge instead of rebase. More intuitive
#     for beginners and avoids accidental history rewrites.
#
#   git lfs install --system
#     Registers Git LFS (Large File Storage) hooks system-wide so that
#     repos using LFS (for large binary files) work automatically.
RUN git config --system --add safe.directory '*' \
 && git config --system init.defaultBranch main \
 && git config --system pull.rebase false \
 && git lfs install --system

 # ----------------------------------------------------------------------------
# (k) RUN chsh -s /usr/bin/zsh root — change the default shell to zsh
# ----------------------------------------------------------------------------
# chsh (change shell) updates /etc/passwd to set zsh as the login shell
# for the root user. This means interactive sessions will launch zsh instead
# of bash by default.
# This is equivalent to what BHB Ch.1 describes for switching shells:
# "chsh -s /bin/bash" — same command, different target shell.
# (BHB Ch.1 - Accessing the Bash Shell)
RUN chsh -s /usr/bin/zsh root


# ----------------------------------------------------------------------------
# (l) Here-document (cat >> ~/.zshrc <<'EOF' ... EOF) — custom prompt
# ----------------------------------------------------------------------------
# A here-document (heredoc) is a redirection that feeds multiple lines of
# text as stdin to a command, without needing a separate file.
# The syntax "<<'EOF'" means: read everything until the line containing
# just EOF as input. The single quotes around EOF prevent variable expansion
# inside the block — the text is treated literally. (BHB Ch.1 - Redirection Operators)
#
# "cat >>" appends the block to /root/.zshrc, the zsh startup file that
# runs every time a new interactive shell session opens.
#
# What the PROMPT block does:
#   __set_prompt() is a function called before every prompt is displayed.
#   It checks the exit code ($?) of the last command:
#     - exit code 0  → shows a green ✓ (success)
#     - any other    → shows a red ✗ followed by the error code (failure)
#   PS1 is the environment variable that defines the prompt appearance.
#   \[\e[36m\] sets the color to cyan; \[\e[0m\] resets it.
#   \W prints only the current directory name (not the full path).
#   PROMPT_COMMAND tells zsh to run __set_prompt before every prompt.
# (BHB Ch.1 - Checking Environment Variables, BHB Ch.2 - Bash Customizations)
RUN cat >> /root/.zshrc <<'EOF'
 
 
# ----------------------------------------------------------------------------
# (l) Here-document (cat >> ~/.zshrc <<'EOF' ... EOF) — custom prompt
# ----------------------------------------------------------------------------
# A here-document (heredoc) is a redirection that feeds multiple lines of
# text as stdin to a command, without needing a separate file.
# The syntax "<<'EOF'" means: read everything until the line containing
# just EOF as input. The single quotes around EOF prevent variable expansion
# inside the block — the text is treated literally. (BHB Ch.1 - Redirection Operators)
#
# "cat >>" appends the block to /root/.zshrc, the zsh startup file that
# runs every time a new interactive shell session opens.
#
# What the PROMPT block does:
#   __set_prompt() is a function called before every prompt is displayed.
#   It checks the exit code ($?) of the last command:
#     - exit code 0  → shows a green ✓ (success)
#     - any other    → shows a red ✗ followed by the error code (failure)
#   PS1 is the environment variable that defines the prompt appearance.
#   \[\e[36m\] sets the color to cyan; \[\e[0m\] resets it.
#   \W prints only the current directory name (not the full path).
#   PROMPT_COMMAND tells zsh to run __set_prompt before every prompt.
# (BHB Ch.1 - Checking Environment Variables, BHB Ch.2 - Bash Customizations)
RUN cat >> /root/.zshrc <<'EOF'

# ----------------------------------------------------------------------------
# (m) CMD — the default command when the container starts
# ----------------------------------------------------------------------------
# CMD defines what runs when someone starts the container without specifying
# a command explicitly (e.g., "docker run <image>").
# Unlike RUN (which executes during BUILD time to modify the image),
# CMD executes at RUNTIME when the container is launched.
# Only one CMD is allowed per Dockerfile — if you write multiple, only the
# last one takes effect.
# Codespaces overrides this with its own VS Code integrated terminal,
# but defining it makes the image usable with plain Docker too.
# (BHB Ch.1 - Accessing the Bash Shell
CMD ["/bin/zsh"]

# ===== Course prompt =====
__set_prompt() {
    local ec=$?
    local mark
    if [ $ec -eq 0 ]; then
        mark=$'\e[32m✓\e[0m'
    else
        mark=$"\e[31m✗ $ec\e[0m"
    fi
    PROMPT=$'%{\e[35m%}[Matias Quinteros]%{\e[0m%} %{\e[33m%}%1~%{\e[0m%} '"$mark"$' %# '
}
precmd() { __set_prompt; }
EOF




