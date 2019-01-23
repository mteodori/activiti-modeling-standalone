ARG VERSION=7.0.0.Beta5

FROM activiti/activiti-modeling-app:$VERSION as FRONTEND
FROM activiti/activiti-cloud-modeling:$VERSION

COPY --from=FRONTEND /usr/share/nginx/html /usr/share/nginx/html

RUN apk update && apk add nginx
RUN mkdir /run/nginx
RUN cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
COPY nginx.conf /etc/nginx/nginx.conf

ENV SECURITY_BASIC_ENABLED=false
ENV MANAGEMENT_SECURITY_ENABLED=false
ENV ACT_KEYCLOAK_PATTERNS=/disabled

RUN sed \
  -e 's@"backend": ".*"@"backend": "/"@g' \
  -e 's@"pathPrefix": ".*"@"pathPrefix": ""@g' \
  -i /usr/share/nginx/html/app.config.json

ENTRYPOINT nginx && exec java $JAVA_OPTS -jar app.jar

