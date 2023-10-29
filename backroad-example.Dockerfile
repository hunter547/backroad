# This file is generated by Nx.
#
# Build the docker image with `npx nx docker-build backroad-example`.
# Tip: Modify "docker-build" options in project.json to change docker build args.
#
# Run the container with `docker run -p 3000:3000 -t backroad-example`.
FROM node:20 as builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build-example-app

FROM node:20 as runner
COPY --from=builder /app/dist/apps/backroad-example /app
WORKDIR /app

# RUN addgroup --system backroad-example && \
#     adduser --system --group backroad-example backroad-example

# RUN chown -R backroad-example:backroad-example .

# You can remove this install step if you build with `--bundle` option.
# The bundled output will include external dependencies.
RUN npm ci
EXPOSE 3333
CMD [ "node", "." ]
