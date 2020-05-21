FROM node:12-stretch as install-stage
WORKDIR /app
COPY Makefile .
RUN make print_env
RUN make node_modules
COPY . .

FROM install-stage as test-stage
WORKDIR /app
COPY --from=install-stage /app .
RUN make print_env
RUN make test

FROM install-stage as build-stage
WORKDIR /app
COPY --from=install-stage /app .
RUN make print_env
RUN make build

FROM nginx:mainline-alpine as production-stage
COPY --from=build-stage /app/build/app /usr/share/nginx/html
COPY .config/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-t"]
CMD ["nginx", "-g", "daemon off;"]
