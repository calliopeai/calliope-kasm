ARG BASE_TAG="1.17.0"
ARG BASE_IMAGE="core-debian-bookworm"
FROM kasmweb/${BASE_IMAGE}:${BASE_TAG}

USER root

ENV HOME=/home/kasm-default-profile
ENV STARTUPDIR=/dockerstartup
ENV INST_SCRIPTS=$STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# Version can be overridden at build time
ARG CALLIOPE_VERSION="1.2.9"
ENV CALLIOPE_VERSION=${CALLIOPE_VERSION}

# Install dependencies for Electron apps
RUN apt-get update && apt-get install -y --no-install-recommends \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxkbcommon0 \
    libxrandr2 \
    xdg-utils \
    wget \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy installation script
COPY src/install_calliope.sh $INST_SCRIPTS/calliope/
RUN chmod +x $INST_SCRIPTS/calliope/install_calliope.sh \
    && bash $INST_SCRIPTS/calliope/install_calliope.sh \
    && rm -rf $INST_SCRIPTS/calliope/

# Copy desktop shortcut
COPY src/calliope-ide.desktop $HOME/Desktop/
RUN chmod +x $HOME/Desktop/calliope-ide.desktop \
    && chown 1000:1000 $HOME/Desktop/calliope-ide.desktop

# Copy custom startup script
COPY src/custom_startup.sh $STARTUPDIR/custom_startup.sh
RUN chmod 755 $STARTUPDIR/custom_startup.sh

# Optional: Set custom background
# COPY src/bg_calliope.png /usr/share/backgrounds/bg_default.png

# Optional: Single-app mode - remove panel for cleaner look
# RUN apt-get remove -y xfce4-panel

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME=/home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
