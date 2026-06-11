
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
# RUN: ejecutar comandos durante la construcción de la imagen
# ----------------------------------------------------------------------------
# Aquí instalamos TODO el software del curso en un solo RUN.
#
#   apt-get update          -> actualiza la lista de paquetes disponibles
#   apt-get install         -> descarga e instala los paquetes listados
#     -y                    -> responde "sí" automáticamente
#     --no-install-recommends -> instala SOLO lo esencial (no los extras
#                                sugeridos). Ahorra cientos de MB.
#
# ¿Por qué un solo RUN gigante y no 10 RUN pequeños?
# Porque CADA RUN crea una capa nueva en la imagen. Menos capas = imagen
# más pequeña, más rápida de construir y de descargar.
#
# El "&&" encadena comandos: ejecuta el siguiente SOLO SI el anterior
# terminó bien. Si algo falla, el build se detiene con error (que es lo
# que queremos: mejor un error claro que una imagen rota).
RUN apt-get update && apt-get install -y --no-install-recommends \
    \
    # === Editores de texto y shells (intérpretes de comandos) ===
    neovim \
    vim \
    zsh \
    bash-completion \
    \
    # === Herramientas de 4ta generación ===
    # Estas son las protagonistas de las Unidades 2, 3 y 4:
    perl \
    make \
    gawk \
    sed \
    grep \
    \
    # === Utilidades básicas de UNIX ===
    # coreutils trae cat, ls, head, tail, sort, cut, tr, etc.
    # findutils trae find y xargs.
    # procps trae ps, top, kill (gestión de procesos).
    # less = paginador para leer archivos largos.
    # tree = muestra directorios como árbol.
    # jq = procesa JSON desde la línea de comandos.
    coreutils \
    findutils \
    procps \
    less \
    tree \
    jq \
    \
    # === Páginas de manual (comando `man`) ===
    # La imagen base de Kali viene sin documentación para
    # ahorrar espacio. La reinstalamos porque en el curso "man bash" o
    # "man grep" es material de consulta obligada.
    man-db \
    manpages \
    manpages-posix \
    \
    # === Red básica y utilidades de descarga ===
    curl \
    wget \
    git \
    git-lfs \
    ca-certificates \
    locales \
    \
    # === Linter (revisor automático de errores) para scripts Bash ===
    shellcheck \
    \
    # === Reconocimiento y escaneo de red ===
    # nmap = el escáner de puertos más famoso.
    # masscan = escaneo masivo de rangos grandes de IPs.
    nmap \
    masscan \
    \
    # === Captura y análisis de paquetes de red ===
    # tcpdump = capturador clásico por terminal.
    # tshark = versión de terminal de Wireshark.
    tcpdump \
    tshark \
    \
    # === Utilidades de red variadas ===
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
    # === Anonimato: Tor y similares ===
    # tor = cliente de la red Tor.
    # torsocks = "envoltorio" que hace pasar cualquier comando por Tor.
    # proxychains4 = encadena múltiples proxies.
    # obfs4proxy = ofusca el tráfico de Tor para evadir bloqueos.
    tor \
    torsocks \
    proxychains4 \
    obfs4proxy \
    \
    # === Cliente HTTP más legible que curl para aprender ===
    httpie \
    \
 # --- Después de instalar, activamos el idioma español ---
 # sed busca "# es_ES.UTF-8" en /etc/locale.gen y le quita el "#" para
 # activar esa línea. Luego locale-gen compila los archivos de idioma.
 && sed -i 's/# es_ES.UTF-8/es_ES.UTF-8/' /etc/locale.gen \
 && locale-gen \
 \
 # --- Limpieza final: reducir el tamaño de la imagen ---
 # apt deja archivos de caché que ya no necesitamos después de instalar.
 # Borrarlos aquí (en el mismo RUN) hace la capa final más pequeña.
 # Si los borráramos en otro RUN, seguirían ocupando en la capa anterior.
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*


# ----------------------------------------------------------------------------
# SHELL: qué intérprete usar en los siguientes RUN
# ----------------------------------------------------------------------------
# Por defecto Docker usa /bin/sh (un shell más limitado y antiguo). Lo
# cambiamos a bash por si agregamos más instrucciones con sintaxis
# moderna (arrays, [[ ]], etc.).
SHELL ["/bin/bash", "-c"]


# ----------------------------------------------------------------------------
# WORKDIR: directorio de trabajo al entrar al contenedor
# ----------------------------------------------------------------------------
# Codespaces siempre monta el código del repositorio en
# /workspaces/<nombre-del-repo>. Establecer /workspaces aquí hace que las
# terminales se abran cerca de nuestros archivos del curso.
WORKDIR /workspaces

# Configuración de Git para el contenedor:
# - safe.directory *: confía en cualquier repo montado (necesario porque
#   /workspaces/... tiene un UID distinto al de root dentro del container).
# - init.defaultBranch main: evita warnings de "master vs main" en git init.
# - pull.rebase false: merge por defecto al hacer pull (más intuitivo)
# - git lfs install --system: registra los hooks de LFS globalmente para
#   que, si un repo los necesita, funcionen sin sorpresas.
RUN git config --system --add safe.directory '*' \
 && git config --system init.defaultBranch main \
 && git config --system pull.rebase false \
 && git lfs install --system

# ----------------------------------------------------------------------------
# CMD: comando que se ejecuta por defecto al arrancar el contenedor
# ----------------------------------------------------------------------------
# Lanza una shell bash interactiva. Codespaces la sobrescribe con su
# propia terminal integrada de VS Code, pero es buena práctica dejarla
# definida para que la imagen sea usable también con Docker puro.
# Prompt del curso para bash
RUN cat >> /root/.bashrc <<'EOF'

# ===== Prompt del curso =====
__set_prompt() {
    local ec=$?
    local mark
    if [ $ec -eq 0 ]; then
        mark='\[\e[32m\]✓\[\e[0m\]'
    else
        mark="\[\e[31m\]✗ $ec\[\e[0m\]"
    fi
    PS1="\[\e[36m\][TU_NOMBRE]\[\e[0m\] \[\e[33m\]\W\[\e[0m\] $mark \$ "
}
PROMPT_COMMAND=__set_prompt
EOF
CMD ["/bin/bash"]




