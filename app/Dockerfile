# base node image
FROM node:lts-alpine AS base

# update the openssl package to apply a security patch @see CVE-2023-6129⁠
RUN apk -U add --update-cache openssl

# set for base and all layer that inherit from it
ENV NODE_ENV=production

# Create user and set ownership and permissions as required
RUN <<EOT
addgroup student &&
adduser -D -H -g "student" -G student student &&
mkdir /cst8918-grp4 &&
chown -R student:student /cst8918-grp4
EOT

# Install all node_modules, including dev dependencies
FROM base AS deps

WORKDIR /cst8918-grp4

ADD package.json ./
RUN npm install --include=dev

# Setup production node_modules
FROM base AS production-deps

WORKDIR /cst8918-grp4

COPY --from=deps /cst8918-grp4/node_modules /cst8918-grp4/node_modules
ADD package.json ./
RUN npm prune --omit=dev

# Build the app
FROM base AS build

WORKDIR /cst8918-grp4

COPY --from=deps /cst8918-grp4/node_modules /cst8918-grp4/node_modules

ADD . .
RUN npm run build

# Finally, build the production image with minimal footprint
FROM base AS production

WORKDIR /cst8918-grp4

COPY --from=production-deps /cst8918-grp4/node_modules /cst8918-grp4/node_modules

COPY --from=build /cst8918-grp4/build /cst8918-grp4/build
COPY --from=build /cst8918-grp4/public /cst8918-grp4/public
COPY --from=build /cst8918-grp4/package.json /cst8918-grp4/package.json

# make sure the app files are owned by the non-root user, then switch to it
RUN chown -R student:student /cst8918-grp4
USER student

CMD [ "/bin/sh", "-c", "./node_modules/.bin/remix-serve ./build/index.js" ]