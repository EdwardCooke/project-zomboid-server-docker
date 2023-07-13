###########################################################
# Dockerfile that builds a CSGO Gameserver
###########################################################
FROM cm2network/steamcmd:steam

LABEL maintainer="daniel.carrasco@electrosoftcloud.com"

ENV STEAMAPPID 380870
ENV STEAMAPP pz
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated/pz"

USER root
# Install required packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
      dos2unix \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the entry point file
COPY --chown=root:root --chmod=555 scripts/entry.sh /server/scripts/entry.sh
USER steam

# Create required folders to keep their permissions on mount
RUN mkdir -p "${HOMEDIR}/Zomboid"

WORKDIR ${HOMEDIR}
# Expose ports
EXPOSE 16261-16262/udp \
       27015/tcp

ENTRYPOINT ["/server/scripts/entry.sh"]
